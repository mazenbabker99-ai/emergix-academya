import { and, asc, eq, inArray, isNull } from "drizzle-orm";
import { MembershipOffersResponse } from "@workspace/api-zod";
import { coursesTable, db, planCoursesTable, planPricesTable, plansTable, settingsTable } from "@workspace/db";
import { Router, type IRouter } from "express";
import { publicCache } from "../lib/http";

export const DEFAULT_MEMBERSHIP_WHATSAPP = "+966563169123";
export const MEMBERSHIP_SETTINGS_KEY = "membership.whatsapp_number";
export const MANUAL_MEMBERSHIP_FAMILY = "whatsapp-manual";

export async function getMembershipSettings() {
  const [setting] = await db.select({ value: settingsTable.value })
    .from(settingsTable)
    .where(eq(settingsTable.key, MEMBERSHIP_SETTINGS_KEY))
    .limit(1);
  const number = typeof setting?.value === "string" ? setting.value : DEFAULT_MEMBERSHIP_WHATSAPP;
  return { whatsappNumber: number };
}

export async function listMembershipOffers(includeDrafts = false) {
  const planConditions = [
    eq(plansTable.familyKey, MANUAL_MEMBERSHIP_FAMILY),
    isNull(plansTable.deletedAt),
    ...(includeDrafts ? [] : [eq(plansTable.status, "published" as const)]),
  ];
  const rows = await db.select({
    plan: plansTable,
    amountMinor: planPricesTable.amountMinor,
    currency: planPricesTable.currency,
  })
    .from(plansTable)
    .innerJoin(planPricesTable, and(
      eq(planPricesTable.planId, plansTable.id),
      eq(planPricesTable.region, "ALL"),
    ))
    .where(and(...planConditions))
    .orderBy(asc(plansTable.position), asc(plansTable.name));
  if (!rows.length) return [];

  const links = await db.select({
    planId: planCoursesTable.planId,
    id: coursesTable.id,
    title: coursesTable.title,
    slug: coursesTable.slug,
  })
    .from(planCoursesTable)
    .innerJoin(coursesTable, eq(coursesTable.id, planCoursesTable.courseId))
    .where(inArray(planCoursesTable.planId, rows.map((row) => row.plan.id)));
  const coursesByPlan = new Map<string, typeof links>();
  for (const link of links) coursesByPlan.set(link.planId, [...(coursesByPlan.get(link.planId) ?? []), link]);

  return rows.map(({ plan, amountMinor, currency }) => ({
    id: plan.id,
    slug: plan.slug,
    name: plan.name,
    description: plan.description,
    accessMonths: plan.accessMonths,
    amountMinor,
    currency,
    status: plan.status,
    courses: (coursesByPlan.get(plan.id) ?? []).map(({ id, title, slug }) => ({ id, title, slug })),
  }));
}

const router: IRouter = Router();

router.get("/membership/offers", async (_req, res) => {
  const [settings, offers] = await Promise.all([getMembershipSettings(), listMembershipOffers()]);
  publicCache(res);
  res.json(MembershipOffersResponse.parse({ settings, offers }));
});

export default router;
