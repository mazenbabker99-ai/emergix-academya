-- ==========================================================================
-- FIX: Remove duplicate Modules & correct Infectious Diseases position
-- ==========================================================================
-- Shadow course 4c794261 has:
--   * Vascular Emergencies x2: dcd783c9 (pos 8, 82 lessons) vs 7d06da21 (pos 10, 8 lessons)
--   * MRCEM SBA Mock Simulations x2: 9b8941e0 (pos 4, broken titles) vs 5bacd90d (pos 10, correct)
--   * Infectious Diseases at pos 47 -> fix to 19 (pos 15 taken by Allergy)
-- ==========================================================================

DO $$
DECLARE
  v_fixed INTEGER := 0;
BEGIN

  -- =========================================================================
  -- FIX 1: Soft-delete duplicate Vascular Emergencies (smaller one, pos 10)
  --         KEEP: dcd783c9 (pos 8, 82 lessons)
  --         DELETE: 7d06da21 (pos 10, 8 lessons - duplicate)
  -- =========================================================================
  UPDATE "modules"
    SET "deleted_at" = now(), "updated_at" = now()
    WHERE "id" = '7d06da21-b32e-4946-82b3-3ea2c69d5346'
      AND "deleted_at" IS NULL;

  GET DIAGNOSTICS v_fixed = ROW_COUNT;
  RAISE NOTICE 'Fix 1: Soft-deleted % duplicate Vascular Emergencies module(s) [7d06da21, pos 10]', v_fixed;

  -- =========================================================================
  -- FIX 2: Soft-delete broken Mock Simulations (pos 4, "Mock ? I" encoding)
  --         KEEP: 5bacd90d (pos 10, "Mock 1 - Paper 1" correct titles)
  --         DELETE: 9b8941e0 (pos 4, broken character encoding)
  -- =========================================================================
  UPDATE "modules"
    SET "deleted_at" = now(), "updated_at" = now()
    WHERE "id" = '9b8941e0-cdf7-4e3c-958b-a1c6b225a8bd'
      AND "deleted_at" IS NULL;

  GET DIAGNOSTICS v_fixed = ROW_COUNT;
  RAISE NOTICE 'Fix 2: Soft-deleted % broken Mock Simulations module(s) [9b8941e0, pos 4]', v_fixed;

  -- =========================================================================
  -- FIX 3: Infectious Diseases & Global Health - correct position
  --         pos 47 -> pos 19 (pos 15 occupied by Allergy in shadow course)
  --         Also fix the specific module ID in shadow course
  -- =========================================================================
  UPDATE "modules"
    SET "position" = 19, "updated_at" = now()
    WHERE "id" = '0086654b-4da1-434f-990b-4776e6c0a7a4'
      AND "deleted_at" IS NULL;

  GET DIAGNOSTICS v_fixed = ROW_COUNT;
  RAISE NOTICE 'Fix 3: Updated % Infectious Diseases module position to 19 [0086654b]', v_fixed;

  -- Also fix in real course (3017cd2a) - keep at 15, no Allergy conflict there
  -- Real course already has correct position from earlier migration, no change needed

  RAISE NOTICE 'All duplicate module fixes applied successfully.';
END $$;
