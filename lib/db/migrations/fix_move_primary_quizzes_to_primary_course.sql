-- ==========================================================================
-- RELIABLE, DEDUPLICATING TRANSFER OF 41 PRIMARY QUIZZES
-- FROM SBA TO PRIMARY COURSE
--
-- Fixes: "duplicate key value violates unique constraint lessons_module_slug_uq"
--
-- Strategy:
-- 1. Locates Primary & SBA courses.
-- 2. Ensures exactly 4 Question Bank modules in Primary (positions 22, 23, 24, 25).
-- 3. For each quiz 1..41:
--    a. Finds the best "keeper" lesson (longest body).
--    b. Deletes any conflicting duplicate rows with the same target slug in the module.
--    c. Deletes any other candidate duplicate rows for this quiz across the DB.
--    d. Updates the keeper lesson to the target module, target slug, title, published status.
-- 4. Cleans up old quiz modules from SBA.
-- ==========================================================================
DO $$
DECLARE
  v_primary_id uuid;
  v_sba_id     uuid;

  v_mod1_id uuid;
  v_mod2_id uuid;
  v_mod3_id uuid;
  v_mod4_id uuid;

  v_target_mod uuid;
  v_quiz_num int;
  v_target_slug text;
  v_target_title text;
  v_keeper_id uuid;
  v_moved_count int := 0;
BEGIN
  -- 1. Identify Courses
  SELECT id INTO v_primary_id FROM "courses" WHERE "slug" = 'mrcem-primary' OR "id" = 'a32b4f45-b1a6-4c82-93c0-58e092e97a13' LIMIT 1;
  SELECT id INTO v_sba_id     FROM "courses" WHERE "slug" = 'mrcem-sba'     OR "id" = '4c794261-4f8e-4de7-8f77-b1bf8592154d' LIMIT 1;

  IF v_primary_id IS NULL THEN
    RAISE EXCEPTION 'Course mrcem-primary not found';
  END IF;

  -- 2. Ensure Primary Question Bank Modules exist in mrcem-primary
  -- Module 1: Quizzes 01-10
  SELECT id INTO v_mod1_id FROM "modules" 
  WHERE "course_id" = v_primary_id 
    AND ("title" ILIKE '%Question Bank%01%10%' OR "title" ILIKE '%Quizzes 01-10%' OR "title" ILIKE '%Quizzes 01 - 10%')
  ORDER BY "created_at" ASC LIMIT 1;

  IF v_mod1_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_primary_id, 'MRCEM Primary Question Bank: Quizzes 01-10', 22, now(), now())
    RETURNING "id" INTO v_mod1_id;
  ELSE
    UPDATE "modules" SET "title" = 'MRCEM Primary Question Bank: Quizzes 01-10', "position" = 22, "deleted_at" = NULL, "updated_at" = now() WHERE "id" = v_mod1_id;
  END IF;

  -- Module 2: Quizzes 11-20
  SELECT id INTO v_mod2_id FROM "modules" 
  WHERE "course_id" = v_primary_id 
    AND ("title" ILIKE '%Question Bank%11%20%' OR "title" ILIKE '%Quizzes 11-20%' OR "title" ILIKE '%Quizzes 11 - 20%')
  ORDER BY "created_at" ASC LIMIT 1;

  IF v_mod2_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_primary_id, 'MRCEM Primary Question Bank: Quizzes 11-20', 23, now(), now())
    RETURNING "id" INTO v_mod2_id;
  ELSE
    UPDATE "modules" SET "title" = 'MRCEM Primary Question Bank: Quizzes 11-20', "position" = 23, "deleted_at" = NULL, "updated_at" = now() WHERE "id" = v_mod2_id;
  END IF;

  -- Module 3: Quizzes 21-30
  SELECT id INTO v_mod3_id FROM "modules" 
  WHERE "course_id" = v_primary_id 
    AND ("title" ILIKE '%Question Bank%21%30%' OR "title" ILIKE '%Quizzes 21-30%' OR "title" ILIKE '%Quizzes 21 - 30%')
  ORDER BY "created_at" ASC LIMIT 1;

  IF v_mod3_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_primary_id, 'MRCEM Primary Question Bank: Quizzes 21-30', 24, now(), now())
    RETURNING "id" INTO v_mod3_id;
  ELSE
    UPDATE "modules" SET "title" = 'MRCEM Primary Question Bank: Quizzes 21-30', "position" = 24, "deleted_at" = NULL, "updated_at" = now() WHERE "id" = v_mod3_id;
  END IF;

  -- Module 4: Quizzes 31-41
  SELECT id INTO v_mod4_id FROM "modules" 
  WHERE "course_id" = v_primary_id 
    AND ("title" ILIKE '%Question Bank%31%41%' OR "title" ILIKE '%Quizzes 31-41%' OR "title" ILIKE '%Quizzes 31 - 41%')
  ORDER BY "created_at" ASC LIMIT 1;

  IF v_mod4_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_primary_id, 'MRCEM Primary Question Bank: Quizzes 31-41', 25, now(), now())
    RETURNING "id" INTO v_mod4_id;
  ELSE
    UPDATE "modules" SET "title" = 'MRCEM Primary Question Bank: Quizzes 31-41', "position" = 25, "deleted_at" = NULL, "updated_at" = now() WHERE "id" = v_mod4_id;
  END IF;

  -- 3. Loop through Quizzes 1 to 41 and relocate each safely with deduplication
  FOR v_quiz_num IN 1..41 LOOP
    v_target_slug  := 'primary-quiz-' || LPAD(v_quiz_num::text, 2, '0');
    v_target_title := CASE v_quiz_num
      WHEN 1 THEN 'Quiz 01: Emergency Resuscitation, Cranial Nerves & Infection Microbiology'
      WHEN 2 THEN 'Quiz 02: Abdominal Viscera, Inguinal Anatomy & Autonomic Neuro-Ophthalmology'
      WHEN 3 THEN 'Quiz 03: Clinical Neuroanatomy, Cranial Nerves & Head-and-Neck Trauma'
      WHEN 4 THEN 'Quiz 04: Thoracic Cavity, Upper Limb Neurovascular & Trauma Mechanics'
      WHEN 5 THEN 'Quiz 05: Cardiovascular Physiology, Coronary Anatomy & Renal Mechanisms'
      WHEN 6 THEN 'Quiz 06: Endocrine Emergencies, Cardiac Cycle & Toxicological Crises'
      WHEN 7 THEN 'Quiz 07: Pharmacology & Toxicology, Autonomic System & Airway Anatomy'
      WHEN 8 THEN 'Quiz 08: Respiratory Tract Anatomy, Facial Innervation & Metabolic Disorders'
      WHEN 9 THEN 'Quiz 09: Lower Limb Nerves, Resuscitation Drugs & Gastrointestinal System'
      WHEN 10 THEN 'Quiz 10: Diabetic Ketoacidosis, Adrenoceptors & Skull Base Foramina'
      WHEN 11 THEN 'Quiz 11: Blood Gas Physiology, Electrolyte ECG & Hematological Disorders'
      WHEN 12 THEN 'Quiz 12: Peripheral Neuropathy, Hernia Anatomy & Inguinal Architecture'
      WHEN 13 THEN 'Quiz 13: Pharmacokinetics, Neuromuscular Junction & Shock Physiology'
      WHEN 14 THEN 'Quiz 14: Respiratory Mechanics, Acid-Base Chemoreceptors & Visual Pathways'
      WHEN 15 THEN 'Quiz 15: Neuro-Aphasia, Inguinal Canal & Autonomic Receptors'
      WHEN 16 THEN 'Quiz 16: Musculoskeletal Biomechanics, Renal Tubular Transport & Immunology'
      WHEN 17 THEN 'Quiz 17: Clinical Microbiology, Cerebrovascular Circulation & Infectious Disease'
      WHEN 18 THEN 'Quiz 18: Evidence-Based Medicine, Cardiac Conduction & Clinical Trials'
      WHEN 19 THEN 'Quiz 19: Pediatric Emergencies, Joint Ligaments & Parasitology'
      WHEN 20 THEN 'Quiz 20: Emergency Anesthetics, Toxicology Antidotes & Resuscitation Pharmacology'
      WHEN 21 THEN 'Quiz 21: Biophysics of Flow, Arrhythmia Mechanisms & Critical Care Burns'
      WHEN 22 THEN 'Quiz 22: Hematological Malignancies, Bone Healing & Surgical Anatomy'
      WHEN 23 THEN 'Quiz 23: Gastrointestinal Secretions, Pancreatic Enzymes & Lower Limb Blocks'
      WHEN 24 THEN 'Quiz 24: Abdominal Hernias, Intestinal Pathology & CSF Diagnostics'
      WHEN 25 THEN 'Quiz 25: Traumatic Brain Injury, Tuberculosis & Enzyme Induction'
      WHEN 26 THEN 'Quiz 26: Diving Physics, Musculoskeletal Trauma & Cardiovascular Drugs'
      WHEN 27 THEN 'Quiz 27: Upper & Lower Limb Trauma, Compartment Syndromes & Scaphoid Fracture'
      WHEN 28 THEN 'Quiz 28: Intracranial Dynamics, Acute Abdomen & Shock Resuscitation'
      WHEN 29 THEN 'Quiz 29: Splenic Trauma, Osteology & Neuromuscular Toxins'
      WHEN 30 THEN 'Quiz 30: Medical Statistics, Epidemiology & Cranial Nerve Palsies'
      WHEN 31 THEN 'Quiz 31: Lower Limb Anatomy, Gastrointestinal Surgery & Pharmacology'
      WHEN 32 THEN 'Quiz 32: Cranial Nerve Lesions, Brainstem Pathways & Vaccine Guidelines'
      WHEN 33 THEN 'Quiz 33: Glomerulonephritis, Upper Limb Fractures & Wound Microbiology'
      WHEN 34 THEN 'Quiz 34: Resuscitation Protocols, Airway Interventions & Cellular Biology'
      WHEN 35 THEN 'Quiz 35: Sepsis Resuscitation, Toxicology Antidotes & Immunization Rules'
      WHEN 36 THEN 'Quiz 36: Adrenal-Renal Physiology, Bowel Histology & Clinical Evidence'
      WHEN 37 THEN 'Quiz 37: Atypical Infections, Skull Base Pathology & Syncope Mechanisms'
      WHEN 38 THEN 'Quiz 38: Genitourinary Emergencies, Hip/Knee Muscles & Spinal Landmarks'
      WHEN 39 THEN 'Quiz 39: Neuromuscular Disorders, Thyroid Storm & Knee Biomechanics'
      WHEN 40 THEN 'Quiz 40: Neurotoxins, Enzyme Induction & Autoimmune Pathologies'
      WHEN 41 THEN 'Quiz 41: Neuroleptic Syndrome, Laryngeal Anatomy & Portal Hypertension'
      ELSE 'Primary Quiz ' || LPAD(v_quiz_num::text, 2, '0')
    END;

    IF v_quiz_num BETWEEN 1 AND 10 THEN
      v_target_mod := v_mod1_id;
    ELSIF v_quiz_num BETWEEN 11 AND 20 THEN
      v_target_mod := v_mod2_id;
    ELSIF v_quiz_num BETWEEN 21 AND 30 THEN
      v_target_mod := v_mod3_id;
    ELSE
      v_target_mod := v_mod4_id;
    END IF;

    -- Find the single best "keeper" lesson row for this quiz
    SELECT l.id INTO v_keeper_id
    FROM "lessons" l
    JOIN "modules" m ON m.id = l.module_id
    WHERE (
      l.slug = v_target_slug
      OR l.slug = 'quiz-' || v_quiz_num::text
      OR l.slug = 'quiz-' || LPAD(v_quiz_num::text, 2, '0')
      OR l.title ILIKE 'Quiz _ ' || v_quiz_num::text
      OR l.title ILIKE 'Primary Quiz ' || LPAD(v_quiz_num::text, 2, '0')
      OR l.title ILIKE 'Quiz ' || v_quiz_num::text || ' %'
      OR l.title = 'Quiz ' || v_quiz_num::text
      OR l.title = 'Primary Quiz ' || v_quiz_num::text
    )
    ORDER BY
      -- Prioritize row that already has non-empty body
      CASE WHEN LENGTH(COALESCE(l.body, '')) > 100 THEN 0 ELSE 1 END,
      LENGTH(COALESCE(l.body, '')) DESC,
      -- Then prioritize row already in primary module
      CASE WHEN l.module_id = v_target_mod THEN 0 ELSE 1 END,
      l.created_at ASC
    LIMIT 1;

    IF v_keeper_id IS NOT NULL THEN
      -- Delete any conflicting row in target module that would trigger lessons_module_slug_uq
      DELETE FROM "lessons"
      WHERE "module_id" = v_target_mod
        AND "slug" = v_target_slug
        AND "id" != v_keeper_id;

      -- Also delete any conflicting row with old slug format in target module
      DELETE FROM "lessons"
      WHERE "module_id" = v_target_mod
        AND "slug" = 'quiz-' || v_quiz_num::text
        AND "id" != v_keeper_id;

      -- Delete any other candidate duplicates of this quiz across the DB
      DELETE FROM "lessons"
      WHERE "id" != v_keeper_id
        AND (
          "slug" = v_target_slug
          OR "slug" = 'quiz-' || v_quiz_num::text
          OR "slug" = 'quiz-' || LPAD(v_quiz_num::text, 2, '0')
          OR "title" = 'Quiz _ ' || v_quiz_num::text
          OR "title" = 'Primary Quiz ' || LPAD(v_quiz_num::text, 2, '0')
        );

      -- Now safely update the keeper row
      UPDATE "lessons"
      SET
        "module_id"  = v_target_mod,
        "slug"       = v_target_slug,
        "title"      = v_target_title,
        "type"       = 'quiz',
        "status"     = 'published',
        "deleted_at" = NULL,
        "position"   = CASE
          WHEN v_quiz_num BETWEEN 1 AND 10 THEN v_quiz_num - 1
          WHEN v_quiz_num BETWEEN 11 AND 20 THEN v_quiz_num - 11
          WHEN v_quiz_num BETWEEN 21 AND 30 THEN v_quiz_num - 21
          ELSE v_quiz_num - 31
        END,
        "updated_at" = now()
      WHERE "id" = v_keeper_id;

      v_moved_count := v_moved_count + 1;
    END IF;
  END LOOP;

  -- 4. Clean up old quiz modules in SBA
  IF v_sba_id IS NOT NULL THEN
    UPDATE "modules"
    SET "deleted_at" = now(), "updated_at" = now()
    WHERE "course_id" = v_sba_id
      AND (
        "title" ILIKE '%Primary Question Bank%'
        OR "title" ILIKE 'High-Yield SBA Quizzes: Part % (Quizzes %)'
        OR "title" ILIKE '%Quizzes 01 - 10%'
        OR "title" ILIKE '%Quizzes 11 - 20%'
        OR "title" ILIKE '%Quizzes 21 - 30%'
        OR "title" ILIKE '%Quizzes 31 - 41%'
      )
      AND "deleted_at" IS NULL;

    -- Clean up any empty quiz modules in SBA
    UPDATE "modules" m
    SET "deleted_at" = now(), "updated_at" = now()
    WHERE m."course_id" = v_sba_id
      AND m."deleted_at" IS NULL
      AND m."title" ILIKE '%Quiz%'
      AND NOT EXISTS (
        SELECT 1 FROM "lessons" l WHERE l."module_id" = m."id" AND l."deleted_at" IS NULL
      );
  END IF;

  -- 5. Touch course timestamps
  UPDATE "courses" SET "updated_at" = now() WHERE "id" IN (v_primary_id, v_sba_id);

  RAISE NOTICE 'SUCCESS: Transferred and deduplicated % quizzes into MRCEM Primary course.', v_moved_count;
END $$;
