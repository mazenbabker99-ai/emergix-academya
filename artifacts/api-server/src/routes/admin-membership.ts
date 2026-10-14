import {
  AdminMembershipResponse,
  CourseAccessGrant,
  GrantCourseAccessInput,
  MembershipPlanInput,
  MembershipSettingsInput,
} from "@workspace/api-zod";
import {
  courseEntitlementsTable,
  coursesTable,
  db,
  planCoursesTable,
  planPricesTable,
  plansTable,
  settingsTable,
  users,
} from "@workspace/db";
import { and, asc, desc, eq, ilike, inArray, isNull, ne, or } from "drizzle-orm";
import { randomUUID } from "node:crypto";
import { Router, type IRouter, type Request } from "express";
import { sendError } from "../lib/errors";
import {
  MANUAL_MEMBERSHIP_FAMILY,
  MEMBERSHIP_SETTINGS_KEY,
  getMembershipSettings,
  listMembershipOffers,
} from "./membership";

const router: IRouter = Router();
const monthsInRange = (date: Date, months: number) => {
  const result = new Date(date);
  const day = result.getUTCDate();
  result.setUTCDate(1);
  result.setUTCMonth(result.getUTCMonth() + months);
  const lastDay = new Date(Date.UTC(result.getUTCFullYear(), result.getUTCMonth() + 1, 0)).getUTCDate();
  result.setUTCDate(Math.min(day, lastDay));
  return result;
};

function phoneForStorage(value: string) {
  const normalized = value.trim().replace(/[^\d+]/g, "");
  const digits = normalized.replace(/\D/g, "");
  return /^\+?[1-9]\d{7,14}$/.test(normalized) ? `+${digits}` : null;
}

function slugFromName(name: string) {
  return name.toLowerCase().normalize("NFKD").replace(/[\u0300-\u036f]/g, "")
    .replace(/[^a-z0-9]+/g, "-").replace(/^-|-$/g, "") || `offer-${randomUUID().slice(0, 8)}`;
}

function inputError(res: Parameters<typeof sendError>[0], message: string, details?: unknown) {
  sendError(res, 400, "invalid_request", message, details);
}

async function readPlanInput(req: Request, res: Parameters<typeof sendError>[0]) {
  const parsed = MembershipPlanInput.safeParse(req.body);
  if (!parsed.success) {
    inputError(res, "Invalid subscription offer.", parsed.error.flatten());
    return null;
  }
  const courseIds = [...new Set(parsed.data.courseIds)];
  if (courseIds.length !== parsed.data.courseIds.length) {
    inputError(res, "Choose each course only once.");
    return null;
  }
  const validCourses = await db.select({ id: coursesTable.id })
    .from(coursesTable)
    .where(and(
      inArray(coursesTable.id, courseIds),
      eq(coursesTable.status, "published"),
      eq(coursesTable.isFree, false),
      isNull(coursesTable.deletedAt),
    ));
  if (validCourses.length !== courseIds.length) {
    inputError(res, "Offers can include published paid courses only.");
    return null;
  }
  return { ...parsed.data, courseIds };
}

async function getAdminMembershipResponse() {
  const [settings, offers] = await Promise.all([getMembershipSettings(), listMembershipOffers(true)]);
  return AdminMembershipResponse.parse({ settings, offers });
}

async function saveMembershipPlan(input: NonNullable<Awaited<ReturnType<typeof readPlanInput>>>, planId?: string) {
  return db.transaction(async (tx) => {
    let targetId = planId;
    if (targetId) {
      const [existing] = await tx.select({ id: plansTable.id })
        .from(plansTable)
        .where(and(eq(plansTable.id, targetId), eq(plansTable.familyKey, MANUAL_MEMBERSHIP_FAMILY), isNull(plansTable.deletedAt)))
        .limit(1);
      if (!existing) return null;
      await tx.update(plansTable).set({
        name: input.name,
        description: input.description,
        accessMonths: input.accessMonths,
        status: input.status,
        isPlaceholder: false,
      }).where(eq(plansTable.id, targetId));
    } else {
      let slug = slugFromName(input.name);
      const [collision] = await tx.select({ id: plansTable.id }).from(plansTable).where(eq(plansTable.slug, slug)).limit(1);
      if (collision) slug = `${slug}-${randomUUID().slice(0, 6)}`;
      const [created] = await tx.insert(plansTable).values({
        slug,
        name: input.name,
        description: input.description,
        features: [],
        accessMonths: input.accessMonths,
        isPlaceholder: false,
        familyKey: MANUAL_MEMBERSHIP_FAMILY,
        familyName: input.name,
        status: input.status,
      }).returning({ id: plansTable.id });
      targetId = created!.id;
    }

    await tx.insert(planPricesTable).values({
      planId: targetId!,
      currency: input.currency,
      region: "ALL",
      amountMinor: input.amountMinor,
    }).onConflictDoUpdate({
      target: [planPricesTable.planId, planPricesTable.currency, planPricesTable.region],
      set: { amountMinor: input.amountMinor },
    });
    // A plan has exactly one configured currency. Remove stale price rows when currency changes.
    await tx.delete(planPricesTable).where(and(
      eq(planPricesTable.planId, targetId!),
      eq(planPricesTable.region, "ALL"),
      ne(planPricesTable.currency, input.currency),
    ));
    await tx.delete(planCoursesTable).where(eq(planCoursesTable.planId, targetId!));
    await tx.insert(planCoursesTable).values(input.courseIds.map((courseId) => ({ planId: targetId!, courseId })));
    return targetId;
  });
}

router.get("/membership", async (_req, res) => {
  res.json(await getAdminMembershipResponse());
});

router.put("/membership", async (req, res) => {
  const parsed = MembershipSettingsInput.safeParse(req.body);
  if (!parsed.success) {
    inputError(res, "Invalid WhatsApp number.", parsed.error.flatten());
    return;
  }
  const number = phoneForStorage(parsed.data.whatsappNumber);
  if (!number) {
    inputError(res, "Enter a valid phone number with country code.");
    return;
  }
  await db.insert(settingsTable).values({
    key: MEMBERSHIP_SETTINGS_KEY,
    value: number,
    isPublic: true,
  }).onConflictDoUpdate({
    target: settingsTable.key,
    set: { value: number, isPublic: true },
  });
  res.json({ whatsappNumber: number });
});

router.get("/membership/plans", async (_req, res) => {
  res.json(await listMembershipOffers(true));
});

router.post("/membership/plans", async (req, res) => {
  const input = await readPlanInput(req, res);
  if (!input) return;
  const planId = await saveMembershipPlan(input);
  const created = (await listMembershipOffers(true)).find((plan) => plan.id === planId);
  res.status(201).json(created);
});

router.patch("/membership/plans/:id", async (req, res) => {
  const input = await readPlanInput(req, res);
  if (!input) return;
  const id = await saveMembershipPlan(input, req.params.id);
  if (!id) {
    sendError(res, 404, "not_found", "Subscription offer not found.");
    return;
  }
  const updated = (await listMembershipOffers(true)).find((plan) => plan.id === id);
  res.json(updated);
});

router.delete("/membership/plans/:id", async (req, res) => {
  const [archived] = await db.update(plansTable)
    .set({ status: "archived" })
    .where(and(
      eq(plansTable.id, req.params.id),
      eq(plansTable.familyKey, MANUAL_MEMBERSHIP_FAMILY),
      isNull(plansTable.deletedAt),
    ))
    .returning({ id: plansTable.id });
  if (!archived) {
    sendError(res, 404, "not_found", "Subscription offer not found.");
    return;
  }
  res.status(204).end();
});

router.get("/access-users", async (req, res) => {
  const query = typeof req.query.q === "string" ? req.query.q.trim() : "";
  if (query.length < 2 || query.length > 120) {
    inputError(res, "Enter at least two characters to search.");
    return;
  }
  const escaped = query.replace(/[\\%_]/g, "\\$&");
  const rows = await db.select({ id: users.id, name: users.name, email: users.email })
    .from(users)
    .where(and(eq(users.role, "learner"), eq(users.status, "active"), or(
      ilike(users.name, `%${escaped}%`),
      ilike(users.email, `%${escaped}%`),
    )))
    .orderBy(asc(users.name))
    .limit(20);
  res.json(rows);
});

router.get("/access-users/:id/course-access", async (req, res) => {
  const [user] = await db.select({ id: users.id }).from(users).where(eq(users.id, req.params.id)).limit(1);
  if (!user) {
    sendError(res, 404, "not_found", "Learner not found.");
    return;
  }
  const rows = await db.select({
    id: courseEntitlementsTable.id,
    courseId: courseEntitlementsTable.courseId,
    courseTitle: coursesTable.title,
    planName: plansTable.name,
    startsAt: courseEntitlementsTable.startsAt,
    endsAt: courseEntitlementsTable.endsAt,
    revokedAt: courseEntitlementsTable.revokedAt,
  }).from(courseEntitlementsTable)
    .innerJoin(coursesTable, eq(coursesTable.id, courseEntitlementsTable.courseId))
    .leftJoin(plansTable, eq(plansTable.id, courseEntitlementsTable.planId))
    .where(eq(courseEntitlementsTable.userId, user.id))
    .orderBy(desc(courseEntitlementsTable.startsAt));
  res.json(rows.map((row) => CourseAccessGrant.parse({
    ...row,
    startsAt: row.startsAt.toISOString(),
    endsAt: row.endsAt?.toISOString() ?? null,
    revokedAt: row.revokedAt?.toISOString() ?? null,
  })));
});

router.post("/access-users/:id/course-access", async (req, res) => {
  const parsed = GrantCourseAccessInput.safeParse(req.body);
  if (!parsed.success) {
    inputError(res, "Choose a subscription offer.", parsed.error.flatten());
    return;
  }
  const [user] = await db.select({ id: users.id }).from(users)
    .where(and(eq(users.id, req.params.id), eq(users.role, "learner"), eq(users.status, "active")))
    .limit(1);
  if (!user) {
    sendError(res, 404, "not_found", "Learner not found.");
    return;
  }
  const [plan] = await db.select({ id: plansTable.id, name: plansTable.name, accessMonths: plansTable.accessMonths })
    .from(plansTable)
    .where(and(
      eq(plansTable.id, parsed.data.planId),
      eq(plansTable.familyKey, MANUAL_MEMBERSHIP_FAMILY),
      eq(plansTable.status, "published"),
      isNull(plansTable.deletedAt),
    ))
    .limit(1);
  if (!plan) {
    sendError(res, 404, "not_found", "Published subscription offer not found.");
    return;
  }
  const courseRows = await db.select({ id: coursesTable.id, title: coursesTable.title })
    .from(planCoursesTable)
    .innerJoin(coursesTable, eq(coursesTable.id, planCoursesTable.courseId))
    .where(and(
      eq(planCoursesTable.planId, plan.id),
      eq(coursesTable.status, "published"),
      eq(coursesTable.isFree, false),
      isNull(coursesTable.deletedAt),
    ));
  if (!courseRows.length) {
    inputError(res, "This offer has no published paid courses.");
    return;
  }
  const now = new Date();
  const endsAt = monthsInRange(now, plan.accessMonths);
  const inserted = await db.insert(courseEntitlementsTable).values(courseRows.map((course) => ({
    userId: user.id,
    courseId: course.id,
    planId: plan.id,
    grantedBy: req.auth!.user.id,
    startsAt: now,
    endsAt,
  }))).returning();
  const titles = new Map(courseRows.map((course) => [course.id, course.title]));
  res.status(201).json(inserted.map((grant) => CourseAccessGrant.parse({
    id: grant.id,
    courseId: grant.courseId,
    courseTitle: titles.get(grant.courseId)!,
    planName: plan.name,
    startsAt: grant.startsAt.toISOString(),
    endsAt: grant.endsAt?.toISOString() ?? null,
    revokedAt: null,
  })));
});

router.delete("/course-access/:grantId", async (req, res) => {
  const [revoked] = await db.update(courseEntitlementsTable)
    .set({ revokedAt: new Date() })
    .where(and(eq(courseEntitlementsTable.id, req.params.grantId), isNull(courseEntitlementsTable.revokedAt)))
    .returning({ id: courseEntitlementsTable.id });
  if (!revoked) {
    sendError(res, 404, "not_found", "Active course access grant not found.");
    return;
  }
  res.status(204).end();
});

export default router;
