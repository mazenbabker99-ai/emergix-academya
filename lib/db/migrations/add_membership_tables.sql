-- Migration: add plans, plan_courses, course_entitlements tables
-- Run this in Replit Shell:
--   psql $DATABASE_URL -f lib/db/migrations/add_membership_tables.sql

-- 1. plans table (WhatsApp subscription plans managed by admin)
CREATE TABLE IF NOT EXISTS "plans" (
  "id"                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "exam_id"           uuid REFERENCES "exams"("id") ON DELETE SET NULL,
  "slug"              text NOT NULL,
  "name"              text NOT NULL,
  "description"       text NOT NULL DEFAULT '',
  "features"          jsonb NOT NULL DEFAULT '[]',
  "access_months"     integer NOT NULL,
  "trial_days"        integer NOT NULL DEFAULT 0,
  "is_placeholder"    boolean NOT NULL DEFAULT false,
  "family_key"        text,
  "family_name"       text,
  "is_featured"       boolean NOT NULL DEFAULT false,
  "stripe_product_id" text,
  "position"          integer NOT NULL DEFAULT 0,
  "status"            text NOT NULL DEFAULT 'draft',
  "created_at"        timestamptz NOT NULL DEFAULT now(),
  "updated_at"        timestamptz NOT NULL DEFAULT now(),
  "deleted_at"        timestamptz
);
CREATE UNIQUE INDEX IF NOT EXISTS "plans_slug_uq" ON "plans"("slug");
CREATE INDEX IF NOT EXISTS "plans_exam_status_idx" ON "plans"("exam_id", "status");

-- 2. plan_prices table
CREATE TABLE IF NOT EXISTS "plan_prices" (
  "id"              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "plan_id"         uuid NOT NULL REFERENCES "plans"("id") ON DELETE CASCADE,
  "currency"        text NOT NULL,
  "region"          text NOT NULL DEFAULT 'ALL',
  "amount_minor"    integer NOT NULL,
  "stripe_price_id" text,
  "created_at"      timestamptz NOT NULL DEFAULT now(),
  "updated_at"      timestamptz NOT NULL DEFAULT now()
);
CREATE UNIQUE INDEX IF NOT EXISTS "plan_prices_plan_currency_region_uq" ON "plan_prices"("plan_id","currency","region");
CREATE INDEX IF NOT EXISTS "plan_prices_plan_idx" ON "plan_prices"("plan_id");

-- 3. plan_courses (which courses belong to each plan)
CREATE TABLE IF NOT EXISTS "plan_courses" (
  "id"         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "plan_id"    uuid NOT NULL REFERENCES "plans"("id") ON DELETE CASCADE,
  "course_id"  uuid NOT NULL REFERENCES "courses"("id") ON DELETE CASCADE,
  "created_at" timestamptz NOT NULL DEFAULT now(),
  "updated_at" timestamptz NOT NULL DEFAULT now()
);
CREATE UNIQUE INDEX IF NOT EXISTS "plan_courses_plan_course_uq" ON "plan_courses"("plan_id","course_id");
CREATE INDEX IF NOT EXISTS "plan_courses_course_idx" ON "plan_courses"("course_id");

-- 4. course_entitlements (admin grants a user access to a specific course)
CREATE TABLE IF NOT EXISTS "course_entitlements" (
  "id"         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "user_id"    text NOT NULL REFERENCES "users"("id") ON DELETE CASCADE,
  "course_id"  uuid NOT NULL REFERENCES "courses"("id") ON DELETE CASCADE,
  "plan_id"    uuid REFERENCES "plans"("id") ON DELETE SET NULL,
  "granted_by" text REFERENCES "users"("id") ON DELETE SET NULL,
  "starts_at"  timestamptz NOT NULL DEFAULT now(),
  "ends_at"    timestamptz,
  "revoked_at" timestamptz,
  "created_at" timestamptz NOT NULL DEFAULT now(),
  "updated_at" timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS "course_entitlements_user_course_idx" ON "course_entitlements"("user_id","course_id");
CREATE INDEX IF NOT EXISTS "course_entitlements_course_user_idx" ON "course_entitlements"("course_id","user_id");
