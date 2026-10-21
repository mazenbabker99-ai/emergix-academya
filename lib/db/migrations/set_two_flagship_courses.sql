-- ==========================================================================
-- MIGRATION: Set the Two Flagship Courses & Pricing Plans
-- (MRCEM PRIMARY: $99 - $199 & MRCEM SBA: $149 - $249)
-- ==========================================================================

-- 1. Ensure MRCEM PRIMARY is Course 1
UPDATE "courses"
SET 
  "title" = 'MRCEM PRIMARY',
  "slug" = 'mrcem-primary',
  "summary" = 'Comprehensive basic sciences masterclass covering clinical anatomy, applied physiology, emergency pharmacology, pathology, and microbiology.',
  "description" = 'The premier flagship preparation course for the Royal College of Emergency Medicine (RCEM) Primary examination. Features all 21 core curriculum modules, 221 detailed lecture notes, 269 embedded anatomical and clinical figures, and interactive topic knowledge checks.',
  "position" = 1,
  "status" = 'published',
  "is_free" = false,
  "deleted_at" = NULL,
  "updated_at" = now()
WHERE "slug" = 'mrcem-primary';

-- 2. Ensure MRCEM SBA is Course 2
UPDATE "courses"
SET 
  "title" = 'MRCEM SBA',
  "slug" = 'mrcem-sba',
  "summary" = 'Dedicated single best answer (SBA) question bank & timed mock simulations with comprehensive clinical explanations.',
  "description" = 'The flagship SBA masterclass for the Royal College of Emergency Medicine examination. Features 41 topical question bank quizzes, timed full-length mock simulation papers, interactive distractor strikethrough, and high-yield clinical teaching pearls.',
  "position" = 2,
  "status" = 'published',
  "is_free" = false,
  "deleted_at" = NULL,
  "updated_at" = now()
WHERE "slug" = 'mrcem-sba';

-- 3. Archive redundant sub-curriculum courses so only the TWO flagship courses appear in the main catalogue
UPDATE "courses"
SET 
  "status" = 'archived',
  "deleted_at" = now(),
  "updated_at" = now()
WHERE "slug" IN (
  'mrcem-anatomy',
  'mrcem-physiology',
  'mrcem-pharmacology',
  'mrcem-pathology-micro'
);

-- 4. Upsert Flagship Pricing Plans
-- 4.1. Plan 1: MRCEM Primary Diet 1 ($99)
INSERT INTO "plans" (
  "id", "slug", "name", "description", "features", "access_months", "family_key", "family_name", "is_featured", "position", "status", "created_at", "updated_at"
) VALUES (
  'a1111111-1111-4111-a111-111111111111',
  'mrcem-primary-diet-1',
  'MRCEM PRIMARY - Diet 1 Pass',
  'Full access to all 21 basic science modules, 221 lessons, and 269 figures for Diet 1 exam preparation.',
  '["21 RCEM Basic Science Modules", "221 In-Depth Illustrated Notes", "269 Medical Figures & Anatomy Plates", "Topic Knowledge Checks", "3 Months Diet 1 Access", "WhatsApp Mentor Desk Support"]'::jsonb,
  3,
  'whatsapp-manual',
  'MRCEM PRIMARY',
  false,
  1,
  'published',
  now(),
  now()
) ON CONFLICT ("slug") DO UPDATE SET
  "name" = EXCLUDED."name",
  "description" = EXCLUDED."description",
  "features" = EXCLUDED."features",
  "access_months" = EXCLUDED."access_months",
  "status" = 'published',
  "updated_at" = now();

INSERT INTO "plan_prices" ("id", "plan_id", "currency", "region", "amount_minor", "created_at", "updated_at")
VALUES ('b1111111-1111-4111-b111-111111111111', 'a1111111-1111-4111-a111-111111111111', 'USD', 'ALL', 9900, now(), now())
ON CONFLICT ("plan_id", "currency", "region") DO UPDATE SET "amount_minor" = 9900, "updated_at" = now();

-- 4.2. Plan 2: MRCEM Primary Diet 2 / Full Pass ($199)
INSERT INTO "plans" (
  "id", "slug", "name", "description", "features", "access_months", "family_key", "family_name", "is_featured", "position", "status", "created_at", "updated_at"
) VALUES (
  'a2222222-2222-4222-a222-222222222222',
  'mrcem-primary-diet-2',
  'MRCEM PRIMARY - Diet 2 / Full Pass',
  'Extended 6-month access with Pass Guarantee, comprehensive basic science notes, and full tutor mentoring.',
  '["All 21 Curriculum Modules (Complete Masterclass)", "221 In-Depth Illustrated Notes", "269 Figures & Anatomical Plates", "6 Months Extended Access (Diet 2)", "Pass Guarantee & Tutor Mentorship on WhatsApp", "Mobile & Desktop Synced Progress"]'::jsonb,
  6,
  'whatsapp-manual',
  'MRCEM PRIMARY',
  true,
  2,
  'published',
  now(),
  now()
) ON CONFLICT ("slug") DO UPDATE SET
  "name" = EXCLUDED."name",
  "description" = EXCLUDED."description",
  "features" = EXCLUDED."features",
  "access_months" = EXCLUDED."access_months",
  "status" = 'published',
  "updated_at" = now();

INSERT INTO "plan_prices" ("id", "plan_id", "currency", "region", "amount_minor", "created_at", "updated_at")
VALUES ('b2222222-2222-4222-b222-222222222222', 'a2222222-2222-4222-a222-222222222222', 'USD', 'ALL', 19900, now(), now())
ON CONFLICT ("plan_id", "currency", "region") DO UPDATE SET "amount_minor" = 19900, "updated_at" = now();

-- 4.3. Plan 3: MRCEM SBA Diet 1 ($149)
INSERT INTO "plans" (
  "id", "slug", "name", "description", "features", "access_months", "family_key", "family_name", "is_featured", "position", "status", "created_at", "updated_at"
) VALUES (
  'a3333333-3333-4333-a333-333333333333',
  'mrcem-sba-diet-1',
  'MRCEM SBA - Diet 1 Pass',
  'Full single best answer question bank access with 41 topical quizzes and 6 full mock exams for Diet 1.',
  '["41 Topical SBA Question Banks", "6 Timed Mock Examination Papers", "Amboss/UWorld Test Engine with Strikethrough", "Comprehensive Clinical Explanations", "3 Months Diet 1 Access", "WhatsApp Mentor Support"]'::jsonb,
  3,
  'whatsapp-manual',
  'MRCEM SBA',
  false,
  3,
  'published',
  now(),
  now()
) ON CONFLICT ("slug") DO UPDATE SET
  "name" = EXCLUDED."name",
  "description" = EXCLUDED."description",
  "features" = EXCLUDED."features",
  "access_months" = EXCLUDED."access_months",
  "status" = 'published',
  "updated_at" = now();

INSERT INTO "plan_prices" ("id", "plan_id", "currency", "region", "amount_minor", "created_at", "updated_at")
VALUES ('b3333333-3333-4333-b333-333333333333', 'a3333333-3333-4333-a333-333333333333', 'USD', 'ALL', 14900, now(), now())
ON CONFLICT ("plan_id", "currency", "region") DO UPDATE SET "amount_minor" = 14900, "updated_at" = now();

-- 4.4. Plan 4: MRCEM SBA Diet 2 / Full Pass ($249)
INSERT INTO "plans" (
  "id", "slug", "name", "description", "features", "access_months", "family_key", "family_name", "is_featured", "position", "status", "created_at", "updated_at"
) VALUES (
  'a4444444-4444-4444-a444-444444444444',
  'mrcem-sba-diet-2',
  'MRCEM SBA - Diet 2 / Full Pass',
  'Extended 6-month access to the complete SBA Question Bank, timed mock simulations, and clinical rationale.',
  '["Complete 41 Topical SBA Quizzes", "All 6 Full-Length Mock Simulation Exams", "Amboss/UWorld Advanced Test Engine", "Detailed Rationales & RCEM Guidelines", "6 Months Extended Access (Diet 2)", "Dedicated WhatsApp Consultant Mentorship"]'::jsonb,
  6,
  'whatsapp-manual',
  'MRCEM SBA',
  true,
  4,
  'published',
  now(),
  now()
) ON CONFLICT ("slug") DO UPDATE SET
  "name" = EXCLUDED."name",
  "description" = EXCLUDED."description",
  "features" = EXCLUDED."features",
  "access_months" = EXCLUDED."access_months",
  "status" = 'published',
  "updated_at" = now();

INSERT INTO "plan_prices" ("id", "plan_id", "currency", "region", "amount_minor", "created_at", "updated_at")
VALUES ('b4444444-4444-4444-b444-444444444444', 'a4444444-4444-4444-a444-444444444444', 'USD', 'ALL', 24900, now(), now())
ON CONFLICT ("plan_id", "currency", "region") DO UPDATE SET "amount_minor" = 24900, "updated_at" = now();

-- 5. Link courses to plans
-- Link mrcem-primary to primary plans
INSERT INTO "plan_courses" ("id", "plan_id", "course_id", "created_at", "updated_at")
SELECT gen_random_uuid(), p.id, c.id, now(), now()
FROM "plans" p
CROSS JOIN "courses" c
WHERE p.slug IN ('mrcem-primary-diet-1', 'mrcem-primary-diet-2')
  AND c.slug = 'mrcem-primary'
ON CONFLICT ("plan_id", "course_id") DO NOTHING;

-- Link mrcem-sba to sba plans
INSERT INTO "plan_courses" ("id", "plan_id", "course_id", "created_at", "updated_at")
SELECT gen_random_uuid(), p.id, c.id, now(), now()
FROM "plans" p
CROSS JOIN "courses" c
WHERE p.slug IN ('mrcem-sba-diet-1', 'mrcem-sba-diet-2')
  AND c.slug = 'mrcem-sba'
ON CONFLICT ("plan_id", "course_id") DO NOTHING;

-- 6. Verify and report current published courses and plans
SELECT id, slug, title, position, status 
FROM "courses" 
WHERE "status" = 'published' AND "deleted_at" IS NULL 
ORDER BY "position" ASC, "title" ASC;

-- 7. Grant admin role to users so they have full access to both learner view and admin portal
UPDATE "users" SET "role" = 'admin' WHERE "role" = 'learner';
SELECT id, email, name, role FROM "users";
