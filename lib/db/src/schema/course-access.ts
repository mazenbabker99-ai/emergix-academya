import { index, pgTable, text, uniqueIndex, uuid } from "drizzle-orm/pg-core";
import { pk, timestamps, tstz } from "./_helpers";
import { plansTable } from "./billing";
import { coursesTable } from "./courses";
import { users } from "./users";

/** Courses included in a manual WhatsApp subscription offer. */
export const planCoursesTable = pgTable(
  "plan_courses",
  {
    id: pk(),
    planId: uuid("plan_id").notNull().references(() => plansTable.id, { onDelete: "cascade" }),
    courseId: uuid("course_id").notNull().references(() => coursesTable.id, { onDelete: "cascade" }),
    ...timestamps,
  },
  (t) => [
    uniqueIndex("plan_courses_plan_course_uq").on(t.planId, t.courseId),
    index("plan_courses_course_idx").on(t.courseId),
  ],
);

/** Course-scoped access granted by an administrator after manual payment verification. */
export const courseEntitlementsTable = pgTable(
  "course_entitlements",
  {
    id: pk(),
    userId: text("user_id").notNull().references(() => users.id, { onDelete: "cascade" }),
    courseId: uuid("course_id").notNull().references(() => coursesTable.id, { onDelete: "cascade" }),
    planId: uuid("plan_id").references(() => plansTable.id, { onDelete: "set null" }),
    grantedBy: text("granted_by").references(() => users.id, { onDelete: "set null" }),
    startsAt: tstz("starts_at").notNull().defaultNow(),
    endsAt: tstz("ends_at"),
    revokedAt: tstz("revoked_at"),
    ...timestamps,
  },
  (t) => [
    index("course_entitlements_user_course_idx").on(t.userId, t.courseId),
    index("course_entitlements_course_user_idx").on(t.courseId, t.userId),
  ],
);
