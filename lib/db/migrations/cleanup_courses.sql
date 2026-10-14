-- Cleanup: Keep ONLY the two flagship courses: 'mrcem-primary' and 'mrcem-sba'
UPDATE "courses"
SET "status" = 'archived', "deleted_at" = now()
WHERE "slug" NOT IN ('mrcem-primary', 'mrcem-sba') AND "deleted_at" IS NULL;
