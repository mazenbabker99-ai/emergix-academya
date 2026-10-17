-- ==========================================================================
-- CLEANUP SCRIPT: Keep all 5 Master Curriculum Courses + SBA Question Bank
-- ==========================================================================
UPDATE "courses"
SET "status" = 'published', "deleted_at" = NULL
WHERE "slug" IN (
  'mrcem-primary',
  'mrcem-anatomy',
  'mrcem-physiology',
  'mrcem-pharmacology',
  'mrcem-pathology-micro',
  'mrcem-sba'
);

-- Archive any old test or legacy courses
UPDATE "courses"
SET "status" = 'archived', "deleted_at" = now()
WHERE "slug" NOT IN (
  'mrcem-primary',
  'mrcem-anatomy',
  'mrcem-physiology',
  'mrcem-pharmacology',
  'mrcem-pathology-micro',
  'mrcem-sba'
) AND "deleted_at" IS NULL;
