-- ==========================================================================
-- FIX: Deduplicate mrcem-sba courses
-- ==========================================================================
-- BACKGROUND:
--   The autoMigration seeder created a shadow course (4c794261) by running
--   SELECT id FROM courses WHERE slug='mrcem-sba' LIMIT 1 on a fresh Replit
--   restart when the REAL course (583e83a1) already existed.
--   The real course 583e83a1 has 536+ lessons + all user customizations.
--   The shadow 4c794261 has incomplete/duplicate data inserted by the seeder.
--
-- STRATEGY (NON-DESTRUCTIVE):
--   1. Move any UNIQUE modules from shadow -> real (that don't exist in real)
--   2. For modules that exist in both: soft-delete the shadow duplicates
--   3. Soft-delete the shadow course itself (deleted_at = now())
--   4. Leave real course 583e83a1 completely intact
-- ==========================================================================

DO $$
DECLARE
  v_real_course_id   uuid := '583e83a1-b45d-463b-ad53-4e0e3af8cf3a';
  v_shadow_course_id uuid := '4c794261-4f8e-4de7-8f77-b1bf8592154d';
  v_shadow_exists    boolean;
  v_moved_modules    integer := 0;
  v_deleted_modules  integer := 0;
  rec                record;
BEGIN
  -- Check if shadow course exists at all (may have been cleaned up already)
  SELECT EXISTS(
    SELECT 1 FROM "courses" WHERE "id" = v_shadow_course_id
  ) INTO v_shadow_exists;

  IF NOT v_shadow_exists THEN
    RAISE NOTICE 'Shadow course % does not exist - nothing to deduplicate.', v_shadow_course_id;
    RETURN;
  END IF;

  RAISE NOTICE 'Starting deduplication: real=%, shadow=%', v_real_course_id, v_shadow_course_id;

  -- Step 1: For each module in shadow course, check if real course has same title
  FOR rec IN
    SELECT sm.id as shadow_module_id, sm.title as module_title
    FROM "modules" sm
    WHERE sm."course_id" = v_shadow_course_id
      AND sm."deleted_at" IS NULL
  LOOP
    IF EXISTS (
      SELECT 1 FROM "modules" rm
      WHERE rm."course_id" = v_real_course_id
        AND rm."title" = rec.module_title
        AND rm."deleted_at" IS NULL
    ) THEN
      -- Duplicate: real course already has this module -> soft-delete shadow version
      UPDATE "modules"
        SET "deleted_at" = now(), "updated_at" = now()
        WHERE "id" = rec.shadow_module_id;
      v_deleted_modules := v_deleted_modules + 1;
      RAISE NOTICE '  Soft-deleted duplicate shadow module: % (id %)', rec.module_title, rec.shadow_module_id;
    ELSE
      -- Unique: move shadow module to real course
      UPDATE "modules"
        SET "course_id" = v_real_course_id, "updated_at" = now()
        WHERE "id" = rec.shadow_module_id;
      v_moved_modules := v_moved_modules + 1;
      RAISE NOTICE '  Moved unique module to real course: % (id %)', rec.module_title, rec.shadow_module_id;
    END IF;
  END LOOP;

  -- Step 2: Soft-delete the shadow course itself
  UPDATE "courses"
    SET "deleted_at" = now(), "updated_at" = now()
    WHERE "id" = v_shadow_course_id;

  RAISE NOTICE 'Deduplication complete: moved % modules, soft-deleted % duplicate modules. Shadow course soft-deleted.',
    v_moved_modules, v_deleted_modules;
  RAISE NOTICE 'Real course % is now the sole active mrcem-sba course.', v_real_course_id;
END $$;
