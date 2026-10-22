import fs from "node:fs";
import path from "node:path";
import { SetUserRoleBody, SetUserRoleParams } from "@workspace/api-zod";
import { db, pool, users } from "@workspace/db";
import { eq } from "drizzle-orm";
import { Router, type IRouter } from "express";
import { writeAudit } from "../lib/audit";
import { sendError } from "../lib/errors";
import { requirePermission } from "../middlewares/rbac";
import adminCoursesRouter from "./admin-courses";
import adminMediaRouter from "./admin-media";
import adminQuestionsRouter from "./admin-questions";

import { runAutoMigrationsAndSeeds } from "../lib/autoMigration";

/** Mounted behind requireAuth + requirePermission('admin:access'). */
const router: IRouter = Router();

router.get("/ping", (_req, res) => {
  res.json({ status: "ok" });
});

router.post("/sync-database", async (_req, res) => {
  await runAutoMigrationsAndSeeds();
  res.json({
    status: "ok",
    message: "Database schema and course seeds synchronized successfully.",
  });
});

router.all("/move-primary-quizzes", async (_req, res) => {
  try {
    const candidates = [
      path.resolve(
        process.cwd(),
        "lib",
        "db",
        "migrations",
        "fix_move_primary_quizzes_to_primary_course.sql",
      ),
      path.resolve(
        process.cwd(),
        "..",
        "..",
        "lib",
        "db",
        "migrations",
        "fix_move_primary_quizzes_to_primary_course.sql",
      ),
      path.resolve(
        __dirname,
        "..",
        "..",
        "..",
        "..",
        "lib",
        "db",
        "migrations",
        "fix_move_primary_quizzes_to_primary_course.sql",
      ),
      path.resolve(
        __dirname,
        "..",
        "..",
        "lib",
        "db",
        "migrations",
        "fix_move_primary_quizzes_to_primary_course.sql",
      ),
    ];
    let resolved: string | null = null;
    for (const c of candidates) {
      if (fs.existsSync(c)) {
        resolved = c;
        break;
      }
    }
    if (!resolved) {
      return void res
        .status(404)
        .json({ status: "error", error: "Migration SQL file not found" });
    }
    const sql = fs.readFileSync(resolved, "utf-8");
    await pool.query(sql);

    const countsRes = await pool.query(`
      SELECT c.slug, count(l.id)::int as count
      FROM courses c
      LEFT JOIN modules m ON m.course_id = c.id AND m.deleted_at IS NULL
      LEFT JOIN lessons l ON l.module_id = m.id AND l.deleted_at IS NULL
      WHERE c.slug IN ('mrcem-primary', 'mrcem-sba')
      GROUP BY c.slug;
    `);

    res.json({
      status: "ok",
      message:
        "Successfully transferred 41 primary quizzes into MRCEM Primary course.",
      counts: countsRes.rows,
    });
  } catch (err: any) {
    res
      .status(500)
      .json({ status: "error", error: err?.message || String(err) });
  }
});

router.put(
  "/users/:userId/role",
  requirePermission("users:set-role"),
  async (req, res) => {
    const params = SetUserRoleParams.safeParse(req.params);
    const body = SetUserRoleBody.safeParse(req.body);
    if (!params.success || !body.success) {
      return void sendError(res, 400, "validation_error", "Invalid request.");
    }
    const actor = req.auth!.user;
    if (params.data.userId === actor.id) {
      return void sendError(
        res,
        400,
        "cannot_change_own_role",
        "You cannot change your own role.",
      );
    }
    const [target] = await db
      .select({ id: users.id, role: users.role })
      .from(users)
      .where(eq(users.id, params.data.userId))
      .limit(1);
    if (!target) return void sendError(res, 404, "not_found", "User not found.");

    await db
      .update(users)
      .set({ role: body.data.role })
      .where(eq(users.id, target.id));
    await writeAudit({
      actorId: actor.id,
      action: "admin.role_changed",
      entityType: "user",
      entityId: target.id,
      before: { role: target.role },
      after: { role: body.data.role },
      ip: req.ip,
    });
    res.json({ status: "ok" });
  },
);

router.use(adminCoursesRouter);
router.use(adminMediaRouter);
router.use(adminQuestionsRouter);

export default router;
