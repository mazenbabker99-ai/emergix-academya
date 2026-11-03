-- ============================================================================
-- SEED TEST ACCOUNTS: Admin & Premium Users
-- ============================================================================
-- Safety: Idempotent with ON CONFLICT DO UPDATE.
-- Generates:
-- 1. Admin Account:
--    Email:    admin@emergix.com
--    Password: EmergixAdmin2026!
--    Role:     superadmin (Full access to /admin, content editor, users, courses)
--
-- 2. Premium Learner Account:
--    Email:    premium@emergix.com
--    Password: EmergixPremium2026!
--    Role:     learner (Full 5-year access to all courses, SBAs, question banks)
-- ============================================================================

DO $$
DECLARE
  v_admin_id text := 'a0000000-0000-4000-a000-000000000001';
  v_admin_acc_id text := 'a0000000-0000-4000-a000-000000000002';
  v_admin_hash text := 'c41c43f6467b0e5a0b8ff76d41a76692:62c864dae6765a37d09574ac110bf9adb3555eb0b25d16a18f0abb5750ad872193b7cec61e9645542eb19b11225ff7158f7ceee3402ad5763934fcc1bc78985a';

  v_prem_id text := 'b0000000-0000-4000-b000-000000000001';
  v_prem_acc_id text := 'b0000000-0000-4000-b000-000000000002';
  v_prem_hash text := '93b0513d5594c11bdc9d057e3fb67cde:a4d70c7902abe0bb852271cf6d932bba8a66a15ab76c95c1ec4218c1fdd72f24b4cdcf19449ed1ec9ea25eee81b29efa638c9098651773a219f42583011bf9b1';

  v_plan_id uuid;
  v_primary_exam_id uuid;
  v_sba_exam_id uuid;
BEGIN

  -- ╔════════════════════════════════════════════════════════════════════════╗
  -- ║ 1. CREATE OR UPDATE ADMIN ACCOUNT                                      ║
  -- ╚════════════════════════════════════════════════════════════════════════╝
  INSERT INTO "users" (
    "id", "name", "email", "email_verified", "role", "status", "created_at", "updated_at"
  ) VALUES (
    v_admin_id, 'Emergix Admin', 'admin@emergix.com', true, 'superadmin', 'active', now(), now()
  )
  ON CONFLICT ("email") DO UPDATE SET
    "name" = 'Emergix Admin',
    "role" = 'superadmin',
    "status" = 'active',
    "email_verified" = true,
    "updated_at" = now()
  RETURNING "id" INTO v_admin_id;

  INSERT INTO "accounts" (
    "id", "user_id", "account_id", "provider_id", "password", "created_at", "updated_at"
  ) VALUES (
    v_admin_acc_id, v_admin_id, 'admin@emergix.com', 'credential', v_admin_hash, now(), now()
  )
  ON CONFLICT ("id") DO UPDATE SET
    "password" = v_admin_hash,
    "updated_at" = now();

  -- Update password if an existing account exists by user_id + provider_id
  UPDATE "accounts"
  SET "password" = v_admin_hash, "updated_at" = now()
  WHERE "user_id" = v_admin_id AND "provider_id" = 'credential';

  -- User Profile for Admin
  INSERT INTO "user_profiles" ("user_id", "country", "specialty", "grade", "daily_goal_questions", "created_at", "updated_at")
  VALUES (v_admin_id, 'United Kingdom', 'Emergency Medicine', 'Consultant', 50, now(), now())
  ON CONFLICT ("user_id") DO UPDATE SET
    "specialty" = 'Emergency Medicine',
    "grade" = 'Consultant',
    "updated_at" = now();

  RAISE NOTICE 'Admin account verified: admin@emergix.com (role: superadmin)';

  -- ╔════════════════════════════════════════════════════════════════════════╗
  -- ║ 2. CREATE OR UPDATE PREMIUM LEARNER ACCOUNT                            ║
  -- ╚════════════════════════════════════════════════════════════════════════╝
  INSERT INTO "users" (
    "id", "name", "email", "email_verified", "role", "status", "created_at", "updated_at"
  ) VALUES (
    v_prem_id, 'Emergix Premium', 'premium@emergix.com', true, 'learner', 'active', now(), now()
  )
  ON CONFLICT ("email") DO UPDATE SET
    "name" = 'Emergix Premium',
    "status" = 'active',
    "email_verified" = true,
    "updated_at" = now()
  RETURNING "id" INTO v_prem_id;

  INSERT INTO "accounts" (
    "id", "user_id", "account_id", "provider_id", "password", "created_at", "updated_at"
  ) VALUES (
    v_prem_acc_id, v_prem_id, 'premium@emergix.com', 'credential', v_prem_hash, now(), now()
  )
  ON CONFLICT ("id") DO UPDATE SET
    "password" = v_prem_hash,
    "updated_at" = now();

  -- Update password if an existing account exists by user_id + provider_id
  UPDATE "accounts"
  SET "password" = v_prem_hash, "updated_at" = now()
  WHERE "user_id" = v_prem_id AND "provider_id" = 'credential';

  -- User Profile for Premium Learner
  INSERT INTO "user_profiles" ("user_id", "country", "specialty", "grade", "daily_goal_questions", "created_at", "updated_at")
  VALUES (v_prem_id, 'United Kingdom', 'Emergency Medicine', 'ST3 Trainee', 30, now(), now())
  ON CONFLICT ("user_id") DO UPDATE SET
    "specialty" = 'Emergency Medicine',
    "grade" = 'ST3 Trainee',
    "updated_at" = now();

  RAISE NOTICE 'Premium account verified: premium@emergix.com (role: learner)';

  -- ╔════════════════════════════════════════════════════════════════════════╗
  -- ║ 3. GRANT PREMIUM ENTITLEMENTS TO ALL COURSES & EXAMS                    ║
  -- ╚════════════════════════════════════════════════════════════════════════╝

  -- 3.1 Course entitlements (Direct access to all published courses for 5 years)
  INSERT INTO "course_entitlements" ("id", "user_id", "course_id", "starts_at", "ends_at", "created_at", "updated_at")
  SELECT gen_random_uuid(), v_prem_id, c.id, now(), now() + interval '5 years', now(), now()
  FROM "courses" c
  WHERE c.status = 'published' AND c.deleted_at IS NULL
  ON CONFLICT DO NOTHING;

  -- 3.2 Exam-level entitlements (Access to MRCEM Primary and MRCEM SBA exams)
  SELECT id INTO v_primary_exam_id FROM "exams" WHERE slug = 'mrcem-primary' LIMIT 1;
  IF v_primary_exam_id IS NOT NULL THEN
    INSERT INTO "entitlements" ("id", "user_id", "exam_id", "source", "starts_at", "ends_at", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_prem_id, v_primary_exam_id, 'manual', now(), now() + interval '5 years', now(), now())
    ON CONFLICT DO NOTHING;
  END IF;

  SELECT id INTO v_sba_exam_id FROM "exams" WHERE slug = 'mrcem-sba' LIMIT 1;
  IF v_sba_exam_id IS NOT NULL THEN
    INSERT INTO "entitlements" ("id", "user_id", "exam_id", "source", "starts_at", "ends_at", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_prem_id, v_sba_exam_id, 'manual', now(), now() + interval '5 years', now(), now())
    ON CONFLICT DO NOTHING;
  END IF;

  -- 3.3 Active Subscription link (so billing page shows Active Premium Membership)
  SELECT id INTO v_plan_id FROM "plans" WHERE "status" = 'published' AND "deleted_at" IS NULL ORDER BY "position", "created_at" LIMIT 1;
  IF v_plan_id IS NULL THEN
    SELECT id INTO v_plan_id FROM "plans" WHERE "deleted_at" IS NULL ORDER BY "created_at" LIMIT 1;
  END IF;

  IF v_plan_id IS NOT NULL THEN
    INSERT INTO "subscriptions" (
      "id", "user_id", "plan_id", "status", "current_period_start", "current_period_end", "created_at", "updated_at"
    ) VALUES (
      gen_random_uuid(), v_prem_id, v_plan_id, 'active', now(), now() + interval '5 years', now(), now()
    )
    ON CONFLICT DO NOTHING;
    RAISE NOTICE 'Attached active subscription with plan_id: %', v_plan_id;
  END IF;

  RAISE NOTICE '=========================================================';
  RAISE NOTICE 'SUCCESS: Test accounts initialized successfully.';
  RAISE NOTICE 'Admin:   admin@emergix.com   / EmergixAdmin2026!';
  RAISE NOTICE 'Premium: premium@emergix.com / EmergixPremium2026!';
  RAISE NOTICE '=========================================================';
END $$;
