-- ==========================================================================
-- CLEANUP SCRIPT: Keep only the TWO Flagship Courses (MRCEM Primary & MRCEM SBA)
-- ==========================================================================

-- 1. Ensure MRCEM PRIMARY is Course 1
UPDATE "courses"
SET 
  "title" = 'MRCEM PRIMARY',
  "position" = 1,
  "status" = 'published',
  "deleted_at" = NULL,
  "updated_at" = now()
WHERE "slug" = 'mrcem-primary';

-- 2. Ensure MRCEM SBA is Course 2
UPDATE "courses"
SET 
  "title" = 'MRCEM SBA',
  "position" = 2,
  "status" = 'published',
  "deleted_at" = NULL,
  "updated_at" = now()
WHERE "slug" = 'mrcem-sba';

-- 3. Archive redundant sub-courses so only the two flagship tracks appear
UPDATE "courses"
SET 
  "status" = 'archived', 
  "deleted_at" = now(), 
  "updated_at" = now()
WHERE "slug" IN (
  'mrcem-anatomy',
  'mrcem-physiology',
  'mrcem-pharmacology',
  'mrcem-pathology-micro',
  'mrcem-upper-limb'
);

-- 4. Archive any other test courses
UPDATE "courses"
SET 
  "status" = 'archived', 
  "deleted_at" = now(), 
  "updated_at" = now()
WHERE "slug" NOT IN ('mrcem-primary', 'mrcem-sba') AND "deleted_at" IS NULL;
