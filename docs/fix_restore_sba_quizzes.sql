-- ============================================================================
-- FIX: Restore missing SBA quizzes from soft-deleted modules
-- ============================================================================
-- SAFETY: Creates backup first. Run DIAGNOSE_MISSING_QUIZZES.sql first.
-- Run on: psql "$DATABASE_URL" -f fix_restore_sba_quizzes.sql
-- ============================================================================

BEGIN;

-- Step 0: Backup
CREATE TABLE IF NOT EXISTS modules_backup_quiz_fix AS SELECT * FROM modules;
CREATE TABLE IF NOT EXISTS lessons_backup_quiz_fix AS SELECT * FROM lessons;

\echo 'Backups created: modules_backup_quiz_fix, lessons_backup_quiz_fix'

-- ============================================================================
-- SCENARIO A: Quiz lessons are in SOFT-DELETED modules inside mrcem-sba
-- Fix: Restore those deleted modules (undelete them)
-- ============================================================================

-- Find how many orphaned quizzes exist
DO $$
DECLARE
  v_orphan_count integer;
  v_sba_course_id uuid;
BEGIN
  SELECT id INTO v_sba_course_id FROM courses WHERE slug = 'mrcem-sba' LIMIT 1;

  SELECT count(*) INTO v_orphan_count
  FROM lessons l
  JOIN modules m ON m.id = l.module_id
  WHERE l.type = 'quiz'
    AND l.status = 'published'
    AND l.deleted_at IS NULL
    AND m.deleted_at IS NOT NULL
    AND m.course_id = v_sba_course_id;

  RAISE NOTICE 'Orphaned quizzes found in soft-deleted SBA modules: %', v_orphan_count;

  IF v_orphan_count > 0 THEN
    -- Restore all soft-deleted modules in mrcem-sba that contain live quizzes
    UPDATE modules
    SET deleted_at = NULL, updated_at = now()
    WHERE course_id = v_sba_course_id
      AND deleted_at IS NOT NULL
      AND id IN (
        SELECT DISTINCT l.module_id
        FROM lessons l
        WHERE l.type = 'quiz'
          AND l.status = 'published'
          AND l.deleted_at IS NULL
      );

    GET DIAGNOSTICS v_orphan_count = ROW_COUNT;
    RAISE NOTICE 'Restored % soft-deleted modules', v_orphan_count;
  ELSE
    RAISE NOTICE 'No orphaned quizzes in soft-deleted SBA modules.';
  END IF;
END $$;

-- ============================================================================
-- SCENARIO B: Quizzes are in modules with position=0 (all same position)
-- Fix: Re-number module positions based on creation order
-- ============================================================================

DO $$
DECLARE
  v_sba_course_id uuid;
  v_dup_count integer;
BEGIN
  SELECT id INTO v_sba_course_id FROM courses WHERE slug = 'mrcem-sba' LIMIT 1;

  -- Check if multiple modules share the same position
  SELECT count(*) INTO v_dup_count
  FROM (
    SELECT position, count(*) as cnt
    FROM modules
    WHERE course_id = v_sba_course_id AND deleted_at IS NULL
    GROUP BY position
    HAVING count(*) > 1
  ) t;

  IF v_dup_count > 0 THEN
    RAISE NOTICE 'Found % duplicate positions in SBA modules. Re-numbering...', v_dup_count;

    -- Re-number positions in creation order
    WITH ordered AS (
      SELECT id,
             row_number() OVER (ORDER BY created_at, title) - 1 AS new_pos
      FROM modules
      WHERE course_id = v_sba_course_id AND deleted_at IS NULL
    )
    UPDATE modules m
    SET position = o.new_pos, updated_at = now()
    FROM ordered o
    WHERE m.id = o.id;

    RAISE NOTICE 'Module positions re-numbered successfully.';
  ELSE
    RAISE NOTICE 'No duplicate module positions. Positions are OK.';
  END IF;
END $$;

-- ============================================================================
-- SCENARIO C: Quizzes are in mrcem-primary modules that were incorrectly
--             left inside mrcem-sba (or vice versa)
-- Fix: Move primary-quiz-* back to mrcem-primary, sba-quiz-* to mrcem-sba
-- ============================================================================

DO $$
DECLARE
  v_primary_id uuid;
  v_sba_id uuid;
  v_target_module_id uuid;
  v_moved integer;
BEGIN
  SELECT id INTO v_primary_id FROM courses WHERE slug = 'mrcem-primary' LIMIT 1;
  SELECT id INTO v_sba_id     FROM courses WHERE slug = 'mrcem-sba'     LIMIT 1;

  -- Find primary quizzes stranded in SBA modules
  SELECT count(*) INTO v_moved
  FROM lessons l
  JOIN modules m ON m.id = l.module_id
  WHERE l.type = 'quiz'
    AND l.slug LIKE 'primary-quiz-%'
    AND m.course_id = v_sba_id
    AND l.deleted_at IS NULL
    AND m.deleted_at IS NULL;

  IF v_moved > 0 THEN
    RAISE NOTICE 'Found % primary-quiz-* lessons misplaced in mrcem-sba. Moving them.', v_moved;

    -- Find or create a "Misplaced Primary Quizzes" holding module in mrcem-primary
    SELECT id INTO v_target_module_id
    FROM modules
    WHERE course_id = v_primary_id
      AND title = 'High-Yield SBA Quizzes: Part 1 (Quizzes 01 - 10)'
      AND deleted_at IS NULL
    LIMIT 1;

    IF v_target_module_id IS NULL THEN
      -- Use the first active module in mrcem-primary
      SELECT id INTO v_target_module_id
      FROM modules
      WHERE course_id = v_primary_id AND deleted_at IS NULL
      ORDER BY position
      LIMIT 1;
    END IF;

    IF v_target_module_id IS NOT NULL THEN
      UPDATE lessons
      SET module_id = v_target_module_id, updated_at = now()
      FROM modules m
      WHERE lessons.module_id = m.id
        AND lessons.type = 'quiz'
        AND lessons.slug LIKE 'primary-quiz-%'
        AND m.course_id = v_sba_id
        AND lessons.deleted_at IS NULL;

      RAISE NOTICE 'Moved primary quizzes to mrcem-primary module: %', v_target_module_id;
    ELSE
      RAISE NOTICE 'WARNING: No target module found in mrcem-primary!';
    END IF;
  ELSE
    RAISE NOTICE 'No misplaced primary quizzes found.';
  END IF;
END $$;

-- ============================================================================
-- VERIFICATION
-- ============================================================================

\echo ''
\echo '=== POST-FIX VERIFICATION ==='

SELECT c.slug,
       count(l.id) FILTER (WHERE l.type='quiz' AND l.status='published' AND l.deleted_at IS NULL) as quizzes,
       count(l.id) FILTER (WHERE l.type='article' AND l.status='published' AND l.deleted_at IS NULL) as articles
FROM courses c
JOIN modules m ON m.course_id = c.id AND m.deleted_at IS NULL
JOIN lessons l ON l.module_id = m.id
WHERE c.slug IN ('mrcem-primary', 'mrcem-sba')
GROUP BY c.slug;

\echo ''
\echo 'Total orphaned quizzes remaining:'
SELECT count(*)
FROM lessons l
JOIN modules m ON m.id = l.module_id
WHERE l.type = 'quiz'
  AND l.status = 'published'
  AND l.deleted_at IS NULL
  AND m.deleted_at IS NOT NULL;

COMMIT;
