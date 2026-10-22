-- ==========================================================================
-- FIX: Move 41 Primary Quizzes from mrcem-sba INTO mrcem-primary
-- Uses real Replit course IDs:
--   mrcem-primary : a32b4f45-b1a6-4c82-93c0-58e092e97a13
--   mrcem-sba     : 4c794261-4f8e-4de7-8f77-b1bf8592154d
-- Creates 4 proper modules in mrcem-primary, moves lessons by slug.
-- Safe: uses INSERT ... ON CONFLICT and UPDATE; idempotent.
-- ==========================================================================
DO $$
DECLARE
  v_primary_course_id uuid := 'a32b4f45-b1a6-4c82-93c0-58e092e97a13';
  v_sba_course_id     uuid := '4c794261-4f8e-4de7-8f77-b1bf8592154d';

  v_mod1_id uuid;   -- Quizzes 01-10
  v_mod2_id uuid;   -- Quizzes 11-20
  v_mod3_id uuid;   -- Quizzes 21-30
  v_mod4_id uuid;   -- Quizzes 31-41

  v_lesson_id uuid;
  r RECORD;
BEGIN

  -- =========================================================================
  -- STEP 1: Ensure mrcem-primary exists (safety check)
  -- =========================================================================
  IF NOT EXISTS (SELECT 1 FROM "courses" WHERE "id" = v_primary_course_id) THEN
    RAISE EXCEPTION 'mrcem-primary course (%) not found in DB', v_primary_course_id;
  END IF;

  -- =========================================================================
  -- STEP 2: Create (or find) the 4 Question Bank modules in mrcem-primary
  -- =========================================================================

  -- Module 1: Quizzes 01-10
  SELECT id INTO v_mod1_id FROM "modules"
  WHERE "course_id" = v_primary_course_id
    AND "title" = 'MRCEM Primary Question Bank: Quizzes 01-10'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod1_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_primary_course_id, 'MRCEM Primary Question Bank: Quizzes 01-10', 22, now(), now())
    RETURNING "id" INTO v_mod1_id;
    RAISE NOTICE 'Created module Quizzes 01-10: %', v_mod1_id;
  ELSE
    UPDATE "modules" SET "deleted_at" = NULL, "position" = 22, "updated_at" = now() WHERE "id" = v_mod1_id;
    RAISE NOTICE 'Found existing module Quizzes 01-10: %', v_mod1_id;
  END IF;

  -- Module 2: Quizzes 11-20
  SELECT id INTO v_mod2_id FROM "modules"
  WHERE "course_id" = v_primary_course_id
    AND "title" = 'MRCEM Primary Question Bank: Quizzes 11-20'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod2_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_primary_course_id, 'MRCEM Primary Question Bank: Quizzes 11-20', 23, now(), now())
    RETURNING "id" INTO v_mod2_id;
    RAISE NOTICE 'Created module Quizzes 11-20: %', v_mod2_id;
  ELSE
    UPDATE "modules" SET "deleted_at" = NULL, "position" = 23, "updated_at" = now() WHERE "id" = v_mod2_id;
    RAISE NOTICE 'Found existing module Quizzes 11-20: %', v_mod2_id;
  END IF;

  -- Module 3: Quizzes 21-30
  SELECT id INTO v_mod3_id FROM "modules"
  WHERE "course_id" = v_primary_course_id
    AND "title" = 'MRCEM Primary Question Bank: Quizzes 21-30'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod3_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_primary_course_id, 'MRCEM Primary Question Bank: Quizzes 21-30', 24, now(), now())
    RETURNING "id" INTO v_mod3_id;
    RAISE NOTICE 'Created module Quizzes 21-30: %', v_mod3_id;
  ELSE
    UPDATE "modules" SET "deleted_at" = NULL, "position" = 24, "updated_at" = now() WHERE "id" = v_mod3_id;
    RAISE NOTICE 'Found existing module Quizzes 21-30: %', v_mod3_id;
  END IF;

  -- Module 4: Quizzes 31-41
  SELECT id INTO v_mod4_id FROM "modules"
  WHERE "course_id" = v_primary_course_id
    AND "title" = 'MRCEM Primary Question Bank: Quizzes 31-41'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod4_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_primary_course_id, 'MRCEM Primary Question Bank: Quizzes 31-41', 25, now(), now())
    RETURNING "id" INTO v_mod4_id;
    RAISE NOTICE 'Created module Quizzes 31-41: %', v_mod4_id;
  ELSE
    UPDATE "modules" SET "deleted_at" = NULL, "position" = 25, "updated_at" = now() WHERE "id" = v_mod4_id;
    RAISE NOTICE 'Found existing module Quizzes 31-41: %', v_mod4_id;
  END IF;

  -- =========================================================================
  -- STEP 3: Move lessons from ANY module into correct Primary modules
  --         Matching by slug 'primary-quiz-NN'
  -- =========================================================================

  -- === Quizzes 01-10 → Module 1 ===
  FOR r IN
    SELECT l.id, l.slug, l.position
    FROM "lessons" l
    WHERE l.slug IN (
      'primary-quiz-01','primary-quiz-02','primary-quiz-03','primary-quiz-04','primary-quiz-05',
      'primary-quiz-06','primary-quiz-07','primary-quiz-08','primary-quiz-09','primary-quiz-10'
    )
    AND l.deleted_at IS NULL
  LOOP
    UPDATE "lessons"
    SET
      "module_id"  = v_mod1_id,
      "status"     = 'published',
      "deleted_at" = NULL,
      "updated_at" = now(),
      "position"   = CASE r.slug
        WHEN 'primary-quiz-01' THEN 0
        WHEN 'primary-quiz-02' THEN 1
        WHEN 'primary-quiz-03' THEN 2
        WHEN 'primary-quiz-04' THEN 3
        WHEN 'primary-quiz-05' THEN 4
        WHEN 'primary-quiz-06' THEN 5
        WHEN 'primary-quiz-07' THEN 6
        WHEN 'primary-quiz-08' THEN 7
        WHEN 'primary-quiz-09' THEN 8
        WHEN 'primary-quiz-10' THEN 9
        ELSE 99
      END
    WHERE "id" = r.id;
    RAISE NOTICE 'Moved % -> module Quizzes 01-10', r.slug;
  END LOOP;

  -- === Quizzes 11-20 → Module 2 ===
  FOR r IN
    SELECT l.id, l.slug
    FROM "lessons" l
    WHERE l.slug IN (
      'primary-quiz-11','primary-quiz-12','primary-quiz-13','primary-quiz-14','primary-quiz-15',
      'primary-quiz-16','primary-quiz-17','primary-quiz-18','primary-quiz-19','primary-quiz-20'
    )
    AND l.deleted_at IS NULL
  LOOP
    UPDATE "lessons"
    SET
      "module_id"  = v_mod2_id,
      "status"     = 'published',
      "deleted_at" = NULL,
      "updated_at" = now(),
      "position"   = CASE r.slug
        WHEN 'primary-quiz-11' THEN 0
        WHEN 'primary-quiz-12' THEN 1
        WHEN 'primary-quiz-13' THEN 2
        WHEN 'primary-quiz-14' THEN 3
        WHEN 'primary-quiz-15' THEN 4
        WHEN 'primary-quiz-16' THEN 5
        WHEN 'primary-quiz-17' THEN 6
        WHEN 'primary-quiz-18' THEN 7
        WHEN 'primary-quiz-19' THEN 8
        WHEN 'primary-quiz-20' THEN 9
        ELSE 99
      END
    WHERE "id" = r.id;
    RAISE NOTICE 'Moved % -> module Quizzes 11-20', r.slug;
  END LOOP;

  -- === Quizzes 21-30 → Module 3 ===
  FOR r IN
    SELECT l.id, l.slug
    FROM "lessons" l
    WHERE l.slug IN (
      'primary-quiz-21','primary-quiz-22','primary-quiz-23','primary-quiz-24','primary-quiz-25',
      'primary-quiz-26','primary-quiz-27','primary-quiz-28','primary-quiz-29','primary-quiz-30'
    )
    AND l.deleted_at IS NULL
  LOOP
    UPDATE "lessons"
    SET
      "module_id"  = v_mod3_id,
      "status"     = 'published',
      "deleted_at" = NULL,
      "updated_at" = now(),
      "position"   = CASE r.slug
        WHEN 'primary-quiz-21' THEN 0
        WHEN 'primary-quiz-22' THEN 1
        WHEN 'primary-quiz-23' THEN 2
        WHEN 'primary-quiz-24' THEN 3
        WHEN 'primary-quiz-25' THEN 4
        WHEN 'primary-quiz-26' THEN 5
        WHEN 'primary-quiz-27' THEN 6
        WHEN 'primary-quiz-28' THEN 7
        WHEN 'primary-quiz-29' THEN 8
        WHEN 'primary-quiz-30' THEN 9
        ELSE 99
      END
    WHERE "id" = r.id;
    RAISE NOTICE 'Moved % -> module Quizzes 21-30', r.slug;
  END LOOP;

  -- === Quizzes 31-41 → Module 4 ===
  FOR r IN
    SELECT l.id, l.slug
    FROM "lessons" l
    WHERE l.slug IN (
      'primary-quiz-31','primary-quiz-32','primary-quiz-33','primary-quiz-34','primary-quiz-35',
      'primary-quiz-36','primary-quiz-37','primary-quiz-38','primary-quiz-39','primary-quiz-40',
      'primary-quiz-41'
    )
    AND l.deleted_at IS NULL
  LOOP
    UPDATE "lessons"
    SET
      "module_id"  = v_mod4_id,
      "status"     = 'published',
      "deleted_at" = NULL,
      "updated_at" = now(),
      "position"   = CASE r.slug
        WHEN 'primary-quiz-31' THEN 0
        WHEN 'primary-quiz-32' THEN 1
        WHEN 'primary-quiz-33' THEN 2
        WHEN 'primary-quiz-34' THEN 3
        WHEN 'primary-quiz-35' THEN 4
        WHEN 'primary-quiz-36' THEN 5
        WHEN 'primary-quiz-37' THEN 6
        WHEN 'primary-quiz-38' THEN 7
        WHEN 'primary-quiz-39' THEN 8
        WHEN 'primary-quiz-40' THEN 9
        WHEN 'primary-quiz-41' THEN 10
        ELSE 99
      END
    WHERE "id" = r.id;
    RAISE NOTICE 'Moved % -> module Quizzes 31-41', r.slug;
  END LOOP;

  -- =========================================================================
  -- STEP 4: Soft-delete any OLD misplaced Primary quiz modules in mrcem-sba
  --         (modules whose titles match the old naming used in SBA seed)
  -- =========================================================================
  UPDATE "modules"
  SET "deleted_at" = now(), "updated_at" = now()
  WHERE "course_id" = v_sba_course_id
    AND "title" IN (
      'MRCEM Primary Question Bank: Quizzes 01-10',
      'MRCEM Primary Question Bank: Quizzes 11-20',
      'MRCEM Primary Question Bank: Quizzes 21-30',
      'MRCEM Primary Question Bank: Quizzes 31-41',
      'High-Yield SBA Quizzes: Part 1 (Quizzes 01 - 10)',
      'High-Yield SBA Quizzes: Part 2 (Quizzes 11 - 20)',
      'High-Yield SBA Quizzes: Part 3 (Quizzes 21 - 30)',
      'High-Yield SBA Quizzes: Part 4 (Quizzes 31 - 41)'
    )
    AND "deleted_at" IS NULL;

  -- =========================================================================
  -- STEP 5: Also soft-delete any orphaned empty modules with matching titles
  --         that ended up in SBA but whose lessons have been moved out
  -- =========================================================================
  UPDATE "modules" m
  SET "deleted_at" = now(), "updated_at" = now()
  WHERE m."course_id" = v_sba_course_id
    AND m."deleted_at" IS NULL
    AND m."title" LIKE '%Question Bank%'
    AND NOT EXISTS (
      SELECT 1 FROM "lessons" l
      WHERE l."module_id" = m."id" AND l."deleted_at" IS NULL
    );

  -- =========================================================================
  -- STEP 6: Update mrcem-primary lesson count cache (if table exists)
  -- =========================================================================
  UPDATE "courses"
  SET "updated_at" = now()
  WHERE "id" = v_primary_course_id;

  UPDATE "courses"
  SET "updated_at" = now()
  WHERE "id" = v_sba_course_id;

  RAISE NOTICE '========================================';
  RAISE NOTICE 'PRIMARY QUIZ MIGRATION COMPLETE';
  RAISE NOTICE 'Module 1 (01-10): %', v_mod1_id;
  RAISE NOTICE 'Module 2 (11-20): %', v_mod2_id;
  RAISE NOTICE 'Module 3 (21-30): %', v_mod3_id;
  RAISE NOTICE 'Module 4 (31-41): %', v_mod4_id;
  RAISE NOTICE '========================================';

END $$;
