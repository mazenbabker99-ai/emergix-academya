-- ============================================================================
-- Emergix Academy — Phase 2 Data Migration
-- Generated: 2026-11-02
-- Purpose: Fix title typos, garbled characters in lesson bodies
-- Safety: All changes are idempotent. Run on DEVELOPMENT DB only.
-- ============================================================================

-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║ STEP 0: BACKUPS                                                        ║
-- ╚══════════════════════════════════════════════════════════════════════════╝

-- Back up lessons table before any changes
CREATE TABLE IF NOT EXISTS lessons_backup_20261102 AS SELECT * FROM lessons;

-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║ STEP 1: FIX TITLE TYPOS                                                ║
-- ║ Rule: Do NOT change slugs (safety rule #4)                             ║
-- ╚══════════════════════════════════════════════════════════════════════════╝

-- Fix 1: "Chocking Andult and Pedio" -> "Choking in Adults and Paediatrics"
UPDATE lessons SET title = 'Choking in Adults and Paediatrics'
WHERE title LIKE '%Chocking%Andult%Pedio%'
  AND title != 'Choking in Adults and Paediatrics';

-- Fix 2: "Acute Glucoma" -> "Acute Glaucoma" 
UPDATE lessons SET title = replace(title, 'Glucoma', 'Glaucoma')
WHERE title LIKE '%Glucoma%';

-- Fix 3: "Head Reauma" -> "Head Trauma"
UPDATE lessons SET title = replace(title, 'Reauma', 'Trauma')
WHERE title LIKE '%Reauma%';

-- Fix 4: "Mangement" -> "Management" (any title containing this typo)
UPDATE lessons SET title = replace(title, 'Mangement', 'Management')
WHERE title LIKE '%Mangement%';

-- Fix 5: "Transfution" -> "Transfusion"
UPDATE lessons SET title = replace(title, 'Transfution', 'Transfusion')
WHERE title LIKE '%Transfution%';

-- Fix 6: "Anduilt" -> variant of Andult (catch any remaining)
UPDATE lessons SET title = replace(title, 'Anduilt', 'Adult')
WHERE title LIKE '%Anduilt%';

-- Fix 7: " Hge" at end of title -> " Haemorrhage"
UPDATE lessons SET title = replace(title, ' Hge', ' Haemorrhage')
WHERE title LIKE '% Hge' OR title LIKE '% Hge %';

-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║ STEP 2: FIX GARBLED CHARACTERS IN LESSON BODIES                        ║
-- ║ Rule: Only fix formatting. Clinical content -> NEEDS HUMAN REVIEW      ║
-- ╚══════════════════════════════════════════════════════════════════════════╝

-- Fix garbled "grouæ(ALSC)" -> "group (ALSG)" — known OCR error
UPDATE lessons SET body = replace(body, 'grouæ(ALSC)', 'group (ALSG)')
WHERE body LIKE '%grouæ(ALSC)%';

-- Fix garbled ae-ligature (æ) — common OCR artifacts
-- These are case-by-case fixes for known garbled text:

-- "Deeæpartial" -> "Deep partial" (burn-injury lesson)
UPDATE lessons SET body = replace(body, 'Deeæpartial', 'Deep partial')
WHERE slug = 'burn-injury' AND body LIKE '%Deeæpartial%';

-- "ætension pneumothorax" -> "tension pneumothorax" (thoracic-trauma lesson)
UPDATE lessons SET body = replace(body, 'ætension pneumothora', 'tension pneumothora')
WHERE slug = 'throacic-trauma-life-threatining-injury' AND body LIKE '%ætension pneumothora%';

-- "Hypoproteinæmia" -> "Hypoproteinaemia" (expert-clinical-sba-mock-3)
UPDATE lessons SET body = replace(body, 'Hypoproteinæmia', 'Hypoproteinaemia')
WHERE slug = 'expert-clinical-sba-mock-3' AND body LIKE '%Hypoproteinæmia%';

-- "Hætth" -> "Health" (head trauma lesson)
UPDATE lessons SET body = replace(body, 'Hætth', 'Health')
WHERE slug = 'head-reauma' AND body LIKE '%Hætth%';

-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║ STEP 3: FIX COMMON FORMATTING ISSUES                                   ║
-- ╚══════════════════════════════════════════════════════════════════════════╝

-- Fix "previOUS" -> "previous" (OCR artifact where "Previous Next" UI text leaked)
UPDATE lessons SET body = replace(body, 'previOUS', 'previous')
WHERE body LIKE '%previOUS%';

-- Remove leaked UI text patterns: "Previous Next" at end of content  
UPDATE lessons SET body = regexp_replace(body, '\s*Previous\s+Next\s*$', '', 'g')
WHERE body ~ '\s*Previous\s+Next\s*$';

-- Remove leaked "(Page N Reference)" captions
UPDATE lessons SET body = regexp_replace(body, '\(Page \d+ Reference\)', '', 'g')
WHERE body LIKE '%(Page % Reference)%';

-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║ STEP 4: VERIFY FIXES                                                   ║
-- ╚══════════════════════════════════════════════════════════════════════════╝

-- Count remaining issues after fixes
SELECT 'Remaining garbled ae chars' AS check_name, 
       count(*) AS count 
FROM lessons WHERE body LIKE '%æ%' AND deleted_at IS NULL;

SELECT 'Remaining title typos' AS check_name,
       count(*) AS count
FROM lessons WHERE (
  title LIKE '%Mangement%' OR 
  title LIKE '%Chocking%' OR 
  title LIKE '%Glucoma%' OR 
  title LIKE '%Reauma%' OR
  title LIKE '%Transfution%'
) AND deleted_at IS NULL;

SELECT 'Remaining previOUS' AS check_name,
       count(*) AS count
FROM lessons WHERE body LIKE '%previOUS%' AND deleted_at IS NULL;

-- Show backup row count for verification
SELECT 'Backup row count' AS info, count(*) FROM lessons_backup_20261102;
SELECT 'Current row count' AS info, count(*) FROM lessons;
