-- ==========================================================================
-- RELIABLE TRANSFER OF 41 PRIMARY QUIZZES FROM SBA TO PRIMARY COURSE
-- Handles both module reassignment (course_id update) and individual lesson relocation.
-- Works whether slugs are 'quiz-1'..'quiz-41' or 'primary-quiz-01'..'primary-quiz-41'
-- ==========================================================================
DO $$
DECLARE
  v_primary_id uuid;
  v_sba_id     uuid;

  v_mod1_id uuid;
  v_mod2_id uuid;
  v_mod3_id uuid;
  v_mod4_id uuid;

  v_target_mod uuid;
  v_quiz_num int;
  r RECORD;
BEGIN
  -- 1. Identify Courses
  SELECT id INTO v_primary_id FROM "courses" WHERE "slug" = 'mrcem-primary' OR "id" = 'a32b4f45-b1a6-4c82-93c0-58e092e97a13' LIMIT 1;
  SELECT id INTO v_sba_id     FROM "courses" WHERE "slug" = 'mrcem-sba'     OR "id" = '4c794261-4f8e-4de7-8f77-b1bf8592154d' LIMIT 1;

  IF v_primary_id IS NULL THEN
    RAISE EXCEPTION 'mrcem-primary course not found';
  END IF;

  -- 2. Ensure Primary Question Bank Module 1 exists (Quizzes 01 - 10)
  SELECT id INTO v_mod1_id FROM "modules" 
  WHERE "course_id" = v_primary_id 
    AND ("title" ILIKE '%Question Bank%01%10%' OR "title" ILIKE '%Quizzes 01-10%' OR "title" ILIKE '%Quizzes 01 - 10%')
    AND "deleted_at" IS NULL LIMIT 1;

  IF v_mod1_id IS NULL THEN
    -- Check if it exists in SBA so we can simply move it
    SELECT id INTO v_mod1_id FROM "modules" 
    WHERE "course_id" = v_sba_id 
      AND ("title" ILIKE '%01%10%' OR "title" ILIKE '%Part 1%Quiz%')
      AND "deleted_at" IS NULL LIMIT 1;

    IF v_mod1_id IS NOT NULL THEN
      UPDATE "modules" 
      SET "course_id" = v_primary_id, "title" = 'MRCEM Primary Question Bank: Quizzes 01-10', "position" = 22, "deleted_at" = NULL, "updated_at" = now()
      WHERE "id" = v_mod1_id;
    ELSE
      INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
      VALUES (gen_random_uuid(), v_primary_id, 'MRCEM Primary Question Bank: Quizzes 01-10', 22, now(), now())
      RETURNING "id" INTO v_mod1_id;
    END IF;
  ELSE
    UPDATE "modules" SET "position" = 22, "deleted_at" = NULL, "updated_at" = now() WHERE "id" = v_mod1_id;
  END IF;

  -- 3. Ensure Primary Question Bank Module 2 exists (Quizzes 11 - 20)
  SELECT id INTO v_mod2_id FROM "modules" 
  WHERE "course_id" = v_primary_id 
    AND ("title" ILIKE '%Question Bank%11%20%' OR "title" ILIKE '%Quizzes 11-20%' OR "title" ILIKE '%Quizzes 11 - 20%')
    AND "deleted_at" IS NULL LIMIT 1;

  IF v_mod2_id IS NULL THEN
    SELECT id INTO v_mod2_id FROM "modules" 
    WHERE "course_id" = v_sba_id 
      AND ("title" ILIKE '%11%20%' OR "title" ILIKE '%Part 2%Quiz%')
      AND "deleted_at" IS NULL LIMIT 1;

    IF v_mod2_id IS NOT NULL THEN
      UPDATE "modules" 
      SET "course_id" = v_primary_id, "title" = 'MRCEM Primary Question Bank: Quizzes 11-20', "position" = 23, "deleted_at" = NULL, "updated_at" = now()
      WHERE "id" = v_mod2_id;
    ELSE
      INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
      VALUES (gen_random_uuid(), v_primary_id, 'MRCEM Primary Question Bank: Quizzes 11-20', 23, now(), now())
      RETURNING "id" INTO v_mod2_id;
    END IF;
  ELSE
    UPDATE "modules" SET "position" = 23, "deleted_at" = NULL, "updated_at" = now() WHERE "id" = v_mod2_id;
  END IF;

  -- 4. Ensure Primary Question Bank Module 3 exists (Quizzes 21 - 30)
  SELECT id INTO v_mod3_id FROM "modules" 
  WHERE "course_id" = v_primary_id 
    AND ("title" ILIKE '%Question Bank%21%30%' OR "title" ILIKE '%Quizzes 21-30%' OR "title" ILIKE '%Quizzes 21 - 30%')
    AND "deleted_at" IS NULL LIMIT 1;

  IF v_mod3_id IS NULL THEN
    SELECT id INTO v_mod3_id FROM "modules" 
    WHERE "course_id" = v_sba_id 
      AND ("title" ILIKE '%21%30%' OR "title" ILIKE '%Part 3%Quiz%')
      AND "deleted_at" IS NULL LIMIT 1;

    IF v_mod3_id IS NOT NULL THEN
      UPDATE "modules" 
      SET "course_id" = v_primary_id, "title" = 'MRCEM Primary Question Bank: Quizzes 21-30', "position" = 24, "deleted_at" = NULL, "updated_at" = now()
      WHERE "id" = v_mod3_id;
    ELSE
      INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
      VALUES (gen_random_uuid(), v_primary_id, 'MRCEM Primary Question Bank: Quizzes 21-30', 24, now(), now())
      RETURNING "id" INTO v_mod3_id;
    END IF;
  ELSE
    UPDATE "modules" SET "position" = 24, "deleted_at" = NULL, "updated_at" = now() WHERE "id" = v_mod3_id;
  END IF;

  -- 5. Ensure Primary Question Bank Module 4 exists (Quizzes 31 - 41)
  SELECT id INTO v_mod4_id FROM "modules" 
  WHERE "course_id" = v_primary_id 
    AND ("title" ILIKE '%Question Bank%31%41%' OR "title" ILIKE '%Quizzes 31-41%' OR "title" ILIKE '%Quizzes 31 - 41%')
    AND "deleted_at" IS NULL LIMIT 1;

  IF v_mod4_id IS NULL THEN
    SELECT id INTO v_mod4_id FROM "modules" 
    WHERE "course_id" = v_sba_id 
      AND ("title" ILIKE '%31%41%' OR "title" ILIKE '%Part 4%Quiz%')
      AND "deleted_at" IS NULL LIMIT 1;

    IF v_mod4_id IS NOT NULL THEN
      UPDATE "modules" 
      SET "course_id" = v_primary_id, "title" = 'MRCEM Primary Question Bank: Quizzes 31-41', "position" = 25, "deleted_at" = NULL, "updated_at" = now()
      WHERE "id" = v_mod4_id;
    ELSE
      INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
      VALUES (gen_random_uuid(), v_primary_id, 'MRCEM Primary Question Bank: Quizzes 31-41', 25, now(), now())
      RETURNING "id" INTO v_mod4_id;
    END IF;
  ELSE
    UPDATE "modules" SET "position" = 25, "deleted_at" = NULL, "updated_at" = now() WHERE "id" = v_mod4_id;
  END IF;

  -- 6. Move any lessons matching Quizzes 1-41 from SBA into the primary modules
  FOR r IN
    SELECT l.id, l.slug, l.title, l.module_id, m.course_id
    FROM "lessons" l
    JOIN "modules" m ON m.id = l.module_id
    WHERE (
      -- Match by slug: 'quiz-1' to 'quiz-41' OR 'primary-quiz-01' to 'primary-quiz-41'
      l.slug ~ '^quiz-([1-9]|[1-3][0-9]|4[0-1])$'
      OR l.slug ~ '^primary-quiz-0?([1-9]|[1-3][0-9]|4[0-1])$'
      -- Or match by title: 'Quiz _ 1' to 'Quiz _ 41' or 'Primary Quiz ...'
      OR l.title ~* '^(Primary )?Quiz[ _]+0?([1-9]|[1-3][0-9]|4[0-1])$'
    )
    AND l.deleted_at IS NULL
  LOOP
    -- Extract quiz number
    v_quiz_num := NULL;
    IF r.slug ~ '^quiz-([0-9]+)$' THEN
      v_quiz_num := (regexp_match(r.slug, '^quiz-([0-9]+)$'))[1]::int;
    ELSIF r.slug ~ '^primary-quiz-([0-9]+)$' THEN
      v_quiz_num := (regexp_match(r.slug, '^primary-quiz-([0-9]+)$'))[1]::int;
    ELSIF r.title ~* '([0-9]+)' THEN
      v_quiz_num := (regexp_match(r.title, '([0-9]+)'))[1]::int;
    END IF;

    IF v_quiz_num IS NOT NULL AND v_quiz_num >= 1 AND v_quiz_num <= 41 THEN
      IF v_quiz_num BETWEEN 1 AND 10 THEN
        v_target_mod := v_mod1_id;
      ELSIF v_quiz_num BETWEEN 11 AND 20 THEN
        v_target_mod := v_mod2_id;
      ELSIF v_quiz_num BETWEEN 21 AND 30 THEN
        v_target_mod := v_mod3_id;
      ELSE
        v_target_mod := v_mod4_id;
      END IF;

      UPDATE "lessons"
      SET
        "module_id" = v_target_mod,
        "type" = 'quiz',
        "status" = 'published',
        "deleted_at" = NULL,
        "title" = 'Primary Quiz ' || LPAD(v_quiz_num::text, 2, '0'),
        "position" = (v_quiz_num - 1) % 10,
        "updated_at" = now()
      WHERE "id" = r.id;

      RAISE NOTICE 'Relocated quiz % (id: %) to module %', v_quiz_num, r.id, v_target_mod;
    END IF;
  END LOOP;

  -- 7. Clean up any leftover duplicate/empty quiz modules in SBA
  IF v_sba_id IS NOT NULL THEN
    UPDATE "modules"
    SET "deleted_at" = now(), "updated_at" = now()
    WHERE "course_id" = v_sba_id
      AND (
        "title" ILIKE '%Primary Question Bank%'
        OR "title" ILIKE 'High-Yield SBA Quizzes: Part % (Quizzes %)'
      )
      AND "deleted_at" IS NULL;

    -- Also clean up empty modules in SBA
    UPDATE "modules" m
    SET "deleted_at" = now(), "updated_at" = now()
    WHERE m."course_id" = v_sba_id
      AND m."deleted_at" IS NULL
      AND (m."title" ILIKE '%Quizzes 01%' OR m."title" ILIKE '%Quizzes 11%' OR m."title" ILIKE '%Quizzes 21%' OR m."title" ILIKE '%Quizzes 31%')
      AND NOT EXISTS (
        SELECT 1 FROM "lessons" l WHERE l."module_id" = m."id" AND l."deleted_at" IS NULL
      );
  END IF;

  -- 8. Refresh updated timestamps
  UPDATE "courses" SET "updated_at" = now() WHERE "id" IN (v_primary_id, v_sba_id);

  RAISE NOTICE 'SUCCESS: All 41 Primary Quizzes moved to MRCEM Primary course.';
END $$;
