import { hasPermission } from "@workspace/auth-shared";
import {
  GetCourseParams,
  GetCourseResponse,
  GetLessonParams,
  GetLessonResponse,
  ListCoursesQueryParams,
  ListCoursesResponse,
} from "@workspace/api-zod";
import {
  coursesTable,
  courseEntitlementsTable,
  db,
  entitlementsTable,
  lessonsTable,
  mediaAssetsTable,
  modulesTable,
} from "@workspace/db";
import { and, asc, count, eq, gt, inArray, isNull, lte, or } from "drizzle-orm";
import { Router, type IRouter, type Request } from "express";
import { signCourseAssetRead } from "../lib/courseStorage";
import { sendError } from "../lib/errors";
import { publicCache } from "../lib/http";
import { requireAuth } from "../middlewares/rbac";

const router: IRouter = Router();
const playbackTtlSeconds = 2 * 60 * 60;

type CourseRow = typeof coursesTable.$inferSelect;

function courseSummary(course: CourseRow, lessonCount: number) {
  return {
    id: course.id,
    examId: course.examId,
    slug: course.slug,
    title: course.title,
    summary: course.summary,
    coverUrl: null,
    isFree: course.isFree,
    lessonCount,
    position: course.position,
  };
}

async function publishedCourse(slug: string) {
  const [course] = await db
    .select()
    .from(coursesTable)
    .where(and(eq(coursesTable.slug, slug), eq(coursesTable.status, "published"), isNull(coursesTable.deletedAt)))
    .limit(1);
  return course;
}

async function publishedLessonCounts(courseIds: string[]) {
  if (courseIds.length === 0) return new Map<string, number>();
  const rows = await db
    .select({ courseId: modulesTable.courseId, value: count() })
    .from(modulesTable)
    .innerJoin(lessonsTable, eq(lessonsTable.moduleId, modulesTable.id))
    .where(
      and(
        inArray(modulesTable.courseId, courseIds),
        isNull(modulesTable.deletedAt),
        eq(lessonsTable.status, "published"),
        isNull(lessonsTable.deletedAt),
      ),
    )
    .groupBy(modulesTable.courseId);
  return new Map(rows.map((row) => [row.courseId, Number(row.value)]));
}

async function loadOutline(courseId: string) {
  const modules = await db
    .select()
    .from(modulesTable)
    .where(and(eq(modulesTable.courseId, courseId), isNull(modulesTable.deletedAt)))
    .orderBy(asc(modulesTable.position), asc(modulesTable.createdAt));

  if (modules.length === 0) return [];

  const lessons = await db
    .select()
    .from(lessonsTable)
    .where(
      and(
        inArray(lessonsTable.moduleId, modules.map((module) => module.id)),
        eq(lessonsTable.status, "published"),
        isNull(lessonsTable.deletedAt),
      ),
    )
    .orderBy(asc(lessonsTable.position), asc(lessonsTable.createdAt));

  return modules.map((module) => ({
    id: module.id,
    title: module.title,
    topicId: module.topicId,
    position: module.position,
    lessons: lessons
      .filter((lesson) => lesson.moduleId === module.id)
      .map((lesson) => ({
        id: lesson.id,
        slug: lesson.slug,
        title: lesson.title,
        type: lesson.type,
        durationSeconds: lesson.durationSeconds,
        isFreePreview: lesson.isFreePreview,
        position: lesson.position,
      })),
  }));
}

/** Free courses, admins, or current entitlements for the exam linked to the course. */
async function canAccessCourse(req: Request, course: CourseRow) {
  if (req.auth && hasPermission(req.auth.user.role, "admin:access")) return true;
  if (course.isFree) return true;
  if (!req.auth) return false;

  const now = new Date();
  const [courseGrant] = await db
    .select({ id: courseEntitlementsTable.id })
    .from(courseEntitlementsTable)
    .where(
      and(
        eq(courseEntitlementsTable.userId, req.auth.user.id),
        eq(courseEntitlementsTable.courseId, course.id),
        isNull(courseEntitlementsTable.revokedAt),
        lte(courseEntitlementsTable.startsAt, now),
        or(isNull(courseEntitlementsTable.endsAt), gt(courseEntitlementsTable.endsAt, now)),
      ),
    )
    .limit(1);
  if (courseGrant) return true;
  if (!course.examId) return false;

  const [entitlement] = await db
    .select({ id: entitlementsTable.id })
    .from(entitlementsTable)
    .where(
      and(
        eq(entitlementsTable.userId, req.auth.user.id),
        eq(entitlementsTable.examId, course.examId),
        isNull(entitlementsTable.revokedAt),
        lte(entitlementsTable.startsAt, now),
        or(isNull(entitlementsTable.endsAt), gt(entitlementsTable.endsAt, now)),
      ),
    )
    .limit(1);
  return Boolean(entitlement);
}

router.get("/courses", async (req, res): Promise<void> => {
  const query = ListCoursesQueryParams.safeParse(req.query);
  if (!query.success) {
    sendError(res, 400, "invalid_request", "Invalid course list parameters.", query.error.flatten());
    return;
  }

  const conditions = [
    eq(coursesTable.status, "published"),
    isNull(coursesTable.deletedAt),
    ...(query.data.examId ? [eq(coursesTable.examId, query.data.examId)] : []),
  ];

  if (query.data.cursor) {
    const [cursor] = await db
      .select({ id: coursesTable.id, position: coursesTable.position, title: coursesTable.title })
      .from(coursesTable)
      .where(and(...conditions, eq(coursesTable.id, query.data.cursor)))
      .limit(1);
    if (!cursor) {
      sendError(res, 400, "invalid_cursor", "The course list cursor is not valid.");
      return;
    }
    conditions.push(
      or(
        gt(coursesTable.position, cursor.position),
        and(eq(coursesTable.position, cursor.position), gt(coursesTable.title, cursor.title)),
        and(
          eq(coursesTable.position, cursor.position),
          eq(coursesTable.title, cursor.title),
          gt(coursesTable.id, cursor.id),
        ),
      )!,
    );
  }

  const rows = await db
    .select()
    .from(coursesTable)
    .where(and(...conditions))
    .orderBy(asc(coursesTable.position), asc(coursesTable.title), asc(coursesTable.id))
    .limit(query.data.limit + 1);
  const hasNextPage = rows.length > query.data.limit;
  const page = rows.slice(0, query.data.limit);
  const counts = await publishedLessonCounts(page.map((course) => course.id));

  publicCache(res);
  res.json(
    ListCoursesResponse.parse({
      data: page.map((course) => courseSummary(course, counts.get(course.id) ?? 0)),
      nextCursor: hasNextPage ? (page.at(-1)?.id ?? null) : null,
    }),
  );
});

router.get("/courses/:slug", async (req, res): Promise<void> => {
  const params = GetCourseParams.safeParse(req.params);
  if (!params.success) {
    sendError(res, 400, "invalid_request", "Invalid course slug.");
    return;
  }

  const course = await publishedCourse(params.data.slug);
  if (!course) {
    sendError(res, 404, "not_found", "Course not found.");
    return;
  }

  const [modules, counts, hasAccess] = await Promise.all([
    loadOutline(course.id),
    publishedLessonCounts([course.id]),
    canAccessCourse(req, course),
  ]);
  res.setHeader("Cache-Control", "private, no-store");
  res.json(
    GetCourseResponse.parse({
      course: courseSummary(course, counts.get(course.id) ?? 0),
      description: course.description,
      hasAccess,
      modules,
    }),
  );
});

router.get("/courses/:courseSlug/lessons/:lessonId", requireAuth, async (req, res): Promise<void> => {
  const params = GetLessonParams.safeParse(req.params);
  if (!params.success) {
    sendError(res, 400, "invalid_request", "Invalid course or lesson identifier.");
    return;
  }

  const course = await publishedCourse(params.data.courseSlug);
  if (!course) {
    sendError(res, 404, "not_found", "Course not found.");
    return;
  }

  // PostgreSQL cannot cast a non-UUID string to the uuid type, even inside an OR.
  // Only compare against the id (uuid) column when the input actually looks like a UUID.
  const UUID_RE = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
  const lessonLookup = UUID_RE.test(params.data.lessonId)
    ? or(eq(lessonsTable.id, params.data.lessonId), eq(lessonsTable.slug, params.data.lessonId))
    : eq(lessonsTable.slug, params.data.lessonId);

  const [row] = await db
    .select({ lesson: lessonsTable })
    .from(lessonsTable)
    .innerJoin(modulesTable, eq(modulesTable.id, lessonsTable.moduleId))
    .where(
      and(
        lessonLookup,
        eq(modulesTable.courseId, course.id),
        eq(lessonsTable.status, "published"),
        isNull(lessonsTable.deletedAt),
        isNull(modulesTable.deletedAt),
      ),
    )
    .limit(1);
  if (!row) {
    sendError(res, 404, "not_found", "Lesson not found.");
    return;
  }

  const lesson = row.lesson;

  if (!lesson.isFreePreview && !(await canAccessCourse(req, course))) {
    sendError(res, 403, "forbidden", "This lesson is not included in your plan.");
    return;
  }

  let assetUrl: string | null = null;
  let assetFilename: string | null = null;
  let assetMimeType: string | null = null;
  let captions: { lang: string; url: string }[] = [];

  if (lesson.assetId) {
    const [asset] = await db
      .select()
      .from(mediaAssetsTable)
      .where(and(eq(mediaAssetsTable.id, lesson.assetId), isNull(mediaAssetsTable.deletedAt)))
      .limit(1);

    if (asset?.storageKey && asset.processing === "ready") {
      try {
        assetUrl = await signCourseAssetRead(asset.storageKey, playbackTtlSeconds);
        assetFilename = asset.filename;
        assetMimeType = asset.mimeType;
        captions = await Promise.all(
          asset.captions.map(async (caption) => ({
            lang: caption.lang,
            url: await signCourseAssetRead(caption.storageKey, playbackTtlSeconds),
          })),
        );
      } catch (error) {
        req.log.error({ err: error, lessonId: lesson.id }, "Failed to sign lesson media URL");
        sendError(res, 503, "storage_unavailable", "Lesson media is temporarily unavailable.");
        return;
      }
    }
  }

  res.setHeader("Cache-Control", "private, no-store");
  res.json(
    GetLessonResponse.parse({
      id: lesson.id,
      slug: lesson.slug,
      title: lesson.title,
      type: lesson.type,
      body: lesson.body,
      assetUrl,
      assetFilename,
      assetMimeType,
      chapters: lesson.chapters,
      captions,
      durationSeconds: lesson.durationSeconds,
    }),
  );
});

export default router;
