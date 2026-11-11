import { Router, type IRouter } from "express";
import { pool } from "@workspace/db";
import { env } from "../config/env";
import { publicReadLimiter } from "../middlewares/rateLimit";
import { requireAuth, requirePermission } from "../middlewares/rbac";
import accountRouter from "./account";
import adminRouter from "./admin";
import bootstrapRouter from "./bootstrap";
import contactRouter from "./contact";
import contentRouter from "./content";
import coursesRouter from "./courses";
import examsRouter from "./exams";
import healthRouter from "./health";
import plansRouter from "./plans";
import sitemapRouter from "./sitemap";
import testHooksRouter from "./testHooks";
import osceRouter from "./osce";
import analyticsRouter from "./analytics";
import quizzesRouter from "./quizzes";
import { myNotesRouter, questionActionsRouter, questionCatalogRouter } from "./questions";
import membershipRouter from "./membership";
import adminMembershipRouter from "./admin-membership";

const router: IRouter = Router();

router.use(healthRouter);
router.use("/setup", bootstrapRouter);
router.use("/account", requireAuth, accountRouter);
router.use("/admin", requireAuth, requirePermission("admin:access"), adminRouter);
router.use("/admin", requireAuth, requirePermission("admin:access"), adminMembershipRouter);
router.use("/quizzes", requireAuth, quizzesRouter);
router.use("/questions", requireAuth, questionActionsRouter);
router.use("/me", requireAuth, myNotesRouter);
router.use("/analytics", requireAuth, analyticsRouter);
if (env.testHooksEnabled) router.use("/test", testHooksRouter);

// Public site (phase 04): read-only content, contact form and sitemap. Mounted after the authenticated
// areas so the generous public-read limiter never counts account or admin traffic.
const publicRouter: IRouter = Router();
publicRouter.use(publicReadLimiter);
publicRouter.use(examsRouter);
publicRouter.use(coursesRouter);
publicRouter.use(questionCatalogRouter);
publicRouter.use(contentRouter);
publicRouter.use(plansRouter);
publicRouter.use(membershipRouter);
publicRouter.use(contactRouter);
publicRouter.use(sitemapRouter);
publicRouter.use("/osce", osceRouter);

// Public lesson image serving endpoint
publicRouter.get("/images/:id", async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query(
      "SELECT mime_type, data FROM lesson_images WHERE id = $1",
      [id],
    );
    if (result.rowCount === 0) {
      return res.status(404).json({ error: "Image not found" });
    }
    const row = result.rows[0];
    res.setHeader("Content-Type", row.mime_type || "image/jpeg");
    res.setHeader("Cache-Control", "public, max-age=31536000, immutable");
    return res.send(row.data);
  } catch {
    return res.status(500).json({ error: "Failed to load image" });
  }
});
router.use(publicRouter);

export default router;
