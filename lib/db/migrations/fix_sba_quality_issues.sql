-- ==========================================================================
-- FIX: SBA Course Quality Issues
-- ==========================================================================
-- 1. Fix Infectious Diseases & Global Health position (47 -> 15)
-- 2. Fix Child Abuse title capitalisation
-- 3. Remove duplicate Digital Block lesson (keep Digital Nerve Block)
-- 4. Fix duplicate FGM lesson (keep the more detailed one)
-- ==========================================================================

DO $$
DECLARE
  v_fixed INTEGER := 0;
BEGIN

  -- =========================================================================
  -- FIX 1: Infectious Diseases & Global Health position 47 -> 15
  -- Fix in ALL courses where this module has wrong position
  -- =========================================================================
  UPDATE "modules"
    SET "position" = 15, "updated_at" = now()
    WHERE "title" = 'Infectious Diseases & Global Health'
      AND "position" != 15
      AND "deleted_at" IS NULL;

  GET DIAGNOSTICS v_fixed = ROW_COUNT;
  RAISE NOTICE 'Fix 1: Updated % Infectious Diseases module(s) position to 15', v_fixed;

  -- =========================================================================
  -- FIX 2: Child abuse -> Child Abuse (capitalisation)
  -- =========================================================================
  UPDATE "lessons"
    SET "title" = 'Child Abuse', "updated_at" = now()
    WHERE "title" = 'Child abuse'
      AND "deleted_at" IS NULL;

  GET DIAGNOSTICS v_fixed = ROW_COUNT;
  RAISE NOTICE 'Fix 2: Fixed % "Child Abuse" title(s)', v_fixed;

  -- =========================================================================
  -- FIX 3: Remove "Digital Block" duplicate (keep "Digital Nerve Block Technique & Anaesthesia")
  -- Soft-delete only the short "Digital Block" title
  -- =========================================================================
  UPDATE "lessons"
    SET "deleted_at" = now(), "updated_at" = now()
    WHERE "title" = 'Digital Block'
      AND "deleted_at" IS NULL
      AND "module_id" IN (
        SELECT "id" FROM "modules"
        WHERE "title" = 'Pain & Sedation' AND "deleted_at" IS NULL
      );

  GET DIAGNOSTICS v_fixed = ROW_COUNT;
  RAISE NOTICE 'Fix 3: Soft-deleted % duplicate "Digital Block" lesson(s)', v_fixed;

  -- =========================================================================
  -- FIX 4: Remove short "Female Genital Mutilation" duplicate
  -- Keep "Female Genital Mutilation (FGM) Management & Legal Duty" (more detailed)
  -- =========================================================================
  UPDATE "lessons"
    SET "deleted_at" = now(), "updated_at" = now()
    WHERE "title" = 'Female Genital Mutilation'
      AND "deleted_at" IS NULL
      AND "module_id" IN (
        SELECT "id" FROM "modules"
        WHERE "title" LIKE 'Safeguarding%' AND "deleted_at" IS NULL
      )
      AND "module_id" IN (
        -- Only remove where the detailed version ALSO exists
        SELECT DISTINCT l2."module_id"
        FROM "lessons" l2
        WHERE l2."title" = 'Female Genital Mutilation (FGM) Management & Legal Duty'
          AND l2."deleted_at" IS NULL
      );

  GET DIAGNOSTICS v_fixed = ROW_COUNT;
  RAISE NOTICE 'Fix 4: Soft-deleted % duplicate "Female Genital Mutilation" lesson(s)', v_fixed;

  RAISE NOTICE 'All quality fixes applied successfully.';
END $$;
