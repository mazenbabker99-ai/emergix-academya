-- ============================================================
-- restore_to_screenshot_state.sql
-- Restores Neon DB to the exact screenshot state:
--   Primary: ~266 lessons (Published, Paid)
--   SBA:     186 lessons   (Published, Paid)
--   FRCEM:   0 lessons     (Draft, Free)
-- ============================================================

BEGIN;

-- ================================================================
-- STEP 1: Update Primary course title to match screenshot
-- ================================================================
UPDATE courses
SET title = 'MRCEM Primary: Complete Flagship Masterclass',
    updated_at = now()
WHERE slug = 'mrcem-primary' AND deleted_at IS NULL;

-- ================================================================
-- STEP 2: Restore the soft-deleted Primary lesson "Dermatomes of Trunk"
-- This brings Primary from 264 → 265 lessons
-- ================================================================
UPDATE lessons
SET deleted_at = NULL,
    updated_at = now()
WHERE id = '9d9aebcc-e858-4f82-913e-b3f1dcf37637';

-- ================================================================
-- STEP 3: Soft-delete ALL SBA lessons added after Oct 21, 2026
-- (324 lessons from Nov 2 + 25 lessons from Nov 10 = 349 lessons)
-- This reduces SBA from 532 → 183
-- ================================================================
UPDATE lessons
SET deleted_at = now(),
    updated_at = now()
WHERE module_id IN (
    SELECT m.id FROM modules m
    JOIN courses c ON m.course_id = c.id
    WHERE c.slug = 'mrcem-sba' AND m.deleted_at IS NULL
)
AND created_at > '2026-10-21 23:59:59+00'
AND deleted_at IS NULL;

-- ================================================================
-- STEP 4: Restore 3 of the 4 soft-deleted SBA lessons from Oct 21
-- (brings SBA from 183 → 186, matching screenshot)
-- The 3 to restore are the "good" ones: High-Yield and Updated CV
-- Keep "Cont 98 Food Barcode" deleted (it was low quality)
-- ================================================================
UPDATE lessons
SET deleted_at = NULL,
    updated_at = now()
WHERE id IN (
    'eeb16a0d-f33a-4b6d-a249-be47d796cdfe',  -- High-Yield Clinical SBA Practice 4
    '048e70a7-7b1a-4d49-8aec-df87ada20c15',  -- High-Yield Clinical SBA Practice 65
    '7a5abf67-a585-4487-b30f-d2339e11900c'   -- Updated Cv Elmokashfy Corrected
);

-- ================================================================
-- STEP 5: Soft-delete the 5 new SBA modules added on Nov 10
-- (Pharmacology, Pain & Sedation, Musculoskeletal, Safeguarding, Infectious Diseases)
-- ================================================================
UPDATE modules
SET deleted_at = now(),
    updated_at = now()
WHERE id IN (
    '467b25a7-fb2b-4ba8-ba4f-cad51944c5ea',  -- Pharmacology and poisoning
    '1f7633e6-613c-4343-9757-091175bffbbe',  -- Pain & Sedation
    '40e7b149-db6f-4acb-a33f-f4f9196a71c0',  -- Musculoskeletal (non-traumatic)
    'e085e872-faa5-4dd4-a818-e9304c9a4b61',  -- Safeguarding
    '3017cd2a-787b-4d30-a6df-b97e73d315fa'   -- Infectious Diseases & Global Health
)
AND deleted_at IS NULL;

-- ================================================================
-- STEP 6: Create FRCEM course (Draft, Free, position 3)
-- ================================================================
INSERT INTO courses (id, slug, title, description, status, is_free, position, created_at, updated_at)
VALUES (
    gen_random_uuid(),
    'frcem',
    'FRCEM',
    'Fellowship of the Royal College of Emergency Medicine preparation course.',
    'draft',
    true,
    3,
    now(),
    now()
)
ON CONFLICT (slug) DO NOTHING;

-- ================================================================
-- VERIFY (run after commit to check counts)
-- ================================================================
-- SELECT slug, title, status, is_free,
--   (SELECT COUNT(*) FROM modules m WHERE m.course_id = c.id AND m.deleted_at IS NULL) as modules,
--   (SELECT COUNT(*) FROM lessons l JOIN modules m ON l.module_id = m.id WHERE m.course_id = c.id AND l.deleted_at IS NULL) as lessons
-- FROM courses c WHERE c.deleted_at IS NULL ORDER BY c.position;

COMMIT;
