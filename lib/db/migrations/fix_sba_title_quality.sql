-- ==========================================================================
-- FIX: Title quality improvements & structural cleanup
-- ==========================================================================
-- 1. Major Trauma: fix low-quality article titles
-- 2. Gastroenterology: remove duplicate Acute Appendicitis, rename "GE"
-- 3. MAXILLOFACIAL TRAUMA: fix position conflict (pos 9 -> pos 11)
-- ==========================================================================

DO $$
DECLARE
  v_fixed INTEGER := 0;
BEGIN

  -- =========================================================================
  -- FIX 1A: "Renal Ca vs Bladder Ca" -> "Renal & Bladder Malignancies"
  -- =========================================================================
  UPDATE "lessons"
    SET "title" = 'Renal & Bladder Malignancies', "updated_at" = now()
    WHERE "id" = '229b26b3-bec5-48a3-9853-7d7762722c4f'
      AND "deleted_at" IS NULL;
  GET DIAGNOSTICS v_fixed = ROW_COUNT;
  RAISE NOTICE 'Fix 1A: Renamed % "Renal Ca vs Bladder Ca" lesson(s)', v_fixed;

  -- =========================================================================
  -- FIX 1B: "Laryngotracheal trauma" -> "Laryngotracheal Injury & Airway Trauma"
  -- =========================================================================
  UPDATE "lessons"
    SET "title" = 'Laryngotracheal Injury & Airway Trauma', "updated_at" = now()
    WHERE "id" = 'f20ad1cf-d1e5-4a42-9c4e-88cc7c6f764e'
      AND "deleted_at" IS NULL;
  GET DIAGNOSTICS v_fixed = ROW_COUNT;
  RAISE NOTICE 'Fix 1B: Renamed % "Laryngotracheal trauma" lesson(s)', v_fixed;

  -- =========================================================================
  -- FIX 1C: "Spinal Cord" -> "Spinal Cord Injury & Incomplete Syndromes"
  -- =========================================================================
  UPDATE "lessons"
    SET "title" = 'Spinal Cord Injury & Incomplete Syndromes', "updated_at" = now()
    WHERE "id" = 'f86abad8-2572-4b86-bce3-2ff3fe77f8d2'
      AND "deleted_at" IS NULL;
  GET DIAGNOSTICS v_fixed = ROW_COUNT;
  RAISE NOTICE 'Fix 1C: Renamed % "Spinal Cord" lesson(s)', v_fixed;

  -- =========================================================================
  -- FIX 2A: Soft-delete duplicate "Acute Appendicitis" (728f6999 - seeder copy)
  --          Keep: 64ebac11 (original user lesson)
  -- =========================================================================
  UPDATE "lessons"
    SET "deleted_at" = now(), "updated_at" = now()
    WHERE "id" = '728f6999-0366-4d49-a11b-da01bbd1e2de'
      AND "deleted_at" IS NULL;
  GET DIAGNOSTICS v_fixed = ROW_COUNT;
  RAISE NOTICE 'Fix 2A: Soft-deleted % duplicate "Acute Appendicitis" lesson(s)', v_fixed;

  -- =========================================================================
  -- FIX 2B: "GE" -> "Acute Gastroenteritis & Dehydration"
  -- =========================================================================
  UPDATE "lessons"
    SET "title" = 'Acute Gastroenteritis & Dehydration', "updated_at" = now()
    WHERE "id" = '634368ec-d63c-48e5-aa5f-1ccfa930e6c5'
      AND "deleted_at" IS NULL;
  GET DIAGNOSTICS v_fixed = ROW_COUNT;
  RAISE NOTICE 'Fix 2B: Renamed % "GE" lesson(s) to "Acute Gastroenteritis & Dehydration"', v_fixed;

  -- =========================================================================
  -- FIX 3: MAXILLOFACIAL TRAUMA position conflict (pos 9 -> pos 11)
  --         High-Yield Rapid Clinical Revision stays at pos 9
  -- =========================================================================
  UPDATE "modules"
    SET "position" = 11, "updated_at" = now()
    WHERE "id" = '4f767f5a-63f0-4cad-9bd1-9e896111a4e5'
      AND "deleted_at" IS NULL;
  GET DIAGNOSTICS v_fixed = ROW_COUNT;
  RAISE NOTICE 'Fix 3: Moved % MAXILLOFACIAL TRAUMA module(s) to position 11', v_fixed;

  RAISE NOTICE 'All title quality fixes applied successfully.';
END $$;
