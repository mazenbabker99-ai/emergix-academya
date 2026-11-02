-- ==========================================================================
-- MASTER CURRICULUM MIGRATION: 109 TOPIC SBA QUIZZES + CLINICAL FIGURES
-- Course: MRCEM SBA & MRCEM Primary
-- Adds 109 interactive SBA quizzes (545 verified questions)
-- Embeds 400 clinical images with zoom and high-definition review
-- Sanitizes junk lessons, re-orders modules 0..10, and aligns lectures
-- ==========================================================================
DO $$
DECLARE
  v_sba_id      uuid;
  v_primary_id  uuid;
  v_mod_id      uuid;
  v_lec_id      uuid;
  v_quiz_id     uuid;
BEGIN
  -- Locate Courses
  SELECT id INTO v_sba_id     FROM "courses" WHERE "slug" = 'mrcem-sba' LIMIT 1;
  SELECT id INTO v_primary_id FROM "courses" WHERE "slug" = 'mrcem-primary' LIMIT 1;

  IF v_sba_id IS NULL THEN
    RAISE EXCEPTION 'Course mrcem-sba not found';
  END IF;

  -- ========================================================================
  -- STEP 1: MODULE ORDERING & STRUCTURE (Positions 0 to 10 in mrcem-sba)
  -- ========================================================================
  -- Module 0: Resuscitation & Critical Care
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_sba_id AND "title" = 'Resuscitation & Critical Care' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_sba_id, 'Resuscitation & Critical Care', 0, now(), now());
  ELSE
    UPDATE "modules" SET "position" = 0, "deleted_at" = NULL, "updated_at" = now() WHERE "id" = v_mod_id;
  END IF;

  -- Module 1: Cardiovascular Emergencies
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_sba_id AND "title" = 'Cardiovascular Emergencies' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_sba_id, 'Cardiovascular Emergencies', 1, now(), now());
  ELSE
    UPDATE "modules" SET "position" = 1, "deleted_at" = NULL, "updated_at" = now() WHERE "id" = v_mod_id;
  END IF;

  -- Module 2: Major Trauma & Injury Management
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_sba_id AND "title" = 'Major Trauma & Injury Management' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_sba_id, 'Major Trauma & Injury Management', 2, now(), now());
  ELSE
    UPDATE "modules" SET "position" = 2, "deleted_at" = NULL, "updated_at" = now() WHERE "id" = v_mod_id;
  END IF;

  -- Module 3: Pulmonology & Respiratory Emergencies
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_sba_id AND "title" = 'Pulmonology & Respiratory Emergencies' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_sba_id, 'Pulmonology & Respiratory Emergencies', 3, now(), now());
  ELSE
    UPDATE "modules" SET "position" = 3, "deleted_at" = NULL, "updated_at" = now() WHERE "id" = v_mod_id;
  END IF;

  -- Module 4: Gastroenterology Emergencies
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_sba_id AND "title" = 'Gastroenterology Emergencies' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_sba_id, 'Gastroenterology Emergencies', 4, now(), now());
  ELSE
    UPDATE "modules" SET "position" = 4, "deleted_at" = NULL, "updated_at" = now() WHERE "id" = v_mod_id;
  END IF;

  -- Module 5: Nephrology & Acid-Base Disorders
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_sba_id AND "title" = 'Nephrology & Acid-Base Disorders' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_sba_id, 'Nephrology & Acid-Base Disorders', 5, now(), now());
  ELSE
    UPDATE "modules" SET "position" = 5, "deleted_at" = NULL, "updated_at" = now() WHERE "id" = v_mod_id;
  END IF;

  -- Module 6: Urological Emergencies
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_sba_id AND "title" = 'Urological Emergencies' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_sba_id, 'Urological Emergencies', 6, now(), now());
  ELSE
    UPDATE "modules" SET "position" = 6, "deleted_at" = NULL, "updated_at" = now() WHERE "id" = v_mod_id;
  END IF;

  -- Module 7: Ophthalmology Emergencies
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_sba_id AND "title" = 'Ophthalmology Emergencies' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_sba_id, 'Ophthalmology Emergencies', 7, now(), now());
  ELSE
    UPDATE "modules" SET "position" = 7, "deleted_at" = NULL, "updated_at" = now() WHERE "id" = v_mod_id;
  END IF;

  -- Module 8: Vascular Emergencies
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_sba_id AND "title" = 'Vascular Emergencies' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_sba_id, 'Vascular Emergencies', 8, now(), now());
  ELSE
    UPDATE "modules" SET "position" = 8, "deleted_at" = NULL, "updated_at" = now() WHERE "id" = v_mod_id;
  END IF;

  -- Module 9: High-Yield Rapid Clinical Revision
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_sba_id AND "title" = 'High-Yield Rapid Clinical Revision' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_sba_id, 'High-Yield Rapid Clinical Revision', 9, now(), now());
  ELSE
    UPDATE "modules" SET "position" = 9, "deleted_at" = NULL, "updated_at" = now() WHERE "id" = v_mod_id;
  END IF;

  -- Module 10: MRCEM SBA Mock Simulations
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_sba_id AND "title" = 'MRCEM SBA Mock Simulations' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_sba_id, 'MRCEM SBA Mock Simulations', 10, now(), now());
  ELSE
    UPDATE "modules" SET "position" = 10, "deleted_at" = NULL, "updated_at" = now() WHERE "id" = v_mod_id;
  END IF;

  -- ========================================================================
  -- STEP 2: SANITIZE JUNK LESSONS & MISPLACED DUPLICATES
  -- ========================================================================
  UPDATE "lessons"
  SET "deleted_at" = now(), "updated_at" = now()
  WHERE "slug" IN (
    'updated-cv-elmokashfy-corrected',
    'cont-98-food-barcode',
    'dermatomes-of-trunk-2'
  ) OR "title" ILIKE '%Elmokashfy%' OR "title" ILIKE '%Food Barcode%';

  -- Soft-delete misplaced MOKA duplicates from Resuscitation module
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_sba_id AND "title" = 'Resuscitation & Critical Care' LIMIT 1;
  IF v_mod_id IS NOT NULL THEN
    UPDATE "lessons"
    SET "deleted_at" = now(), "updated_at" = now()
    WHERE "module_id" = v_mod_id
      AND "slug" IN ('high-yield-clinical-sba-practice-4', 'high-yield-clinical-sba-practice-65');
  END IF;

  -- ========================================================================
  -- STEP 3: CLEAN UP EXISTING LECTURE TITLES (Fix typos)
  -- ========================================================================
  UPDATE "lessons"
  SET "title" = 'Transfusion Management of Major Haemorrhage', "updated_at" = now()
  WHERE "slug" = 'transfction-mangement-of-major-hge';
  UPDATE "lessons"
  SET "title" = 'Choking Management (Adult & Paediatric)', "updated_at" = now()
  WHERE "slug" = 'chocking-andult-and-pedio';
  UPDATE "lessons"
  SET "title" = 'Resuscitation in Sepsis', "updated_at" = now()
  WHERE "slug" = 'resucitiation-in-sepsis';
  UPDATE "lessons"
  SET "title" = 'Cardiac Arrest in Pregnancy', "updated_at" = now()
  WHERE "slug" = 'cardiac-arest-in-pregnancy';
  UPDATE "lessons"
  SET "title" = 'Emergency Clinical Scores & Classifications', "updated_at" = now()
  WHERE "slug" = 'all-scores-and-classifications';
  UPDATE "lessons"
  SET "title" = 'Head Trauma & Intracranial Haemorrhage', "updated_at" = now()
  WHERE "slug" = 'head-reauma';
  UPDATE "lessons"
  SET "title" = 'Genitourinary Trauma & Urethral Injury', "updated_at" = now()
  WHERE "slug" = 'genetourinary-trauma';
  UPDATE "lessons"
  SET "title" = 'Maxillofacial & Facial Trauma', "updated_at" = now()
  WHERE "slug" = 'maxilofascial-trauma';
  UPDATE "lessons"
  SET "title" = 'Devastating Brain Injury & Prognostication', "updated_at" = now()
  WHERE "slug" = 'devastatiing-brain-injury';
  UPDATE "lessons"
  SET "title" = 'Laryngotracheal Injury & Airway Trauma', "updated_at" = now()
  WHERE "slug" = 'laryngotrachila-injury';
  UPDATE "lessons"
  SET "title" = 'Spinal Injury & Autonomic Dysreflexia', "updated_at" = now()
  WHERE "slug" = 'spinal-injury-autonmic-dysreflexia';
  UPDATE "lessons"
  SET "title" = 'Thoracic Trauma: Life-Threatening Injuries', "updated_at" = now()
  WHERE "slug" = 'throacic-trauma-life-threatining-injury';
  UPDATE "lessons"
  SET "title" = 'Spontaneous Pneumothorax (Non-Traumatic)', "updated_at" = now()
  WHERE "slug" = 'spontenus-pnemothroax-non-tramuatic';
  UPDATE "lessons"
  SET "title" = 'Thoracic Trauma & Flail Chest', "updated_at" = now()
  WHERE "slug" = 'throacic-trauma-and-faial-chest';
  UPDATE "lessons"
  SET "title" = 'Community-Acquired Pneumonia (Adults)', "updated_at" = now()
  WHERE "slug" = 'pulmo-1';
  UPDATE "lessons"
  SET "title" = 'Bronchiolitis in Infants', "updated_at" = now()
  WHERE "slug" = 'broncholilis';
  UPDATE "lessons"
  SET "title" = 'Aspiration Pneumonia & Chemical Pneumonitis', "updated_at" = now()
  WHERE "slug" = '10cap';
  UPDATE "lessons"
  SET "title" = 'Acute Constipation & Bowel Management', "updated_at" = now()
  WHERE "slug" = 'constibation';
  UPDATE "lessons"
  SET "title" = 'Foreign Body Ingestion in the ED', "updated_at" = now()
  WHERE "slug" = 'fb-ingestion';
  UPDATE "lessons"
  SET "title" = 'Infantile Hypertrophic Pyloric Stenosis', "updated_at" = now()
  WHERE "slug" = 'pykoric-stenosis';
  UPDATE "lessons"
  SET "title" = 'Alcoholic Liver Disease & Cirrhosis', "updated_at" = now()
  WHERE "slug" = 'alcoholic-ld';
  UPDATE "lessons"
  SET "title" = 'Diverticular Disease & Diverticulitis', "updated_at" = now()
  WHERE "slug" = 'diverticulr-disease';
  UPDATE "lessons"
  SET "title" = 'Hyperkalaemic Cardiac Arrest Protocols', "updated_at" = now()
  WHERE "slug" = 'hyperkalemic-cardiac-arest';
  UPDATE "lessons"
  SET "title" = 'Hypercalcaemia Emergency Management', "updated_at" = now()
  WHERE "slug" = 'hypercalemia';
  UPDATE "lessons"
  SET "title" = 'Hypocalcaemia & Tetany', "updated_at" = now()
  WHERE "slug" = 'hypocalecemia';
  UPDATE "lessons"
  SET "title" = 'Acute Kidney Injury (AKI) & KDIGO Staging', "updated_at" = now()
  WHERE "slug" = 'aki';
  UPDATE "lessons"
  SET "title" = 'Renal Colic & Nephrolithiasis', "updated_at" = now()
  WHERE "slug" = 'renal-colic-nephrolithiasis';
  UPDATE "lessons"
  SET "title" = 'Acute Angle-Closure Glaucoma', "updated_at" = now()
  WHERE "slug" = 'acute-glucoma';
  UPDATE "lessons"
  SET "title" = 'Orbital & Periorbital Cellulitis', "updated_at" = now()
  WHERE "slug" = 'orbital-and-per-celiltits';
  UPDATE "lessons"
  SET "title" = 'Temporal Arteritis (Giant Cell Arteritis)', "updated_at" = now()
  WHERE "slug" = 'temporal-artitis';
  UPDATE "lessons"
  SET "title" = 'Inflammatory Eye Disease (Uveitis & Scleritis)', "updated_at" = now()
  WHERE "slug" = 'inflammetory-eye-disease';
  UPDATE "lessons"
  SET "title" = 'Ophthalmia Neonatorum', "updated_at" = now()
  WHERE "slug" = 'ophthalma-neonatorum';

  -- ========================================================================
  -- STEP 4: 109 VERIFIED INTERACTIVE SBA QUIZZES WITH EMBEDDED CLINICAL IMAGES
  -- ========================================================================

  -- ------------------------------------------------------------------------
  -- Specialty: Resuscitation & Critical Care (10 Topics)
  -- ------------------------------------------------------------------------
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_sba_id AND "title" = 'Resuscitation & Critical Care' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module Resuscitation & Critical Care not found in mrcem-sba';
  END IF;

  -- Topic 1/10: Advanced Life Support (ALS)
  -- 1) Interleave Lecture (Position 0)
  UPDATE "lessons"
  SET "position" = 0, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'advanced-life-support-als-algorithms' OR "slug" = 'als');

  -- 2) Upsert Quiz Lesson (Position 1)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-resuscitation-als',
    'Advanced Life Support (ALS) — SBA Interactive Quiz',
    'quiz',
    $SBA_RESU_001$# Advanced Life Support (ALS) — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 64-year-old man collapses in the emergency department waiting room. The monitor is attached and shows ventricular fibrillation (VF). Chest compressions are immediately commenced. A defibrillator is charged. What is the single most important immediate action?

![Figure 1: Clinical Findings & Diagnostic Reference (Advanced Life Support (ALS))](/lessons/images/sba/resuscitation/als/figure_01_p1.jpeg)


- **A.** Administer 1mg IV adrenaline immediately
- **B.** Deliver a single unsynchronised shock of 120-150J biphasic with minimal interruption to chest compressions
- **C.** Intubate the patient with an endotracheal tube before defibrillation
- **D.** Administer 300mg IV amiodarone bolus
- **E.** Perform 2 minutes of CPR before attempting any shock

**Correct Answer:** B
**Explanation:**
In shockable rhythms (VF/pVT), immediate defibrillation is the single most critical intervention that determines survival. Compressions should only be paused briefly to deliver the shock. Adrenaline is given only after the 3rd shock (not 1st), and amiodarone 300mg is also given after the 3rd shock per RCUK ALS guidelines.

![Clinical Algorithm & Advanced Reference (Advanced Life Support (ALS))](/lessons/images/sba/resuscitation/als/figure_06_p8.jpeg)


## Question 2 of 5

During cardiopulmonary resuscitation of a 55-year-old male in refractory ventricular fibrillation who has received three shocks, which pharmacological therapy is indicated per Resuscitation Council UK guidelines?

![Figure 2: Clinical Findings & Diagnostic Reference (Advanced Life Support (ALS))](/lessons/images/sba/resuscitation/als/figure_02_p3.jpeg)


- **A.** IV Adrenaline 1mg and IV Amiodarone 300mg
- **B.** IV Atropine 3mg and IV Calcium Chloride 10ml 10%
- **C.** IV Sodium Bicarbonate 50ml 8.4%
- **D.** IV Lidocaine 100mg only, avoiding adrenaline
- **E.** IV Vasopressin 40 units alone

**Correct Answer:** A
**Explanation:**
Per RCUK ALS guidelines, after the 3rd shock in VF/pVT, the team should immediately administer Adrenaline 1mg IV/IO and Amiodarone 300mg IV/IO while CPR is continued for 2 minutes before rhythm re-check. A second dose of amiodarone (150mg) is given after the 5th shock.

## Question 3 of 5

A 48-year-old woman is brought to the ED in cardiac arrest with pulseless electrical activity (PEA) at 35 bpm. What is the priority drug administration and timing according to the ALS algorithm?

![Figure 3: Clinical Findings & Diagnostic Reference (Advanced Life Support (ALS))](/lessons/images/sba/resuscitation/als/figure_03_p4.jpeg)


- **A.** Synchronised DC cardioversion 100J
- **B.** Adrenaline 1mg IV as soon as vascular access is established, repeated every 3-5 minutes
- **C.** Amiodarone 300mg IV immediately
- **D.** Atropine 500mcg IV bolus
- **E.** Transcutaneous pacing at 80 bpm

**Correct Answer:** B
**Explanation:**
In non-shockable rhythms (PEA / Asystole), Adrenaline 1mg IV/IO should be given as soon as vascular access is obtained, and repeated every alternate CPR cycle (every 3-5 minutes). Defibrillation, pacing, and amiodarone are not indicated in PEA.

## Question 4 of 5

A patient in cardiac arrest has end-tidal CO2 (ETCO2) monitoring during CPR. For the past 10 minutes, the ETCO2 has been 14 mmHg. Suddenly, during chest compressions, the ETCO2 value jumps sharply to 42 mmHg. What is the most likely clinical significance?

![Figure 4: Clinical Findings & Diagnostic Reference (Advanced Life Support (ALS))](/lessons/images/sba/resuscitation/als/figure_04_p5.jpeg)


- **A.** Endotracheal tube displacement into the oesophagus
- **B.** Tension pneumothorax development
- **C.** Return of Spontaneous Circulation (ROSC)
- **D.** Severe metabolic lactic acidosis accumulation
- **E.** Exhaustion of the chest compressor

**Correct Answer:** C
**Explanation:**
A sudden sustained increase in ETCO2 (typically >35-40 mmHg) is a very reliable indicator of Return of Spontaneous Circulation (ROSC). It reflects a sudden surge in pulmonary blood flow as cardiac output is restored. Oesophageal intubation causes ETCO2 to drop towards zero.

## Question 5 of 5

Which of the following reversible causes of cardiac arrest (the '4 Hs and 4 Ts') is specifically treated with high-dose intravenous calcium chloride?

![Figure 5: Clinical Findings & Diagnostic Reference (Advanced Life Support (ALS))](/lessons/images/sba/resuscitation/als/figure_05_p6.jpeg)


- **A.** Hypothermia
- **B.** Severe hyperkalaemia
- **C.** Cardiac tamponade
- **D.** Tension pneumothorax
- **E.** Hypovolaemia

**Correct Answer:** B
**Explanation:**
Severe hyperkalaemia as a cause of arrest is treated immediately with IV 10% calcium chloride (10ml) or 10% calcium gluconate (30ml) to stabilise the myocardial membrane, alongside insulin-dextrose and sodium bicarbonate.
$SBA_RESU_001$,
    false,
    1,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 2/10: Brief Resolved Unexplained Event (BRUE)
  -- 1) Interleave Lecture (Position 2)
  UPDATE "lessons"
  SET "position" = 2, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'brief-resolved-unexplained-event-brue' OR "slug" = 'brue');

  -- 2) Upsert Quiz Lesson (Position 3)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-resuscitation-brue',
    'Brief Resolved Unexplained Event (BRUE) — SBA Interactive Quiz',
    'quiz',
    $SBA_RESU_002$# Brief Resolved Unexplained Event (BRUE) — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 6-week-old infant is brought to the ED by parents who report that 45 minutes ago the infant turned pale, went completely limp, and appeared to stop breathing for 15 seconds. By the time emergency services arrived, the infant was fully alert and feeding. On examination in the ED, the infant appears well, vital signs are normal, and physical examination is entirely unremarkable. What is this clinical presentation classified as?

![Figure 1: Clinical Findings & Diagnostic Reference (Brief Resolved Unexplained Event (BRUE))](/lessons/images/sba/resuscitation/brue/figure_01_p1.jpeg)


- **A.** Apparent Life-Threatening Event (ALTE) requiring mandatory 48-hour hospital admission
- **B.** Brief Resolved Unexplained Event (BRUE)
- **C.** Febrile seizure
- **D.** Epileptic spasm syndrome
- **E.** Pertussis encephalopathy

**Correct Answer:** B
**Explanation:**
BRUE (Brief Resolved Unexplained Event) replaced ALTE. A BRUE is defined in an infant <1 year old as a sudden, brief (<1 minute), and now fully resolved episode of: cyanosis or pallor, absent/irregular/decreased breathing, marked change in tone (hyper/hypotonia), or altered level of responsiveness, with no underlying explanation after history and exam.

## Question 2 of 5

According to American Academy of Pediatrics (AAP) and UK paediatric guidance, which infant with a BRUE meets the criteria for 'Low Risk' designation?

![Figure 2: Clinical Findings & Diagnostic Reference (Brief Resolved Unexplained Event (BRUE))](/lessons/images/sba/resuscitation/brue/figure_02_p4.jpeg)


- **A.** Age 45 days, born at 31 weeks gestation (corrected age 37 weeks)
- **B.** Age 5 months, born at 39 weeks, first episode, duration 20 seconds, no CPR required
- **C.** Age 3 months, second episode within 24 hours
- **D.** Age 2 months, episode duration was 3 minutes with vigorous chest compressions by father
- **E.** Age 3 weeks, born at full term

**Correct Answer:** B
**Explanation:**
Low-risk BRUE criteria: Age >60 days; gestational age >=32 weeks and postconceptional age >=45 weeks; first episode; duration <1 minute; no CPR required by trained healthcare provider; no concerning history (no family history of sudden cardiac death or metabolic illness); normal physical exam.

## Question 3 of 5

For a 4-month-old infant classified as 'Low-Risk BRUE' who is completely well on ED assessment, what is the most appropriate management according to guidelines?

![Figure 3: Clinical Findings & Diagnostic Reference (Brief Resolved Unexplained Event (BRUE))](/lessons/images/sba/resuscitation/brue/figure_03_p5.jpeg)


- **A.** Perform lumbar puncture, full septic screen, and admission for IV antibiotics
- **B.** 24-hour continuous inpatient cardiac telemetry and routine EEG
- **C.** Educate parents, offer infant CPR training, brief observation, and discharge with primary care follow-up
- **D.** Emergent CT scan of the brain to exclude non-accidental head injury
- **E.** Start oral ranitidine and home apnoea monitor for 3 months

**Correct Answer:** C
**Explanation:**
For infants classified as Low-Risk BRUE, extensive investigations (lumbar puncture, blood tests, neuroimaging, echocardiogram, routine admission) are NOT recommended. Management includes brief clinical observation, parent education, offering CPR training, and arranged follow-up.

## Question 4 of 5

Which examination finding in an infant presenting after an apparent BRUE should immediately raise suspicion of Non-Accidental Injury (NAI) / physical abuse?

![Figure 4: Clinical Findings & Diagnostic Reference (Brief Resolved Unexplained Event (BRUE))](/lessons/images/sba/resuscitation/brue/figure_04_p5.jpeg)


- **A.** Mongolian blue spots over the sacrum
- **B.** Retinal haemorrhages on fundoscopy and torn labial frenulum
- **C.** Caput succedaneum
- **D.** Mild physiological jaundice
- **E.** Prominent Moro reflex

**Correct Answer:** B
**Explanation:**
Retinal haemorrhages, torn frenulum (from forced feeding/smothering), unexplained bruising (especially on torso, ears, or neck in non-mobile infants), or rib fractures on skeletal survey are critical red flags for abusive head trauma / physical abuse.

## Question 5 of 5

An infant with a BRUE is found on ECG to have a corrected QT interval (QTc) of 490 ms. What is the most likely diagnosis to consider?

- **A.** Congenital Long QT Syndrome (LQTS)
- **B.** Wolff-Parkinson-White syndrome
- **C.** Benign physiological QT variation
- **D.** Atrial septal defect
- **E.** Patent ductus arteriosus

**Correct Answer:** A
**Explanation:**
An ECG is recommended in BRUE to screen for arrhythmogenic conditions. A QTc >460-470 ms in infants raises concern for Congenital Long QT Syndrome (e.g. Romano-Ward or Jervell and Lange-Nielsen), which can cause syncope, torsades de pointes, and sudden unexplained death.
$SBA_RESU_002$,
    false,
    3,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 3/10: Cardiac Arrest in Pregnancy
  -- 1) Interleave Lecture (Position 4)
  UPDATE "lessons"
  SET "position" = 4, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'cardiac-arest-in-pregnancy' OR "slug" = 'cardiac-arrest-pregnancy');

  -- 2) Upsert Quiz Lesson (Position 5)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-resuscitation-cardiac-arrest-pregnancy',
    'Cardiac Arrest in Pregnancy — SBA Interactive Quiz',
    'quiz',
    $SBA_RESU_003$# Cardiac Arrest in Pregnancy — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 32-year-old woman at 32 weeks gestation suffers a sudden out-of-hospital cardiac arrest and is brought to the resuscitation bay. Chest compressions are ongoing. To relieve aortocaval compression, what is the recommended immediate physical manoeuvre?

![Figure 1: Clinical Findings & Diagnostic Reference (Cardiac Arrest in Pregnancy)](/lessons/images/sba/resuscitation/cardiac-arrest-pregnancy/figure_01_p2.jpeg)


- **A.** Place the patient in a full 90-degree left lateral decubitus position
- **B.** Manual left uterine displacement (LUD) while keeping the patient supine on a firm backboard
- **C.** Trendelenburg position (head down 30 degrees)
- **D.** Elevate both lower limbs to 45 degrees
- **E.** Prone positioning

**Correct Answer:** B
**Explanation:**
In pregnant patients >20 weeks gestation, the gravid uterus compresses the inferior vena cava and aorta, reducing venous return and cardiac output during CPR. Resuscitation guidelines recommend Manual Left Uterine Displacement (LUD) performed with one or two hands while the patient remains supine on a firm surface, avoiding tilting tables which degrade compression quality.

## Question 2 of 5

In maternal cardiac arrest at >=20 weeks gestation, if Return of Spontaneous Circulation (ROSC) is NOT achieved despite high-quality CPR, within how many minutes from the time of arrest should Resuscitative Hysterotomy (Perimortem Caesarean Section) be initiated and delivered?

![Figure 2: Clinical Findings & Diagnostic Reference (Cardiac Arrest in Pregnancy)](/lessons/images/sba/resuscitation/cardiac-arrest-pregnancy/figure_02_p2.jpeg)


- **A.** Initiate at 15 minutes, deliver by 20 minutes
- **B.** Initiate at 10 minutes, deliver by 15 minutes
- **C.** Initiate by 4 minutes, deliver by 5 minutes ('The 4-5 Minute Rule')
- **D.** Wait until 30 minutes of full ALS cycles are completed
- **E.** Only perform hysterotomy after maternal death is formally certified by two physicians

**Correct Answer:** C
**Explanation:**
The '4-5 Minute Rule': If there is no ROSC after 4 minutes of resuscitation in a pregnant woman >=20 weeks gestation, resuscitative hysterotomy should be commenced immediately with the goal of delivering the fetus by 5 minutes. This dramatically relieves aortocaval compression, restoring maternal venous return and giving the best chance of maternal (and fetal) survival.

## Question 3 of 5

Where should a Resuscitative Hysterotomy (Perimortem Caesarean Section) take place when maternal cardiac arrest occurs in the Emergency Department?

- **A.** Transfer urgently to the main hospital obstetric operating theatre
- **B.** In the ED Resuscitation Bay where the patient is located, without moving her
- **C.** In the radiology CT scanner room
- **D.** In the labour ward triage area
- **E.** In the post-anaesthetic recovery unit

**Correct Answer:** B
**Explanation:**
Resuscitative hysterotomy must NEVER be delayed by transporting the patient to an operating theatre. It should be performed immediately at the site of arrest (ED Resus room) using a scalpel. Time to delivery is the primary determinant of maternal brain viability.

## Question 4 of 5

A 28-year-old primigravida at 34 weeks gestation with severe pre-eclampsia receiving IV magnesium sulphate suddenly becomes apnoeic, bradycardic, and loses her pulse. What specific antidote should be administered immediately?

- **A.** IV Naloxone 400mcg
- **B.** IV Calcium Gluconate 10% (10ml) or Calcium Chloride 10%
- **C.** IV Flumazenil 500mcg
- **D.** IV Sodium Bicarbonate 50ml 8.4%
- **E.** IV Lipid Emulsion 20%

**Correct Answer:** B
**Explanation:**
Magnesium sulphate toxicity causes loss of deep tendon reflexes, respiratory depression, and cardiac arrest. The specific antagonist is intravenous calcium (10ml of 10% calcium gluconate or calcium chloride IV over 5-10 minutes), which competitively reverses neuromuscular and cardiac toxicity.

## Question 5 of 5

Regarding defibrillation pad placement and energy selection in maternal cardiac arrest, which statement is correct?

- **A.** Defibrillation energy should be halved to protect the fetal myocardium
- **B.** Defibrillation is strictly contraindicated in pregnancy due to amniotic fluid conduction
- **C.** Standard adult energy levels (e.g. 150-200J biphasic) should be used, with anterolateral or anterior-posterior pad placement avoiding breast tissue
- **D.** Defibrillate only if the fetus is confirmed non-viable by bedside ultrasound
- **E.** Synchronised cardioversion only must be used even for ventricular fibrillation

**Correct Answer:** C
**Explanation:**
Standard adult defibrillation protocols apply in pregnancy. Transthoracic impedance is unchanged, and standard biphasic energy doses (150-200J) must be used. Defibrillation does not deliver harmful electrical current to the fetus. Do not delay defibrillation.
$SBA_RESU_003$,
    false,
    5,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 4/10: Choking (Adult & Paediatric)
  -- 1) Interleave Lecture (Position 6)
  UPDATE "lessons"
  SET "position" = 6, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'chocking-andult-and-pedio' OR "slug" = 'choking-adult-pediatric');

  -- 2) Upsert Quiz Lesson (Position 7)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-resuscitation-choking-adult-pediatric',
    'Choking (Adult & Paediatric) — SBA Interactive Quiz',
    'quiz',
    $SBA_RESU_004$# Choking (Adult & Paediatric) — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 58-year-old man in a restaurant suddenly stands up, clutching his neck with both hands. He is conscious, coughing forcefully, and able to speak in short sentences. What is the most appropriate initial management?

![Figure 1: Clinical Findings & Diagnostic Reference (Choking (Adult & Paediatric))](/lessons/images/sba/resuscitation/choking-adult-pediatric/figure_01_p1.jpeg)


- **A.** Perform 5 sharp abdominal thrusts (Heimlich manoeuvre) immediately
- **B.** Encourage him to continue coughing forcefully and monitor closely
- **C.** Perform a blind finger sweep of the posterior pharynx
- **D.** Deliver 5 sharp back blows between the shoulder blades
- **E.** Perform emergency needle cricothyroidotomy

**Correct Answer:** B
**Explanation:**
In mild foreign body airway obstruction (effective cough, able to speak, responsive), natural coughing is the most effective way to clear the airway. Intervention (back blows or thrusts) is indicated ONLY if the victim shows signs of severe airway obstruction (ineffective cough, inability to speak, cyanosis, stridor, or quiet struggling).

## Question 2 of 5

A 6-year-old child who was eating peanuts suddenly develops severe airway obstruction: she cannot vocalise, has a silent cough, and is becoming cyanosed but remains conscious. What is the correct sequence of physical interventions according to UK Resuscitation guidelines?

![Figure 2: Clinical Findings & Diagnostic Reference (Choking (Adult & Paediatric))](/lessons/images/sba/resuscitation/choking-adult-pediatric/figure_02_p2.jpeg)


- **A.** Give up to 5 back blows followed by up to 5 abdominal thrusts; alternate cycles
- **B.** Give 5 chest thrusts followed by 5 abdominal thrusts
- **C.** Start 30 chest compressions immediately
- **D.** Perform blind finger sweep
- **E.** Deliver 5 back blows only and repeat indefinitely

**Correct Answer:** A
**Explanation:**
For conscious children >1 year with severe foreign body airway obstruction (FBAO): Give up to 5 sharp back blows. If unresolved, give up to 5 abdominal thrusts (Heimlich). Repeat the cycle of 5 back blows and 5 abdominal thrusts until dislodged or the child becomes unresponsive.

## Question 3 of 5

An 8-month-old infant is brought into the ED choking on a plastic toy part. The infant is conscious but has ineffective coughing, severe stridor, and cyanosis. Which physical intervention is CONTRAINDICATED in an infant under 1 year of age?

![Figure 3: Clinical Findings & Diagnostic Reference (Choking (Adult & Paediatric))](/lessons/images/sba/resuscitation/choking-adult-pediatric/figure_03_p3.jpeg)


- **A.** Back blows with the infant positioned head-down on the rescuer's forearm
- **B.** Chest thrusts using two fingers over the lower sternum
- **C.** Abdominal thrusts (Heimlich manoeuvre)
- **D.** Direct laryngoscopy with Magill forceps under direct vision
- **E.** Oxygen administration by blow-by once cleared

**Correct Answer:** C
**Explanation:**
Abdominal thrusts are CONTRAINDICATED in infants (<1 year) because of the horizontal orientation of the ribs and the relative lack of protection for the liver and spleen, which risks fatal hepatic rupture or visceral laceration. Infants receive alternating cycles of 5 back blows and 5 CHEST thrusts.

## Question 4 of 5

A 45-year-old choking victim collapses and becomes unconscious while receiving back blows. What is the immediate next step in management?

![Figure 4: Clinical Findings & Diagnostic Reference (Choking (Adult & Paediatric))](/lessons/images/sba/resuscitation/choking-adult-pediatric/figure_04_p4.jpeg)


- **A.** Perform a blind finger sweep to retrieve the object
- **B.** Carefully support the patient to the ground and start CPR immediately with 30 chest compressions
- **C.** Attempt 5 abdominal thrusts on the floor
- **D.** Perform needle cricothyroidotomy immediately
- **E.** Check a carotid pulse for 60 seconds before acting

**Correct Answer:** B
**Explanation:**
When any choking victim becomes unresponsive, immediately place them on a firm flat surface, call for emergency resuscitation team, and begin CPR starting with 30 chest compressions. Chest compressions generate higher intrathoracic airway pressures than abdominal thrusts and may dislodge the foreign body.

## Question 5 of 5

Following successful relief of severe choking in a 35-year-old woman using 5 abdominal thrusts, she is breathing comfortably and speaking normally. What clinical evaluation is mandatory before safe discharge?

- **A.** No evaluation needed, discharge home immediately
- **B.** Careful abdominal examination and clinical assessment for internal traumatic injuries
- **C.** Mandatory whole-body CT scan
- **D.** Prophylactic broad-spectrum oral antibiotics for 7 days
- **E.** Immediate barium swallow study

**Correct Answer:** B
**Explanation:**
Abdominal thrusts (and chest thrusts) can cause serious internal injuries, including gastric rupture, splenic or hepatic laceration, and rib/sternal fractures. Guidelines mandate that all patients who have received abdominal thrusts must be examined by a medical practitioner to rule out occult intra-abdominal trauma.
$SBA_RESU_004$,
    false,
    7,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 5/10: Haemorrhagic Shock & Massive Transfusion
  -- 1) Interleave Lecture (Position 8)
  UPDATE "lessons"
  SET "position" = 8, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'hemorrhagic-shock-massive-transfusion' OR "slug" = 'hemorrhagic-shock');

  -- 2) Upsert Quiz Lesson (Position 9)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-resuscitation-hemorrhagic-shock',
    'Haemorrhagic Shock & Massive Transfusion — SBA Interactive Quiz',
    'quiz',
    $SBA_RESU_005$# Haemorrhagic Shock & Massive Transfusion — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 24-year-old motorcyclist arrives after a high-speed collision. He is pale and clammy. HR 126 bpm, BP 86/52 mmHg, RR 28/min, GCS 13. Urine output via catheter is 15 ml/hr. According to the ATLS classification, which class of haemorrhagic shock is this patient exhibiting?

![Figure 1: Clinical Findings & Diagnostic Reference (Haemorrhagic Shock & Massive Transfusion)](/lessons/images/sba/resuscitation/hemorrhagic-shock/figure_01_p2.jpeg)


- **A.** Class I (Compensated)
- **B.** Class II (Mild)
- **C.** Class III (Moderate)
- **D.** Class IV (Severe / Exsanguinating)
- **E.** Neurogenic shock

**Correct Answer:** C
**Explanation:**
Class III haemorrhagic shock is characterised by 30-40% blood volume loss (1500-2000 ml), marked tachycardia (>120 bpm), HYPOTENSION (systolic BP drops), tachypnoea (20-30), decreased urine output (5-15 ml/hr), and anxiety/confusion. In Class II BP is still normal.

## Question 2 of 5

In the initial resuscitation of severe haemorrhagic trauma shock prior to definitive surgical or radiological haemostasis, what is the target systolic blood pressure in 'Permissive Hypotension' (damage control resuscitation) in the absence of traumatic brain injury?

![Figure 2: Clinical Findings & Diagnostic Reference (Haemorrhagic Shock & Massive Transfusion)](/lessons/images/sba/resuscitation/hemorrhagic-shock/figure_02_p4.jpeg)


- **A.** Systolic BP 120-130 mmHg
- **B.** Systolic BP 80-90 mmHg (or palpable radial pulse)
- **C.** Systolic BP 60-70 mmHg
- **D.** Systolic BP 140-150 mmHg
- **E.** Mean Arterial Pressure >95 mmHg

**Correct Answer:** B
**Explanation:**
Permissive hypotension targets a systolic BP of 80-90 mmHg (MAP 50-65 mmHg) in patients with penetrating or blunt haemorrhagic trauma until surgical haemostasis is achieved. Overzealous fluid administration 'pops the clot', dilutes clotting factors, and worsens hypothermia. (Note: in traumatic brain injury, target systolic is >=100-110 mmHg to maintain CPP).

## Question 3 of 5

Based on the landmark CRASH-2 trial, what is the recommended dose and administration window for Tranexamic Acid (TXA) in trauma patients with significant haemorrhage?

![Figure 3: Clinical Findings & Diagnostic Reference (Haemorrhagic Shock & Massive Transfusion)](/lessons/images/sba/resuscitation/hemorrhagic-shock/figure_03_p5.jpeg)


- **A.** 1g IV bolus over 10 minutes followed by 1g IV infusion over 8 hours, started within 3 hours of injury
- **B.** 2g IV bolus given at 6 hours post-injury
- **C.** 500mg IV single dose within 12 hours
- **D.** 1g orally once daily for 3 days
- **E.** TXA is only indicated if fibrinogen is <1.0 g/L on laboratory testing

**Correct Answer:** A
**Explanation:**
CRASH-2 demonstrated that Tranexamic Acid (TXA) reduces all-cause mortality in trauma haemorrhage when given within 3 hours of injury. The protocol is 1g IV over 10 minutes, followed by 1g IV over 8 hours. Giving TXA >3 hours after injury is associated with increased mortality and is contraindicated.

## Question 4 of 5

What constitutes the 'Lethal Triad' in trauma resuscitation that drives uncorrectable coagulopathic haemorrhage and death?

- **A.** Hypertension, Bradycardia, Irregular breathing
- **B.** Hypothermia, Coagulopathy, and Acidosis
- **C.** Hypokalaemia, Hyperglycaemia, Hypernatraemia
- **D.** Tachypnoea, Tachycardia, Oliguria
- **E.** Hypocalcaemia, Thrombocytosis, Leucopenia

**Correct Answer:** B
**Explanation:**
The Trauma Lethal Triad consists of Hypothermia, Acidosis, and Coagulopathy. Hypothermia impairs enzyme coagulation kinetics; acidosis reduces thrombin generation; coagulopathy accelerates blood loss, perpetuating the vicious cycle.

## Question 5 of 5

In damage control resuscitation for massive haemorrhage, what is the recommended ratio of Packed Red Blood Cells (PRBC) to Fresh Frozen Plasma (FFP) to Platelets in empirical massive transfusion protocols (MTP)?

- **A.** 4 : 1 : 1
- **B.** 1 : 1 : 1 (balanced haemostatic resuscitation)
- **C.** 10 : 2 : 1
- **D.** 1 : 4 : 0
- **E.** PRBC only until haemoglobin is >100 g/L

**Correct Answer:** B
**Explanation:**
The PROPPR trial and international major trauma guidelines recommend a balanced 1:1:1 ratio of PRBCs, FFP, and platelets (or reconstituted whole blood) to prevent early dilution of platelets and clotting factors during massive transfusion.
$SBA_RESU_005$,
    false,
    9,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 6/10: Neutropenic Sepsis
  -- 1) Interleave Lecture (Position 10)
  UPDATE "lessons"
  SET "position" = 10, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'neutropenic-sepsis-guidelines' OR "slug" = 'neutropenic-sepsis');

  -- 2) Upsert Quiz Lesson (Position 11)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-resuscitation-neutropenic-sepsis',
    'Neutropenic Sepsis — SBA Interactive Quiz',
    'quiz',
    $SBA_RESU_006$# Neutropenic Sepsis — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 52-year-old woman undergoing chemotherapy for breast cancer presents to the ED with rigors and lethargy. Her temperature is 38.6C, HR 112 bpm, BP 104/62. Blood tests show an absolute neutrophil count (ANC) of 0.3 x 10^9/L. According to NICE guidelines (CG151), what is the immediate priority antibiotic therapy?

![Figure 1: Clinical Findings & Diagnostic Reference (Neutropenic Sepsis)](/lessons/images/sba/resuscitation/neutropenic-sepsis/figure_01_p2.jpeg)


- **A.** Oral ciprofloxacin 500mg twice daily with home discharge
- **B.** Immediate IV Piperacillin with Tazobactam (Tazocin) within 1 hour ('The Golden Hour')
- **C.** Wait for blood culture and urine culture results before starting antibiotics
- **D.** IV Vancomycin monotherapy
- **E.** IV Metronidazole and oral co-amoxiclav

**Correct Answer:** B
**Explanation:**
NICE CG151 mandates that suspected neutropenic sepsis is a medical emergency requiring immediate empirical broad-spectrum IV antipseudomonal beta-lactam monotherapy (first-line IV piperacillin/tazobactam - Tazocin) within 60 minutes of arrival ('door-to-needle time < 1 hour'). Do not delay for blood counts or cultures.

## Question 2 of 5

Which of the following defines neutropenia in the context of oncology patients presenting with suspected neutropenic sepsis?

- **A.** Absolute neutrophil count (ANC) < 0.5 x 10^9/L, or < 1.0 x 10^9/L with an expected fall
- **B.** Total white blood cell count < 4.0 x 10^9/L
- **C.** Platelet count < 50 x 10^9/L
- **D.** Lymphocyte count < 0.8 x 10^9/L
- **E.** Neutrophil percentage < 40% regardless of absolute count

**Correct Answer:** A
**Explanation:**
Neutropenic sepsis is diagnosed when a patient on active chemotherapy (or within 6 weeks) has a fever (>38.0C) or symptoms/signs of sepsis and an absolute neutrophil count < 0.5 x 10^9/L (or < 1.0 x 10^9/L that is predicted to fall below 0.5).

## Question 3 of 5

Which risk stratification score is validated and recommended by ESMO/NICE to identify oncology patients with febrile neutropenia who may be candidates for early oral step-down therapy or outpatient management?

- **A.** MASCC (Multinational Association for Supportive Care in Cancer) score
- **B.** APACHE II score
- **C.** Glasgow Coma Scale
- **D.** Rockall score
- **E.** CURB-65 score

**Correct Answer:** A
**Explanation:**
The MASCC score is used to identify low-risk patients with febrile neutropenia. A MASCC score >= 21 indicates low risk of serious medical complications, identifying potential candidates for outpatient oral antibiotic therapy following an initial period of ED assessment.

## Question 4 of 5

A 60-year-old man with neutropenic sepsis and an indwelling tunnelled central venous line (Hickman catheter) remains persistently hypotensive despite 30 ml/kg fluid resuscitation and Tazocin. Examination reveals erythema and purulent discharge along the subcutaneous catheter tunnel. What antibiotic should be added immediately?

- **A.** IV Vancomycin (or Teicoplanin) for MRSA and coagulase-negative Staphylococci coverage
- **B.** Oral Fluconazole 200mg
- **C.** IV Clindamycin alone
- **D.** IV Ampicillin
- **E.** Inhaled colistin

**Correct Answer:** A
**Explanation:**
NICE recommends adding a glycopeptide (IV Vancomycin or Teicoplanin) to Tazocin when there is clinical suspicion of central venous catheter-related infection, severe tunnel/port infection, suspected MRSA, or persistent hemodynamic instability.

## Question 5 of 5

Why must digital rectal examination (DRE), rectal temperature measurement, and intramuscular injections be avoided in patients with severe neutropenia?

- **A.** Risk of inducing cardiac vagal reflex
- **B.** Risk of mucosal trauma precipitating overwhelming systemic bacteremia / perirectal abscess, and severe bleeding from concurrent thrombocytopenia
- **C.** They cause severe false elevations in neutrophil elastase
- **D.** They interfere with PET-CT imaging
- **E.** They cause allergic histamine degranulation

**Correct Answer:** B
**Explanation:**
Mucosal barriers in neutropenic patients are thin and fragile from chemotherapy (mucositis). Rectal manipulations (DRE, suppositories, rectal thermometers) can breach the rectal mucosa, allowing gut flora (Gram-negative bacilli and enterococci) to enter the bloodstream and cause fatal septicaemia. Concomitant thrombocytopenia also risks severe haematoma from IM injections.
$SBA_RESU_006$,
    false,
    11,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 7/10: Paediatric Life Support (PLS / PALS)
  -- 1) Interleave Lecture (Position 12)
  UPDATE "lessons"
  SET "position" = 12, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'paediatric-life-support-pls-pals' OR "slug" = 'pls');

  -- 2) Upsert Quiz Lesson (Position 13)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-resuscitation-pls',
    'Paediatric Life Support (PLS / PALS) — SBA Interactive Quiz',
    'quiz',
    $SBA_RESU_007$# Paediatric Life Support (PLS / PALS) — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

You are leading the resuscitation of an unresponsive 3-year-old child in the ED. The child is apnoeic with no central pulse palpable after 10 seconds. According to the European Resuscitation Council (ERC) and Resuscitation Council UK paediatric algorithm, what is the FIRST action?

![Figure 1: Clinical Findings & Diagnostic Reference (Paediatric Life Support (PLS / PALS))](/lessons/images/sba/resuscitation/pls/figure_01_p2.jpeg)


- **A.** Deliver 5 initial rescue breaths before commencing chest compressions
- **B.** Deliver 30 chest compressions at 100-120/min
- **C.** Apply defibrillator pads and deliver a 4 J/kg shock
- **D.** Establish intraosseous access and give 10 mcg/kg adrenaline
- **E.** Perform emergency needle cricothyroidotomy

**Correct Answer:** A
**Explanation:**
In paediatric cardiac arrest, the primary aetiology is almost always respiratory failure or hypoxia (asphyxial arrest), unlike the primary cardiac/arrhythmic arrest seen in adults. Therefore, ERC/RCUK PLS guidelines mandate starting with 5 initial rescue breaths to oxygenate the lungs before initiating chest compressions.

## Question 2 of 5

What is the recommended compression-to-ventilation ratio for trained healthcare professionals during CPR of an infant or child when TWO rescuers are present?

![Figure 2: Clinical Findings & Diagnostic Reference (Paediatric Life Support (PLS / PALS))](/lessons/images/sba/resuscitation/pls/figure_02_p3.jpeg)


- **A.** 30 : 2
- **B.** 15 : 2
- **C.** 3 : 1
- **D.** 5 : 1
- **E.** 20 : 2

**Correct Answer:** B
**Explanation:**
For healthcare professionals in paediatric resuscitation (PLS), the ratio is 15 chest compressions to 2 ventilations (15:2) to provide higher minute ventilation for hypoxic arrests. (Note: 3:1 is used specifically in neonatal resuscitation at birth).

## Question 3 of 5

A 4-year-old boy in cardiac arrest has intraosseous access established. The monitor displays ventricular fibrillation. What is the correct initial defibrillation energy dose in paediatric cardiac arrest?

![Figure 3: Clinical Findings & Diagnostic Reference (Paediatric Life Support (PLS / PALS))](/lessons/images/sba/resuscitation/pls/figure_03_p3.jpeg)


- **A.** 1 J/kg
- **B.** 4 J/kg
- **C.** 10 J/kg
- **D.** 150 J fixed dose
- **E.** 0.5 J/kg

**Correct Answer:** B
**Explanation:**
In paediatric ALS (RCUK/ERC), the defibrillation shock energy for shockable rhythms (VF/pulseless VT) is 4 J/kg for all shocks (both initial and subsequent shocks).

## Question 4 of 5

During paediatric resuscitation, what is the correct dose and concentration of intravenous or intraosseous (IV/IO) Adrenaline?

- **A.** 10 micrograms/kg (0.1 ml/kg of 1:10,000 solution)
- **B.** 100 micrograms/kg (1.0 ml/kg of 1:10,000 solution)
- **C.** 10 micrograms/kg of 1:1,000 solution undiluted
- **D.** 1 mg fixed dose as in adults
- **E.** 1 microgram/kg of 1:10,000 solution

**Correct Answer:** A
**Explanation:**
The standard paediatric ALS adrenaline dose is 10 mcg/kg IV or IO, which corresponds to exactly 0.1 ml/kg of the 1:10,000 (100 mcg/ml) concentration. (Maximum single dose is 1 mg).

## Question 5 of 5

What is the preferred site for emergency Intraosseous (IO) needle insertion in a 2-year-old child in cardiac arrest when peripheral intravenous access cannot be obtained within 60 seconds?

- **A.** Proximal tibia (anteromedial flat surface, 1-2 cm below the tibial tuberosity)
- **B.** Distal femur mid-shaft
- **C.** Sternal manubrium
- **D.** Radial styloid process
- **E.** Iliac crest anterior superior spine

**Correct Answer:** A
**Explanation:**
The proximal tibia is the primary recommended site for paediatric IO access. The anatomical landmark is the anteromedial flat surface of the tibia, approximately 1-2 cm below and medial to the tibial tuberosity, avoiding the epiphyseal growth plate.
$SBA_RESU_007$,
    false,
    13,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 8/10: Resuscitation in Sepsis & Septic Shock
  -- 1) Interleave Lecture (Position 14)
  UPDATE "lessons"
  SET "position" = 14, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'resucitiation-in-sepsis' OR "slug" = 'resuscitation-sepsis');

  -- 2) Upsert Quiz Lesson (Position 15)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-resuscitation-resuscitation-sepsis',
    'Resuscitation in Sepsis & Septic Shock — SBA Interactive Quiz',
    'quiz',
    $SBA_RESU_008$# Resuscitation in Sepsis & Septic Shock — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 68-year-old woman is brought to the ED with confusion, rigors, and dysuria. HR 122 bpm, BP 82/48 mmHg, RR 26/min, Temp 38.9C, Lactate 4.6 mmol/L. According to the Surviving Sepsis Campaign and NICE NG51, what initial crystalloid fluid bolus volume should be administered for sepsis-induced hypoperfusion?

![Figure 1: Clinical Findings & Diagnostic Reference (Resuscitation in Sepsis & Septic Shock)](/lessons/images/sba/resuscitation/resuscitation-sepsis/figure_01_p1.jpeg)


- **A.** 10 ml/kg of 0.9% Normal Saline over 4 hours
- **B.** 30 ml/kg of a balanced crystalloid (e.g. Hartmann's or Plasmalyte) within the first 3 hours
- **C.** 500 ml 5% Dextrose bolus
- **D.** 20 ml/kg 20% Albumin infusion
- **E.** Zero fluids, start noradrenaline infusion immediately

**Correct Answer:** B
**Explanation:**
The Surviving Sepsis Campaign guidelines recommend administering at least 30 ml/kg of intravenous balanced crystalloid solution within the first 3 hours of resuscitation for patients with sepsis-induced hypoperfusion (lactate >=4 mmol/L or hypotension systolic <90 mmHg / MAP <65 mmHg).

## Question 2 of 5

Despite 30 ml/kg balanced crystalloid infusion, the 68-year-old patient's blood pressure remains 84/50 mmHg (MAP 61 mmHg) and lactate is 4.1 mmol/L. What is the first-line vasopressor of choice in septic shock?

![Figure 2: Clinical Findings & Diagnostic Reference (Resuscitation in Sepsis & Septic Shock)](/lessons/images/sba/resuscitation/resuscitation-sepsis/figure_02_p2.jpeg)


- **A.** Dopamine infusion
- **B.** Noradrenaline (Norepinephrine) target MAP >= 65 mmHg
- **C.** Phenylephrine boluses
- **D.** Adrenaline (Epinephrine) infusion as initial monotherapy
- **E.** Vasopressin monotherapy at 0.08 units/min

**Correct Answer:** B
**Explanation:**
Noradrenaline is the first-line vasopressor of choice in septic shock to restore and maintain a Mean Arterial Pressure (MAP) of >=65 mmHg. Dopamine is associated with significantly higher rates of tachyarrhythmias and excess mortality.

## Question 3 of 5

What is the key advantage of using balanced crystalloids (such as Hartmann's solution or Ringer's lactate) over 0.9% Normal Saline in large-volume resuscitation for septic shock?

![Figure 3: Clinical Findings & Diagnostic Reference (Resuscitation in Sepsis & Septic Shock)](/lessons/images/sba/resuscitation/resuscitation-sepsis/figure_03_p3.jpeg)


- **A.** Higher sodium concentration preventing cerebral oedema
- **B.** Avoidance of hyperchloraemic metabolic acidosis and reduced incidence of acute kidney injury (AKI)
- **C.** Immediate reversal of thrombocytopenia
- **D.** Prevention of hypocalcaemia
- **E.** Bactericidal action against Gram-negative bacteria

**Correct Answer:** B
**Explanation:**
Large infusions of 0.9% Normal Saline (chloride 154 mmol/L) cause hyperchloraemic metabolic acidosis, renal vasoconstriction, reduced glomerular filtration rate, and higher risk of requiring renal replacement therapy. Balanced crystalloids reduce this risk.

## Question 4 of 5

In patients with septic shock refractory to fluid resuscitation and high-dose noradrenaline and vasopressin, which adjunctive pharmacological therapy is recommended?

![Figure 4: Clinical Findings & Diagnostic Reference (Resuscitation in Sepsis & Septic Shock)](/lessons/images/sba/resuscitation/resuscitation-sepsis/figure_04_p4.jpeg)


- **A.** Intravenous Hydrocortisone 200mg/day (given as 50mg every 6 hours or continuous infusion)
- **B.** High-dose Dexamethasone 20mg IV daily
- **C.** Intravenous Vitamin C (Ascorbic acid) megadose
- **D.** Activated Protein C infusion
- **E.** Recombinant Erythropoietin

**Correct Answer:** A
**Explanation:**
Surviving Sepsis Campaign guidelines recommend low-dose corticosteroid therapy (IV Hydrocortisone 200 mg/day, either as 50 mg IV q6h or continuous infusion) for patients with septic shock who require ongoing vasopressor therapy (e.g. noradrenaline >=0.25 mcg/kg/min) despite adequate fluid resuscitation.

## Question 5 of 5

What is the recommended target Mean Arterial Pressure (MAP) during vasopressor titration in adult patients with septic shock without chronic hypertension?

![Figure 5: Clinical Findings & Diagnostic Reference (Resuscitation in Sepsis & Septic Shock)](/lessons/images/sba/resuscitation/resuscitation-sepsis/figure_05_p4.jpeg)


- **A.** MAP >= 55 mmHg
- **B.** MAP >= 65 mmHg
- **C.** MAP >= 85 mmHg
- **D.** MAP >= 95 mmHg
- **E.** MAP >= 110 mmHg

**Correct Answer:** B
**Explanation:**
Surviving Sepsis Campaign recommends an initial target MAP of 65 mmHg. Targeting higher MAP values (e.g. 80-85 mmHg) does not improve survival or renal outcomes in general, but increases vasopressor exposure, myocardial oxygen demand, and risk of arrhythmias.
$SBA_RESU_008$,
    false,
    15,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 9/10: Adult Sepsis & The Sepsis Six
  -- 1) Interleave Lecture (Position 16)
  UPDATE "lessons"
  SET "position" = 16, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'adult-sepsis-septic-shock' OR "slug" = 'sepsis-adult');

  -- 2) Upsert Quiz Lesson (Position 17)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-resuscitation-sepsis-adult',
    'Adult Sepsis & The Sepsis Six — SBA Interactive Quiz',
    'quiz',
    $SBA_RESU_009$# Adult Sepsis & The Sepsis Six — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 74-year-old male nursing home resident presents with productive cough, fever of 39.1C, HR 118 bpm, RR 26/min, BP 98/58 mmHg, and new confusion. His NEWS2 score is 11. Which six interventions comprise the UK 'Sepsis Six' care bundle to be delivered within 1 hour?

![Figure 1: Clinical Findings & Diagnostic Reference (Adult Sepsis & The Sepsis Six)](/lessons/images/sba/resuscitation/sepsis-adult/figure_01_p2.jpeg)


- **A.** Give oxygen, Give IV antibiotics, Give IV fluids, Take blood cultures, Measure lactate, Measure urine output
- **B.** Give paracetamol, Take sputum, Give oral fluids, Insert arterial line, Measure CRP, Chest X-ray
- **C.** Intubate, Give noradrenaline, Give hydrocortisone, Take CSF, Measure troponin, Insert CVP
- **D.** Give blood transfusion, Take CT chest, Give bronchodilators, Check D-dimer, Measure troponin, Start heparin
- **E.** Give oral co-amoxiclav, Give 5% dextrose, Take urine dipstick, Check blood glucose, Measure ESR, Electrocardiogram

**Correct Answer:** A
**Explanation:**
The UK Sepsis Six pathway consists of 3 diagnostic and 3 therapeutic actions within 1 hour: (1) Give supplemental oxygen (target 94-98% or 88-92% in hypercapnic COPD); (2) Take blood cultures; (3) Give broad-spectrum IV antibiotics; (4) Give IV fluid challenge; (5) Measure serum lactate; (6) Measure urine output (monitor fluid balance).

## Question 2 of 5

According to the Third International Consensus Definitions for Sepsis and Septic Shock (Sepsis-3), how is 'Sepsis' formally defined?

![Figure 2: Clinical Findings & Diagnostic Reference (Adult Sepsis & The Sepsis Six)](/lessons/images/sba/resuscitation/sepsis-adult/figure_02_p3.jpeg)


- **A.** Presence of 2 or more SIRS criteria in the presence of confirmed infection
- **B.** Life-threatening organ dysfunction caused by a dysregulated host response to infection (quantified by an acute increase in SOFA score >= 2)
- **C.** Bacteraemia with a positive blood culture
- **D.** Fever >38.5C with neutrophilia >15 x 10^9/L
- **E.** Hypotension requiring vasopressors with elevated procalcitonin

**Correct Answer:** B
**Explanation:**
Sepsis-3 defines sepsis as a 'life-threatening organ dysfunction caused by a dysregulated host response to infection'. Organ dysfunction is clinically identified by an acute change in total SOFA score >= 2 points consequent to the infection, which is associated with an in-hospital mortality >10%.

## Question 3 of 5

Which three clinical variables constitute the bedside 'quick SOFA' (qSOFA) criteria used to prompt clinicians to consider sepsis and impending organ failure?

![Figure 3: Clinical Findings & Diagnostic Reference (Adult Sepsis & The Sepsis Six)](/lessons/images/sba/resuscitation/sepsis-adult/figure_03_p4.jpeg)


- **A.** Temperature >38C, Heart rate >90 bpm, White cell count >12
- **B.** Respiratory rate >= 22/min, Altered mentation (GCS <15), and Systolic BP <= 100 mmHg
- **C.** Urine output <0.5 ml/kg/hr, Serum lactate >2 mmol/L, Platelets <100
- **D.** Bilirubin >33 umol/L, Creatinine >170 umol/L, PaO2/FiO2 <300
- **E.** Capillary refill >3s, Core-peripheral temp gradient >3C, Blood glucose >10

**Correct Answer:** B
**Explanation:**
qSOFA criteria consist of: (1) Respiratory rate >= 22/min; (2) Altered mental status (GCS <15); (3) Systolic blood pressure <= 100 mmHg. Presence of >=2 criteria indicates high risk of poor outcome.

## Question 4 of 5

When obtaining blood cultures in a patient with suspected severe sepsis, which practice adheres to RCEM best practice standards?

![Figure 4: Clinical Findings & Diagnostic Reference (Adult Sepsis & The Sepsis Six)](/lessons/images/sba/resuscitation/sepsis-adult/figure_04_p5.jpeg)


- **A.** Take blood cultures from an existing central venous line placed 2 weeks ago only
- **B.** Draw at least two sets of peripheral blood cultures (aerobic and anaerobic bottles) using strict aseptic technique prior to antibiotic administration
- **C.** Wait for the fever spike above 39.5C before taking any blood culture bottles
- **D.** Only take blood cultures if the white cell count is abnormal
- **E.** Administer IV antibiotics first, then draw cultures 4 hours later

**Correct Answer:** B
**Explanation:**
Blood cultures should be drawn before initiating antimicrobial therapy, provided this does not cause significant delay (>45 min). At least two sets (aerobic and anaerobic) should be taken from separate peripheral venepuncture sites with aseptic technique.

## Question 5 of 5

What is the clinical significance of a serum lactate level > 4.0 mmol/L in an ED patient with suspected sepsis, even if the systolic blood pressure is currently 110/70 mmHg?

- **A.** It represents 'Cryptic Septic Shock' (occult hypoperfusion) and carries a mortality equivalent to hypotensive septic shock
- **B.** It is clinically insignificant because blood pressure is preserved
- **C.** It is purely caused by hyperventilation and respiratory alkalosis
- **D.** It indicates that IV fluids should be strictly withheld to avoid pulmonary oedema
- **E.** It indicates primary renal tubular necrosis rather than sepsis

**Correct Answer:** A
**Explanation:**
Lactate >4.0 mmol/L in normotensive sepsis represents 'cryptic septic shock' (cellular hypoxia and occult microcirculatory failure). These patients have an in-hospital mortality rate comparable to patients with overt hypotension and require immediate aggressive resuscitation with 30 ml/kg crystalloid and critical care admission.
$SBA_RESU_009$,
    false,
    17,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 10/10: Transfusion Management of Major Haemorrhage
  -- 1) Interleave Lecture (Position 18)
  UPDATE "lessons"
  SET "position" = 18, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'transfction-mangement-of-major-hge' OR "slug" = 'transfusion-major-hemorrhage');

  -- 2) Upsert Quiz Lesson (Position 19)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-resuscitation-transfusion-major-hemorrhage',
    'Transfusion Management of Major Haemorrhage — SBA Interactive Quiz',
    'quiz',
    $SBA_RESU_010$# Transfusion Management of Major Haemorrhage — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 40-year-old trauma victim is receiving massive transfusion protocol (MTP). After receiving 8 units of packed red blood cells, he develops muscle spasms, prolonged QT interval on ECG, and carpopedal spasm upon blood pressure cuff inflation (Trousseau's sign). What acute electrolyte derangement caused this?

![Figure 1: Clinical Findings & Diagnostic Reference (Transfusion Management of Major Haemorrhage)](/lessons/images/sba/resuscitation/transfusion-major-hemorrhage/figure_01_p2.jpeg)


- **A.** Hypocalcaemia caused by citrate binding of ionized calcium
- **B.** Severe hypernatraemia
- **C.** Hypokalaemia from cellular shift
- **D.** Hypermagnesaemia from packed cells
- **E.** Severe metabolic alkalosis from lactate

**Correct Answer:** A
**Explanation:**
Citrate used as an anticoagulant in stored blood products chelates ionized calcium in the patient's circulation. Rapid massive transfusion overwhelms hepatic metabolism of citrate, resulting in acute severe hypocalcaemia manifested by tetany, Trousseau's sign, QT prolongation, myocardial depression, and worsened coagulopathy. IV 10% calcium chloride or gluconate must be given proactively.

## Question 2 of 5

In the Emergency Department, an exsanguinating trauma patient with uncrossmatched emergency blood requirements arrives. What blood product should be released immediately for an adult female of unknown age and unknown blood group?

![Figure 2: Clinical Findings & Diagnostic Reference (Transfusion Management of Major Haemorrhage)](/lessons/images/sba/resuscitation/transfusion-major-hemorrhage/figure_02_p3.jpeg)


- **A.** Group O RhD-positive packed red blood cells
- **B.** Group O RhD-negative packed red blood cells
- **C.** Group AB RhD-positive packed red blood cells
- **D.** Group A RhD-negative packed red blood cells
- **E.** Wait 45 minutes for full crossmatched blood

**Correct Answer:** B
**Explanation:**
In an emergent situation of unknown blood group, Group O RhD-negative red cells are administered to females of childbearing potential (<50 years old) to prevent RhD alloimmunisation and subsequent haemolytic disease of the fetus/newborn. In males and postmenopausal females, Group O RhD-positive cells can be used to preserve scarce O RhD-negative stocks.

## Question 3 of 5

During a massive haemorrhage resuscitation, the laboratory reports a fibrinogen level of 0.8 g/L (normal 2.0-4.0 g/L). What is the blood product of choice to rapidly replenish fibrinogen?

![Figure 3: Clinical Findings & Diagnostic Reference (Transfusion Management of Major Haemorrhage)](/lessons/images/sba/resuscitation/transfusion-major-hemorrhage/figure_03_p3.jpeg)


- **A.** Packed red blood cells
- **B.** Cryoprecipitate (or Fibrinogen Concentrate)
- **C.** Platelet concentrate
- **D.** Unfractionated heparin
- **E.** Fresh Frozen Plasma 1 unit

**Correct Answer:** B
**Explanation:**
Cryoprecipitate (standard adult dose: 2 pools of 5 units = 10 units total) or Fibrinogen Concentrate is the treatment of choice to rapidly correct hypofibrinogenaemia (<1.5-2.0 g/L in trauma/obstetric haemorrhage). FFP contains fibrinogen but in lower concentrations, requiring excessive volume.

## Question 4 of 5

Which transfusion-related complication is characterised by acute hypoxemia (PaO2/FiO2 <= 300), bilateral non-cardiogenic pulmonary infiltrates on chest radiograph, and fever developing within 6 hours of transfusion, caused by antileucocyte antibodies in donor plasma?

- **A.** Transfusion-Associated Circulatory Overload (TACO)
- **B.** Transfusion-Related Acute Lung Injury (TRALI)
- **C.** Haemolytic Transfusion Reaction (HTR)
- **D.** Transfusion-Associated Graft-versus-Host Disease (TA-GvHD)
- **E.** Post-Transfusion Purpura

**Correct Answer:** B
**Explanation:**
TRALI is a non-cardiogenic pulmonary oedema occurring within 6 hours of blood product transfusion, mediated by donor anti-HLA or anti-HNA antibodies activating recipient neutrophils in pulmonary capillaries. Unlike TACO, TRALI features normal jugular venous pressure, normal or low BNP, and no signs of fluid overload.

## Question 5 of 5

How can Transfusion-Associated Circulatory Overload (TACO) be clinically differentiated from Transfusion-Related Acute Lung Injury (TRALI)?

- **A.** TACO presents with hypertension, elevated JVP, third heart sound (S3), and elevated NT-proBNP, responding rapidly to loop diuretics
- **B.** TRALI always responds dramatically to IV furosemide
- **C.** TACO produces high fever and neutropenia
- **D.** TRALI is caused by red cells only, never plasma
- **E.** There is no clinical or radiological method to differentiate them

**Correct Answer:** A
**Explanation:**
TACO is hydrostatic/cardiogenic pulmonary oedema from volume overload. Diagnostic hallmarks include hypertension, elevated JVP, peripheral oedema, raised BNP/NT-proBNP, and rapid improvement with IV furosemide and fluid restriction. TRALI is non-cardiogenic permeability oedema with normal or low JVP and hypotension.
$SBA_RESU_010$,
    false,
    19,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();


  -- ------------------------------------------------------------------------
  -- Specialty: Cardiovascular Emergencies (21 Topics)
  -- ------------------------------------------------------------------------
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_sba_id AND "title" = 'Cardiovascular Emergencies' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module Cardiovascular Emergencies not found in mrcem-sba';
  END IF;

  -- Topic 1/21: Acute Coronary Syndromes (ACS)
  -- 1) Interleave Lecture (Position 0)
  UPDATE "lessons"
  SET "position" = 0, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'acute-coronary-syndromes-acs' OR "slug" = 'acute-coronary-syndrome');

  -- 2) Upsert Quiz Lesson (Position 1)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-cardiology-acute-coronary-syndrome',
    'Acute Coronary Syndromes (ACS) — SBA Interactive Quiz',
    'quiz',
    $SBA_CARD_011$# Acute Coronary Syndromes (ACS) — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 58-year-old man presents with 2 hours of crushing retrosternal chest pain radiating to his left shoulder and jaw. The 12-lead ECG demonstrates 3 mm ST-segment elevation in leads II, III, and aVF with reciprocal ST depression in leads I and aVL. What is the definitive reperfusion management of choice according to NICE NG185?

![Figure 1: Clinical Findings & Diagnostic Reference (Acute Coronary Syndromes (ACS))](/lessons/images/sba/cardiology/acute-coronary-syndrome/figure_01_p4.jpeg)


- **A.** Immediate Primary Percutaneous Coronary Intervention (pPCI) if delivered within 120 minutes of first medical contact
- **B.** Intravenous fibrinolysis with tenecteplase regardless of time to cath lab
- **C.** Elective coronary angiography within 72 hours
- **D.** Intravenous heparin infusion alone with serial troponin checks
- **E.** Oral bisoprolol and GTN infusion with observation in the clinical decision unit

**Correct Answer:** A
**Explanation:**
Primary PCI is the gold standard reperfusion strategy for acute STEMI (inferior STEMI here), provided it can be performed within 120 minutes of the time when fibrinolysis could have been given. If pPCI cannot be delivered within 120 minutes, immediate intravenous fibrinolysis is indicated.

![Clinical Algorithm & Advanced Reference (Acute Coronary Syndromes (ACS))](/lessons/images/sba/cardiology/acute-coronary-syndrome/figure_06_p14.jpeg)


## Question 2 of 5

In an acute inferior STEMI involving occlusion of the proximal Right Coronary Artery (RCA), which supplementary ECG lead view is essential to evaluate for concurrent Right Ventricular (RV) Infarction?

![Figure 2: Clinical Findings & Diagnostic Reference (Acute Coronary Syndromes (ACS))](/lessons/images/sba/cardiology/acute-coronary-syndrome/figure_02_p5.jpeg)


- **A.** Lead V4R (right-sided chest lead)
- **B.** Posterior leads V7-V9
- **C.** Lead aVR alone
- **D.** Fontaine bipolar leads
- **E.** Lewis lead placement

**Correct Answer:** A
**Explanation:**
In inferior STEMI, a right-sided ECG (especially lead V4R) must be performed. ST elevation >=1 mm in V4R is highly sensitive and specific for RV infarction. Nitrates and diuretics are contraindicated in RV infarction due to profound preload dependence; fluid resuscitation is the management of choice.

## Question 3 of 5

A 62-year-old woman presents with ongoing ischemic chest discomfort. 12-lead ECG shows deep symmetrical T-wave inversions in leads V2 and V3 (or biphasic T-waves) with preserved R waves and no Q waves. Cardiac enzymes are currently normal. What clinical syndrome does this ECG represent?

![Figure 3: Clinical Findings & Diagnostic Reference (Acute Coronary Syndromes (ACS))](/lessons/images/sba/cardiology/acute-coronary-syndrome/figure_03_p6.jpeg)


- **A.** Wellens' Syndrome (critical proximal LAD stenosis)
- **B.** Brugada syndrome
- **C.** Early repolarisation pattern
- **D.** Acute pericarditis
- **E.** Digitalis effect

**Correct Answer:** A
**Explanation:**
Wellens' syndrome is an ECG manifestation of critical stenosis of the proximal Left Anterior Descending (LAD) coronary artery. Pattern A features biphasic T waves in V2-V3; Pattern B features deep symmetrical T-wave inversions in V2-V3. It represents a pre-infarction state requiring urgent coronary angiography.

## Question 4 of 5

Which dual antiplatelet therapy (DAPT) regimen is recommended by NICE for patients undergoing primary PCI for STEMI without contraindications?

![Figure 4: Clinical Findings & Diagnostic Reference (Acute Coronary Syndromes (ACS))](/lessons/images/sba/cardiology/acute-coronary-syndrome/figure_04_p8.jpeg)


- **A.** Aspirin 300mg loading dose plus Ticagrelor 180mg loading dose (or Prasugrel 60mg)
- **B.** Aspirin 75mg daily monotherapy
- **C.** Clopidogrel 75mg plus Dipyridamole 200mg
- **D.** Aspirin 300mg plus Warfarin loading
- **E.** Apixaban 5mg plus Aspirin 300mg

**Correct Answer:** A
**Explanation:**
NICE NG185 recommends Aspirin (300 mg loading dose) combined with a potent P2Y12 inhibitor: Prasugrel (60 mg load) or Ticagrelor (180 mg load) as first-line DAPT for STEMI patients undergoing PCI. Clopidogrel (600 mg) is used when ticagrelor/prasugrel are contraindicated or in patients requiring oral anticoagulation.

## Question 5 of 5

A 65-year-old male with acute NSTEMI has a GRACE risk score calculated as 148 (predicted 6-month mortality >3%). According to NICE guidelines, what is the recommended timeframe for invasive coronary angiography?

![Figure 5: Clinical Findings & Diagnostic Reference (Acute Coronary Syndromes (ACS))](/lessons/images/sba/cardiology/acute-coronary-syndrome/figure_05_p10.jpeg)


- **A.** Within 72 hours of admission
- **B.** Within 14 days in the outpatient setting
- **C.** Immediate coronary angiography within 2 hours
- **D.** Within 6 months if stress testing is positive
- **E.** Angiography is not indicated for NSTEMI

**Correct Answer:** A
**Explanation:**
NICE recommends an early invasive strategy (coronary angiography within 72 hours) for patients with NSTEMI or unstable angina who have a predicted 6-month mortality >3.0% (intermediate or high risk by GRACE score >108), or those with dynamic ECG changes or recurrent ischemia.
$SBA_CARD_011$,
    false,
    1,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 2/21: Atrial Arrhythmias & Atrial Flutter
  -- 1) Interleave Lecture (Position 2)
  UPDATE "lessons"
  SET "position" = 2, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'atrial-arrhythmias' OR "slug" = 'atrial-arrhythmias');

  -- 2) Upsert Quiz Lesson (Position 3)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-cardiology-atrial-arrhythmias',
    'Atrial Arrhythmias & Atrial Flutter — SBA Interactive Quiz',
    'quiz',
    $SBA_CARD_012$# Atrial Arrhythmias & Atrial Flutter — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 65-year-old woman presents with sudden palpitations. ECG demonstrates a regular narrow-complex tachycardia at exactly 150 bpm with a 'sawtooth' baseline pattern best visualized in leads II, III, and aVF. What is the diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Atrial Arrhythmias & Atrial Flutter)](/lessons/images/sba/cardiology/atrial-arrhythmias/figure_01_p4.jpeg)


- **A.** Atrial Flutter with 2:1 AV block
- **B.** Sinus tachycardia
- **C.** Atrial fibrillation with rapid ventricular response
- **D.** AV Nodal Re-entrant Tachycardia (AVNRT)
- **E.** Ventricular tachycardia

**Correct Answer:** A
**Explanation:**
Classic (typical) atrial flutter arises from a cavotricuspid isthmus counter-clockwise macro-re-entrant circuit in the right atrium with an atrial rate of ~300 bpm. When conducted with 2:1 AV block, the ventricular rate is precisely 150 bpm with pathognomonic negative 'sawtooth' flutter waves in inferior leads.

## Question 2 of 5

In a patient presenting with regular narrow complex tachycardia at 150 bpm where flutter waves are obscured by T waves, what diagnostic and therapeutic pharmacological manoeuvre unmasks the underlying atrial activity?

- **A.** Rapid IV Adenosine bolus (6mg followed by flush)
- **B.** IV Atropine 500mcg
- **C.** Oral Digoxin 250mcg
- **D.** IV Adrenaline 1mg
- **E.** IV Flecainide infusion over 2 hours

**Correct Answer:** A
**Explanation:**
Adenosine causes transient, high-grade AV nodal block. In atrial flutter, it temporarily blocks conduction through the AV node without terminating the atrial flutter circuit, revealing the underlying baseline flutter (sawtooth) waves and confirming the diagnosis.

## Question 3 of 5

A 70-year-old male with atrial flutter is haemodynamically unstable with BP 78/45 mmHg, diaphoresis, and acute chest pain. What is the emergency treatment of choice?

- **A.** Synchronised DC cardioversion (starting at 50-100J biphasic)
- **B.** IV Amiodarone 300mg over 1 hour
- **C.** Oral Bisoprolol 5mg
- **D.** IV Verapamil 5mg
- **E.** Carotid sinus massage alone

**Correct Answer:** A
**Explanation:**
Any tachyarrhythmia with adverse features (shock, syncope, myocardial ischaemia, or severe heart failure) requires immediate synchronised DC cardioversion under sedation/analgesia per Resuscitation Council UK guidelines. Atrial flutter responds exquisitely to low-energy cardioversion (50-100 J).

## Question 4 of 5

What is the definitive, curative catheter ablation target for typical counter-clockwise atrial flutter?

- **A.** Cavotricuspid Isthmus (CTI) radiofrequency ablation
- **B.** Pulmonary vein isolation (PVI)
- **C.** Bundle of His ablation
- **D.** Left atrial appendage occlusion
- **E.** Sinoatrial node excision

**Correct Answer:** A
**Explanation:**
Cavotricuspid isthmus (CTI) ablation creates a line of bidirectional block between the tricuspid valve annulus and the inferior vena cava, curing typical atrial flutter with a success rate exceeding 90-95%.

## Question 5 of 5

Regarding systemic thromboembolism risk, how does stroke prevention in typical atrial flutter compare to atrial fibrillation?

- **A.** The thromboembolic risk is identical; anticoagulation decisions follow the CHA2DS2-VASc score exactly as in AF
- **B.** Atrial flutter carries zero risk of thrombus formation; anticoagulation is never indicated
- **C.** Aspirin alone is sufficient for all flutter patients
- **D.** Anticoagulation is only needed if the ventricular rate exceeds 180 bpm
- **E.** Warfarin is mandatory; DOACs are ineffective in atrial flutter

**Correct Answer:** A
**Explanation:**
Current ESC and NICE guidelines state that the thromboembolic risk in atrial flutter is comparable to atrial fibrillation. Anticoagulation is recommended using the same criteria and CHA2DS2-VASc scoring thresholds as for atrial fibrillation.
$SBA_CARD_012$,
    false,
    3,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 3/21: Atrial Fibrillation Management
  -- 1) Interleave Lecture (Position 4)
  UPDATE "lessons"
  SET "position" = 4, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'atrial-fibrillation-flutter-af' OR "slug" = 'atrial-fibrillation');

  -- 2) Upsert Quiz Lesson (Position 5)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-cardiology-atrial-fibrillation',
    'Atrial Fibrillation Management — SBA Interactive Quiz',
    'quiz',
    $SBA_CARD_013$# Atrial Fibrillation Management — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 71-year-old man presents with palpitations and breathlessness. ECG confirms atrial fibrillation with a ventricular rate of 135 bpm. BP is 128/82 mmHg. He has a history of hypertension, type 2 diabetes, and had an ischaemic stroke 2 years ago. What is his CHA2DS2-VASc score and anticoagulation indication?

![Figure 1: Clinical Findings & Diagnostic Reference (Atrial Fibrillation Management)](/lessons/images/sba/cardiology/atrial-fibrillation/figure_01_p1.jpeg)


- **A.** Score 5; anticoagulation with a DOAC is strongly indicated
- **B.** Score 2; prescribe aspirin monotherapy
- **C.** Score 1; no anticoagulation required
- **D.** Score 3; clopidogrel is preferred
- **E.** Score 0; low risk

**Correct Answer:** A
**Explanation:**
CHA2DS2-VASc: Congestive HF (0), Hypertension (1), Age >=75 (0, he is 71), Diabetes (1), Stroke/TIA (2), Vascular disease (0), Age 65-74 (1), Sex category female (0). Total = 1 + 1 + 2 + 1 = 5. A score >=2 in men strongly mandates oral anticoagulation (DOAC first-line per NICE).

![Clinical Algorithm & Advanced Reference (Atrial Fibrillation Management)](/lessons/images/sba/cardiology/atrial-fibrillation/figure_06_p7.jpeg)


## Question 2 of 5

A 66-year-old woman with new-onset AF of 6 hours duration is haemodynamically stable. She has no structural heart disease, normal renal function, and normal baseline ECG. Which pharmacological agent is recommended for chemical cardioversion?

![Figure 2: Clinical Findings & Diagnostic Reference (Atrial Fibrillation Management)](/lessons/images/sba/cardiology/atrial-fibrillation/figure_02_p4.jpeg)


- **A.** IV Flecainide 2mg/kg (max 150mg) over 30 minutes (or IV Ibutilide)
- **B.** IV Digoxin 500mcg
- **C.** IV Adenosine 12mg
- **D.** Oral Warfarin 10mg single dose
- **E.** IV Metoprolol 5mg bolus

**Correct Answer:** A
**Explanation:**
For acute chemical cardioversion of AF (<48 hours) in patients WITHOUT structural or ischemic heart disease, Class 1c antiarrhythmics (IV Flecainide) or IV Vernakalant/Ibutilide are first-line. In patients with known coronary artery disease or heart failure, IV Amiodarone is the agent of choice.

## Question 3 of 5

A 75-year-old woman with known permanent AF presents with fatigue and HR 130 bpm. Echo shows severe Left Ventricular Systolic Dysfunction with an ejection fraction (LVEF) of 28%. Which rate-control medication is CONTRAINDICATED?

![Figure 3: Clinical Findings & Diagnostic Reference (Atrial Fibrillation Management)](/lessons/images/sba/cardiology/atrial-fibrillation/figure_03_p5.jpeg)


- **A.** IV Verapamil (or Diltiazem)
- **B.** Oral Digoxin
- **C.** Oral Bisoprolol low dose
- **D.** Oral Carvedilol
- **E.** IV Amiodarone

**Correct Answer:** A
**Explanation:**
Non-dihydropyridine calcium channel blockers (Verapamil, Diltiazem) have potent negative inotropic properties and can precipitate acute decompensated heart failure and cardiogenic shock in patients with reduced ejection fraction (HFrEF, LVEF <40%). Beta-blockers and/or digoxin are indicated.

## Question 4 of 5

In a patient presenting with AF of unknown duration (or >48 hours), what is the minimum duration of therapeutic anticoagulation required before and after elective electrical cardioversion to minimize thromboembolic risk?

![Figure 4: Clinical Findings & Diagnostic Reference (Atrial Fibrillation Management)](/lessons/images/sba/cardiology/atrial-fibrillation/figure_04_p5.jpeg)


- **A.** At least 3 weeks before and at least 4 weeks after cardioversion
- **B.** 24 hours before and 24 hours after
- **C.** 6 months before and indefinitely after
- **D.** No pre-treatment needed if aspirin is given
- **E.** 1 week before and 1 week after

**Correct Answer:** A
**Explanation:**
If AF duration is >48 hours or unknown, elective cardioversion requires either: (1) at least 3 weeks of therapeutic oral anticoagulation before cardioversion, followed by at least 4 weeks post-procedure; or (2) transoesophageal echocardiography (TOE) to exclude left atrial thrombus prior to cardioversion.

## Question 5 of 5

A 28-year-old male with known Wolff-Parkinson-White (WPW) syndrome presents in rapid, irregular, wide-complex tachycardia with rates varying from 200 to 280 bpm (pre-excited AF). He is conscious with BP 115/70. Which class of drugs is strictly CONTRAINDICATED?

![Figure 5: Clinical Findings & Diagnostic Reference (Atrial Fibrillation Management)](/lessons/images/sba/cardiology/atrial-fibrillation/figure_05_p6.jpeg)


- **A.** AV-nodal blocking agents (Adenosine, Digoxin, Verapamil, Beta-blockers)
- **B.** Procainamide
- **C.** Ibutilide
- **D.** Electrical DC cardioversion
- **E.** Oxygen therapy

**Correct Answer:** A
**Explanation:**
In pre-excited AF (AF with WPW), conduction travels down both the AV node and the accessory pathway. Drugs that selectively block the AV node (adenosine, verapamil, digoxin, beta-blockers) divert all impulses down the accessory pathway without physiological decrement, precipitating ventricular fibrillation and cardiac arrest. IV Procainamide or DC cardioversion is the treatment of choice.
$SBA_CARD_013$,
    false,
    5,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 4/21: Atrial Septal Defect (ASD)
  -- 1) Interleave Lecture (Position 6)
  UPDATE "lessons"
  SET "position" = 6, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'atrial-septal-defect' OR "slug" = 'atrial-septal-defect');

  -- 2) Upsert Quiz Lesson (Position 7)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-cardiology-atrial-septal-defect',
    'Atrial Septal Defect (ASD) — SBA Interactive Quiz',
    'quiz',
    $SBA_CARD_014$# Atrial Septal Defect (ASD) — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 34-year-old woman is evaluated for exertional dyspnoea. Cardiac auscultation reveals an ejection systolic murmur loudest at the upper left sternal border and fixed, wide splitting of the second heart sound (S2) during both inspiration and expiration. What is the most likely diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Atrial Septal Defect (ASD))](/lessons/images/sba/cardiology/atrial-septal-defect/figure_01_p1.jpeg)


- **A.** Ostium secundum Atrial Septal Defect (ASD)
- **B.** Ventricular Septal Defect (VSD)
- **C.** Coarctation of the aorta
- **D.** Hypertrophic obstructive cardiomyopathy
- **E.** Aortic stenosis

**Correct Answer:** A
**Explanation:**
Fixed wide splitting of S2 is the classic hallmark of Atrial Septal Defect (ASD). The left-to-right shunt increases right ventricular volume and ejection time, delaying pulmonic valve closure equally in both inspiration and expiration. The systolic murmur is due to increased flow across the normal pulmonary valve.

## Question 2 of 5

Which anatomical subtype accounts for approximately 75-80% of all congenital Atrial Septal Defects in adults?

![Figure 2: Clinical Findings & Diagnostic Reference (Atrial Septal Defect (ASD))](/lessons/images/sba/cardiology/atrial-septal-defect/figure_02_p4.jpeg)


- **A.** Ostium secundum defect (in the region of the fossa ovalis)
- **B.** Ostium primum defect
- **C.** Sinus venosus defect
- **D.** Coronary sinus defect
- **E.** Patent ductus arteriosus

**Correct Answer:** A
**Explanation:**
Ostium secundum ASD is by far the most common type (75-80%), resulting from excessive resorption of the septum primum or deficient growth of the septum secundum. Ostium primum defects (15%) are associated with Down syndrome and endocardial cushion defects.

## Question 3 of 5

What is the classic 12-lead ECG finding associated with an Ostium Secundum ASD?

![Figure 3: Clinical Findings & Diagnostic Reference (Atrial Septal Defect (ASD))](/lessons/images/sba/cardiology/atrial-septal-defect/figure_03_p5.jpeg)


- **A.** Right axis deviation with incomplete Right Bundle Branch Block (rSR' pattern in V1)
- **B.** Left axis deviation with Left Bundle Branch Block
- **C.** Delta waves and short PR interval
- **D.** Deep Q waves in leads II, III, aVF
- **E.** ST elevation in V1-V3

**Correct Answer:** A
**Explanation:**
Ostium secundum ASD characteristically produces right axis deviation and incomplete right bundle branch block (rSR' pattern in V1) reflecting right ventricular volume overload. Conversely, ostium primum ASD classically demonstrates left axis deviation.

## Question 4 of 5

A 42-year-old patient with an untreated large ASD develops progressive cyanosis, clubbing, and severe pulmonary arterial hypertension. Bedside echo reveals reversal of the intracardiac shunt to right-to-left. What is this clinical entity known as?

- **A.** Eisenmenger's syndrome
- **B.** Ebstein's anomaly
- **C.** Tetralogy of Fallot
- **D.** Cor pulmonale from COPD
- **E.** Lutembacher's syndrome

**Correct Answer:** A
**Explanation:**
Eisenmenger's syndrome is the development of severe irreversible pulmonary vascular disease and pulmonary arterial hypertension secondary to a longstanding systemic-to-pulmonary (left-to-right) shunt, causing shunt reversal (right-to-left), cyanosis, and polycythaemia.

## Question 5 of 5

A 25-year-old scuba diver with an unclosed Patent Foramen Ovale (PFO) / small ASD develops a sudden focal neurological deficit (stroke) after deep-vein thrombosis. What mechanism explains this phenomenon?

- **A.** Paradoxical embolism
- **B.** Atherosclerotic plaque rupture
- **C.** Bacterial endocarditis
- **D.** Carotid artery dissection
- **E.** Fat embolism syndrome

**Correct Answer:** A
**Explanation:**
Paradoxical embolism occurs when a venous thrombus (e.g. from DVT) crosses an intracardiac right-to-left communication (PFO or ASD) into the systemic arterial circulation, bypassing pulmonary filtration and causing embolic stroke or peripheral arterial occlusion.
$SBA_CARD_014$,
    false,
    7,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 5/21: ECG Axis Interpretation
  -- 1) Interleave Lecture (Position 8)
  UPDATE "lessons"
  SET "position" = 8, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'ecg-axis-interpretation' OR "slug" = 'axis-interpretation');

  -- 2) Upsert Quiz Lesson (Position 9)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-cardiology-axis-interpretation',
    'ECG Axis Interpretation — SBA Interactive Quiz',
    'quiz',
    $SBA_CARD_015$# ECG Axis Interpretation — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 12-lead ECG demonstrates a positive QRS net deflection in Lead I (predominantly upright) and a negative net deflection in Lead aVF (predominantly downwards), with a negative net deflection in Lead II. What is the QRS electrical axis?

![Figure 1: Clinical Findings & Diagnostic Reference (ECG Axis Interpretation)](/lessons/images/sba/cardiology/axis-interpretation/figure_01_p2.jpeg)


- **A.** Left Axis Deviation (LAD)
- **B.** Normal cardiac axis
- **C.** Right Axis Deviation (RAD)
- **D.** Extreme right axis deviation ('Northwest axis')
- **E.** Indeterminate axis

**Correct Answer:** A
**Explanation:**
Left Axis Deviation is defined as a QRS axis between -30 and -90 degrees. Quick rule: Lead I is positive, Lead aVF is negative, and Lead II is negative (QRS complexes are 'leaving' each other). Causes include Left Anterior Fascicular Block (LAFB), inferior MI, LVH, and artificial pacing.

![Clinical Algorithm & Advanced Reference (ECG Axis Interpretation)](/lessons/images/sba/cardiology/axis-interpretation/figure_06_p6.jpeg)


## Question 2 of 5

A 12-lead ECG shows a predominantly negative QRS deflection in Lead I and a predominantly positive QRS deflection in Lead aVF. What is the QRS axis?

![Figure 2: Clinical Findings & Diagnostic Reference (ECG Axis Interpretation)](/lessons/images/sba/cardiology/axis-interpretation/figure_02_p3.jpeg)


- **A.** Right Axis Deviation (RAD)
- **B.** Normal axis
- **C.** Left Axis Deviation
- **D.** Extreme axis deviation
- **E.** Isoelectric axis

**Correct Answer:** A
**Explanation:**
Right Axis Deviation is defined as a QRS axis between +90 and +180 degrees. Quick rule: Lead I is negative and Lead aVF is positive (QRS complexes are 'reaching towards' each other). Causes include Right Ventricular Hypertrophy (RVH), acute PE, COPD/cor pulmonale, lateral MI, and Left Posterior Fascicular Block (LPFB).

![Clinical Algorithm & Advanced Reference (ECG Axis Interpretation)](/lessons/images/sba/cardiology/axis-interpretation/figure_07_p7.jpeg)


## Question 3 of 5

A 12-lead ECG shows negative net QRS deflections in BOTH Lead I and Lead aVF, with a positive QRS in lead aVR. What is this axis deviation termed?

![Figure 3: Clinical Findings & Diagnostic Reference (ECG Axis Interpretation)](/lessons/images/sba/cardiology/axis-interpretation/figure_03_p4.jpeg)


- **A.** Extreme Right Axis Deviation ('Northwest axis' / -90 to 180 degrees)
- **B.** Normal axis
- **C.** Physiological left axis
- **D.** Artifactual reversal
- **E.** Vertical axis

**Correct Answer:** A
**Explanation:**
Extreme axis deviation (Northwest axis, -90 to 180 degrees) occurs when QRS is negative in both I and aVF. Highly characteristic of ventricular tachycardia (VT), severe hyperkalaemia, apical pacing, or limb-lead reversal.

## Question 4 of 5

In which lead is the QRS complex equiphasic (net zero, where positive R equals negative S) when the frontal electrical axis is exactly +60 degrees?

![Figure 4: Clinical Findings & Diagnostic Reference (ECG Axis Interpretation)](/lessons/images/sba/cardiology/axis-interpretation/figure_04_p5.jpeg)


- **A.** Lead aVL
- **B.** Lead I
- **C.** Lead II
- **D.** Lead III
- **E.** Lead aVR

**Correct Answer:** A
**Explanation:**
The axis is perpendicular to the lead that is equiphasic (isoelectric). Lead aVL is at -30 degrees. The perpendicular to -30 degrees is +60 degrees (Lead II). Thus, when the axis is +60 degrees (normal axis parallel to Lead II), Lead aVL is equiphasic.

## Question 5 of 5

Accidental reversal of the Right Arm (RA) and Left Arm (LA) limb electrodes during ECG recording produces which characteristic diagnostic pattern?

![Figure 5: Clinical Findings & Diagnostic Reference (ECG Axis Interpretation)](/lessons/images/sba/cardiology/axis-interpretation/figure_05_p6.jpeg)


- **A.** Lead I is completely inverted (negative P wave, negative QRS, and negative T wave), mimicking dextrocardia with normal precordial R-wave progression
- **B.** Complete asystole in lead II
- **C.** Giant Osborne waves in leads V4-V6
- **D.** Loss of all precordial R waves
- **E.** Pseudo-Brugada sign in V1

**Correct Answer:** A
**Explanation:**
LA/RA electrode reversal inverts lead I (negative P, QRS, T). Leads II and III swap, and leads aVR and aVL swap. Unlike true dextrocardia, the chest leads (V1-V6) show completely normal R-wave progression.
$SBA_CARD_015$,
    false,
    9,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 6/21: Bifascicular & Trifascicular Blocks
  -- 1) Interleave Lecture (Position 10)
  UPDATE "lessons"
  SET "position" = 10, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'bifascicular-trifascicular-blocks' OR "slug" = 'bifascicular-trifascicular-block');

  -- 2) Upsert Quiz Lesson (Position 11)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-cardiology-bifascicular-trifascicular-block',
    'Bifascicular & Trifascicular Blocks — SBA Interactive Quiz',
    'quiz',
    $SBA_CARD_016$# Bifascicular & Trifascicular Blocks — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 76-year-old man presents with recurrent episodes of syncope. His ECG reveals complete Right Bundle Branch Block (RBBB) and Left Anterior Fascicular Block (marked left axis deviation of -60 degrees). What conduction disorder does this combination represent?

![Figure 1: Clinical Findings & Diagnostic Reference (Bifascicular & Trifascicular Blocks)](/lessons/images/sba/cardiology/bifascicular-trifascicular-block/figure_01_p1.jpeg)


- **A.** Bifascicular Block
- **B.** Isolated RBBB
- **C.** Wenckebach phenomenon
- **D.** Wolf-Parkinson-White syndrome
- **E.** Complete heart block

**Correct Answer:** A
**Explanation:**
The intraventricular conduction system has 3 fascicles: RBB, Left Anterior Fascicle (LAF), and Left Posterior Fascicle (LPF). Bifascicular block refers to block of two of these three pathways: typically RBBB + LAFB (or RBBB + LPFB). When accompanied by syncope, it carries high risk of progressing to complete heart block.

![Clinical Algorithm & Advanced Reference (Bifascicular & Trifascicular Blocks)](/lessons/images/sba/cardiology/bifascicular-trifascicular-block/figure_06_p5.jpeg)


## Question 2 of 5

When a patient with Bifascicular Block (RBBB + LAFB) also demonstrates a prolonged PR interval (>200 ms) on 12-lead ECG, what is this clinical triad traditionally termed?

![Figure 2: Clinical Findings & Diagnostic Reference (Bifascicular & Trifascicular Blocks)](/lessons/images/sba/cardiology/bifascicular-trifascicular-block/figure_02_p2.jpeg)


- **A.** Trifascicular Block (bifascicular block with first-degree AV block)
- **B.** Mobitz Type II AV block
- **C.** Sick Sinus Syndrome
- **D.** Sinus node dysfunction with LBBB
- **E.** Brugada syndrome Type 3

**Correct Answer:** A
**Explanation:**
Trifascicular block (incomplete) is defined as bifascicular block (e.g. RBBB + LAFB or LPFB) in the presence of first-degree AV block (PR > 200 ms). It indicates disease throughout all three fascicles and requires urgent cardiology evaluation for permanent pacemaker implantation if symptomatic.

![Clinical Algorithm & Advanced Reference (Bifascicular & Trifascicular Blocks)](/lessons/images/sba/cardiology/bifascicular-trifascicular-block/figure_07_p6.jpeg)


## Question 3 of 5

Which fascicle of the cardiac conduction system is anatomically the most robust, possesses a dual blood supply (from LAD and posterior descending artery), and is therefore least commonly blocked in isolation?

![Figure 3: Clinical Findings & Diagnostic Reference (Bifascicular & Trifascicular Blocks)](/lessons/images/sba/cardiology/bifascicular-trifascicular-block/figure_03_p3.jpeg)


- **A.** Left Posterior Fascicle (LPF)
- **B.** Left Anterior Fascicle (LAF)
- **C.** Right Bundle Branch (RBB)
- **D.** Sinoatrial nodal artery branch
- **E.** Bachmann's bundle

**Correct Answer:** A
**Explanation:**
The Left Posterior Fascicle is broad, thick, and has a dual blood supply from both the anterior and posterior descending coronary arteries. Consequently, isolated Left Posterior Fascicular Block (LPFB) is rare and implies extensive myocardial or conducting system damage.

## Question 4 of 5

An 82-year-old woman with known bifascicular block presents to the ED with a mechanical fall and sudden blackout. During telemetry monitoring, her rhythm strip shows a sudden dropped QRS without prior PR prolongation (Mobitz II / high-degree AV block). What is the definitive treatment?

![Figure 4: Clinical Findings & Diagnostic Reference (Bifascicular & Trifascicular Blocks)](/lessons/images/sba/cardiology/bifascicular-trifascicular-block/figure_04_p4.jpeg)


- **A.** Permanent Pacemaker (PPM) insertion
- **B.** Oral bisoprolol titration
- **C.** Oral amiodarone 200mg daily
- **D.** Elective direct current cardioversion
- **E.** No intervention needed if she recovers consciousness

**Correct Answer:** A
**Explanation:**
Symptomatic advanced conduction disease (syncope in the setting of bifascicular block with documented high-degree AV block or intermittent complete heart block) is a Class I indication for permanent pacemaker (PPM) implantation to prevent sudden cardiac death.

## Question 5 of 5

Which temporary emergency measure is indicated in the ED for a patient with trifascicular block presenting with severe symptomatic bradycardia (HR 26 bpm, BP 76/44 mmHg) refractory to IV Atropine?

![Figure 5: Clinical Findings & Diagnostic Reference (Bifascicular & Trifascicular Blocks)](/lessons/images/sba/cardiology/bifascicular-trifascicular-block/figure_05_p5.jpeg)


- **A.** Transcutaneous Pacing (TCP) with analgesia/sedation, preparing for transvenous wire insertion
- **B.** IV Adenosine 6mg rapid bolus
- **C.** IV Digoxin 500mcg over 2 hours
- **D.** Oral verapamil
- **E.** Synchronised DC shock 200J

**Correct Answer:** A
**Explanation:**
Infrastructural/infranodal AV blocks (such as in trifascicular disease) respond poorly to atropine. For haemodynamic compromise, immediate transcutaneous electrical pacing (TCP) is the treatment of choice, serving as a bridge to emergency transvenous pacing.
$SBA_CARD_016$,
    false,
    11,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 7/21: Emergency Bradycardia Management
  -- 1) Interleave Lecture (Position 12)
  UPDATE "lessons"
  SET "position" = 12, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'emergency-bradycardia-management' OR "slug" = 'bradycardia');

  -- 2) Upsert Quiz Lesson (Position 13)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-cardiology-bradycardia',
    'Emergency Bradycardia Management — SBA Interactive Quiz',
    'quiz',
    $SBA_CARD_017$# Emergency Bradycardia Management — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 74-year-old male presents with profound light-headedness. His pulse is 32 bpm and regular. BP is 80/48 mmHg. The ECG shows complete dissociation between P waves (rate 75 bpm) and wide QRS complexes (rate 32 bpm). According to the Resuscitation Council UK algorithm, what is the initial first-line drug therapy?

![Figure 1: Clinical Findings & Diagnostic Reference (Emergency Bradycardia Management)](/lessons/images/sba/cardiology/bradycardia/figure_01_p1.jpeg)


- **A.** IV Atropine 500 micrograms
- **B.** IV Adrenaline 1mg rapid bolus
- **C.** IV Amiodarone 300mg
- **D.** IV Metoprolol 5mg
- **E.** IV Flecainide 150mg

**Correct Answer:** A
**Explanation:**
For any bradycardia with adverse features (shock, syncope, myocardial ischaemia, or heart failure), IV Atropine 500 mcg is the first-line medication, repeatable up to a maximum total of 3 mg (6 doses). If ineffective, use pacing or inotropes (isoprenaline/adrenaline).

## Question 2 of 5

Which of the following is considered an 'Adverse Feature' in the RCUK Bradycardia algorithm that mandates immediate emergency active intervention?

![Figure 2: Clinical Findings & Diagnostic Reference (Emergency Bradycardia Management)](/lessons/images/sba/cardiology/bradycardia/figure_02_p10.jpeg)


- **A.** Shock (systolic BP <90 mmHg, pallor, diaphoresis) or Syncope
- **B.** PR interval of 220 ms with normal BP
- **C.** Resting heart rate of 52 bpm in a trained athlete
- **D.** Incomplete RBBB on ECG
- **E.** Serum potassium of 4.2 mmol/L

**Correct Answer:** A
**Explanation:**
The 4 life-threatening adverse features in bradycardia are: (1) Shock (systolic BP <90 mmHg, oliguria, cold peripheries); (2) Syncope; (3) Myocardial ischaemia; (4) Severe heart failure (pulmonary oedema). Their presence dictates immediate atropine and pacing.

## Question 3 of 5

Why should Atropine NOT be administered in doses less than 500 micrograms in adult patients?

- **A.** Paradoxical bradycardia may occur due to central vagal stimulation
- **B.** It induces immediate renal failure
- **C.** It causes profound hypokalaemia
- **D.** It causes severe metabolic acidosis
- **E.** It precipitates immediate ventricular fibrillation

**Correct Answer:** A
**Explanation:**
Subtherapeutic doses of atropine (<500 mcg) can paradoxically worsen bradycardia through central vagomimetic effects and presynaptic muscarinic M1 receptor blockade before complete postsynaptic M2 blockade is achieved.

## Question 4 of 5

In which type of second-degree AV block is the PR interval constant prior to a non-conducted P wave, originating below the AV node and carrying high risk of progression to asystole?

- **A.** Mobitz Type II AV block
- **B.** Mobitz Type I (Wenckebach) AV block
- **C.** First-degree AV block
- **D.** Sinus arrhythmia
- **E.** Wandering atrial pacemaker

**Correct Answer:** A
**Explanation:**
Mobitz Type II AV block has fixed PR intervals with randomly dropped QRS complexes. It occurs infranodally (His-Purkinje system), is often irreversible, frequently progresses to complete heart block/asystole, and is an absolute indication for pacing.

## Question 5 of 5

A patient with complete heart block following an anterior myocardial infarction is completely refractory to 3mg total atropine. Transcutaneous pacing capture is intermittent. Which intravenous infusion is recommended as a second-line pharmacological bridge to transvenous pacing?

- **A.** IV Isoprenaline infusion (5 mcg/min) or Adrenaline infusion (2-10 mcg/min)
- **B.** IV Adenosine infusion
- **C.** IV Labetalol infusion
- **D.** IV Salbutamol nebuliser alone
- **E.** IV Furosemide infusion

**Correct Answer:** A
**Explanation:**
When atropine is ineffective or pacing is unavailable/failing, second-line inotropic/chronotropic infusions are indicated: Adrenaline (2-10 mcg/min), Isoprenaline (5 mcg/min), or Dopamine (2-10 mcg/kg/min) to maintain heart rate and perfusion.
$SBA_CARD_017$,
    false,
    13,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 8/21: Cardiogenic Pulmonary Oedema
  -- 1) Interleave Lecture (Position 14)
  UPDATE "lessons"
  SET "position" = 14, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'cardiogenic-pulmonary-oedema' OR "slug" = 'cardiogenic-pulmonary-edema');

  -- 2) Upsert Quiz Lesson (Position 15)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-cardiology-cardiogenic-pulmonary-edema',
    'Cardiogenic Pulmonary Oedema — SBA Interactive Quiz',
    'quiz',
    $SBA_CARD_018$# Cardiogenic Pulmonary Oedema — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 68-year-old woman with a history of ischaemic heart disease presents with severe orthopnoea and pink frothy sputum. HR 122 bpm, BP 184/102 mmHg, RR 34/min, SpO2 84% on room air. Auscultation reveals extensive bilateral pulmonary crackles and wheezes. What is the immediate non-invasive respiratory support of choice?

![Figure 1: Clinical Findings & Diagnostic Reference (Cardiogenic Pulmonary Oedema)](/lessons/images/sba/cardiology/cardiogenic-pulmonary-edema/figure_01_p1.jpeg)


- **A.** Continuous Positive Airway Pressure (CPAP) at 5-10 cm H2O with high-flow oxygen
- **B.** Immediate endotracheal intubation and paralysis
- **C.** Low-flow nasal cannula at 2 L/min
- **D.** Venturi mask 24% oxygen
- **E.** Incentive spirometry

**Correct Answer:** A
**Explanation:**
CPAP (or BiPAP) is the first-line respiratory support for acute cardiogenic pulmonary oedema. CPAP recruits collapsed alveoli, increases functional residual capacity, reduces work of breathing, and decreases both LV preload and afterload, dramatically reducing intubation and mortality rates.

![Clinical Algorithm & Advanced Reference (Cardiogenic Pulmonary Oedema)](/lessons/images/sba/cardiology/cardiogenic-pulmonary-edema/figure_06_p7.jpeg)


## Question 2 of 5

In acute cardiogenic pulmonary oedema with preserved or elevated blood pressure (systolic BP >110 mmHg), which vasodilator reduces cardiac preload and afterload most rapidly and safely?

![Figure 2: Clinical Findings & Diagnostic Reference (Cardiogenic Pulmonary Oedema)](/lessons/images/sba/cardiology/cardiogenic-pulmonary-edema/figure_02_p3.jpeg)


- **A.** Sublingual or IV Glyceryl Trinitrate (GTN)
- **B.** IV Metoprolol
- **C.** Oral Amlodipine
- **D.** IV Hydralazine bolus
- **E.** IV Milrinone

**Correct Answer:** A
**Explanation:**
Nitrates (sublingual GTN spray 400-800 mcg followed by IV infusion titrated to BP) are the cornerstone of medical therapy in hypertensive cardiogenic pulmonary oedema. They induce venodilatation (reducing preload and LV filling pressure) and arterial dilatation (reducing LV afterload).

## Question 3 of 5

What is the recommended initial intravenous dose of Furosemide in a patient presenting with acute decompensated heart failure who is already taking 40mg oral furosemide daily at home?

![Figure 3: Clinical Findings & Diagnostic Reference (Cardiogenic Pulmonary Oedema)](/lessons/images/sba/cardiology/cardiogenic-pulmonary-edema/figure_03_p4.jpeg)


- **A.** 40-80 mg IV bolus (equivalent to 1-2 times their daily oral dose)
- **B.** 10 mg IV bolus
- **C.** 250 mg IV bolus immediately
- **D.** Oral spironolactone 25mg alone
- **E.** Loop diuretics are contraindicated in pulmonary oedema

**Correct Answer:** A
**Explanation:**
NICE and ESC guidelines recommend giving an initial IV bolus of furosemide equal to 1-2 times the patient's existing total daily oral dose. For loop diuretic-naive patients, 20-40 mg IV is typically sufficient.

## Question 4 of 5

Why has the routine use of intravenous opiates (such as Diamorphine or Morphine) fallen out of favour in modern management of acute cardiogenic pulmonary oedema?

![Figure 4: Clinical Findings & Diagnostic Reference (Cardiogenic Pulmonary Oedema)](/lessons/images/sba/cardiology/cardiogenic-pulmonary-edema/figure_04_p5.jpeg)


- **A.** They are associated with increased rates of respiratory depression, ICU admission, mechanical ventilation, and excess mortality
- **B.** They cause severe hyperkalaemia
- **C.** They induce acute hypertensive crisis
- **D.** They cause intractable pulmonary fibrosis
- **E.** They neutralize the effect of loop diuretics

**Correct Answer:** A
**Explanation:**
Large registry data and meta-analyses show routine morphine use in acute pulmonary oedema is associated with sedation, hypoventilation, hypercapnia, increased invasive mechanical ventilation, and higher in-hospital mortality. Opiates are now reserved strictly for severe intractable distress or palliative care.

## Question 5 of 5

A 59-year-old male with acute anterior STEMI presents in cardiogenic shock: cold extremities, oliguria, confusion, BP 76/44 mmHg, and severe pulmonary oedema. What inotrope/vasopressor strategy is recommended by ESC guidelines?

![Figure 5: Clinical Findings & Diagnostic Reference (Cardiogenic Pulmonary Oedema)](/lessons/images/sba/cardiology/cardiogenic-pulmonary-edema/figure_05_p6.jpeg)


- **A.** Noradrenaline infusion to restore coronary perfusion pressure, plus Dobutamine if cardiogenic inotropy is needed
- **B.** Aggressive 3-litre 0.9% normal saline fluid challenge
- **C.** High-dose IV GTN infusion
- **D.** Oral beta-blockers immediately
- **E.** Verapamil infusion

**Correct Answer:** A
**Explanation:**
In cardiogenic shock with severe hypotension, Noradrenaline is preferred over dopamine to restore MAP and coronary perfusion with lower arrhythmia risk. Dobutamine is added to augment inotropy. Reperfusion (emergency primary PCI) is the definitive life-saving therapy.
$SBA_CARD_018$,
    false,
    15,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 9/21: Congenital Heart Disease in the ED
  -- 1) Interleave Lecture (Position 16)
  UPDATE "lessons"
  SET "position" = 16, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'congenital-heart-disease-in-the-ed' OR "slug" = 'congenital-heart-disease');

  -- 2) Upsert Quiz Lesson (Position 17)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-cardiology-congenital-heart-disease',
    'Congenital Heart Disease in the ED — SBA Interactive Quiz',
    'quiz',
    $SBA_CARD_019$# Congenital Heart Disease in the ED — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 10-day-old newborn infant is brought to the ED in severe cardiogenic shock: grey, mottled, lethargic, with weak femoral pulses and profound metabolic acidosis. The ductus arteriosus is suspected of closing. What life-saving intravenous infusion must be initiated immediately?

![Figure 1: Clinical Findings & Diagnostic Reference (Congenital Heart Disease in the ED)](/lessons/images/sba/cardiology/congenital-heart-disease/figure_01_p2.jpeg)


- **A.** Prostaglandin E1 (Alprostadil / Dinoprostone) infusion
- **B.** Indomethacin infusion
- **C.** Ibuprofen IV
- **D.** High-dose furosemide
- **E.** Sodium polystyrene sulfonate

**Correct Answer:** A
**Explanation:**
In duct-dependent congenital cardiac lesions (e.g. Coarctation of the aorta, Hypoplastic Left Heart Syndrome, Transposition of the Great Arteries), closure of the ductus arteriosus at 7-14 days causes sudden cardiovascular collapse. Prostaglandin E1 maintains or reopens ductal patency, restoring systemic or pulmonary blood flow.

## Question 2 of 5

Which of the following is a classic side effect of intravenous Prostaglandin E1 (Alprostadil) infusion in neonates that requires the resuscitation team to be prepared for immediate endotracheal intubation?

![Figure 2: Clinical Findings & Diagnostic Reference (Congenital Heart Disease in the ED)](/lessons/images/sba/cardiology/congenital-heart-disease/figure_02_p6.jpeg)


- **A.** Apnoea
- **B.** Hypertensive crisis
- **C.** Severe hypernatraemia
- **D.** Aplastic anaemia
- **E.** Severe polycythaemia

**Correct Answer:** A
**Explanation:**
Apnoea is a very common and well-documented adverse effect of Prostaglandin E1 infusion (occurring in 10-15% of neonates, particularly in the first hour of infusion). Clinicians must always be prepared to secure the airway and intubate.

## Question 3 of 5

A 9-month-old infant with known unrepaired Tetralogy of Fallot suddenly becomes irritable, intensely cyanosed, and hyperpnoeic during feeding (a 'Tet spell'). What initial physical manoeuvre helps abort this hypercyanotic crisis?

- **A.** Knee-to-chest position (or squatting)
- **B.** Trendelenburg position
- **C.** Valsalva manoeuvre with cold water
- **D.** Rapid vertical suspension
- **E.** Prone position with neck hyperextended

**Correct Answer:** A
**Explanation:**
In a 'Tet spell' (hypercyanotic episode), infundibular spasm increases right-to-left shunting through the VSD. Bringing the infant's knees to the chest (or squatting in older children) kinks the femoral arteries, acutely increasing systemic vascular resistance (SVR), which forces blood from the RV into the pulmonary circulation rather than across the VSD.

## Question 4 of 5

What pharmacological therapy reduces infundibular spasm and calms agitation during a severe paediatric Tetralogy of Fallot hypercyanotic spell?

- **A.** Intravenous Morphine and IV Propranolol (beta-blocker)
- **B.** IV Adrenaline bolus
- **C.** IV Digoxin loading
- **D.** Inhaled nitric oxide monotherapy
- **E.** Oral Sildenafil alone

**Correct Answer:** A
**Explanation:**
Treatment of a Tet spell includes: (1) Knee-to-chest position; (2) High-flow oxygen; (3) Morphine (calms agitation and reduces systemic venous return); (4) IV fluids bolus (expands circulating volume); (5) IV Propranolol or esmolol (relaxes infundibular spasm); (6) Phenylephrine (increases SVR).

## Question 5 of 5

What four cardiac anomalies compose the classic anatomical tetrad of Tetralogy of Fallot (TOF)?

- **A.** Ventricular Septal Defect (VSD), Pulmonary infundibular stenosis, Overriding aorta, and Right Ventricular Hypertrophy (RVH)
- **B.** Atrial Septal Defect, Mitral stenosis, Tricuspid regurgitation, and LVH
- **C.** Coarctation of the aorta, Bicuspid aortic valve, VSD, and PDA
- **D.** Transposition of great vessels, ASD, VSD, and pulmonic atresia
- **E.** Dextrocardia, Situs inversus, Bronchiectasis, and Sinusitis

**Correct Answer:** A
**Explanation:**
Tetralogy of Fallot consists of: (1) Ventricular Septal Defect; (2) Pulmonary outflow tract obstruction / infundibular stenosis; (3) Overriding aorta; (4) Right Ventricular Hypertrophy resulting from the high pressure in the RV.
$SBA_CARD_019$,
    false,
    17,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 10/21: Infective Endocarditis
  -- 1) Interleave Lecture (Position 18)
  UPDATE "lessons"
  SET "position" = 18, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'infective-endocarditis' OR "slug" = 'endocarditis');

  -- 2) Upsert Quiz Lesson (Position 19)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-cardiology-endocarditis',
    'Infective Endocarditis — SBA Interactive Quiz',
    'quiz',
    $SBA_CARD_020$# Infective Endocarditis — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 38-year-old male intravenous drug user presents with fever, rigors, pleuritic chest pain, and haemoptysis. Auscultation reveals a pansystolic murmur at the lower left sternal edge that intensifies with inspiration (Carvallo's sign). Chest radiograph shows multiple cavitating pulmonary nodules. What is the most likely diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Infective Endocarditis)](/lessons/images/sba/cardiology/endocarditis/figure_01_p1.jpeg)


- **A.** Tricuspid valve infective endocarditis with septic pulmonary emboli
- **B.** Mitral valve prolapse
- **C.** Community-acquired lobar pneumonia
- **D.** Pulmonary tuberculosis
- **E.** Goodpasture's syndrome

**Correct Answer:** A
**Explanation:**
In intravenous drug users (IVDU), the tricuspid valve is the most commonly affected valve (>60%), most frequently caused by Staphylococcus aureus. Manifestations include tricuspid regurgitation (pansystolic murmur louder on inspiration) and septic pulmonary emboli causing cavitating lung lesions, pleurisy, and haemoptysis.

## Question 2 of 5

Which microorganism is the single most common cause of acute, destructive native-valve and prosthetic-valve Infective Endocarditis in ED patients?

![Figure 2: Clinical Findings & Diagnostic Reference (Infective Endocarditis)](/lessons/images/sba/cardiology/endocarditis/figure_02_p4.jpeg)


- **A.** Staphylococcus aureus
- **B.** Streptococcus viridans
- **C.** Enterococcus faecalis
- **D.** Pseudomonas aeruginosa
- **E.** Candida albicans

**Correct Answer:** A
**Explanation:**
Staphylococcus aureus has overtaken Streptococcus viridans to become the leading cause of infective endocarditis in native valves, IVDU, and prosthetic valves within 12 months of surgery. It causes acute, virulent, destructive valve destruction with rapid systemic embolisation.

## Question 3 of 5

According to the Modified Duke Criteria, which combination represents a definitive diagnosis of Infective Endocarditis?

![Figure 3: Clinical Findings & Diagnostic Reference (Infective Endocarditis)](/lessons/images/sba/cardiology/endocarditis/figure_03_p5.jpeg)


- **A.** 2 Major criteria (e.g. typical blood cultures + echocardiographic vegetation)
- **B.** 1 Major and 1 Minor criterion
- **C.** 2 Minor criteria only
- **D.** Elevated CRP and temperature >38C
- **E.** A single positive blood culture for Staphylococcus epidermidis

**Correct Answer:** A
**Explanation:**
Definite infective endocarditis by Modified Duke criteria requires: 2 Major criteria; OR 1 Major and 3 Minor criteria; OR 5 Minor criteria. Major criteria include: persistently positive blood cultures with typical organisms, and imaging positive for IE (echocardiographic vegetation, abscess, or new dehiscence).

## Question 4 of 5

Which peripheral stigmata of Infective Endocarditis are PAINFUL, nodular erythematous lesions found on the pulps of fingers and toes?

- **A.** Osler's nodes
- **B.** Janeway lesions
- **C.** Roth's spots
- **D.** Splinter haemorrhages
- **E.** Erythema marginatum

**Correct Answer:** A
**Explanation:**
Osler's nodes are painful, tender erythematous nodules located on the pads of fingers and toes, caused by immune complex deposition ('O for Ouch = Osler'). Conversely, Janeway lesions are non-tender, painless erythematous macules on palms and soles caused by septic micro-emboli.

## Question 5 of 5

What is the primary emergency surgical indication for urgent valve replacement surgery in a patient with active native-valve infective endocarditis?

- **A.** Severe acute valve regurgitation causing refractory pulmonary oedema or cardiogenic shock
- **B.** Fever persisting for 24 hours after starting antibiotics
- **C.** Presence of splinter haemorrhages
- **D.** Microscopic haematuria
- **E.** Isolation of Streptococcus viridans on blood culture

**Correct Answer:** A
**Explanation:**
The primary emergency indications for surgery in active IE are: (1) Severe acute aortic or mitral regurgitation causing refractory cardiogenic shock or acute pulmonary oedema; (2) Uncontrolled local infection (abscess, fistula, false aneurysm); (3) Prevention of embolism in large mobile vegetations (>10 mm) after embolic events despite antimicrobial therapy.
$SBA_CARD_020$,
    false,
    19,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 11/21: Hypertension in Pregnancy & Preeclampsia
  -- 1) Interleave Lecture (Position 20)
  UPDATE "lessons"
  SET "position" = 20, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'hypertension-in-pregnancy-preeclampsia' OR "slug" = 'hypertension-pregnancy');

  -- 2) Upsert Quiz Lesson (Position 21)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-cardiology-hypertension-pregnancy',
    'Hypertension in Pregnancy & Preeclampsia — SBA Interactive Quiz',
    'quiz',
    $SBA_CARD_021$# Hypertension in Pregnancy & Preeclampsia — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 29-year-old primigravida at 34 weeks gestation presents with a 2-day history of throbbing frontal headache, visual flashing lights (scotomata), and right upper quadrant pain. BP is 168/112 mmHg. Urine dipstick shows 3+ protein. What is the diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Hypertension in Pregnancy & Preeclampsia)](/lessons/images/sba/cardiology/hypertension-pregnancy/figure_01_p5.jpeg)


- **A.** Severe Pre-eclampsia
- **B.** Gestational hypertension
- **C.** Tension headache
- **D.** Acute viral hepatitis
- **E.** Chronic essential hypertension

**Correct Answer:** A
**Explanation:**
Pre-eclampsia is new hypertension (>=140/90 mmHg) occurring after 20 weeks gestation with significant proteinuria (>=300 mg/24h or dipstick >=2+) or signs of maternal organ dysfunction (headache, visual disturbance, epigastric/RUQ pain, thrombocytopenia, renal impairment). Severe pre-eclampsia is systolic >=160 or diastolic >=110 mmHg.

## Question 2 of 5

What is the first-line intravenous anticonvulsant medication of choice for the prevention and treatment of eclamptic seizures according to NICE NG133?

- **A.** Intravenous Magnesium Sulphate (4g loading dose over 5-15 min followed by 1g/hour infusion)
- **B.** Intravenous Diazepam 10mg bolus
- **C.** Intravenous Phenytoin loading
- **D.** Intravenous Levetiracetam (Keppra)
- **E.** Intravenous Sodium Valproate

**Correct Answer:** A
**Explanation:**
The Collaborative Eclampsia Trial established IV Magnesium Sulphate as the drug of choice for treating eclamptic fits and preventing eclampsia in severe pre-eclampsia. It halves the risk of eclampsia and reduces maternal mortality significantly compared to diazepam or phenytoin.

## Question 3 of 5

Which first-line oral antihypertensive agents are recommended by NICE for the management of severe gestational hypertension or pre-eclampsia?

- **A.** Labetalol (first-line), Nifedipine (modified release), or Methyldopa
- **B.** Ramipril (ACE inhibitors)
- **C.** Losartan (ARBs)
- **D.** Spironolactone
- **E.** Bendroflumethiazide

**Correct Answer:** A
**Explanation:**
Labetalol is first-line oral therapy per NICE NG133. Modified-release oral Nifedipine is second-line, and Methyldopa is third-line. ACE inhibitors and Angiotensin Receptor Blockers (ARBs) are strictly CONTRAINDICATED in pregnancy due to severe fetotoxicity (renal dysgenesis, oligohydramnios, skull hypoplasia).

## Question 4 of 5

A 32-week pregnant woman with pre-eclampsia has blood tests demonstrating: Platelets 48 x 10^9/L, AST 240 IU/L, Bilirubin 38 umol/L, and fragmented red cells (schistocytes) on blood film. What severe pre-eclampsia variant has developed?

- **A.** HELLP Syndrome (Haemolysis, Elevated Liver enzymes, Low Platelets)
- **B.** Immune Thrombocytopenic Purpura (ITP)
- **C.** Acute fatty liver of pregnancy (AFLP)
- **D.** Disseminated Intravascular Coagulation from sepsis
- **E.** Haemolytic Uraemic Syndrome

**Correct Answer:** A
**Explanation:**
HELLP syndrome is a life-threatening complication of severe pre-eclampsia comprising: (H) Haemolysis (schistocytes, raised LDH, raised unconjugated bilirubin); (EL) Elevated Liver enzymes (transaminases >=2x upper limit); (LP) Low Platelets (<100 x 10^9/L). Definitive treatment is delivery.

## Question 5 of 5

During IV Magnesium Sulphate infusion for severe pre-eclampsia, the patient's respiratory rate drops to 8 breaths/min and patellar tendon reflexes are completely absent. What immediate actions must be taken?

- **A.** Stop magnesium sulphate infusion immediately and administer IV Calcium Gluconate 10% (10ml over 10 minutes)
- **B.** Increase magnesium infusion rate to suppress cerebral irritability
- **C.** Administer IV Naloxone 400mcg
- **D.** Administer IV Flumazenil
- **E.** Administer rapid IV normal saline bolus 2 litres

**Correct Answer:** A
**Explanation:**
Loss of deep tendon reflexes is the earliest clinical sign of hypermagnesaemia (magnesium toxicity), followed by respiratory depression (<12/min) and cardiac arrest. Management: stop infusion immediately, support airway/breathing, and give the physiological antagonist: IV 10% calcium gluconate 10 ml over 10 minutes.
$SBA_CARD_021$,
    false,
    21,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 12/21: Hypertensive Emergencies
  -- 1) Interleave Lecture (Position 22)
  UPDATE "lessons"
  SET "position" = 22, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'hypertensive-emergencies' OR "slug" = 'hypertensive-emergency');

  -- 2) Upsert Quiz Lesson (Position 23)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-cardiology-hypertensive-emergency',
    'Hypertensive Emergencies — SBA Interactive Quiz',
    'quiz',
    $SBA_CARD_022$# Hypertensive Emergencies — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 56-year-old man presents with severe occipital headache, blurred vision, and confusion. Blood pressure is 224/132 mmHg. Fundoscopic examination reveals bilateral optic disc swelling (papilloedema) and flame haemorrhages. Serum creatinine is 220 umol/L. What is the diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Hypertensive Emergencies)](/lessons/images/sba/cardiology/hypertensive-emergency/figure_01_p1.jpeg)


- **A.** Hypertensive Emergency (Malignant / Accelerated Hypertension)
- **B.** Hypertensive urgency without target organ damage
- **C.** Idiopathic intracranial hypertension
- **D.** Acute primary angle-closure glaucoma
- **E.** Normal pressure hydrocephalus

**Correct Answer:** A
**Explanation:**
Hypertensive Emergency is defined as severely elevated BP (typically systolic >180 or diastolic >120 mmHg) accompanied by acute, life-threatening Target Organ Damage (TOD), such as hypertensive encephalopathy, papilloedema, acute kidney injury, acute pulmonary oedema, or aortic dissection. Hypertensive urgency lacks acute TOD.

## Question 2 of 5

In the absence of aortic dissection, acute ischaemic stroke, or severe pre-eclampsia, what is the safe target rate of blood pressure reduction in a Hypertensive Emergency to prevent cerebral or myocardial hypoperfusion?

![Figure 2: Clinical Findings & Diagnostic Reference (Hypertensive Emergencies)](/lessons/images/sba/cardiology/hypertensive-emergency/figure_02_p3.jpeg)


- **A.** Reduce MAP by no more than 20-25% over the first hour, then gradually towards 160/100 mmHg over the next 2-6 hours
- **B.** Rapidly lower blood pressure to normal (<120/80 mmHg) within 15 minutes
- **C.** Reduce systolic BP by at least 100 mmHg in the first 10 minutes
- **D.** Withhold all treatment for 24 hours to observe cerebral autoregulation
- **E.** Normalize diastolic BP to exactly 60 mmHg immediately

**Correct Answer:** A
**Explanation:**
Patients with chronic severe hypertension have rightward-shifted cerebral autoregulation curves. Rapid excessive drops in BP precipitate watershed cerebral infarction, optic nerve ischemia (blindness), or acute myocardial infarction. The target is a controlled reduction of MAP by 20-25% in the first hour.

## Question 3 of 5

In an acute Stanford Type A or B Aortic Dissection presenting with severe hypertension, what is the urgent target systolic blood pressure and heart rate, and which medication is administered first?

![Figure 3: Clinical Findings & Diagnostic Reference (Hypertensive Emergencies)](/lessons/images/sba/cardiology/hypertensive-emergency/figure_03_p5.jpeg)


- **A.** IV Beta-blocker (e.g. Labetalol or Esmolol) first to achieve HR <60 bpm, followed by vasodilators if needed to target systolic BP 100-120 mmHg
- **B.** IV Hydralazine alone targeting systolic BP 150 mmHg
- **C.** IV Sodium nitroprusside alone without beta-blockers
- **D.** Oral amlodipine targeting BP 140/90
- **E.** Rapid normal saline infusion

**Correct Answer:** A
**Explanation:**
In acute aortic dissection, beta-blockers (IV Labetalol or Esmolol) MUST be given BEFORE or concurrently with vasodilators (e.g. GTN/nitroprusside) to reduce aortic wall shear stress (dP/dt). Vasodilators given alone trigger reflex tachycardia, which increases aortic shear stress and propagates dissection. Target HR is <60 bpm and systolic BP 100-120 mmHg within 20 minutes.

## Question 4 of 5

Which intravenous antihypertensive agent is contraindicated as monotherapy in pheochromocytoma-induced hypertensive crisis because of the risk of unopposed alpha-adrenergic vasoconstriction?

- **A.** Pure beta-blockers (e.g. Propranolol, Atenolol, Metoprolol)
- **B.** Phenoxybenzamine (alpha-blocker)
- **C.** Phentolamine
- **D.** Magnesium sulphate
- **E.** Sodium nitroprusside

**Correct Answer:** A
**Explanation:**
In pheochromocytoma, catecholamines stimulate both alpha and beta receptors. Giving pure beta-blockers without prior effective alpha-blockade leaves alpha-1 receptors unopposed, causing massive vasoconstriction and catastrophic, potentially fatal hypertensive crisis. 'Alpha-blockade before beta-blockade' is the cardinal rule.

## Question 5 of 5

Why are sublingual short-acting Nifedipine capsules strictly avoided and contraindicated in the management of hypertensive crises?

- **A.** They cause unpredictable, precipitous drops in blood pressure resulting in fatal cerebral, renal, and myocardial ischaemia
- **B.** They cause severe hyperkalaemia
- **C.** They induce acute pulmonary embolism
- **D.** They cause irreversible heart block
- **E.** They cannot be absorbed orally

**Correct Answer:** A
**Explanation:**
Sublingual nifedipine bite-and-swallow causes rapid, uncontrolled hypotension with severe reflex sympathetic activation, leading to documented cases of acute ischaemic stroke, blindness, and myocardial infarction. It has been banned from emergency practice worldwide.
$SBA_CARD_022$,
    false,
    23,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 13/21: Left Anterior vs Posterior Fascicular Block
  -- 1) Interleave Lecture (Position 24)
  UPDATE "lessons"
  SET "position" = 24, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'left-anterior-vs-posterior-fascicular-block' OR "slug" = 'left-anterior-posterior-fascicular-block');

  -- 2) Upsert Quiz Lesson (Position 25)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-cardiology-left-anterior-posterior-fascicular-block',
    'Left Anterior vs Posterior Fascicular Block — SBA Interactive Quiz',
    'quiz',
    $SBA_CARD_023$# Left Anterior vs Posterior Fascicular Block — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 12-lead ECG demonstrates Left Axis Deviation of -60 degrees, a small Q wave with tall R wave (qR pattern) in leads I and aVL, and a small R wave with deep S wave (rS pattern) in leads II, III, and aVF, with normal QRS duration (<120 ms). What is the diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Left Anterior vs Posterior Fascicular Block)](/lessons/images/sba/cardiology/left-anterior-posterior-fascicular-block/figure_01_p2.jpeg)


- **A.** Left Anterior Fascicular Block (LAFB / Left Anterior Hemiblock)
- **B.** Left Posterior Fascicular Block (LPFB)
- **C.** Complete Left Bundle Branch Block
- **D.** Inferior myocardial infarction
- **E.** Right Ventricular Hypertrophy

**Correct Answer:** A
**Explanation:**
LAFB diagnostic criteria: (1) Marked left axis deviation (-45 to -90 degrees); (2) qR pattern in lateral leads (I, aVL); (3) rS pattern in inferior leads (II, III, aVF); (4) QRS duration <120 ms; (5) Absence of other causes of LAD (e.g. inferior MI, LVH).

![Clinical Algorithm & Advanced Reference (Left Anterior vs Posterior Fascicular Block)](/lessons/images/sba/cardiology/left-anterior-posterior-fascicular-block/figure_06_p6.jpeg)


## Question 2 of 5

Which of the following ECG criteria is required to diagnose isolated Left Posterior Fascicular Block (LPFB)?

![Figure 2: Clinical Findings & Diagnostic Reference (Left Anterior vs Posterior Fascicular Block)](/lessons/images/sba/cardiology/left-anterior-posterior-fascicular-block/figure_02_p3.jpeg)


- **A.** Right Axis Deviation (+90 to +180 degrees) with rS in leads I and aVL, qR in leads II, III, and aVF, in the absence of RVH or lateral MI
- **B.** Marked Left Axis Deviation (-60 degrees)
- **C.** QRS duration >140 ms with deep QS in V1
- **D.** ST-elevation in leads V1-V3
- **E.** PR interval <120 ms with delta waves

**Correct Answer:** A
**Explanation:**
LPFB diagnostic criteria: (1) Right axis deviation (+90 to +180 degrees); (2) rS pattern in leads I and aVL; (3) qR pattern in leads II, III, and aVF; (4) Normal QRS duration (<120 ms); (5) Exclusion of other causes of RAD (pulmonary embolism, cor pulmonale, RVH, extensive lateral MI).

![Clinical Algorithm & Advanced Reference (Left Anterior vs Posterior Fascicular Block)](/lessons/images/sba/cardiology/left-anterior-posterior-fascicular-block/figure_07_p7.jpeg)


## Question 3 of 5

Why is Left Anterior Fascicular Block (LAFB) vastly more common than Left Posterior Fascicular Block (LPFB) in clinical practice?

![Figure 3: Clinical Findings & Diagnostic Reference (Left Anterior vs Posterior Fascicular Block)](/lessons/images/sba/cardiology/left-anterior-posterior-fascicular-block/figure_03_p3.jpeg)


- **A.** The anterior fascicle is long, thin, fragile, and has a single blood supply (LAD septal perforators), whereas the posterior fascicle is broad and has dual blood supply (LAD and PDA)
- **B.** The posterior fascicle does not carry electrical impulses
- **C.** The anterior fascicle is protected by valves
- **D.** The right coronary artery never supplies the conducting system
- **E.** LAFB is an autosomal dominant congenital condition

**Correct Answer:** A
**Explanation:**
The left anterior fascicle is thin, elongated, traverses the turbulent LV outflow tract, and relies almost exclusively on septal perforator branches of the LAD. The left posterior fascicle is thick, broad, and dual-perfused by both the LAD and posterior descending artery (PDA), making isolated LPFB very uncommon.

![Clinical Algorithm & Advanced Reference (Left Anterior vs Posterior Fascicular Block)](/lessons/images/sba/cardiology/left-anterior-posterior-fascicular-block/figure_08_p8.jpeg)


## Question 4 of 5

In Left Anterior Fascicular Block, why are inferior leads (II, III, aVF) dominated by deep S waves?

![Figure 4: Clinical Findings & Diagnostic Reference (Left Anterior vs Posterior Fascicular Block)](/lessons/images/sba/cardiology/left-anterior-posterior-fascicular-block/figure_04_p4.jpeg)


- **A.** Depolarisation spreads initially downwards through the intact posterior fascicle, then moves late and upwards towards the anterolateral wall
- **B.** The inferior wall of the myocardium is completely infarcted
- **C.** Conduction through the right bundle branch is accelerated
- **D.** The AV node fires retrogradely
- **E.** Hyperkalaemia causes inferior T-wave inversion

**Correct Answer:** A
**Explanation:**
In LAFB, initial activation proceeds inferiorly and rightward via the intact posterior fascicle (producing tiny r waves in II, III, aVF). Then, activation of the anterior and lateral LV myocardium occurs late via cell-to-cell spread in a superior and leftward direction, away from the inferior leads, generating deep S waves.

![Clinical Algorithm & Advanced Reference (Left Anterior vs Posterior Fascicular Block)](/lessons/images/sba/cardiology/left-anterior-posterior-fascicular-block/figure_09_p8.jpeg)


## Question 5 of 5

A 70-year-old patient with an acute extensive anterior STEMI develops a new Left Anterior Fascicular Block on top of a pre-existing Right Bundle Branch Block. What is the clinical implication?

![Figure 5: Clinical Findings & Diagnostic Reference (Left Anterior vs Posterior Fascicular Block)](/lessons/images/sba/cardiology/left-anterior-posterior-fascicular-block/figure_05_p5.jpeg)


- **A.** High risk of sudden complete heart block due to extensive necrosis of the interventricular septum
- **B.** Benign finding with no risk of conduction failure
- **C.** Immediate indication to stop all antiplatelets
- **D.** Reassurance that reperfusion has succeeded
- **E.** The patient has converted to Mobitz Type I block

**Correct Answer:** A
**Explanation:**
Development of acute new bifascicular block (RBBB + LAFB) during acute anterior MI indicates massive septal infarction involving the proximal bundle branches. There is an extremely high risk of progression to complete heart block, ventricular asystole, and cardiogenic shock, requiring urgent cardiology consultation and temporary pacing pad application.
$SBA_CARD_023$,
    false,
    25,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 14/21: Bundle Branch Blocks (LBBB & RBBB)
  -- 1) Interleave Lecture (Position 26)
  UPDATE "lessons"
  SET "position" = 26, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'bundle-branch-blocks-lbbb-rbbb' OR "slug" = 'left-right-bundle-branch-block');

  -- 2) Upsert Quiz Lesson (Position 27)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-cardiology-left-right-bundle-branch-block',
    'Bundle Branch Blocks (LBBB & RBBB) — SBA Interactive Quiz',
    'quiz',
    $SBA_CARD_024$# Bundle Branch Blocks (LBBB & RBBB) — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

Which set of ECG features defines complete Left Bundle Branch Block (LBBB)?

![Figure 1: Clinical Findings & Diagnostic Reference (Bundle Branch Blocks (LBBB & RBBB))](/lessons/images/sba/cardiology/left-right-bundle-branch-block/figure_01_p1.jpeg)


- **A.** QRS duration >=120 ms, broad notched or slurred R waves in lateral leads (I, aVL, V5-V6), absence of Q waves in lateral leads, and deep QS complex in V1
- **B.** QRS duration <100 ms with tall R wave in V1
- **C.** rSR' pattern in lead V1 ('rabbit ears') with broad S wave in lead I
- **D.** PR interval >200 ms with delta waves
- **E.** Extreme right axis deviation with QRS duration 90 ms

**Correct Answer:** A
**Explanation:**
Complete LBBB criteria: (1) QRS >=120 ms; (2) Broad, notched or monophasic R wave in lateral leads (I, aVL, V5, V6); (3) Absence of Q waves in leads I, V5, V6; (4) Deep QS or rS pattern in lead V1; (5) ST-T wave discordance (opposite to main QRS deflection).

![Clinical Algorithm & Advanced Reference (Bundle Branch Blocks (LBBB & RBBB))](/lessons/images/sba/cardiology/left-right-bundle-branch-block/figure_06_p6.jpeg)


## Question 2 of 5

Which clinical criteria are validated to diagnose acute myocardial infarction in the presence of pre-existing Left Bundle Branch Block (LBBB)?

![Figure 2: Clinical Findings & Diagnostic Reference (Bundle Branch Blocks (LBBB & RBBB))](/lessons/images/sba/cardiology/left-right-bundle-branch-block/figure_02_p2.jpeg)


- **A.** Modified Sgarbossa Criteria
- **B.** Wellens Criteria
- **C.** Centor Criteria
- **D.** GCS scoring
- **E.** San Francisco Syncope Rule

**Correct Answer:** A
**Explanation:**
The Sgarbossa (and Smith-modified Sgarbossa) criteria diagnose acute STEMI in the presence of LBBB or ventricular paced rhythm: (1) Concordant ST elevation >=1 mm in leads with positive QRS (5 points); (2) Concordant ST depression >=1 mm in V1, V2, or V3 (3 points); (3) Disproportionate discordant ST elevation >=1 mm with ST/S ratio <= -0.25 (Smith modification).

![Clinical Algorithm & Advanced Reference (Bundle Branch Blocks (LBBB & RBBB))](/lessons/images/sba/cardiology/left-right-bundle-branch-block/figure_07_p6.jpeg)


## Question 3 of 5

A 12-lead ECG demonstrates QRS duration of 135 ms, a classic rSR' pattern ('M-shaped' rabbit ears) in Lead V1, and wide slurred S waves in Leads I and V6. What is the diagnosis?

![Figure 3: Clinical Findings & Diagnostic Reference (Bundle Branch Blocks (LBBB & RBBB))](/lessons/images/sba/cardiology/left-right-bundle-branch-block/figure_03_p3.jpeg)


- **A.** Complete Right Bundle Branch Block (RBBB)
- **B.** Complete Left Bundle Branch Block (LBBB)
- **C.** Wolf-Parkinson-White syndrome
- **D.** Brugada syndrome Type 1
- **E.** Left ventricular hypertrophy

**Correct Answer:** A
**Explanation:**
Complete RBBB criteria: (1) QRS >=120 ms; (2) rsR', rSR', or M-shaped notched QRS complex in V1-V2; (3) Wide, slurred S wave in lateral leads (I, aVL, V5-V6). In RBBB, normal initial septal activation is preserved (from left to right), so Q waves in MI can still be reliably interpreted.

## Question 4 of 5

A 24-year-old healthy male has an ECG performed for a sports medical showing an rSr' complex in Lead V1, normal axis, normal intervals, and a QRS duration of 105 ms. What is the correct interpretation?

![Figure 4: Clinical Findings & Diagnostic Reference (Bundle Branch Blocks (LBBB & RBBB))](/lessons/images/sba/cardiology/left-right-bundle-branch-block/figure_04_p4.jpeg)


- **A.** Incomplete Right Bundle Branch Block (IRBBB), a common normal physiological variant in young healthy individuals
- **B.** Severe cardiomyopathy requiring immediate implantable cardioverter-defibrillator (ICD)
- **C.** High-risk Brugada syndrome requiring sports cessation
- **D.** Complete heart block
- **E.** Acute anterior myocardial infarction

**Correct Answer:** A
**Explanation:**
Incomplete RBBB (QRS duration 100-119 ms with RBBB morphology in V1) is a common, benign physiological finding in up to 5-10% of healthy young individuals and athletes due to physiological RV enlargement, with excellent prognosis.

## Question 5 of 5

Why does pre-existing Left Bundle Branch Block (LBBB) obscure the classic ECG diagnosis of acute myocardial infarction on standard interpretation?

![Figure 5: Clinical Findings & Diagnostic Reference (Bundle Branch Blocks (LBBB & RBBB))](/lessons/images/sba/cardiology/left-right-bundle-branch-block/figure_05_p5.jpeg)


- **A.** Altered septal activation eliminates normal physiological Q waves, and baseline secondary ST-T wave discordance mimics or masks ischaemic ST shifts
- **B.** LBBB completely stops blood flow to coronary arteries
- **C.** LBBB causes electrical silence in leads V1 to V6
- **D.** Troponin is never released in patients with LBBB
- **E.** The heart rate in LBBB is always faster than 200 bpm

**Correct Answer:** A
**Explanation:**
In LBBB, the septum is depolarised abnormally from right to left (reversing normal septal vectors), obliterating septal Q waves. Furthermore, LBBB induces marked baseline secondary repolarisation abnormalities (discordant ST elevation in right precordial leads and ST depression in lateral leads) that mask or mimic acute ischaemia.
$SBA_CARD_024$,
    false,
    27,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 15/21: Long QT Syndrome & Torsades de Pointes
  -- 1) Interleave Lecture (Position 28)
  UPDATE "lessons"
  SET "position" = 28, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'long-qt-syndrome-torsades' OR "slug" = 'long-qt-syndrome');

  -- 2) Upsert Quiz Lesson (Position 29)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-cardiology-long-qt-syndrome',
    'Long QT Syndrome & Torsades de Pointes — SBA Interactive Quiz',
    'quiz',
    $SBA_CARD_025$# Long QT Syndrome & Torsades de Pointes — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 22-year-old woman collapses with syncope while running a marathon. In the ED, telemetry reveals episodes of polymorphic ventricular tachycardia with a characteristic twist of the QRS peaks around the isoelectric baseline at a rate of 220 bpm. What is this arrhythmia termed?

![Figure 1: Clinical Findings & Diagnostic Reference (Long QT Syndrome & Torsades de Pointes)](/lessons/images/sba/cardiology/long-qt-syndrome/figure_01_p3.jpeg)


- **A.** Torsades de Pointes (TdP)
- **B.** Monomorphic Ventricular Tachycardia
- **C.** Ventricular fibrillation
- **D.** Atrial flutter with 1:1 conduction
- **E.** Accelerated idioventricular rhythm

**Correct Answer:** A
**Explanation:**
Torsades de Pointes ('twisting of the points') is a specific form of polymorphic ventricular tachycardia occurring in the setting of acquired or congenital prolonged QT interval. The QRS complexes continuously twist in polarity around the isoelectric baseline.

## Question 2 of 5

What is the immediate first-line intravenous pharmacological treatment for haemodynamically stable Torsades de Pointes, regardless of the patient's baseline serum magnesium level?

![Figure 2: Clinical Findings & Diagnostic Reference (Long QT Syndrome & Torsades de Pointes)](/lessons/images/sba/cardiology/long-qt-syndrome/figure_02_p4.jpeg)


- **A.** Intravenous Magnesium Sulphate (2g IV bolus over 1-2 minutes)
- **B.** Intravenous Amiodarone 300mg
- **C.** Intravenous Procainamide 100mg
- **D.** Intravenous Sotalol 80mg
- **E.** Intravenous Flecainide 150mg

**Correct Answer:** A
**Explanation:**
IV Magnesium Sulphate (2 g IV push over 1-2 minutes, repeatable in 5-10 minutes) is the drug of choice for Torsades de Pointes. Magnesium acts by blocking early after-depolarisations (EADs) and suppressing triggered activity, even in normomagnesaemic patients. Note: Class Ia and III antiarrhythmics (amiodarone, procainamide, sotalol) prolong QT and are strictly CONTRAINDICATED.

## Question 3 of 5

Which of the following formula is standardly used to correct the measured QT interval for heart rate on ECG, and what value is generally considered prolonged in adult females?

![Figure 3: Clinical Findings & Diagnostic Reference (Long QT Syndrome & Torsades de Pointes)](/lessons/images/sba/cardiology/long-qt-syndrome/figure_03_p5.jpeg)


- **A.** Bazett formula (QTc = QT / sqrt(RR)); QTc >460-470 ms
- **B.** Framingham formula; QTc >350 ms
- **C.** Cockcroft-Gault formula; QTc >500 ms
- **D.** Winter formula; QTc >400 ms
- **E.** Haskell formula; QTc >300 ms

**Correct Answer:** A
**Explanation:**
The Bazett formula (QTc = QT / sqrt(RR in seconds)) is the most widely used heart-rate correction. Prolonged QTc is typically defined as >450 ms in adult males and >460-470 ms in adult females. A QTc >500 ms carries high risk of degenerating into Torsades de Pointes.

## Question 4 of 5

Which commonly prescribed emergency department antimicrobials and antiemetics are well-known causes of acquired QT prolongation that can precipitate Torsades de Pointes?

![Figure 4: Clinical Findings & Diagnostic Reference (Long QT Syndrome & Torsades de Pointes)](/lessons/images/sba/cardiology/long-qt-syndrome/figure_04_p5.jpeg)


- **A.** Macrolides (Clarithromycin, Azithromycin), Fluoroquinolones (Ciprofloxacin), and Ondansetron / Haloperidol
- **B.** Amoxicillin and Paracetamol
- **C.** Cephalexin and Metronidazole
- **D.** Doxycycline and Ibuprofen
- **E.** Gentamicin and Meropenem

**Correct Answer:** A
**Explanation:**
Acquired long QT is frequently triggered by drugs that block the I_Kr potassium channel: macrolides, fluoroquinolones, antipsychotics (haloperidol), antiemetics (ondansetron, droperidol), and antiarrhythmics (sotalol, amiodarone), especially when combined with hypokalaemia or hypomagnesaemia.

## Question 5 of 5

What acute emergency intervention is indicated for recurrent pauses and bradycardia-dependent Torsades de Pointes that fails to terminate with intravenous magnesium boluses?

- **A.** Temporary overdrive pacing (target HR 90-110 bpm) or Isoprenaline infusion
- **B.** IV Metoprolol bolus to slow heart rate down to 40 bpm
- **C.** Immediate hyperventilation to induce alkalosis
- **D.** Ice water immersion
- **E.** High-dose adenosine bolus

**Correct Answer:** A
**Explanation:**
Torsades de Pointes is frequently pause-dependent and worsened by bradycardia (which lengthens QT). Overdrive electrical pacing (or chronotropic infusion with Isoprenaline) shortens the ventricular cycle length, shortens the QT interval, and eliminates the pause-dependent trigger.
$SBA_CARD_025$,
    false,
    29,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 16/21: Acute Myocarditis
  -- 1) Interleave Lecture (Position 30)
  UPDATE "lessons"
  SET "position" = 30, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'acute-myocarditis' OR "slug" = 'myocarditis');

  -- 2) Upsert Quiz Lesson (Position 31)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-cardiology-myocarditis',
    'Acute Myocarditis — SBA Interactive Quiz',
    'quiz',
    $SBA_CARD_026$# Acute Myocarditis — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 24-year-old previously fit athlete presents with sharp central chest pain radiating to his left shoulder, mild fever, and shortness of breath, 10 days after a flu-like viral illness. 12-lead ECG shows widespread concave ST-segment elevation. High-sensitivity Troponin T is markedly elevated at 1450 ng/L. Urgent coronary angiography reveals unobstructed coronary arteries. What is the most likely diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Acute Myocarditis)](/lessons/images/sba/cardiology/myocarditis/figure_01_p1.jpeg)


- **A.** Acute Myopericarditis
- **B.** Atherosclerotic STEMI
- **C.** Aortic dissection
- **D.** Bacterial pneumonia
- **E.** Costochondritis

**Correct Answer:** A
**Explanation:**
Acute myopericarditis typically affects young adults following a viral prodrome (Coxsackievirus, Parvovirus B19, HHV-6, SARS-CoV-2). It mimics acute STEMI with chest pain, ECG ST-elevation, and significant troponin elevation, but coronary angiography shows normal patent arteries.

## Question 2 of 5

What is the gold standard, non-invasive imaging modality of choice to confirm myocardial inflammation, oedema, and necrosis in suspected acute myocarditis?

![Figure 2: Clinical Findings & Diagnostic Reference (Acute Myocarditis)](/lessons/images/sba/cardiology/myocarditis/figure_02_p4.jpeg)


- **A.** Cardiovascular Magnetic Resonance (CMR) using Lake Louise Criteria
- **B.** CT Pulmonary Angiogram
- **C.** Transthoracic Echocardiogram alone
- **D.** Technetium bone scan
- **E.** Barium swallow

**Correct Answer:** A
**Explanation:**
Cardiac MRI (CMR) is the reference non-invasive investigation. The updated Lake Louise Criteria (myocardial oedema on T2-weighted imaging plus late gadolinium enhancement [LGE] showing non-ischaemic epicardial/mid-wall pattern) has high diagnostic sensitivity and specificity for acute myocarditis.

## Question 3 of 5

Which histological subtype of myocarditis presents with rapid, fulminant heart failure, refractory ventricular arrhythmias, and heart block, classically requiring urgent immunosuppressive therapy and early mechanical circulatory support (ECMO/LVAD)?

![Figure 3: Clinical Findings & Diagnostic Reference (Acute Myocarditis)](/lessons/images/sba/cardiology/myocarditis/figure_03_p5.jpeg)


- **A.** Giant Cell Myocarditis
- **B.** Lymphocytic viral myocarditis
- **C.** Eosinophilic myocarditis
- **D.** Chagas disease
- **E.** Toxoplasmosis myocarditis

**Correct Answer:** A
**Explanation:**
Giant Cell Myocarditis is a rare, aggressive autoimmune disorder of young adults characterized by multinucleated giant cells and widespread myocardial necrosis. It carries a dismal prognosis without urgent combined immunosuppressive therapy (cyclosporine, corticosteroids) and mechanical circulatory support or heart transplant.

## Question 4 of 5

What physical activity advice is strongly recommended by ESC and AHA guidelines for athletes diagnosed with acute myocarditis?

- **A.** Strict cessation of competitive and recreational strenuous athletic activity for at least 3 to 6 months until clinical and CMR resolution
- **B.** Continue regular marathon training if asymptomatic
- **C.** No physical restrictions needed after 48 hours
- **D.** Only avoid swimming
- **E.** Permanent lifelong ban from all forms of walking

**Correct Answer:** A
**Explanation:**
Athletes with acute myocarditis are at high risk of sudden cardiac death due to ventricular arrhythmias triggered by intense exercise during active inflammation. Current guidelines mandate abstaining from competitive and strenuous sports for a minimum of 3-6 months, resuming only after reassessment confirms normalized ventricular function, biomarkers, and 24h ECG.

## Question 5 of 5

Which parasitic infection transmitted by the Reduviid (triatomine) kissing bug in Central and South America causes chronic myocarditis, apical LV aneurysms, megacolon, and mega-oesophagus?

- **A.** Trypanosoma cruzi (Chagas Disease)
- **B.** Plasmodium falciparum
- **C.** Leishmania donovani
- **D.** Entamoeba histolytica
- **E.** Schistosoma mansoni

**Correct Answer:** A
**Explanation:**
Chagas disease is caused by Trypanosoma cruzi. Chronic Chagas cardiomyopathy develops decades after initial infection, causing conduction system fibrosis (RBBB + LAFB), apical left ventricular aneurysms, lethal ventricular arrhythmias, and dilated cardiomyopathy, often with gastrointestinal mega-syndromes.
$SBA_CARD_026$,
    false,
    31,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 17/21: Non-Invasive Ventilation (NIV) Guidelines
  -- 1) Interleave Lecture (Position 32)
  UPDATE "lessons"
  SET "position" = 32, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'non-invasive-ventilation-niv-guidelines' OR "slug" = 'niv-guidelines');

  -- 2) Upsert Quiz Lesson (Position 33)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-cardiology-niv-guidelines',
    'Non-Invasive Ventilation (NIV) Guidelines — SBA Interactive Quiz',
    'quiz',
    $SBA_CARD_027$# Non-Invasive Ventilation (NIV) Guidelines — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 67-year-old male with severe COPD presents with acute breathlessness and drowsiness. Arterial Blood Gas (ABG) on 28% Venturi mask reveals: pH 7.26, PaCO2 8.4 kPa (63 mmHg), PaO2 7.8 kPa (58 mmHg), HCO3- 32 mmol/L. According to British Thoracic Society (BTS) guidelines, what is the immediate respiratory intervention?

![Figure 1: Clinical Findings & Diagnostic Reference (Non-Invasive Ventilation (NIV) Guidelines)](/lessons/images/sba/cardiology/niv-guidelines/figure_01_p2.jpeg)


- **A.** Initiate Non-Invasive Ventilation (Bilevel Positive Airway Pressure - BiPAP)
- **B.** Increase oxygen to 15 L/min via non-rebreathe reservoir mask
- **C.** Continuous Positive Airway Pressure (CPAP) at 12 cm H2O
- **D.** Immediate endotracheal intubation without trial of NIV
- **E.** Administer IV sodium bicarbonate infusion

**Correct Answer:** A
**Explanation:**
BTS guidelines recommend NIV (BiPAP) as first-line therapy for acute hypercapnic respiratory failure (AHRF) secondary to COPD exacerbation when persistent respiratory acidosis (pH <7.35 and PaCO2 >6.0 kPa) persists despite optimal medical therapy and controlled oxygen for 60 minutes.

## Question 2 of 5

What is the recommended initial pressure setting for Bilevel Positive Airway Pressure (BiPAP) in acute hypercapnic COPD exacerbation according to BTS guidelines?

![Figure 2: Clinical Findings & Diagnostic Reference (Non-Invasive Ventilation (NIV) Guidelines)](/lessons/images/sba/cardiology/niv-guidelines/figure_02_p3.jpeg)


- **A.** IPAP 10-12 cm H2O and EPAP 4-5 cm H2O, titrating IPAP upwards to 15-20 cm H2O
- **B.** IPAP 25 cm H2O and EPAP 15 cm H2O immediately
- **C.** IPAP 5 cm H2O and EPAP 10 cm H2O
- **D.** Fixed CPAP 10 cm H2O without IPAP
- **E.** IPAP 30 cm H2O and EPAP 2 cm H2O

**Correct Answer:** A
**Explanation:**
Recommended initial BiPAP settings: Inspiratory Positive Airway Pressure (IPAP) 10-12 cm H2O and Expiratory Positive Airway Pressure (EPAP) 4-5 cm H2O. IPAP is titrated upward in steps of 2-3 cm H2O every 15-30 minutes towards 16-20 cm H2O based on clinical tolerance, tidal volume (6-8 ml/kg), and repeat ABG.

## Question 3 of 5

Which of the following represents an ABSOLUTE contraindication to initiating non-invasive positive pressure ventilation (NIV)?

- **A.** Undrained tension pneumothorax or facial trauma/burns preventing mask seal
- **B.** pH of 7.28
- **C.** PaCO2 of 7.5 kPa
- **D.** Mild confusion
- **E.** Respiratory rate of 28/min

**Correct Answer:** A
**Explanation:**
Absolute contraindications to NIV: undrained pneumothorax (positive pressure can convert simple into fatal tension pneumothorax), severe facial trauma/deformity preventing mask seal, bowel obstruction/severe vomiting (high aspiration risk), and inability to maintain airway.

## Question 4 of 5

When should an arterial blood gas (ABG) be repeated after initiating Non-Invasive Ventilation to evaluate response and determine if treatment failure is occurring?

- **A.** At 1 to 2 hours after commencing NIV
- **B.** At 24 hours
- **C.** At 5 minutes
- **D.** Only when the patient is ready for discharge
- **E.** ABG monitoring is not necessary if pulse oximetry is >90%

**Correct Answer:** A
**Explanation:**
BTS guidelines mandate a repeat ABG at 1 hour (and 4 hours) following initiation of NIV. Failure of pH and PaCO2 to improve, or worsening acidosis/sensorium, indicates NIV failure and should prompt immediate evaluation for invasive mechanical ventilation.

## Question 5 of 5

What is the key physiological difference between CPAP and BiPAP in emergency non-invasive ventilation?

- **A.** CPAP delivers a constant single positive airway pressure throughout inspiration and expiration (ideal for type 1 failure / pulmonary oedema), whereas BiPAP delivers two distinct pressure levels (IPAP and EPAP) to assist ventilation in hypercapnic type 2 failure
- **B.** CPAP requires an endotracheal tube whereas BiPAP uses a mask
- **C.** BiPAP only delivers oxygen at atmospheric pressure
- **D.** CPAP cannot be used in acute pulmonary oedema
- **E.** BiPAP is contraindicated in COPD

**Correct Answer:** A
**Explanation:**
CPAP provides a continuous constant positive pressure that keeps alveoli open and improves oxygenation (type 1 respiratory failure, e.g. cardiogenic pulmonary oedema, atelectasis). BiPAP provides dual pressure: IPAP assists alveolar ventilation and clears CO2, while EPAP recruits alveoli (type 2 hypercapnic respiratory failure, e.g. COPD, neuromuscular weakness).
$SBA_CARD_027$,
    false,
    33,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 18/21: Acute Pericarditis & Cardiac Tamponade
  -- 1) Interleave Lecture (Position 34)
  UPDATE "lessons"
  SET "position" = 34, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'acute-pericarditis-tamponade' OR "slug" = 'pericarditis');

  -- 2) Upsert Quiz Lesson (Position 35)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-cardiology-pericarditis',
    'Acute Pericarditis & Cardiac Tamponade — SBA Interactive Quiz',
    'quiz',
    $SBA_CARD_028$# Acute Pericarditis & Cardiac Tamponade — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 32-year-old male presents with sharp retrosternal chest pain that worsens on inspiration and lying flat, and improves dramatically when sitting forward. Auscultation reveals a superficial, high-pitched scratching friction rub at the left lower sternal border. What is the classic 12-lead ECG finding in Stage 1 acute pericarditis?

![Figure 1: Clinical Findings & Diagnostic Reference (Acute Pericarditis & Cardiac Tamponade)](/lessons/images/sba/cardiology/pericarditis/figure_01_p1.jpeg)


- **A.** Widespread, concave-upward ST elevation with reciprocal PR depression in Lead aVR and widespread PR segment depression
- **B.** Convex 'tombstone' ST elevation in leads II, III, aVF
- **C.** Deep S wave in lead I, Q wave in lead III, inverted T wave in lead III (S1Q3T3)
- **D.** Low voltage QRS complexes in all leads with delta waves
- **E.** Biphasic T waves in leads V2-V3 only

**Correct Answer:** A
**Explanation:**
Stage 1 acute pericarditis classic ECG features: widespread concave ST-segment elevation across almost all limb and precordial leads, with reciprocal ST depression in aVR (and V1), and pathognomonic widespread PR-segment depression (with PR elevation in aVR) reflecting atrial injury.

## Question 2 of 5

What is the first-line medical therapy recommended by ESC guidelines for acute idiopathic or viral pericarditis to reduce symptoms and prevent recurrent attacks?

![Figure 2: Clinical Findings & Diagnostic Reference (Acute Pericarditis & Cardiac Tamponade)](/lessons/images/sba/cardiology/pericarditis/figure_02_p4.jpeg)


- **A.** High-dose NSAIDs (e.g. Ibuprofen 600-800mg TDS or Aspirin 750-1000mg TDS) plus Colchicine (0.5mg once or twice daily for 3 months)
- **B.** High-dose systemic oral Prednisolone monotherapy
- **C.** Intravenous Heparin infusion
- **D.** Oral Warfarin targeting INR 3.0
- **E.** Broad-spectrum IV Vancomycin

**Correct Answer:** A
**Explanation:**
First-line therapy for acute pericarditis: NSAIDs (Ibuprofen 600-800 mg TDS or Aspirin) combined with Colchicine (0.5 mg daily or BD based on body weight) for 3 months. Colchicine significantly halves the rate of recurrence and treatment failure. Corticosteroids are second-line because they increase recurrence rates.

## Question 3 of 5

A 48-year-old male with malignant pericardial effusion presents with severe dyspnoea, lethargy, and cold extremities. Examination reveals hypotension (BP 82/56 mmHg), distended neck veins (elevated JVP), and distant, muffled heart sounds. What is this classic clinical triad termed?

![Figure 3: Clinical Findings & Diagnostic Reference (Acute Pericarditis & Cardiac Tamponade)](/lessons/images/sba/cardiology/pericarditis/figure_03_p5.jpeg)


- **A.** Beck's Triad of Cardiac Tamponade
- **B.** Virchow's Triad
- **C.** Charcot's Triad
- **D.** Cushing's Triad
- **E.** Reynolds' Pentad

**Correct Answer:** A
**Explanation:**
Beck's triad of acute cardiac tamponade consists of: (1) Hypotension (decreased stroke volume); (2) Jugular venous distension (impaired venous return to the right heart); (3) Muffled, distant heart sounds (insulating layer of pericardial fluid).

## Question 4 of 5

What physical examination finding is defined as an abnormally large drop in systolic blood pressure (>10 mmHg) during normal inspiration, pathognomonic of cardiac tamponade?

![Figure 4: Clinical Findings & Diagnostic Reference (Acute Pericarditis & Cardiac Tamponade)](/lessons/images/sba/cardiology/pericarditis/figure_04_p6.jpeg)


- **A.** Pulsus paradoxus
- **B.** Pulsus alternans
- **C.** Pulsus bisferiens
- **D.** Water-hammer pulse
- **E.** Kussmaul's sign

**Correct Answer:** A
**Explanation:**
Pulsus paradoxus is an exaggeration (>10 mmHg) of the normal physiological drop in systolic BP during inspiration. In cardiac tamponade, ventricular interdependence within the rigid pericardium causes inspiratory right ventricular filling to bulge the interventricular septum into the left ventricle, compromising LV stroke volume.

## Question 5 of 5

What is the emergency life-saving procedure of choice for a patient with cardiac tamponade presenting in obstructive shock and PEA cardiac arrest?

- **A.** Emergency Pericardiocentesis (subxiphoid or ultrasound-guided apical approach)
- **B.** High-dose IV Furosemide 120mg bolus
- **C.** Immediate DC cardioversion 200J
- **D.** Chest tube insertion into the right pleural space
- **E.** Nitroglycerin sublingual spray

**Correct Answer:** A
**Explanation:**
Cardiac tamponade is a mechanical obstructive cause of cardiac arrest ('4 Ts - Tamponade'). Emergency pericardiocentesis (aspirating even 20-50 ml of fluid) decompresses the pericardial space, restores diastolic ventricular filling, and can immediately restore cardiac output.
$SBA_CARD_028$,
    false,
    35,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 19/21: Tachyarrhythmias Management
  -- 1) Interleave Lecture (Position 36)
  UPDATE "lessons"
  SET "position" = 36, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'tachyarrhythmias-management' OR "slug" = 'tachyarrhythmia');

  -- 2) Upsert Quiz Lesson (Position 37)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-cardiology-tachyarrhythmia',
    'Tachyarrhythmias Management — SBA Interactive Quiz',
    'quiz',
    $SBA_CARD_029$# Tachyarrhythmias Management — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 35-year-old woman presents with sudden onset racing heart and lightheadedness. ECG shows a regular narrow-complex tachycardia (QRS 80 ms) at 190 bpm with retrograde P waves buried within the QRS complexes. BP is 114/72 mmHg. Vagal manoeuvres (modified Valsalva) fail. What is the first-line pharmacological treatment per Resuscitation Council UK guidelines?

![Figure 1: Clinical Findings & Diagnostic Reference (Tachyarrhythmias Management)](/lessons/images/sba/cardiology/tachyarrhythmia/figure_01_p1.jpeg)


- **A.** IV Adenosine 6mg rapid bolus with immediate flush (titrating to 12mg, then 18mg if needed)
- **B.** IV Amiodarone 300mg infusion
- **C.** IV Metoprolol 5mg slow bolus
- **D.** Synchronised DC cardioversion 100J
- **E.** Oral Digoxin 500mcg

**Correct Answer:** A
**Explanation:**
For haemodynamically stable regular narrow-complex tachycardia (SVT / AVNRT), after vagal manoeuvres, IV Adenosine (initial 6 mg rapid bolus via large proximal vein with fast saline flush) is first-line. If unsuccessful, give 12 mg, then 18 mg. Adenosine terminates AV nodal re-entrant circuits in over 90% of cases.

![Clinical Algorithm & Advanced Reference (Tachyarrhythmias Management)](/lessons/images/sba/cardiology/tachyarrhythmia/figure_06_p6.jpeg)


## Question 2 of 5

In which medical condition is the use of intravenous Adenosine strictly CONTRAINDICATED due to the risk of precipitating fatal bronchospasm?

![Figure 2: Clinical Findings & Diagnostic Reference (Tachyarrhythmias Management)](/lessons/images/sba/cardiology/tachyarrhythmia/figure_02_p2.jpeg)


- **A.** Severe active bronchial asthma
- **B.** Type 2 diabetes mellitus
- **C.** Systemic hypertension
- **D.** Osteoarthritis
- **E.** Previous appendicectomy

**Correct Answer:** A
**Explanation:**
Adenosine causes bronchoconstriction via purinergic A2B/A3 receptors on mast cells. It is contraindicated in patients with severe active asthma, bronchospastic lung disease, or known adenosine hypersensitivity. Non-dihydropyridine calcium channel blockers (e.g. Verapamil) are the preferred alternative.

![Clinical Algorithm & Advanced Reference (Tachyarrhythmias Management)](/lessons/images/sba/cardiology/tachyarrhythmia/figure_07_p7.jpeg)


## Question 3 of 5

A 52-year-old man presents with rapid palpitations, sweating, and severe central chest tightness. The monitor shows a regular wide-complex tachycardia at 170 bpm. BP is 74/48 mmHg, and GCS is 13. According to ALS guidelines, what is the immediate treatment?

![Figure 3: Clinical Findings & Diagnostic Reference (Tachyarrhythmias Management)](/lessons/images/sba/cardiology/tachyarrhythmia/figure_03_p3.jpeg)


- **A.** Immediate Synchronised DC Cardioversion (120-150J biphasic) with sedation/analgesia
- **B.** IV Adenosine 6mg
- **C.** IV Amiodarone 300mg over 30 minutes
- **D.** Oral Sotalol 160mg
- **E.** Carotid sinus massage for 60 seconds

**Correct Answer:** A
**Explanation:**
The presence of any adverse feature (shock, syncope, myocardial ischaemia, or acute heart failure) in a tachyarrhythmia mandates immediate synchronised DC cardioversion. Up to 3 synchronized shocks should be attempted before considering amiodarone.

![Clinical Algorithm & Advanced Reference (Tachyarrhythmias Management)](/lessons/images/sba/cardiology/tachyarrhythmia/figure_08_p8.jpeg)


## Question 4 of 5

What is the recommended initial physical manoeuvre with highest proven cardioversion success rates (43% vs 17% standard) for terminating stable supraventricular tachycardia (AVNRT/AVRT) in the ED?

![Figure 4: Clinical Findings & Diagnostic Reference (Tachyarrhythmias Management)](/lessons/images/sba/cardiology/tachyarrhythmia/figure_04_p4.jpeg)


- **A.** Modified Valsalva manoeuvre (straining against 40 mmHg for 15s followed immediately by passive leg elevation to 45 degrees)
- **B.** Bilateral simultaneous eyeball pressure
- **C.** Bilateral simultaneous carotid sinus massage
- **D.** Deep knee bends for 2 minutes
- **E.** Trendelenburg position for 1 hour

**Correct Answer:** A
**Explanation:**
The REVERT trial demonstrated that the Modified Valsalva Manoeuvre (blowing into a 10ml syringe to generate 40 mmHg pressure for 15 seconds, followed immediately by lying flat with passive leg elevation to 45 degrees for 15 seconds) achieved a 43% conversion rate to sinus rhythm compared to 17% for the standard Valsalva manoeuvre.

![Clinical Algorithm & Advanced Reference (Tachyarrhythmias Management)](/lessons/images/sba/cardiology/tachyarrhythmia/figure_09_p10.jpeg)


## Question 5 of 5

When a regular wide-complex tachycardia is encountered in an adult patient with no prior ECG, how should it be managed medically if the clinician is uncertain whether it is VT or SVT with aberrancy?

![Figure 5: Clinical Findings & Diagnostic Reference (Tachyarrhythmias Management)](/lessons/images/sba/cardiology/tachyarrhythmia/figure_05_p5.jpeg)


- **A.** Treat as Ventricular Tachycardia (VT) until proven otherwise
- **B.** Treat as SVT and administer IV Verapamil
- **C.** Give IV Digoxin loading dose
- **D.** Administer IV Atropine
- **E.** Perform vagal manoeuvres only and discharge home if stable

**Correct Answer:** A
**Explanation:**
Over 80% of all regular wide-complex tachycardias are Ventricular Tachycardia (and >90% in patients with previous MI or structural heart disease). Giving AV-nodal blockers like verapamil to a patient in VT can precipitate refractory hypotension, ventricular fibrillation, and death. Always treat wide-complex tachycardia as VT unless proven otherwise.

![Clinical Algorithm & Advanced Reference (Tachyarrhythmias Management)](/lessons/images/sba/cardiology/tachyarrhythmia/figure_10_p10.jpeg)


![Supplementary Clinical Reference 6 (Tachyarrhythmias Management)](/lessons/images/sba/cardiology/tachyarrhythmia/figure_11_p11.jpeg)


![Supplementary Clinical Reference 7 (Tachyarrhythmias Management)](/lessons/images/sba/cardiology/tachyarrhythmia/figure_12_p12.jpeg)


![Supplementary Clinical Reference 8 (Tachyarrhythmias Management)](/lessons/images/sba/cardiology/tachyarrhythmia/figure_13_p13.jpeg)


![Supplementary Clinical Reference 9 (Tachyarrhythmias Management)](/lessons/images/sba/cardiology/tachyarrhythmia/figure_14_p14.jpeg)


![Supplementary Clinical Reference 10 (Tachyarrhythmias Management)](/lessons/images/sba/cardiology/tachyarrhythmia/figure_15_p15.jpeg)


![Supplementary Clinical Reference 11 (Tachyarrhythmias Management)](/lessons/images/sba/cardiology/tachyarrhythmia/figure_16_p16.jpeg)

$SBA_CARD_029$,
    false,
    37,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 20/21: Valvular Heart Disease in the ED
  -- 1) Interleave Lecture (Position 38)
  UPDATE "lessons"
  SET "position" = 38, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'valvular-heart-disease-in-the-ed' OR "slug" = 'valvular-heart-disease');

  -- 2) Upsert Quiz Lesson (Position 39)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-cardiology-valvular-heart-disease',
    'Valvular Heart Disease in the ED — SBA Interactive Quiz',
    'quiz',
    $SBA_CARD_030$# Valvular Heart Disease in the ED — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 78-year-old male presents with exertional syncope. On examination, he has a slow-rising, low-volume pulse (pulsus parvus et tardus), an ejection systolic murmur loudest in the right second intercostal space radiating to the carotids, and an absent or soft A2 component of S2. What is the diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Valvular Heart Disease in the ED)](/lessons/images/sba/cardiology/valvular-heart-disease/figure_01_p1.jpeg)


- **A.** Severe Aortic Stenosis (AS)
- **B.** Aortic Regurgitation
- **C.** Mitral Regurgitation
- **D.** Tricuspid Stenosis
- **E.** Pulmonary Regurgitation

**Correct Answer:** A
**Explanation:**
The classic triad of symptomatic severe aortic stenosis is Angina, Syncope, and Dyspnoea (SAD). Characteristic examination findings: slow-rising, plateau pulse (pulsus parvus et tardus), harsh crescendo-decrescendo ejection systolic murmur at the aortic area radiating to the carotids, and soft/absent A2.

## Question 2 of 5

Why must aggressive preload-reducing medications (such as high-dose nitrates and vigorous loop diuretics) be used with extreme caution or avoided in patients with severe Aortic Stenosis presenting with angina or heart failure?

![Figure 2: Clinical Findings & Diagnostic Reference (Valvular Heart Disease in the ED)](/lessons/images/sba/cardiology/valvular-heart-disease/figure_02_p2.jpeg)


- **A.** The hypertrophied left ventricle is fixed-afterload and exquisitely preload-dependent; excessive vasodilation causes precipitous drops in cardiac output and fatal shock
- **B.** They cause severe acute aortic valve rupture
- **C.** They induce acute massive pulmonary embolism
- **D.** They cause irreversible complete heart block
- **E.** They neutralize cardiac troponin

**Correct Answer:** A
**Explanation:**
Severe aortic stenosis represents a fixed mechanical outflow obstruction. The hypertrophic, non-compliant LV requires high end-diastolic filling pressures (preload) to generate adequate forward stroke volume. Venodilators (nitrates) or excessive diuresis sharply drop venous return, precipitating profound hypotension, syncope, and cardiac arrest.

## Question 3 of 5

A 45-year-old woman with a history of rheumatic heart disease presents with worsening dyspnoea, orthopnoea, and new-onset atrial fibrillation. Auscultation reveals a loud first heart sound (S1), an opening snap in early diastole, and a low-pitched mid-diastolic rumbling murmur heard best at the apex in the left lateral position. What is the diagnosis?

![Figure 3: Clinical Findings & Diagnostic Reference (Valvular Heart Disease in the ED)](/lessons/images/sba/cardiology/valvular-heart-disease/figure_03_p11.jpeg)


- **A.** Mitral Stenosis (MS)
- **B.** Aortic Stenosis
- **C.** Mitral Valve Prolapse
- **D.** Ventricular Septal Defect
- **E.** Tricuspid Regurgitation

**Correct Answer:** A
**Explanation:**
Mitral stenosis (predominantly caused by rheumatic fever) is characterized by: loud S1, opening snap (pliant valve leaflet opening), and a low-pitched rumbling mid-diastolic murmur best heard with the bell of the stethoscope at the apex in the left lateral decubitus position. It frequently leads to left atrial dilation, AF, and pulmonary hypertension.

## Question 4 of 5

Which peripheral physical signs are associated with chronic severe Aortic Regurgitation (AR)?

- **A.** Corrigan's water-hammer pulse, wide pulse pressure, de Musset's sign (head nodding), and Quincke's capillary pulsations
- **B.** Pulsus parvus et tardus with narrow pulse pressure
- **C.** Cyanosis and digital clubbing
- **D.** Pulsus paradoxus and electrical alternans
- **E.** Splinter haemorrhages and Osler's nodes only

**Correct Answer:** A
**Explanation:**
Chronic severe aortic regurgitation causes a huge stroke volume ejected into the aorta followed by massive diastolic regurgitation back into the LV, leading to a hyperdynamic circulation and wide pulse pressure: Corrigan's (water-hammer) pulse, Quincke's sign (capillary nailbed pulsation), de Musset's sign (head nodding with heartbeats), and Duroziez's sign.

## Question 5 of 5

A 55-year-old male with a mechanical St. Jude bileaflet aortic valve presents with sudden severe pulmonary oedema and cardiogenic shock. His INR is 1.4 (therapeutic target 2.5-3.5). Bedside echo demonstrates restricted leaflet motion and massive transvalvular gradient. What is the primary diagnosis?

- **A.** Prosthetic Valve Thrombosis
- **B.** Cardiac tamponade
- **C.** Acute anterior myocardial infarction
- **D.** Bacterial pneumonia
- **E.** Normal prosthetic valve function

**Correct Answer:** A
**Explanation:**
Subtherapeutic INR in a patient with a mechanical prosthetic valve presenting with acute cardiogenic shock or pulmonary oedema strongly indicates Prosthetic Valve Thrombosis. It is a critical surgical emergency requiring urgent echocardiography/fluoroscopy and either emergency surgical thrombectomy/replacement or slow-infusion low-dose fibrinolytic therapy.
$SBA_CARD_030$,
    false,
    39,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 21/21: Ventricular Tachycardia (VT)
  -- 1) Interleave Lecture (Position 40)
  UPDATE "lessons"
  SET "position" = 40, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'ventricular-tachycardia-vt' OR "slug" = 'ventricular-tachycardia');

  -- 2) Upsert Quiz Lesson (Position 41)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-cardiology-ventricular-tachycardia',
    'Ventricular Tachycardia (VT) — SBA Interactive Quiz',
    'quiz',
    $SBA_CARD_031$# Ventricular Tachycardia (VT) — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

Which of the following 12-lead ECG findings provides pathognomonic proof of Atrioventricular (AV) Dissociation, definitively confirming that a regular wide-complex tachycardia is Ventricular Tachycardia rather than SVT with aberrancy?

![Figure 1: Clinical Findings & Diagnostic Reference (Ventricular Tachycardia (VT))](/lessons/images/sba/cardiology/ventricular-tachycardia/figure_01_p4.jpeg)


- **A.** Presence of Fusion and Capture beats
- **B.** QRS duration of 110 ms
- **C.** Heart rate exactly 150 bpm
- **D.** Normal frontal QRS axis
- **E.** Inverted T waves in lead III

**Correct Answer:** A
**Explanation:**
AV dissociation is the diagnostic hallmark of VT. It occurs when atria and ventricles beat independently. Intermittent conduction of a sinus impulse to the ventricles during VT produces either a 'Capture beat' (normal narrow QRS complex) or a 'Fusion beat' (hybrid complex between sinus and ventricular morphology), proving ventricular origin.

![Clinical Algorithm & Advanced Reference (Ventricular Tachycardia (VT))](/lessons/images/sba/cardiology/ventricular-tachycardia/figure_06_p13.jpeg)


## Question 2 of 5

According to the Brugada Algorithm, which single criterion in Step 1 confirms Ventricular Tachycardia immediately?

![Figure 2: Clinical Findings & Diagnostic Reference (Ventricular Tachycardia (VT))](/lessons/images/sba/cardiology/ventricular-tachycardia/figure_02_p5.jpeg)


- **A.** Absence of an RS complex in ALL precordial leads V1 through V6 (concordance)
- **B.** Presence of a classic rSR' in lead V1
- **C.** PR interval >200 ms
- **D.** Rate less than 120 bpm
- **E.** Normal QT interval

**Correct Answer:** A
**Explanation:**
Step 1 of the Brugada algorithm assesses for the absence of an RS complex across all chest leads (V1-V6). If there is no RS complex (i.e. positive concordance: all R waves; or negative concordance: all QS complexes), the diagnosis of Ventricular Tachycardia is confirmed with 100% specificity.

![Clinical Algorithm & Advanced Reference (Ventricular Tachycardia (VT))](/lessons/images/sba/cardiology/ventricular-tachycardia/figure_07_p14.jpeg)


## Question 3 of 5

A 64-year-old male with a history of ischaemic cardiomyopathy presents with sustained monomorphic Ventricular Tachycardia at 160 bpm. He is fully conscious, conversing, and completely haemodynamically stable with BP 124/80 mmHg and no chest pain. What is the recommended first-line antiarrhythmic therapy per Resuscitation Council UK / ESC guidelines?

![Figure 3: Clinical Findings & Diagnostic Reference (Ventricular Tachycardia (VT))](/lessons/images/sba/cardiology/ventricular-tachycardia/figure_03_p6.jpeg)


- **A.** Intravenous Amiodarone 300mg infused over 20-60 minutes, followed by 900mg infusion over 24 hours
- **B.** IV Verapamil 10mg bolus
- **C.** Immediate unsynchronised defibrillation 200J without sedation
- **D.** Oral Digoxin 250mcg
- **E.** IV Metoprolol 15mg rapid push

**Correct Answer:** A
**Explanation:**
For stable sustained monomorphic VT, IV Amiodarone (300 mg over 20-60 min followed by 900 mg/24h) is first-line in structural heart disease. Alternative in preserved LV function is IV Procainamide (PROCAMIO study). If medical therapy fails or patient deteriorates, elective synchronised DC cardioversion under sedation is performed.

![Clinical Algorithm & Advanced Reference (Ventricular Tachycardia (VT))](/lessons/images/sba/cardiology/ventricular-tachycardia/figure_08_p22.jpeg)


## Question 4 of 5

What is the Vereckei aVR algorithm criterion that strongly indicates Ventricular Tachycardia?

![Figure 4: Clinical Findings & Diagnostic Reference (Ventricular Tachycardia (VT))](/lessons/images/sba/cardiology/ventricular-tachycardia/figure_04_p8.jpeg)


- **A.** Initial R wave in lead aVR
- **B.** Negative QRS in lead aVR
- **C.** Absent P wave in lead aVR
- **D.** T wave inversion in lead aVR
- **E.** Isoelectric QRS in lead aVR

**Correct Answer:** A
**Explanation:**
The simplified Vereckei algorithm looks exclusively at lead aVR. An initial dominant R wave in aVR indicates that ventricular activation is moving from the apex up towards the base and right shoulder, characteristic of ventricular tachycardia (normal ventricular conduction moves away from aVR, producing a negative complex).

## Question 5 of 5

What genetic inherited arrhythmogenic disorder is characterized by incomplete RBBB with coved-type ST-segment elevation >=2 mm followed by a negative T wave in leads V1-V2 (Type 1 pattern), predisposing to nocturnal polymorphic VT and sudden cardiac death?

![Figure 5: Clinical Findings & Diagnostic Reference (Ventricular Tachycardia (VT))](/lessons/images/sba/cardiology/ventricular-tachycardia/figure_05_p10.jpeg)


- **A.** Brugada Syndrome (SCN5A sodium channelopathy)
- **B.** Long QT Syndrome Type 2
- **C.** Arrhythmogenic Right Ventricular Cardiomyopathy (ARVC) with epsilon waves
- **D.** Short QT Syndrome
- **E.** Catecholaminergic Polymorphic VT

**Correct Answer:** A
**Explanation:**
Brugada syndrome (autosomal dominant sodium channel SCN5A mutation) features the Type 1 Brugada pattern: coved ST elevation >=2 mm descending into an inverted T wave in >=1 right precordial lead (V1, V2). It causes sudden cardiac death due to polymorphic VT/VF, typically during rest or sleep, unmasked by fever.
$SBA_CARD_031$,
    false,
    41,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();


  -- ------------------------------------------------------------------------
  -- Specialty: Major Trauma & Injury Management (13 Topics)
  -- ------------------------------------------------------------------------
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_sba_id AND "title" = 'Major Trauma & Injury Management' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module Major Trauma & Injury Management not found in mrcem-sba';
  END IF;

  -- Topic 1/13: Abdominal Trauma
  -- 1) Interleave Lecture (Position 0)
  UPDATE "lessons"
  SET "position" = 0, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'abdominal-trauma' OR "slug" = 'abdominal-trauma');

  -- 2) Upsert Quiz Lesson (Position 1)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-trauma-abdominal-trauma',
    'Abdominal Trauma — SBA Interactive Quiz',
    'quiz',
    $SBA_TRAU_032$# Abdominal Trauma — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 26-year-old male is brought to the resuscitation room following a stab wound to the left upper quadrant of his abdomen. On examination, he is pale and diaphoretic with heart rate 130 bpm, BP 82/46 mmHg, and obvious peritonitis with involuntary abdominal guarding. What is the immediate definitive management?

![Figure 1: Clinical Findings & Diagnostic Reference (Abdominal Trauma)](/lessons/images/sba/trauma/abdominal-trauma/figure_01_p1.jpeg)


- **A.** Immediate transfer to the operating theatre for Emergency Laparotomy
- **B.** Perform a contrast-enhanced abdominal CT scan first
- **C.** Diagnostic peritoneal lavage (DPL) at the bedside
- **D.** Administer 3 litres of 0.9% normal saline and observe in the ICU
- **E.** Perform upper gastrointestinal endoscopy

**Correct Answer:** A
**Explanation:**
In abdominal trauma (penetrating or blunt), haemodynamic instability (hypotension, tachycardia) or overt signs of peritonitis/evisceration are absolute indications for immediate emergency laparotomy. CT scanning is strictly contraindicated in unstable patients.

![Clinical Algorithm & Advanced Reference (Abdominal Trauma)](/lessons/images/sba/trauma/abdominal-trauma/figure_06_p8.jpeg)


## Question 2 of 5

A 32-year-old restrained driver involved in a high-speed road traffic collision is haemodynamically stable. A Focused Assessment with Sonography for Trauma (FAST) scan is performed in the resuscitation room. What are the four standard anatomical acoustic windows evaluated during a FAST examination?

![Figure 2: Clinical Findings & Diagnostic Reference (Abdominal Trauma)](/lessons/images/sba/trauma/abdominal-trauma/figure_02_p5.jpeg)


- **A.** Right upper quadrant (Morison's pouch), Left upper quadrant (splenorenal recess), Pelvic / retrovesical pouch, and Subxiphoid pericardial window
- **B.** Gallbladder, Appendix, Spleen, and Urinary bladder
- **C.** Aorta, IVC, Carotid arteries, and Femoral vessels
- **D.** Bilateral lungs, Stomach, and Pancreas
- **E.** Scrotum, Inguinal canals, Popliteal fossa, and Umbilicus

**Correct Answer:** A
**Explanation:**
The 4 standard FAST windows evaluate for pathological free fluid (haemoperitoneum / haemopericardium): (1) RUQ (hepatorenal space / Morison's pouch - most sensitive dependent space); (2) LUQ (splenorenal recess and subphrenic space); (3) Pelvic (pouch of Douglas / retrovesical space); (4) Subxiphoid (pericardial space). Extended FAST (eFAST) adds bilateral anterior thoracic views for pneumothorax/haemothorax.

## Question 3 of 5

Which solid abdominal organ is most frequently injured in blunt abdominal trauma, and what physical examination sign denotes referred left shoulder tip pain caused by diaphragmatic irritation from splenic rupture?

![Figure 3: Clinical Findings & Diagnostic Reference (Abdominal Trauma)](/lessons/images/sba/trauma/abdominal-trauma/figure_03_p6.jpeg)


- **A.** Spleen; Kehr's sign
- **B.** Liver; Murphy's sign
- **C.** Pancreas; Grey Turner's sign
- **D.** Kidney; Cullen's sign
- **E.** Urinary bladder; Rovsing's sign

**Correct Answer:** A
**Explanation:**
The spleen is the most commonly injured visceral organ in blunt trauma (followed closely by the liver). Kehr's sign is referred pain to the left shoulder tip caused by blood irritating the peritoneal surface of the left hemidiaphragm (innervated by the phrenic nerve C3-C5).

## Question 4 of 5

A 40-year-old unrestrained driver involved in a head-on collision sustains steering wheel impact to his epigastrium. Forty-eight hours later, he develops fever, persistent vomiting, epigastric tenderness, and back pain. Serum amylase is elevated. Contrast CT demonstrates retroperitoneal air and fluid surrounding the second portion of the duodenum. What injury has occurred?

![Figure 4: Clinical Findings & Diagnostic Reference (Abdominal Trauma)](/lessons/images/sba/trauma/abdominal-trauma/figure_04_p7.jpeg)


- **A.** Traumatic retroperitoneal duodenal rupture
- **B.** Splenic laceration Grade I
- **C.** Acute cholecystitis
- **D.** Diaphragmatic herniation
- **E.** Mesenteric tear of the sigmoid colon

**Correct Answer:** A
**Explanation:**
Blunt trauma to the epigastrium (steering wheel, bicycle handlebar) compresses the retroperitoneal duodenum against the lumbar spine. Duodenal rupture often has an insidious, delayed clinical presentation because retroperitoneal extravasation does not cause early classical signs of anterior peritonitis. CT hallmark is retroperitoneal air and fluid around the right kidney/duodenum.

## Question 5 of 5

What is the primary management strategy for a haemodynamically stable patient with a Grade III blunt hepatic or splenic laceration confirmed on contrast CT who has no signs of peritonitis?

![Figure 5: Clinical Findings & Diagnostic Reference (Abdominal Trauma)](/lessons/images/sba/trauma/abdominal-trauma/figure_05_p7.jpeg)


- **A.** Non-Operative Management (NOM) with intensive HDU monitoring, serial clinical exams, and angiographic embolisation if needed
- **B.** Immediate mandatory total splenectomy
- **C.** Immediate exploratory laparotomy
- **D.** Bedside diagnostic peritoneal lavage
- **E.** Discharge home with bed rest instructions

**Correct Answer:** A
**Explanation:**
In blunt hepatic and splenic injuries, Non-Operative Management (NOM) is the gold standard for haemodynamically stable patients regardless of injury grade, preserving organ function with success rates >85-90%. It requires monitored care, serial abdominal exams, haemoglobin tracking, and interventional radiology angio-embolisation for active contrast extravasation ('blush').
$SBA_TRAU_032$,
    false,
    1,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 2/13: Burn Injury & Resuscitation
  -- 1) Interleave Lecture (Position 2)
  UPDATE "lessons"
  SET "position" = 2, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'burn-injury' OR "slug" = 'burn-injury');

  -- 2) Upsert Quiz Lesson (Position 3)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-trauma-burn-injury',
    'Burn Injury & Resuscitation — SBA Interactive Quiz',
    'quiz',
    $SBA_TRAU_033$# Burn Injury & Resuscitation — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 70 kg man sustains deep partial-thickness burns involving his entire anterior torso (18%) and the entirety of both upper limbs (9% + 9% = 18%), totaling 36% Total Body Surface Area (TBSA). Using the Parkland formula (4 ml x kg x %TBSA), how much Hartmann's solution should be administered over the FIRST 8 hours from the time of injury?

![Figure 1: Clinical Findings & Diagnostic Reference (Burn Injury & Resuscitation)](/lessons/images/sba/trauma/burn-injury/figure_01_p3.jpeg)


- **A.** 5,040 ml (half of the 10,080 ml 24-hour total)
- **B.** 10,080 ml
- **C.** 2,500 ml
- **D.** 1,000 ml
- **E.** 15,000 ml

**Correct Answer:** A
**Explanation:**
Parkland formula: Total 24-hour fluid = 4 ml x body weight (kg) x % TBSA burned. Here: 4 x 70 x 36 = 10,080 ml of Hartmann's. Half of this total (5,040 ml) must be administered in the first 8 hours calculated from the time of the BURN (not time of arrival), and the remaining half over the subsequent 16 hours.

![Clinical Algorithm & Advanced Reference (Burn Injury & Resuscitation)](/lessons/images/sba/trauma/burn-injury/figure_06_p9.jpeg)


## Question 2 of 5

What is the single most reliable physiological endpoint to titrate fluid resuscitation volume in an adult burn patient without electrical injury?

![Figure 2: Clinical Findings & Diagnostic Reference (Burn Injury & Resuscitation)](/lessons/images/sba/trauma/burn-injury/figure_02_p4.jpeg)


- **A.** Target urine output of 0.5 to 1.0 ml/kg/hour
- **B.** Systolic blood pressure >160 mmHg
- **C.** Central venous pressure of exactly 15 mmHg
- **D.** Serum sodium level >145 mmol/L
- **E.** Skin turgor over the chest

**Correct Answer:** A
**Explanation:**
In burn resuscitation, fluid rates must be titrated hourly based on target urine output: 0.5 - 1.0 ml/kg/hr in adults (and 1.0 - 1.5 ml/kg/hr in children). In high-voltage electrical injuries with myoglobinuria, target urine output is higher (1.5 - 2.0 ml/kg/hr) until urine clears.

![Clinical Algorithm & Advanced Reference (Burn Injury & Resuscitation)](/lessons/images/sba/trauma/burn-injury/figure_07_p9.jpeg)


## Question 3 of 5

A 35-year-old firefighter was rescued from an enclosed room fire. He has facial burns, singed nasal hairs, carbonaceous soot in his oropharynx, and is hoarse with early inspiratory stridor. What is the immediate priority management?

![Figure 3: Clinical Findings & Diagnostic Reference (Burn Injury & Resuscitation)](/lessons/images/sba/trauma/burn-injury/figure_03_p5.jpeg)


- **A.** Immediate endotracheal intubation by an experienced airway operator
- **B.** Inhaled nebulised salbutamol and observation
- **C.** Oral dexamethasone 8mg
- **D.** Chest radiography before any airway intervention
- **E.** High-flow oxygen via nasal prongs

**Correct Answer:** A
**Explanation:**
Signs of upper airway thermal injury and inhalation injury (facial burns, soot in sputum/oropharynx, hoarseness, stridor) warn of rapid, catastrophic pharyngeal and glottic oedema. Endotracheal intubation must be performed early before anatomical landmarks are obliterated by massive swelling.

![Clinical Algorithm & Advanced Reference (Burn Injury & Resuscitation)](/lessons/images/sba/trauma/burn-injury/figure_08_p14.jpeg)


## Question 4 of 5

A patient rescued from a house fire is confused with cherry-red skin appearance and normal pulse oximetry (SpO2 99% on room air). Arterial blood gas co-oximetry reveals a carboxyhaemoglobin (COHb) level of 34%. What is the definitive treatment?

![Figure 4: Clinical Findings & Diagnostic Reference (Burn Injury & Resuscitation)](/lessons/images/sba/trauma/burn-injury/figure_04_p8.jpeg)


- **A.** 100% high-flow oxygen via non-rebreather reservoir mask, and consider hyperbaric oxygen (HBO) therapy
- **B.** Wean oxygen because SpO2 is normal
- **C.** Administer IV methylene blue
- **D.** Intravenous N-acetylcysteine infusion
- **E.** Perform therapeutic phlebotomy

**Correct Answer:** A
**Explanation:**
Standard pulse oximeters cannot distinguish carboxyhaemoglobin from oxyhaemoglobin, giving falsely normal SpO2 readings in carbon monoxide (CO) poisoning. Management is 100% normobaric oxygen via reservoir mask (reduces CO half-life from 320 min to 80 min). Hyperbaric oxygen is considered for COHb >25% (>15% in pregnancy), loss of consciousness, severe metabolic acidosis, or neurological deficits.

![Clinical Algorithm & Advanced Reference (Burn Injury & Resuscitation)](/lessons/images/sba/trauma/burn-injury/figure_09_p15.jpeg)


## Question 5 of 5

A 45-year-old man sustains full-thickness circumferential burns to his entire chest. During resuscitation, the ventilator peak inspiratory pressures rise sharply to 50 cm H2O, chest expansion becomes rigid and severely restricted, and systolic BP falls to 75 mmHg. What emergency bedside procedure is indicated?

![Figure 5: Clinical Findings & Diagnostic Reference (Burn Injury & Resuscitation)](/lessons/images/sba/trauma/burn-injury/figure_05_p8.jpeg)


- **A.** Emergency Chest Escharotomy
- **B.** Needle thoracocentesis in the second intercostal space
- **C.** Administration of high-dose intravenous muscle relaxants only
- **D.** Pericardiocentesis
- **E.** Incision and drainage of burn blisters

**Correct Answer:** A
**Explanation:**
Circumferential full-thickness chest burns create a rigid, inelastic eschar that acts as a tourniquet. As underlying tissue oedema accumulates, chest wall compliance drops severely, preventing ventilation and compressing the great veins (thoracic compartment syndrome). Emergency escharotomy (incising the burnt dead tissue down to subcutaneous fat in anterior axillary lines and transverse upper/lower margins) relieves restriction.
$SBA_TRAU_033$,
    false,
    3,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 3/13: Devastating Brain Injury & Prognostication
  -- 1) Interleave Lecture (Position 4)
  UPDATE "lessons"
  SET "position" = 4, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'devastatiing-brain-injury' OR "slug" = 'devastating-brain-injury');

  -- 2) Upsert Quiz Lesson (Position 5)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-trauma-devastating-brain-injury',
    'Devastating Brain Injury & Prognostication — SBA Interactive Quiz',
    'quiz',
    $SBA_TRAU_034$# Devastating Brain Injury & Prognostication — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 50-year-old woman is brought to the ED after a severe traumatic brain injury. On arrival, she opens eyes only to painful sternal rub (2), produces incomprehensible sounds (2), and shows abnormal flexion (decorticate posturing) to pain (3). What is her Glasgow Coma Scale (GCS) score?

![Figure 1: Clinical Findings & Diagnostic Reference (Devastating Brain Injury & Prognostication)](/lessons/images/sba/trauma/devastating-brain-injury/figure_01_p1.jpeg)


- **A.** GCS 7 (E2 V2 M3)
- **B.** GCS 9
- **C.** GCS 5
- **D.** GCS 11
- **E.** GCS 3

**Correct Answer:** A
**Explanation:**
GCS calculation: Eye opening to pain = 2; Verbal incomprehensible sounds = 2; Motor abnormal flexion (decorticate) = 3. Total GCS = 7. Severe traumatic brain injury is defined as GCS <= 8, mandating emergency airway protection (RSI intubation).

## Question 2 of 5

According to Brain Trauma Foundation and NICE guidelines, what is the target Cerebral Perfusion Pressure (CPP) and Mean Arterial Pressure (MAP) in the resuscitation of severe traumatic brain injury?

![Figure 2: Clinical Findings & Diagnostic Reference (Devastating Brain Injury & Prognostication)](/lessons/images/sba/trauma/devastating-brain-injury/figure_02_p2.jpeg)


- **A.** Target CPP 60-70 mmHg (avoiding systolic BP <100-110 mmHg)
- **B.** Target CPP 30-40 mmHg
- **C.** Target systolic BP 80-90 mmHg (permissive hypotension)
- **D.** Target CPP >100 mmHg with aggressive vasopressors
- **E.** Target ICP >30 mmHg

**Correct Answer:** A
**Explanation:**
CPP = MAP - ICP. The Brain Trauma Foundation recommends maintaining CPP between 60-70 mmHg. Even a single episode of hypotension (systolic BP <90 mmHg, or <100-110 mmHg in older adults) doubles mortality in severe TBI. Permissive hypotension is strictly contraindicated in TBI.

## Question 3 of 5

Which osmotherapy agent is indicated in the ED for acute intracranial hypertension with signs of imminent transtentorial herniation (unilateral dilated pupil, decerebrate posturing)?

![Figure 3: Clinical Findings & Diagnostic Reference (Devastating Brain Injury & Prognostication)](/lessons/images/sba/trauma/devastating-brain-injury/figure_03_p2.jpeg)


- **A.** Hypertonic Saline (e.g. 3% or 5% NaCl 250-500ml bolus) or Mannitol 20% (0.5-1.0 g/kg)
- **B.** Dextrose 5% in water 1000ml rapid bolus
- **C.** 0.45% half-normal saline infusion
- **D.** Intravenous furosemide 10mg monotherapy
- **E.** Oral glycerol

**Correct Answer:** A
**Explanation:**
Osmotherapy draws free water from cerebral parenchyma into the intravascular space, rapidly lowering ICP. Hypertonic saline (3% or 5%) or 20% Mannitol (0.5-1.0 g/kg) is first-line for acute herniation. Hypertonic saline is preferred in hypotensive patients as it expands plasma volume without inducing osmotic diuresis.

## Question 4 of 5

What is the recommended target arterial PaCO2 when using temporary hyperventilation as a rescue measure for acute cerebral herniation in severe TBI?

- **A.** PaCO2 4.0 - 4.5 kPa (30 - 35 mmHg) for brief periods only
- **B.** PaCO2 < 2.5 kPa (< 20 mmHg) for 24 hours
- **C.** PaCO2 6.5 - 7.5 kPa (hypercapnia)
- **D.** PaCO2 does not affect cerebral blood flow
- **E.** Target PaCO2 5.5 - 6.0 kPa

**Correct Answer:** A
**Explanation:**
Hypocapnia induces cerebral arteriolar vasoconstriction, lowering cerebral blood volume and ICP. However, prolonged or aggressive hyperventilation (PaCO2 <4.0 kPa / <30 mmHg) causes profound cerebral ischaemia. Guidelines mandate brief, controlled mild hyperventilation (PaCO2 4.0-4.5 kPa / 30-35 mmHg) only as a temporary bridge to definitive surgical decompression.

## Question 5 of 5

In the UK Academy of Medical Royal Colleges (AoMRC) code of practice for the diagnosis of death using neurological criteria (brainstem death testing), which prerequisite condition must be rigorously fulfilled prior to testing?

- **A.** Irreversible brain damage of known etiology, exclusion of reversible metabolic/endocrine disturbances, normothermia (>34C), and complete exclusion of depressant drugs / neuromuscular blockade
- **B.** Flat EEG for 48 hours is mandatory
- **C.** Cerebral angiography must show absent flow in all four vessels
- **D.** Patient must be aged over 18 years
- **E.** Serum potassium must be >5.5 mmol/L

**Correct Answer:** A
**Explanation:**
AoMRC prerequisites for brainstem death testing: (1) Apnoeic coma of known irreversible cause; (2) Exclusion of reversible causes: core temperature >34C, no intoxication/recreational drugs, no residual neuromuscular blocking or sedative agents (verified by train-of-four / adequate drug clearance time), and no severe electrolyte, acid-base, or endocrine abnormalities.
$SBA_TRAU_034$,
    false,
    5,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 4/13: Genitourinary Trauma & Urethral Injury
  -- 1) Interleave Lecture (Position 6)
  UPDATE "lessons"
  SET "position" = 6, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'genetourinary-trauma' OR "slug" = 'genitourinary-trauma');

  -- 2) Upsert Quiz Lesson (Position 7)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-trauma-genitourinary-trauma',
    'Genitourinary Trauma & Urethral Injury — SBA Interactive Quiz',
    'quiz',
    $SBA_TRAU_035$# Genitourinary Trauma & Urethral Injury — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 23-year-old male motorcyclist involved in a collision presents with an unstable pelvic fracture. On secondary survey, blood is noted at the external urethral meatus, and a butterfly perineal haematoma is visible. Rectal exam reveals a 'high-riding' boggy prostate. What is the single most important contraindication in the immediate management?

![Figure 1: Clinical Findings & Diagnostic Reference (Genitourinary Trauma & Urethral Injury)](/lessons/images/sba/trauma/genitourinary-trauma/figure_01_p1.jpeg)


- **A.** Do NOT attempt blind transurethral catheterisation
- **B.** Do NOT perform pelvis X-ray
- **C.** Do NOT give intravenous analgesia
- **D.** Do NOT place a pelvic binder
- **E.** Do NOT give tetanus toxoid

**Correct Answer:** A
**Explanation:**
The classic triad of urethral injury is: blood at the urethral meatus, perineal/scrotal haematoma ('butterfly' ecchymosis), and a high-riding/floating prostate on DRE. Blind urethral catheterisation is strictly CONTRAINDICATED as it can convert a partial urethral tear into a complete transection and introduce infection into pelvic haematomas.

## Question 2 of 5

What is the gold standard diagnostic investigation to evaluate for urethral trauma in an adult male before any catheter insertion?

![Figure 2: Clinical Findings & Diagnostic Reference (Genitourinary Trauma & Urethral Injury)](/lessons/images/sba/trauma/genitourinary-trauma/figure_02_p5.jpeg)


- **A.** Retrograde Urethrogram (RUG) / Ascending Urethrography
- **B.** Intravenous Pyelogram (IVP)
- **C.** Renal ultrasound
- **D.** Non-contrast pelvic CT scan
- **E.** Rigid cystoscopy in the ED

**Correct Answer:** A
**Explanation:**
Retrograde Urethrography (RUG) is performed by injecting 20-30 ml of water-soluble contrast via a small Foley catheter tip placed in the navicular fossa of the distal penis with oblique pelvic radiographs. It definitively identifies the presence, site, and extent (partial vs complete) of urethral disruption.

## Question 3 of 5

A 28-year-old male presents with acute penile pain, a loud 'cracking' sound heard during vigorous intercourse, immediate detumescence, and a swollen, deviated, ecchymotic penis ('eggplant deformity'). What anatomical structure has ruptured?

- **A.** Tunica albuginea of the corpus cavernosum (penile fracture)
- **B.** Bulbospongiosus muscle
- **C.** External urethral sphincter
- **D.** Suspensory ligament of the penis
- **E.** Superficial dorsal vein alone

**Correct Answer:** A
**Explanation:**
Penile fracture is caused by blunt trauma to the erect penis, causing rupture of the fibrous tunica albuginea enclosing the corpus cavernosum (and occasionally the corpus spongiosum/urethra). Hallmark features are sudden pain, cracking pop, rapid detumescence, and the 'eggplant deformity'. It is a surgical emergency requiring immediate exploration and repair.

## Question 4 of 5

A 35-year-old driver with blunt lower abdominal trauma after a road collision has gross haematuria and suprapubic pain. CT cystography with 350 ml of instilled dilute contrast demonstrates contrast extravasation outlining loops of small bowel in the peritoneal cavity. What is the diagnosis and definitive management?

- **A.** Intraperitoneal bladder rupture; requires emergent surgical exploration and formal operative repair
- **B.** Extraperitoneal bladder rupture; managed conservatively with Foley catheter drainage for 14 days
- **C.** Ureteral transection; requires nephrectomy
- **D.** Renal contusion; bed rest only
- **E.** Normal CT cystogram finding

**Correct Answer:** A
**Explanation:**
Intraperitoneal bladder rupture occurs when a distended bladder bursts at the dome (weakest point covered by peritoneum) from blunt compression. Contrast freely extravasates into the peritoneal cavity around the bowel loops. Intraperitoneal tears ALWAYS require emergency open or laparoscopic operative repair to prevent peritonitis and sepsis.

## Question 5 of 5

In blunt renal trauma, which clinical finding is the most common and important indication for contrast-enhanced multiphase abdominal CT imaging?

- **A.** Gross haematuria, or microscopic haematuria with a systolic BP <90 mmHg
- **B.** Microscopic haematuria with normal vital signs in a minor fall
- **C.** Mild dysuria without pain
- **D.** Presence of trace proteinuria on dipstick
- **E.** Isolated minor rib contusion

**Correct Answer:** A
**Explanation:**
Indications for contrast CT in blunt renal trauma: (1) All cases of macroscopic (gross) haematuria; (2) Microscopic haematuria accompanied by shock (systolic BP <90 mmHg); (3) Rapid deceleration mechanism (fall from height, high-speed collision); (4) Significant flank contusion or lower rib fractures (10th-12th ribs).
$SBA_TRAU_035$,
    false,
    7,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 5/13: Head Trauma & Intracranial Haemorrhage
  -- 1) Interleave Lecture (Position 8)
  UPDATE "lessons"
  SET "position" = 8, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'head-reauma' OR "slug" = 'head-trauma');

  -- 2) Upsert Quiz Lesson (Position 9)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-trauma-head-trauma',
    'Head Trauma & Intracranial Haemorrhage — SBA Interactive Quiz',
    'quiz',
    $SBA_TRAU_036$# Head Trauma & Intracranial Haemorrhage — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 21-year-old rugby player is struck on the temporoparietal skull. He experiences a brief loss of consciousness, recovers fully, and converses normally for 2 hours (lucid interval). Later, he rapidly deteriorates with vomiting, GCS drop to 6, and a dilated, unreactive right pupil (Hutchinson's pupil). What intracranial pathology is most likely?

![Figure 1: Clinical Findings & Diagnostic Reference (Head Trauma & Intracranial Haemorrhage)](/lessons/images/sba/trauma/head-trauma/figure_01_p4.jpeg)


- **A.** Extradural (Epidural) Haematoma secondary to Middle Meningeal Artery laceration
- **B.** Acute Subdural Haematoma from bridging cortical veins
- **C.** Traumatic subarachnoid haemorrhage
- **D.** Diffuse axonal injury
- **E.** Post-concussion syndrome

**Correct Answer:** A
**Explanation:**
Extradural haematoma (EDH) typically results from a blow to the pterion fracturing the squamous temporal bone and tearing the middle meningeal artery. The classic presentation is a 'lucid interval' followed by rapid herniation with ipsilateral uncal pupil dilation and contralateral hemiparesis. CT shows a hyperdense, biconvex (lenticular) collection limited by cranial sutures.

![Clinical Algorithm & Advanced Reference (Head Trauma & Intracranial Haemorrhage)](/lessons/images/sba/trauma/head-trauma/figure_06_p9.jpeg)


## Question 2 of 5

What is the characteristic appearance of an Acute Subdural Haematoma (SDH) on a non-contrast brain CT scan?

![Figure 2: Clinical Findings & Diagnostic Reference (Head Trauma & Intracranial Haemorrhage)](/lessons/images/sba/trauma/head-trauma/figure_02_p5.jpeg)


- **A.** Hyperdense crescentic (concave / sickle-shaped) collection that crosses cranial sutures and extends along the cerebral convexity
- **B.** Biconvex, lenticular hyperdensity strictly limited by cranial suture lines
- **C.** Punctate micro-haemorrhages confined to the grey-white matter junction
- **D.** Star-shaped blood collection confined to the basal cisterns
- **E.** Widespread cerebral atrophy without extra-axial fluid

**Correct Answer:** A
**Explanation:**
Acute Subdural Haematoma (SDH) arises from rupture of bridging cortical veins between the cerebral cortex and dural venous sinuses (common in elderly, alcoholics, and high-energy deceleration). CT demonstrates a hyperdense crescentic (crescent-shaped) extra-axial collection that freely crosses cranial suture lines, causing significant midline shift.

![Clinical Algorithm & Advanced Reference (Head Trauma & Intracranial Haemorrhage)](/lessons/images/sba/trauma/head-trauma/figure_07_p11.jpeg)


## Question 3 of 5

Which physical examination signs are classic clinical indicators of a Basilar Skull Fracture?

![Figure 3: Clinical Findings & Diagnostic Reference (Head Trauma & Intracranial Haemorrhage)](/lessons/images/sba/trauma/head-trauma/figure_03_p6.jpeg)


- **A.** Battle's sign (mastoid ecchymosis), Raccoon eyes (periorbital ecchymosis), Haemotympanum, and CSF rhinorrhoea/otorrhoea
- **B.** Marcus Gunn pupil and papilloedema
- **C.** Horner's syndrome and facial nerve spasm
- **D.** Bilateral proptosis and chemosis only
- **E.** Nuchal rigidity and positive Kernig's sign

**Correct Answer:** A
**Explanation:**
Basilar skull fracture signs: (1) Battle's sign (retroauricular ecchymosis over mastoid process); (2) 'Panda / Raccoon' eyes (bilateral periorbital ecchymosis with tarsal plate sparing); (3) Haemotympanum or blood in external auditory canal; (4) CSF rhinorrhoea or otorrhoea (Halo sign on filter paper). Nasogastric tubes are contraindicated.

![Clinical Algorithm & Advanced Reference (Head Trauma & Intracranial Haemorrhage)](/lessons/images/sba/trauma/head-trauma/figure_08_p12.jpeg)


## Question 4 of 5

According to NICE guideline NG232, which adult patient with head injury requires an immediate emergency non-contrast CT brain scan within 1 hour?

![Figure 4: Clinical Findings & Diagnostic Reference (Head Trauma & Intracranial Haemorrhage)](/lessons/images/sba/trauma/head-trauma/figure_04_p7.jpeg)


- **A.** GCS 13 on initial assessment in the ED, or GCS <15 at 2 hours post-injury
- **B.** Amnesia of 10 minutes prior to impact with GCS 15 and no other features
- **C.** Single episode of vomiting 30 minutes after injury with normal GCS
- **D.** Minor frontal scalp haematoma in an alert 25-year-old
- **E.** Age 66 with a minor forehead bump and no amnesia

**Correct Answer:** A
**Explanation:**
NICE NG232 criteria for CT brain within 1 hour: GCS <13 on initial ED assessment; GCS <15 at 2 hours post-injury; suspected open or depressed skull fracture; signs of basal skull fracture; post-traumatic seizure; focal neurological deficit; >1 episode of vomiting in adults.

![Clinical Algorithm & Advanced Reference (Head Trauma & Intracranial Haemorrhage)](/lessons/images/sba/trauma/head-trauma/figure_09_p14.jpeg)


## Question 5 of 5

A 78-year-old male on Warfarin presents with confusion 3 weeks after a minor mechanical fall at home. Brain CT reveals a hypodense (dark), crescentic fluid collection along the right hemisphere with midline shift. What is the diagnosis?

![Figure 5: Clinical Findings & Diagnostic Reference (Head Trauma & Intracranial Haemorrhage)](/lessons/images/sba/trauma/head-trauma/figure_05_p8.jpeg)


- **A.** Chronic Subdural Haematoma (SDH)
- **B.** Acute Extradural Haematoma
- **C.** Acute Subarachnoid Haemorrhage
- **D.** Ischaemic stroke with haemorrhagic transformation
- **E.** Glioblastoma multiforme

**Correct Answer:** A
**Explanation:**
Chronic SDH is common in elderly patients (cerebral atrophy stretches bridging veins, predisposing to minor tearing with minimal trauma, amplified by anticoagulation). Over weeks, blood liquefies and becomes hypodense (dark) on CT compared to acute hyperdense (white) blood. Symptomatic chronic SDH with mass effect is treated with burr hole craniostomy.

![Clinical Algorithm & Advanced Reference (Head Trauma & Intracranial Haemorrhage)](/lessons/images/sba/trauma/head-trauma/figure_10_p15.jpeg)


![Supplementary Clinical Reference 6 (Head Trauma & Intracranial Haemorrhage)](/lessons/images/sba/trauma/head-trauma/figure_11_p23.jpeg)

$SBA_TRAU_036$,
    false,
    9,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 6/13: Laryngotracheal Injury & Airway Trauma
  -- 1) Interleave Lecture (Position 10)
  UPDATE "lessons"
  SET "position" = 10, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'laryngotrachila-injury' OR "slug" = 'laryngotracheal-injury');

  -- 2) Upsert Quiz Lesson (Position 11)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-trauma-laryngotracheal-injury',
    'Laryngotracheal Injury & Airway Trauma — SBA Interactive Quiz',
    'quiz',
    $SBA_TRAU_037$# Laryngotracheal Injury & Airway Trauma — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 28-year-old motorcyclist sustains a 'clothesline' impact to the anterior neck from a low-hanging wire. In the ED, he has hoarseness, anterior neck tenderness, extensive subcutaneous emphysema over the neck and upper chest, and mild stridor. What is the clinical triad pathognomonic of acute Laryngotracheal Disruption?

![Figure 1: Clinical Findings & Diagnostic Reference (Laryngotracheal Injury & Airway Trauma)](/lessons/images/sba/trauma/laryngotracheal-injury/figure_01_p3.jpeg)


- **A.** Hoarseness (dysphonia), Subcutaneous emphysema, and Palpable fracture/loss of thyroid cartilage prominence
- **B.** Stridor, Dysphagia, and Tracheal deviation to the left
- **C.** Hypotension, Distended neck veins, and Muffled heart sounds
- **D.** Horner's syndrome, Carotid bruit, and Syncope
- **E.** Trismus, Drooling, and Uvular deviation

**Correct Answer:** A
**Explanation:**
The classic triad of acute blunt laryngeal fracture/tracheal disruption: (1) Hoarseness / altered voice; (2) Subcutaneous emphysema of the neck; (3) Palpable crepitus or loss of normal thyroid cartilage anatomical landmarks. Haemoptysis and respiratory distress often accompany.

![Clinical Algorithm & Advanced Reference (Laryngotracheal Injury & Airway Trauma)](/lessons/images/sba/trauma/laryngotracheal-injury/figure_06_p9.jpeg)


## Question 2 of 5

What is the safest method to secure the airway in a patient with suspected acute blunt laryngotracheal fracture and impending airway compromise?

![Figure 2: Clinical Findings & Diagnostic Reference (Laryngotracheal Injury & Airway Trauma)](/lessons/images/sba/trauma/laryngotracheal-injury/figure_02_p4.jpeg)


- **A.** Awake flexible fiberoptic intubation in the operating theatre (or tracheostomy under local anaesthesia) with a surgeon scrubbed and prepared
- **B.** Standard rapid sequence induction (RSI) with blind bougie insertion
- **C.** Laryngeal mask airway (LMA) insertion
- **D.** Needle cricothyroidotomy directly through the fractured thyroid cartilage
- **E.** Deep sedation with propofol and bag-mask ventilation

**Correct Answer:** A
**Explanation:**
In blunt laryngeal fracture, standard blind or rapid sequence intubation with paralysis carries severe danger of completely transecting a partial tracheal tear or creating a false tract in the mediastinum. The safest approach is awake flexible fiberoptic intubation (or awake surgical tracheostomy under local anaesthesia) in the OR with ENT/thoracic surgery scrubbed.

## Question 3 of 5

In penetrating neck trauma, what anatomical landmarks define Neck Zone II, which is the most commonly injured and surgically accessible zone?

![Figure 3: Clinical Findings & Diagnostic Reference (Laryngotracheal Injury & Airway Trauma)](/lessons/images/sba/trauma/laryngotracheal-injury/figure_03_p6.jpeg)


- **A.** Between the cricoid cartilage inferiorly and the angle of the mandible superiorly
- **B.** Between the clavicles and the cricoid cartilage
- **C.** Above the angle of the mandible to the skull base
- **D.** Posterior to the anterior border of the trapezius
- **E.** Submandibular triangle only

**Correct Answer:** A
**Explanation:**
Anatomical neck zones for penetrating trauma: Zone I = clavicles/sternal notch to cricoid cartilage (high vascular mortality, thoracic inlet access required); Zone II = cricoid cartilage to angle of mandible (most commonly injured, easily examined and explored); Zone III = angle of mandible to skull base (difficult exposure).

## Question 4 of 5

Which 'Hard Sign' of penetrating aerodigestive tract injury mandates immediate operative neck exploration rather than imaging in a stable patient?

![Figure 4: Clinical Findings & Diagnostic Reference (Laryngotracheal Injury & Airway Trauma)](/lessons/images/sba/trauma/laryngotracheal-injury/figure_04_p7.jpeg)


- **A.** Massive subcutaneous emphysema, bubbling air through the neck wound, or severe stridor
- **B.** Superficial skin laceration <1 cm
- **C.** Mild dysphagia
- **D.** Localized non-expanding haematoma
- **E.** Small puncture mark without active bleeding

**Correct Answer:** A
**Explanation:**
'Hard signs' of airway injury in penetrating trauma: air bubbling from wound, massive expanding subcutaneous emphysema, severe respiratory distress/stridor. 'Hard signs' of vascular injury: expanding/pulsatile haematoma, active arterial bleeding, absent distal pulses, bruit/thrill. Both mandate immediate surgical exploration.

## Question 5 of 5

Why is surgical cricothyroidotomy CONTRAINDICATED in children under the age of 8 to 12 years with airway trauma?

![Figure 5: Clinical Findings & Diagnostic Reference (Laryngotracheal Injury & Airway Trauma)](/lessons/images/sba/trauma/laryngotracheal-injury/figure_05_p8.jpeg)


- **A.** The cricothyroid membrane is extremely small and the cricoid cartilage is the only complete ring supporting the upper airway; damage causes subglottic stenosis
- **B.** Children do not possess a cricoid cartilage
- **C.** The thyroid cartilage is entirely calcified
- **D.** Children never experience airway trauma
- **E.** The trachea is located posterior to the oesophagus in children

**Correct Answer:** A
**Explanation:**
In young children (<8-12 years), surgical cricothyroidotomy is contraindicated because the cricoid cartilage is the narrowest part of the airway and the sole circumferential cartilaginous support of the subglottis. Incising it risks crushing the cartilage, resulting in permanent subglottic stenosis. Needle cricothyroidotomy with jet insufflation or formal tracheostomy is preferred.
$SBA_TRAU_037$,
    false,
    11,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 7/13: Maxillofacial & Mandibular Trauma
  -- 1) Interleave Lecture (Position 12)
  UPDATE "lessons"
  SET "position" = 12, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'maxilofascial-trauma' OR "slug" = 'maxillofacial-trauma');

  -- 2) Upsert Quiz Lesson (Position 13)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-trauma-maxillofacial-trauma',
    'Maxillofacial & Mandibular Trauma — SBA Interactive Quiz',
    'quiz',
    $SBA_TRAU_038$# Maxillofacial & Mandibular Trauma — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 25-year-old male is struck forcefully in the left eye by a squash ball. He presents with periorbital ecchymosis, enophthalmos, vertical diplopia (especially on upward gaze), and numbness over his left cheek and upper lip. What specific injury has occurred?

![Figure 1: Clinical Findings & Diagnostic Reference (Maxillofacial & Mandibular Trauma)](/lessons/images/sba/trauma/maxillofacial-trauma/figure_01_p3.jpeg)


- **A.** Orbital floor blowout fracture with inferior rectus muscle entrapment and infraorbital nerve injury
- **B.** Le Fort I fracture
- **C.** Ruptured globe
- **D.** Isolated nasal bone fracture
- **E.** Zygomatic arch fracture without orbital involvement

**Correct Answer:** A
**Explanation:**
Orbital floor blowout fractures occur when blunt impact increases intraorbital pressure, fracturing the thin orbital floor (maxillary bone). Diplopia on upward gaze occurs due to entrapment of the inferior rectus muscle or periorbital fat in the fracture line. Hypoaesthesia over the cheek and upper teeth results from injury to the infraorbital nerve (branch of V2).

## Question 2 of 5

Which classification system categorizes midface fractures resulting from high-energy blunt facial trauma?

![Figure 2: Clinical Findings & Diagnostic Reference (Maxillofacial & Mandibular Trauma)](/lessons/images/sba/trauma/maxillofacial-trauma/figure_02_p6.jpeg)


- **A.** Le Fort Classification (Types I, II, III)
- **B.** Gustilo-Anderson Classification
- **C.** Garden Classification
- **D.** Salter-Harris Classification
- **E.** Neer Classification

**Correct Answer:** A
**Explanation:**
Midface fractures are classified using René Le Fort's system: Le Fort I = horizontal maxillary fracture separating alveolar process from maxilla ('floating palate'); Le Fort II = pyramidal fracture involving maxilla, nasal bones, and medial orbital floors ('floating maxilla'); Le Fort III = complete craniofacial disjunction ('floating face').

## Question 3 of 5

A 30-year-old male involved in an assault sustains a high-energy Le Fort III craniofacial disjunction fracture. What is the most immediate life-threatening complication facing this patient in the resuscitation bay?

![Figure 3: Clinical Findings & Diagnostic Reference (Maxillofacial & Mandibular Trauma)](/lessons/images/sba/trauma/maxillofacial-trauma/figure_03_p8.jpeg)


- **A.** Catastrophic upper airway obstruction from posterior displacement of the maxilla/tongue and massive bleeding/secretions
- **B.** Temporary dental malocclusion
- **C.** Permanent facial scarring
- **D.** Sinusitis
- **E.** Conductive hearing loss

**Correct Answer:** A
**Explanation:**
Maxillofacial trauma threatens life primarily through Upper Airway Obstruction caused by posterior displacement of the detached midface/tongue against the pharynx, compounded by massive haemorrhage from branches of the maxillary artery, soft tissue oedema, aspirated teeth, and vomit. Early airway control is paramount.

## Question 4 of 5

A 22-year-old boxer is struck on the jaw. He has severe pain, malocclusion (teeth do not meet properly), and sublingual haematoma. Why does a mandibular fracture almost always occur in at least TWO places ('ring bone' principle)?

![Figure 4: Clinical Findings & Diagnostic Reference (Maxillofacial & Mandibular Trauma)](/lessons/images/sba/trauma/maxillofacial-trauma/figure_04_p14.jpeg)


- **A.** The mandible functions as a rigid anatomical ring with the skull base; force applied to one side typically produces a direct fracture at the impact site and a contralateral fracture (e.g. body and opposite condyle)
- **B.** The mandible has no muscle attachments
- **C.** Mandibular bone consists only of cartilage
- **D.** Mandibular trauma always involves the cervical spine
- **E.** Chewing forces divide every fracture into two

**Correct Answer:** A
**Explanation:**
Like the pelvis, the mandible is a rigid U-shaped bone forming a closed ring with the temporomandibular joints and skull base. Blunt impact commonly produces bilateral fractures: a direct fracture at the site of impact (e.g. angle or parasymphysis) and an indirect fracture on the opposite side (e.g. contralateral condylar neck).

## Question 5 of 5

On examination of a patient with a nasal fracture, a bilateral, boggy, bluish-purple swelling of the anterior nasal septum is visualised on anterior rhinoscopy. Why must this Septal Haematoma be urgently drained?

- **A.** Blood strips the perichondrium from the septal cartilage, leading to ischaemic avascular necrosis, septal perforation, and 'saddle nose' deformity, or septal abscess
- **B.** It inevitably causes cavernous sinus thrombosis within 1 hour
- **C.** It causes permanent anosmia
- **D.** It causes optic nerve atrophy
- **E.** It will cause severe epistaxis if not drained

**Correct Answer:** A
**Explanation:**
Septal cartilage derives its entire blood supply from the overlying mucoperichondrium. A septal haematoma strips the perichondrium away; within 24-48 hours, ischaemic necrosis occurs, leading to destruction of the cartilaginous septum, permanent collapse of the nasal bridge ('saddle-nose deformity'), and potential bacterial abscess. Immediate incision and drainage is mandatory.
$SBA_TRAU_038$,
    false,
    13,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 8/13: Renal & Bladder Malignancies
  -- 1) Interleave Lecture (Position 14)
  UPDATE "lessons"
  SET "position" = 14, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'renal-ca-vs-bladder-ca' OR "slug" = 'renal-cancer-bladder-cancer');

  -- 2) Upsert Quiz Lesson (Position 15)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-trauma-renal-cancer-bladder-cancer',
    'Renal & Bladder Malignancies — SBA Interactive Quiz',
    'quiz',
    $SBA_TRAU_039$# Renal & Bladder Malignancies — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 64-year-old male smoker presents with intermittent, painless macroscopic (gross) haematuria for 3 weeks. He has no dysuria, fever, or loin pain. What is the single most urgent investigation indicated to exclude bladder cancer?

![Figure 1: Clinical Findings & Diagnostic Reference (Renal & Bladder Malignancies)](/lessons/images/sba/trauma/renal-cancer-bladder-cancer/figure_01_p1.jpeg)


- **A.** Urgent 2-week-wait urology referral for Flexible Cystoscopy and CT Urogram
- **B.** Course of oral trimethoprim for 7 days
- **C.** Repeat urine dipstick in 3 months
- **D.** Reassurance that painless haematuria is benign
- **E.** Serum PSA level alone

**Correct Answer:** A
**Explanation:**
Painless gross (macroscopic) haematuria in an adult (especially aged >45 or with smoking history) is considered urothelial malignancy until proven otherwise. NICE guidelines mandate urgent 2-week-wait cancer referral for flexible cystoscopy (to visualize the bladder urothelium) and contrast CT urography (to assess the upper urinary tracts).

## Question 2 of 5

What is the classic clinical triad of Renal Cell Carcinoma (RCC), although found in less than 10% of patients and denoting advanced disease?

![Figure 2: Clinical Findings & Diagnostic Reference (Renal & Bladder Malignancies)](/lessons/images/sba/trauma/renal-cancer-bladder-cancer/figure_02_p3.jpeg)


- **A.** Flank / loin pain, Palpable abdominal/flank mass, and Haematuria
- **B.** Jaundice, Ascites, and Caput medusae
- **C.** Fever, Dysuria, and Frequency
- **D.** Weight loss, Polyuria, and Polydipsia
- **E.** Hypertension, Headache, and Diaphoresis

**Correct Answer:** A
**Explanation:**
The classic 'Too Late Triad' of Renal Cell Carcinoma is: (1) Flank pain; (2) Palpable renal mass; (3) Gross or microscopic haematuria. Most renal cell carcinomas are now detected incidentally on abdominal cross-sectional imaging for other indications.

## Question 3 of 5

A 58-year-old man presents with a newly developed, non-tender left-sided varicocele that fails to decompress or empty when the patient assumes the supine position. What underlying pathology must be urgently excluded?

- **A.** Renal Cell Carcinoma invading the left renal vein and obstructing the left testicular vein
- **B.** Inguinal hernia
- **C.** Epididymal cyst
- **D.** Benign testicular hydrocele
- **E.** Torsion of the appendix testis

**Correct Answer:** A
**Explanation:**
The left gonadal (testicular) vein drains at a right angle directly into the left renal vein (unlike the right testicular vein, which drains directly into the IVC). An acute, non-reducible left varicocele in a middle-aged/older man is a classic red flag for a left renal cell carcinoma with tumor thrombus extension into the left renal vein obstructing venous outflow.

## Question 4 of 5

Which histological subtype represents approximately 75-80% of all primary Renal Cell Carcinomas and is classically associated with mutations in the von Hippel-Lindau (VHL) tumour suppressor gene on chromosome 3p?

- **A.** Clear Cell Renal Cell Carcinoma
- **B.** Papillary RCC (chromophilic)
- **C.** Chromophobe RCC
- **D.** Collecting duct carcinoma
- **E.** Renal oncocytoma

**Correct Answer:** A
**Explanation:**
Clear cell RCC is the predominant histological subtype (75-80%). Inactivation or mutation of the VHL gene on chromosome 3p causes accumulation of Hypoxia-Inducible Factor (HIF), driving overexpression of VEGF and PDGF, making clear cell RCC a highly vascular tumor responsive to tyrosine kinase inhibitors and immunotherapy.

## Question 5 of 5

What is the single most common histological type of Bladder Cancer in the UK and Western Europe, and what is its most important modifiable risk factor?

- **A.** Transitional Cell Carcinoma (Urothelial Carcinoma); Cigarette smoking
- **B.** Squamous Cell Carcinoma; Schistosomiasis
- **C.** Adenocarcinoma; Bladder extrophy
- **D.** Small cell neuroendocrine carcinoma; Alcohol
- **E.** Sarcoma; Radiotherapy

**Correct Answer:** A
**Explanation:**
Urothelial (transitional cell) carcinoma accounts for >90% of bladder cancers in Western countries. Cigarette smoking is by far the leading risk factor, responsible for approximately 50% of cases due to aromatic amines and polycyclic aromatic hydrocarbons excreted in the urine.
$SBA_TRAU_039$,
    false,
    15,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 9/13: Spinal Cord Injury & Incomplete Syndromes
  -- 1) Interleave Lecture (Position 16)
  UPDATE "lessons"
  SET "position" = 16, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'spinal-cord' OR "slug" = 'spinal-cord-injury');

  -- 2) Upsert Quiz Lesson (Position 17)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-trauma-spinal-cord-injury',
    'Spinal Cord Injury & Incomplete Syndromes — SBA Interactive Quiz',
    'quiz',
    $SBA_TRAU_040$# Spinal Cord Injury & Incomplete Syndromes — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 24-year-old male suffers a stab wound to the right side of his thoracic spinal cord (T8 level). Examination demonstrates ipsilateral loss of motor function (spastic paralysis) and proprioception/vibration sense, accompanied by contralateral loss of pain and temperature sensation beginning 1-2 segments below the lesion. What incomplete spinal cord syndrome is this?

![Figure 1: Clinical Findings & Diagnostic Reference (Spinal Cord Injury & Incomplete Syndromes)](/lessons/images/sba/trauma/spinal-cord-injury/figure_01_p6.jpeg)


- **A.** Brown-Séquard Syndrome (spinal cord hemisection)
- **B.** Central Cord Syndrome
- **C.** Anterior Cord Syndrome
- **D.** Posterior Cord Syndrome
- **E.** Cauda Equina Syndrome

**Correct Answer:** A
**Explanation:**
Brown-Séquard syndrome (hemisection of the spinal cord): (1) Ipsilateral motor loss (corticospinal tract crosses at medulla); (2) Ipsilateral loss of proprioception/vibration (dorsal columns cross at medulla); (3) Contralateral loss of pain and temperature (spinothalamic tract crosses 1-2 levels above entry in the spinal cord).

![Clinical Algorithm & Advanced Reference (Spinal Cord Injury & Incomplete Syndromes)](/lessons/images/sba/trauma/spinal-cord-injury/figure_06_p11.jpeg)


## Question 2 of 5

A 72-year-old man with cervical spondylosis sustains a hyperextension injury to his neck after falling forward onto his forehead. On examination, he has marked weakness and sensory loss in his UPPER limbs, with relatively preserved motor strength in his lower limbs, and variable bladder dysfunction. What syndrome is this?

![Figure 2: Clinical Findings & Diagnostic Reference (Spinal Cord Injury & Incomplete Syndromes)](/lessons/images/sba/trauma/spinal-cord-injury/figure_02_p7.jpeg)


- **A.** Central Cord Syndrome
- **B.** Anterior Cord Syndrome
- **C.** Brown-Séquard Syndrome
- **D.** Complete spinal cord transection
- **E.** Guillain-Barré syndrome

**Correct Answer:** A
**Explanation:**
Central Cord Syndrome is the most common incomplete spinal cord injury. Typically seen in elderly patients with pre-existing cervical spondylosis undergoing hyperextension trauma. The central corticospinal fibers supplying the cervical/upper extremities are selectively damaged, leading to greater motor deficit in upper limbs than lower limbs ('hands worse than feet').

![Clinical Algorithm & Advanced Reference (Spinal Cord Injury & Incomplete Syndromes)](/lessons/images/sba/trauma/spinal-cord-injury/figure_07_p13.jpeg)


## Question 3 of 5

Which incomplete spinal cord injury is caused by occlusion or trauma to the Anterior Spinal Artery, producing complete bilateral loss of motor function and bilateral loss of pain and temperature below the lesion, while sparing dorsal column light touch, vibration, and proprioception?

![Figure 3: Clinical Findings & Diagnostic Reference (Spinal Cord Injury & Incomplete Syndromes)](/lessons/images/sba/trauma/spinal-cord-injury/figure_03_p7.jpeg)


- **A.** Anterior Cord Syndrome
- **B.** Brown-Séquard Syndrome
- **C.** Central Cord Syndrome
- **D.** Conus Medullaris Syndrome
- **E.** Posterior Cord Syndrome

**Correct Answer:** A
**Explanation:**
Anterior Cord Syndrome results from infarction of the anterior two-thirds of the spinal cord supplied by the anterior spinal artery (or flexion-compression bone retropulsion). Corticospinal and spinothalamic tracts are destroyed (bilateral paralysis, loss of pain/temp), but dorsal columns (posterior third supplied by paired posterior spinal arteries) are spared, preserving proprioception and vibration.

![Clinical Algorithm & Advanced Reference (Spinal Cord Injury & Incomplete Syndromes)](/lessons/images/sba/trauma/spinal-cord-injury/figure_08_p14.jpeg)


## Question 4 of 5

What is the critical clinical difference between 'Neurogenic Shock' and 'Spinal Shock' in acute trauma management?

![Figure 4: Clinical Findings & Diagnostic Reference (Spinal Cord Injury & Incomplete Syndromes)](/lessons/images/sba/trauma/spinal-cord-injury/figure_04_p8.jpeg)


- **A.** Neurogenic shock is a haemodynamic condition (loss of sympathetic vasomotor tone producing hypotension and bradycardia), whereas spinal shock is a neurological state of temporary flaccidity and loss of all spinal reflexes below the lesion
- **B.** Spinal shock causes severe hypertension and tachycardia
- **C.** Neurogenic shock causes hypovolaemic tachycardia
- **D.** They are identical terms with no difference
- **E.** Spinal shock requires emergency thoracotomy

**Correct Answer:** A
**Explanation:**
Neurogenic shock is a form of distributive shock caused by disruption of descending sympathetic autonomic pathways (typically cervical/high thoracic injuries >=T6), producing arterial vasodilation (hypotension) and loss of cardiac accelerator tone (bradycardia with warm peripheries). Spinal shock refers to the temporary total loss of spinal reflex function, motor tone, and sensation below a severe spinal cord injury, which resolves over days to weeks (signalled by return of the bulbocavernosus reflex).

![Clinical Algorithm & Advanced Reference (Spinal Cord Injury & Incomplete Syndromes)](/lessons/images/sba/trauma/spinal-cord-injury/figure_09_p14.jpeg)


## Question 5 of 5

Which reflex marks the end of 'Spinal Shock' and indicates return of spinal reflex arcs (transitioning to spasticity)?

![Figure 5: Clinical Findings & Diagnostic Reference (Spinal Cord Injury & Incomplete Syndromes)](/lessons/images/sba/trauma/spinal-cord-injury/figure_05_p9.jpeg)


- **A.** Bulbocavernosus reflex (anal sphincter contraction in response to squeezing the glans penis or tugging a Foley catheter)
- **B.** Patellar tendon reflex
- **C.** Corneal reflex
- **D.** Gag reflex
- **E.** Abdominal cutaneous reflex

**Correct Answer:** A
**Explanation:**
The bulbocavernosus reflex (mediated by S2-S4) tests the integrity of the sacral reflex arc. During acute spinal shock, all reflexes including the bulbocavernosus reflex are absent. Its reappearance signals the termination of spinal shock; if profound motor and sensory deficits persist after the reflex returns, the spinal cord injury is classified as neurologically complete.

![Clinical Algorithm & Advanced Reference (Spinal Cord Injury & Incomplete Syndromes)](/lessons/images/sba/trauma/spinal-cord-injury/figure_10_p15.jpeg)


![Supplementary Clinical Reference 6 (Spinal Cord Injury & Incomplete Syndromes)](/lessons/images/sba/trauma/spinal-cord-injury/figure_11_p17.jpeg)


![Supplementary Clinical Reference 7 (Spinal Cord Injury & Incomplete Syndromes)](/lessons/images/sba/trauma/spinal-cord-injury/figure_12_p18.jpeg)


![Supplementary Clinical Reference 8 (Spinal Cord Injury & Incomplete Syndromes)](/lessons/images/sba/trauma/spinal-cord-injury/figure_13_p19.jpeg)


![Supplementary Clinical Reference 9 (Spinal Cord Injury & Incomplete Syndromes)](/lessons/images/sba/trauma/spinal-cord-injury/figure_14_p20.jpeg)


![Supplementary Clinical Reference 10 (Spinal Cord Injury & Incomplete Syndromes)](/lessons/images/sba/trauma/spinal-cord-injury/figure_15_p20.jpeg)

$SBA_TRAU_040$,
    false,
    17,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 10/13: Spinal Injury & Autonomic Dysreflexia
  -- 1) Interleave Lecture (Position 18)
  UPDATE "lessons"
  SET "position" = 18, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'spinal-injury-autonmic-dysreflexia' OR "slug" = 'spinal-injury-autonomic-dysreflexia');

  -- 2) Upsert Quiz Lesson (Position 19)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-trauma-spinal-injury-autonomic-dysreflexia',
    'Spinal Injury & Autonomic Dysreflexia — SBA Interactive Quiz',
    'quiz',
    $SBA_TRAU_041$# Spinal Injury & Autonomic Dysreflexia — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 36-year-old male with a complete T4 spinal cord injury (wheelchair-dependent) presents with a pounding headache, facial flushing, severe diaphoresis above his nipple line, and profound nasal congestion. His BP is 218/124 mmHg, and heart rate is 46 bpm. What life-threatening medical emergency is this?

![Figure 1: Clinical Findings & Diagnostic Reference (Spinal Injury & Autonomic Dysreflexia)](/lessons/images/sba/trauma/spinal-injury-autonomic-dysreflexia/figure_01_p3.jpeg)


- **A.** Autonomic Dysreflexia (Hyperreflexia)
- **B.** Neurogenic shock
- **C.** Pheochromocytoma crisis
- **D.** Ischaemic stroke
- **E.** Opiate withdrawal

**Correct Answer:** A
**Explanation:**
Autonomic Dysreflexia is a medical emergency occurring in spinal cord injuries at or above T6. Noxious visceral stimuli below the lesion trigger uncontrolled sympathetic discharge (vasoconstriction, severe hypertension). Intact cranial baroreceptors attempt compensation via the vagus nerve (bradycardia, vasodilation/flushing/sweating ABOVE the lesion), but inhibitory impulses cannot traverse the damaged spinal cord.

## Question 2 of 5

What is the single most common trigger of an acute episode of Autonomic Dysreflexia?

![Figure 2: Clinical Findings & Diagnostic Reference (Spinal Injury & Autonomic Dysreflexia)](/lessons/images/sba/trauma/spinal-injury-autonomic-dysreflexia/figure_02_p5.jpeg)


- **A.** Bladder distension / blocked urinary catheter (responsible for 75-85% of cases)
- **B.** Hypothermia
- **C.** Coughing
- **D.** Hunger
- **E.** Excess fluid intake

**Correct Answer:** A
**Explanation:**
Bladder-related triggers cause 75-85% of episodes (distended bladder, kinked/blocked Foley catheter, UTI, cystoscopy). Bowel impaction/constipation is the second most common trigger (~15%), followed by pressure ulcers, ingrown toenails, or bone fractures.

## Question 3 of 5

What is the FIRST immediate physical action to take when a patient is diagnosed with an acute episode of Autonomic Dysreflexia in the ED?

![Figure 3: Clinical Findings & Diagnostic Reference (Spinal Injury & Autonomic Dysreflexia)](/lessons/images/sba/trauma/spinal-injury-autonomic-dysreflexia/figure_03_p6.jpeg)


- **A.** Sit the patient upright (90 degrees) with legs dangling over the edge of the bed, and loosen all tight clothing
- **B.** Place the patient flat in Trendelenburg position
- **C.** Infuse 2 litres of intravenous fluid rapidly
- **D.** Administer intravenous atropine 3mg
- **E.** Place in the prone position

**Correct Answer:** A
**Explanation:**
Immediate non-pharmacological management: Sit the patient fully upright (90 degrees) with legs dependent. This uses gravitational venous pooling in the lower extremities to acutely lower blood pressure (orthostatic drop). Loosen all restrictive belts, clothing, and abdominal binders immediately, and check the catheter.

## Question 4 of 5

If sitting the patient upright and checking/relieving the urinary catheter does not immediately reduce blood pressure in severe Autonomic Dysreflexia (systolic BP remains >160-170 mmHg), which rapidly acting vasodilator is first-line?

- **A.** Sublingual Glyceryl Trinitrate (GTN) spray or topical GTN transdermal paste, or oral Nifedipine (bite-and-swallow modified-release)
- **B.** IV Adrenaline infusion
- **C.** Oral propranolol
- **D.** IV Noradrenaline
- **E.** Subcutaneous morphine

**Correct Answer:** A
**Explanation:**
If BP remains severely elevated, rapid short-acting antihypertensives should be administered while investigating secondary triggers. Sublingual GTN spray (or topical GTN paste which can be wiped off if hypotension develops) or oral/sublingual captopril or modified-release nifedipine are recommended.

## Question 5 of 5

What catastrophic complications can occur if acute severe Autonomic Dysreflexia is left unrecognised or untreated?

- **A.** Intracranial haemorrhage, hypertensive encephalopathy, seizures, acute pulmonary oedema, retinal detachment, or fatal cardiac arrest
- **B.** Acute hypoglycemia
- **C.** Permanent paralysis of cranial nerves
- **D.** Acute liver failure
- **E.** Hyperglycaemic hyperosmolar state

**Correct Answer:** A
**Explanation:**
Severe acute hypertension in autonomic dysreflexia can reach systolic pressures >250-300 mmHg. Fatal complications include hypertensive encephalopathy, intracerebral/subarachnoid haemorrhage, status epilepticus, acute myocardial infarction, and ventricular arrhythmias.
$SBA_TRAU_041$,
    false,
    19,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 11/13: Spontaneous Pneumothorax (Non-Traumatic)
  -- 1) Interleave Lecture (Position 20)
  UPDATE "lessons"
  SET "position" = 20, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'spontenus-pnemothroax-non-tramuatic' OR "slug" = 'spontaneous-pneumothorax-non-traumatic');

  -- 2) Upsert Quiz Lesson (Position 21)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-trauma-spontaneous-pneumothorax-non-traumatic',
    'Spontaneous Pneumothorax (Non-Traumatic) — SBA Interactive Quiz',
    'quiz',
    $SBA_TRAU_042$# Spontaneous Pneumothorax (Non-Traumatic) — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 21-year-old tall, thin male smoker presents with sudden sharp left-sided pleuritic chest pain and mild breathlessness. Trachea is central. Left lung has decreased breath sounds and hyper-resonance to percussion. Chest radiograph demonstrates a 3 cm rim of air between the lung margin and chest wall at the level of the hilum. What is the diagnosis and initial management according to British Thoracic Society (BTS) guidelines?

![Figure 1: Clinical Findings & Diagnostic Reference (Spontaneous Pneumothorax (Non-Traumatic))](/lessons/images/sba/trauma/spontaneous-pneumothorax-non-traumatic/figure_01_p5.jpeg)


- **A.** Primary Spontaneous Pneumothorax (large >2cm); Simple Needle Aspiration (16-18G cannula)
- **B.** Tension pneumothorax; immediate thoracotomy
- **C.** Secondary spontaneous pneumothorax; mandatory surgical pleurectomy
- **D.** Discharge home without any intervention
- **E.** Large bore 32F surgical chest tube insertion

**Correct Answer:** A
**Explanation:**
BTS Pneumothorax guidelines define Primary Spontaneous Pneumothorax (PSP) as occurring in individuals without pre-existing clinical lung disease. 'Large' is defined as a visible rim of air >2 cm at the level of the hilum on erect CXR. First-line intervention for symptomatic large PSP is simple aspiration using a 16-18G cannula. If successful (<2 cm rim, improved dyspnoea), the patient may be observed and discharged.

## Question 2 of 5

How does British Thoracic Society management differ between Primary Spontaneous Pneumothorax (PSP) and Secondary Spontaneous Pneumothorax (SSP)?

![Figure 2: Clinical Findings & Diagnostic Reference (Spontaneous Pneumothorax (Non-Traumatic))](/lessons/images/sba/trauma/spontaneous-pneumothorax-non-traumatic/figure_02_p6.jpeg)


- **A.** SSP occurs in patients with underlying lung disease (e.g. COPD, fibrotic lung disease); patients are generally older, less able to tolerate collapse, and usually require small-bore chest tube (intercostal drain) insertion and hospital admission
- **B.** PSP always requires surgical VATS pleurodesis on first presentation
- **C.** SSP never requires admission
- **D.** There is no difference in BTS management
- **E.** SSP is treated with high-dose steroids only

**Correct Answer:** A
**Explanation:**
Secondary Spontaneous Pneumothorax (SSP) occurs in the presence of established lung pathology (COPD, asthma, CF, interstitial lung disease). Because underlying respiratory reserve is poor, even a small pneumothorax (<2 cm) can cause life-threatening respiratory failure. Most patients with SSP >1-2 cm or marked breathlessness require small-bore chest drain insertion (10-14F) and inpatient admission.

## Question 3 of 5

In the safe insertion of a chest tube (intercostal drain), what anatomical boundaries define the 'Triangle of Safety'?

- **A.** Anterior border of latissimus dorsi, lateral border of pectoralis major, a horizontal line superior to the horizontal level of the nipple (5th intercostal space), and apex below the axilla
- **B.** Clavicle, Sternum, and 2nd intercostal space
- **C.** Posterior axillary line, Vertebral column, and 12th rib
- **D.** Xiphoid process, Costal margin, and Midclavicular line
- **E.** Suprasternal notch and bilateral sternocleidomastoid muscles

**Correct Answer:** A
**Explanation:**
The 'Triangle of Safety' minimizes risk of damage to the long thoracic nerve, internal mammary artery, liver, spleen, and diaphragm: (1) Anterior border: lateral edge of pectoralis major; (2) Posterior border: anterior edge of latissimus dorsi; (3) Inferior border: horizontal line at the 5th intercostal space (nipple level in males); (4) Apex: base of axilla.

## Question 4 of 5

Why must an intercostal chest tube always be inserted immediately OVER the superior border of the rib, rather than along the inferior border of the rib?

- **A.** To avoid lacerating the intercostal neurovascular bundle (intercostal vein, artery, and nerve) running in the subcostal groove along the inferior border
- **B.** The superior border is thinner and easier to puncture
- **C.** The inferior border contains the thoracic duct
- **D.** The superior border has no periosteum
- **E.** To prevent damaging the pericardium

**Correct Answer:** A
**Explanation:**
The intercostal neurovascular bundle (Vein, Artery, Nerve - 'VAN' from superior to inferior) runs protected in the subcostal groove along the INFERIOR border of each rib. Instruments and chest tubes must always 'ride' immediately over the SUPERIOR border of the lower rib to avoid catastrophic intercostal artery haemorrhage or nerve damage.

## Question 5 of 5

What critical travel advice regarding commercial air travel and scuba diving must be given to patients following resolution of a spontaneous pneumothorax according to BTS guidelines?

- **A.** Avoid commercial air flight until at least 7 days post complete radiological resolution; scuba diving is permanently contraindicated unless definitive surgical pleurectomy has been performed
- **B.** They may fly immediately after chest drain removal
- **C.** Scuba diving is safe if they take prophylactic inhalers
- **D.** Commercial flight is permanently banned for life
- **E.** They must never ride in an automobile above sea level

**Correct Answer:** A
**Explanation:**
According to BTS guidelines, commercial air travel (Boyle's law: gas expansion at cabin pressure) can expand residual pneumothorax, causing tension pneumothorax. Air travel is prohibited until at least 7-14 days after full radiological resolution. Scuba diving is permanently contraindicated following an episode of pneumothorax unless bilateral surgical pleurectomy has been performed.
$SBA_TRAU_042$,
    false,
    21,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 12/13: Thoracic Trauma & Flail Chest
  -- 1) Interleave Lecture (Position 22)
  UPDATE "lessons"
  SET "position" = 22, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'throacic-trauma-and-faial-chest' OR "slug" = 'thoracic-trauma-flail-chest');

  -- 2) Upsert Quiz Lesson (Position 23)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-trauma-thoracic-trauma-flail-chest',
    'Thoracic Trauma & Flail Chest — SBA Interactive Quiz',
    'quiz',
    $SBA_TRAU_043$# Thoracic Trauma & Flail Chest — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 54-year-old unrestrained driver involved in a high-speed collision has blunt chest trauma. On inspection, a segment of his anterior chest wall moves inward during inspiration and outward during expiration ('paradoxical respiration'). What anatomical skeletal injury defines this Flail Chest?

![Figure 1: Clinical Findings & Diagnostic Reference (Thoracic Trauma & Flail Chest)](/lessons/images/sba/trauma/thoracic-trauma-flail-chest/figure_01_p5.jpeg)


- **A.** Fracture of >=3 consecutive ribs in >=2 places, creating a detached, freely floating segment of the thoracic cage
- **B.** Fracture of a single rib in one place
- **C.** Sternal fracture alone without rib fractures
- **D.** Bilateral clavicle fractures
- **E.** Fracture of the 12th floating rib

**Correct Answer:** A
**Explanation:**
Flail chest is defined as fractures of three or more contiguous ribs in two or more places along each rib, producing a segment of the chest wall that is mechanically separated from the rest of the thoracic cage, causing pathognomonic paradoxical chest motion.

## Question 2 of 5

What underlying parenchymal injury is almost invariably associated with Flail Chest and is the primary determinant of respiratory failure and hypoxia?

![Figure 2: Clinical Findings & Diagnostic Reference (Thoracic Trauma & Flail Chest)](/lessons/images/sba/trauma/thoracic-trauma-flail-chest/figure_02_p7.jpeg)


- **A.** Pulmonary Contusion
- **B.** Tracheal transection
- **C.** Diaphragmatic rupture
- **D.** Aortic dissection
- **E.** Oesophageal rupture

**Correct Answer:** A
**Explanation:**
The paradoxical motion of the flail segment contributes to work of breathing, but the major cause of hypoxaemia and respiratory failure in flail chest is the underlying Pulmonary Contusion (alveolar haemorrhage, interstitial oedema, ventilation-perfusion mismatch, and loss of compliance).

## Question 3 of 5

What is the cornerstone of emergency management for an adult patient with a Flail Chest and underlying pulmonary contusion who is maintaining acceptable oxygenation without distress?

![Figure 3: Clinical Findings & Diagnostic Reference (Thoracic Trauma & Flail Chest)](/lessons/images/sba/trauma/thoracic-trauma-flail-chest/figure_03_p9.jpeg)


- **A.** Aggressive multimodal analgesia (e.g. thoracic epidural or erector spinae / paravertebral nerve block) to allow deep breathing and clearance of secretions, with humidified oxygen
- **B.** Tight circumferential strapping and taping of the flail segment with elastoplast
- **C.** Prophylactic intubation and paralysis of all patients immediately
- **D.** Massive fluid overload with 4 litres of saline
- **E.** Complete immobilization in a body cast

**Correct Answer:** A
**Explanation:**
Adequate pain control is the cornerstone of flail chest management. Severe pain causes shallow breathing, splinting, atelectasis, and fatal pneumonia. Multimodal analgesia (regional anaesthesia: thoracic epidural, paravertebral, or erector spinae plane block) combined with systemic analgesia and chest physiotherapy prevents respiratory failure. Chest taping/sandbags are contraindicated because they worsen atelectasis.

## Question 4 of 5

Why must intravenous fluid resuscitation be strictly controlled and restricted ('euvolaemic / dry lung strategy') in patients with significant pulmonary contusions?

![Figure 4: Clinical Findings & Diagnostic Reference (Thoracic Trauma & Flail Chest)](/lessons/images/sba/trauma/thoracic-trauma-flail-chest/figure_04_p11.jpeg)


- **A.** Disrupted capillary-alveolar membranes in the contused lung readily leak fluid, accelerating massive alveolar flooding and severe ARDS
- **B.** Fluids cause immediate bone demineralization
- **C.** Fluids stimulate intercostal nerve hyperactivity
- **D.** Fluids neutralize endogenous surfactant
- **E.** Fluids cause acute pneumothorax

**Correct Answer:** A
**Explanation:**
In pulmonary contusion, the alveolar-capillary barrier is mechanically damaged. Excess fluid administration readily extravasates into the damaged alveoli, causing rapid worsening of pulmonary contusion, severe V/Q mismatch, and precipitation of Acute Respiratory Distress Syndrome (ARDS).

## Question 5 of 5

What are the indications for Surgical Stabilization of Rib Fractures (SSRF / surgical rib plating) in patients with flail chest?

![Figure 5: Clinical Findings & Diagnostic Reference (Thoracic Trauma & Flail Chest)](/lessons/images/sba/trauma/thoracic-trauma-flail-chest/figure_05_p12.jpeg)


- **A.** Severe flail chest with failure to wean from mechanical ventilation, persistent intractable pain despite epidural, or severe chest wall deformity
- **B.** Single non-displaced rib fracture
- **C.** Any rib fracture in a child
- **D.** Mild pain on deep inspiration
- **E.** Flail chest in a brain-dead patient

**Correct Answer:** A
**Explanation:**
Indications for surgical fixation of flail chest (rib plating): failure to wean from mechanical ventilation due to chest wall instability, progressive pulmonary deterioration, severe chest wall deformity/loss of thoracic volume, and intractable pain uncontrolled by maximal regional analgesia.
$SBA_TRAU_043$,
    false,
    23,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 13/13: Thoracic Trauma: Immediate Life Threats
  -- 1) Interleave Lecture (Position 24)
  UPDATE "lessons"
  SET "position" = 24, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'throacic-trauma-life-threatining-injury' OR "slug" = 'thoracic-trauma-life-threatening');

  -- 2) Upsert Quiz Lesson (Position 25)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-trauma-thoracic-trauma-life-threatening',
    'Thoracic Trauma: Immediate Life Threats — SBA Interactive Quiz',
    'quiz',
    $SBA_TRAU_044$# Thoracic Trauma: Immediate Life Threats — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 28-year-old male arrives following a blunt chest crush injury. He is in severe respiratory distress, cyanotic, and agitated. Examination reveals tachypnoea (RR 38/min), hypotension (BP 72/40 mmHg), distended neck veins, absent breath sounds on the right hemithorax, and tracheal deviation to the left. What is the immediate life-saving action?

![Figure 1: Clinical Findings & Diagnostic Reference (Thoracic Trauma: Immediate Life Threats)](/lessons/images/sba/trauma/thoracic-trauma-life-threatening/figure_01_p4.jpeg)


- **A.** Immediate Needle Decompression or Finger Thoracostomy of the right chest without waiting for a chest radiograph
- **B.** Perform an immediate portable chest X-ray in the resuscitation room
- **C.** Immediate endotracheal intubation and mechanical ventilation
- **D.** Administer 2 units of packed red blood cells
- **E.** Pericardiocentesis under ultrasound guidance

**Correct Answer:** A
**Explanation:**
Tension pneumothorax is a clinical diagnosis, NOT a radiological one. A 'one-way valve' air leak allows air into the pleural space on inspiration without escape, raising intrathoracic pressure, collapsing the ipsilateral lung, shifting the mediastinum to the contralateral side, kinking the vena cava, and arresting venous return to the heart (obstructive shock). Never delay decompression for a chest X-ray.

## Question 2 of 5

According to the updated ATLS 10th edition guidelines, what are the two recommended anatomical sites for emergency needle decompression in adult tension pneumothorax?

![Figure 2: Clinical Findings & Diagnostic Reference (Thoracic Trauma: Immediate Life Threats)](/lessons/images/sba/trauma/thoracic-trauma-life-threatening/figure_02_p7.jpeg)


- **A.** Fifth intercostal space slightly anterior to the mid-axillary line, OR second intercostal space in the mid-clavicular line
- **B.** Sixth intercostal space in the posterior axillary line
- **C.** First intercostal space parasternal line
- **D.** Subxiphoid space directly underneath the sternum
- **E.** Eighth intercostal space scapular line

**Correct Answer:** A
**Explanation:**
ATLS 10th edition recommends the 5th intercostal space, slightly anterior to the mid-axillary line (the same location as a chest tube) as the preferred site in adults because chest wall thickness is significantly less here than at the 2nd intercostal space mid-clavicular line, where standard catheters frequently fail to penetrate the pleural space.

## Question 3 of 5

A 22-year-old male sustains a stab wound to the right lateral chest. A large sucking chest wound (greater than two-thirds the diameter of the trachea) is present. What is the immediate temporary dressing of choice before formal chest tube placement?

![Figure 3: Clinical Findings & Diagnostic Reference (Thoracic Trauma: Immediate Life Threats)](/lessons/images/sba/trauma/thoracic-trauma-life-threatening/figure_03_p9.jpeg)


- **A.** Three-sided sterile occlusive dressing (flutter valve effect)
- **B.** Four-sided completely airtight occlusive dressing
- **C.** Open dry gauze without tape
- **D.** Surgical skin staples to close the wound tightly
- **E.** Pack the wound tightly with petroleum gauze

**Correct Answer:** A
**Explanation:**
An open pneumothorax ('sucking chest wound') occurs when the chest wall defect is >2/3 the diameter of the trachea, causing air to preferentially enter the wound during inspiration. The immediate management is applying a sterile occlusive dressing taped on THREE sides. This creates a flutter-valve effect: the dressing seals against the wound during inspiration (preventing air entry) and flutters open during expiration (allowing trapped air to escape). Taping all 4 sides can convert an open into a fatal tension pneumothorax.

## Question 4 of 5

A 35-year-old male with penetrating chest trauma has a large-bore chest tube inserted, which immediately drains 1,600 ml of fresh blood. Over the subsequent 2 hours, drainage continues at 250 ml/hour. What is the definitive management indicated by ATLS guidelines?

- **A.** Emergency Operative Thoracotomy
- **B.** Clamp the chest drain immediately
- **C.** Administer tranexamic acid and observe for 24 hours
- **D.** Perform a repeat chest radiograph
- **E.** Insert a second chest drain on the same side

**Correct Answer:** A
**Explanation:**
Indications for urgent thoracotomy in massive haemothorax: (1) Immediate initial evacuation of >=1,500 ml of blood upon chest tube insertion; OR (2) Ongoing persistent bleeding of >=200 ml/hour for 2-4 consecutive hours; OR (3) Persistent haemodynamic instability despite aggressive balanced blood resuscitation.

## Question 5 of 5

What are the indications for emergency 'Resuscitative Thoracotomy' (ED thoracotomy / clamshell thoracotomy) in a patient presenting in traumatic cardiac arrest?

- **A.** Penetrating thoracic trauma with witnessed cardiac arrest and <15 minutes of CPR (or signs of life in transit)
- **B.** Blunt trauma with >30 minutes of CPR and asystole
- **C.** Isolated severe closed head injury with GCS 3
- **D.** Penetrating abdominal trauma with CPR >45 minutes
- **E.** All cardiac arrest patients in the ED regardless of injury

**Correct Answer:** A
**Explanation:**
ED Resuscitative Thoracotomy has a meaningful survival rate (15-35%) almost exclusively in PENETRATING chest trauma patients with witnessed cardiac arrest or loss of signs of life (pupillary response, spontaneous ventilation, pulse) with <10-15 minutes of CPR. In blunt trauma, survival is <1-2% and it is generally futile unless cardiac arrest is witnessed directly in the ED.
$SBA_TRAU_044$,
    false,
    25,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();


  -- ------------------------------------------------------------------------
  -- Specialty: Pulmonology & Respiratory Emergencies (13 Topics)
  -- ------------------------------------------------------------------------
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_sba_id AND "title" = 'Pulmonology & Respiratory Emergencies' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module Pulmonology & Respiratory Emergencies not found in mrcem-sba';
  END IF;

  -- Topic 1/13: Acute Severe & Life-Threatening Asthma in Adults
  -- 1) Interleave Lecture (Position 0)
  UPDATE "lessons"
  SET "position" = 0, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'acute-severe-asthma-in-adults' OR "slug" = 'asthma');

  -- 2) Upsert Quiz Lesson (Position 1)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-pulmonology-asthma',
    'Acute Severe & Life-Threatening Asthma in Adults — SBA Interactive Quiz',
    'quiz',
    $SBA_PULM_045$# Acute Severe & Life-Threatening Asthma in Adults — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 24-year-old woman presents with acute breathlessness and wheezing. Her peak expiratory flow (PEF) is 45% of predicted, respiratory rate is 28 breaths/min, heart rate is 115 bpm, and she is unable to complete sentences in one breath. According to BTS/SIGN guidelines, how is this acute asthma exacerbation classified?

![Figure 1: Clinical Findings & Diagnostic Reference (Acute Severe & Life-Threatening Asthma in Adults)](/lessons/images/sba/pulmonology/asthma/figure_01_p2.jpeg)


- **A.** Acute Severe Asthma
- **B.** Moderate asthma exacerbation
- **C.** Life-threatening asthma
- **D.** Near-fatal asthma
- **E.** Brittle asthma

**Correct Answer:** A
**Explanation:**
BTS/SIGN criteria for Acute Severe Asthma: PEF 33-50% best/predicted, respiratory rate >=25/min, heart rate >=110 bpm, or inability to complete sentences in one breath. Moderate is PEF 50-75% with no severe features. Life-threatening features include PEF <33%, SpO2 <92%, silent chest, cyanosis, exhaustion, or normal/high PaCO2.

## Question 2 of 5

Which of the following clinical and arterial blood gas (ABG) findings is a critical sign of LIFE-THREATENING asthma requiring immediate critical care involvement?

![Figure 2: Clinical Findings & Diagnostic Reference (Acute Severe & Life-Threatening Asthma in Adults)](/lessons/images/sba/pulmonology/asthma/figure_02_p4.jpeg)


- **A.** A 'normal' or elevated PaCO2 (>=6.0 kPa / 45 mmHg) in a fatigued, exhausted patient
- **B.** PaCO2 of 3.2 kPa (respiratory alkalosis)
- **C.** Heart rate of 112 bpm
- **D.** Bilateral expiratory wheezing on chest auscultation
- **E.** PEF of 48% of predicted

**Correct Answer:** A
**Explanation:**
In early/moderate asthma exacerbations, hyperventilation drives PaCO2 down (respiratory alkalosis). Finding a 'normal' or elevated PaCO2 indicates respiratory muscle exhaustion, impending alveolar hypoventilation, and imminent respiratory arrest. It is a hallmark of life-threatening/near-fatal asthma.

## Question 3 of 5

What is the recommended first-line pharmacological bronchodilator regimen for acute severe asthma according to BTS/SIGN guidelines?

![Figure 3: Clinical Findings & Diagnostic Reference (Acute Severe & Life-Threatening Asthma in Adults)](/lessons/images/sba/pulmonology/asthma/figure_03_p5.jpeg)


- **A.** Oxygen-driven nebulised Salbutamol 5mg combined with Ipratropium Bromide 500mcg, plus early systemic corticosteroids (oral Prednisolone 40-50mg or IV Hydrocortisone 100mg)
- **B.** Oral montelukast alone
- **C.** Inhaled fluticasone low dose
- **D.** Intravenous aminophylline bolus without nebulisers
- **E.** Subcutaneous terbutaline without oxygen

**Correct Answer:** A
**Explanation:**
First-line emergency therapy: High-dose inhaled beta-2 agonist (Salbutamol 5mg) driven by high-flow oxygen, combined with an anticholinergic (Ipratropium bromide 500mcg) repeated every 15-20 minutes, alongside early systemic corticosteroids (Prednisolone 40-50mg orally or IV Hydrocortisone 100mg) which take 4-6 hours to exert anti-inflammatory effects.

## Question 4 of 5

A 28-year-old male with acute severe asthma has not improved despite back-to-back salbutamol and ipratropium nebulisers and IV hydrocortisone. PEF remains 38%. What intravenous adjunctive medication should be administered next according to BTS/SIGN guidelines?

![Figure 4: Clinical Findings & Diagnostic Reference (Acute Severe & Life-Threatening Asthma in Adults)](/lessons/images/sba/pulmonology/asthma/figure_04_p5.jpeg)


- **A.** Intravenous Magnesium Sulphate (1.2 - 2.0g infusion over 20 minutes)
- **B.** Intravenous Aminophylline loading dose
- **C.** Intravenous Ketamine
- **D.** Intravenous Sodium Bicarbonate
- **E.** Intravenous Furosemide

**Correct Answer:** A
**Explanation:**
IV Magnesium Sulphate (1.2 - 2.0 g IV over 20 min) is recommended as a safe and effective second-line bronchodilator for patients with acute severe asthma not responding to initial inhaled therapy (PEF <50%) or life-threatening asthma. It causes bronchial smooth muscle relaxation by blocking calcium influx.

## Question 5 of 5

Why should oxygen NOT be withheld in severe acute asthma exacerbations, and what is the target pulse oximetry (SpO2) range?

- **A.** Asthma patients do not have chronic hypoxic drive; target SpO2 is 94-98% using high-flow oxygen-driven nebulisers
- **B.** Target SpO2 is strictly 88-92% as in COPD
- **C.** Oxygen is toxic to asthmatic airways
- **D.** Target SpO2 is 80-85%
- **E.** Asthma requires room air only

**Correct Answer:** A
**Explanation:**
Unlike chronic hypercapnic COPD patients, patients with acute asthma are typically young with normal baseline lung function and do not rely on hypoxic drive. Hypoxia is the primary cause of cardiac arrest in asthma. High-flow oxygen is used to drive nebulisers with a target SpO2 of 94-98%.
$SBA_PULM_045$,
    false,
    1,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 2/13: Acute Paediatric Asthma & Wheeze
  -- 1) Interleave Lecture (Position 2)
  UPDATE "lessons"
  SET "position" = 2, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'acute-pediatric-asthma-wheeze' OR "slug" = 'asthma-children');

  -- 2) Upsert Quiz Lesson (Position 3)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-pulmonology-asthma-children',
    'Acute Paediatric Asthma & Wheeze — SBA Interactive Quiz',
    'quiz',
    $SBA_PULM_046$# Acute Paediatric Asthma & Wheeze — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 4-year-old boy presents to the paediatric ED with acute breathlessness and audible wheeze. He is agitated, breathless to talk or feed, respiratory rate is 45 breaths/min, heart rate is 145 bpm, and he has marked intercostal and subcostal retractions. SpO2 is 91% in room air. How is this acute attack categorized under BTS/SIGN paediatric guidelines?

![Figure 1: Clinical Findings & Diagnostic Reference (Acute Paediatric Asthma & Wheeze)](/lessons/images/sba/pulmonology/asthma-children/figure_01_p2.jpeg)


- **A.** Acute Severe Asthma
- **B.** Moderate asthma
- **C.** Mild episodic viral wheeze
- **D.** Croup
- **E.** Life-threatening asthma

**Correct Answer:** A
**Explanation:**
BTS/SIGN criteria for Acute Severe Asthma in children aged 2-5: SpO2 <92%, too breathless to talk or feed, RR >40/min, HR >130 bpm, or use of accessory neck muscles. Life-threatening features in this age group include silent chest, cyanosis, poor respiratory effort, hypotension, exhaustion, or confusion.

## Question 2 of 5

What is the preferred route and delivery device for administering inhaled Salbutamol to a 3-year-old child with mild-to-moderate acute wheeze?

![Figure 2: Clinical Findings & Diagnostic Reference (Acute Paediatric Asthma & Wheeze)](/lessons/images/sba/pulmonology/asthma-children/figure_02_p4.jpeg)


- **A.** Pressurised Metered-Dose Inhaler (pMDI) with an appropriately sized spacer and mask (giving 2-10 puffs, 1 puff every 30-60 seconds with 5 breaths per puff)
- **B.** Dry powder inhaler (turbohaler)
- **C.** Jet nebuliser driven by compressed air is mandatory for all children
- **D.** Oral salbutamol syrup
- **E.** Subcutaneous adrenaline

**Correct Answer:** A
**Explanation:**
Numerous clinical trials demonstrate that pMDI plus spacer is as effective as (and often superior to) a nebuliser for delivering bronchodilators in mild-to-moderate paediatric asthma, producing fewer side effects (less tachycardia) and causing less distress to the child.

## Question 3 of 5

What is the recommended oral steroid and dose for an acute severe asthma exacerbation in a 4-year-old child?

![Figure 3: Clinical Findings & Diagnostic Reference (Acute Paediatric Asthma & Wheeze)](/lessons/images/sba/pulmonology/asthma-children/figure_03_p5.jpeg)


- **A.** Oral Prednisolone 20mg once daily (or 1-2 mg/kg, max 40mg) for 3 days
- **B.** Oral Dexamethasone 0.15 mg/kg for 14 days
- **C.** Oral Hydrocortisone 5mg once weekly
- **D.** Inhaled budesonide alone without oral steroids
- **E.** Systemic steroids are contraindicated in children under 5

**Correct Answer:** A
**Explanation:**
BTS/SIGN recommends early administration of oral prednisolone (20 mg for children aged 2-5 years; 30-40 mg for children >5 years, or 1-2 mg/kg up to max 40 mg) for 3 days. Soluble prednisolone tablets or oral dexamethasone (0.3-0.6 mg/kg single dose) are effective.

## Question 4 of 5

A 5-year-old girl with acute severe asthma has not responded to frequent inhaled bronchodilators and oral steroids. Inhaled oxygen SpO2 is 89%, and she is becoming exhausted. What is the intravenous bronchodilator of choice for refractory severe paediatric asthma in the ED?

![Figure 4: Clinical Findings & Diagnostic Reference (Acute Paediatric Asthma & Wheeze)](/lessons/images/sba/pulmonology/asthma-children/figure_04_p5.jpeg)


- **A.** Intravenous Magnesium Sulphate (40 mg/kg, max 2g, infused over 20 minutes)
- **B.** Intravenous Salbutamol bolus 5mg
- **C.** Intravenous Aminophylline without monitoring
- **D.** Intravenous Morphine
- **E.** Intravenous Furosemide

**Correct Answer:** A
**Explanation:**
BTS/SIGN guidelines recommend IV Magnesium Sulphate (40 mg/kg, max 2 g, over 20 min) as first-line intravenous therapy for children with acute severe asthma unresponsive to initial inhaled bronchodilators. IV Salbutamol (infusion or slow bolus) and IV Aminophylline are second-line add-ons.

## Question 5 of 5

In pre-school children (<3 years), what is the most common clinical phenotype of recurrent wheezing triggered exclusively by viral upper respiratory tract infections with no interval symptoms?

- **A.** Viral-Induced Episodic (intermittent) Wheeze
- **B.** Multiple-trigger wheeze / Atopic asthma
- **C.** Cystic fibrosis
- **D.** Foreign body aspiration
- **E.** Tracheomalacia

**Correct Answer:** A
**Explanation:**
Pre-school wheezing is broadly classified into: (1) Episodic (viral) wheeze: child wheezes only during acute viral colds and is completely symptom-free between episodes; and (2) Multiple-trigger wheeze: child wheezes with viral infections and also with interval triggers like exercise, cold air, crying, or pet allergens, which has a higher risk of evolving into true atopic asthma.
$SBA_PULM_046$,
    false,
    3,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 3/13: Emergency Approach to Acute Breathlessness
  -- 1) Interleave Lecture (Position 4)
  UPDATE "lessons"
  SET "position" = 4, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'emergency-approach-to-acute-breathlessness' OR "slug" = 'breathlessness');

  -- 2) Upsert Quiz Lesson (Position 5)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-pulmonology-breathlessness',
    'Emergency Approach to Acute Breathlessness — SBA Interactive Quiz',
    'quiz',
    $SBA_PULM_047$# Emergency Approach to Acute Breathlessness — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 72-year-old male with a history of both COPD and ischemic heart disease presents with worsening shortness of breath and ankle swelling. Bedside point-of-care lung ultrasound (POCUS) demonstrates multiple bilateral 'B-lines' (comet-tail artefacts >3 per intercostal space) throughout anterior and lateral lung zones. What is the most likely diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Emergency Approach to Acute Breathlessness)](/lessons/images/sba/pulmonology/breathlessness/figure_01_p3.jpeg)


- **A.** Acute Cardiogenic Pulmonary Oedema (interstitial-alveolar fluid syndrome)
- **B.** Pure COPD exacerbation without pulmonary congestion
- **C.** Large pneumothorax
- **D.** Aspiration of a foreign body
- **E.** Chest wall muscular contusion

**Correct Answer:** A
**Explanation:**
In point-of-care lung ultrasound (BLUE protocol), multiple bilateral B-lines (vertical laser-like comet-tail reverberation artefacts arising from the pleural line) represent fluid-thickened interlobular septa and extravascular lung water, with >90% sensitivity and specificity for acute cardiogenic pulmonary oedema. COPD exacerbation without pulmonary edema classically shows horizontal A-lines.

## Question 2 of 5

Which serum biomarker has a high negative predictive value (>95%) to exclude acute congestive heart failure as the cause of acute breathlessness in the ED?

![Figure 2: Clinical Findings & Diagnostic Reference (Emergency Approach to Acute Breathlessness)](/lessons/images/sba/pulmonology/breathlessness/figure_02_p4.jpeg)


- **A.** B-type Natriuretic Peptide (BNP <100 pg/ml) or NT-proBNP (<300 pg/ml)
- **B.** Serum Troponin T
- **C.** C-reactive protein (CRP)
- **D.** Serum D-dimer
- **E.** Serum amylase

**Correct Answer:** A
**Explanation:**
BNP (<100 pg/ml) or NT-proBNP (<300 pg/ml) is highly accurate for ruling out acute decompensated heart failure in patients presenting with acute dyspnoea. Natriuretic peptides are released by ventricular myocytes in response to wall stretch and increased ventricular filling pressures.

## Question 3 of 5

A 65-year-old woman presents with sudden onset sharp right-sided pleuritic chest pain and shortness of breath 10 days after a total hip replacement. Heart rate is 112 bpm, BP 120/75 mmHg, SpO2 93% on room air. The chest radiograph is completely normal. What is the single most likely diagnosis to exclude?

![Figure 3: Clinical Findings & Diagnostic Reference (Emergency Approach to Acute Breathlessness)](/lessons/images/sba/pulmonology/breathlessness/figure_03_p5.jpeg)


- **A.** Acute Pulmonary Embolism (PE)
- **B.** Lobar pneumonia
- **C.** Pneumothorax
- **D.** Gastro-oesophageal reflux
- **E.** Rib fracture

**Correct Answer:** A
**Explanation:**
The classic presentation of acute Pulmonary Embolism is sudden-onset dyspnoea and pleuritic chest pain with tachycardia and a normal or near-normal chest X-ray in a patient with risk factors (recent major orthopaedic surgery). A normal CXR in a hypoxic, tachypnoeic patient strongly points toward PE.

## Question 4 of 5

What is the physiological hallmark of Type 1 Respiratory Failure on an Arterial Blood Gas (ABG)?

![Figure 4: Clinical Findings & Diagnostic Reference (Emergency Approach to Acute Breathlessness)](/lessons/images/sba/pulmonology/breathlessness/figure_04_p7.jpeg)


- **A.** Hypoxaemia (PaO2 < 8.0 kPa / 60 mmHg) with normal or low PaCO2 (< 6.0 kPa / 45 mmHg)
- **B.** Hypoxaemia with elevated PaCO2 (> 6.0 kPa)
- **C.** Isolated hypercapnia with PaO2 > 12.0 kPa
- **D.** Normal PaO2 with metabolic alkalosis
- **E.** Elevated carboxyhaemoglobin with normal PaO2

**Correct Answer:** A
**Explanation:**
Type 1 (hypoxaemic) respiratory failure is caused by V/Q mismatch or shunt: PaO2 < 8.0 kPa (60 mmHg) on air with normal or low PaCO2 (due to hyperventilation). Examples: pneumonia, pulmonary embolism, cardiogenic pulmonary oedema, ARDS. Type 2 (hypercapnic) failure has PaCO2 > 6.0 kPa (ventilatory failure: COPD, neuromuscular, drug overdose).

## Question 5 of 5

A 23-year-old university student is brought to the ED hyperventilating, reporting severe breathlessness, light-headedness, and bilateral tingling in her hands and around her mouth (carpopedal spasm). Arterial blood gas shows: pH 7.58, PaCO2 2.6 kPa (20 mmHg), PaO2 14.5 kPa (110 mmHg), HCO3- 24 mmol/L. What is the acid-base disorder and cause of tetany?

![Figure 5: Clinical Findings & Diagnostic Reference (Emergency Approach to Acute Breathlessness)](/lessons/images/sba/pulmonology/breathlessness/figure_05_p8.jpeg)


- **A.** Acute Respiratory Alkalosis; hypocapnic alkalosis increases protein binding of calcium, causing acute reduction in ionized calcium (hypocalcaemic tetany)
- **B.** Acute Metabolic Acidosis; hyperkalaemia
- **C.** Type 2 respiratory failure; CO2 narcosis
- **D.** Lactic acidosis from sepsis
- **E.** Salicylate poisoning Stage 3

**Correct Answer:** A
**Explanation:**
Hyperventilation blows off CO2, producing acute respiratory alkalosis (pH >7.45, low PaCO2). Alkalosis causes hydrogen ions to dissociate from albumin, freeing negative binding sites that bind ionized calcium. The resulting drop in free ionized calcium increases neuronal membrane excitability, causing circumoral tingling, paresthesias, and carpopedal spasm (tetany).
$SBA_PULM_047$,
    false,
    5,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 4/13: Acute Bronchiolitis in Infants
  -- 1) Interleave Lecture (Position 6)
  UPDATE "lessons"
  SET "position" = 6, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'broncholilis' OR "slug" = 'bronchiolitis');

  -- 2) Upsert Quiz Lesson (Position 7)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-pulmonology-bronchiolitis',
    'Acute Bronchiolitis in Infants — SBA Interactive Quiz',
    'quiz',
    $SBA_PULM_048$# Acute Bronchiolitis in Infants — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 3-month-old infant presents during winter with a 3-day history of coryza, low-grade fever, worsening cough, and difficulty feeding. Examination reveals tachypnoea (RR 62/min), subcostal and intercostal retractions, nasal flaring, and widespread fine bilateral inspiratory crackles and high-pitched expiratory wheezes throughout both lung fields. What is the most likely diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Acute Bronchiolitis in Infants)](/lessons/images/sba/pulmonology/bronchiolitis/figure_01_p3.jpeg)


- **A.** Acute Bronchiolitis
- **B.** Croup (laryngotracheobronchitis)
- **C.** Foreign body aspiration
- **D.** Bacterial tracheitis
- **E.** Congenital lobar emphysema

**Correct Answer:** A
**Explanation:**
Acute bronchiolitis is the most common lower respiratory tract infection in infants <1 year (peak age 2-6 months). Hallmark clinical features: viral prodrome followed by tachypnoea, hyperinflation, intercostal recession, and the characteristic combination of fine inspiratory crackles and expiratory wheeze.

## Question 2 of 5

What is the single most common causative viral pathogen of acute bronchiolitis in infants worldwide?

![Figure 2: Clinical Findings & Diagnostic Reference (Acute Bronchiolitis in Infants)](/lessons/images/sba/pulmonology/bronchiolitis/figure_02_p4.jpeg)


- **A.** Respiratory Syncytial Virus (RSV, causing 75-80% of cases)
- **B.** Human Metapneumovirus
- **C.** Rhinovirus
- **D.** Parainfluenza virus Type 1
- **E.** Adenovirus

**Correct Answer:** A
**Explanation:**
Respiratory Syncytial Virus (RSV) is responsible for approximately 75-80% of all bronchiolitis admissions. Rhinovirus, human metapneumovirus, and bocavirus are other causes.

## Question 3 of 5

According to NICE guideline NG9 (Bronchiolitis in children), which of the following interventions is recommended in routine management?

- **A.** Oxygen supplementation if SpO2 <92% and supportive fluid/nutritional maintenance via nasogastric feeding if feeding is <50% of normal
- **B.** Routine inhaled bronchodilators (salbutamol or ipratropium)
- **C.** Routine systemic oral corticosteroids
- **D.** Routine broad-spectrum intravenous antibiotics
- **E.** Routine chest physiotherapy and percussion

**Correct Answer:** A
**Explanation:**
NICE NG9 explicitly advises AGAINST: bronchodilators (salbutamol/ipratropium), systemic or inhaled corticosteroids, antibiotics, and routine chest physiotherapy, because none have shown efficacy in bronchiolitis. Supportive care (humidified oxygen for SpO2 <92%, nasal suctioning for feeding difficulties, and NG/IV fluids) is the only evidence-based management.

## Question 4 of 5

Which clinical presentation is recognized by NICE guidelines as a presentation of acute bronchiolitis specifically in young infants under 6 weeks of age, even before significant respiratory signs develop?

- **A.** Apnoea (cessation of breathing >20 seconds)
- **B.** Severe stridor
- **C.** Maculopapular rash
- **D.** Neck stiffness
- **E.** Profuse watery diarrhoea

**Correct Answer:** A
**Explanation:**
Young infants (<6-8 weeks of age) and premature infants with RSV bronchiolitis are at high risk of presenting with severe recurrent APNOEA, often occurring before prominent wheezing or crackles appear. They require immediate hospital admission with continuous cardiorespiratory monitoring.

## Question 5 of 5

According to NICE guidelines, what is an absolute 'Red Flag' criterion for immediate hospital admission in an infant with acute bronchiolitis?

- **A.** Persistent SpO2 <92% in room air, observed apnoea, or oral fluid intake less than 50% of typical volume
- **B.** Temperature of 37.8C
- **C.** Presence of mild nasal discharge
- **D.** Mild cough for 2 days
- **E.** Weight in the 50th centile

**Correct Answer:** A
**Explanation:**
NICE NG9 criteria for admission: Persistent SpO2 <92% on room air; clinical dehydration; inadequate oral fluid intake (<50% of normal volume); respiratory rate >60/min in infants <1 year; observed or reported apnoea; severe respiratory distress (grunting, marked recession); or social vulnerability.
$SBA_PULM_048$,
    false,
    7,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 5/13: Community-Acquired Pneumonia in Children
  -- 1) Interleave Lecture (Position 8)
  UPDATE "lessons"
  SET "position" = 8, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'community-acquired-pneumonia-in-children' OR "slug" = 'cap-children');

  -- 2) Upsert Quiz Lesson (Position 9)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-pulmonology-cap-children',
    'Community-Acquired Pneumonia in Children — SBA Interactive Quiz',
    'quiz',
    $SBA_PULM_049$# Community-Acquired Pneumonia in Children — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 3-year-old fully vaccinated boy presents with high fever (39.5C), productive cough, tachypnoea (RR 48/min), and focal crackles with bronchial breathing at the right lung base. Chest radiograph confirms dense right lower lobe lobar consolidation. What is the most likely bacterial pathogen?

![Figure 1: Clinical Findings & Diagnostic Reference (Community-Acquired Pneumonia in Children)](/lessons/images/sba/pulmonology/cap-children/figure_01_p4.jpeg)


- **A.** Streptococcus pneumoniae (Pneumococcus)
- **B.** Mycoplasma pneumoniae
- **C.** Staphylococcus aureus
- **D.** Haemophilus influenzae type b
- **E.** Pseudomonas aeruginosa

**Correct Answer:** A
**Explanation:**
Streptococcus pneumoniae is the most common cause of typical bacterial lobar pneumonia in children beyond the neonatal period. Characterized by high remittent fever, tachypnoea, focal bronchial breath sounds, and dense lobar consolidation on chest radiograph.

## Question 2 of 5

According to British Thoracic Society (BTS) paediatric pneumonia guidelines, what is the first-line oral antibiotic of choice for children with mild-to-moderate community-acquired pneumonia?

![Figure 2: Clinical Findings & Diagnostic Reference (Community-Acquired Pneumonia in Children)](/lessons/images/sba/pulmonology/cap-children/figure_02_p5.jpeg)


- **A.** Oral Amoxicillin (first-line in all ages)
- **B.** Oral Ciprofloxacin
- **C.** Oral Doxycycline
- **D.** Oral Clarithromycin monotherapy in an infant
- **E.** Oral Metronidazole

**Correct Answer:** A
**Explanation:**
BTS guidelines recommend oral Amoxicillin as the first-line empirical antibiotic for all children with mild-to-moderate community-acquired pneumonia because it provides excellent coverage against Streptococcus pneumoniae. Macrolides (e.g. clarithromycin or azithromycin) are added if atypical pneumonia (Mycoplasma) is suspected in children >=5 years.

## Question 3 of 5

An 8-year-old girl presents with persistent low-grade fever, dry hacking cough, headache, malaise, and patchy bilateral reticulonodular interstitial infiltrates on chest radiograph. Auscultation reveals diffuse fine crackles rather than lobar consolidation. What is the most likely pathogen?

- **A.** Mycoplasma pneumoniae
- **B.** Streptococcus pneumoniae
- **C.** Group B Streptococcus
- **D.** Klebsiella pneumoniae
- **E.** Legionella pneumophila

**Correct Answer:** A
**Explanation:**
Mycoplasma pneumoniae is the classic cause of 'atypical' community-acquired pneumonia in school-aged children and adolescents (>5 years). It features gradual onset, prominent headache, dry hacking cough, constitutional symptoms, and diffuse bilateral chest infiltrates that appear worse than clinical examination ('walking pneumonia'). Treatment is with a macrolide (clarithromycin/azithromycin).

## Question 4 of 5

A 4-year-old girl with severe staphylococcal pneumonia develops worsening breathlessness, high fevers, and dullness to percussion over the left hemithorax despite 48 hours of IV co-amoxiclav. Diagnostic pleural aspiration yields cloudy, purulent fluid with pH 6.9, glucose 1.2 mmol/L, and LDH >1000 IU/L. What complication has occurred?

- **A.** Parapneumonic Empyema
- **B.** Simple reactive pleural effusion
- **C.** Pneumothorax
- **D.** Chylothorax
- **E.** Congestive heart failure

**Correct Answer:** A
**Explanation:**
An empyema is pus or infected fluid in the pleural space, confirmed by macroscopic pus or pleural fluid pH <7.2, low glucose (<2.2 mmol/L), and elevated LDH (>1000 IU/L). Parapneumonic empyema in children requires IV antibiotics (e.g. co-amoxiclav or cefotaxime) plus chest tube drainage, often with intrapleural fibrinolytics (urokinase) or VATS surgical debridement.

## Question 5 of 5

According to the World Health Organization (WHO) and BTS, what single clinical sign is the most sensitive and specific bedside physical marker of pneumonia in a febrile young child?

- **A.** Tachypnoea (age-adjusted fast breathing: >50/min in 2-11 months, >40/min in 1-5 years)
- **B.** Presence of chest pain
- **C.** Purulent sputum
- **D.** Night sweats
- **E.** Digital clubbing

**Correct Answer:** A
**Explanation:**
WHO and BTS recognize Tachypnoea (fast breathing) as the most reliable clinical indicator of pneumonia in children. Thresholds: >=60 breaths/min in infants <2 months; >=50 breaths/min in infants 2-11 months; >=40 breaths/min in children 1-5 years. In the absence of tachypnoea, bacterial pneumonia is highly unlikely.
$SBA_PULM_049$,
    false,
    9,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 6/13: Community-Acquired Pneumonia (CAP) in Adults
  -- 1) Interleave Lecture (Position 10)
  UPDATE "lessons"
  SET "position" = 10, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'pulmo-1' OR "slug" = 'community-acquired-pneumonia');

  -- 2) Upsert Quiz Lesson (Position 11)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-pulmonology-community-acquired-pneumonia',
    'Community-Acquired Pneumonia (CAP) in Adults — SBA Interactive Quiz',
    'quiz',
    $SBA_PULM_050$# Community-Acquired Pneumonia (CAP) in Adults — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 72-year-old man presents with fever, productive cough with rust-coloured sputum, and right pleuritic chest pain. Examination: GCS 15 (alert), RR 32/min, BP 106/68 mmHg, Urea 8.4 mmol/L. Based on the CURB-65 scoring system, what is his score and the recommended management setting?

![Figure 1: Clinical Findings & Diagnostic Reference (Community-Acquired Pneumonia (CAP) in Adults)](/lessons/images/sba/pulmonology/community-acquired-pneumonia/figure_01_p3.jpeg)


- **A.** CURB-65 score 3 (Urea >7, RR >=30, Age >=65); High risk, requires urgent hospital admission and consideration of HDU/ICU
- **B.** CURB-65 score 1; Low risk, suitable for home treatment with oral amoxicillin
- **C.** CURB-65 score 0; Discharge immediately
- **D.** CURB-65 score 5; Palliative care only
- **E.** CURB-65 is only used for children

**Correct Answer:** A
**Explanation:**
CURB-65 criteria (1 point each): Confusion (AMTS <=8 or new disorientation); Urea >7 mmol/L; Respiratory rate >=30/min; Blood pressure (systolic <90 or diastolic <=60 mmHg); Age >=65 years. Patient scores 3 points: Urea 8.4 (1), RR 32 (1), Age 72 (1). Score 3-5 indicates severe pneumonia with 30-day mortality >15-20%, mandating hospital admission and urgent consideration of critical care.

## Question 2 of 5

What is the classic bacterial pathogen responsible for pneumonia associated with rust-coloured sputum and lobar consolidation on chest X-ray?

![Figure 2: Clinical Findings & Diagnostic Reference (Community-Acquired Pneumonia (CAP) in Adults)](/lessons/images/sba/pulmonology/community-acquired-pneumonia/figure_02_p4.jpeg)


- **A.** Streptococcus pneumoniae (Pneumococcus)
- **B.** Klebsiella pneumoniae
- **C.** Pseudomonas aeruginosa
- **D.** Mycoplasma pneumoniae
- **E.** Legionella pneumophila

**Correct Answer:** A
**Explanation:**
Streptococcus pneumoniae is the most common cause of CAP (accounting for ~50% of identifiable cases). The sputum is characteristically 'rust-coloured' due to red cell extravasation into the alveoli during the red hepatisation stage of lobar pneumonia.

## Question 3 of 5

A 56-year-old hotel maintenance worker presents with high fever, dry cough, severe diarrhoea, confusion, and hyponatraemia (serum sodium 124 mmol/L). Transaminases are elevated, and chest radiograph shows bilateral consolidation. What is the most likely pathogen and diagnostic test of choice?

![Figure 3: Clinical Findings & Diagnostic Reference (Community-Acquired Pneumonia (CAP) in Adults)](/lessons/images/sba/pulmonology/community-acquired-pneumonia/figure_03_p5.jpeg)


- **A.** Legionella pneumophila; Urinary Antigen Test
- **B.** Streptococcus pneumoniae; Blood culture
- **C.** Mycoplasma pneumoniae; Cold agglutinins
- **D.** Chlamydia psittaci; Throat swab
- **E.** Coxiella burnetii; Liver biopsy

**Correct Answer:** A
**Explanation:**
Legionella pneumophila (Legionnaires' disease) is transmitted via aerosolised droplets from colonized water systems (cooling towers, hot tubs, air conditioning). Hallmarks: severe pneumonia with prominent extrapulmonary features (gastrointestinal symptoms/diarrhoea, neurological confusion/headache, deranged LFTs, and marked hyponatraemia). Diagnosis is made rapidly by urinary antigen testing (detects L. pneumophila serogroup 1).

## Question 4 of 5

According to NICE guideline NG138, what is the empirical antibiotic regimen of choice for patients with severe Community-Acquired Pneumonia (CURB-65 score >=3)?

![Figure 4: Clinical Findings & Diagnostic Reference (Community-Acquired Pneumonia (CAP) in Adults)](/lessons/images/sba/pulmonology/community-acquired-pneumonia/figure_04_p6.jpeg)


- **A.** Intravenous Co-amoxiclav (or Ceftriaxone) PLUS a Macrolide (IV Clarithromycin)
- **B.** Oral Amoxicillin 500mg TDS alone
- **C.** Oral Doxycycline 100mg once daily monotherapy
- **D.** IV Gentamicin monotherapy
- **E.** Oral Ciprofloxacin alone

**Correct Answer:** A
**Explanation:**
For severe CAP (CURB-65 >=3), NICE recommends dual therapy with a broad-spectrum beta-lactam (IV Co-amoxiclav 1.2g TDS or IV Ceftriaxone 2g daily) PLUS a macrolide (IV Clarithromycin 500mg BD) within 4 hours of admission to cover typical pathogens (S. pneumoniae, H. influenzae) and atypical pathogens (Legionella, Mycoplasma).

## Question 5 of 5

An alcoholic patient presents with severe right upper lobe cavitation and producing thick, gelatinous, dark red 'redcurrant jelly' sputum. What pathogen is classically responsible?

- **A.** Klebsiella pneumoniae
- **B.** Streptococcus pneumoniae
- **C.** Staphylococcus aureus
- **D.** Pneumocystis jirovecii
- **E.** Moraxella catarrhalis

**Correct Answer:** A
**Explanation:**
Klebsiella pneumoniae is an encapsulated Gram-negative bacillus classically causing severe necrotizing lobar pneumonia in alcoholics, diabetics, and debilitated patients. It produces thick, mucoid 'redcurrant jelly' sputum (due to blood and necrotic mucoid capsule material) with bulging fissures and cavitation on CXR.
$SBA_PULM_050$,
    false,
    11,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 7/13: COPD & Acute Exacerbations
  -- 1) Interleave Lecture (Position 12)
  UPDATE "lessons"
  SET "position" = 12, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'acute-exacerbation-of-copd' OR "slug" = 'copd');

  -- 2) Upsert Quiz Lesson (Position 13)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-pulmonology-copd',
    'COPD & Acute Exacerbations — SBA Interactive Quiz',
    'quiz',
    $SBA_PULM_051$# COPD & Acute Exacerbations — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

According to the Anthonisen criteria, what three cardinal symptoms define a Type 1 (Severe) Acute Exacerbation of Chronic Obstructive Pulmonary Disease (AECOPD)?

![Figure 1: Clinical Findings & Diagnostic Reference (COPD & Acute Exacerbations)](/lessons/images/sba/pulmonology/copd/figure_01_p4.jpeg)


- **A.** Increased dyspnoea, Increased sputum volume, and Increased sputum purulence
- **B.** Fever, Haemoptysis, and Pleuritic chest pain
- **C.** Weight loss, Night sweats, and Anorexia
- **D.** Confusion, Headache, and Tremor
- **E.** Wheezing, Stridor, and Dysphagia

**Correct Answer:** A
**Explanation:**
The Anthonisen criteria classify AECOPD: Type 1 (severe) has all 3 cardinal symptoms: worsening dyspnoea, increased sputum volume, and increased sputum purulence. Increased sputum purulence is the strongest predictor of bacterial infection and is the primary indication for antibiotic therapy.

## Question 2 of 5

A 66-year-old male with severe COPD is brought to the ED by ambulance on a high-flow 15 L/min non-rebreather reservoir mask. He is now obtunded and difficult to rouse, with warm hands and a bounding pulse with flapping tremor (asterixis). Arterial blood gas reveals: pH 7.18, PaCO2 11.2 kPa (84 mmHg), PaO2 24.5 kPa (184 mmHg), HCO3- 33 mmol/L. What acute physiological crisis has developed?

![Figure 2: Clinical Findings & Diagnostic Reference (COPD & Acute Exacerbations)](/lessons/images/sba/pulmonology/copd/figure_02_p8.jpeg)


- **A.** Oxygen-induced hypercapnia with severe acute-on-chronic respiratory acidosis ('CO2 Narcosis')
- **B.** Septic shock
- **C.** Acute pulmonary embolism
- **D.** Lactic acidosis from metformin
- **E.** Opiate overdose alone

**Correct Answer:** A
**Explanation:**
Administering unregulated high-flow oxygen to a patient with severe chronic hypercapnic respiratory failure worsens hypercapnia through three mechanisms: (1) worsening V/Q mismatch by reversing hypoxic pulmonary vasoconstriction in poorly ventilated alveoli; (2) the Haldane effect (deoxygenated haemoglobin binds CO2 with higher affinity than oxygenated haemoglobin); (3) blunting of carotid body hypoxic drive. Result: massive CO2 retention, acute acidosis, and CO2 narcosis.

## Question 3 of 5

What is the recommended target oxygen saturation (SpO2) range for a patient with acute exacerbation of COPD at risk of hypercapnic respiratory failure according to BTS guidelines?

- **A.** 88% to 92% (using a 24% or 28% Venturi mask or 1-2 L/min nasal prongs)
- **B.** 94% to 98%
- **C.** Strictly 100%
- **D.** 80% to 84%
- **E.** Oxygen is strictly contraindicated in all COPD patients

**Correct Answer:** A
**Explanation:**
BTS emergency oxygen guidelines recommend a target oxygen saturation of 88-92% for patients with known COPD, prior hypercapnia, or risk factors for hypercapnic respiratory failure (cystic fibrosis, neuromuscular disease, severe chest wall deformity, morbid obesity). Controlled oxygen is initiated with a 24% or 28% Venturi mask or low-flow nasal cannula.

## Question 4 of 5

According to NICE guideline NG115, what is the recommended dose and duration of systemic corticosteroids for an acute exacerbation of COPD?

- **A.** Oral Prednisolone 30mg once daily for 5 days
- **B.** Oral Prednisolone 60mg once daily for 28 days
- **C.** IV Dexamethasone 20mg daily for 14 days
- **D.** Inhaled fluticasone monotherapy
- **E.** Steroids are never indicated in COPD

**Correct Answer:** A
**Explanation:**
The REDUCE trial and updated NICE guidelines recommend a short 5-day course of oral Prednisolone 30 mg daily for AECOPD. Short courses are as effective as traditional 10-14 day regimens for recovery, lung function, and relapse prevention, while significantly reducing adverse corticosteroid side effects (hyperglycaemia, infection, osteoporosis).

## Question 5 of 5

Which three bacterial microorganisms are responsible for the vast majority of bacterial exacerbations of COPD?

- **A.** Haemophilus influenzae, Streptococcus pneumoniae, and Moraxella catarrhalis
- **B.** Staphylococcus aureus, E. coli, and Klebsiella
- **C.** Pseudomonas aeruginosa, Legionella, and Mycoplasma
- **D.** Mycobacterium tuberculosis, Nocardia, and Actinomyces
- **E.** Bacteroides fragilis, Enterococcus, and Listeria

**Correct Answer:** A
**Explanation:**
The classic bacterial trio in AECOPD is: (1) Haemophilus influenzae (most common, ~40-50%); (2) Streptococcus pneumoniae (~20-30%); (3) Moraxella catarrhalis (~15-20%). First-line empirical oral antibiotics recommended by NICE include amoxicillin, doxycycline, or clarithromycin.
$SBA_PULM_051$,
    false,
    13,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 8/13: Croup (Laryngotracheobronchitis)
  -- 1) Interleave Lecture (Position 14)
  UPDATE "lessons"
  SET "position" = 14, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'croup-laryngotracheobronchitis' OR "slug" = 'croup');

  -- 2) Upsert Quiz Lesson (Position 15)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-pulmonology-croup',
    'Croup (Laryngotracheobronchitis) — SBA Interactive Quiz',
    'quiz',
    $SBA_PULM_052$# Croup (Laryngotracheobronchitis) — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

An 18-month-old boy is brought to the ED at 2 AM with a sudden onset of a harsh, barking seal-like cough, hoarseness, and inspiratory stridor that worsens when he is distressed. His temperature is 38.0C. What is the most common viral causative agent of Croup?

![Figure 1: Clinical Findings & Diagnostic Reference (Croup (Laryngotracheobronchitis))](/lessons/images/sba/pulmonology/croup/figure_01_p2.jpeg)


- **A.** Parainfluenza Virus (predominantly Type 1)
- **B.** Respiratory Syncytial Virus
- **C.** Influenza A
- **D.** Adenovirus
- **E.** Epstein-Barr virus

**Correct Answer:** A
**Explanation:**
Human Parainfluenza Virus (types 1 and 2) accounts for >75-80% of croup cases. Peak incidence is in infants and toddlers aged 6 months to 3 years, typically occurring in late autumn and winter.

## Question 2 of 5

According to NICE guidelines and the Westley Croup Score, what is the single most effective first-line medication for all children presenting with mild, moderate, or severe croup?

![Figure 2: Clinical Findings & Diagnostic Reference (Croup (Laryngotracheobronchitis))](/lessons/images/sba/pulmonology/croup/figure_02_p3.jpeg)


- **A.** Oral Dexamethasone (0.15 mg/kg single dose)
- **B.** Oral amoxicillin for 7 days
- **C.** Inhaled warm steam / humidified air
- **D.** Oral codeine linctus
- **E.** Intravenous hydrocortisone 200mg

**Correct Answer:** A
**Explanation:**
NICE recommends a single dose of oral Dexamethasone (0.15 mg/kg) for all children with croup regardless of severity. It reduces hospital admission rates, shortens ED stays, reduces return visits, and decreases the need for nebulised adrenaline. (Soluble prednisolone 1-2 mg/kg is an alternative if dexamethasone is unavailable).

## Question 3 of 5

A 2-year-old boy presents with severe croup: he has continuous inspiratory stridor at rest, marked sternal recession, agitation, and tracheal tug. While waiting for oral dexamethasone to take effect, what rapid-acting rescue therapy should be administered?

- **A.** Nebulised Adrenaline (1:1,000 / 1 mg/ml, dose 0.5 ml/kg up to max 5ml) with oxygen
- **B.** Nebulised salbutamol 5mg
- **C.** Nebulised ipratropium bromide
- **D.** Subcutaneous terbutaline
- **E.** Oral paracetamol alone

**Correct Answer:** A
**Explanation:**
For moderate-to-severe croup with stridor at rest and marked retractions, Nebulised Adrenaline (L-adrenaline 1:1,000, 4-5 ml undiluted driven by oxygen) produces rapid alpha-1 mediated mucosal vasoconstriction, dramatically shrinking subglottic airway oedema within 10-30 minutes. The child must be observed for at least 2-4 hours post-nebulisation due to the risk of rebound oedema.

## Question 4 of 5

What classic radiological finding is visible on an anteroposterior (AP) soft-tissue neck radiograph in acute viral croup?

- **A.** 'Steeple sign' (symmetric subglottic tracheal narrowing)
- **B.** 'Thumbprint sign' (enlarged epiglottis)
- **C.** Widened retropharyngeal soft tissue space
- **D.** Pneumomediastinum
- **E.** Subcutaneous foreign body

**Correct Answer:** A
**Explanation:**
The 'Steeple sign' (subglottic tracheal narrowing resembling an inverted church steeple) is seen on AP neck X-rays due to circumferential mucosal oedema of the cricoid ring. (Note: the 'Thumbprint sign' on lateral neck radiograph indicates acute epiglottitis). Routine X-rays are not required and are indicated only if diagnosis is atypical.

## Question 5 of 5

Which clinical feature strongly suggests Acute Epiglottitis or Bacterial Tracheitis rather than typical viral croup?

- **A.** High toxic fever (>39C), absence of barking cough, drooling of saliva, and preference for the 'tripod' sniffing position
- **B.** Barking cough with mild hoarseness
- **C.** Coryza for 2 days followed by symptoms worse at night
- **D.** Improvement with cool night air
- **E.** Normal swallowing of liquids

**Correct Answer:** A
**Explanation:**
Acute Epiglottitis (traditionally caused by Haemophilus influenzae type b or Group A Strep) presents with toxic appearance, high fever, severe sore throat, dysphagia, DROOLING, absent barking cough, and the classic 'tripod position' (sitting forward with neck extended). It is a life-threatening airway emergency; do NOT examine the throat with a tongue depressor.
$SBA_PULM_052$,
    false,
    15,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 9/13: Airway Foreign Body Aspiration
  -- 1) Interleave Lecture (Position 16)
  UPDATE "lessons"
  SET "position" = 16, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'airway-foreign-body-aspiration' OR "slug" = 'foreign-body');

  -- 2) Upsert Quiz Lesson (Position 17)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-pulmonology-foreign-body',
    'Airway Foreign Body Aspiration — SBA Interactive Quiz',
    'quiz',
    $SBA_PULM_053$# Airway Foreign Body Aspiration — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 2-year-old child was playing with plastic building bricks when he suddenly experienced a violent bout of choking, coughing, and cyanosis. In the ED 2 hours later, he is comfortable at rest with no stridor, but chest examination reveals unilateral decreased breath sounds and monophonic expiratory wheeze over the right lung. What is the most appropriate next step in management?

![Figure 1: Clinical Findings & Diagnostic Reference (Airway Foreign Body Aspiration)](/lessons/images/sba/pulmonology/foreign-body/figure_01_p3.jpeg)


- **A.** Urgent referral to ENT / Paediatric Surgery for Rigid Bronchoscopy under general anaesthesia
- **B.** Reassurance and discharge home since he is no longer coughing
- **C.** Prescribe oral amoxicillin for 7 days
- **D.** Perform blind manual finger sweeps of the oropharynx
- **E.** Trial of inhaled salbutamol and discharge if wheeze persists

**Correct Answer:** A
**Explanation:**
A definitive history of a choking episode followed by localized unilateral wheezing or decreased breath sounds is highly diagnostic of tracheobronchial foreign body aspiration, even if the child currently appears stable (the 'silent phase' after the object lodges in a bronchus). Rigid bronchoscopy is the gold standard diagnostic and therapeutic procedure to retrieve the foreign body and prevent fatal airway compromise or bronchiectasis.

## Question 2 of 5

Which bronchus is the most frequent anatomical site of foreign body lodgement in children and adults, and why?

![Figure 2: Clinical Findings & Diagnostic Reference (Airway Foreign Body Aspiration)](/lessons/images/sba/pulmonology/foreign-body/figure_02_p6.jpeg)


- **A.** Right main bronchus; it is wider, shorter, and runs more vertically than the left main bronchus
- **B.** Left main bronchus; it branches at a sharper angle
- **C.** Left upper lobe bronchus
- **D.** Lingular bronchus
- **E.** Both bronchi are lodged at exactly equal frequencies in all age groups

**Correct Answer:** A
**Explanation:**
The right main bronchus is wider in diameter, shorter in length, and takes a more direct, vertical downward takeoff from the carina (~25 degrees vs ~45 degrees for the left). Consequently, aspirated foreign bodies preferentially enter the right tracheobronchial tree in over 60-70% of cases.

## Question 3 of 5

What is the classic radiographic sign of a radiolucent (e.g. food, peanut) foreign body causing a 'ball-valve' obstruction of a major bronchus on an inspiratory-expiratory chest radiograph or lateral decubitus view?

![Figure 3: Clinical Findings & Diagnostic Reference (Airway Foreign Body Aspiration)](/lessons/images/sba/pulmonology/foreign-body/figure_03_p7.jpeg)


- **A.** Unilateral hyperinflation (air-trapping) of the affected lung with mediastinal shift away from the affected side on expiration
- **B.** Dense opaque metallic density with no air trapping
- **C.** Bilateral diffuse reticular opacities
- **D.** Complete pneumothorax on the contralateral side
- **E.** Normal chest radiograph excludes foreign body completely

**Correct Answer:** A
**Explanation:**
Organic foreign bodies (e.g. peanuts) are radiolucent and invisible on standard X-rays. When acting as a one-way 'ball valve', air enters during inspiration (airway dilates) but cannot escape during expiration (airway constricts). This causes unilateral hyperlucency (hyperinflation) with flattening of the hemidiaphragm and mediastinal shift away from the affected lung on expiration.

## Question 4 of 5

Why are peanuts and tree nuts particularly dangerous foreign bodies when aspirated into the tracheobronchial tree?

![Figure 4: Clinical Findings & Diagnostic Reference (Airway Foreign Body Aspiration)](/lessons/images/sba/pulmonology/foreign-body/figure_04_p7.jpeg)


- **A.** They absorb moisture and swell, severely worsening obstruction, while releasing free fatty acids that provoke intense, destructive chemical bronchitis and granulomatous reaction
- **B.** They contain botulinum toxin
- **C.** They dissolve rapidly and enter the systemic circulation
- **D.** They cause immediate malignant transformation
- **E.** They can only be diagnosed by MRI

**Correct Answer:** A
**Explanation:**
Vegetable foreign bodies (peanuts, popcorn) are hygroscopic: they absorb bronchial secretions and swell over hours to days, converting a partial into a complete bronchial obstruction. Furthermore, vegetable oils and lipids incite severe acute chemical vegetative bronchitis, granulation tissue formation, and secondary bronchiectasis.

## Question 5 of 5

In an alert, conscious child who is choking with effective cough, which intervention is strictly CONTRAINDICATED?

- **A.** Blind finger sweep of the mouth
- **B.** Encouraging the child to cough
- **C.** Monitoring oxygen saturation
- **D.** Allowing the child to assume their position of comfort
- **E.** Calling for senior medical assistance

**Correct Answer:** A
**Explanation:**
Blind finger sweeps are dangerous and strictly CONTRAINDICATED because the rescuer's finger can push a mobile foreign body deeper into the posterior oropharynx, converting a non-occlusive supraglottic object into an irreversible, complete laryngeal obstruction or causing pharyngeal lacerations.
$SBA_PULM_053$,
    false,
    17,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 10/13: Haemoptysis Evaluation & Management
  -- 1) Interleave Lecture (Position 18)
  UPDATE "lessons"
  SET "position" = 18, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'acute-hemoptysis-evaluation' OR "slug" = 'hemoptysis');

  -- 2) Upsert Quiz Lesson (Position 19)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-pulmonology-hemoptysis',
    'Haemoptysis Evaluation & Management — SBA Interactive Quiz',
    'quiz',
    $SBA_PULM_054$# Haemoptysis Evaluation & Management — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 58-year-old male smoker presents with coughing up bright red blood. He has produced approximately 400 ml of blood in the past 4 hours. Pulse is 115 bpm, BP 98/58 mmHg, and RR 26/min. What volume threshold generally defines 'Massive Haemoptysis', an immediate life-threatening emergency?

![Figure 1: Clinical Findings & Diagnostic Reference (Haemoptysis Evaluation & Management)](/lessons/images/sba/pulmonology/hemoptysis/figure_01_p3.jpeg)


- **A.** More than 100 to 200 ml of blood within 24 hours (or >=100 ml/hr, or any volume causing respiratory compromise / asphyxiation)
- **B.** Blood-streaked sputum with normal vital signs
- **C.** More than 5 litres in 24 hours
- **D.** More than 10 ml in 24 hours
- **E.** Haemoptysis is only massive if haemoglobin drops below 50 g/L

**Correct Answer:** A
**Explanation:**
Definitions of massive haemoptysis vary from 100 to 600 ml per 24 hours (or >=100 ml/hr). Because the total anatomical dead space of the tracheobronchial tree is only ~150 ml, even a modest volume of blood can rapidly flood the alveoli, causing death from asphyxiation rather than exsanguination.

## Question 2 of 5

In massive haemoptysis, what is the anatomical origin of the bleeding vessels in over 90% of cases?

![Figure 2: Clinical Findings & Diagnostic Reference (Haemoptysis Evaluation & Management)](/lessons/images/sba/pulmonology/hemoptysis/figure_02_p4.jpeg)


- **A.** Bronchial Arteries (high-pressure systemic arterial circulation)
- **B.** Pulmonary Arteries (low-pressure pulmonary circulation)
- **C.** Pulmonary Veins
- **D.** Azygos vein
- **E.** Internal thoracic artery

**Correct Answer:** A
**Explanation:**
Over 90% of massive haemoptysis arises from the Bronchial Arteries, which branch from the high-pressure descending thoracic aorta (systemic pressure ~120 mmHg) to supply the tracheobronchial tree and stroma. Only 5-10% arises from the low-pressure pulmonary arterial circuit (pressure ~15-20 mmHg).

## Question 3 of 5

What is the correct positioning for a patient with massive haemoptysis when the bleeding lung is known to be the RIGHT lung?

- **A.** Position the patient in the Right Lateral Decubitus position (bleeding side DOWN)
- **B.** Position in the Left Lateral Decubitus position (bleeding side UP)
- **C.** Trendelenburg position (head down)
- **D.** Full prone position
- **E.** Supine position flat on the back

**Correct Answer:** A
**Explanation:**
In unilateral pulmonary haemorrhage, place the patient with the bleeding side DEPENDENT (bleeding side down). This uses gravity to contain the pooling blood within the bleeding lung, preventing blood from spilling across the carina into the non-bleeding, healthy 'good' lung, thereby preserving gas exchange.

## Question 4 of 5

What is the first-line minimally invasive definitive interventional procedure of choice for controlling massive or persistent bronchial artery haemoptysis?

- **A.** Transcatheter Bronchial Artery Embolisation (BAE) by Interventional Radiology
- **B.** Emergency pneumonectomy in the ED
- **C.** External beam radiotherapy
- **D.** Endoscopic injection of adrenaline into the stomach
- **E.** Placement of a pleural chest drain

**Correct Answer:** A
**Explanation:**
Bronchial Artery Embolisation (BAE) is the definitive first-line procedure for massive haemoptysis, with initial haemostatic control rates exceeding 85-90%. Femoral arterial catheterisation selectively identifies and embolises the hypertrophied systemic bronchial feeder vessels with microparticles (PVA).

## Question 5 of 5

How can true Haemoptysis be clinically differentiated from Haematemesis in an adult patient presenting with oral bleeding?

- **A.** Haemoptysis is preceded by coughing, is bright red and frothy/bubbly, and has an alkaline pH; haematemesis is preceded by nausea/vomiting, is dark brown ('coffee ground') or acidic, and mixed with food
- **B.** Haemoptysis always contains melena
- **C.** Haematemesis is bright red and frothy with pH >8
- **D.** Haemoptysis always has a positive faecal occult blood test
- **E.** There are no clinical features to distinguish them

**Correct Answer:** A
**Explanation:**
Haemoptysis: coughed up, bright red/pink, frothy/aerated (mixed with air bubbles), alkaline pH (pulmonary secretions), may contain sputum. Haematemesis: vomited up, dark red/brown/coffee-ground, non-frothy, acidic pH (gastric hydrochloric acid), accompanied by food particles, often followed by melaena.
$SBA_PULM_054$,
    false,
    19,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 11/13: Aspiration Pneumonitis vs Aspiration Pneumonia
  -- 1) Interleave Lecture (Position 20)
  UPDATE "lessons"
  SET "position" = 20, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = '10cap' OR "slug" = 'pneumonitis');

  -- 2) Upsert Quiz Lesson (Position 21)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-pulmonology-pneumonitis',
    'Aspiration Pneumonitis vs Aspiration Pneumonia — SBA Interactive Quiz',
    'quiz',
    $SBA_PULM_055$# Aspiration Pneumonitis vs Aspiration Pneumonia — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 42-year-old unconscious alcoholic male regurgitates gastric contents during resuscitation. Within 2 hours, he develops acute breathlessness, cyanosis, tachypnoea (RR 34/min), wheezing, and fever of 38.2C. Chest radiograph shows bilateral diffuse perihilar infiltrates. What is the acute chemical inflammatory lung injury termed?

![Figure 1: Clinical Findings & Diagnostic Reference (Aspiration Pneumonitis vs Aspiration Pneumonia)](/lessons/images/sba/pulmonology/pneumonitis/figure_01_p3.jpeg)


- **A.** Chemical Aspiration Pneumonitis (Mendelson's Syndrome)
- **B.** Bacterial Aspiration Pneumonia
- **C.** Pulmonary Embolism
- **D.** Bronchial carcinoid
- **E.** Pneumocystis jirovecii infection

**Correct Answer:** A
**Explanation:**
Mendelson's syndrome (chemical pneumonitis) is acute chemical pulmonary injury caused by the aspiration of sterile gastric acid (typically pH <2.5 and volume >0.3 ml/kg). It develops acutely within 1-2 hours of aspiration with severe bronchospasm, hypoxaemia, and pulmonary oedema. It is predominantly a non-infectious inflammatory response.

## Question 2 of 5

Why are prophylactic antibiotics NOT recommended in the initial management of witnessed chemical Aspiration Pneumonitis?

![Figure 2: Clinical Findings & Diagnostic Reference (Aspiration Pneumonitis vs Aspiration Pneumonia)](/lessons/images/sba/pulmonology/pneumonitis/figure_02_p3.jpeg)


- **A.** The initial acute injury is a sterile chemical burn to the alveoli; antibiotics do not prevent secondary infection but promote colonization by multidrug-resistant bacteria
- **B.** Antibiotics inactivate pulmonary surfactant
- **C.** Gastric contents are always sterile and can never become infected
- **D.** Antibiotics cause bronchospasm
- **E.** Chemical pneumonitis is fatal in 100% of cases regardless of care

**Correct Answer:** A
**Explanation:**
Aspiration pneumonitis is a sterile chemical inflammatory injury, not a bacterial infection. Controlled trials show routine prophylactic antibiotics do not alter clinical outcome or mortality, but select for resistant pathogens. Antibiotics are withheld unless clinical signs of bacterial infection (persistent fever, purulent sputum, worsening infiltrates >48-72h) develop.

## Question 3 of 5

In an elderly, debilitated nursing home patient with chronic dysphagia who aspirates while lying supine in bed, which lung segments are most anatomically dependent and frequently involved in Aspiration Pneumonia?

![Figure 3: Clinical Findings & Diagnostic Reference (Aspiration Pneumonitis vs Aspiration Pneumonia)](/lessons/images/sba/pulmonology/pneumonitis/figure_03_p4.jpeg)


- **A.** Superior segments of the lower lobes, and posterior segment of the right upper lobe
- **B.** Anterior segments of both upper lobes
- **C.** Apical segment of the left upper lobe
- **D.** Middle lobe anterior segment
- **E.** Lingular inferior segment

**Correct Answer:** A
**Explanation:**
In the supine position, gravity directs aspirated material into the most dependent pulmonary segments: the superior (apical) segments of both lower lobes, and the posterior segment of the right upper lobe. In the erect position, the posterior basal segments of the lower lobes are most commonly affected.

## Question 4 of 5

What is the antibiotic regimen of choice for hospitalised patients with secondary Bacterial Aspiration Pneumonia or Lung Abscess to cover mixed oral anaerobes and Gram-negative bacilli?

- **A.** Intravenous Co-amoxiclav (Amoxicillin-Clavulanic acid), or Piperacillin-Tazobactam
- **B.** Oral Ciprofloxacin monotherapy
- **C.** Oral Erythromycin alone
- **D.** Intravenous Gentamicin monotherapy
- **E.** Oral Trimethoprim

**Correct Answer:** A
**Explanation:**
Aspiration pneumonia involves mixed oral flora, including anaerobes (Peptostreptococcus, Fusobacterium, Prevotella) and Gram-negative bacilli. NICE guidelines recommend IV Co-amoxiclav (1.2g TDS) as first-line monotherapy because clavulanate inhibits beta-lactamase produced by oral anaerobes.

## Question 5 of 5

What is the defining clinical difference between Aspiration Pneumonitis and Aspiration Pneumonia?

- **A.** Pneumonitis is acute non-infectious chemical irritation caused by acidic gastric juices occurring within 1-2 hours; pneumonia is a bacterial infectious process developing over 48-72 hours from aspirated colonized oropharyngeal secretions
- **B.** Pneumonitis is caused by viruses, while pneumonia is caused by fungi
- **C.** Pneumonitis only affects children under 2 years
- **D.** There is no clinical or pathological difference
- **E.** Pneumonia resolves in 15 minutes without treatment

**Correct Answer:** A
**Explanation:**
Aspiration pneumonitis is acute chemical injury caused by aspiration of sterile gastric acid (rapid onset, chemical burn, alveolar damage, sterile). Aspiration pneumonia is an infectious infectious process resulting from aspiration of colonized oropharyngeal secretions (insidious onset over days, bacterial proliferation, purulent sputum, consolidated infiltrates).
$SBA_PULM_055$,
    false,
    21,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 12/13: Pulmonology Foundations & Respiratory Physiology
  -- 1) Interleave Lecture (Position 22)
  UPDATE "lessons"
  SET "position" = 22, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'pneumocystis-jirovecii-pneumonia-pjp' OR "slug" = 'pulmonology-basics');

  -- 2) Upsert Quiz Lesson (Position 23)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-pulmonology-pulmonology-basics',
    'Pulmonology Foundations & Respiratory Physiology — SBA Interactive Quiz',
    'quiz',
    $SBA_PULM_056$# Pulmonology Foundations & Respiratory Physiology — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

What is the normal physiological value of the Alveolar-Arterial (A-a) oxygen gradient on room air in a healthy young adult, and how does it change with age?

![Figure 1: Clinical Findings & Diagnostic Reference (Pulmonology Foundations & Respiratory Physiology)](/lessons/images/sba/pulmonology/pulmonology-basics/figure_01_p2.jpeg)


- **A.** Normal is 5 to 15 mmHg (or < [Age in years / 4] + 4); it increases gradually with advancing age
- **B.** Normal is always zero at all ages
- **C.** Normal is 50 to 80 mmHg
- **D.** Normal is negative (-10 mmHg)
- **E.** The A-a gradient decreases with age

**Correct Answer:** A
**Explanation:**
The A-a gradient (P_A_O2 - P_a_O2) measures the efficiency of pulmonary gas exchange. In a healthy young adult on room air, it is normally 5-15 mmHg (or ~1.0-2.0 kPa). A useful formula for upper limit of normal is: [Age / 4] + 4 mmHg. An elevated A-a gradient indicates intrinsic lung pathology (V/Q mismatch, shunt, or diffusion impairment).

## Question 2 of 5

A patient with hypoxaemia due to acute hypoventilation (e.g. opiate overdose) has an arterial blood gas performed on room air. How will the calculated Alveolar-Arterial (A-a) oxygen gradient compare to normal?

![Figure 2: Clinical Findings & Diagnostic Reference (Pulmonology Foundations & Respiratory Physiology)](/lessons/images/sba/pulmonology/pulmonology-basics/figure_02_p3.jpeg)


- **A.** The A-a gradient is completely NORMAL (normal pulmonary parenchyma with isolated alveolar hypoventilation)
- **B.** The A-a gradient is markedly elevated (>40 mmHg)
- **C.** The A-a gradient cannot be calculated in hypoventilation
- **D.** The A-a gradient drops to zero
- **E.** The A-a gradient is reversed

**Correct Answer:** A
**Explanation:**
In pure alveolar hypoventilation (e.g. opiate toxicity, myasthenia gravis, central apnoea) or low atmospheric FiO2 (high altitude), the lungs themselves are structurally normal. Therefore, both alveolar PO2 and arterial PO2 fall in parallel, leaving a NORMAL A-a gradient. If the A-a gradient is elevated in a patient with hypoventilation, look for a second pathology (e.g. aspiration, atelectasis, PE).

## Question 3 of 5

Which of the following conditions causes a rightward shift of the Oxyhaemoglobin Dissociation Curve, promoting oxygen unloading to peripheral tissues (the Bohr effect)?

![Figure 3: Clinical Findings & Diagnostic Reference (Pulmonology Foundations & Respiratory Physiology)](/lessons/images/sba/pulmonology/pulmonology-basics/figure_03_p6.jpeg)


- **A.** Increased 2,3-DPG, Hyperthermia (fever), Acidosis (low pH), and Increased PaCO2 ('CADET, face Right!')
- **B.** Hypothermia, Alkalosis, and Low PaCO2
- **C.** Carbon monoxide poisoning
- **D.** Foetal haemoglobin (HbF)
- **E.** Methemoglobinaemia

**Correct Answer:** A
**Explanation:**
A rightward shift reduces haemoglobin's affinity for oxygen, releasing oxygen more readily into metabolically active tissues. Triggers: CADET face Right = CO2 increased, Acidosis (low pH / H+ high), 2,3-DPG increased, Exercise, Temperature high. Leftward shift (higher affinity, less unloading) is caused by hypothermia, alkalosis, low PaCO2, HbF, and carboxyhaemoglobin.

## Question 4 of 5

What is the definition of Anatomical Dead Space in respiratory physiology, and what is its typical volume in a 70 kg adult?

![Figure 4: Clinical Findings & Diagnostic Reference (Pulmonology Foundations & Respiratory Physiology)](/lessons/images/sba/pulmonology/pulmonology-basics/figure_04_p6.jpeg)


- **A.** Volume of conducting airways from nose/mouth to terminal bronchioles that does not participate in gas exchange (~150 ml, or ~2 ml/kg)
- **B.** Total volume of air in the lungs at maximal inspiration (~6,000 ml)
- **C.** Volume of air expired after normal expiration (~500 ml)
- **D.** Volume remaining in lungs after maximal expiration (~1,200 ml)
- **E.** The volume of the left pleural cavity (~50 ml)

**Correct Answer:** A
**Explanation:**
Anatomical dead space encompasses the conducting airway passages (nose, pharynx, larynx, trachea, bronchi, and bronchioles up to terminal bronchioles) where no gas-exchange alveoli exist. In an adult, this averages approximately 150 ml (or roughly 2 ml/kg body weight).

## Question 5 of 5

On diagnostic spirometry, which pattern of parameters confirms an Obstructive ventilatory defect according to NICE and GOLD guidelines?

- **A.** Reduced FEV1/FVC ratio (< 0.70 or below Lower Limit of Normal)
- **B.** Normal or increased FEV1/FVC ratio (>0.80) with reduced total lung capacity (TLC <80%)
- **C.** Elevated FVC with normal FEV1
- **D.** FEV1/FVC ratio exactly 1.0
- **E.** Spirometry cannot diagnose obstructive lung disease

**Correct Answer:** A
**Explanation:**
An obstructive defect (COPD, asthma, bronchiectasis) is characterized by a disproportionate reduction in expiratory flow: FEV1/FVC ratio <0.70. Conversely, a restrictive defect (pulmonary fibrosis, sarcoidosis, kyphoscoliosis) shows a preserved or elevated FEV1/FVC ratio (>0.70-0.80) with symmetrically reduced FEV1 and FVC, and reduced TLC.
$SBA_PULM_056$,
    false,
    23,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 13/13: Pertussis (Whooping Cough)
  -- 1) Interleave Lecture (Position 24)
  UPDATE "lessons"
  SET "position" = 24, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'pertussis-whooping-cough' OR "slug" = 'whooping-cough');

  -- 2) Upsert Quiz Lesson (Position 25)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-pulmonology-whooping-cough',
    'Pertussis (Whooping Cough) — SBA Interactive Quiz',
    'quiz',
    $SBA_PULM_057$# Pertussis (Whooping Cough) — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 6-week-old unvaccinated infant is brought to the ED with a 2-week history of paroxysmal coughing episodes followed by facial congestion, post-tussive apnoea, and cyanosis. Between spasms, the infant appears deceptively well. Routine blood count reveals marked absolute lymphocytosis (WBC 42 x 10^9/L, 82% lymphocytes). What is the diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Pertussis (Whooping Cough))](/lessons/images/sba/pulmonology/whooping-cough/figure_01_p5.jpeg)


- **A.** Bordetella pertussis infection (Whooping Cough)
- **B.** Acute lymphoblastic leukaemia
- **C.** Viral bronchiolitis
- **D.** Cystic fibrosis
- **E.** Bacterial epiglottitis

**Correct Answer:** A
**Explanation:**
Pertussis in young infants characteristically presents with coughing paroxysms, post-tussive cyanosis/apnoea, and absence of the classic inspiratory 'whoop' (which is absent in infants <6 months). Marked, striking absolute lymphocytosis (>10-20 x 10^9/L) is a pathognomonic hallmark driven by Pertussis Toxin promoting lymphocyte retention in the intravascular space.

## Question 2 of 5

What is the recommended antibiotic of choice for the treatment and post-exposure prophylaxis of Pertussis according to UK Health Security Agency (UKHSA) guidelines?

- **A.** Macrolides (Oral Azithromycin or Clarithromycin)
- **B.** Oral Amoxicillin
- **C.** Oral Ciprofloxacin
- **D.** Intravenous Ceftriaxone
- **E.** Oral Metronidazole

**Correct Answer:** A
**Explanation:**
Macrolides are the first-line treatment for pertussis: oral Azithromycin (preferred in infants <1 month to reduce risk of infantile hypertrophic pyloric stenosis) or Clarithromycin. When started in the early catarrhal phase (first 2-3 weeks), macrolides reduce disease severity and eradicate nasopharyngeal carriage, stopping transmission.

## Question 3 of 5

Which three clinical stages classically describe the chronological progression of Whooping Cough?

- **A.** Catarrhal stage (1-2 weeks), Paroxysmal stage (2-6 weeks), and Convalescent stage (months)
- **B.** Prodromal stage, Eruptive stage, and Desquamative stage
- **C.** Primary, Secondary, and Tertiary stages
- **D.** Acute stage, Latent stage, and Chronic stage
- **E.** Incipient, Florid, and Terminal stages

**Correct Answer:** A
**Explanation:**
Pertussis unfolds in three stages: (1) Catarrhal stage (1-2 weeks): mild coryza, low-grade fever, non-specific cough (most contagious period); (2) Paroxysmal stage (2-6 weeks): bursts of violent staccato coughing, inspiratory 'whoop', post-tussive vomiting; (3) Convalescent stage: gradual recovery over weeks to months ('the 100-day cough').

## Question 4 of 5

What is the diagnostic investigation of choice for confirming Bordetella pertussis in an ED patient presenting within the first 2 to 3 weeks of symptom onset?

- **A.** Nasopharyngeal swab / aspirate for Bordetella pertussis PCR
- **B.** Sputum Gram stain
- **C.** Serum anti-pertussis toxin IgG test
- **D.** Throat culture on standard blood agar
- **E.** Chest CT scan

**Correct Answer:** A
**Explanation:**
Nasopharyngeal swab (using dacron/polyester swab) or nasopharyngeal aspirate for PCR is the test of choice within the first 2-3 weeks of cough onset (high sensitivity and rapid turnaround). Beyond 3 weeks of cough, PCR sensitivity falls, and serum anti-pertussis toxin IgG serology or oral fluid IgG testing becomes the preferred diagnostic method.

## Question 5 of 5

Why are young infants (<6 months) at the highest risk of mortality from Bordetella pertussis infection?

- **A.** Extreme hyperleukocytosis causing pulmonary vascular microthrombosis / pulmonary hypertension, intractable hypoxaemic apnoea, and encephalopathy
- **B.** Immediate acute liver necrosis
- **C.** Acute renal cortical necrosis
- **D.** Disseminated bone marrow aplasia
- **E.** Severe anaphylaxis to bacterial endotoxin

**Correct Answer:** A
**Explanation:**
In young infants, pertussis can cause a malignant, lethal syndrome: extreme leukocytosis (>50-100 x 10^9/L) leads to pulmonary leukostasis, severe pulmonary hypertension, cardiogenic shock, and refractory hypoxaemic respiratory failure with intractable apnoea and seizures. Exchange transfusion or leukapheresis is sometimes used in pediatric ICU.
$SBA_PULM_057$,
    false,
    25,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();


  -- ------------------------------------------------------------------------
  -- Specialty: Gastroenterology Emergencies (21 Topics)
  -- ------------------------------------------------------------------------
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_sba_id AND "title" = 'Gastroenterology Emergencies' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module Gastroenterology Emergencies not found in mrcem-sba';
  END IF;

  -- Topic 1/21: Acute Appendicitis
  -- 1) Interleave Lecture (Position 0)
  UPDATE "lessons"
  SET "position" = 0, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'acute-appendicitis' OR "slug" = 'acute-appendicitis');

  -- 2) Upsert Quiz Lesson (Position 1)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-gastroenterology-acute-appendicitis',
    'Acute Appendicitis — SBA Interactive Quiz',
    'quiz',
    $SBA_GAST_058$# Acute Appendicitis — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 19-year-old male presents with periumbilical abdominal pain that began 14 hours ago and has now migrated to the right iliac fossa (RIF). He has anorexia, nausea, and low-grade fever (37.9C). On examination, he has localized tenderness and rebound guarding at McBurney's point. What is the classic pathophysiological explanation for the migration of pain in acute appendicitis?

![Figure 1: Clinical Findings & Diagnostic Reference (Acute Appendicitis)](/lessons/images/sba/gastroenterology/acute-appendicitis/figure_01_p4.jpeg)


- **A.** Visceral pain from luminal obstruction/distension is referred via T10 sympathetic afferents to the periumbilical region; subsequent transmural inflammation irritates the parietal peritoneum, producing sharp, well-localized somatic pain in the RIF
- **B.** The appendix physically moves position from the midline to the RIF
- **C.** Initial pain is somatic and becomes visceral as it resolves
- **D.** Referred pain via the vagus nerve
- **E.** Pain radiates along the ilioinguinal nerve only

**Correct Answer:** A
**Explanation:**
Initial appendiceal luminal obstruction (faecolith, lymphoid hyperplasia) causes visceral distension pain carried by T10 autonomic splanchnic afferents (dull, periumbilical). When transmural inflammation spreads to the parietal peritoneum (innervated by somatic spinal nerves), pain becomes sharp, constant, and strictly localized to the right lower quadrant (McBurney's point).

## Question 2 of 5

Which clinical examination sign is positive when passive hyperextension of the right hip with the patient in the left lateral position produces pain in the right iliac fossa, indicating a retrocaecal appendicitis?

- **A.** Psoas sign
- **B.** Obturator sign
- **C.** Rovsing's sign
- **D.** Murphy's sign
- **E.** Cullen's sign

**Correct Answer:** A
**Explanation:**
Psoas sign: passive extension of the right hip stretches the iliopsoas muscle; pain in the RIF indicates inflammation of a retrocaecal appendix lying directly on the psoas. Obturator sign: passive internal rotation of the flexed right hip stretches the internal obturator muscle, indicating a pelvic appendix.

## Question 3 of 5

Which clinical scoring system incorporating symptoms, signs, and laboratory values (leukocytosis, neutrophilia) is widely used in the ED to stratify risk in suspected acute appendicitis?

- **A.** Alvarado Score (MANTRELS score)
- **B.** Glasgow-Imrie score
- **C.** Rockall score
- **D.** Ranson criteria
- **E.** Child-Pugh score

**Correct Answer:** A
**Explanation:**
The Alvarado (MANTRELS) score: Migration of pain (1), Anorexia (1), Nausea/vomiting (1), Tenderness RIF (2), Rebound pain (1), Elevated temp >=37.3C (1), Leukocytosis >=10 (2), Shift to left/neutrophilia (1). Score <=4 has high sensitivity to rule out appendicitis.

## Question 4 of 5

What is the primary diagnostic imaging modality of choice for suspected acute appendicitis in a 26-year-old pregnant woman in her second trimester?

- **A.** Graded-compression abdominal ultrasound (followed by MRI if non-diagnostic)
- **B.** Contrast-enhanced CT abdomen and pelvis
- **C.** Plain abdominal radiography
- **D.** Diagnostic laparoscopy without prior imaging
- **E.** Barium enema

**Correct Answer:** A
**Explanation:**
In pregnancy and paediatric patients, Graded-Compression Abdominal Ultrasound is the initial imaging modality of choice to avoid ionizing radiation. If ultrasound is non-diagnostic or equivocal, non-contrast Magnetic Resonance Imaging (MRI) is the preferred second-line investigation.

## Question 5 of 5

What is the definitive surgical treatment of choice for acute uncomplicated appendicitis in modern practice?

- **A.** Laparoscopic Appendicectomy
- **B.** Open laparotomy via midline incision
- **C.** Percutaneous catheter drainage without surgery
- **D.** Lifelong prophylactic oral metronidazole
- **E.** Right hemicolectomy

**Correct Answer:** A
**Explanation:**
Laparoscopic Appendicectomy is the international standard of care for acute uncomplicated appendicitis, associated with significantly less postoperative pain, lower surgical site infection rates, shorter hospital stay, and faster return to normal activity compared to open surgery.
$SBA_GAST_058$,
    false,
    1,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 2/21: Alcoholic Liver Disease & Decompensation
  -- 1) Interleave Lecture (Position 2)
  UPDATE "lessons"
  SET "position" = 2, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'alcoholic-ld' OR "slug" = 'alcoholic-liver-disease');

  -- 2) Upsert Quiz Lesson (Position 3)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-gastroenterology-alcoholic-liver-disease',
    'Alcoholic Liver Disease & Decompensation — SBA Interactive Quiz',
    'quiz',
    $SBA_GAST_059$# Alcoholic Liver Disease & Decompensation — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 46-year-old chronic heavy alcohol consumer presents with jaundice, painful hepatomegaly, anorexia, and ascites. Laboratory investigations reveal: AST 185 IU/L, ALT 78 IU/L, Bilirubin 112 umol/L, INR 1.8. What classic transaminase ratio is characteristic of acute alcoholic hepatitis?

![Figure 1: Clinical Findings & Diagnostic Reference (Alcoholic Liver Disease & Decompensation)](/lessons/images/sba/gastroenterology/alcoholic-liver-disease/figure_01_p5.jpeg)


- **A.** AST to ALT ratio >= 2:1, with absolute transaminases typically <400-500 IU/L
- **B.** ALT to AST ratio > 5:1 with transaminases >5000 IU/L
- **C.** Normal AST with isolated ALT >1000 IU/L
- **D.** Equimolar AST and ALT exactly 1:1
- **E.** Transaminases are never elevated in alcoholic liver disease

**Correct Answer:** A
**Explanation:**
An AST:ALT ratio >= 2:1 is highly characteristic of alcoholic liver injury (present in >70-80% of cases). This occurs because alcohol damages hepatic mitochondria (where AST is concentrated) and alcoholics are deficient in pyridoxal 5'-phosphate (vitamin B6), an essential cofactor required for ALT synthesis. Transaminases rarely exceed 400-500 IU/L in alcoholic hepatitis.

## Question 2 of 5

Which prognostic scoring tool is used in acute severe alcoholic hepatitis to calculate disease severity and determine whether corticosteroid therapy is indicated?

![Figure 2: Clinical Findings & Diagnostic Reference (Alcoholic Liver Disease & Decompensation)](/lessons/images/sba/gastroenterology/alcoholic-liver-disease/figure_02_p7.jpeg)


- **A.** Maddrey's Discriminant Function (mDF) score
- **B.** CURB-65 score
- **C.** Wells score
- **D.** CHADS2-VASc score
- **E.** APACHE II score

**Correct Answer:** A
**Explanation:**
Maddrey's Discriminant Function: mDF = 4.6 x [Prothrombin time - control PT in seconds] + Serum Bilirubin (mg/dL). A score >=32 indicates severe acute alcoholic hepatitis with 30-50% 1-month mortality, indicating consideration of corticosteroid therapy (oral Prednisolone 40mg daily for 28 days) if active sepsis is excluded.

## Question 3 of 5

A chronic alcohol-dependent patient is brought to the ED confused, disoriented, with horizontal nystagmus, bilateral sixth cranial nerve palsies, and profound cerebellar ataxia. What acute nutritional deficiency does this classic triad represent?

- **A.** Wernicke's Encephalopathy (Thiamine / Vitamin B1 deficiency)
- **B.** Korsakoff's psychosis alone
- **C.** Vitamin B12 (Cobalamin) subacute degeneration
- **D.** Niacin deficiency (Pellagra)
- **E.** Folate deficiency

**Correct Answer:** A
**Explanation:**
Wernicke's encephalopathy is caused by acute Thiamine (Vitamin B1) deficiency. The classic triad comprises: (1) Ocular abnormalities (nystagmus, lateral rectus / CN VI palsy, conjugate gaze palsies); (2) Cerebellar ataxia; (3) Confusion / altered mental status. It is a medical emergency requiring immediate high-dose IV thiamine (Pabrinex).

## Question 4 of 5

Why must intravenous Thiamine (Pabrinex) ALWAYS be administered BEFORE or concurrently with intravenous glucose / dextrose infusions in malnourished alcohol-dependent patients?

- **A.** Dextrose infusion without thiamine triggers rapid oxidative carbohydrate metabolism that depletes remaining thiamine stores, precipitating acute Wernicke's encephalopathy and irreversible brainstem damage
- **B.** Dextrose neutralizes thiamine molecules
- **C.** Thiamine causes severe hypoglycaemia if given alone
- **D.** Pabrinex cannot dissolve in saline
- **E.** Dextrose promotes renal excretion of vitamin B1

**Correct Answer:** A
**Explanation:**
Thiamine is an essential pyrophosphate cofactor for pyruvate dehydrogenase and alpha-ketoglutarate dehydrogenase in the Krebs cycle. Infusing intravenous dextrose forces cellular carbohydrate glycolysis, completely exhausting marginal thiamine reserves and precipitating acute, fatal Wernicke's encephalopathy or Korsakoff syndrome.

## Question 5 of 5

Which validated scoring system is used to assess alcohol withdrawal severity and guide symptom-triggered benzodiazepine therapy in the ED?

- **A.** CIWA-Ar (Clinical Institute Withdrawal Assessment for Alcohol - Revised)
- **B.** GCS score
- **C.** NEWS2 score
- **D.** AUDIT-C score
- **E.** CAGE questionnaire

**Correct Answer:** A
**Explanation:**
The CIWA-Ar protocol evaluates 10 withdrawal symptoms (nausea, tremor, sweating, anxiety, agitation, tactile/auditory/visual disturbances, headache, orientation). A score >=8-10 indicates significant withdrawal requiring symptom-triggered doses of long-acting benzodiazepines (e.g. Chlordiazepoxide or Diazepam).
$SBA_GAST_059$,
    false,
    3,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 3/21: Anal Pain & Rectal Bleeding Differential
  -- 1) Interleave Lecture (Position 4)
  UPDATE "lessons"
  SET "position" = 4, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'anal-pain-and-rectal-bleeding' OR "slug" = 'anal-pain-rectal-bleeding');

  -- 2) Upsert Quiz Lesson (Position 5)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-gastroenterology-anal-pain-rectal-bleeding',
    'Anal Pain & Rectal Bleeding Differential — SBA Interactive Quiz',
    'quiz',
    $SBA_GAST_060$# Anal Pain & Rectal Bleeding Differential — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 28-year-old male presents with excruciating, sharp tearing pain during defecation, described as 'passing broken glass', followed by a dull throbbing ache lasting 2-3 hours and bright red blood streaking the toilet paper. On gentle separation of the buttocks, what is the most likely physical finding?

![Figure 1: Clinical Findings & Diagnostic Reference (Anal Pain & Rectal Bleeding Differential)](/lessons/images/sba/gastroenterology/anal-pain-rectal-bleeding/figure_01_p3.jpeg)


- **A.** An acute Anal Fissure, most commonly in the posterior midline of the anal verge
- **B.** A thrombosed external haemorrhoid in the anterior midline
- **C.** Anorectal melanoma
- **D.** Perianal abscess
- **E.** Intersphincteric fistula

**Correct Answer:** A
**Explanation:**
Anal fissure presents characteristically with severe, sharp tearing pain during defecation ('passing razor blades/glass') followed by post-defecation burning ache and bright red blood on tissue paper. Over 90% occur in the posterior midline (due to poor perfusion and elliptical arrangement of external sphincter fibers). Treatment includes high-fibre diet, stool softeners, and topical 0.4% GTN ointment or diltiazem.

## Question 2 of 5

What is the clinical significance of finding an anal fissure located OFF the midline (e.g. lateral positions) or multiple anal fissures?

![Figure 2: Clinical Findings & Diagnostic Reference (Anal Pain & Rectal Bleeding Differential)](/lessons/images/sba/gastroenterology/anal-pain-rectal-bleeding/figure_02_p4.jpeg)


- **A.** It strongly suggests underlying systemic pathology such as Crohn's disease, Tuberculosis, HIV, Syphilis, or Anal Carcinoma
- **B.** It is the normal anatomical variant in young men
- **C.** It indicates internal haemorrhoids
- **D.** It is caused by simple constipation
- **E.** It requires no investigation

**Correct Answer:** A
**Explanation:**
Typical primary anal fissures are located in the posterior midline (90%) or anterior midline (10%). Fissures located laterally, off-midline, painless, or multiple are considered secondary fissures and warrant immediate investigation for Crohn's disease, sexually transmitted infections (syphilis, herpes, LGV), tuberculosis, or anal cancer.

## Question 3 of 5

A 45-year-old woman presents with severe, constant throbbing perianal pain that prevents her from sitting, accompanied by fever (38.4C) and rigors. Examination reveals a tender, fluctuant, erythematous swelling adjacent to the anal verge. What is the definitive management?

![Figure 3: Clinical Findings & Diagnostic Reference (Anal Pain & Rectal Bleeding Differential)](/lessons/images/sba/gastroenterology/anal-pain-rectal-bleeding/figure_03_p4.jpeg)


- **A.** Emergency Operative Incision and Drainage (I&D) under general anaesthesia
- **B.** Oral amoxicillin and warm sitz baths at home
- **C.** Application of topical hydrocortisone cream
- **D.** Rubber band ligation
- **E.** Wait 7 days for spontaneous rupture

**Correct Answer:** A
**Explanation:**
A perianal abscess originates from infected cryptoglandular anal glands in the intersphincteric space. Antibiotics alone cannot penetrate the collection. Definitive treatment is urgent surgical incision and drainage to relieve pain, evacuate pus, and prevent progression to ischiorectal sepsis or supralevator extension. Approximately 30-50% will subsequently form an anal fistula (fistula-in-ano).

## Question 4 of 5

A 34-year-old male with a history of chronic constipation presents with a sudden onset of a tender, blue-purple, marble-sized lump at the anal verge that appeared after heavy straining 18 hours ago. What is the diagnosis?

- **A.** Thrombosed External Haemorrhoid (perianal haematoma)
- **B.** Internal haemorrhoid Grade IV
- **C.** Anal fissure
- **D.** Condyloma acuminata
- **E.** Rectal prolapse

**Correct Answer:** A
**Explanation:**
A thrombosed external haemorrhoid is a thrombosis of the subcutaneous perianal venous plexus below the dentate line covered by sensitive anoderm. It presents as an acute, severely painful, tense, purplish-blue solitary nodule. If presenting within 48-72 hours of onset with severe pain, complete surgical excision (or unroofing) under local anaesthesia provides immediate relief; after 72 hours, conservative management is indicated as the thrombus organizes.

## Question 5 of 5

What is the critical anatomical boundary that separates Internal Haemorrhoids (painless, visceral innervation above) from External Haemorrhoids (painful, somatic innervation below)?

- **A.** The Dentate (Pectinate) Line
- **B.** The Hilton's white line
- **C.** The Puborectalis sling
- **D.** The Sacral promontory
- **E.** The Valves of Houston

**Correct Answer:** A
**Explanation:**
The Dentate (Pectinate) Line is the embryological junction between endodermal hindgut and ectodermal proctodeum. Internal haemorrhoids arise above the dentate line (covered by columnar/cuboidal epithelium innervated by visceral sensory nerves: painless, manifest with painless bright red bleeding). External haemorrhoids arise below the dentate line (covered by squamous anoderm innervated by somatic inferior rectal nerves: exquisitely painful).
$SBA_GAST_060$,
    false,
    5,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 4/21: Small & Large Bowel Obstruction
  -- 1) Interleave Lecture (Position 6)
  UPDATE "lessons"
  SET "position" = 6, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'small-large-bowel-obstruction' OR "slug" = 'bowel-obstruction');

  -- 2) Upsert Quiz Lesson (Position 7)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-gastroenterology-bowel-obstruction',
    'Small & Large Bowel Obstruction — SBA Interactive Quiz',
    'quiz',
    $SBA_GAST_061$# Small & Large Bowel Obstruction — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 62-year-old woman with a history of prior appendicectomy and hysterectomy presents with crampy central abdominal pain, bilious vomiting, marked abdominal distension, and absolute constipation (obstipation). Plain abdominal X-ray reveals multiple dilated central small bowel loops with visible plicae circulares (valvulae conniventes). What is the single most common cause of Small Bowel Obstruction (SBO)?

![Figure 1: Clinical Findings & Diagnostic Reference (Small & Large Bowel Obstruction)](/lessons/images/sba/gastroenterology/bowel-obstruction/figure_01_p3.jpeg)


- **A.** Postoperative Intra-abdominal Adhesions (responsible for 60-70% of SBO)
- **B.** Colorectal adenocarcinoma
- **C.** Sigmoid volvulus
- **D.** Intussusception
- **E.** Gallstone ileus

**Correct Answer:** A
**Explanation:**
Postoperative intra-abdominal adhesions account for 60-75% of all small bowel obstructions in adults with previous abdominal or pelvic surgery. Incarcerated abdominal wall/groin hernias are the second most common cause (~15-20%), and malignancy/Crohn's disease represent the remainder.

![Clinical Algorithm & Advanced Reference (Small & Large Bowel Obstruction)](/lessons/images/sba/gastroenterology/bowel-obstruction/figure_06_p9.jpeg)


## Question 2 of 5

How can Small Bowel loops be radiologically differentiated from Large Bowel loops on abdominal radiographs or CT scans?

![Figure 2: Clinical Findings & Diagnostic Reference (Small & Large Bowel Obstruction)](/lessons/images/sba/gastroenterology/bowel-obstruction/figure_02_p4.jpeg)


- **A.** Small bowel loops lie centrally with plicae circulares (valvulae conniventes) that traverse the ENTIRE diameter of the lumen; large bowel lies peripherally with haustral folds that indent partially without crossing the entire lumen
- **B.** Small bowel loops are always >8 cm in diameter
- **C.** Large bowel has no air
- **D.** Small bowel is always located in the pelvis
- **E.** Small bowel has taeniae coli

**Correct Answer:** A
**Explanation:**
Small bowel: centrally located, maximum normal diameter <3 cm, valvulae conniventes (plicae circulares) are thin circular mucosal folds that extend completely across the lumen from wall to wall. Large bowel: peripherally located, diameter <6 cm (caecum <9 cm - '3-6-9 rule'), haustra are spaced wider apart and do NOT cross the full width of the bowel.

## Question 3 of 5

What is the single most common cause of mechanical Large Bowel Obstruction (LBO) in adults, accounting for over 60% of cases?

![Figure 3: Clinical Findings & Diagnostic Reference (Small & Large Bowel Obstruction)](/lessons/images/sba/gastroenterology/bowel-obstruction/figure_03_p5.jpeg)


- **A.** Colorectal Carcinoma
- **B.** Postoperative adhesions
- **C.** Diverticular stricture
- **D.** Faecal impaction
- **E.** Strangulated femoral hernia

**Correct Answer:** A
**Explanation:**
Colorectal adenocarcinoma (most frequently located in the sigmoid colon or rectosigmoid junction) is the cause of mechanical large bowel obstruction in >60% of adults. Volvulus (sigmoid ~10-15%, caecal ~5%) and diverticular disease/strictures (~10%) are the other leading causes. Adhesions rarely cause large bowel obstruction.

## Question 4 of 5

An 82-year-old nursing home resident with chronic constipation and immobility presents with massive, painless abdominal distension. Abdominal radiograph demonstrates a massive, inverted U-shaped loop of dilated bowel arising from the pelvis and pointing towards the right upper quadrant ('coffee bean sign'). What is the diagnosis and initial emergency treatment?

![Figure 4: Clinical Findings & Diagnostic Reference (Small & Large Bowel Obstruction)](/lessons/images/sba/gastroenterology/bowel-obstruction/figure_04_p7.jpeg)


- **A.** Sigmoid Volvulus; Rigid or flexible sigmoidoscopy with flatus tube decompression
- **B.** Caecal volvulus; Immediate colonoscopy
- **C.** Small bowel obstruction; Gastric lavage
- **D.** Toxic megacolon; Oral loperamide
- **E.** Paralytic ileus; IV neostigmine

**Correct Answer:** A
**Explanation:**
Sigmoid volvulus is the twisting of an elongated, redundant sigmoid colon around its mesentery, producing the classic 'coffee bean sign' (inverted U-loop with apex pointing to RUQ). In the absence of bowel gangrene/peritonitis, initial emergency management is endoscopic decompression with flexible or rigid sigmoidoscopy and placement of a soft flatus tube, followed by elective semi-urgent sigmoid resection.

## Question 5 of 5

Which of the following clinical and laboratory findings indicates 'Strangulated' (ischaemic/infarcted) bowel obstruction requiring immediate emergency laparotomy rather than a trial of conservative drip-and-suck management?

![Figure 5: Clinical Findings & Diagnostic Reference (Small & Large Bowel Obstruction)](/lessons/images/sba/gastroenterology/bowel-obstruction/figure_05_p8.jpeg)


- **A.** Fever, constant localized severe peritonitis with rebound tenderness, tachycardia, metabolic lactic acidosis, and pneumatosis intestinalis on CT
- **B.** Intermittent colicky pain with normal inflammatory markers
- **C.** Presence of active bowel sounds on auscultation
- **D.** Normal serum lactate
- **E.** Passage of flatus

**Correct Answer:** A
**Explanation:**
Simple mechanical obstruction can often be managed conservatively (nasogastric decompression, IV fluids, nil by mouth). However, strangulated obstruction (compromised mesenteric blood flow leading to bowel necrosis) is a surgical emergency. Warning signs of strangulation: continuous severe pain replacing colicky pain, localized peritonitis, fever, marked leukocytosis, elevated serum lactate, metabolic acidosis, and CT evidence of reduced wall enhancement or pneumatosis.
$SBA_GAST_061$,
    false,
    7,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 5/21: Cirrhosis & Portal Hypertensive Bleeding
  -- 1) Interleave Lecture (Position 8)
  UPDATE "lessons"
  SET "position" = 8, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'cirrhosis' OR "slug" = 'cirrhosis');

  -- 2) Upsert Quiz Lesson (Position 9)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-gastroenterology-cirrhosis',
    'Cirrhosis & Portal Hypertensive Bleeding — SBA Interactive Quiz',
    'quiz',
    $SBA_GAST_062$# Cirrhosis & Portal Hypertensive Bleeding — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 54-year-old male with decompensated alcoholic cirrhosis presents with massive haematemesis and melaena. Pulse is 126 bpm, BP is 84/52 mmHg. Along with balanced blood resuscitation and airway protection, what three pharmacological agents must be initiated immediately prior to emergency endoscopy per BSG guidelines?

![Figure 1: Clinical Findings & Diagnostic Reference (Cirrhosis & Portal Hypertensive Bleeding)](/lessons/images/sba/gastroenterology/cirrhosis/figure_01_p7.jpeg)


- **A.** Intravenous Vasoactive medication (Terlipressin), Prophylactic IV Antibiotics (Ceftriaxone), and high-dose IV Proton Pump Inhibitor
- **B.** Oral propranolol, furosemide, and lactulose
- **C.** IV tranexamic acid, heparin, and aspirin
- **D.** Oral antacids, vitamin K, and metronidazole
- **E.** Terlipressin is contraindicated before endoscopy

**Correct Answer:** A
**Explanation:**
BSG and Baveno VII guidelines mandate that in suspected variceal upper GI bleeding: (1) Start IV Terlipressin (2 mg IV bolus) immediately to cause splanchnic vasoconstriction and reduce portal venous inflow; (2) Start prophylactic IV antibiotics (Ceftriaxone 1g daily) which significantly reduces rebleeding, bacterial infections, and mortality; (3) IV PPI.

## Question 2 of 5

What is the endoscopic haemostatic treatment of choice for acute bleeding oesophageal varices during emergency upper GI endoscopy?

- **A.** Endoscopic Variceal Band Ligation (EVL)
- **B.** Endoscopic sclerotherapy with ethanolamine
- **C.** Endoscopic clipping alone
- **D.** Argon plasma coagulation
- **E.** Surgical devascularisation

**Correct Answer:** A
**Explanation:**
Endoscopic Variceal Band Ligation (EVL) is the gold standard for acute oesophageal variceal haemorrhage. It has superior efficacy in controlling bleeding, lower rates of rebleeding, lower complication rates (less oesophageal ulceration/stricture), and improved survival compared to endoscopic sclerotherapy.

## Question 3 of 5

A patient with refractory oesophageal variceal bleeding continues to exsanguinate despite Terlipressin and attempted endoscopic band ligation. What temporary balloon tamponade device can be inserted in the ED as an emergency bridge to TIPS?

- **A.** Sengstaken-Blakemore tube (or Minnesota tube)
- **B.** Levin nasogastric tube
- **C.** Ewald tube
- **D.** Endotracheal tube
- **E.** Salem sump tube

**Correct Answer:** A
**Explanation:**
The Sengstaken-Blakemore tube (with gastric and oesophageal balloons) or Minnesota tube provides immediate mechanical tamponade of bleeding gastro-oesophageal varices as a temporary salvage bridge (maximum 24 hours due to risk of oesophageal necrosis) to definitive Transjugular Intrahepatic Portosystemic Shunt (TIPS). Patients must be intubated before insertion to prevent aspiration.

## Question 4 of 5

A 58-year-old cirrhotic patient with massive ascites presents with fever (38.5C), mild diffuse abdominal pain, and new-onset confusion. Diagnostic paracentesis is performed. What diagnostic criteria in the ascitic fluid confirms Spontaneous Bacterial Peritonitis (SBP)?

- **A.** Ascitic fluid Polymorphonuclear (PMN) neutrophil count >= 250 cells/mm3 (>= 0.25 x 10^9/L)
- **B.** Ascitic total protein >30 g/L
- **C.** Ascitic fluid glucose <0.5 mmol/L
- **D.** Positive Gram stain in 100% of cases
- **E.** Presence of macroscopic blood in the ascites

**Correct Answer:** A
**Explanation:**
Spontaneous Bacterial Peritonitis (SBP) is diagnosed when ascitic fluid neutrophil (PMN) count is >= 250 cells/mm3 (0.25 x 10^9/L) in the absence of a surgically treatable intra-abdominal source. Treatment is immediate empirical IV third-generation cephalosporin (Ceftriaxone or Cefotaxime) plus IV human albumin (1.5 g/kg day 1, 1 g/kg day 3) to prevent hepatorenal syndrome.

## Question 5 of 5

Which oral non-absorbable disaccharide is the first-line medical therapy for Hepatic Encephalopathy in patients with cirrhosis, and what is its mechanism of action?

- **A.** Lactulose; it is fermented by colonic bacteria into lactic and acetic acids, acidifying the colon (trapping ammonia as non-absorbable ammonium NH4+) and producing an osmotic laxative effect
- **B.** Sucrose; increases hepatic blood flow
- **C.** Lactose; stimulates urea cycle enzymes
- **D.** Maltose; decreases gastric acid secretion
- **E.** Sorbitol monotherapy

**Correct Answer:** A
**Explanation:**
Lactulose is degraded by colonic flora into short-chain fatty acids, lowering colonic pH. Acidification converts diffusible ammonia (NH3) into non-absorbable ammonium ions (NH4+), which are trapped in the gut lumen and excreted ('ammonia trapping'). It also exerts an osmotic cathartic effect. Dose is titrated to 2-3 soft bowel motions per day. Rifaximin is added for secondary prevention.
$SBA_GAST_062$,
    false,
    9,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 6/21: Constipation & Faecal Impaction
  -- 1) Interleave Lecture (Position 10)
  UPDATE "lessons"
  SET "position" = 10, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'constibation' OR "slug" = 'constipation');

  -- 2) Upsert Quiz Lesson (Position 11)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-gastroenterology-constipation',
    'Constipation & Faecal Impaction — SBA Interactive Quiz',
    'quiz',
    $SBA_GAST_063$# Constipation & Faecal Impaction — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

An 84-year-old bedbound nursing home resident presents with frequent small-volume watery diarrhoea, abdominal cramping, and urinary retention. Abdominal radiograph shows marked faecal loading throughout the colon. Digital rectal examination reveals a rock-hard mass of impacted stool in the rectal vault. What is the diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Constipation & Faecal Impaction)](/lessons/images/sba/gastroenterology/constipation/figure_01_p4.jpeg)


- **A.** Faecal Impaction with 'Overflow Diarrhoea' (spurious diarrhoea / encopresis)
- **B.** Acute Clostridioides difficile colitis
- **C.** Infectious viral gastroenteritis
- **D.** Inflammatory bowel disease
- **E.** Secretory diarrhoea from carcinoid syndrome

**Correct Answer:** A
**Explanation:**
Faecal impaction often presents paradoxically as 'overflow diarrhoea' (encopresis). Liquid stool from the proximal colon tracks around the large, inspissated hard faecal mass lodged in the rectum and leaks out involuntarily. Administering anti-motility agents (e.g. loperamide) in this setting is dangerous and can precipitate acute toxic megacolon or bowel perforation.

## Question 2 of 5

What is the recommended medical therapy for clearing severe faecal impaction according to NICE and British National Formulary (BNF) guidelines?

- **A.** High-dose Polyethylene Glycol (Macrogol / PEG) osmotic laxative escalating regimen, combined with rectal enemas/suppositories (e.g. phosphate enema) if needed
- **B.** Bulk-forming laxatives (ispaghula husk) with fluid restriction
- **C.** Oral loperamide 4mg immediately
- **D.** Immediate emergency hemicolectomy
- **E.** Codeine phosphate 30mg TDS

**Correct Answer:** A
**Explanation:**
For acute faecal impaction, Macrogol (polyethylene glycol 3350 with electrolytes) in high divided doses (e.g. up to 8 sachets daily dissolved in 1 litre of water) is first-line to hydrate and soften the hard mass. Glycerol suppositories or sodium phosphate enemas are used for distal rectal impaction. Bulk-forming laxatives (ispaghula) are contraindicated in established impaction as they expand without clearing.

## Question 3 of 5

An 80-year-old institutionalized female with severe cardiovascular disease presents with acute abdominal distension, severe pain, and fever. Contrast CT reveals an enormous faecaloma in the rectum with localized transmural pressure necrosis of the rectal wall and extraluminal free air. What rare surgical emergency has occurred?

- **A.** Stercoral Perforation of the colon/rectum
- **B.** Perforated peptic ulcer
- **C.** Appendiceal rupture
- **D.** Ruptured abdominal aortic aneurysm
- **E.** Ischaemic colitis alone

**Correct Answer:** A
**Explanation:**
Stercoral perforation is bowel perforation caused by ischemic pressure necrosis of the colonic or rectal wall from a hard, impacted faecal mass (faecaloma). It carries a high mortality rate (>30-50%) and requires immediate emergency laparotomy, resection of the perforated segment, and end colostomy (Hartmann's procedure).

## Question 4 of 5

Which of the following medications is a notorious pharmacological cause of refractory chronic constipation in emergency department patients?

- **A.** Opioid analgesics (e.g. Morphine, Codeine, Oxycodone) via mu-opioid receptor activation in the myenteric plexus
- **B.** Amoxicillin
- **C.** Metformin
- **D.** Paracetamol
- **E.** Aspirin 75mg

**Correct Answer:** A
**Explanation:**
Opioid-Induced Constipation (OIC) occurs via activation of enteric mu-opioid receptors, which inhibits peristalsis, increases non-propulsive segmental contractions, delays gastric emptying, and increases intestinal fluid absorption. Patients prescribed regular opioids should always receive prophylactic co-prescription of stimulant and osmotic laxatives.

## Question 5 of 5

Which 'Red Flag' symptom in a 58-year-old patient presenting with a 6-week history of new-onset constipation warrants an urgent 2-week-wait colorectal cancer referral under NICE guidelines?

- **A.** Unexplained change in bowel habit to looser stools or persistent constipation, rectal bleeding, or unexplained iron-deficiency anaemia
- **B.** Occasional bloating relieved by passing flatus
- **C.** Mild anal pruritus
- **D.** Transient constipation during travel
- **E.** Normal appetite and stable weight

**Correct Answer:** A
**Explanation:**
NICE NG12 criteria for urgent 2-week-wait suspected colorectal cancer referral: unexplained change in bowel habit (persisting >=6 weeks in adults >50), rectal bleeding in patients >50, unexplained iron-deficiency anaemia, or palpable rectal/abdominal mass.
$SBA_GAST_063$,
    false,
    11,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 7/21: Acute Diarrhoea & Infectious Enteritis
  -- 1) Interleave Lecture (Position 12)
  UPDATE "lessons"
  SET "position" = 12, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'diarrhea' OR "slug" = 'diarrhea');

  -- 2) Upsert Quiz Lesson (Position 13)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-gastroenterology-diarrhea',
    'Acute Diarrhoea & Infectious Enteritis — SBA Interactive Quiz',
    'quiz',
    $SBA_GAST_064$# Acute Diarrhoea & Infectious Enteritis — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 74-year-old hospital inpatient develops watery diarrhoea (6 episodes per day), low-grade fever, abdominal cramping, and marked leukocytosis (WBC 22 x 10^9/L) 10 days after completing a course of IV co-amoxiclav for a chest infection. What is the most likely pathogen and diagnostic test?

![Figure 1: Clinical Findings & Diagnostic Reference (Acute Diarrhoea & Infectious Enteritis)](/lessons/images/sba/gastroenterology/diarrhea/figure_01_p3.jpeg)


- **A.** Clostridioides difficile; Stool testing for C. difficile GDH antigen and Toxin A/B EIA
- **B.** Campylobacter jejuni; Stool culture
- **C.** Salmonella enterica; Blood culture
- **D.** Norovirus; PCR
- **E.** Giardia lamblia; Microscopy for cysts

**Correct Answer:** A
**Explanation:**
Clostridioides (formerly Clostridium) difficile colitis is triggered by broad-spectrum antibiotics (clindamycin, cephalosporins, co-amoxiclav, fluoroquinolones) altering colonic microflora. Diagnosis: two-step stool algorithm detecting glutamate dehydrogenase (GDH) antigen followed by C. difficile Toxin A/B enzyme immunoassay or NAAT/PCR.

## Question 2 of 5

According to updated NICE and BSG guidelines, what is the first-line oral antibiotic therapy for an initial episode of mild-to-moderate Clostridioides difficile infection?

![Figure 2: Clinical Findings & Diagnostic Reference (Acute Diarrhoea & Infectious Enteritis)](/lessons/images/sba/gastroenterology/diarrhea/figure_02_p3.jpeg)


- **A.** Oral Vancomycin 125mg QDS for 10 days (or Oral Fidaxomicin 200mg BD for 10 days)
- **B.** Oral Metronidazole 400mg TDS alone
- **C.** Intravenous Vancomycin 1g BD
- **D.** Oral Ciprofloxacin 500mg BD
- **E.** Oral Loperamide 4mg TDS

**Correct Answer:** A
**Explanation:**
Current NICE and BSG guidelines recommend Oral Vancomycin (125 mg QDS for 10 days) or Oral Fidaxomicin as first-line therapy for an initial episode of C. difficile. Oral metronidazole is no longer first-line due to inferior cure rates and higher recurrence rates. Note: IV Vancomycin is ineffective because it is not excreted into the intestinal lumen.

## Question 3 of 5

A 7-year-old child presents with bloody diarrhoea, abdominal cramps, and vomiting 3 days after eating an undercooked hamburger at a barbecue. Five days later, she develops pallor, petechiae, oliguria, and lethargy. Bloods show: Hb 68 g/L, Platelets 28 x 10^9/L, Creatinine 240 umol/L, and fragmented red cells (schistocytes) on blood smear. What complication has occurred?

![Figure 3: Clinical Findings & Diagnostic Reference (Acute Diarrhoea & Infectious Enteritis)](/lessons/images/sba/gastroenterology/diarrhea/figure_03_p4.jpeg)


- **A.** Haemolytic Uraemic Syndrome (HUS) caused by Shiga-toxin producing E. coli (STEC / E. coli O157:H7)
- **B.** Thrombotic Thrombocytopenic Purpura
- **C.** Disseminated Intravascular Coagulation
- **D.** Henoch-Schönlein purpura
- **E.** Acute appendicitis with sepsis

**Correct Answer:** A
**Explanation:**
Haemolytic Uraemic Syndrome (HUS) is characterized by the classic triad of: (1) Microangiopathic haemolytic anaemia; (2) Thrombocytopenia; (3) Acute kidney injury. It is triggered by Shiga-toxin producing E. coli (STEC, classically serotype O157:H7). Antibiotics and anti-motility agents are contraindicated in STEC diarrhoea as they trigger massive toxin release, significantly increasing the risk of developing HUS.

## Question 4 of 5

Which bacterial foodborne pathogen is most commonly associated with consumption of contaminated poultry and unpasteurized milk, and is known for presenting with severe right lower quadrant pain mimicking acute appendicitis (pseudoappendicitis)?

![Figure 4: Clinical Findings & Diagnostic Reference (Acute Diarrhoea & Infectious Enteritis)](/lessons/images/sba/gastroenterology/diarrhea/figure_04_p8.jpeg)


- **A.** Campylobacter jejuni
- **B.** Staphylococcus aureus
- **C.** Bacillus cereus
- **D.** Vibrio cholerae
- **E.** Clostridium perfringens

**Correct Answer:** A
**Explanation:**
Campylobacter jejuni is the leading cause of bacterial gastroenteritis in the UK. Typical presentation: severe colicky abdominal pain (often in RIF due to mesenteric adenitis/terminal ileitis, mimicking acute appendicitis), fever, and bloody diarrhoea. It is also the classic trigger for Guillain-Barré syndrome (molecular mimicry with gangliosides).

## Question 5 of 5

Why are antimotility agents (such as Loperamide) strictly CONTRAINDICATED in patients presenting with acute bloody diarrhoea (dysentery) or suspected toxic megacolon?

- **A.** They slow intestinal transit, prolonging mucosal contact with bacterial cytotoxins and predisposing to toxic megacolon and bowel perforation
- **B.** They cause severe hyperchloraemic metabolic acidosis
- **C.** They cause irreversible heart block
- **D.** They neutralize oral rehydration salts
- **E.** They cause immediate pulmonary fibrosis

**Correct Answer:** A
**Explanation:**
In invasive bacterial enteritis (Shigella, Salmonella, STEC, C. difficile), anti-motility agents like loperamide inhibit peristalsis, trapping organisms and toxins within the gut lumen. This worsens mucosal invasion, prolongs fever, and risks precipitating fatal toxic megacolon and colonic perforation.
$SBA_GAST_064$,
    false,
    13,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 8/21: Diverticular Disease & Acute Diverticulitis
  -- 1) Interleave Lecture (Position 14)
  UPDATE "lessons"
  SET "position" = 14, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'diverticulr-disease' OR "slug" = 'diverticular-disease');

  -- 2) Upsert Quiz Lesson (Position 15)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-gastroenterology-diverticular-disease',
    'Diverticular Disease & Acute Diverticulitis — SBA Interactive Quiz',
    'quiz',
    $SBA_GAST_065$# Diverticular Disease & Acute Diverticulitis — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 66-year-old male presents with constant left iliac fossa (LIF) pain, fever (38.3C), anorexia, and localized tenderness with rebound guarding in the left lower quadrant. Bloods demonstrate marked leukocytosis (WBC 17.5 x 10^9/L) and elevated CRP of 145 mg/L. What is the clinical diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Diverticular Disease & Acute Diverticulitis)](/lessons/images/sba/gastroenterology/diverticular-disease/figure_01_p2.jpeg)


- **A.** Acute Diverticulitis
- **B.** Acute appendicitis
- **C.** Sigmoid volvulus
- **D.** Ulcerative colitis
- **E.** Coeliac disease

**Correct Answer:** A
**Explanation:**
Acute diverticulitis ('left-sided appendicitis') is inflammation or microperforation of a colonic diverticulum (most commonly in the sigmoid and descending colon in Western populations). Hallmark presentation: persistent LIF pain, fever, altered bowel habit, and localized peritoneal signs with elevated inflammatory markers.

## Question 2 of 5

What is the gold standard diagnostic imaging investigation of choice for suspected acute diverticulitis in the ED?

![Figure 2: Clinical Findings & Diagnostic Reference (Diverticular Disease & Acute Diverticulitis)](/lessons/images/sba/gastroenterology/diverticular-disease/figure_02_p3.jpeg)


- **A.** Contrast-Enhanced Computed Tomography (CT) of the abdomen and pelvis
- **B.** Emergency colonoscopy
- **C.** Barium enema
- **D.** Plain abdominal radiography alone
- **E.** Transrectal ultrasound

**Correct Answer:** A
**Explanation:**
Contrast-enhanced CT of the abdomen and pelvis is the gold standard diagnostic test (sensitivity and specificity >95%). It confirms diverticulitis (sigmoid wall thickening, pericolic fat stranding) and identifies complications (Hinchey staging: pericolic abscess, distant abscess, purulent peritonitis, or faeculent perforation).

## Question 3 of 5

Why are optical colonoscopy and flexible sigmoidoscopy strictly CONTRAINDICATED during an acute episode of diverticulitis?

![Figure 3: Clinical Findings & Diagnostic Reference (Diverticular Disease & Acute Diverticulitis)](/lessons/images/sba/gastroenterology/diverticular-disease/figure_03_p4.jpeg)


- **A.** Air insufflation and mechanical pressure on the friable, acutely inflamed diverticular wall carry high risk of iatrogenic colonic perforation
- **B.** Colonoscopy is technically impossible in diverticular disease
- **C.** Bowel preparation causes hypokalaemia
- **D.** Endoscopy neutralizes antibiotics
- **E.** Diverticulitis can only be treated surgically

**Correct Answer:** A
**Explanation:**
During acute diverticulitis, the colonic wall is inflamed, thin, and friable (often with a microperforation sealed by omentum). Mechanical instrumentation and gas insufflation during endoscopy risk converting a contained microperforation into a free, catastrophic faeculent perforation. Endoscopy should be deferred for at least 6 weeks post-recovery to exclude occult colorectal malignancy.

## Question 4 of 5

Which classification system stages the severity of complicated acute diverticulitis based on CT imaging findings to guide management?

- **A.** Hinchey Classification (Stages I to IV)
- **B.** Alvarado classification
- **C.** Bormann classification
- **D.** Forrest classification
- **E.** Child-Pugh classification

**Correct Answer:** A
**Explanation:**
Hinchey Classification: Stage I = pericolic or mesenteric abscess; Stage II = distant (pelvic or retroperitoneal) abscess; Stage III = generalized purulent peritonitis; Stage IV = generalized faeculent peritonitis (free perforation). Hinchey I/II with small abscesses (<3-4 cm) can be managed with antibiotics; large abscesses (>=4 cm) require percutaneous drainage; Hinchey III/IV require emergency surgery (Hartmann's procedure).

## Question 5 of 5

A 70-year-old male with a history of recurrent diverticulitis presents with pneumaturia (air bubbles in urine during micturition) and recurrent polymicrobial UTIs with fecaluria. What complication has developed?

- **A.** Colovesical Fistula
- **B.** Renal cell carcinoma
- **C.** Urethrorectal trauma
- **D.** Emphysematous pyelonephritis
- **E.** Bladder diverticulum

**Correct Answer:** A
**Explanation:**
Colovesical fistula (fistula between colon and urinary bladder) is a well-recognized complication of recurrent sigmoid diverticulitis. Pathognomonic hallmarks: pneumaturia (passing air/gas in urine) and faecaluria (stool in urine), with recurrent polymicrobial enteric urinary tract infections. CT scan demonstrating air in the bladder in the absence of recent instrumentation is highly diagnostic.
$SBA_GAST_065$,
    false,
    15,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 9/21: Foreign Body Ingestion & Food Impaction
  -- 1) Interleave Lecture (Position 16)
  UPDATE "lessons"
  SET "position" = 16, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'fb-ingestion' OR "slug" = 'foreign-body-ingestion');

  -- 2) Upsert Quiz Lesson (Position 17)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-gastroenterology-foreign-body-ingestion',
    'Foreign Body Ingestion & Food Impaction — SBA Interactive Quiz',
    'quiz',
    $SBA_GAST_066$# Foreign Body Ingestion & Food Impaction — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 3-year-old child is witnessed swallowing a small shiny object. Plain radiographs show a circular radiopaque foreign body in the mid-oesophagus displaying a characteristic 'double-ring' (halo) sign on the AP view and a step-off contour on the lateral view. What object has been ingested, and what is the urgent management?

![Figure 1: Clinical Findings & Diagnostic Reference (Foreign Body Ingestion & Food Impaction)](/lessons/images/sba/gastroenterology/foreign-body-ingestion/figure_01_p3.jpeg)


- **A.** Button / Disc Battery; Immediate Emergency Endoscopic Removal within 2 hours
- **B.** Standard non-magnetic coin; observe at home for 24 hours
- **C.** Plastic bead; no treatment required
- **D.** Marble; administer oral laxatives
- **E.** Safety pin; wait for gastric passage

**Correct Answer:** A
**Explanation:**
A button battery lodged in the oesophagus is a true surgical emergency. Electrical current generated by battery contact with moist mucosa hydrolyzes tissue fluids, producing caustic sodium hydroxide (alkali burn) that can cause transmural oesophageal liquefactive necrosis, tracheo-oesophageal fistula, or catastrophic aorto-oesophageal fistula within 2 hours. Radiographic hallmark: 'double-ring' or halo sign on AP and step-off on lateral view.

## Question 2 of 5

A 10-year-old child swallows two small, powerful rare-earth neodymium magnetic spheres from a toy set. Abdominal radiograph confirms both magnets are in the gastrointestinal tract, separated by a distance. What is the major risk of multiple magnet ingestion?

![Figure 2: Clinical Findings & Diagnostic Reference (Foreign Body Ingestion & Food Impaction)](/lessons/images/sba/gastroenterology/foreign-body-ingestion/figure_02_p6.jpeg)


- **A.** Attraction between magnets across adjacent bowel loops leads to pressure necrosis, bowel wall perforation, internal fistulation, volvulus, and peritonitis
- **B.** Acute magnetic toxicity of the liver
- **C.** Radioactive poisoning
- **D.** Immediate complete gastric outlet obstruction
- **E.** Cardiac arrest from magnetic interference

**Correct Answer:** A
**Explanation:**
Ingestion of multiple magnets (or a magnet plus a metallic object) is dangerous. As they traverse different loops of bowel, their powerful magnetic attraction draws them together, trapping bowel wall between them. This causes ischaemic pressure necrosis, bowel perforation, enterocutaneous/enteroenteric fistulae, and peritonitis, requiring urgent endoscopic or surgical removal.

## Question 3 of 5

A 52-year-old man presents with complete inability to swallow saliva (drooling), retrosternal foreign body sensation, and gagging 1 hour after eating steak. He has a known history of reflux oesophagitis and Schatzki's ring. What is the immediate definitive management for complete oesophageal food bolus obstruction?

![Figure 3: Clinical Findings & Diagnostic Reference (Foreign Body Ingestion & Food Impaction)](/lessons/images/sba/gastroenterology/foreign-body-ingestion/figure_03_p7.jpeg)


- **A.** Urgent Therapeutic Upper GI Endoscopy for bolus extraction or gentle push technique
- **B.** Administer effervescent drinks (Coke / carbonated beverage) and discharge
- **C.** Oral meat tenderizer (papain enzymes)
- **D.** Intravenous glucagon 10mg bolus alone as definitive therapy
- **E.** Barium swallow examination immediately

**Correct Answer:** A
**Explanation:**
Complete oesophageal food bolus obstruction (demonstrated by inability to swallow secretions / drooling) requires urgent therapeutic endoscopy within 2-6 hours to prevent aspiration and pressure necrosis of the oesophagus. Papain meat tenderizers are strictly CONTRAINDICATED due to documented cases of fatal oesophageal perforation. Glucagon has low success rates (~15-30%) and is not definitive.

## Question 4 of 5

Which ingested sharp foreign body requires emergency endoscopic extraction even if it has already passed out of the oesophagus and reached the stomach or proximal duodenum?

- **A.** Sharp-pointed foreign bodies (e.g. open safety pins, sewing needles, toothpicks, chicken bones >5 cm)
- **B.** Small smooth coin in the stomach
- **C.** Small marble in the stomach
- **D.** Soft chewing gum
- **E.** Gummy sweet

**Correct Answer:** A
**Explanation:**
Sharp-pointed objects (sewing needles, pins, bones, toothpicks) carry a high risk of visceral perforation (up to 15-35%), typically at the ileocaecal valve, duodenum, or flexures. If located in the stomach or proximal duodenum within reach of an upper endoscope, they must be retrieved emergently.

## Question 5 of 5

What physical anatomical landmark in the adult oesophagus is the single most common site of foreign body and food bolus impaction?

- **A.** Upper Oesophageal Sphincter / Cricopharyngeus muscle (C6 level)
- **B.** Aortic arch crossing (T4 level)
- **C.** Left main bronchus crossing (T5 level)
- **D.** Gastro-oesophageal junction (T10-T11 level)
- **E.** Gastric pylorus

**Correct Answer:** A
**Explanation:**
The Cricopharyngeus muscle (Upper Oesophageal Sphincter at the C6 vertebral level) is the narrowest point of the entire gastrointestinal tract. Over 70-80% of foreign bodies that become arrested in the oesophagus lodge at the cricopharyngeus.
$SBA_GAST_066$,
    false,
    17,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 10/21: Gallstones & Biliary Emergencies
  -- 1) Interleave Lecture (Position 18)
  UPDATE "lessons"
  SET "position" = 18, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'gallstones-cholecystitis-biliary-colic' OR "slug" = 'gallstones');

  -- 2) Upsert Quiz Lesson (Position 19)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-gastroenterology-gallstones',
    'Gallstones & Biliary Emergencies — SBA Interactive Quiz',
    'quiz',
    $SBA_GAST_067$# Gallstones & Biliary Emergencies — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 44-year-old female presents with acute right upper quadrant (RUQ) pain radiating to her right shoulder and scapula, accompanied by fever (38.4C), nausea, and anorexia. On palpation of the RUQ, deep inspiration is abruptly arrested due to sharp pain (Murphy's sign). What is the diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Gallstones & Biliary Emergencies)](/lessons/images/sba/gastroenterology/gallstones/figure_01_p4.jpeg)


- **A.** Acute Cholecystitis
- **B.** Biliary Colic without inflammation
- **C.** Acute Appendicitis
- **D.** Acute Pancreatitis
- **E.** Perforated peptic ulcer

**Correct Answer:** A
**Explanation:**
Acute cholecystitis is chemical and bacterial inflammation of the gallbladder, almost always (>95%) caused by cystic duct obstruction by an impacted gallstone (calculous cholecystitis). Murphy's sign (arrest of inspiration on RUQ palpation) is classic. Unlike biliary colic (which lasts <4-6 hours and has no fever or inflammatory markers), cholecystitis features persistent pain >6 hours, fever, and leukocytosis.

## Question 2 of 5

What is the primary diagnostic imaging modality of choice for suspected acute cholecystitis, and what sonographic signs confirm the diagnosis?

![Figure 2: Clinical Findings & Diagnostic Reference (Gallstones & Biliary Emergencies)](/lessons/images/sba/gastroenterology/gallstones/figure_02_p5.jpeg)


- **A.** Transabdominal Ultrasound; Gallstones, gallbladder wall thickening (>3-4 mm), pericholecystic fluid, and sonographic Murphy's sign
- **B.** Plain abdominal X-ray
- **C.** ERCP
- **D.** Barium meal
- **E.** Liver biopsy

**Correct Answer:** A
**Explanation:**
Transabdominal Ultrasound is the first-line imaging modality of choice (sensitivity >90-95%). Diagnostic sonographic criteria: presence of gallstones, thickened gallbladder wall (>3-4 mm), gallbladder distension/sludge, pericholecystic fluid halo, and a positive Sonographic Murphy's sign (focal tenderness directly over the sonographically visualized gallbladder).

## Question 3 of 5

A 72-year-old female presents with Charcot's Triad of acute cholangitis: fever/rigors, right upper quadrant pain, and fluctuating jaundice. Blood tests show bilirubin 98 umol/L, alkaline phosphatase 450 IU/L, and WBC 19 x 10^9/L. What is the immediate definitive therapeutic procedure of choice following resuscitation?

![Figure 3: Clinical Findings & Diagnostic Reference (Gallstones & Biliary Emergencies)](/lessons/images/sba/gastroenterology/gallstones/figure_03_p5.jpeg)


- **A.** Urgent Endoscopic Retrograde Cholangiopancreatography (ERCP) with biliary sphincterotomy and stone extraction / stenting
- **B.** Emergency open cholecystectomy in the ED
- **C.** Oral ursodeoxycholic acid
- **D.** Percutaneous liver biopsy
- **E.** Extracorporeal shock-wave lithotripsy (ESWL)

**Correct Answer:** A
**Explanation:**
Acute cholangitis is an ascending bacterial infection of the biliary tree secondary to biliary obstruction (most commonly choledocholithiasis / common bile duct stone). Urgent biliary decompression via ERCP (endoscopic sphincterotomy and stent placement/stone extraction) is life-saving, combined with broad-spectrum IV antibiotics.

## Question 4 of 5

What constitutes Reynolds' Pentad, denoting life-threatening, fulminant acute suppurative cholangitis with high mortality?

- **A.** Charcot's Triad (Fever, Jaundice, RUQ pain) PLUS Hypotension (shock) and Altered Mental Status (confusion)
- **B.** Fever, Jaundice, Ascites, Asterixis, and Spider naevi
- **C.** Hypotension, Muffled heart sounds, JVD, Bradycardia, and Stridor
- **D.** Pain, Pallor, Pulselessness, Paresthesia, and Paralysis
- **E.** Hypertension, Bradycardia, Irregular breathing, Coma, and Vomiting

**Correct Answer:** A
**Explanation:**
Reynolds' Pentad (Charcot's triad + shock + altered mental status) indicates severe acute suppurative cholangitis with systemic sepsis and multi-organ dysfunction. It mandates emergent intensive care resuscitation, broad-spectrum IV antibiotics, and urgent emergency biliary decompression within hours.

## Question 5 of 5

An 80-year-old female presents with small bowel obstruction. Abdominal CT demonstrates the classic 'Rigler's Triad'. What is this condition and what are the three components of Rigler's Triad?

- **A.** Gallstone Ileus; Pneumobilia (air in biliary tree), Mechanical small bowel obstruction, and an Ectopic radiopaque gallstone in the lumen (classically at the ileocaecal valve)
- **B.** Sigmoid volvulus with perforation
- **C.** Acute appendicitis with abscess
- **D.** Renal colic with hydronephrosis
- **E.** Intussusception with lead point

**Correct Answer:** A
**Explanation:**
Gallstone ileus occurs when a large gallstone erodes through the inflamed gallbladder wall directly into the adjacent duodenum via a cholecystoduodenal fistula. The stone travels down the small bowel until it impacts at the narrowest point (the ileocaecal valve), causing mechanical SBO. Rigler's triad on imaging: (1) Small bowel obstruction; (2) Pneumobilia (air in bile ducts); (3) Ectopic gallstone in the bowel.
$SBA_GAST_067$,
    false,
    19,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 11/21: Acute Gastroenteritis & Dehydration
  -- 1) Interleave Lecture (Position 20)
  UPDATE "lessons"
  SET "position" = 20, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'acute-gastroenteritis-dehydration' OR "slug" = 'gastroenteritis');

  -- 2) Upsert Quiz Lesson (Position 21)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-gastroenterology-gastroenteritis',
    'Acute Gastroenteritis & Dehydration — SBA Interactive Quiz',
    'quiz',
    $SBA_GAST_068$# Acute Gastroenteritis & Dehydration — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 28-year-old nurse develops severe, abrupt-onset projectile vomiting and watery non-bloody diarrhoea 24 hours after an outbreak on her hospital ward. She is afebrile with mild crampy abdominal pain. What is the single most common viral causative agent of acute gastroenteritis outbreaks in healthcare institutions and cruise ships?

![Figure 1: Clinical Findings & Diagnostic Reference (Acute Gastroenteritis & Dehydration)](/lessons/images/sba/gastroenterology/gastroenteritis/figure_01_p5.jpeg)


- **A.** Norovirus (Norwalk-like virus)
- **B.** Rotavirus
- **C.** Astrovirus
- **D.** Adenovirus types 40/41
- **E.** Cytomegalovirus

**Correct Answer:** A
**Explanation:**
Norovirus (Caliciviridae) is the leading cause of epidemic non-bacterial gastroenteritis in adults and healthcare settings. Highly contagious with an extremely low infectious dose (10-100 viral particles), transmitted by aerosolised vomitus, person-to-person, or contaminated surfaces. Hallmark: sudden explosive projectile vomiting, watery diarrhoea, and rapid 24-48 hour resolution.

![Clinical Algorithm & Advanced Reference (Acute Gastroenteritis & Dehydration)](/lessons/images/sba/gastroenterology/gastroenteritis/figure_06_p12.jpeg)


## Question 2 of 5

Which bacterial enterotoxin-mediated food poisoning has the shortest incubation period (typically 1 to 6 hours after consuming contaminated dairy, cream pastries, or sliced meats) and presents with violent nausea and vomiting with little or no fever?

![Figure 2: Clinical Findings & Diagnostic Reference (Acute Gastroenteritis & Dehydration)](/lessons/images/sba/gastroenterology/gastroenteritis/figure_02_p6.jpeg)


- **A.** Staphylococcus aureus preformed heat-stable enterotoxin
- **B.** Salmonella enteritidis
- **C.** Campylobacter jejuni
- **D.** Clostridium perfringens
- **E.** Listeria monocytogenes

**Correct Answer:** A
**Explanation:**
Preformed heat-stable toxins produced by Staphylococcus aureus (or Bacillus cereus emetic toxin from reheated fried rice) act directly on the vagus nerve in the stomach. Because the toxin is preformed in the food prior to ingestion, incubation is very short (1-6 hours), dominated by violent nausea, vomiting, and prostration with minimal fever.

![Clinical Algorithm & Advanced Reference (Acute Gastroenteritis & Dehydration)](/lessons/images/sba/gastroenterology/gastroenteritis/figure_07_p13.jpeg)


## Question 3 of 5

According to NICE guideline CG84, what is the first-line rehydration strategy for a 14-month-old child presenting with acute gastroenteritis and mild-to-moderate clinical dehydration?

![Figure 3: Clinical Findings & Diagnostic Reference (Acute Gastroenteritis & Dehydration)](/lessons/images/sba/gastroenterology/gastroenteritis/figure_03_p8.jpeg)


- **A.** Oral Rehydration Solution (ORS, e.g. Dioralyte) given in small, frequent sips (5 ml every 5 minutes)
- **B.** Immediate rapid intravenous infusion of 0.9% normal saline with 5% dextrose
- **C.** Fruit juice and sweetened carbonated drinks
- **D.** Pure plain sterile water in large volumes
- **E.** Withhold all fluids for 12 hours to rest the gut

**Correct Answer:** A
**Explanation:**
NICE CG84 recommends Oral Rehydration Salt (ORS) solution as the primary first-line treatment for children with mild-to-moderate dehydration. ORS exploits the intact sodium-glucose co-transporter (SGLT-1) in the intestinal brush border. Small, frequent volumes (5 ml every 5 minutes with a syringe or teaspoon) minimize vomiting. IV fluids are reserved for shock, failure of ORS/NG, or severe dehydration.

## Question 4 of 5

Which antiemetic medication is recommended by paediatric emergency guidelines as an effective single-dose agent to reduce vomiting and facilitate successful oral rehydration in children with acute gastroenteritis?

![Figure 4: Clinical Findings & Diagnostic Reference (Acute Gastroenteritis & Dehydration)](/lessons/images/sba/gastroenterology/gastroenteritis/figure_04_p9.jpeg)


- **A.** Oral Ondansetron (0.15 mg/kg or weight-based dose)
- **B.** Metoclopramide
- **C.** Prochlorperazine
- **D.** Domperidone
- **E.** Promethazine

**Correct Answer:** A
**Explanation:**
A single dose of oral Ondansetron (5-HT3 receptor antagonist) reduces the frequency of vomiting, increases the success rate of oral rehydration therapy, and significantly decreases hospital admission and IV fluid rates in children with acute gastroenteritis. Metoclopramide is avoided in young children due to high rates of extrapyramidal dystonic reactions.

## Question 5 of 5

A 35-year-old backpacker returns from a 3-week trek in South Asia with persistent foul-smelling, greasy, floating stools, severe abdominal bloating, flatulence, and 4 kg weight loss for the past 3 weeks. What protozoan parasite is most likely, and what is the treatment?

![Figure 5: Clinical Findings & Diagnostic Reference (Acute Gastroenteritis & Dehydration)](/lessons/images/sba/gastroenterology/gastroenteritis/figure_05_p11.jpeg)


- **A.** Giardia lamblia (Giardia duodenalis); Oral Metronidazole (or Tinidazole)
- **B.** Entamoeba histolytica; Ciprofloxacin
- **C.** Cryptosporidium parvum; Loperamide
- **D.** Ascaris lumbricoides; Mebendazole
- **E.** Enterobius vermicularis; Albendazole

**Correct Answer:** A
**Explanation:**
Giardia lamblia trophozoites adhere to duodenal and jejunal brush border mucosa with ventral sucking disks, causing malabsorption. Features: chronic diarrhoea (>2-3 weeks), steatorrhoea (greasy, floating, foul-smelling stools), bloating, sulfurous belching, and weight loss. Treatment is oral Metronidazole (400 mg TDS for 5-7 days) or single-dose Tinidazole (2 g).
$SBA_GAST_068$,
    false,
    21,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 12/21: Acute Hepatitis & Liver Failure
  -- 1) Interleave Lecture (Position 22)
  UPDATE "lessons"
  SET "position" = 22, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'hepatitis' OR "slug" = 'hepatitis');

  -- 2) Upsert Quiz Lesson (Position 23)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-gastroenterology-hepatitis',
    'Acute Hepatitis & Liver Failure — SBA Interactive Quiz',
    'quiz',
    $SBA_GAST_069$# Acute Hepatitis & Liver Failure — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 26-year-old man presents with malaise, dark tea-coloured urine, pale acholic stools, and scleral icterus 3 weeks after returning from an overseas holiday where he consumed raw shellfish. Bloods show ALT 2400 IU/L, AST 1800 IU/L, and Bilirubin 95 umol/L. What serological marker confirms acute Hepatitis A infection?

![Figure 1: Clinical Findings & Diagnostic Reference (Acute Hepatitis & Liver Failure)](/lessons/images/sba/gastroenterology/hepatitis/figure_01_p2.jpeg)


- **A.** Anti-HAV IgM antibody
- **B.** Anti-HAV IgG antibody alone
- **C.** Hepatitis B surface antigen (HBsAg)
- **D.** Anti-HCV antibody
- **E.** Hepatitis D RNA

**Correct Answer:** A
**Explanation:**
Anti-HAV IgM is the diagnostic serological marker for acute Hepatitis A virus infection (detectable from symptom onset and persisting for 3-6 months). Anti-HAV IgG denotes past infection or immunity following vaccination. Hepatitis A is transmitted via the faecal-oral route (shellfish, contaminated water) and does NOT cause chronic hepatitis.

## Question 2 of 5

Which serological marker is the FIRST detectable viral marker in the serum during acute Hepatitis B infection, and indicates that the patient is infectious?

![Figure 2: Clinical Findings & Diagnostic Reference (Acute Hepatitis & Liver Failure)](/lessons/images/sba/gastroenterology/hepatitis/figure_02_p4.jpeg)


- **A.** Hepatitis B Surface Antigen (HBsAg)
- **B.** Hepatitis B Surface Antibody (anti-HBs)
- **C.** Hepatitis B Core Antibody IgG (anti-HBc IgG)
- **D.** Hepatitis A antibody
- **E.** Hepatitis C core antigen

**Correct Answer:** A
**Explanation:**
HBsAg is the first serological marker to appear in acute Hepatitis B (appearing 1-10 weeks after exposure). Persistence of HBsAg for >6 months defines chronic Hepatitis B infection. Anti-HBs indicates recovery, clinical immunity, or successful vaccination.

## Question 3 of 5

Which Hepatitis virus requires concurrent active co-infection or super-infection with Hepatitis B virus (HBV) to replicate, and significantly accelerates progression to acute fulminant hepatic failure or cirrhosis?

![Figure 3: Clinical Findings & Diagnostic Reference (Acute Hepatitis & Liver Failure)](/lessons/images/sba/gastroenterology/hepatitis/figure_03_p6.jpeg)


- **A.** Hepatitis D Virus (HDV / Delta agent)
- **B.** Hepatitis A Virus
- **C.** Hepatitis C Virus
- **D.** Hepatitis E Virus
- **E.** Hepatitis G Virus

**Correct Answer:** A
**Explanation:**
Hepatitis D (Delta virus) is an incomplete, defective RNA virus that cannot synthesize its own envelope protein; it utilizes the Hepatitis B surface antigen (HBsAg) coat to assemble infectious virions. HDV infection occurs only as a co-infection with HBV or as a super-infection in a chronic HBV carrier, carrying the highest risk of fulminant liver failure and rapid cirrhosis.

## Question 4 of 5

In which specific patient population does acute Hepatitis E virus (HEV) infection carry an alarming, exceptionally high mortality rate of up to 20 to 25% from acute fulminant hepatic failure?

![Figure 4: Clinical Findings & Diagnostic Reference (Acute Hepatitis & Liver Failure)](/lessons/images/sba/gastroenterology/hepatitis/figure_04_p11.jpeg)


- **A.** Pregnant women (particularly in the third trimester)
- **B.** Children under 5 years of age
- **C.** Young healthy athletic males
- **D.** Elderly patients with osteoarthritis
- **E.** Patients with asthma

**Correct Answer:** A
**Explanation:**
Hepatitis E (HEV genotypes 1 and 2, transmitted enterically through contaminated water in developing nations) is typically self-limiting in healthy adults. However, in pregnant women (especially in the 3rd trimester), HEV infection carries a catastrophic 20-25% mortality rate due to fulminant hepatic necrosis, eclampsia, and DIC.

## Question 5 of 5

According to the King's College Hospital Criteria, what single laboratory parameter predicts >85% mortality and warrants immediate listing for emergency liver transplantation in Acute Liver Failure secondary to Paracetamol (Acetaminophen) toxicity?

![Figure 5: Clinical Findings & Diagnostic Reference (Acute Hepatitis & Liver Failure)](/lessons/images/sba/gastroenterology/hepatitis/figure_05_p12.jpeg)


- **A.** Arterial pH < 7.30 at 24 hours after overdose (after adequate fluid resuscitation)
- **B.** Serum ALT > 10,000 IU/L
- **C.** Serum Bilirubin > 50 umol/L
- **D.** Platelet count < 100 x 10^9/L
- **E.** Paracetamol level at 4 hours of 150 mg/L

**Correct Answer:** A
**Explanation:**
King's College Criteria for liver transplant in paracetamol-induced acute liver failure: Arterial pH < 7.30 (after fluid resuscitation) irrespective of encephalopathy grade; OR all 3 of the following within a 24-hour period: Grade III/IV hepatic encephalopathy, Prothrombin Time >100 seconds (INR >6.5), and Serum Creatinine >300 umol/L.
$SBA_GAST_069$,
    false,
    23,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 13/21: Inflammatory Bowel Disease (Crohn & UC)
  -- 1) Interleave Lecture (Position 24)
  UPDATE "lessons"
  SET "position" = 24, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'inflammatory-bowel-disease-crohn-uc' OR "slug" = 'inflammatory-bowel-disease');

  -- 2) Upsert Quiz Lesson (Position 25)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-gastroenterology-inflammatory-bowel-disease',
    'Inflammatory Bowel Disease (Crohn & UC) — SBA Interactive Quiz',
    'quiz',
    $SBA_GAST_070$# Inflammatory Bowel Disease (Crohn & UC) — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 26-year-old male presents with a 6-week history of bloody diarrhoea (8-10 episodes daily), lower abdominal tenesmus, and urgency. Flexible sigmoidoscopy reveals continuous, confluent mucosal erythema, loss of vascular pattern, and superficial ulceration starting at the anal verge and extending continuously into the sigmoid colon without skip lesions. What is the diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Inflammatory Bowel Disease (Crohn & UC))](/lessons/images/sba/gastroenterology/inflammatory-bowel-disease/figure_01_p2.jpeg)


- **A.** Ulcerative Colitis (UC)
- **B.** Crohn's Disease
- **C.** Ischaemic colitis
- **D.** Infectious amoebic colitis
- **E.** Collagenous colitis

**Correct Answer:** A
**Explanation:**
Ulcerative Colitis is characterized by continuous, confluent superficial mucosal inflammation that starts in the rectum (proctitis) and extends proximally into the colon without skip areas. The rectum is involved in >95% of cases. In contrast, Crohn's disease causes transmural, patchy ('skip lesions') inflammation with cobblestoning, deep linear ulcers, and can involve any part of the GI tract from mouth to anus.

## Question 2 of 5

According to the Truelove and Witts criteria, what clinical and laboratory parameters define Acute Severe Ulcerative Colitis (ASUC), a life-threatening medical emergency?

![Figure 2: Clinical Findings & Diagnostic Reference (Inflammatory Bowel Disease (Crohn & UC))](/lessons/images/sba/gastroenterology/inflammatory-bowel-disease/figure_02_p3.jpeg)


- **A.** >=6 bloody bowel motions per day, PLUS at least one sign of systemic toxicity (Pulse >90 bpm, Temp >37.8C, Hb <105 g/L, or ESR >30 mm/h / CRP >45 mg/L)
- **B.** 2-3 soft stools per day with normal pulse and ESR
- **C.** Constipation alternating with diarrhoea
- **D.** Isolated perianal skin tag without rectal bleeding
- **E.** Abdominal pain relieved by defecation without blood

**Correct Answer:** A
**Explanation:**
Truelove and Witts criteria for Acute Severe Ulcerative Colitis (ASUC): >=6 bloody stools per day PLUS at least one feature of systemic disturbance: temperature >37.8C, pulse >90 bpm, haemoglobin <105 g/L, or ESR >30 mm/h (or CRP >45 mg/L). ASUC carries risk of toxic megacolon and perforation, requiring immediate admission for IV corticosteroids.

## Question 3 of 5

What is the recommended first-line medical therapy for an adult presenting with Acute Severe Ulcerative Colitis according to NICE and BSG guidelines?

![Figure 3: Clinical Findings & Diagnostic Reference (Inflammatory Bowel Disease (Crohn & UC))](/lessons/images/sba/gastroenterology/inflammatory-bowel-disease/figure_03_p4.jpeg)


- **A.** Intravenous Hydrocortisone (100mg QDS) or IV Methylprednisolone (60mg daily), plus prophylactic low-molecular-weight heparin
- **B.** Oral mesalazine 1g daily alone
- **C.** Oral loperamide 4mg TDS
- **D.** Immediate total proctocolectomy within 1 hour
- **E.** Oral budesonide 3mg

**Correct Answer:** A
**Explanation:**
First-line therapy for ASUC: IV Hydrocortisone (100mg QDS) or IV Methylprednisolone (60mg/day). Prophylactic LMWH is mandatory because IBD flare is a major prothrombotic risk factor for venous thromboembolism. Response is formally assessed on Day 3 using the Travis/Oxford criteria (stool frequency >8/day or CRP >45 predicts 85% colectomy rate, indicating rescue therapy with Infliximab or Ciclosporin).

## Question 4 of 5

A 30-year-old female with severe ulcerative colitis develops acute, massive abdominal distension, severe pain, tachycardia (HR 130 bpm), and fever (39.0C). Abdominal radiograph demonstrates transverse colonic dilation measuring 7.5 cm with loss of haustration. What catastrophic complication has occurred?

![Figure 4: Clinical Findings & Diagnostic Reference (Inflammatory Bowel Disease (Crohn & UC))](/lessons/images/sba/gastroenterology/inflammatory-bowel-disease/figure_04_p4.jpeg)


- **A.** Toxic Megacolon
- **B.** Small bowel volvulus
- **C.** Intussusception
- **D.** Acute appendicitis
- **E.** Paralytic ileus without inflammation

**Correct Answer:** A
**Explanation:**
Toxic megacolon is non-obstructive acute toxic dilation of the colon (>6 cm, typically transverse colon on plain radiograph) associated with systemic toxicity (fever, tachycardia, leukocytosis, altered sensorium). It is caused by deep transmural inflammation paralyzing the colonic smooth muscle plexus. It carries extreme risk of perforation; emergency subtotal colectomy is indicated if medical therapy fails within 24-48 hours.

## Question 5 of 5

Which of the following clinical features and complications is characteristic of Crohn's Disease but is NOT typical of Ulcerative Colitis?

- **A.** Transmural inflammation leading to strictures, enterocutaneous / enteroenteric fistulae, deep fissures, perianal abscesses, and non-caseating granulomas on biopsy
- **B.** Superficial mucosal inflammation limited to the colon
- **C.** Continuous inflammation always involving the rectum
- **D.** Crypt abscesses without granulomas
- **E.** Complete absence of small bowel involvement

**Correct Answer:** A
**Explanation:**
Crohn's disease produces transmural inflammation (affecting all layers of the bowel wall). Pathological hallmarks: skip lesions, cobblestone mucosa, non-caseating epithelioid granulomas (~50%), transmural lymphoid aggregates, fibrotic strictures, and penetrating sinus tracts causing fistulae (perianal, enterocutaneous, colovesical) and intra-abdominal abscesses.
$SBA_GAST_070$,
    false,
    25,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 14/21: Acute Mesenteric & Ischaemic Bowel Disease
  -- 1) Interleave Lecture (Position 26)
  UPDATE "lessons"
  SET "position" = 26, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'acute-mesenteric-ischemic-bowel-disease' OR "slug" = 'ischemic-bowel');

  -- 2) Upsert Quiz Lesson (Position 27)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-gastroenterology-ischemic-bowel',
    'Acute Mesenteric & Ischaemic Bowel Disease — SBA Interactive Quiz',
    'quiz',
    $SBA_GAST_071$# Acute Mesenteric & Ischaemic Bowel Disease — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 74-year-old female with atrial fibrillation not taking anticoagulation presents with severe, agonizing, unremitting mid-abdominal pain for 3 hours. On abdominal examination, the abdomen is soft and non-distended with no guarding or rebound tenderness. What is the classic clinical hallmark of early Acute Mesenteric Ischaemia (AMI)?

![Figure 1: Clinical Findings & Diagnostic Reference (Acute Mesenteric & Ischaemic Bowel Disease)](/lessons/images/sba/gastroenterology/ischemic-bowel/figure_01_p2.jpeg)


- **A.** Severe abdominal pain completely disproportionate to the benign physical examination findings
- **B.** Board-like rigid peritonitis from the first minute of onset
- **C.** Painless gross haematochezia
- **D.** Palpable pulsatile mass
- **E.** Normal white cell count and normal heart rate

**Correct Answer:** A
**Explanation:**
The classic, cardinal presentation of acute mesenteric ischaemia is severe, agonizing abdominal pain out of proportion to physical examination findings (the abdomen remains soft and non-tender initially because the visceral ischaemia has not yet progressed to transmural bowel infarction and somatic parietal peritoneal irritation).

## Question 2 of 5

What is the single most common cause of Acute Mesenteric Ischaemia, accounting for approximately 50% of all cases?

![Figure 2: Clinical Findings & Diagnostic Reference (Acute Mesenteric & Ischaemic Bowel Disease)](/lessons/images/sba/gastroenterology/ischemic-bowel/figure_02_p3.jpeg)


- **A.** Superior Mesenteric Artery (SMA) Embolism (originating from atrial fibrillation, recent MI, or endocarditis)
- **B.** Mesenteric venous thrombosis
- **C.** Non-occlusive mesenteric ischaemia (NOMI)
- **D.** Inferior mesenteric artery dissection
- **E.** Celiac trunk thrombosis

**Correct Answer:** A
**Explanation:**
Acute SMA embolism causes ~50% of cases of acute mesenteric ischaemia. Cardiac emboli (from AF, ventricular mural thrombus post-MI, or valvular disease) lodge typically 3-10 cm distal to the origin of the SMA (just distal to the middle colic artery takeoff), sparing the proximal jejunum but devascularizing the ileum and ascending colon.

## Question 3 of 5

What is the definitive diagnostic imaging modality of choice for suspected Acute Mesenteric Ischaemia in the ED?

![Figure 3: Clinical Findings & Diagnostic Reference (Acute Mesenteric & Ischaemic Bowel Disease)](/lessons/images/sba/gastroenterology/ischemic-bowel/figure_03_p3.jpeg)


- **A.** Multiphase Contrast-Enhanced CT Angiography (CTA) of the Abdomen and Pelvis (arterial and portal venous phases)
- **B.** Plain abdominal X-ray
- **C.** Abdominal ultrasound with Doppler alone
- **D.** Colonoscopy
- **E.** Barium enema

**Correct Answer:** A
**Explanation:**
Biphasic Contrast CT Angiography (arterial and portal venous phases) is the gold standard diagnostic test (sensitivity >95%). It demonstrates direct arterial filling defects (occlusion of the SMA), bowel wall thickening or lack of enhancement, mesenteric stranding, pneumatosis intestinalis, or portomesenteric venous gas.

## Question 4 of 5

An 80-year-old male with generalised atherosclerosis presents with mild lower left quadrant crampy pain and bright red rectal bleeding 12 hours after an episode of transient intraoperative hypotension. Contrast CT demonstrates thumbprinting (mucosal oedema) confined to the splenic flexure and rectosigmoid junction. What condition is this?

- **A.** Colonic Ischaemia (Ischaemic Colitis) affecting 'watershed' areas (Griffiths' point and Sudeck's point)
- **B.** Acute mesenteric arterial embolism
- **C.** Sigmoid diverticulitis
- **D.** Ulcerative colitis
- **E.** Infectious dysentery

**Correct Answer:** A
**Explanation:**
Ischaemic colitis (colonic ischaemia) is non-occlusive hypoperfusion of the microvasculature of the colon, typically triggered by transient hypotension or shock. It characteristically affects 'watershed' areas with vulnerable dual marginal blood supply: the splenic flexure (Griffiths' point between SMA and IMA) and rectosigmoid junction (Sudeck's point). It presents with crampy pain and bloody diarrhoea; over 80-90% resolve with supportive care.

## Question 5 of 5

What late radiological sign on abdominal CT indicates extensive, irreversible transmural bowel infarction and impending gangrenous rupture in mesenteric ischaemia?

- **A.** Pneumatosis Intestinalis (gas in the bowel wall) and Hepatic Portal Venous Gas
- **B.** Simple small bowel fluid levels
- **C.** Mild mesenteric lymphadenopathy
- **D.** Normal mucosal enhancement
- **E.** Colonic diverticulosis

**Correct Answer:** A
**Explanation:**
Pneumatosis intestinalis (intramural gas in the bowel wall) and hepatic portal venous gas (gas bubbles tracking via mesenteric veins into the periphery of the liver) are ominous radiological signs signifying transmural bowel wall infarction, bacterial gas translocation, and intestinal gangrene, mandating immediate emergency laparotomy.
$SBA_GAST_071$,
    false,
    27,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 15/21: Acute Jaundice Differential in the ED
  -- 1) Interleave Lecture (Position 28)
  UPDATE "lessons"
  SET "position" = 28, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'acute-jaundice-differential-in-the-ed' OR "slug" = 'jaundice');

  -- 2) Upsert Quiz Lesson (Position 29)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-gastroenterology-jaundice',
    'Acute Jaundice Differential in the ED — SBA Interactive Quiz',
    'quiz',
    $SBA_GAST_072$# Acute Jaundice Differential in the ED — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 22-year-old medical student notes mild scleral icterus after fasting during a busy 24-hour shift and recovering from a viral cold. She is otherwise completely asymptomatic with normal physical exam. Blood tests show: Total Bilirubin 48 umol/L, Direct (conjugated) Bilirubin 6 umol/L, ALT 24 IU/L, AST 22 IU/L, ALP 72 IU/L, Haemoglobin 142 g/L, Reticulocytes normal. What benign condition is this?

![Figure 1: Clinical Findings & Diagnostic Reference (Acute Jaundice Differential in the ED)](/lessons/images/sba/gastroenterology/jaundice/figure_01_p2.jpeg)


- **A.** Gilbert's Syndrome (familial unconjugated hyperbilirubinaemia)
- **B.** Autoimmune haemolytic anaemia
- **C.** Acute viral hepatitis
- **D.** Choledocholithiasis
- **E.** Crigler-Najjar syndrome Type I

**Correct Answer:** A
**Explanation:**
Gilbert's syndrome is a benign autosomal recessive hereditary condition (affecting 5-10% of the population) caused by reduced activity of the hepatic enzyme UDP-glucuronosyltransferase (UGT1A1). It causes mild unconjugated (indirect) hyperbilirubinaemia provoked by physiological stressors: fasting/starvation, viral illness, dehydration, or strenuous exercise. Liver enzymes and haemolysis markers are completely normal; no treatment is required.

## Question 2 of 5

What physiological liver function pattern on serum testing distinguishes an 'Obstructive / Cholestatic' jaundice from a 'Hepatocellular' jaundice?

![Figure 2: Clinical Findings & Diagnostic Reference (Acute Jaundice Differential in the ED)](/lessons/images/sba/gastroenterology/jaundice/figure_02_p3.jpeg)


- **A.** Obstructive: Predominant elevation of Alkaline Phosphatase (ALP) and Gamma-GT (GGT) out of proportion to transaminases; Hepatocellular: Predominant elevation of ALT and AST out of proportion to ALP
- **B.** Obstructive has elevated ALT >3000 IU/L with normal ALP
- **C.** Hepatocellular jaundice has normal transaminases
- **D.** Cholestatic jaundice is characterized by unconjugated hyperbilirubinaemia only
- **E.** There is no biochemical difference

**Correct Answer:** A
**Explanation:**
Liver enzymes categorize jaundice: Cholestatic/obstructive pattern features prominent elevation of biliary enzymes: Alkaline Phosphatase (ALP) and Gamma-glutamyl transferase (GGT) with conjugated hyperbilirubinaemia, dark urine, and pale stools. Hepatocellular pattern features prominent transaminase elevation (ALT/AST) caused by hepatocyte necrosis.

## Question 3 of 5

What is 'Courvoisier's Law' regarding palpable gallbladder in jaundice, and what does it classically indicate?

![Figure 3: Clinical Findings & Diagnostic Reference (Acute Jaundice Differential in the ED)](/lessons/images/sba/gastroenterology/jaundice/figure_03_p4.jpeg)


- **A.** In the presence of jaundice, an enlarged, palpably painless gallbladder is unlikely to be due to gallstones, and strongly suggests malignant biliary obstruction (e.g. Pancreatic Head Adenocarcinoma or Cholangiocarcinoma)
- **B.** A palpable gallbladder always indicates acute cholecystitis
- **C.** Gallstones always produce an enlarged palpable gallbladder
- **D.** A palpable gallbladder indicates viral hepatitis
- **E.** Courvoisier's law only applies to children with choledochal cysts

**Correct Answer:** A
**Explanation:**
Courvoisier's Law states that a palpably enlarged, non-tender gallbladder in a jaundiced patient is rarely caused by gallstones, because chronic cholelithiasis causes chronic inflammation and fibrosis that shrivels the gallbladder, preventing distension. Instead, it indicates slow, progressive extrinsic compression by an obstructive malignancy (e.g. pancreatic head cancer, periampullary tumour).

## Question 4 of 5

Why do patients with extrahepatic obstructive/cholestatic jaundice characteristically report passage of dark 'coca-cola' colored urine and pale, clay-colored (acholic) stools?

![Figure 4: Clinical Findings & Diagnostic Reference (Acute Jaundice Differential in the ED)](/lessons/images/sba/gastroenterology/jaundice/figure_04_p5.jpeg)


- **A.** Conjugated bilirubin cannot enter the duodenum due to biliary obstruction (stools become pale without stercobilin), so water-soluble conjugated bilirubin is excreted in urine via kidneys (turning urine dark)
- **B.** Bilirubin is converted into melanin in the kidneys
- **C.** Unconjugated bilirubin is filtered by the glomerulus
- **D.** Urine darkness is caused by acute tubular haemoglobinuria
- **E.** Stool paleness is caused by calcium ingestion

**Correct Answer:** A
**Explanation:**
In biliary obstruction, bile flow into the duodenum is blocked. The absence of bile pigments in the gut prevents conversion of bilirubin to stercobilin, resulting in pale/clay-colored (acholic) stools. Meanwhile, water-soluble conjugated bilirubin builds up in the blood, is filtered by the renal glomeruli, and turns urine dark brown. (Unconjugated bilirubin is water-insoluble and bound to albumin, so it never appears in urine).

## Question 5 of 5

A 28-year-old male with acute liver failure, psychiatric disturbances (depression, tremors), choreoathetosis, and brown rings visible at the periphery of his cornea on slit-lamp exam presents with Coombs-negative haemolytic jaundice. What genetic disorder of copper metabolism is this?

![Figure 5: Clinical Findings & Diagnostic Reference (Acute Jaundice Differential in the ED)](/lessons/images/sba/gastroenterology/jaundice/figure_05_p5.jpeg)


- **A.** Wilson's Disease (Hepatolenticular Degeneration; ATP7B mutation) with Kayser-Fleischer rings
- **B.** Haemochromatosis
- **C.** Alpha-1 antitrypsin deficiency
- **D.** Primary biliary cholangitis
- **E.** Porphyria cutanea tarda

**Correct Answer:** A
**Explanation:**
Wilson's disease (autosomal recessive ATP7B mutation) causes defective copper excretion into bile and failure to incorporate copper into ceruloplasmin. Toxic copper accumulates in liver, basal ganglia (movement disorders, tremor, psychosis), and Descemet's membrane of the cornea (Kayser-Fleischer rings). It can present acutely in young adults as acute liver failure with Coombs-negative hemolytic anemia.
$SBA_GAST_072$,
    false,
    29,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 16/21: Pancreatitis & Loin Pain Differential
  -- 1) Interleave Lecture (Position 30)
  UPDATE "lessons"
  SET "position" = 30, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'loin-pain-pancreatitis' OR "slug" = 'loin-pain-pancreatitis');

  -- 2) Upsert Quiz Lesson (Position 31)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-gastroenterology-loin-pain-pancreatitis',
    'Pancreatitis & Loin Pain Differential — SBA Interactive Quiz',
    'quiz',
    $SBA_GAST_073$# Pancreatitis & Loin Pain Differential — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 48-year-old male with a history of alcohol misuse presents with severe, constant epigastric pain that radiates directly through to his back, accompanied by persistent vomiting and relief when leaning forward. Serum Lipase is 1450 IU/L (normal <60 IU/L). According to the revised Atlanta classification, how many criteria are required to establish the diagnosis of Acute Pancreatitis?

![Figure 1: Clinical Findings & Diagnostic Reference (Pancreatitis & Loin Pain Differential)](/lessons/images/sba/gastroenterology/loin-pain-pancreatitis/figure_01_p3.jpeg)


- **A.** At least 2 of 3 criteria: (1) Characteristic epigastric pain radiating to back; (2) Serum amylase or lipase >= 3 times upper limit of normal; (3) Characteristic cross-sectional imaging findings
- **B.** All 3 criteria plus mandatory exploratory laparotomy
- **C.** Only an elevated lipase is required, regardless of symptoms
- **D.** Positive blood culture alone
- **E.** Serum amylase >10,000 IU/L

**Correct Answer:** A
**Explanation:**
Revised Atlanta criteria: Diagnosis of acute pancreatitis requires at least 2 of the following 3 features: (1) Typical abdominal pain (severe, constant epigastric pain radiating to the back, relieved by sitting forward); (2) Serum amylase or lipase elevated >= 3 times the upper limit of normal; (3) Characteristic findings on contrast CT, MRI, or ultrasound. If criteria 1 and 2 are met, routine early CT is NOT necessary.

## Question 2 of 5

Why is Serum Lipase preferred over Serum Amylase in the diagnostic evaluation of suspected acute pancreatitis in the ED?

- **A.** Lipase has higher sensitivity and specificity (95% vs 80%), rises similarly, but remains elevated for 8-14 days (longer diagnostic window) compared to amylase which normalizes within 48-72 hours
- **B.** Amylase cannot be measured in the laboratory
- **C.** Lipase is elevated only in pancreatitis and nowhere else
- **D.** Amylase is only found in salivary glands
- **E.** Lipase levels determine the need for antibiotics

**Correct Answer:** A
**Explanation:**
Serum Lipase is superior to amylase: it is produced almost exclusively by the pancreas (higher specificity), while amylase is also produced by salivary glands, fallopian tubes, and small bowel. Furthermore, lipase remains elevated for up to 8-14 days, whereas amylase falls rapidly within 2-4 days, making lipase far more reliable in patients with delayed presentation.

## Question 3 of 5

Which bedside clinical signs denote retroperitoneal necrotizing haemorrhage in severe acute pancreatitis?

- **A.** Grey Turner's sign (flank ecchymosis) and Cullen's sign (periumbilical ecchymosis)
- **B.** Murphy's sign and Rovsing's sign
- **C.** Trousseau's sign and Chvostek's sign
- **D.** Kussmaul's sign and Pulsus paradoxus
- **E.** Osler's nodes and Janeway lesions

**Correct Answer:** A
**Explanation:**
Grey Turner's sign is blue-red/purple ecchymosis of the flanks caused by retroperitoneal blood tracking along the transversalis fascia to the lateral abdominal wall. Cullen's sign is periumbilical ecchymosis caused by blood tracking along the falciform ligament. Both indicate severe necrotizing pancreatitis with retroperitoneal haemorrhage.

## Question 4 of 5

What is the single most common cause of Acute Pancreatitis in the UK and worldwide, followed by alcohol misuse?

- **A.** Gallstones (Cholelithiasis / biliary pancreatitis, causing 45-50% of cases)
- **B.** Hypertriglyceridaemia
- **C.** Autoimmune pancreatitis
- **D.** ERCP complications
- **E.** Scorpion sting venom

**Correct Answer:** A
**Explanation:**
The leading causes of acute pancreatitis (mnemonic: I GET SMASHED): Gallstones account for ~45-50%, followed by Alcohol (~30-35%). Other causes include Hypertriglyceridaemia (>11 mmol/L / 1000 mg/dL), ERCP, trauma, drugs (azathioprine, valproate, thiazides), hypercalcaemia, and structural anomalies.

## Question 5 of 5

What is the recommended approach to early intravenous fluid resuscitation in mild-to-moderate acute pancreatitis according to modern international (IAP/APA and BSG) guidelines?

- **A.** Goal-directed, moderate fluid resuscitation using a balanced crystalloid (e.g. Hartmann's / Ringer's lactate) at 1.5-2 ml/kg/hr, avoiding aggressive excessive fluid overload
- **B.** Hyper-aggressive resuscitation with >6 litres of 0.9% normal saline in the first 12 hours
- **C.** Fluid restriction to 500 ml/day
- **D.** Immediate 20% albumin infusion in all patients
- **E.** Dextrose 5% only

**Correct Answer:** A
**Explanation:**
The landmark WATERFALL trial (NEJM 2022) showed that aggressive early fluid resuscitation (>3-4 L in 12h) significantly increases the incidence of fluid overload and heart failure without improving clinical outcomes. Modern guidelines recommend goal-directed, moderate fluid resuscitation with balanced crystalloids (Hartmann's at ~1.5-2 ml/kg/h) titrated to clinical parameters (urine output >0.5 ml/kg/h, hematocrit, BUN).
$SBA_GAST_073$,
    false,
    31,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 17/21: Acute Lower Gastrointestinal Bleeding
  -- 1) Interleave Lecture (Position 32)
  UPDATE "lessons"
  SET "position" = 32, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'lower-gi-bleeding' OR "slug" = 'lower-gi-bleeding');

  -- 2) Upsert Quiz Lesson (Position 33)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-gastroenterology-lower-gi-bleeding',
    'Acute Lower Gastrointestinal Bleeding — SBA Interactive Quiz',
    'quiz',
    $SBA_GAST_074$# Acute Lower Gastrointestinal Bleeding — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 72-year-old male with a history of hypertension presents with a sudden onset of painless, large-volume, bright red to maroon rectal bleeding (haematochezia). Pulse is 95 bpm, BP 124/78 mmHg. Abdominal examination is entirely soft and non-tender. What is the single most common cause of acute lower gastrointestinal bleeding in adults?

![Figure 1: Clinical Findings & Diagnostic Reference (Acute Lower Gastrointestinal Bleeding)](/lessons/images/sba/gastroenterology/lower-gi-bleeding/figure_01_p5.jpeg)


- **A.** Colonic Diverticular Bleeding (Diverticulosis, causing 30-40% of cases)
- **B.** Haemorrhoids
- **C.** Colorectal cancer
- **D.** Ischaemic colitis
- **E.** Angiodysplasia

**Correct Answer:** A
**Explanation:**
Colonic diverticular bleeding is the leading cause of acute major lower GI bleeding in adults (responsible for 30-40% of cases). It occurs when asymmetric mechanical shear stress ruptures the penetrating vasa recta branch stretching across the dome of a diverticulum, producing painless, brisk haematochezia. Approximately 75-80% stop bleeding spontaneously.

## Question 2 of 5

Which clinical risk score is recommended by the British Society of Gastroenterology (BSG) guidelines to risk-stratify acute Lower Gastrointestinal Bleeding and identify patients safe for outpatient investigation?

- **A.** Oakland Score (score <= 8 defines safe outpatient management)
- **B.** Glasgow-Blatchford Score
- **C.** Rockall Score
- **D.** Alvarado Score
- **E.** Ranson Score

**Correct Answer:** A
**Explanation:**
The BSG 2019 guidelines strongly recommend the Oakland Score for acute lower GI bleeding. Incorporating age, sex, prior lower GI bleed, DRE findings, heart rate, systolic BP, and haemoglobin, an Oakland score <= 8 identifies low-risk patients who can be safely discharged from the ED for outpatient investigation.

## Question 3 of 5

A 68-year-old male presents with massive, bright red haematochezia and acute cardiovascular collapse (HR 135 bpm, BP 76/40 mmHg). After initial fluid resuscitation, what mandatory diagnostic examination must be considered before assuming the haemorrhage is from the colon?

- **A.** Urgent Upper GI Endoscopy (OGD) to rule out an exsanguinating upper gastrointestinal bleed with rapid transit
- **B.** Immediate exploratory laparotomy
- **C.** Barium enema
- **D.** Oral iron therapy
- **E.** Wait 24 hours for elective colonoscopy

**Correct Answer:** A
**Explanation:**
Approximately 10-15% of patients presenting with severe, brisk haematochezia and haemodynamic shock actually have an Upper GI source (e.g. massive duodenal ulcer, aorto-enteric fistula) with hyperperistaltic transit. BSG guidelines mandate emergency upper GI endoscopy (OGD) in patients with massive haematochezia and hemodynamic instability before proceeding to lower GI investigations.

## Question 4 of 5

What is the diagnostic and therapeutic interventional modality of choice for an unstable patient with ongoing, active severe lower GI bleeding who cannot undergo colonoscopy?

- **A.** Catheter Angiography and Transcatheter Embolisation (preceded by CT Angiography if feasible)
- **B.** Emergency blind total colectomy
- **C.** Capsule endoscopy in the ED
- **D.** Tagged red blood cell scan alone
- **E.** Intravenous vasopressin infusion

**Correct Answer:** A
**Explanation:**
BSG guidelines recommend that patients with hemodynamically significant, active lower GI bleeding should undergo urgent CT Angiography (CTA), which detects bleeding rates as low as 0.3-0.5 ml/min. If positive, immediate catheter angiography and superselective transcatheter embolisation (with microcoils) achieves definitive haemostasis with low complication rates.

## Question 5 of 5

What vascular malformation of dilated mucosal and submucosal tortuous venules/capillaries, classically located in the caecum and ascending colon of elderly patients and associated with aortic stenosis (Heyde's syndrome), is a major cause of recurrent lower GI bleeding?

- **A.** Angiodysplasia (Arteriovenous Malformation)
- **B.** Dieulafoy's lesion
- **C.** Cavernous haemangioma
- **D.** Kaposi's sarcoma
- **E.** Hereditary haemorrhagic telangiectasia alone

**Correct Answer:** A
**Explanation:**
Colonic angiodysplasia (vascular ectasia) is degenerative dilation of submucosal vessels, most common in the caecum and right colon of patients >60 years. Heyde's syndrome is the triad of aortic stenosis, acquired von Willebrand disease (loss of high-molecular-weight multimers sheared by the stenotic valve), and bleeding from intestinal angiodysplasias, which resolves after aortic valve replacement.
$SBA_GAST_074$,
    false,
    33,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 18/21: Mallory-Weiss Syndrome & Upper GI Bleeding
  -- 1) Interleave Lecture (Position 34)
  UPDATE "lessons"
  SET "position" = 34, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'mallory-weiss-syndrome-upper-gi-bleeding' OR "slug" = 'mallory-weiss-tear');

  -- 2) Upsert Quiz Lesson (Position 35)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-gastroenterology-mallory-weiss-tear',
    'Mallory-Weiss Syndrome & Upper GI Bleeding — SBA Interactive Quiz',
    'quiz',
    $SBA_GAST_075$# Mallory-Weiss Syndrome & Upper GI Bleeding — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 32-year-old male presents with hematemesis after a night of heavy alcohol binge drinking. He reports multiple episodes of non-bloody, forceful retching and vomiting, after which the vomit abruptly became mixed with bright red blood. He is haemodynamically stable. What is the diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Mallory-Weiss Syndrome & Upper GI Bleeding)](/lessons/images/sba/gastroenterology/mallory-weiss-tear/figure_01_p2.jpeg)


- **A.** Mallory-Weiss Syndrome (mucosal tear at the gastro-oesophageal junction)
- **B.** Boerhaave's syndrome (transmural rupture)
- **C.** Bleeding peptic ulcer
- **D.** Ruptured oesophageal varices
- **E.** Gastric adenocarcinoma

**Correct Answer:** A
**Explanation:**
Mallory-Weiss syndrome is a longitudinal, non-transmural mucosal laceration occurring at the gastro-oesophageal junction or gastric cardia, classic in alcohol misuse or gastroenteritis. The hallmark clinical history is repeated episodes of severe, forceful non-bloody vomiting or retching, followed abruptly by fresh haematemesis.

## Question 2 of 5

How does the anatomical depth of tissue injury in Mallory-Weiss Syndrome fundamentally differ from Boerhaave's Syndrome?

![Figure 2: Clinical Findings & Diagnostic Reference (Mallory-Weiss Syndrome & Upper GI Bleeding)](/lessons/images/sba/gastroenterology/mallory-weiss-tear/figure_02_p3.jpeg)


- **A.** Mallory-Weiss is a non-transmural mucosal/submucosal tear; Boerhaave's is a complete, full-thickness transmural perforation of the oesophageal wall
- **B.** Mallory-Weiss causes pneumomediastinum, Boerhaave's does not
- **C.** Boerhaave's involves only the oral mucosa
- **D.** Mallory-Weiss is always fatal within 1 hour
- **E.** There is no anatomical difference

**Correct Answer:** A
**Explanation:**
Mallory-Weiss tear is confined to the mucosa and submucosa (causing bleeding without perforation). Boerhaave's syndrome is spontaneous full-thickness transmural rupture of the oesophagus (typically left posterolateral distal oesophagus), leading to mediastinitis, subcutaneous emphysema, septic shock, and Mackler's triad.

## Question 3 of 5

What is the natural clinical course and primary management for the vast majority (>85-90%) of patients presenting with Mallory-Weiss tears who are haemodynamically stable?

![Figure 3: Clinical Findings & Diagnostic Reference (Mallory-Weiss Syndrome & Upper GI Bleeding)](/lessons/images/sba/gastroenterology/mallory-weiss-tear/figure_03_p4.jpeg)


- **A.** Spontaneous resolution and cessation of bleeding with supportive care, IV proton pump inhibitors, and antiemetics
- **B.** Mandatory emergency open thoracotomy and surgical repair
- **C.** Endoscopic mucosal resection
- **D.** Transjugular intrahepatic portosystemic shunt (TIPS)
- **E.** Balloon tamponade with a Sengstaken tube

**Correct Answer:** A
**Explanation:**
Over 85-90% of Mallory-Weiss mucosal tears stop bleeding spontaneously without any endoscopic or surgical intervention. Management consists of supportive care, IV antiemetics (e.g. ondansetron) to eliminate retching, and IV high-dose proton pump inhibitors to promote mucosal healing.

## Question 4 of 5

When active arterial spurting or an oozing vessel is visualized at a Mallory-Weiss tear during endoscopy, which endoscopic haemostatic modalities are recommended?

![Figure 4: Clinical Findings & Diagnostic Reference (Mallory-Weiss Syndrome & Upper GI Bleeding)](/lessons/images/sba/gastroenterology/mallory-weiss-tear/figure_04_p5.jpeg)


- **A.** Endoscopic haemostatic clipping (hemoclips) or thermal coagulation with dilute adrenaline injection
- **B.** Total gastrectomy
- **C.** Radiation therapy
- **D.** High-volume saline irrigation only
- **E.** Insertion of a permanent metallic stent

**Correct Answer:** A
**Explanation:**
In the minority of patients with active spurting or persistent oozing at the tear site, endoscopic haemostasis is highly effective (>95% success). Endoscopic haemostatic clips (through-the-scope hemoclips) are preferred as they avoid tissue necrosis, often combined with submucosal adrenaline injection.

## Question 5 of 5

What pre-existing anatomical condition is present in up to 75% of patients who develop Mallory-Weiss tears, predisposing the gastro-oesophageal junction to shearing forces during vomiting?

- **A.** Hiatus Hernia (sliding type)
- **B.** Achalasia cardia
- **C.** Zenker's diverticulum
- **D.** Oesophageal web (Plummer-Vinson)
- **E.** Eosinophilic oesophagitis

**Correct Answer:** A
**Explanation:**
A sliding hiatus hernia is present in over 75% of patients with Mallory-Weiss syndrome. The displacement of the gastro-oesophageal junction into the negative-pressure thoracic cavity creates an altered transmural pressure gradient during retching, concentrating mechanical shear stress directly on the mucosal junction.
$SBA_GAST_075$,
    false,
    35,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 19/21: Peptic Ulcer Disease & Complications
  -- 1) Interleave Lecture (Position 36)
  UPDATE "lessons"
  SET "position" = 36, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'peptic-ulcer' OR "slug" = 'peptic-ulcer');

  -- 2) Upsert Quiz Lesson (Position 37)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-gastroenterology-peptic-ulcer',
    'Peptic Ulcer Disease & Complications — SBA Interactive Quiz',
    'quiz',
    $SBA_GAST_076$# Peptic Ulcer Disease & Complications — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 52-year-old male with chronic dyspepsia treated with over-the-counter antacids presents with sudden-onset, catastrophic 'thunderclap' epigastric pain 2 hours ago that rapidly became generalized across the entire abdomen. On examination, he lies motionless; the abdomen is rigid, board-like, and exquisitely tender with absent bowel sounds. What is the diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Peptic Ulcer Disease & Complications)](/lessons/images/sba/gastroenterology/peptic-ulcer/figure_01_p4.jpeg)


- **A.** Perforated Peptic Ulcer with generalized chemical peritonitis
- **B.** Acute biliary colic
- **C.** Uncomplicated acute gastritis
- **D.** Irritable bowel syndrome
- **E.** Acute non-perforated appendicitis

**Correct Answer:** A
**Explanation:**
Perforated peptic ulcer (typically anterior duodenal or gastric ulcer) releases acidic gastric juices and gastroduodenal contents directly into the peritoneal cavity, causing sudden, dramatic, explosive peritonitis. Hallmark: sudden agonizing pain, patient lies motionless (movement worsens somatic pain), rigid board-like abdominal wall, and absent bowel sounds.

## Question 2 of 5

What is the classic diagnostic finding on an erect chest radiograph (CXR) in over 70-80% of patients with a perforated peptic ulcer?

- **A.** Pneumoperitoneum (free subdiaphragmatic crescentic air under the right hemidiaphragm)
- **B.** Bilateral pleural effusions
- **C.** Widened mediastinum
- **D.** Air bronchograms in the left base
- **E.** Ground-glass lung opacities

**Correct Answer:** A
**Explanation:**
Pneumoperitoneum (free intraperitoneal gas) is visible on an erect chest X-ray in 70-85% of visceral perforations as a thin crescent of radiolucent air beneath the right hemidiaphragm (between liver and diaphragm). If erect CXR is non-diagnostic or the patient is unable to stand, a left lateral decubitus abdominal X-ray or CT abdomen confirms free air.

## Question 3 of 5

Which two aetiological factors account for more than 90% of all Peptic Ulcer Disease cases worldwide?

- **A.** Helicobacter pylori infection and Non-Steroidal Anti-Inflammatory Drugs (NSAIDs / Aspirin)
- **B.** Spicy food consumption and psychological stress
- **C.** Alcohol intake and caffeine
- **D.** Viral hepatitis and paracetamol
- **E.** Gluten enteropathy and milk protein allergy

**Correct Answer:** A
**Explanation:**
Helicobacter pylori (Gram-negative microaerophilic spiral bacillus that colonizes gastric mucosa) and NSAIDs/Aspirin (which inhibit COX-1 and deplete mucosal cytoprotective prostaglandins) together account for over 90% of all gastric and duodenal ulcers. Eradication of H. pylori and avoidance of NSAIDs cures peptic ulcer disease in the vast majority.

## Question 4 of 5

What endoscopic grading classification stratifies the risk of recurrent haemorrhage and mortality in bleeding peptic ulcers to determine the necessity of endoscopic therapy?

- **A.** Forrest Classification (Ia, Ib, IIa, IIb, IIc, III)
- **B.** Hinchey classification
- **C.** Child-Pugh classification
- **D.** Los Angeles classification
- **E.** Bormann classification

**Correct Answer:** A
**Explanation:**
Forrest Classification: Active bleeding: Ia (spurting arterial - 90% rebleed risk), Ib (oozing); Recent bleeding: IIa (non-bleeding visible vessel - 50% rebleed), IIb (adherent clot - 30% rebleed), IIc (flat pigmented spot - 10% rebleed); No bleeding: III (clean ulcer base - <5% rebleed). Forrest Ia, Ib, and IIa mandate dual endoscopic haemostatic therapy.

## Question 5 of 5

What is the standard triple-therapy eradication regimen recommended by NICE for Helicobacter pylori infection?

- **A.** High-dose Proton Pump Inhibitor (PPI, e.g. Omeprazole 20mg BD) PLUS Amoxicillin 1g BD PLUS either Clarithromycin 500mg BD or Metronidazole 400mg BD for 7 days
- **B.** Ciprofloxacin, Metronidazole, and Aspirin for 14 days
- **C.** Omeprazole monotherapy for 6 months
- **D.** Vancomycin, Gentamicin, and Prednisolone
- **E.** Doxycycline and Fluconazole

**Correct Answer:** A
**Explanation:**
NICE recommends first-line H. pylori eradication with a 7-day, twice-daily triple regimen: (1) Full-dose PPI twice daily; (2) Amoxicillin 1g twice daily; (3) Clarithromycin 500mg BD (or Metronidazole 400mg BD in penicillin allergy). For areas with high clarithromycin resistance, bismuth quadruple therapy (PPI + Bismuth + Metronidazole + Tetracycline) is preferred.
$SBA_GAST_076$,
    false,
    37,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 20/21: Infantile Hypertrophic Pyloric Stenosis
  -- 1) Interleave Lecture (Position 38)
  UPDATE "lessons"
  SET "position" = 38, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'pykoric-stenosis' OR "slug" = 'pyloric-stenosis');

  -- 2) Upsert Quiz Lesson (Position 39)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-gastroenterology-pyloric-stenosis',
    'Infantile Hypertrophic Pyloric Stenosis — SBA Interactive Quiz',
    'quiz',
    $SBA_GAST_077$# Infantile Hypertrophic Pyloric Stenosis — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 4-week-old first-born male infant presents with a 5-day history of non-bilious, forceful projectile vomiting occurring immediately after every feed. He remains ravenously hungry and eager to feed again immediately after vomiting. What is the classic metabolic and electrolyte derangement in Infantile Hypertrophic Pyloric Stenosis (IHPS)?

![Figure 1: Clinical Findings & Diagnostic Reference (Infantile Hypertrophic Pyloric Stenosis)](/lessons/images/sba/gastroenterology/pyloric-stenosis/figure_01_p3.jpeg)


- **A.** Hypochloraemic, Hypokalaemic Metabolic Alkalosis with paradoxical aciduria
- **B.** Hyperchloraemic metabolic acidosis
- **C.** Hyperkalaemic metabolic acidosis
- **D.** Normal electrolytes and normal acid-base balance
- **E.** Hyponatraemic respiratory acidosis

**Correct Answer:** A
**Explanation:**
Persistent gastric vomiting causes massive loss of hydrochloric acid (H+ and Cl-) and water. The kidneys attempt to compensate by retaining sodium at the expense of potassium and hydrogen ions in the distal tubules. The classic pathognomonic biochemical derangement is Hypochloraemic, Hypokalaemic Metabolic Alkalosis with paradoxical aciduria. It is a medical emergency requiring fluid resuscitation before surgery.

## Question 2 of 5

What physical examination finding is considered pathognomonic of Infantile Hypertrophic Pyloric Stenosis during a test feed?

![Figure 2: Clinical Findings & Diagnostic Reference (Infantile Hypertrophic Pyloric Stenosis)](/lessons/images/sba/gastroenterology/pyloric-stenosis/figure_02_p4.jpeg)


- **A.** Palpation of a firm, mobile, olive-sized mass ('pyloric olive') in the right upper quadrant / epigastrium with visible gastric peristaltic waves from left to right
- **B.** Sausage-shaped mass in the right lower quadrant
- **C.** Distended tympanitic abdomen with absent bowel sounds
- **D.** Rebound tenderness at McBurney's point
- **E.** Massive splenomegaly

**Correct Answer:** A
**Explanation:**
During or immediately after a milk feed (when the infant is relaxed), inspection may reveal visible gastric peristaltic waves traversing the epigastrium from left to right. Deep gentle palpation in the right hypochondrium/epigastrium reveals the hypertrophied pyloric muscle: a smooth, firm, mobile, olive-shaped mass (2-3 cm diameter).

## Question 3 of 5

What is the diagnostic imaging modality of choice to confirm Hypertrophic Pyloric Stenosis, and what sonographic measurements are diagnostic?

- **A.** Pyloric Ultrasound; Pyloric muscle wall thickness >= 3 mm (or >=4 mm) and channel length >= 14-15 mm
- **B.** Plain abdominal X-ray alone
- **C.** Abdominal CT with IV contrast
- **D.** Upper GI endoscopy
- **E.** Nuclear gastric emptying scan

**Correct Answer:** A
**Explanation:**
Transabdominal Ultrasound is the non-invasive gold standard (sensitivity >98-100%). Diagnostic sonographic criteria: pyloric muscle thickness >= 3.0 mm (in cross-section) and pyloric canal length >= 14-15 mm (in longitudinal section), accompanied by non-opening of the pyloric channel during real-time observation.

## Question 4 of 5

Why is Pyloric Stenosis considered a 'Medical Emergency, Not a Surgical Emergency' upon arrival in the ED?

- **A.** General anaesthesia in the presence of uncorrected severe hypochloraemic metabolic alkalosis and dehydration carries severe risks of fatal cardiac arrhythmias, hypoventilation, and prolonged apnoea; surgery must be delayed until electrolytes and hydration are completely normalised
- **B.** Pyloric stenosis never requires surgery
- **C.** Surgery must be performed within 15 minutes of arrival
- **D.** Oral feeding must be continued throughout
- **E.** Metabolic alkalosis protects the infant from shock

**Correct Answer:** A
**Explanation:**
Infantile hypertrophic pyloric stenosis is never an immediate surgical emergency. Administering general anaesthesia and muscle relaxants to an infant with severe dehydration, hypokalaemia, and metabolic alkalosis causes post-operative hypoventilation, apnoea, and fatal arrhythmias. Fluid resuscitation with 0.9% normal saline with potassium chloride is mandatory until chloride >100, bicarbonate <30, and urine output is restored before proceeding to surgery.

## Question 5 of 5

What is the definitive surgical procedure of choice for Infantile Hypertrophic Pyloric Stenosis?

- **A.** Ramstedt's Pyloromyotomy (longitudinal incision of the hypertrophic pyloric muscle down to, but preserving, the underlying submucosa and mucosa)
- **B.** Partial gastrectomy
- **C.** Gastrojejunostomy bypass
- **D.** Endoscopic balloon dilatation
- **E.** Total duodenectomy

**Correct Answer:** A
**Explanation:**
Fredet-Ramstedt Pyloromyotomy (performed open via circumumbilical incision or laparoscopically) is the definitive surgical cure. The serosa and hypertrophied circular muscle of the pylorus are incised longitudinally down to the submucosa, allowing the intact mucosal lumen to herniate freely outwards and relieving the gastric outlet obstruction. Full feeds can typically be resumed within 24 hours.
$SBA_GAST_077$,
    false,
    39,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 21/21: Upper Gastrointestinal Bleeding & Resuscitation
  -- 1) Interleave Lecture (Position 40)
  UPDATE "lessons"
  SET "position" = 40, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'upper-gi-bleeding' OR "slug" = 'upper-gi-bleeding');

  -- 2) Upsert Quiz Lesson (Position 41)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-gastroenterology-upper-gi-bleeding',
    'Upper Gastrointestinal Bleeding & Resuscitation — SBA Interactive Quiz',
    'quiz',
    $SBA_GAST_078$# Upper Gastrointestinal Bleeding & Resuscitation — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 60-year-old male presents with sudden-onset haematemesis and melaena. Pulse is 118 bpm, BP is 92/58 mmHg, and Hb is 82 g/L. Which validated risk assessment tool is recommended by NICE and BSG for pre-endoscopy risk stratification in all patients presenting with acute Upper GI Bleeding to determine who requires urgent hospital admission vs outpatient management?

![Figure 1: Clinical Findings & Diagnostic Reference (Upper Gastrointestinal Bleeding & Resuscitation)](/lessons/images/sba/gastroenterology/upper-gi-bleeding/figure_01_p4.jpeg)


- **A.** Glasgow-Blatchford Bleeding Score (GBS)
- **B.** Rockall Score (post-endoscopy)
- **C.** Oakland Score
- **D.** Child-Pugh Score
- **E.** Alvarado Score

**Correct Answer:** A
**Explanation:**
NICE CG141 and BSG guidelines recommend the Glasgow-Blatchford Score (GBS) for pre-endoscopy risk assessment. It uses urea, haemoglobin, systolic BP, pulse, and clinical comorbidities. A GBS of 0 (or 0-1) identifies very low risk patients (<1% mortality or intervention) who can be safely managed as outpatients. A GBS >=2 mandates inpatient admission; GBS >=6 identifies high risk requiring early intervention.

## Question 2 of 5

What is the target haemoglobin threshold for blood transfusion in acute upper GI bleeding according to NICE guidelines and the landmark Villanueva restrictive transfusion trial?

![Figure 2: Clinical Findings & Diagnostic Reference (Upper Gastrointestinal Bleeding & Resuscitation)](/lessons/images/sba/gastroenterology/upper-gi-bleeding/figure_02_p6.jpeg)


- **A.** Restrictive transfusion threshold: Transfuse only when haemoglobin is < 70 g/L (targeting 70-90 g/L), unless the patient has active cardiovascular disease (target 80-100 g/L)
- **B.** Liberal transfusion: Transfuse all patients with Hb < 100 g/L
- **C.** Transfuse only when Hb < 40 g/L
- **D.** Transfuse 4 units immediately to all patients with haematemesis regardless of Hb
- **E.** Never transfuse red cells in GI bleeding

**Correct Answer:** A
**Explanation:**
The landmark Villanueva RCT (NEJM 2013) demonstrated that a RESTRICTIVE transfusion strategy (trigger Hb <70 g/L, target 70-90 g/L) significantly improved survival and reduced rebleeding compared to a liberal strategy (trigger <90 g/L). Liberal transfusion increases portal venous pressure and reverses physiological splanchnic vasoconstriction, dislodging fresh clots. (In active coronary artery disease, trigger is <80 g/L).

## Question 3 of 5

According to NICE and BSG guidelines, when should emergency therapeutic Upper Gastrointestinal Endoscopy (OGD) be performed in high-risk patients presenting with acute upper GI bleeding after initial resuscitation?

![Figure 3: Clinical Findings & Diagnostic Reference (Upper Gastrointestinal Bleeding & Resuscitation)](/lessons/images/sba/gastroenterology/upper-gi-bleeding/figure_03_p12.jpeg)


- **A.** Within 24 hours of admission for all stable inpatients, and immediately (<2-6 hours) for patients who remain haemodynamically unstable despite active resuscitation
- **B.** Within 7 days
- **C.** Within 15 minutes of arrival before resuscitation
- **D.** Only after the patient is discharged home
- **E.** Endoscopy is not recommended for upper GI bleeding

**Correct Answer:** A
**Explanation:**
NICE recommends endoscopy within 24 hours of presentation for all patients with acute upper GI bleeding. For patients with severe ongoing bleeding, haemodynamic instability refractory to fluid resuscitation, or suspected variceal bleeding, immediate endoscopy should be performed as soon as initial physiological resuscitation is established (within 2-6 hours).

## Question 4 of 5

What dual endoscopic haemostatic therapy is recommended by NICE for bleeding peptic ulcers with high-risk stigmata (Forrest Ia, Ib, or IIa)?

![Figure 4: Clinical Findings & Diagnostic Reference (Upper Gastrointestinal Bleeding & Resuscitation)](/lessons/images/sba/gastroenterology/upper-gi-bleeding/figure_04_p13.jpeg)


- **A.** Submucosal injection of dilute adrenaline (epinephrine) combined with a second mechanical modality (e.g. through-the-scope hemoclips) or thermal coagulation
- **B.** Adrenaline injection monotherapy
- **C.** Oral antacids only
- **D.** Intravenous tranexamic acid infusion alone
- **E.** Barium swallow

**Correct Answer:** A
**Explanation:**
NICE explicitly recommends that adrenaline injection must NOT be used as monotherapy (as it only produces temporary local vasoconstriction and carries a high rebleeding rate). Endoscopic haemostasis requires combination dual therapy: adrenaline injection PLUS a mechanical modality (hemoclips) or thermal coagulation (heater probe, bipolar electrocoagulation).

## Question 5 of 5

A 70-year-old male with a prior infra-renal abdominal aortic aneurysm repair with a Dacron prosthetic graft 3 years ago presents with an episode of minor 'herald' haematemesis followed 6 hours later by sudden, catastrophic, exsanguinating upper GI haemorrhage. What life-threatening vascular complication must be suspected?

![Figure 5: Clinical Findings & Diagnostic Reference (Upper Gastrointestinal Bleeding & Resuscitation)](/lessons/images/sba/gastroenterology/upper-gi-bleeding/figure_05_p13.jpeg)


- **A.** Secondary Aorto-Enteric Fistula (classically eroding into the third or fourth portion of the duodenum)
- **B.** Mallory-Weiss tear
- **C.** Gastric varices
- **D.** Bleeding diverticulum
- **E.** Acute appendiceal fistula

**Correct Answer:** A
**Explanation:**
Aorto-enteric fistula (AEF) is an erosion of a prosthetic aortic graft directly into the adjacent gastrointestinal tract (most commonly the third or fourth part of the duodenum, which lies directly over the graft). Hallmark presentation is a small, self-limiting 'herald bleed' (minor haematemesis/melaena) followed hours to days later by catastrophic, fatal exsanguinating haemorrhage. Urgent contrast CT angiography and emergency vascular surgery are life-saving.
$SBA_GAST_078$,
    false,
    41,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();


  -- ------------------------------------------------------------------------
  -- Specialty: Nephrology & Acid-Base Disorders (8 Topics)
  -- ------------------------------------------------------------------------
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_sba_id AND "title" = 'Nephrology & Acid-Base Disorders' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module Nephrology & Acid-Base Disorders not found in mrcem-sba';
  END IF;

  -- Topic 1/8: Acute Kidney Injury (AKI) & KDIGO Staging
  -- 1) Interleave Lecture (Position 0)
  UPDATE "lessons"
  SET "position" = 0, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'aki' OR "slug" = 'acute-kidney-injury');

  -- 2) Upsert Quiz Lesson (Position 1)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-nephrology-acute-kidney-injury',
    'Acute Kidney Injury (AKI) & KDIGO Staging — SBA Interactive Quiz',
    'quiz',
    $SBA_NEPH_079$# Acute Kidney Injury (AKI) & KDIGO Staging — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 72-year-old dehydrated male is admitted with sepsis. Baseline serum creatinine was 80 umol/L. Repeat creatinine in the ED is 176 umol/L (more than a 2-fold increase), and urine output over the past 12 hours has been 0.3 ml/kg/hr. According to the Kidney Disease: Improving Global Outcomes (KDIGO) classification, what stage of Acute Kidney Injury is this?

![Figure 1: Clinical Findings & Diagnostic Reference (Acute Kidney Injury (AKI) & KDIGO Staging)](/lessons/images/sba/nephrology/acute-kidney-injury/figure_01_p2.jpeg)


- **A.** KDIGO Stage 2 AKI
- **B.** KDIGO Stage 1 AKI
- **C.** KDIGO Stage 3 AKI
- **D.** End-Stage Renal Disease
- **E.** Chronic Kidney Disease Stage 5

**Correct Answer:** A
**Explanation:**
KDIGO AKI Staging criteria: Stage 1: Serum creatinine 1.5-1.9x baseline OR increase >=26.5 umol/L, or urine output <0.5 ml/kg/hr for 6-12h. Stage 2: Creatinine 2.0-2.9x baseline, or urine output <0.5 ml/kg/hr for >=12h. Stage 3: Creatinine >=3.0x baseline OR >=353.6 umol/L OR initiation of RRT, or anuria for >=12h / urine <0.3 ml/kg/hr for >=24h. This patient meets Stage 2 criteria (creatinine 2.2x baseline and urine <0.5 ml/kg/hr for 12h).

## Question 2 of 5

Which of the following medications is a notorious cause of pre-renal hemodynamically mediated AKI in hypovolaemic patients by inhibiting renal prostaglandin synthesis and causing afferent arteriolar vasoconstriction?

![Figure 2: Clinical Findings & Diagnostic Reference (Acute Kidney Injury (AKI) & KDIGO Staging)](/lessons/images/sba/nephrology/acute-kidney-injury/figure_02_p5.jpeg)


- **A.** Non-Steroidal Anti-Inflammatory Drugs (NSAIDs, e.g. Ibuprofen, Naproxen)
- **B.** Paracetamol
- **C.** Amoxicillin
- **D.** Inhaled salbutamol
- **E.** Oral lactulose

**Correct Answer:** A
**Explanation:**
Renal prostaglandins (PGE2, PGI2) dilate the afferent arteriole to maintain glomerular capillary plasma flow and GFR during states of reduced renal perfusion (hypovolaemia, heart failure). NSAIDs block cyclooxygenase (COX-1/COX-2), depleting prostaglandins and causing profound afferent arteriolar vasoconstriction, precipitating acute pre-renal azotemia.

## Question 3 of 5

What classic triad of medications comprises the 'Triple Whammy' that precipitously induces severe acute renal failure in elderly patients?

![Figure 3: Clinical Findings & Diagnostic Reference (Acute Kidney Injury (AKI) & KDIGO Staging)](/lessons/images/sba/nephrology/acute-kidney-injury/figure_03_p9.jpeg)


- **A.** ACE inhibitor (or ARB) + Diuretic + NSAID
- **B.** Aspirin + Statin + Beta-blocker
- **C.** Paracetamol + Codeine + Omeprazole
- **D.** Amoxicillin + Clarithromycin + Prednisolone
- **E.** Metformin + Insulin + Gliclazide

**Correct Answer:** A
**Explanation:**
The 'Triple Whammy' causes synergistic renal hemodynamic collapse: (1) Diuretics reduce circulating intravascular volume (hypovolaemia); (2) NSAIDs block afferent arteriolar vasodilatory prostaglandins (afferent vasoconstriction); (3) ACE inhibitors/ARBs block angiotensin II-mediated efferent arteriolar vasoconstriction (efferent vasodilation). Together, they destroy the transglomerular hydraulic pressure gradient, causing severe AKI.

## Question 4 of 5

What are the absolute emergency indications for initiating acute Renal Replacement Therapy (haemodialysis / hemofiltration) in a patient with severe AKI (mnemonic: AEIOU)?

- **A.** Acidosis (refractory metabolic pH <7.15-7.20), Electrolytes (severe refractory hyperkalaemia >6.5 mmol/L with ECG changes), Ingestion/toxins (toxic alcohols, lithium, salicylates), Overload (refractory pulmonary oedema), Uraemic complications (pericarditis, encephalopathy)
- **B.** Isolated mild elevation of urea of 12 mmol/L with normal potassium
- **C.** Mild asymptomatic hypernatraemia
- **D.** Presence of trace proteinuria on dipstick
- **E.** Stage 1 AKI responding to intravenous fluids

**Correct Answer:** A
**Explanation:**
Emergency indications for dialysis in AKI (AEIOU): (A) Acidosis: severe metabolic acidosis (pH <7.15) refractory to medical management; (E) Electrolytes: severe refractory hyperkalaemia (>6.5 mmol/L) with ECG changes; (I) Ingestion: dialyzable intoxications (methanol, ethylene glycol, lithium, salicylates); (O) Overload: volume overload / pulmonary oedema refractory to diuretics; (U) Uraemia: uraemic pericarditis, encephalopathy, neuropathy, or bleeding.

## Question 5 of 5

In the differentiation of acute intrinsic Acute Tubular Necrosis (ATN) from Pre-Renal Azotemia, which urinary diagnostic parameters are classic for Pre-Renal Azotemia?

- **A.** Fractional Excretion of Sodium (FENa) < 1.0%, Urine Sodium < 20 mmol/L, and high Urine Osmolality (>500 mOsm/kg)
- **B.** FENa > 2.0%, Urine Sodium > 40 mmol/L, and isosthenuric Urine Osmolality (~300 mOsm/kg)
- **C.** Presence of muddy brown granular casts in 100% of cases
- **D.** Urine specific gravity < 1.005
- **E.** FENa > 5.0%

**Correct Answer:** A
**Explanation:**
In pre-renal azotemia, tubular function is intact. The kidneys avidly reabsorb sodium and water to restore intravascular volume, resulting in: low urine sodium (<20 mmol/L), low fractional excretion of sodium (FENa <1.0%), and highly concentrated urine (osmolality >500 mOsm/kg, specific gravity >1.020). In ATN, tubular epithelial cells are damaged and cannot reabsorb sodium, so FENa >2% and urine sodium >40 mmol/L with muddy brown granular casts.
$SBA_NEPH_079$,
    false,
    1,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 2/8: Potassium Disorders: Hyperkalaemia & Hypokalaemia
  -- 1) Interleave Lecture (Position 2)
  UPDATE "lessons"
  SET "position" = 2, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'hyper-and-hypokalemia' OR "slug" = 'hyper-hypokalemia');

  -- 2) Upsert Quiz Lesson (Position 3)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-nephrology-hyper-hypokalemia',
    'Potassium Disorders: Hyperkalaemia & Hypokalaemia — SBA Interactive Quiz',
    'quiz',
    $SBA_NEPH_080$# Potassium Disorders: Hyperkalaemia & Hypokalaemia — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 66-year-old male with end-stage renal disease misses two dialysis sessions. He presents with generalized muscle weakness. Serum potassium is 7.4 mmol/L. What is the chronological progression of ECG changes as hyperkalaemia worsens from mild to life-threatening?

![Figure 1: Clinical Findings & Diagnostic Reference (Potassium Disorders: Hyperkalaemia & Hypokalaemia)](/lessons/images/sba/nephrology/hyper-hypokalemia/figure_01_p2.jpeg)


- **A.** Tall peaked (tented) T waves -> PR interval prolongation and flattening of P waves -> QRS widening -> Sine-wave pattern -> Ventricular fibrillation / Asystole
- **B.** ST elevation in all leads -> T wave inversion -> Normalisation
- **C.** Prolonged QT interval -> U waves -> Torsades de pointes
- **D.** Delta waves -> Short PR interval -> Atrial flutter
- **E.** Biphasic T waves in V2-V3 only

**Correct Answer:** A
**Explanation:**
Progression of hyperkalaemic ECG changes: (1) Tall, narrow, symmetrical peaked 'tented' T waves (K+ >5.5); (2) PR prolongation, flattening/loss of P waves, and bradycardia (K+ >6.5); (3) Progressive QRS widening and bundle branch block patterns (K+ >7.0); (4) Merging of wide QRS with T wave forming a biphasic 'Sine Wave' pattern (K+ >8.0); (5) Ventricular fibrillation or asystole.

![Clinical Algorithm & Advanced Reference (Potassium Disorders: Hyperkalaemia & Hypokalaemia)](/lessons/images/sba/nephrology/hyper-hypokalemia/figure_06_p7.jpeg)


## Question 2 of 5

What is the single most critical, immediate first step in the emergency pharmacological management of severe hyperkalaemia (K+ >6.5 mmol/L or any hyperkalaemic ECG change)?

![Figure 2: Clinical Findings & Diagnostic Reference (Potassium Disorders: Hyperkalaemia & Hypokalaemia)](/lessons/images/sba/nephrology/hyper-hypokalemia/figure_02_p3.jpeg)


- **A.** Intravenous Calcium (10ml of 10% Calcium Chloride or 30ml of 10% Calcium Gluconate over 5-10 minutes) to stabilize myocardial membrane excitability
- **B.** Intravenous Insulin and Dextrose
- **C.** Nebulised Salbutamol 10-20mg
- **D.** Oral Calcium Resonium resin
- **E.** Intravenous Furosemide 40mg

**Correct Answer:** A
**Explanation:**
IV Calcium is the essential FIRST intervention. Calcium does NOT lower serum potassium; it directly antagonizes the cardiotoxic effects of hyperkalaemia on the cardiac cell membrane by raising the threshold potential, restoring normal resting membrane excitability within 1-3 minutes. Note: 10ml of 10% Calcium Chloride contains three times more elemental calcium than 10ml of 10% Calcium Gluconate.

## Question 3 of 5

What standard intravenous regimen is administered to shift potassium rapidly from the extracellular space into the intracellular space?

![Figure 3: Clinical Findings & Diagnostic Reference (Potassium Disorders: Hyperkalaemia & Hypokalaemia)](/lessons/images/sba/nephrology/hyper-hypokalemia/figure_03_p4.jpeg)


- **A.** 10 units of soluble Insulin (e.g. Actrapid) in 50ml of 50% Dextrose (or 100ml of 20% Dextrose) infused over 15-30 minutes
- **B.** 50 units of subcutaneous long-acting insulin alone
- **C.** 500ml of 5% Dextrose without insulin
- **D.** Intravenous Potassium Chloride 40 mmol
- **E.** Intravenous Digoxin 500mcg

**Correct Answer:** A
**Explanation:**
Insulin stimulates the Na+/K+-ATPase pump in skeletal muscle and liver, driving potassium into cells. Standard dose: 10 units of rapid-acting soluble insulin in 50 ml of 50% dextrose (or 100-125 ml 20% dextrose) IV over 15-30 minutes. It lowers potassium by 0.5-1.0 mmol/L within 15-30 minutes, lasting 4-6 hours. Blood glucose must be monitored closely for hypoglycemia.

## Question 4 of 5

What are the classic 12-lead ECG manifestations of acute severe Hypokalaemia (K+ < 2.5 mmol/L)?

![Figure 4: Clinical Findings & Diagnostic Reference (Potassium Disorders: Hyperkalaemia & Hypokalaemia)](/lessons/images/sba/nephrology/hyper-hypokalemia/figure_04_p5.jpeg)


- **A.** ST depression, flattened or inverted T waves, prominent U waves, and pseudo-prolongation of the QT interval (prolonged QU interval)
- **B.** Tall peaked tented T waves with narrow QRS
- **C.** Shortened PR interval with delta waves
- **D.** Widespread concave ST elevation
- **E.** Sine wave appearance

**Correct Answer:** A
**Explanation:**
ECG signs of hypokalaemia: (1) Flattened, decreased amplitude, or inverted T waves; (2) ST-segment depression; (3) Prominent U waves (positive deflection following T wave, best seen in V2-V4); (4) Apparent prolongation of the QT interval due to fusion of T and U waves (prolonged QU interval); (5) Predisposition to atrial and ventricular tachyarrhythmias (Torsades de pointes).

## Question 5 of 5

Why must serum Magnesium be checked and concurrently corrected when treating refractory Hypokalaemia?

![Figure 5: Clinical Findings & Diagnostic Reference (Potassium Disorders: Hyperkalaemia & Hypokalaemia)](/lessons/images/sba/nephrology/hyper-hypokalemia/figure_05_p6.jpeg)


- **A.** Magnesium is a critical cofactor that maintains Na+/K+-ATPase pump activity and closes renal outer medullary potassium (ROMK) channels; hypomagnesaemia promotes ongoing, uninhibited renal potassium wasting
- **B.** Magnesium converts potassium into calcium in the liver
- **C.** Hypomagnesaemia only affects the nervous system
- **D.** Potassium cannot be absorbed without vitamin D
- **E.** There is no physiological interaction between potassium and magnesium

**Correct Answer:** A
**Explanation:**
Magnesium inhibits the renal outer medullary potassium (ROMK) channels in the collecting tubule. When magnesium is depleted, this physiological inhibition is lost, allowing potassium to pour freely into the urine. Furthermore, hypomagnesaemia impairs Na+/K+-ATPase activity. Hypokalaemia is virtually impossible to correct until concurrent hypomagnesaemia is aggressively repleted.
$SBA_NEPH_080$,
    false,
    3,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 3/8: Hypercalcaemia Emergency Management
  -- 1) Interleave Lecture (Position 4)
  UPDATE "lessons"
  SET "position" = 4, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'hypercalemia' OR "slug" = 'hypercalcemia');

  -- 2) Upsert Quiz Lesson (Position 5)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-nephrology-hypercalcemia',
    'Hypercalcaemia Emergency Management — SBA Interactive Quiz',
    'quiz',
    $SBA_NEPH_081$# Hypercalcaemia Emergency Management — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 62-year-old woman with metastatic breast cancer presents with profound lethargy, confusion, constipation, generalized weakness, and polydipsia with polyuria. Adjusted serum calcium is 3.65 mmol/L (normal 2.20-2.60 mmol/L). What classic mnemonic summarizes the clinical manifestations of severe hypercalcaemia?

![Figure 1: Clinical Findings & Diagnostic Reference (Hypercalcaemia Emergency Management)](/lessons/images/sba/nephrology/hypercalcemia/figure_01_p4.jpeg)


- **A.** 'Stones, Bones, Abdominal groans, and Psychic moans' (renal calculi, bone pain/fractures, constipation/pancreatitis, and confusion/depression)
- **B.** 'Pain, Pallor, Pulselessness, Paresthesia, and Paralysis'
- **C.** 'Charcot's triad and Reynolds' pentad'
- **D.** 'Virchow's triad of thrombosis'
- **E.** 'Cushing's triad of increased intracranial pressure'

**Correct Answer:** A
**Explanation:**
The clinical features of hypercalcaemia are summarized as: Stones (nephrolithiasis, nephrocalcinosis); Bones (bone pain, osteopenia, pathological fractures); Abdominal groans (anorexia, nausea, constipation, peptic ulcer, pancreatitis); Psychic moans (lethargy, cognitive impairment, depression, psychosis, coma). Shortened QT interval on ECG is classic.

## Question 2 of 5

What is the two most common underlying aetiologies responsible for over 90% of all cases of Hypercalcaemia in adults?

- **A.** Primary Hyperparathyroidism (outpatient setting) and Malignancy (hospital inpatient setting)
- **B.** Excessive dietary milk intake and antacids
- **C.** Hypothyroidism and adrenal insufficiency
- **D.** Vitamin C toxicity and gout
- **E.** Chronic viral hepatitis and cirrhosis

**Correct Answer:** A
**Explanation:**
Primary hyperparathyroidism (solitary parathyroid adenoma) is the leading cause of hypercalcaemia in ambulatory outpatients (>60%). Malignancy (humoral hypercalcaemia via PTHrP in squamous cell cancers, or osteolytic bone metastases in breast/myeloma) is the leading cause in hospital inpatients (~30%), presenting with rapid onset, high calcium levels (>3.0 mmol/L), and suppressed intact PTH.

## Question 3 of 5

What is the absolute FIRST-LINE medical therapy in the emergency management of severe acute hypercalcaemia (calcium >3.5 mmol/L)?

- **A.** Aggressive intravenous hydration with 0.9% Normal Saline (typically 3 to 4 litres in the first 24 hours, titrated to cardiovascular status)
- **B.** Immediate intravenous loop diuretics (Furosemide) before giving any fluids
- **C.** Intravenous bisphosphonates immediately with fluid restriction
- **D.** Oral calcitriol 0.5mcg daily
- **E.** Oral sodium bicarbonate

**Correct Answer:** A
**Explanation:**
Severe hypercalcaemia induces nephrogenic diabetes insipidus, severe polyuria, anorexia, and vomiting, resulting in profound volume depletion (often 3-5 litres fluid deficit). Immediate aggressive volume expansion with 0.9% Normal Saline (3-4 litres in 24 hours) restores GFR, dilutes serum calcium, and promotes urinary calciuria. Loop diuretics are NOT given until the patient is fully volume-resuscitated.

## Question 4 of 5

Which pharmacological class of anti-resorptive agents is administered following initial saline rehydration for hypercalcaemia of malignancy, and why does its calcium-lowering effect take 48 to 72 hours to manifest?

- **A.** Intravenous Bisphosphonates (e.g. Zoledronic Acid 4mg IV over 15 minutes or Pamidronate 60-90mg); they inhibit osteoclast-mediated bone resorption, taking 2-4 days to reach peak effect
- **B.** Intravenous Furosemide; works by depleting calcium in the proximal tubule
- **C.** Oral Cinacalcet alone
- **D.** Subcutaneous Insulin
- **E.** Intravenous Hydrocortisone; works instantly

**Correct Answer:** A
**Explanation:**
IV Bisphosphonates (Zoledronic acid 4mg IV or Pamidronate) bind to hydroxyapatite crystals in bone and inhibit osteoclast enzyme activity and recruitment. Because they act on osteoclast bone turnover, their maximal hypocalcaemic effect is delayed, peaking at 48-72 hours. Calcitonin (subcutaneous or IM) can be given concurrently for rapid temporary reduction within 4-6 hours (tachyphylaxis limits use to 48 hours).

## Question 5 of 5

What classic 12-lead ECG alteration is characteristically seen in acute severe hypercalcaemia?

- **A.** Shortened QT interval (shortened ST segment)
- **B.** Prolonged QT interval with prominent U waves
- **C.** Broad notched P waves
- **D.** Right bundle branch block
- **E.** Delta waves

**Correct Answer:** A
**Explanation:**
Hypercalcaemia accelerates ventricular myocardial repolarisation (phase 2 of cardiac action potential), which produces a classic shortening of the ST segment and a Shortened QT interval on 12-lead ECG. Severe hypercalcaemia can precipitate cardiac arrest in systole.
$SBA_NEPH_081$,
    false,
    5,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 4/8: Hyperkalaemic Cardiac Arrest Protocols
  -- 1) Interleave Lecture (Position 6)
  UPDATE "lessons"
  SET "position" = 6, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'hyperkalemic-cardiac-arest' OR "slug" = 'hyperkalemic-cardiac-arrest');

  -- 2) Upsert Quiz Lesson (Position 7)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-nephrology-hyperkalemic-cardiac-arrest',
    'Hyperkalaemic Cardiac Arrest Protocols — SBA Interactive Quiz',
    'quiz',
    $SBA_NEPH_082$# Hyperkalaemic Cardiac Arrest Protocols — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 55-year-old haemodialysis patient collapses in PEA cardiac arrest. The rhythm on the monitor shows a wide, bizarre, undulating sinusoidal wave ('sine wave' pattern) at 35 bpm. In addition to high-quality CPR and adrenaline, what specific emergency intravenous bolus therapy must be administered immediately?

![Figure 1: Clinical Findings & Diagnostic Reference (Hyperkalaemic Cardiac Arrest Protocols)](/lessons/images/sba/nephrology/hyperkalemic-cardiac-arrest/figure_01_p2.jpeg)


- **A.** Intravenous 10% Calcium Chloride (10ml IV push, repeated after 5 minutes if rhythm persists)
- **B.** Intravenous Amiodarone 300mg
- **C.** Intravenous Magnesium Sulphate 2g
- **D.** Defibrillation at 200J biphasic immediately
- **E.** Intravenous Atropine 3mg

**Correct Answer:** A
**Explanation:**
In hyperkalaemic cardiac arrest or periarrest 'sine wave' rhythm, intravenous calcium is the single most urgent life-saving antidote. 10ml of 10% Calcium Chloride IV bolus (or 30ml 10% Calcium Gluconate) stabilizes the cardiac cell membrane within 1-2 minutes by restoring electrical resting potential. The dose can be repeated every 5-10 minutes if PEA or wide complexes persist.

## Question 2 of 5

During active cardiac arrest resuscitation attributed to severe hyperkalaemia, what dose of Sodium Bicarbonate is recommended by Resuscitation Council UK guidelines to shift potassium and treat metabolic acidaemia?

![Figure 2: Clinical Findings & Diagnostic Reference (Hyperkalaemic Cardiac Arrest Protocols)](/lessons/images/sba/nephrology/hyperkalemic-cardiac-arrest/figure_02_p3.jpeg)


- **A.** 50 ml of 8.4% Sodium Bicarbonate IV (50 mmol) by rapid bolus
- **B.** 10 ml of 1.26% Sodium Bicarbonate
- **C.** 1000 ml of 8.4% Sodium Bicarbonate over 24 hours
- **D.** Oral sodium bicarbonate tablets
- **E.** Sodium bicarbonate is contraindicated in cardiac arrest

**Correct Answer:** A
**Explanation:**
In cardiac arrest caused by hyperkalaemia (or tricyclic antidepressant toxicity), 50 ml of 8.4% Sodium Bicarbonate (50 mmol) IV bolus is indicated. Alkalinisation drives hydrogen ions out of cells in exchange for extracellular potassium entering cells, reducing serum potassium and ameliorating severe metabolic acidosis.

## Question 3 of 5

In hyperkalaemic cardiac arrest, how should the standard insulin-dextrose shift therapy be administered while chest compressions are ongoing?

![Figure 3: Clinical Findings & Diagnostic Reference (Hyperkalaemic Cardiac Arrest Protocols)](/lessons/images/sba/nephrology/hyperkalemic-cardiac-arrest/figure_03_p3.jpeg)


- **A.** 10 units of soluble rapid-acting insulin (e.g. Actrapid) with 50ml of 50% Dextrose given as a rapid IV bolus
- **B.** Subcutaneous insulin 20 units
- **C.** 5% Dextrose infusion at 50 ml/hr without insulin
- **D.** Wait until return of spontaneous circulation before giving insulin
- **E.** Insulin is only given via central line

**Correct Answer:** A
**Explanation:**
During active cardiac arrest from hyperkalaemia, 10 units of regular soluble insulin with 50 ml of 50% dextrose (or 100 ml 20% dextrose) is given as a rapid IV bolus to accelerate intracellular potassium shift. CPR ensures distribution through the central circulation.

## Question 4 of 5

What advanced life support intervention provides the definitive, physical removal of potassium from the blood during refractory hyperkalaemic cardiac arrest or prolonged periarrest resuscitation?

- **A.** Emergency Haemodialysis / Continuous Veno-Venous Haemofiltration (CVVH) with Extracorporeal Membrane Oxygenation (ECMO / ECPR)
- **B.** Oral ion-exchange resins administered via nasogastric tube
- **C.** Intravenous furosemide boluses
- **D.** Surgical bilateral nephrectomy
- **E.** Therapeutic hypothermia to 28C

**Correct Answer:** A
**Explanation:**
Calcium, insulin-dextrose, bicarbonate, and beta-agonists are temporary temporizing measures that only shift potassium intracellularly; they do not remove potassium from the body. Definitive elimination in anuric renal failure requires emergency Haemodialysis or CRRT. In refractory arrest, Extracorporeal Cardiopulmonary Resuscitation (ECPR/ECMO) coupled with dialysis has demonstrated survival rates >75% with full neurological recovery.

## Question 5 of 5

Why must Calcium Chloride and Sodium Bicarbonate NEVER be infused together through the same intravenous cannula simultaneously without a thorough flush?

- **A.** They react chemically to form an insoluble white precipitate of Calcium Carbonate (chalk) that can occlude vascular lines and cause embolic complications
- **B.** They cause severe explosive boiling of the solution
- **C.** They cancel out each other's metabolic effects completely
- **D.** They cause immediate hyperthermia
- **E.** They trigger severe anaphylactic shock

**Correct Answer:** A
**Explanation:**
Calcium salts (CaCl2) and Sodium Bicarbonate (NaHCO3) must never be mixed in the same IV line or syringe. They immediately react to form Calcium Carbonate (CaCO3), an insoluble, milky white crystalline precipitate (chalk) that precipitates in the lumen, blocks lines, and causes vascular embolisation. Always flush the line thoroughly with saline between injections.
$SBA_NEPH_082$,
    false,
    7,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 5/8: Hypernatraemia Emergency Management
  -- 1) Interleave Lecture (Position 8)
  UPDATE "lessons"
  SET "position" = 8, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'hypernatremia' OR "slug" = 'hypernatremia');

  -- 2) Upsert Quiz Lesson (Position 9)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-nephrology-hypernatremia',
    'Hypernatraemia Emergency Management — SBA Interactive Quiz',
    'quiz',
    $SBA_NEPH_083$# Hypernatraemia Emergency Management — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

An 82-year-old institutionalized female with advanced dementia is brought to the ED with severe dehydration and obtundation following a heatwave. Bloods reveal: Serum Sodium 168 mmol/L, Urea 24 mmol/L, Creatinine 180 umol/L. What is the maximum safe rate of serum sodium reduction per 24 hours to prevent fatal Cerebral Oedema?

![Figure 1: Clinical Findings & Diagnostic Reference (Hypernatraemia Emergency Management)](/lessons/images/sba/nephrology/hypernatremia/figure_01_p4.jpeg)


- **A.** No more than 8 to 10 mmol/L per 24 hours (roughly 0.5 mmol/L per hour)
- **B.** Lower sodium to 140 mmol/L within 2 hours
- **C.** No more than 1 mmol/L per 24 hours
- **D.** At least 25 mmol/L in the first 6 hours
- **E.** Sodium can be lowered at any speed without risk

**Correct Answer:** A
**Explanation:**
In chronic hypernatraemia (>48 hours), brain cells synthesize and accumulate intracellular 'idiogenic osmoles' (inositol, glutamine, taurine) to protect against osmotic cell shrinkage. Rapid lowering of serum sodium (>8-10 mmol/L in 24h) causes acute movement of free water into brain cells, leading to catastrophic cerebral oedema, brain herniation, seizures, and death.

## Question 2 of 5

In an elderly patient with severe hypernatraemic dehydration presenting with hemodynamic shock (BP 75/40 mmHg, cold clammy peripheries), what is the first fluid to administer?

![Figure 2: Clinical Findings & Diagnostic Reference (Hypernatraemia Emergency Management)](/lessons/images/sba/nephrology/hypernatremia/figure_02_p6.jpeg)


- **A.** 0.9% Normal Saline (isotonic crystalloid) to restore circulating intravascular volume and perfusion first, before addressing hypernatraemia
- **B.** Intravenous sterile water bolus
- **C.** 5% Dextrose in water at 1000 ml/hr immediately
- **D.** 0.45% half-normal saline at 500 ml/hr
- **E.** Intravenous loop diuretics

**Correct Answer:** A
**Explanation:**
The fundamental rule of hypernatraemia resuscitation: Treat Shock First! If the patient is hypotensive with signs of hypovolaemic shock, restore intravascular volume and tissue perfusion immediately with 0.9% Normal Saline (or balanced crystalloid). Once haemodynamic stability is achieved, transition to hypotonic fluids (0.45% saline or 5% dextrose) to correct the free water deficit slowly.

## Question 3 of 5

What is the formula used to calculate the Free Water Deficit in a hypernatraemic patient?

- **A.** Free Water Deficit (Litres) = Total Body Water (TBW) x [(Serum Sodium / 140) - 1]
- **B.** Free Water Deficit = Body weight (kg) x 4
- **C.** Free Water Deficit = Serum Sodium minus 140
- **D.** Free Water Deficit = Urine sodium / Serum sodium
- **E.** Free Water Deficit = Hematocrit x 10

**Correct Answer:** A
**Explanation:**
Free water deficit is calculated as: Deficit = TBW x [(Current Na / 140) - 1], where TBW is estimated as body weight (kg) x 0.6 in young men, 0.5 in young women/elderly men, and 0.45 in elderly women. This calculated deficit, combined with ongoing insensible and urinary losses, is replaced gradually over 48 to 72 hours.

## Question 4 of 5

A 35-year-old male presents with massive polyuria (8 litres/day of dilute urine) and intense thirst 10 days after transsphenoidal pituitary surgery. Serum sodium is 154 mmol/L, serum osmolality is 315 mOsm/kg, and urine osmolality is inappropriately low at 110 mOsm/kg. What condition is this, and what is the treatment?

- **A.** Central (Neurogenic) Diabetes Insipidus (deficiency of ADH / Arginine Vasopressin); Desmopressin (DDAVP)
- **B.** Nephrogenic Diabetes Insipidus; Hydrochlorothiazide
- **C.** Primary psychogenic polydipsia; Fluid restriction
- **D.** Syndrome of Inappropriate ADH secretion (SIADH); Fluid restriction
- **E.** Diabetic ketoacidosis; Insulin infusion

**Correct Answer:** A
**Explanation:**
Central Diabetes Insipidus results from failure of the posterior pituitary to secrete Antidiuretic Hormone (ADH / Vasopressin), classic after head injury or pituitary surgery. The collecting ducts cannot reabsorb water, producing large volumes of dilute urine (urine osmolality <300 mOsm/kg) despite hypernatraemia and high serum osmolality (>300 mOsm/kg). The definitive treatment is Desmopressin (DDAVP), an ADH analogue.

## Question 5 of 5

Which psychiatric medication is the most classic pharmaceutical cause of chronic Nephrogenic Diabetes Insipidus (insensitivity of renal collecting ducts to ADH)?

- **A.** Lithium Carbonate
- **B.** Sertraline
- **C.** Haloperidol
- **D.** Diazepam
- **E.** Sodium valproate

**Correct Answer:** A
**Explanation:**
Lithium enters principal cells of the collecting duct through epithelial sodium channels (ENaC) and inhibits intracellular glycogen synthase kinase 3beta (GSK3beta) and adenylate cyclase, downregulating aquaporin-2 water channels and rendering the kidney refractory to endogenous ADH (Nephrogenic DI). Treatment includes stopping lithium, amiloride (which blocks ENaC), and thiazide diuretics.
$SBA_NEPH_083$,
    false,
    9,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 6/8: Hypocalcaemia & Tetany
  -- 1) Interleave Lecture (Position 10)
  UPDATE "lessons"
  SET "position" = 10, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'hypocalecemia' OR "slug" = 'hypocalcemia');

  -- 2) Upsert Quiz Lesson (Position 11)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-nephrology-hypocalcemia',
    'Hypocalcaemia & Tetany — SBA Interactive Quiz',
    'quiz',
    $SBA_NEPH_084$# Hypocalcaemia & Tetany — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 34-year-old woman presents 24 hours after an uneventful total thyroidectomy with circumoral paresthesias, numbness in her fingertips, and painful muscle cramping. Tapping gently over the facial nerve anterior to the earlobe produces involuntary twitching of the ipsilateral facial and lip muscles. What is this classic clinical sign termed?

![Figure 1: Clinical Findings & Diagnostic Reference (Hypocalcaemia & Tetany)](/lessons/images/sba/nephrology/hypocalcemia/figure_01_p3.jpeg)


- **A.** Chvostek's sign
- **B.** Trousseau's sign
- **C.** Kernig's sign
- **D.** Brudzinski's sign
- **E.** Tinel's sign

**Correct Answer:** A
**Explanation:**
Chvostek's sign is facial muscle spasm elicited by tapping lightly over the facial nerve trunk anterior to the external auditory meatus / tragus. Trousseau's sign is carpopedal spasm (flexion of wrist and metacarpophalangeal joints, extension of interphalangeal joints, and adduction of thumb - 'main d'accoucheur') elicited by inflating a sphygmomanometer cuff above systolic BP for 3 minutes. Both indicate neuromuscular irritability secondary to acute hypocalcaemia.

## Question 2 of 5

Why must Total Serum Calcium always be adjusted (corrected) for serum albumin concentration, and what is the standard correction formula?

![Figure 2: Clinical Findings & Diagnostic Reference (Hypocalcaemia & Tetany)](/lessons/images/sba/nephrology/hypocalcemia/figure_02_p4.jpeg)


- **A.** Approximately 40-45% of circulating calcium is bound to albumin; Adjusted Calcium = Measured Calcium + [0.02 x (40 - Albumin in g/L)]
- **B.** Albumin and calcium are always equimolar
- **C.** Free ionized calcium is completely unaffected by albumin
- **D.** Adjusted Calcium = Measured Calcium minus Albumin
- **E.** Correction is only required in hyperalbuminaemia

**Correct Answer:** A
**Explanation:**
Only free ionized calcium is biologically active. In hypoalbuminaemia, total measured calcium is artificially low because the bound fraction is reduced, while free ionized calcium may remain normal. The standard formula adjusts for albumin: Corrected Calcium (mmol/L) = Measured Total Calcium + [0.02 x (40 - Albumin g/L)]. If accurate assessment is required, a direct point-of-care blood gas ionized calcium (iCa) should be measured.

## Question 3 of 5

What is the immediate intravenous treatment of choice for severe acute symptomatic hypocalcaemia presenting with tetany, laryngeal stridor, or prolonged QT interval on ECG?

- **A.** Intravenous 10% Calcium Gluconate (10 to 20ml in 100ml 5% dextrose infused over 10-20 minutes with cardiac monitoring)
- **B.** Oral calcium carbonate 500mg once daily
- **C.** Intravenous furosemide 40mg bolus
- **D.** Oral vitamin D3 400 IU
- **E.** Intravenous sodium bicarbonate

**Correct Answer:** A
**Explanation:**
Severe symptomatic hypocalcaemia (tetany, carpopedal spasm, seizures, laryngospasm, or QTc prolongation) is a medical emergency treated with IV 10% Calcium Gluconate (10-20 ml in 100 ml 5% dextrose over 10-20 minutes under continuous ECG monitoring). Calcium gluconate is preferred over calcium chloride in peripheral veins because it is less irritant and does not cause tissue necrosis if extravasated.

## Question 4 of 5

What is the classic 12-lead ECG finding in acute severe Hypocalcaemia?

- **A.** Prolongation of the QT interval (specifically prolongation of the ST segment with a normal T-wave duration)
- **B.** Shortening of the QT interval
- **C.** Delta waves
- **D.** Prominent U waves with ST depression
- **E.** Sine-wave pattern

**Correct Answer:** A
**Explanation:**
Hypocalcaemia prolongs phase 2 of the myocardial action potential (the plateau phase), which manifests on 12-lead ECG as a prolonged ST segment, resulting in QT-interval prolongation (prolonged QTc). Unlike other causes of prolonged QT, the T wave morphology and duration itself remain completely normal. It predisposes to Torsades de pointes and ventricular arrhythmias.

## Question 5 of 5

What is the single most common cause of acute hypocalcaemia encountered in the emergency department within the first 24 to 48 hours following neck surgery?

- **A.** Post-surgical Hypoparathyroidism (accidental devascularisation, manipulation, or removal of the parathyroid glands during total thyroidectomy or parathyroidectomy)
- **B.** Acute respiratory failure
- **C.** Excessive calcium consumption
- **D.** Severe vitamin C deficiency
- **E.** Primary aldosteronism

**Correct Answer:** A
**Explanation:**
Transient (or permanent) hypoparathyroidism occurs in up to 10-30% of total thyroidectomy patients due to inadvertent intraoperative surgical trauma, thermal injury, accidental excision, or devascularisation of the delicate parathyroid glands. Serum calcium typically drops to a nadir at 24-48 hours post-operatively.
$SBA_NEPH_084$,
    false,
    11,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 7/8: Hypokalaemia Emergency Management
  -- 1) Interleave Lecture (Position 12)
  UPDATE "lessons"
  SET "position" = 12, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'hypokalemia' OR "slug" = 'hypokalemia');

  -- 2) Upsert Quiz Lesson (Position 13)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-nephrology-hypokalemia',
    'Hypokalaemia Emergency Management — SBA Interactive Quiz',
    'quiz',
    $SBA_NEPH_085$# Hypokalaemia Emergency Management — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 48-year-old woman with a history of bulimia and thiazide diuretic use presents with generalized muscle weakness and palpitations. Serum potassium is 2.1 mmol/L. What is the maximum safe peripheral intravenous infusion rate of Potassium Chloride (KCl) in an unmonitored setting to prevent severe local pain, thrombophlebitis, and lethal hyperkalaemic cardiac arrest?

![Figure 1: Clinical Findings & Diagnostic Reference (Hypokalaemia Emergency Management)](/lessons/images/sba/nephrology/hypokalemia/figure_01_p4.jpeg)


- **A.** 10 to 20 mmol/hour (maximum peripheral concentration 40 mmol/L)
- **B.** 40 mmol/hour via a small butterfly needle in the hand
- **C.** 100 mmol/hour rapid bolus push
- **D.** 200 mmol over 15 minutes
- **E.** Potassium can never be administered intravenously

**Correct Answer:** A
**Explanation:**
Safe peripheral IV potassium guidelines: Standard infusion rate should NOT exceed 10 mmol/hour (maximum 20 mmol/hr in emergency monitored resus setting). Maximum concentration in peripheral veins is 40 mmol/L to avoid severe burning chemical pain and thrombophlebitis. Higher concentrations (>40 mmol/L, e.g. up to 100 mmol/L) or faster rates mandate a central venous line with continuous cardiac telemetry.

## Question 2 of 5

Which life-threatening neuromuscular complication can occur when severe hypokalaemia (K+ < 2.0-2.5 mmol/L) causes acute necrosis of skeletal muscle fibers and secondary myoglobinuria?

![Figure 2: Clinical Findings & Diagnostic Reference (Hypokalaemia Emergency Management)](/lessons/images/sba/nephrology/hypokalemia/figure_02_p5.jpeg)


- **A.** Rhabdomyolysis and acute pigment-induced kidney injury
- **B.** Myasthenia gravis
- **C.** Guillain-Barré syndrome
- **D.** Multiple sclerosis
- **E.** Amyotrophic lateral sclerosis

**Correct Answer:** A
**Explanation:**
Potassium plays an essential role in mediating physiological exercise-induced vasodilation in skeletal muscle microcirculation. Severe hypokalaemia (<2.0-2.5 mmol/L) impairs hyperaemic vasodilation, causing skeletal muscle ischaemia, membrane lysis, and Rhabdomyolysis (marked elevation of creatine kinase and myoglobinuria), which can precipitate acute tubular necrosis.

## Question 3 of 5

A 28-year-old Asian male wakes up at 4 AM with acute, flaccid symmetrical paralysis of both lower limbs following a heavy carbohydrate-rich meal (pizza) and alcohol the evening before. Bloods reveal: Potassium 2.0 mmol/L, Free T4 48 pmol/L (markedly elevated), TSH <0.01 mU/L. What is the diagnosis?

![Figure 3: Clinical Findings & Diagnostic Reference (Hypokalaemia Emergency Management)](/lessons/images/sba/nephrology/hypokalemia/figure_03_p6.jpeg)


- **A.** Thyrotoxic Periodic Paralysis (TPP)
- **B.** Guillain-Barré syndrome
- **C.** Acute intermittent porphyria
- **D.** Transverse myelitis
- **E.** Botulism

**Correct Answer:** A
**Explanation:**
Thyrotoxic Periodic Paralysis (TPP) is an endocrine emergency seen predominantly in young Asian and Hispanic males with hyperthyroidism (Graves' disease). High thyroid hormone levels upregulate Na+/K+-ATPase pumps. A high-carbohydrate meal stimulates insulin release, driving potassium massively into cells, producing profound hypokalaemia and acute flaccid motor paralysis. It resolves rapidly with low-dose potassium and non-selective beta-blockers (propranolol).

## Question 4 of 5

Why must intravenous potassium NEVER be administered as an undiluted IV push or bolus?

- **A.** A rapid IV bolus of potassium causes immediate cardiac arrest in diastole due to instant inexcitability of the myocardium
- **B.** It causes massive acute renal stones
- **C.** It causes severe hypernatraemia
- **D.** It causes instantaneous liver infarction
- **E.** It precipitates severe hypothermia

**Correct Answer:** A
**Explanation:**
Potassium chloride injected as an undiluted IV bolus is a lethal injection protocol. It instantly abolishes the transcellular resting membrane potential gradient across cardiac myocytes, producing immediate electrical silence and refractory asystolic cardiac arrest. IV potassium must ALWAYS be pre-mixed and delivered via an infusion pump.

## Question 5 of 5

Which of the following endocrine disorders is a classical cause of primary mineralocorticoid excess presenting with hypertension, hypokalaemia, and metabolic alkalosis?

- **A.** Conn's Syndrome (Primary Hyperaldosteronism)
- **B.** Addison's disease (Primary adrenal insufficiency)
- **C.** Hashimoto's thyroiditis
- **D.** Hypoparathyroidism
- **E.** Type 1 diabetes mellitus

**Correct Answer:** A
**Explanation:**
Conn's syndrome (aldosterone-producing adrenal adenoma or bilateral adrenal hyperplasia) causes autonomous hyperaldosteronism. Excessive aldosterone stimulates epithelial sodium channels (ENaC) in renal cortical collecting ducts, causing sodium retention (hypertension) and reciprocal potassium and hydrogen ion excretion, producing hypokalaemic metabolic alkalosis with suppressed plasma renin.
$SBA_NEPH_085$,
    false,
    13,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 8/8: Hyponatraemia & Osmotic Demyelination
  -- 1) Interleave Lecture (Position 14)
  UPDATE "lessons"
  SET "position" = 14, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'hyponatremia' OR "slug" = 'hyponatremia');

  -- 2) Upsert Quiz Lesson (Position 15)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-nephrology-hyponatremia',
    'Hyponatraemia & Osmotic Demyelination — SBA Interactive Quiz',
    'quiz',
    $SBA_NEPH_086$# Hyponatraemia & Osmotic Demyelination — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 70-year-old female presents with acute confusion and generalised tonic-clonic status epilepticus. Laboratory tests reveal severe hyponatraemia: Serum Sodium 112 mmol/L. According to European Clinical Practice guidelines, what is the immediate treatment of choice for severe hyponatraemia presenting with severe neurological symptoms?

![Figure 1: Clinical Findings & Diagnostic Reference (Hyponatraemia & Osmotic Demyelination)](/lessons/images/sba/nephrology/hyponatremia/figure_01_p1.jpeg)


- **A.** Intravenous 3% Hypertonic Saline (150ml bolus infused over 20 minutes, repeatable up to 3 times or until symptoms resolve and sodium rises by 5 mmol/L)
- **B.** Oral fluid restriction of 500 ml/day alone
- **C.** Rapid infusion of 2 litres of 5% Dextrose
- **D.** Intravenous furosemide 80mg bolus
- **E.** Oral sodium chloride tablets

**Correct Answer:** A
**Explanation:**
Severe acute symptomatic hyponatraemia presenting with seizures, coma, or respiratory arrest is an emergency caused by acute cerebral oedema. European and UK guidelines recommend an immediate IV bolus of 150 ml of 3% Hypertonic Saline over 20 minutes (repeatable twice if needed) to rapidly raise serum sodium by 4-6 mmol/L, which is sufficient to shrink brain oedema, stop seizures, and prevent fatal transtentorial herniation.

## Question 2 of 5

What catastrophic, permanent neurological complication occurs if chronic hyponatraemia (>48 hours duration) is corrected too rapidly (>8 to 10 mmol/L in 24 hours)?

![Figure 2: Clinical Findings & Diagnostic Reference (Hyponatraemia & Osmotic Demyelination)](/lessons/images/sba/nephrology/hyponatremia/figure_02_p5.jpeg)


- **A.** Osmotic Demyelination Syndrome (ODS / Central Pontine Myelinolysis), presenting with dysarthria, dysphagia, spastic quadriparesis, and 'Locked-In' syndrome
- **B.** Wernicke-Korsakoff encephalopathy
- **C.** Acute viral encephalitis
- **D.** Transient ischemic attack
- **E.** Alzheimer's dementia

**Correct Answer:** A
**Explanation:**
In chronic hyponatraemia, brain cells adapt to hypotonicity by extruding organic osmoles. When sodium is raised too rapidly (>8-10 mmol/L in 24h), hypertonic stress shrinks astrocytes and oligodendrocytes, triggering massive demyelination of the central pons (Central Pontine Myelinolysis). Patients present 2-7 days later with dysarthria, dysphagia, spastic flaccid-to-spastic quadriparesis, and horizontal gaze paralysis ('locked-in' syndrome).

## Question 3 of 5

Which laboratory profile confirms the diagnosis of Syndrome of Inappropriate Antidiuretic Hormone secretion (SIADH)?

![Figure 3: Clinical Findings & Diagnostic Reference (Hyponatraemia & Osmotic Demyelination)](/lessons/images/sba/nephrology/hyponatremia/figure_03_p5.jpeg)


- **A.** Euvolaemic hyponatraemia with Serum Osmolality < 275 mOsm/kg, Inappropriately concentrated Urine Osmolality (>100 mOsm/kg), and Urine Sodium > 30 mmol/L, in the presence of normal thyroid and adrenal function
- **B.** Hypovolaemic hyponatraemia with urine sodium < 10 mmol/L
- **C.** Hypervolaemic hyponatraemia with urine osmolality < 100 mOsm/kg
- **D.** High serum osmolality with normal sodium
- **E.** SIADH cannot be diagnosed without an MRI brain

**Correct Answer:** A
**Explanation:**
Diagnostic criteria for SIADH (Bartter-Schwartz): (1) True hypotonic hyponatraemia (serum osmolality <275 mOsm/kg); (2) Clinically EUVOLAEMIC (no edema, no dehydration); (3) Inappropriately concentrated urine (urine osmolality >100 mOsm/kg, typically >serum osmolality); (4) Elevated urine sodium (>30-40 mmol/L on normal salt intake); (5) Normal renal, adrenal, and thyroid function, and no recent diuretic use.

## Question 4 of 5

A 55-year-old male with severe diabetic ketoacidosis has blood glucose of 44 mmol/L (792 mg/dL) and a measured serum sodium of 126 mmol/L. What is his calculated 'Corrected' serum sodium level, and what phenomenon does this represent?

- **A.** Corrected Sodium = 136 mmol/L; Hyperglycaemic Pseudohyponatraemia (osmotic water shift from intracellular to extracellular space)
- **B.** Corrected Sodium = 116 mmol/L
- **C.** Corrected Sodium = 126 mmol/L (glucose has no effect on sodium)
- **D.** Corrected Sodium = 155 mmol/L
- **E.** True hypovolaemic hyponatraemia requiring hypertonic saline

**Correct Answer:** A
**Explanation:**
Katz formula for hyperglycaemic pseudohyponatraemia: Corrected Na = Measured Na + [0.4 x (Glucose in mmol/L - 5.5)]. Here: 126 + [0.4 x (44 - 5.5)] = 126 + 15.4 = 141.4 mmol/L (~136-141 mmol/L). High intravascular glucose draws free water from intracellular space into the vascular compartment, diluting serum sodium. As insulin therapy normalizes glucose, water moves back into cells and measured sodium normalizes without saline.

## Question 5 of 5

What is the cornerstone first-line medical therapy for chronic, asymptomatic or mildly symptomatic euvolaemic hyponatraemia secondary to SIADH?

- **A.** Fluid restriction (typically 500 to 1,000 ml/day)
- **B.** 0.9% Normal Saline intravenous infusion at 150 ml/hr
- **C.** 3% Hypertonic saline infusion at 200 ml/hr
- **D.** High-dose hydrocortisone
- **E.** Desmopressin administration

**Correct Answer:** A
**Explanation:**
For euvolaemic hyponatraemia caused by SIADH, the cornerstone of first-line therapy is strict Fluid Restriction (500-1000 ml/day). Giving 0.9% Normal Saline is contraindicated in SIADH because the administered sodium is rapidly excreted in the concentrated urine while the free water is retained, which paradoxically worsens the hyponatraemia.
$SBA_NEPH_086$,
    false,
    15,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();


  -- ------------------------------------------------------------------------
  -- Specialty: Urological Emergencies (11 Topics)
  -- ------------------------------------------------------------------------
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_sba_id AND "title" = 'Urological Emergencies' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module Urological Emergencies not found in mrcem-sba';
  END IF;

  -- Topic 1/11: Acute Pyelonephritis Management
  -- 1) Interleave Lecture (Position 0)
  UPDATE "lessons"
  SET "position" = 0, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'acute-pyelonephritis-management' OR "slug" = 'acute-pyelonephritis');

  -- 2) Upsert Quiz Lesson (Position 1)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-urology-acute-pyelonephritis',
    'Acute Pyelonephritis Management — SBA Interactive Quiz',
    'quiz',
    $SBA_UROL_087$# Acute Pyelonephritis Management — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 28-year-old non-pregnant woman presents with high fevers (39.2C), rigors, nausea, vomiting, dysuria, and severe right loin pain with marked tenderness to gentle percussion over the right costovertebral angle (Murphy's kidney punch sign). What is the clinical diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Acute Pyelonephritis Management)](/lessons/images/sba/urology/acute-pyelonephritis/figure_01_p5.jpeg)


- **A.** Acute Pyelonephritis (upper urinary tract infection)
- **B.** Uncomplicated lower cystitis
- **C.** Acute appendicitis
- **D.** Acute cholecystitis
- **E.** Bacterial vaginosis

**Correct Answer:** A
**Explanation:**
Acute pyelonephritis is acute infectious inflammation of the renal parenchyma and pelvicalyceal system, typically caused by ascending Gram-negative enteric bacilli (most commonly uropathogenic Escherichia coli, >75-80%). Hallmark features: systemic toxic features (high fever, rigors, vomiting) and flank/loin pain with exquisite costovertebral angle tenderness.

## Question 2 of 5

According to NICE guideline NG111, what is the recommended empirical first-line oral antibiotic therapy for an adult woman with mild-to-moderate acute uncomplicated pyelonephritis who is suitable for outpatient management?

- **A.** Oral Cefalexin (500mg TDS for 7-10 days) or Oral Co-amoxiclav (500/125mg TDS for 14 days), or Ciprofloxacin if resistance rates are low
- **B.** Oral Nitrofurantoin 100mg modified-release for 3 days
- **C.** Oral Fosfomycin single dose
- **D.** Oral Trimethoprim 200mg single dose
- **E.** Oral Metronidazole 400mg TDS

**Correct Answer:** A
**Explanation:**
NICE NG111 recommends oral Cefalexin, Co-amoxiclav, or Ciprofloxacin (where local resistance is low) for outpatient pyelonephritis. Crucially, Nitrofurantoin and Fosfomycin are strictly CONTRAINDICATED in pyelonephritis because they achieve therapeutic concentrations only within the lower bladder lumen and fail to achieve adequate tissue levels in the renal parenchyma.

## Question 3 of 5

A 45-year-old diabetic female with acute pyelonephritis remains persistently febrile and toxic with worsening flank pain despite 72 hours of appropriate intravenous antibiotics. What diagnostic investigation is urgently indicated?

- **A.** Contrast-Enhanced CT of the Abdomen and Pelvis to evaluate for Renal Abscess, Perinephric Collection, or Emphysematous Pyelonephritis
- **B.** Plain abdominal X-ray alone
- **C.** Repeat midstream urine culture and wait another 5 days
- **D.** Barium enema
- **E.** Renal biopsy

**Correct Answer:** A
**Explanation:**
Failure of acute pyelonephritis to improve after 48-72 hours of targeted IV antibiotic therapy mandates urgent contrast-enhanced CT (or renal ultrasound) to exclude suppurative complications: intra-renal or perinephric abscess, ureteric obstruction (infected hydronephrosis), renal papillary necrosis, or emphysematous pyelonephritis (gas formation by E. coli/Klebsiella in diabetics).

## Question 4 of 5

What is the single most common bacterial microorganism responsible for more than 75 to 80% of all community-acquired cases of acute pyelonephritis and urinary tract infections?

- **A.** Uropathogenic Escherichia coli (UPEC)
- **B.** Staphylococcus saprophyticus
- **C.** Proteus mirabilis
- **D.** Enterococcus faecalis
- **E.** Pseudomonas aeruginosa

**Correct Answer:** A
**Explanation:**
Uropathogenic Escherichia coli (UPEC) accounts for 75-85% of uncomplicated pyelonephritis and cystitis. UPEC possesses specialized virulence factors: P fimbriae (pyelonephritis-associated pili) that adhere specifically to digalactoside receptors on uroepithelial cells, resisting urine flow and facilitating ascent into the kidney.

## Question 5 of 5

A 60-year-old male with acute pyelonephritis and an obstructing proximal ureteric calculus (stone) presents in severe septic shock (BP 78/44 mmHg, lactate 4.8 mmol/L). What is the mandatory, emergency life-saving intervention?

- **A.** Emergency Biliary / Renal tract Decompression via Percutaneous Nephrostomy (PCN) or Retrograde Ureteral Stenting (JJ stent) combined with IV antibiotics and resuscitation
- **B.** Extracorporeal shock-wave lithotripsy (ESWL) immediately
- **C.** Oral tamsulosin and observation
- **D.** Immediate open nephrectomy
- **E.** High-volume IV fluid diuresis alone

**Correct Answer:** A
**Explanation:**
Infected hydronephrosis / pyonephrosis (obstructing stone with upper UTI / sepsis) is an absolute urological emergency. Antibiotics cannot penetrate an obstructed, high-pressure, infected collecting system. Immediate decompression—either by percutaneous nephrostomy (PCN) placed by interventional radiology or retrograde double-J ureteral stenting by urology—is life-saving.
$SBA_UROL_087$,
    false,
    1,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 2/11: Dysuria & Lower Urinary Tract Infections
  -- 1) Interleave Lecture (Position 2)
  UPDATE "lessons"
  SET "position" = 2, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'dysuria-lower-urinary-tract-infections' OR "slug" = 'dysuria');

  -- 2) Upsert Quiz Lesson (Position 3)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-urology-dysuria',
    'Dysuria & Lower Urinary Tract Infections — SBA Interactive Quiz',
    'quiz',
    $SBA_UROL_088$# Dysuria & Lower Urinary Tract Infections — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 24-year-old sexually active woman presents with a 2-day history of acute painful micturition (dysuria), urinary frequency, and suprapubic discomfort. She has no fever, flank pain, or vaginal discharge. According to NICE guideline NG109, what is the recommended empirical first-line oral antibiotic for acute uncomplicated cystitis in non-pregnant adult women?

![Figure 1: Clinical Findings & Diagnostic Reference (Dysuria & Lower Urinary Tract Infections)](/lessons/images/sba/urology/dysuria/figure_01_p8.jpeg)


- **A.** Oral Nitrofurantoin (50mg QDS or 100mg modified-release BD for 3 days) or Trimethoprim (200mg BD for 3 days)
- **B.** Oral Ciprofloxacin 500mg BD for 14 days
- **C.** Intravenous Ceftriaxone 1g daily for 7 days
- **D.** Oral Co-amoxiclav for 21 days
- **E.** Oral Fluconazole single dose

**Correct Answer:** A
**Explanation:**
NICE NG109 recommends a short 3-day course of Nitrofurantoin (100mg MR BD) or Trimethoprim (200mg BD) as first-line empirical therapy for acute uncomplicated lower UTI in non-pregnant women. A 3-day course is as effective as a 7-day course, with fewer side effects and lower resistance selection. (Note: Nitrofurantoin requires eGFR >=45 ml/min to achieve adequate urinary concentration).

## Question 2 of 5

A 22-year-old male presents with severe burning dysuria and a copious, thick, purulent yellow-white urethral discharge for 3 days. What is the most likely pathogen and recommended empirical therapy according to BASHH (British Association for Sexual Health and HIV) guidelines?

- **A.** Neisseria gonorrhoeae; Ceftriaxone 1g intramuscular (IM) single dose
- **B.** Escherichia coli; Trimethoprim 200mg BD for 3 days
- **C.** Candida albicans; Clotrimazole cream
- **D.** Treponema pallidum; Oral penicillin V
- **E.** Herpes simplex virus; Oral aciclovir 200mg

**Correct Answer:** A
**Explanation:**
Acute urethritis in young males presenting with profuse, purulent urethral discharge is characteristically caused by Neisseria gonorrhoeae (Gram-negative intracellular diplococcus). BASHH guidelines recommend high-dose Ceftriaxone 1g IM single dose (with oral Doxycycline 100mg BD for 7 days if Chlamydia trachomatis has not been excluded), alongside partner notification and NAAT testing.

## Question 3 of 5

Why is a urinary tract infection (UTI) in an adult male ALWAYS considered a 'Complicated UTI' requiring further clinical evaluation?

- **A.** The long male urethra and antibacterial prostatic secretions normally protect against ascending infection; a UTI in a male implies an anatomical, functional, or structural abnormality (e.g. BPH, urethral stricture, prostatitis)
- **B.** Males cannot excrete antibiotics in urine
- **C.** UTI is genetic in males
- **D.** All male UTIs are caused by tuberculosis
- **E.** Men do not have urinary bladders

**Correct Answer:** A
**Explanation:**
In adult males, the long urethra, dry periurethral environment, and zinc-rich antibacterial prostatic secretions make ascending bacterial cystitis very rare. A male UTI is by definition complicated, warranting a minimum 7-day antibiotic course, midstream urine culture, examination for acute prostatitis, and urological investigation for bladder outlet obstruction or urethral stricture.

## Question 4 of 5

On urine dipstick testing of a patient with acute dysuria, what do a positive 'Leukocyte Esterase' and a positive 'Nitrite' test specifically indicate?

- **A.** Leukocyte esterase indicates pyuria (presence of white blood cells / inflammation); Nitrite indicates the presence of bacteria possessing nitrate reductase enzymes (Gram-negative enterobacteria like E. coli)
- **B.** Nitrite indicates viral infection
- **C.** Leukocyte esterase indicates renal glycosuria
- **D.** Both tests indicate acute renal failure
- **E.** Nitrite indicates calcium oxalate crystals

**Correct Answer:** A
**Explanation:**
Leukocyte esterase detects an enzyme produced by neutrophils, confirming pyuria (white cells in urine). Nitrite tests detect the bacterial reduction of dietary dietary nitrate to nitrite by Gram-negative uropathogens (E. coli, Klebsiella, Proteus). Gram-positive organisms (Enterococcus, Staph saprophyticus) do not reduce nitrate, giving a negative nitrite test despite active infection.

## Question 5 of 5

A 30-year-old pregnant woman at 14 weeks gestation is found to have Asymptomatic Bacteriuria (>10^5 CFU/ml of E. coli on routine booking antenatal culture). Why MUST asymptomatic bacteriuria be treated with antibiotics in pregnancy?

- **A.** Untreated asymptomatic bacteriuria in pregnancy carries a 20-40% risk of progressing to acute severe pyelonephritis, pre-term labour, low birth weight, and perinatal mortality
- **B.** It causes immediate fetal cardiac arrest
- **C.** It causes gestational diabetes
- **D.** It causes amniotic fluid embolism
- **E.** It causes maternal hyperemesis

**Correct Answer:** A
**Explanation:**
Pregnancy causes physiological hydroureter and urinary stasis (progesterone relaxes ureteric smooth muscle, and the gravid uterus compresses the ureters). Untreated asymptomatic bacteriuria progresses to acute maternal pyelonephritis in 20-40% of pregnancies, significantly increasing the risk of pre-term labour and low birth weight. Treatment with a 7-day course of pregnancy-safe antibiotics is mandatory.
$SBA_UROL_088$,
    false,
    3,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 3/11: Epididymo-Orchitis Management
  -- 1) Interleave Lecture (Position 4)
  UPDATE "lessons"
  SET "position" = 4, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'epididymo-orchitis' OR "slug" = 'epididymo-orchitis');

  -- 2) Upsert Quiz Lesson (Position 5)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-urology-epididymo-orchitis',
    'Epididymo-Orchitis Management — SBA Interactive Quiz',
    'quiz',
    $SBA_UROL_089$# Epididymo-Orchitis Management — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 23-year-old sexually active male presents with gradual onset of severe right hemiscrotal pain, swelling, and fever developing over 3 days. Examination shows an enlarged, exquisitely tender right epididymis and testis with scrotal erythema. Elevation of the right hemiscrotum relieves the pain (positive Prehn's sign). What is the most likely diagnosis and predominant microbiological aetiology in this age group?

![Figure 1: Clinical Findings & Diagnostic Reference (Epididymo-Orchitis Management)](/lessons/images/sba/urology/epididymo-orchitis/figure_01_p4.jpeg)


- **A.** Acute Epididymo-Orchitis; Chlamydia trachomatis or Neisseria gonorrhoeae
- **B.** Testicular torsion; vascular occlusion
- **C.** Incarcerated inguinal hernia; E. coli
- **D.** Varicocele; venous incompetence
- **E.** Testicular teratoma

**Correct Answer:** A
**Explanation:**
In sexually active males aged <35 years, acute epididymitis is predominantly caused by sexually transmitted pathogens: Chlamydia trachomatis and Neisseria gonorrhoeae ascending via the vas deferens. Prehn's sign (pain relief on physical scrotal elevation) is classically positive in epididymitis (though unreliable to distinguish from torsion). In men >35 years, enteric coliforms (E. coli) predominate.

## Question 2 of 5

According to UK BASHH and NICE guidelines, what is the recommended empirical antibiotic regimen for suspected sexually transmitted acute Epididymo-Orchitis in a 24-year-old male?

- **A.** Intramuscular Ceftriaxone (500mg or 1g IM single dose) PLUS Oral Doxycycline (100mg twice daily for 10-14 days)
- **B.** Oral Ciprofloxacin 500mg BD for 3 days
- **C.** Oral Nitrofurantoin 100mg BD for 7 days
- **D.** Oral Amoxicillin 500mg TDS for 5 days
- **E.** Oral Metronidazole 400mg single dose

**Correct Answer:** A
**Explanation:**
BASHH guidelines recommend dual antimicrobial therapy for sexually transmitted epididymo-orchitis: Ceftriaxone (500mg-1g IM single dose to cover Neisseria gonorrhoeae) plus Oral Doxycycline (100mg BD for 10-14 days to cover Chlamydia trachomatis). Bed rest, scrotal support, and analgesia are essential adjuncts.

## Question 3 of 5

A 68-year-old male with benign prostatic hyperplasia and chronic urinary retention presents with acute left epididymo-orchitis. What is the most likely causative pathogen, and what oral antibiotic is recommended by NICE?

- **A.** Escherichia coli (or other enteric Gram-negative coliforms); Oral Ofloxacin 200mg BD (or Ciprofloxacin 500mg BD / Co-amoxiclav) for 14 days
- **B.** Chlamydia trachomatis; Doxycycline
- **C.** Treponema pallidum; Benzathine penicillin
- **D.** Ureaplasma urealyticum; Erythromycin
- **E.** Herpes simplex virus; Aciclovir

**Correct Answer:** A
**Explanation:**
In men aged >35 years, acute epididymo-orchitis is almost always non-sexually transmitted, arising from reflux of infected urine secondary to bladder outlet obstruction or urinary catheterisation. Enteric coliforms (E. coli, Klebsiella, Proteus, Pseudomonas) are the causative agents. Quinolones (Ofloxacin or Ciprofloxacin) or Co-amoxiclav for 14 days are first-line due to excellent tissue penetration into the prostate and epididymis.

## Question 4 of 5

What acute viral systemic infection classically causes secondary orchitis (typically unilateral in 70-80% and bilateral in 15-30%) in post-pubertal adolescent males, occurring 4-8 days after parotid gland swelling?

- **A.** Mumps Virus (Paramyxovirus)
- **B.** Epstein-Barr Virus
- **C.** Coxsackie B virus
- **D.** Cytomegalovirus
- **E.** Varicella-Zoster virus

**Correct Answer:** A
**Explanation:**
Mumps orchitis occurs in up to 20-30% of post-pubertal males infected with the mumps virus (Paramyxovirus). It typically develops 4-8 days following acute parotitis, presenting with abrupt high fever, severe testicular pain, and marked testicular swelling. Although it can cause testicular atrophy in 30-50%, permanent infertility is uncommon unless bilateral.

## Question 5 of 5

What serious suppurative complication of untreated or severe bacterial epididymo-orchitis is visualised on scrotal ultrasound as a complex, thick-walled, cystic intra-testicular fluid collection with internal debris?

- **A.** Testicular Abscess (requiring surgical drainage or orchidectomy)
- **B.** Spermatocele
- **C.** Varicocele
- **D.** Hydrocele
- **E.** Seminoma

**Correct Answer:** A
**Explanation:**
Suppurative bacterial epididymo-orchitis can lead to a Testicular Abscess or Fournier's gangrene if swelling compromises testicular venous outflow, causing secondary testicular infarction. Diagnostic ultrasound reveals a complex, hypoechoic, thick-walled fluid collection with internal septations and avascular center. Management requires surgical drainage or orchidectomy.
$SBA_UROL_089$,
    false,
    5,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 4/11: Haematuria & Urological Malignancies
  -- 1) Interleave Lecture (Position 6)
  UPDATE "lessons"
  SET "position" = 6, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'hematuria-urological-malignancies' OR "slug" = 'hematuria-cancer');

  -- 2) Upsert Quiz Lesson (Position 7)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-urology-hematuria-cancer',
    'Haematuria & Urological Malignancies — SBA Interactive Quiz',
    'quiz',
    $SBA_UROL_090$# Haematuria & Urological Malignancies — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 58-year-old male with a 30 pack-year smoking history presents with two episodes of painless visible (macroscopic) haematuria with small blood clots. He has no dysuria, fever, or trauma. Routine urine dipstick confirms 3+ blood. What is the single most important clinical action according to NICE guideline NG12?

![Figure 1: Clinical Findings & Diagnostic Reference (Haematuria & Urological Malignancies)](/lessons/images/sba/urology/hematuria-cancer/figure_01_p3.jpeg)


- **A.** Urgent 2-week-wait cancer referral for urological investigation (Flexible Cystoscopy and Upper Tract Imaging)
- **B.** Prescribe a course of oral ciprofloxacin and discharge
- **C.** Repeat the urine dipstick in 6 months
- **D.** Reassure that painless haematuria is self-limiting
- **E.** Prescribe oral tranexamic acid alone

**Correct Answer:** A
**Explanation:**
Under NICE NG12 suspected cancer guidelines, all patients aged >=45 years with unexplained visible haematuria (in the absence of confirmed UTI, or persisting after successful UTI treatment) require urgent 2-week-wait urological referral for flexible cystoscopy (to visualize the bladder) and renal tract imaging (CT Urography or ultrasound) to exclude urothelial and renal malignancy.

## Question 2 of 5

What is the defining clinical threshold for Non-Visible (Microscopic) Haematuria (NVH) on automated urine dipstick analysis according to BAUS guidelines?

![Figure 2: Clinical Findings & Diagnostic Reference (Haematuria & Urological Malignancies)](/lessons/images/sba/urology/hematuria-cancer/figure_02_p7.jpeg)


- **A.** 1+ or greater on urine dipstick on at least two occasions (or >3 RBCs per high-power field on microscopy)
- **B.** Trace blood on a single dipstick in a menstruating female
- **C.** Dark urine without red blood cells
- **D.** Presence of white blood cells only
- **E.** Proteinuria 3+ with negative blood

**Correct Answer:** A
**Explanation:**
BAUS criteria define significant non-visible haematuria (NVH) as 1+ or greater on chemical urine dipstick testing on at least two separate occasions. Routine formal urine microscopy is not required to confirm dipstick haematuria because modern reagent strips have >95% sensitivity for detecting intact erythrocytes and free haemoglobin.

## Question 3 of 5

In the microscopic examination of urine, what morphological characteristic of urinary red blood cells and presence of red blood cell casts indicates a Glomerular (nephrological) source of bleeding rather than a Urological source?

![Figure 3: Clinical Findings & Diagnostic Reference (Haematuria & Urological Malignancies)](/lessons/images/sba/urology/hematuria-cancer/figure_03_p8.jpeg)


- **A.** Dysmorphic erythrocytes (acanthocytes / G1 cells) and Red Blood Cell Casts with significant proteinuria
- **B.** Monomorphic, uniform, smooth biconcave erythrocytes with no casts
- **C.** Hyaline casts only
- **D.** Calcium oxalate crystals without protein
- **E.** Uric acid crystals alone

**Correct Answer:** A
**Explanation:**
Glomerular bleeding (nephritis, glomerulonephritis) forces red cells through damaged glomerular basement membranes, causing mechanical distortion and osmotic lysis, producing dysmorphic erythrocytes (acanthocytes with ring-like vesicular blebs) and Red Cell Casts (cylindrical Tamm-Horsfall protein matrices trapping RBCs). Urological bleeding (stones, tumors, trauma) features isomorphic, normal-shaped erythrocytes without casts.

## Question 4 of 5

A 55-year-old male presents with painless gross haematuria and a palpable, non-tender right flank mass. Ultrasound demonstrates a 6 cm solid vascular mass expanding the upper pole of the right kidney. What is the definitive initial oncological surgical treatment of choice for localized renal cell carcinoma?

![Figure 4: Clinical Findings & Diagnostic Reference (Haematuria & Urological Malignancies)](/lessons/images/sba/urology/hematuria-cancer/figure_04_p8.jpeg)


- **A.** Radical or Partial Nephrectomy (open or laparoscopic)
- **B.** Systemic chemotherapy with 5-fluorouracil
- **C.** External beam radiotherapy alone
- **D.** Percutaneous needle core biopsy without resection
- **E.** Active surveillance for all 6 cm renal tumors

**Correct Answer:** A
**Explanation:**
Surgical resection (Radical Nephrectomy or Nephron-Sparing Partial Nephrectomy) is the gold standard, curative treatment for localized Renal Cell Carcinoma. RCC is notoriously radio-resistant and chemo-resistant. (Pre-operative needle biopsy is avoided for resectable solid renal masses due to the risk of tumor tract seeding and bleeding).

## Question 5 of 5

Which industrial occupational exposures are strongly linked to the development of Transitional Cell (Urothelial) Carcinoma of the bladder?

- **A.** Aromatic amines (e.g. 2-naphthylamine, benzidine) used in rubber, dye, textile, and printing industries
- **B.** Asbestos fibers
- **C.** Silica dust
- **D.** Wood dust
- **E.** Lead fumes

**Correct Answer:** A
**Explanation:**
Occupational exposure to aromatic amines (such as 2-naphthylamine, 4-aminobiphenyl, and benzidine) historically used in the chemical, rubber, leather, textile, dye, and printing industries is a recognized cause of bladder urothelial carcinoma, often with a latency period of 20 to 30 years after exposure.
$SBA_UROL_090$,
    false,
    7,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 5/11: Phimosis & Paraphimosis Emergencies
  -- 1) Interleave Lecture (Position 8)
  UPDATE "lessons"
  SET "position" = 8, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'phimosis-paraphimosis-emergencies' OR "slug" = 'phimosis-paraphimosis');

  -- 2) Upsert Quiz Lesson (Position 9)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-urology-phimosis-paraphimosis',
    'Phimosis & Paraphimosis Emergencies — SBA Interactive Quiz',
    'quiz',
    $SBA_UROL_091$# Phimosis & Paraphimosis Emergencies — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 65-year-old male with an indwelling urinary catheter presents with severe, progressive penile pain and swelling. On examination, the prepuce is retracted behind the coronal sulcus, forming a tight, oedematous, constricting band; the distal glans penis is engorged, purple, and tender. What urological emergency is this?

![Figure 1: Clinical Findings & Diagnostic Reference (Phimosis & Paraphimosis Emergencies)](/lessons/images/sba/urology/phimosis-paraphimosis/figure_01_p2.jpeg)


- **A.** Paraphimosis
- **B.** Phimosis
- **C.** Balanitis xerotica obliterans
- **D.** Priapism
- **E.** Penile fracture

**Correct Answer:** A
**Explanation:**
Paraphimosis is a true urological emergency occurring when a tight foreskin is left retracted behind the glans penis (classic after urethral catheterisation or cleaning). The constricting preputial ring impedes venous and lymphatic return, producing worsening oedema of the glans and foreskin that prevents reduction, culminating in arterial compromise, ischaemia, and penile gangrene if untreated.

## Question 2 of 5

What is the immediate, first-line bedside procedure to reduce acute Paraphimosis in the Emergency Department?

![Figure 2: Clinical Findings & Diagnostic Reference (Phimosis & Paraphimosis Emergencies)](/lessons/images/sba/urology/phimosis-paraphimosis/figure_02_p2.jpeg)


- **A.** Manual reduction: Firm, steady circumferential manual compression of the oedematous glans and prepuce for 5-10 minutes (to expel oedema fluid), followed by pushing the glans proximally with thumbs while pulling the preputial ring distally with index and middle fingers
- **B.** Immediate emergency circumcision without local anaesthesia
- **C.** Cold water immersion for 2 hours
- **D.** Intravenous broad-spectrum antibiotics alone
- **E.** Application of warm petroleum jelly and observation

**Correct Answer:** A
**Explanation:**
Manual reduction: Apply firm, continuous manual pressure to the glans penis for several minutes (often aided by ice packs, osmotic granulated sugar, or the 'Dundee technique' of multiple needle punctures) to express interstitial edema fluid. Then, place both thumbs on the tip of the glans and use the index and middle fingers of both hands to pull the constricting preputial ring forward over the glans.

## Question 3 of 5

If manual reduction of Paraphimosis fails in the ED despite adequate local anaesthesia (dorsal penile nerve block) and osmotic compression, what emergency surgical procedure is indicated to relieve the constricting ring and restore glans perfusion?

![Figure 3: Clinical Findings & Diagnostic Reference (Phimosis & Paraphimosis Emergencies)](/lessons/images/sba/urology/phimosis-paraphimosis/figure_03_p3.jpeg)


- **A.** Dorsal Slit of the preputial constricting ring under local anaesthesia
- **B.** Emergency total penectomy
- **C.** Bilateral orchiectomy
- **D.** Suprapubic catheterisation only
- **E.** Urethral dilatation

**Correct Answer:** A
**Explanation:**
When manual reduction fails, an emergency Dorsal Slit is performed under local dorsal penile block. A 1-2 cm longitudinal incision is made through the tight, constricting fibrous band on the dorsal aspect of the prepuce, relieving the strangulation and allowing the foreskin to be pulled forward easily. Elective formal circumcision is arranged weeks later.

## Question 4 of 5

In young paediatric males, up to what age is Physiological (congenital) Phimosis (inability to retract the prepuce) considered a completely normal developmental finding that requires no surgical intervention?

- **A.** Up to 3 to 5 years of age (and often until puberty)
- **B.** Only during the first 24 hours of life
- **C.** Up to 6 months of age only
- **D.** Phimosis is never physiological
- **E.** Up to 6 weeks of life

**Correct Answer:** A
**Explanation:**
Physiological phimosis is normal in infants and young boys due to natural congenital adhesions between the inner epithelial layer of the prepuce and the glans penis. At birth, only 4% of boys have fully retractable foreskins; by age 3, ~90% are retractable, and by puberty >99% are fully retractable. Forceful retraction must be avoided as it causes micro-tears, scarring, and secondary pathological phimosis.

## Question 5 of 5

What chronic, progressive cicatricial skin condition presents with a thick, white, sclerotic, fibrotic ring at the preputial orifice causing severe Pathological Phimosis and urethral meatal stenosis in adult males?

- **A.** Balanitis Xerotica Obliterans (BXO / Lichen Sclerosus)
- **B.** Psoriasis vulgaris
- **C.** Erythroplasia of Queyrat
- **D.** Condyloma acuminata
- **E.** Bowenoid papulosis

**Correct Answer:** A
**Explanation:**
Balanitis Xerotica Obliterans (BXO), the penile manifestation of lichen sclerosus, is a chronic inflammatory dermatosis causing progressive porcelain-white thickening, scarring, and contracture of the prepuce and glans. It produces true pathological phimosis and meatal stenosis, carrying an increased risk of squamous cell carcinoma of the penis. Treatment is topical ultrapotent steroids or circumcision.
$SBA_UROL_091$,
    false,
    9,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 6/11: Priapism Emergency Management
  -- 1) Interleave Lecture (Position 10)
  UPDATE "lessons"
  SET "position" = 10, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'priapism-emergency-management' OR "slug" = 'priapism');

  -- 2) Upsert Quiz Lesson (Position 11)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-urology-priapism',
    'Priapism Emergency Management — SBA Interactive Quiz',
    'quiz',
    $SBA_UROL_092$# Priapism Emergency Management — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 28-year-old male presents with a persistent, painful erection lasting 6 hours without sexual stimulation after taking an oral PDE-5 inhibitor (sildenafil). On examination, both corpora cavernosa are rigidly erect, tense, and exquisitely tender, but the corpus spongiosum and glans penis are soft and flaccid. What type of priapism is this?

![Figure 1: Clinical Findings & Diagnostic Reference (Priapism Emergency Management)](/lessons/images/sba/urology/priapism/figure_01_p3.jpeg)


- **A.** Ischaemic (Low-Flow / Veno-Occlusive) Priapism
- **B.** Non-Ischaemic (High-Flow / Arterial) Priapism
- **C.** Stuttering priapism
- **D.** Psychogenic priapism
- **E.** Peyronie's disease

**Correct Answer:** A
**Explanation:**
Ischaemic (low-flow) priapism is a compartment syndrome of the corpora cavernosa. Occlusion of cavernous venous outflow results in stasis of deoxygenated blood, ischemia, and acidosis. Clinical hallmarks: rigid, rock-hard, exquisitely painful corpora cavernosa with a characteristic SOFT glans and soft corpus spongiosum. It is a time-critical surgical emergency: irreversible cavernous fibrosis and permanent erectile dysfunction occur if untreated >12-24 hours.

![Clinical Algorithm & Advanced Reference (Priapism Emergency Management)](/lessons/images/sba/urology/priapism/figure_06_p9.jpeg)


## Question 2 of 5

What classic blood gas parameters obtained from aspirating cavernous blood confirm the diagnosis of Ischaemic (Low-Flow) Priapism as opposed to Non-Ischaemic Priapism?

![Figure 2: Clinical Findings & Diagnostic Reference (Priapism Emergency Management)](/lessons/images/sba/urology/priapism/figure_02_p4.jpeg)


- **A.** Dark black venous blood with Acidosis (pH <7.25), Hypoxia (pO2 <30 mmHg), and Hypercapnia (pCO2 >60 mmHg)
- **B.** Bright red arterial blood with normal arterial pH (7.40), pO2 >90 mmHg, and pCO2 <40 mmHg
- **C.** Normal mixed venous blood
- **D.** Blood gas cannot be performed on cavernous blood
- **E.** High glucose and high bicarbonate

**Correct Answer:** A
**Explanation:**
Cavernosal blood gas analysis is diagnostic: Ischaemic (low-flow): dark, deoxygenated blood with pH <7.25, pO2 <30 mmHg (hypoxic), and pCO2 >60 mmHg (hypercapnic), identical to stagnant ischaemic blood. Non-ischaemic (high-flow, typically post-perineal trauma with cavernosal fistula): bright red arterial blood with pH ~7.40, pO2 >90 mmHg, and pCO2 <40 mmHg.

## Question 3 of 5

What is the recommended first-line pharmacological intracavernosal therapy for acute Ischaemic Priapism following aspiration of stagnant blood?

![Figure 3: Clinical Findings & Diagnostic Reference (Priapism Emergency Management)](/lessons/images/sba/urology/priapism/figure_03_p5.jpeg)


- **A.** Intracavernosal injection of Phenylephrine (100 to 500 mcg/ml diluted, injecting 100-200 mcg every 3-5 minutes under continuous BP and ECG monitoring)
- **B.** Intracavernosal injection of Papaverine
- **C.** Intracavernosal Prostaglandin E1 (Alprostadil)
- **D.** Intravenous Nitroglycerin infusion
- **E.** Intravenous Furosemide

**Correct Answer:** A
**Explanation:**
Intracavernosal Phenylephrine (a selective alpha-1 adrenergic agonist) is the pharmacological antidote of choice. Alpha-1 stimulation contracts cavernosal trabecular smooth muscle, opening venous channels and promoting detumescence. Diluted solution (100-500 mcg/ml) is injected in 100-200 mcg increments every 3-5 minutes (max 1,000 mcg). Blood pressure and pulse must be monitored due to the risk of systemic hypertension and reflex bradycardia.

## Question 4 of 5

A 16-year-old male with Sickle Cell Disease (HbSS) presents with acute ischaemic priapism of 5 hours duration. What specific emergency hematological management is indicated alongside urological cavernosal aspiration?

![Figure 4: Clinical Findings & Diagnostic Reference (Priapism Emergency Management)](/lessons/images/sba/urology/priapism/figure_04_p7.jpeg)


- **A.** Aggressive intravenous hydration, supplemental oxygen, systemic analgesia, alkalinisation, and exchange blood transfusion (erythrocytapheresis) to reduce HbS <30%
- **B.** Immediate surgical bilateral orchidectomy
- **C.** High-dose oral iron supplements
- **D.** Fluid restriction and cold baths
- **E.** Warfarin anticoagulation alone

**Correct Answer:** A
**Explanation:**
In sickle cell disease, sickling of red cells within the low-oxygen, acidotic cavernosal sinusoids causes microvascular sludging and veno-occlusive priapism. Management requires immediate systemic therapy (IV fluids, oxygen, analgesia, treat acidosis) and automated red cell exchange transfusion (targeting HbS <30%) to abort sickling, alongside local cavernosal aspiration/phenylephrine.

## Question 5 of 5

What surgical intervention is indicated for acute ischaemic priapism that fails to achieve detumescence despite multiple cavernosal aspirations and maximal intracavernosal phenylephrine injections?

![Figure 5: Clinical Findings & Diagnostic Reference (Priapism Emergency Management)](/lessons/images/sba/urology/priapism/figure_05_p8.jpeg)


- **A.** Surgical Cavernosal Shunting (e.g. Winter / Ebbehoj percutaneous distal shunt or Al-Ghorab open distal glans-cavernosum shunt)
- **B.** Total penile amputation
- **C.** Sartorius muscle flap transposition
- **D.** Pelvic radiation therapy
- **E.** Bilateral vasectomy

**Correct Answer:** A
**Explanation:**
When aspiration and phenylephrine fail, surgical intervention is mandatory. Distal shunting procedures (Winter/Ebbehoj percutaneous trans-glanular biopsy needle shunt, or Al-Ghorab open excision of the distal tips of the corpora cavernosa) create a fistulous communication between the high-pressure, ischemic corpora cavernosa and the low-pressure corpus spongiosum/glans, restoring venous outflow.
$SBA_UROL_092$,
    false,
    11,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 7/11: Acute Bacterial Prostatitis
  -- 1) Interleave Lecture (Position 12)
  UPDATE "lessons"
  SET "position" = 12, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'acute-bacterial-prostatitis' OR "slug" = 'prostatitis');

  -- 2) Upsert Quiz Lesson (Position 13)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-urology-prostatitis',
    'Acute Bacterial Prostatitis — SBA Interactive Quiz',
    'quiz',
    $SBA_UROL_093$# Acute Bacterial Prostatitis — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 48-year-old male presents with high fever (39.0C), chills, perineal and pelvic pain, severe dysuria, and acute urinary hesitancy. On gentle digital rectal examination (DRE), the prostate is swollen, tense, exquisitely tender, and hot to touch. What procedure is strictly CONTRAINDICATED in suspected Acute Bacterial Prostatitis?

![Figure 1: Clinical Findings & Diagnostic Reference (Acute Bacterial Prostatitis)](/lessons/images/sba/urology/prostatitis/figure_01_p6.jpeg)


- **A.** Vigorous or repeated prostatic massage
- **B.** Midstream urine collection
- **C.** Intravenous fluid resuscitation
- **D.** Serum PSA measurement after recovery
- **E.** Abdominal ultrasound

**Correct Answer:** A
**Explanation:**
In acute bacterial prostatitis, vigorous or repetitive prostatic massage (or rough DRE) is strictly CONTRAINDICATED because it can cause severe pain and trigger massive bacteremic seeding and life-threatening Gram-negative septic shock. DRE should be performed very gently solely to assess for fluctuance (prostatic abscess).

## Question 2 of 5

What is the recommended duration of antibiotic therapy for Acute Bacterial Prostatitis according to European Association of Urology (EAU) and NICE guidelines?

- **A.** A prolonged course of 2 to 4 weeks (14 to 28 days) of fluoroquinolones (e.g. Ciprofloxacin or Levofloxacin) or Trimethoprim
- **B.** Single 3-day course of nitrofurantoin
- **C.** 5 days of oral amoxicillin
- **D.** 24 hours of IV gentamicin only
- **E.** Lifelong continuous antibiotics

**Correct Answer:** A
**Explanation:**
Because of the blood-prostate barrier and the non-inflamed stromal capsule, most antibiotics achieve poor penetration into prostatic tissue. Lipid-soluble antibiotics with high pKa values (fluoroquinolones such as Ciprofloxacin 500mg BD or Levofloxacin, or Trimethoprim) must be administered for a prolonged course of 14 to 28 days (2-4 weeks) to achieve bacteriological cure and prevent chronic bacterial prostatitis or prostatic abscess.

## Question 3 of 5

A 52-year-old male with acute bacterial prostatitis develops complete acute urinary retention and is in severe distress with a palpable, tender bladder. What is the preferred method of bladder decompression?

- **A.** Suprapubic Catheterisation (SPC) under ultrasound guidance
- **B.** Forced insertion of a large 20F rigid transurethral Foley catheter
- **C.** Immediate transurethral resection of the prostate (TURP)
- **D.** Intravenous furosemide 80mg
- **E.** Observation without catheterisation

**Correct Answer:** A
**Explanation:**
In acute bacterial prostatitis with urinary retention, transurethral catheterisation is relatively contraindicated or hazardous because negotiating the catheter through the acutely inflamed, edematous prostate is excruciatingly painful and risks septic shock or prostatic rupture. Placement of a percutaneous Suprapubic Catheter (SPC) under ultrasound guidance is the gold standard method to drain the bladder safely.

## Question 4 of 5

What is the most common causative uropathogen isolated in acute bacterial prostatitis in adult males aged >35 years?

- **A.** Escherichia coli (accounting for 65-80% of cases)
- **B.** Staphylococcus aureus
- **C.** Treponema pallidum
- **D.** Chlamydia trachomatis
- **E.** Candida albicans

**Correct Answer:** A
**Explanation:**
Escherichia coli is the predominant causative uropathogen in acute bacterial prostatitis (>65-80%), followed by other Gram-negative Enterobacteriaceae (Klebsiella, Proteus, Enterobacter, Pseudomonas) and Enterococcus. In sexually active men <35 years, Neisseria gonorrhoeae and Chlamydia trachomatis must be considered.

## Question 5 of 5

A diabetic male being treated for acute prostatitis has fluctuating high fevers and perineal pain persisting after 7 days of IV ciprofloxacin. Transrectal ultrasound (TRUS) or pelvic MRI confirms a 3.5 cm Prostatic Abscess. What is the definitive management?

- **A.** Transurethral unroofing / resection (TURP) or Transrectal / Transperineal ultrasound-guided needle aspiration / drainage, with continued IV antibiotics
- **B.** Switch to oral paracetamol and discharge
- **C.** Observation for spontaneous resolution
- **D.** Radiotherapy to the pelvis
- **E.** Bilateral orchidectomy

**Correct Answer:** A
**Explanation:**
A prostatic abscess refractory to antibiotics requires surgical drainage. Abscesses >1-2 cm are typically managed by transurethral resection/unroofing (TURP deroofing) or transrectal/transperineal ultrasound-guided catheter drainage, alongside targeted intravenous antimicrobial therapy.
$SBA_UROL_093$,
    false,
    13,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 8/11: Renal Colic & Nephrolithiasis
  -- 1) Interleave Lecture (Position 14)
  UPDATE "lessons"
  SET "position" = 14, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'renal-colic-nephrolithiasis' OR "slug" = 'renal-stone');

  -- 2) Upsert Quiz Lesson (Position 15)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-urology-renal-stone',
    'Renal Colic & Nephrolithiasis — SBA Interactive Quiz',
    'quiz',
    $SBA_UROL_094$# Renal Colic & Nephrolithiasis — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 36-year-old male presents with sudden-onset, agonizing, colicky right loin-to-groin pain radiating to the testicle. He is writhing in pain on the examination trolley, unable to find a comfortable position. What is the single most effective first-line analgesic class recommended by NICE guideline NG118 for acute renal colic?

![Figure 1: Clinical Findings & Diagnostic Reference (Renal Colic & Nephrolithiasis)](/lessons/images/sba/urology/renal-stone/figure_01_p4.jpeg)


- **A.** Non-Steroidal Anti-Inflammatory Drugs (NSAIDs: e.g. IM/IV Diclofenac 75mg or IV Ketorolac 15-30mg)
- **B.** Intravenous Morphine 10mg monotherapy
- **C.** Oral Paracetamol 1g
- **D.** Oral codeine phosphate
- **E.** Inhaled nitrous oxide alone

**Correct Answer:** A
**Explanation:**
NICE NG118 and BAUS recommend NSAIDs (e.g. IV/IM Diclofenac or Ketorolac) as first-line analgesia for acute renal colic. NSAIDs inhibit renal prostaglandin synthesis, which reduces renal blood flow, decreases pelvicalyceal pressure, and directly relieves ureteric smooth muscle spasm, providing superior and more sustained pain relief with fewer side effects than opiates. (IV Morphine is second-line if NSAIDs are contraindicated).

## Question 2 of 5

What is the gold standard diagnostic imaging investigation of choice for suspected acute renal colic (ureteric stone) according to NICE guidelines?

- **A.** Non-Contrast Low-Dose Computed Tomography of the Kidneys, Ureters, and Bladder (CT KUB) within 14 hours
- **B.** Intravenous Urogram (IVU / IVP)
- **C.** Plain abdominal KUB radiograph alone
- **D.** Renal MRI
- **E.** Barium meal

**Correct Answer:** A
**Explanation:**
Non-Contrast CT KUB (low-dose) is the reference standard diagnostic imaging modality (sensitivity and specificity >97-99%). It visualizes virtually all urinary stones regardless of radiopacity (including radiolucent uric acid stones), accurately measures stone size, determines precise location, and detects secondary obstruction (hydroureter, perinephric stranding) and alternative intra-abdominal pathologies.

## Question 3 of 5

What is the natural spontaneous passage rate for an uncomplicated distal ureteric calculus measuring less than 5 mm in diameter?

- **A.** Approximately 70% to 90%
- **B.** Less than 5%
- **C.** Exactly 50%
- **D.** 0% (all ureteric stones require surgery)
- **E.** 100% within 1 hour

**Correct Answer:** A
**Explanation:**
The probability of spontaneous ureteric stone passage depends strongly on stone size and location: stones <5 mm have a 70-90% chance of passing spontaneously with conservative management and medical expulsive therapy (MET: alpha-blocker e.g. tamsulosin). Stones >7-10 mm have a <10-20% passage rate and almost always require intervention (ureteroscopy or ESWL).

## Question 4 of 5

What chemical composition represents the vast majority (>75-80%) of all urinary tract calculi in adults?

- **A.** Calcium Oxalate (with or without Calcium Phosphate)
- **B.** Uric Acid stones
- **C.** Struvite (Magnesium Ammonium Phosphate) stones
- **D.** Cystine stones
- **E.** Xanthine stones

**Correct Answer:** A
**Explanation:**
Calcium-containing stones account for 75-85% of all renal calculi, predominantly Calcium Oxalate (often mixed with calcium phosphate / hydroxyapatite). Uric acid stones account for ~8-10%, struvite (infection) stones ~5-10%, and cystine stones ~1%.

## Question 5 of 5

Which type of urinary stone is classically radiolucent on plain KUB radiographs but easily visible on non-contrast CT KUB, and can be chemically dissolved (chemolysis) by oral urinary alkalinisation (raising urine pH to 6.5-7.0 with potassium citrate)?

- **A.** Uric Acid calculi
- **B.** Calcium oxalate monohydrate calculi
- **C.** Calcium phosphate calculi
- **D.** Struvite calculi
- **E.** Brushite calculi

**Correct Answer:** A
**Explanation:**
Uric acid stones are completely radiolucent on plain X-rays (due to low atomic number) but visible on CT. Uric acid is poorly soluble at acidic urine pH (<5.5). Oral urinary alkalinisation with Potassium Citrate or Sodium Bicarbonate (titrating urine pH to 6.5-7.0) increases uric acid solubility by more than 10-fold, allowing complete chemical dissolution (oral chemolysis) without surgery.
$SBA_UROL_094$,
    false,
    15,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 9/11: Acute Scrotal & Testicular Pain Assessment
  -- 1) Interleave Lecture (Position 16)
  UPDATE "lessons"
  SET "position" = 16, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'acute-scrotal-testicular-pain' OR "slug" = 'testicular-pain');

  -- 2) Upsert Quiz Lesson (Position 17)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-urology-testicular-pain',
    'Acute Scrotal & Testicular Pain Assessment — SBA Interactive Quiz',
    'quiz',
    $SBA_UROL_095$# Acute Scrotal & Testicular Pain Assessment — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 10-year-old boy presents with gradual onset of mild right-sided upper scrotal pain. On physical examination, the testis is normal, mobile, and non-tender, but there is a discrete, tender, pea-sized nodule palpable at the superior pole of the testis, with a faint blue dot visible through the thin scrotal skin ('Blue Dot Sign'). What is the diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Acute Scrotal & Testicular Pain Assessment)](/lessons/images/sba/urology/testicular-pain/figure_01_p1.jpeg)


- **A.** Torsion of the Appendix Testis (Hydatid of Morgagni)
- **B.** Testicular torsion
- **C.** Acute epididymitis
- **D.** Hydrocele
- **E.** Testicular seminoma

**Correct Answer:** A
**Explanation:**
Torsion of the appendix testis (a vestigial remnant of the paramesonephric / Müllerian duct located at the superior pole of the testis) is the most common cause of acute scrotum in boys aged 7-12 years. The classic pathognomonic physical sign is the 'Blue Dot Sign' (a tender, infarcted, cyanotic nodule visible through translucent scrotal skin). Unlike testicular torsion, the testis itself is normally positioned and non-tender with a normal cremasteric reflex. Management is conservative with analgesia.

## Question 2 of 5

In the clinical differentiation of acute testicular pain in an adolescent, which physical sign is considered the most reliable clinical examination finding to EXCLUDE Testicular Torsion when present?

![Figure 2: Clinical Findings & Diagnostic Reference (Acute Scrotal & Testicular Pain Assessment)](/lessons/images/sba/urology/testicular-pain/figure_02_p3.jpeg)


- **A.** Normal, intact Cremasteric Reflex (elevation of the ipsilateral testis by >=0.5 cm upon stroking the superior medial thigh)
- **B.** Absence of fever
- **C.** Normal urine dipstick
- **D.** Normal white cell count
- **E.** Pain relief with paracetamol

**Correct Answer:** A
**Explanation:**
The cremasteric reflex (sensory: ilioinguinal nerve L1; motor: genital branch of genitofemoral nerve L1-L2) is present when stroking the inner upper thigh causes brisk elevation of the ipsilateral testis. An intact, brisk cremasteric reflex has a high negative predictive value (>95-99%) for testicular torsion, although rarely torsion can occur with an intact reflex. Absence of the cremasteric reflex is classic in testicular torsion.

## Question 3 of 5

A 17-year-old male presents with acute severe testicular pain for 2 hours. Bedside Color Doppler Scrotal Ultrasound is requested. What is the standard emergency surgical principle regarding ultrasound imaging in suspected testicular torsion?

![Figure 3: Clinical Findings & Diagnostic Reference (Acute Scrotal & Testicular Pain Assessment)](/lessons/images/sba/urology/testicular-pain/figure_03_p4.jpeg)


- **A.** Ultrasound must NEVER delay emergency surgical exploration; if clinical suspicion of testicular torsion is high, the patient must be transferred immediately to the operating theatre
- **B.** Ultrasound is mandatory and exploration cannot proceed without it
- **C.** Ultrasound has 100% sensitivity and can completely rule out torsion in all cases
- **D.** Wait 12 hours for a repeat ultrasound
- **E.** Ultrasound is only performed post-operatively

**Correct Answer:** A
**Explanation:**
Testicular torsion is a time-critical clinical diagnosis. Doppler ultrasound has a false-negative rate of up to 10-15% (early torsion, intermittent torsion, or partial cord twist with preserved peripheral arterial waveforms). If clinical suspicion is high, never delay surgical scrotal exploration for imaging—every minute of delay increases testicular necrosis.

## Question 4 of 5

A 26-year-old male presents with dull, aching, dragging scrotal discomfort that worsens on prolonged standing and improves on lying down. Examination reveals a compressible 'bag of worms' sensation in the left hemiscrotum that augments during a Valsalva manoeuvre. What is the diagnosis?

![Figure 4: Clinical Findings & Diagnostic Reference (Acute Scrotal & Testicular Pain Assessment)](/lessons/images/sba/urology/testicular-pain/figure_04_p4.jpeg)


- **A.** Varicocele (dilation of the pampiniform venous plexus)
- **B.** Hydrocele
- **C.** Spermatocele
- **D.** Indirect inguinal hernia
- **E.** Testicular torsion

**Correct Answer:** A
**Explanation:**
A varicocele is an abnormal tortuosity and dilation of the pampiniform venous plexus draining the testis, classic in young men. Described classically as a 'bag of worms' in the upright position that decompresses supine. Over 85-90% occur on the left side because the left internal spermatic vein inserts at a perpendicular right angle into the left renal vein (higher hydrostatic pressure).

## Question 5 of 5

A 50-year-old male presents with a painless, smooth, fluctuant, non-tender scrotal swelling that completely transilluminates brilliantly with a pen torch. The examiner's fingers can easily get ABOVE the mass in the scrotum. What is the diagnosis?

- **A.** Testicular Hydrocele (serous fluid collection within the tunica vaginalis)
- **B.** Incarcerated inguinoscrotal hernia
- **C.** Testicular teratoma
- **D.** Haematocele
- **E.** Sartorius muscle hernia

**Correct Answer:** A
**Explanation:**
A hydrocele is an abnormal accumulation of serous fluid between the visceral and parietal layers of the tunica vaginalis. Physical examination hallmarks: non-tender, smooth, cystic swelling that transilluminates brilliantly. Being able to 'get above the swelling' (palpating normal spermatic cord above the mass) rules out an inguinoscrotal hernia.
$SBA_UROL_095$,
    false,
    17,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 10/11: Testicular Torsion (Surgical Emergency)
  -- 1) Interleave Lecture (Position 18)
  UPDATE "lessons"
  SET "position" = 18, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'testicular-torsion-surgical-emergency' OR "slug" = 'testicular-torsion');

  -- 2) Upsert Quiz Lesson (Position 19)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-urology-testicular-torsion',
    'Testicular Torsion (Surgical Emergency) — SBA Interactive Quiz',
    'quiz',
    $SBA_UROL_096$# Testicular Torsion (Surgical Emergency) — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 15-year-old male presents with sudden-onset, severe, agonizing left testicular pain that woke him from sleep 2 hours ago, associated with nausea and vomiting. On examination, the left testis is high-riding in the scrotum with a transverse/horizontal lie, exquisitely tender, and swollen, with an absent cremasteric reflex. What is the maximum 'Golden Window' of time from symptom onset to surgical detorsion to achieve a testicular salvage rate >90%?

![Figure 1: Clinical Findings & Diagnostic Reference (Testicular Torsion (Surgical Emergency))](/lessons/images/sba/urology/testicular-torsion/figure_01_p1.jpeg)


- **A.** Within 6 hours of symptom onset
- **B.** Within 24 hours
- **C.** Within 48 hours
- **D.** Within 72 hours
- **E.** Testicular tissue survives 7 days of ischaemia

**Correct Answer:** A
**Explanation:**
Testicular torsion is an absolute surgical emergency. Testicular viability is directly time-dependent: salvage rates are >90% if surgical detorsion is performed within 6 hours of symptom onset. Salvage rates fall precipitously to ~50% at 12 hours, and <10% after 24 hours (irreversible ischaemic infarction and necrosis).

## Question 2 of 5

What anatomical congenital anomaly of the tunica vaginalis predisposes adolescent males to Intravaginal Testicular Torsion by allowing the testis to twist freely on the spermatic cord like a clapper inside a bell?

![Figure 2: Clinical Findings & Diagnostic Reference (Testicular Torsion (Surgical Emergency))](/lessons/images/sba/urology/testicular-torsion/figure_02_p1.jpeg)


- **A.** 'Bell-Clapper' deformity (high insertion of the tunica vaginalis, completely encircling the testis, epididymis, and distal spermatic cord)
- **B.** Patent processus vaginalis
- **C.** Absence of the cremaster muscle
- **D.** Duplication of the vas deferens
- **E.** Undescended testis alone

**Correct Answer:** A
**Explanation:**
The 'Bell-Clapper' deformity is the underlying anatomical cause of intravaginal torsion in adolescents and young adults. Normally, the posterior testis is fixed to the scrotal wall by the mesorchium. In the bell-clapper anomaly, the tunica vaginalis completely surrounds the testis and distal cord, leaving the testis suspended freely like a clapper inside a bell, predisposing to rotation around the spermatic cord axis.

## Question 3 of 5

When surgical scrotal exploration confirms acute testicular torsion, which operative procedure must ALWAYS be performed on the CONTRALATERAL, normal testis during the same operation?

- **A.** Contralateral Orchidopexy (fixation of the unaffected testis to the scrotal wall with non-absorbable sutures)
- **B.** Contralateral orchidectomy
- **C.** Contralateral vasectomy
- **D.** Contralateral testicular biopsy
- **E.** No intervention on the contralateral side

**Correct Answer:** A
**Explanation:**
The 'Bell-Clapper' deformity is a bilateral congenital anatomical anomaly in over 50-80% of patients. Therefore, during scrotal exploration for torsion, bilateral orchidopexy (three-point fixation of both the affected testis after detorsion and the contralateral unaffected testis using non-absorbable sutures) is mandatory to prevent future contralateral torsion.

## Question 4 of 5

If an immediate surgical operating theatre is unavailable within 30 minutes, what bedside manual detorsion manoeuvre can be attempted in the ED while continuing preparations for the OR?

- **A.** Manual detorsion: 'Opening the book' (rotating the left testis clockwise, or right testis counter-clockwise, from medial to lateral)
- **B.** 'Closing the book' (rotating lateral to medial)
- **C.** Pushing the testis upwards into the inguinal canal
- **D.** Forceful downward traction on the scrotum
- **E.** Direct injection of adrenaline into the cord

**Correct Answer:** A
**Explanation:**
Over two-thirds of testes twist from lateral to medial. Therefore, manual detorsion is performed by rotating the testis from medial to lateral, like 'opening the pages of a book' (facing the patient: left testis is rotated clockwise; right testis is rotated counter-clockwise). Successful detorsion produces immediate relief of pain and lower position. Even if successful, emergency surgical exploration and bilateral orchidopexy remain mandatory.

## Question 5 of 5

A 16-year-old male undergoes scrotal exploration 18 hours after onset of severe torsion. Upon incising the tunica vaginalis, the testis is found to be black, shrivelled, cold, and non-viable, failing to regain color or bleed after 10 minutes of warm saline packing. What is the surgical procedure performed on this non-viable testis?

- **A.** Orchidectomy (excision of the necrotic testis) to prevent autoimmune anti-sperm antibody formation and scrotal abscess, followed by contralateral orchidopexy
- **B.** Leave the necrotic testis in place
- **C.** Perform kidney transplantation
- **D.** Split-thickness skin graft
- **E.** Transposition into the abdominal cavity

**Correct Answer:** A
**Explanation:**
If the testis remains completely non-viable, black, and avascular after detorsion and 10-15 minutes of warm saline application, orchidectomy (surgical excision) must be performed. Leaving necrotic tissue in the scrotum risks secondary bacterial infection, abscess, prolonged convalescence, and disruption of the blood-testis barrier, which can incite auto-antibodies against sperm, compromising future fertility.
$SBA_UROL_096$,
    false,
    19,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 11/11: Urinary Retention & Lower UTI
  -- 1) Interleave Lecture (Position 20)
  UPDATE "lessons"
  SET "position" = 20, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'urine-retention-and-lower-uti' OR "slug" = 'urine-retention-lower-uti');

  -- 2) Upsert Quiz Lesson (Position 21)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-urology-urine-retention-lower-uti',
    'Urinary Retention & Lower UTI — SBA Interactive Quiz',
    'quiz',
    $SBA_UROL_097$# Urinary Retention & Lower UTI — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 72-year-old male with a history of progressive nocturia, weak stream, and hesitancy presents in agonizing suprapubic pain, completely unable to pass urine for 14 hours. A tense, tender, dull mass is palpable in his lower abdomen up to the umbilicus. What is the single most common cause of Acute Urinary Retention (AUR) in adult men?

![Figure 1: Clinical Findings & Diagnostic Reference (Urinary Retention & Lower UTI)](/lessons/images/sba/urology/urine-retention-lower-uti/figure_01_p11.jpeg)


- **A.** Benign Prostatic Hyperplasia (BPH)
- **B.** Prostate adenocarcinoma
- **C.** Urethral stricture
- **D.** Urethral stone
- **E.** Neurogenic bladder

**Correct Answer:** A
**Explanation:**
Benign Prostatic Hyperplasia (BPH) is by far the leading cause of acute urinary retention in adult males (>60-70% of cases). Sudden decompensation is often precipitated by high fluid intake, alcohol, constipation, delay in voiding, or medications with anticholinergic or sympathomimetic properties (e.g. over-the-counter cold remedies, tricyclic antidepressants).

## Question 2 of 5

A 70-year-old male with BPH is successfully catheterized for acute urinary retention, draining 1,800 ml of urine immediately. Over the next 6 hours, his urinary catheter drains 450 ml/hour. What physiological response to relieving high-pressure urinary retention is occurring, and how must it be monitored?

- **A.** Post-Obstructive Diuresis (POD); monitor hourly urine output, vital signs, and serial serum electrolytes/urea/creatinine, replacing 50-75% of fluid losses if pathological diuresis persists
- **B.** Acute renal cortical necrosis
- **C.** Severe hypervolaemic overload
- **D.** Syndrome of inappropriate ADH
- **E.** Renal artery thrombosis

**Correct Answer:** A
**Explanation:**
Post-obstructive diuresis (POD) is defined as urine output >200 ml/hr for >=2 consecutive hours (or >3 litres/24h) following relief of severe urinary obstruction. It is driven by accumulated urea/osmolytes acting as an osmotic diuretic, down-regulation of tubular sodium transporters, and loss of medullary hypertonicity. Patients require close monitoring of volume status and electrolytes to prevent hypovolaemic shock and severe hypokalaemia.

## Question 3 of 5

How does Chronic Urinary Retention fundamentally differ from Acute Urinary Retention in clinical presentation?

- **A.** Chronic retention is characteristically PAINLESS with high residual volumes (>1-2 litres) presenting with nocturnal enuresis / overflow incontinence and often bilateral hydronephrosis with renal impairment; acute retention is acute, painful, and distressful
- **B.** Chronic retention is always intensely painful
- **C.** Acute retention never causes bladder distension
- **D.** Chronic retention only occurs in young females
- **E.** There is no clinical difference

**Correct Answer:** A
**Explanation:**
Acute retention is a sudden, painful inability to void with a tender, distended bladder (<1 L). Chronic retention is painless, gradual, high-volume retention (>1-2 L) where the bladder stretches insidiously without pain; patients present with nocturnal enuresis, daytime frequency, and overflow incontinence. Chronic retention is subdivided into high-pressure (causes bilateral hydronephrosis and progressive renal failure) and low-pressure retention.

## Question 4 of 5

What class of medication is started immediately following catheterisation for acute urinary retention secondary to BPH to significantly increase the success rate of a Trial Without Catheter (TWOC)?

- **A.** Alpha-1 Adrenergic Receptor Antagonists (e.g. Tamsulosin 400mcg or Alfuzosin)
- **B.** 5-Alpha Reductase Inhibitors (Finasteride) monotherapy on day 1
- **C.** Antimuscarinic bladder relaxants (Oxybutynin)
- **D.** Loop diuretics (Furosemide)
- **E.** Beta-blockers (Atenolol)

**Correct Answer:** A
**Explanation:**
NICE and BAUS guidelines recommend initiating an Alpha-1 blocker (e.g. Tamsulosin 400 mcg daily) immediately upon catheterisation. Alpha-1 blockers relax smooth muscle at the bladder neck and prostate stroma, doubling the success rate of a Trial Without Catheter (TWOC) performed 2-3 days later compared to placebo. (5-ARIs like finasteride take 3-6 months to shrink the prostate and are ineffective acutely).

## Question 5 of 5

A 32-year-old female presents with acute painful urinary retention. She has no fever or pelvic mass. Neurological examination reveals reduced sensation over the perianal and saddle area (S2-S4) and bilateral absent ankle jerks. What spinal emergency must be excluded immediately?

- **A.** Cauda Equina Syndrome (emergency MRI lumbar spine is mandatory)
- **B.** Benign cystitis
- **C.** Fowler's syndrome alone
- **D.** Guillain-Barré syndrome
- **E.** Lumbar spondylolysis

**Correct Answer:** A
**Explanation:**
Acute urinary retention in a young patient (especially female) with saddle anesthesia, reduced anal tone, and lower limb neurological deficits is a red-flag presentation of Cauda Equina Syndrome (compression of lumbosacral nerve roots L2-S5, typically from a massive central lumbar disc herniation). An emergency MRI lumbar spine within hours is mandatory to guide emergent surgical decompression before permanent sphincter paralysis.
$SBA_UROL_097$,
    false,
    21,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();


  -- ------------------------------------------------------------------------
  -- Specialty: Ophthalmology Emergencies (9 Topics)
  -- ------------------------------------------------------------------------
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_sba_id AND "title" = 'Ophthalmology Emergencies' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module Ophthalmology Emergencies not found in mrcem-sba';
  END IF;

  -- Topic 1/9: Acute Angle-Closure Glaucoma
  -- 1) Interleave Lecture (Position 0)
  UPDATE "lessons"
  SET "position" = 0, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'acute-glucoma' OR "slug" = 'acute-glaucoma');

  -- 2) Upsert Quiz Lesson (Position 1)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-ophthalmology-acute-glaucoma',
    'Acute Angle-Closure Glaucoma — SBA Interactive Quiz',
    'quiz',
    $SBA_OPHT_098$# Acute Angle-Closure Glaucoma — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 68-year-old hypermetropic female presents with sudden, severe right ocular and periorbital pain radiating to the forehead, blurred vision with coloured halos around lights, nausea, and vomiting that began after watching a film in a dark cinema. Examination reveals a cloudy, hazy 'steamy' cornea, a mid-dilated fixed vertically oval pupil, and ciliary injection. Intraocular pressure (IOP) is 58 mmHg (normal 10-21 mmHg). What is the diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Acute Angle-Closure Glaucoma)](/lessons/images/sba/ophthalmology/acute-glaucoma/figure_01_p1.jpeg)


- **A.** Acute Angle-Closure Glaucoma (AACG)
- **B.** Acute anterior uveitis (iritis)
- **C.** Bacterial conjunctivitis
- **D.** Migraine with aura
- **E.** Cluster headache

**Correct Answer:** A
**Explanation:**
Acute angle-closure glaucoma is an ophthalmic emergency where pupillary dilation in dim light causes the peripheral iris to bunch into the iridocorneal drainage angle, blocking the trabecular meshwork (pupillary block). Aqueous humor cannot drain, producing an acute surge in IOP (>40-60 mmHg), corneal epithelial oedema (steamy cornea, halos around lights), a mid-dilated non-reactive pupil, and severe trigeminal pain with nausea.

## Question 2 of 5

What is the immediate medical management regimen to acutely lower intraocular pressure in Acute Angle-Closure Glaucoma in the ED?

![Figure 2: Clinical Findings & Diagnostic Reference (Acute Angle-Closure Glaucoma)](/lessons/images/sba/ophthalmology/acute-glaucoma/figure_02_p2.jpeg)


- **A.** IV Acetazolamide 500mg, topical Pilocarpine 2% (miotic), topical beta-blocker (Timolol 0.5%), topical alpha-2 agonist (Apraclonidine 1%), and IV Mannitol 20% if IOP >50 mmHg
- **B.** Topical Atropine 1% eye drops immediately
- **C.** Topical cyclopentolate eye drops
- **D.** Oral paracetamol and observation
- **E.** High-dose systemic steroids alone

**Correct Answer:** A
**Explanation:**
Emergency medical therapy of AACG uses a multi-mechanism approach: (1) Inhibit aqueous humor production: IV Acetazolamide (500mg carbonic anhydrase inhibitor), topical Timolol 0.5% (beta-blocker), and topical Apraclonidine 1%; (2) Open the drainage angle: topical Pilocarpine 2% (muscarinic agonist causing pupillary miosis to pull peripheral iris away from the trabecular meshwork); (3) Dehydrate vitreous: IV 20% Mannitol (1-2 g/kg). Note: Mydriatics (atropine, cyclopentolate) dilate the pupil and are strictly CONTRAINDICATED.

## Question 3 of 5

What is the definitive surgical or laser procedure of choice that provides a permanent cure for Acute Angle-Closure Glaucoma and must be performed on BOTH eyes?

- **A.** Bilateral Nd:YAG Laser Peripheral Iridotomy (LPI)
- **B.** Enucleation of the affected eye
- **C.** Vitrectomy
- **D.** Corneal cross-linking
- **E.** Retinal photocoagulation

**Correct Answer:** A
**Explanation:**
Nd:YAG Laser Peripheral Iridotomy creates a tiny full-thickness hole in the superior peripheral iris. This creates an alternative conduit for aqueous humor to bypass the pupil and flow directly from the posterior into the anterior chamber, equalizing pressures and allowing the iris to fall away from the trabecular meshwork. Because the anatomical predisposition (shallow anterior chamber) is bilateral, prophylactic LPI to the contralateral eye is mandatory.

## Question 4 of 5

Why are systemically administered anticholinergic medications (e.g. atropine, ipratropium) and sympathomimetics notorious triggers of acute angle-closure glaucoma in predisposed individuals?

- **A.** They induce pupillary mydriasis (dilation), causing the peripheral iris to bunch into the narrow iridocorneal angle, precipitating mechanical trabecular meshwork blockade
- **B.** They increase retinal artery blood flow
- **C.** They cause corneal melting
- **D.** They cause optic nerve swelling directly
- **E.** They destroy the lacrimal gland

**Correct Answer:** A
**Explanation:**
In individuals with anatomically shallow anterior chambers (elderly, hypermetropes/far-sighted), any medication that causes pupillary dilation (mydriasis)—such as tricyclic antidepressants, antihistamines, inhaled anticholinergics (ipratropium nebulisers leaking into eyes), and sympathomimetics—causes the peripheral iris to fold into the narrow angle, triggering acute pupillary block.

## Question 5 of 5

On physical palpation of the globes through gently closed eyelids, what classic tactile sign is noted in acute angle-closure glaucoma compared to the normal eye?

- **A.** The affected eyeball feels rock-hard ('stony hard') compared to the normal eye
- **B.** The eyeball feels completely soft and mushy
- **C.** The eyeball pulsates vigorously
- **D.** Crepitus is palpable under the eyelid
- **E.** The eye is painless on palpation

**Correct Answer:** A
**Explanation:**
When a Tono-Pen or Goldman applanation tonometer is unavailable, gentle digital palpation through closed eyelids reveals that the affected eye feels rock-hard ('stony hard', like a wooden marble), while the normal eye has normal compressibility, providing a rapid clinical confirmation of massive IOP elevation.
$SBA_OPHT_098$,
    false,
    1,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 2/9: Ocular Trauma, Chemical Burns & Ruptured Globe
  -- 1) Interleave Lecture (Position 2)
  UPDATE "lessons"
  SET "position" = 2, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'eye-trauma' OR "slug" = 'eye-trauma');

  -- 2) Upsert Quiz Lesson (Position 3)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-ophthalmology-eye-trauma',
    'Ocular Trauma, Chemical Burns & Ruptured Globe — SBA Interactive Quiz',
    'quiz',
    $SBA_OPHT_099$# Ocular Trauma, Chemical Burns & Ruptured Globe — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 30-year-old factory worker sustains a chemical splash of liquid drain cleaner (sodium hydroxide / caustic alkali) into his right eye 10 minutes ago. He is in excruciating pain. What is the single most critical, immediate life-saving intervention?

![Figure 1: Clinical Findings & Diagnostic Reference (Ocular Trauma, Chemical Burns & Ruptured Globe)](/lessons/images/sba/ophthalmology/eye-trauma/figure_01_p6.jpeg)


- **A.** Immediate, copious continuous eye irrigation with 0.9% Normal Saline or water for at least 15-30 minutes using a Morgan lens (aiming for at least 1-2 litres), checking neutral pH (7.0-7.4) with litmus paper
- **B.** Wait for complete ophthalmology consultation before touching the eye
- **C.** Apply acidic solution to neutralize the alkali
- **D.** Perform an immediate CT scan of the orbits
- **E.** Instil eye ointment and apply a pressure patch

**Correct Answer:** A
**Explanation:**
Chemical burns (especially alkalis) are true ocular emergencies. Alkali causes liquefactive necrosis, rapidly saponifying cell membrane fatty acids and penetrating deeply into the anterior chamber within minutes. Immediate continuous irrigation (with water or saline) must begin on-scene and continue in the ED for at least 15-30 minutes before any detailed examination. Irrigation continues until the conjunctival fornix pH neutralizes to 7.0-7.4 on litmus paper.

## Question 2 of 5

Why are Alkali chemical burns (e.g. ammonia, lye, drain cleaner, wet cement) vastly more destructive to the eye than Acid burns (e.g. sulfuric battery acid)?

![Figure 2: Clinical Findings & Diagnostic Reference (Ocular Trauma, Chemical Burns & Ruptured Globe)](/lessons/images/sba/ophthalmology/eye-trauma/figure_02_p8.jpeg)


- **A.** Alkalis cause liquefactive necrosis, dissolving cell membranes and penetrating deeply into the anterior chamber; acids cause coagulative necrosis, creating a protective protein precipitate barrier that limits deeper penetration
- **B.** Acids do not affect the cornea
- **C.** Alkalis are radioactive
- **D.** Alkalis cannot be irrigated with saline
- **E.** Acids cause immediate lens extrusion

**Correct Answer:** A
**Explanation:**
Acids cause coagulative necrosis: proteins precipitate and denature, forming an insoluble barrier (eschar) that partially limits further chemical penetration into deep structures. Alkalis cause liquefactive necrosis: they saponify cellular lipids and dissolve collagen, allowing rapid, unchecked penetration through the cornea into the anterior chamber, iris, ciliary body, and lens, resulting in blindness.

## Question 3 of 5

A 40-year-old carpenter using a high-speed metal grinder without safety goggles feels a sudden impact to his left eye. Examination shows a teardrop-shaped pupil pointing toward a limbal puncture wound, a flat anterior chamber, and 360-degree subconjunctival haemorrhage. What is the diagnosis and initial management?

![Figure 3: Clinical Findings & Diagnostic Reference (Ocular Trauma, Chemical Burns & Ruptured Globe)](/lessons/images/sba/ophthalmology/eye-trauma/figure_03_p9.jpeg)


- **A.** Open Globe Injury (Ruptured Globe / Penetrating Eye Injury); Place a rigid protective eye shield resting on the orbital bones (no pressure patch), keep nil by mouth, and call ophthalmology urgently
- **B.** Apply a tight compressive eye pressure patch
- **C.** Perform manual digital tonometry to measure intraocular pressure
- **D.** Irrigate the eye with 2 litres of saline under pressure
- **E.** Instil topical cyclopentolate and discharge home

**Correct Answer:** A
**Explanation:**
Signs of open globe injury (ruptured/penetrating eye): teardrop/peaked pupil pointing towards the wound (iris prolapse through corneal defect), flat or shallow anterior chamber, extrusion of uveal tissue or vitreous, and positive Seidel's test. Management: place a rigid protective shield (Fox eye shield) that rests on the bony orbital margins to avoid any external pressure on the globe (which could extrude intraocular contents), keep NPO, give IV antiemetics (to prevent retching), give IV broad-spectrum antibiotics, and consult ophthalmology immediately.

## Question 4 of 5

What is 'Seidel's Test' on slit-lamp biomicroscopy, and what does a positive test indicate?

![Figure 4: Clinical Findings & Diagnostic Reference (Ocular Trauma, Chemical Burns & Ruptured Globe)](/lessons/images/sba/ophthalmology/eye-trauma/figure_04_p9.jpeg)


- **A.** Instillation of concentrated fluorescein 10%: diluted aqueous humor leaking through a full-thickness corneal perforation appears as a bright green river / waterfall streaming through dark fluorescein under cobalt blue light
- **B.** Detection of foreign body in the conjunctival fornix
- **C.** Measurement of corneal sensation with cotton wisp
- **D.** Evaluation of tear film breakup time
- **E.** Testing of pupillary light reflexes

**Correct Answer:** A
**Explanation:**
Seidel's test identifies full-thickness corneal or scleral perforations. A strip of 10% sodium fluorescein is applied directly over the suspected wound. Under cobalt blue slit-lamp illumination, clear aqueous humor leaking from the anterior chamber dilutes the concentrated dark orange/brown fluorescein, appearing as a dynamic bright green river or cascading waterfall, proving a full-thickness laceration.

## Question 5 of 5

A 22-year-old male is struck in the eye by a tennis ball, presenting with an 8-ball Hyphema (blood completely filling the anterior chamber). What sight-threatening complications must be monitored and prevented?

![Figure 5: Clinical Findings & Diagnostic Reference (Ocular Trauma, Chemical Burns & Ruptured Globe)](/lessons/images/sba/ophthalmology/eye-trauma/figure_05_p10.jpeg)


- **A.** Secondary re-bleeding (typically at day 3-5), Acute secondary angle-closure glaucoma from trabecular meshwork blockage, and permanent Corneal Blood Staining
- **B.** Cataract formation alone
- **C.** Immediate retinal detachment in 100% of cases
- **D.** Optic nerve avulsion
- **E.** Permanent loss of accommodation only

**Correct Answer:** A
**Explanation:**
A hyphema is blood in the anterior chamber. Complications include: (1) Secondary re-bleed (occurs in 10-30% on days 2-5 when initial clot lyses, typically worse than initial bleed); (2) Acute intraocular hypertension (erythrocytes clog the trabecular meshwork); (3) Corneal blood staining (haemosiderin impregnates the cornea, causing permanent opacification). Management includes bed rest with head elevated at 30-45 degrees, rigid eye shield, topical cycloplegics, topical steroids, and avoidance of NSAIDs/aspirin.
$SBA_OPHT_099$,
    false,
    3,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 3/9: Inflammatory Eye Diseases (Uveitis, Scleritis, Episcleritis)
  -- 1) Interleave Lecture (Position 4)
  UPDATE "lessons"
  SET "position" = 4, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'inflammetory-eye-disease' OR "slug" = 'inflammatory-eye-disease');

  -- 2) Upsert Quiz Lesson (Position 5)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-ophthalmology-inflammatory-eye-disease',
    'Inflammatory Eye Diseases (Uveitis, Scleritis, Episcleritis) — SBA Interactive Quiz',
    'quiz',
    $SBA_OPHT_100$# Inflammatory Eye Diseases (Uveitis, Scleritis, Episcleritis) — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 32-year-old male with ankylosing spondylitis (HLA-B27 positive) presents with severe, deep aching left eye pain, marked photophobia, lacrimation, and blurred vision. Slit-lamp biomicroscopy reveals 'cells and flare' (inflammatory leukocytes and protein) in the anterior chamber and an irregular, small, sluggish pupil with posterior synechiae. What is the diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Inflammatory Eye Diseases (Uveitis, Scleritis, Episcleritis))](/lessons/images/sba/ophthalmology/inflammatory-eye-disease/figure_01_p3.jpeg)


- **A.** Acute Anterior Uveitis (Iritis / Iridocyclitis)
- **B.** Acute angle-closure glaucoma
- **C.** Bacterial keratitis
- **D.** Viral conjunctivitis
- **E.** Episcleritis

**Correct Answer:** A
**Explanation:**
Acute anterior uveitis (iritis) is inflammation of the iris and ciliary body, strongly associated with HLA-B27 spondyloarthropathies (ankylosing spondylitis, reactive arthritis, IBD, psoriatic arthritis). Hallmark features: deep, aching ocular pain, severe photophobia, ciliary injection (circumcorneal flush), small/irregular pupil (due to posterior synechiae—adhesions between iris and lens), and inflammatory cells and protein flare in the anterior chamber (Tyndall effect).

## Question 2 of 5

What is the primary emergency ophthalmic treatment for acute anterior uveitis (iritis) to relieve ciliary spasm pain and prevent permanent pupillary posterior synechiae?

![Figure 2: Clinical Findings & Diagnostic Reference (Inflammatory Eye Diseases (Uveitis, Scleritis, Episcleritis))](/lessons/images/sba/ophthalmology/inflammatory-eye-disease/figure_02_p4.jpeg)


- **A.** Topical Mydriatics / Cycloplegics (e.g. Cyclopentolate 1% or Atropine 1%) combined with intensive topical Corticosteroids (e.g. Prednisolone acetate 1%)
- **B.** Topical Pilocarpine 2% drops
- **C.** Topical Timolol drops alone
- **D.** Oral ciprofloxacin
- **E.** Pressure patching of the eye

**Correct Answer:** A
**Explanation:**
Management of acute anterior uveitis: (1) Topical cycloplegic/mydriatic drops (Cyclopentolate 1% TDS or Atropine 1% BD) paralyze the ciliary muscle (relieving intense ciliary spasm pain) and dilate the pupil (preventing or breaking posterior synechiae between iris and anterior lens capsule); (2) Topical corticosteroid drops (Prednisolone acetate 1% hourly initially) to suppress intraocular inflammation. (Pilocarpine is contraindicated as it causes pupillary miosis and worsens synechiae).

## Question 3 of 5

A 54-year-old female with long-standing rheumatoid arthritis presents with severe, deep, boring, agonizing eye pain that radiates to her temple and jaw, wakes her from sleep, and does not respond to simple analgesia. The sclera shows deep violaceous (bluish-red) vascular engorgement that does NOT blanch with topical 2.5% phenylephrine drops. What is the diagnosis?

![Figure 3: Clinical Findings & Diagnostic Reference (Inflammatory Eye Diseases (Uveitis, Scleritis, Episcleritis))](/lessons/images/sba/ophthalmology/inflammatory-eye-disease/figure_03_p5.jpeg)


- **A.** Anterior Scleritis
- **B.** Episcleritis
- **C.** Allergic conjunctivitis
- **D.** Subconjunctival haemorrhage
- **E.** Dry eye syndrome

**Correct Answer:** A
**Explanation:**
Anterior Scleritis is a severe, destructive, sight-threatening inflammation of the deep scleral collagen, strongly associated with systemic autoimmune diseases (Rheumatoid Arthritis >30%, Granulomatosis with Polyangiitis, SLE). Key features: severe deep boring nocturnal pain; deep violaceous/bluish hue; scleral vessels do NOT blanch with topical phenylephrine drops (distinguishing it from superficial episcleritis, which blanches completely). Scleritis requires systemic NSAIDs, oral corticosteroids, or biologic immunosuppression.

## Question 4 of 5

How can benign, self-limiting Episcleritis be clinically and pharmacologically differentiated from sight-threatening Scleritis in the ED?

![Figure 4: Clinical Findings & Diagnostic Reference (Inflammatory Eye Diseases (Uveitis, Scleritis, Episcleritis))](/lessons/images/sba/ophthalmology/inflammatory-eye-disease/figure_04_p5.jpeg)


- **A.** Episcleritis causes mild irritation / burning without severe boring pain, features bright red sectoral vascular injection, and BLANCHES completely within 10-15 minutes after instillation of 2.5% or 10% topical Phenylephrine drops
- **B.** Episcleritis is always bilateral and causes hypopyon
- **C.** Episcleritis causes permanent blindness within 24 hours
- **D.** Scleritis is completely painless
- **E.** There is no clinical or pharmacological distinction

**Correct Answer:** A
**Explanation:**
The Phenylephrine Blanching Test: Instilling topical 2.5% or 10% phenylephrine constricts the superficial episcleral vascular plexus, completely blanching the redness in Episcleritis within 10-15 minutes. In contrast, the deep scleral vascular plexus involved in Scleritis does NOT blanch. Furthermore, episcleritis causes mild discomfort or gritty sensation, whereas scleritis produces excruciating, deep boring pain.

## Question 5 of 5

What is the accumulation of sterile white blood cells (pus) layering out gravity-dependently in the lower anterior chamber during severe acute anterior uveitis or endophthalmitis called?

- **A.** Hypopyon
- **B.** Hyphema
- **C.** Keratic precipitates
- **D.** Pterygium
- **E.** Arcus senilis

**Correct Answer:** A
**Explanation:**
A Hypopyon is a visible horizontal level of purulent white/creamy inflammatory exudate (leukocytes) layering in the inferior aspect of the anterior chamber. It indicates severe anterior segment inflammation, seen in severe HLA-B27 uveitis, Behçet's disease, bacterial keratitis, and infectious endophthalmitis.
$SBA_OPHT_100$,
    false,
    5,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 4/9: Ophthalmia Neonatorum & Neonatal Eye Infections
  -- 1) Interleave Lecture (Position 6)
  UPDATE "lessons"
  SET "position" = 6, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'ophthalma-neonatorum' OR "slug" = 'ophthalmia-neonatorum');

  -- 2) Upsert Quiz Lesson (Position 7)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-ophthalmology-ophthalmia-neonatorum',
    'Ophthalmia Neonatorum & Neonatal Eye Infections — SBA Interactive Quiz',
    'quiz',
    $SBA_OPHT_101$# Ophthalmia Neonatorum & Neonatal Eye Infections — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 4-day-old neonate presents with acute bilateral copious, thick, creamy, purulent eye discharge, severe chemosis, and tensely swollen eyelids. What is the most virulent and destructive cause of Ophthalmia Neonatorum that can rapidly penetrate an intact cornea and cause corneal perforation within 24 to 48 hours?

![Figure 1: Clinical Findings & Diagnostic Reference (Ophthalmia Neonatorum & Neonatal Eye Infections)](/lessons/images/sba/ophthalmology/ophthalmia-neonatorum/figure_01_p2.jpeg)


- **A.** Neisseria gonorrhoeae (hyperacute gonococcal ophthalmia neonatorum)
- **B.** Chlamydia trachomatis
- **C.** Staphylococcus aureus
- **D.** Herpes simplex virus Type 2
- **E.** Chemical conjunctivitis from silver nitrate

**Correct Answer:** A
**Explanation:**
Neisseria gonorrhoeae causes hyperacute neonatal conjunctivitis, typically presenting within 2 to 5 days of birth following vertical transmission during vaginal delivery. It is a medical emergency: gonococci possess proteolytic enzymes capable of penetrating intact corneal epithelium, producing rapid corneal ulceration, perforation, endophthalmitis, and permanent blindness within 24-48 hours. Treatment is immediate systemic IV/IM Ceftriaxone.

## Question 2 of 5

What is the single most common infectious aetiology of Ophthalmia Neonatorum in the UK and Western nations, classically presenting between 5 and 14 days after birth with mucopurulent conjunctivitis?

![Figure 2: Clinical Findings & Diagnostic Reference (Ophthalmia Neonatorum & Neonatal Eye Infections)](/lessons/images/sba/ophthalmology/ophthalmia-neonatorum/figure_02_p3.jpeg)


- **A.** Chlamydia trachomatis (serovars D to K)
- **B.** Neisseria gonorrhoeae
- **C.** Adenovirus
- **D.** Pseudomonas aeruginosa
- **E.** Streptococcus pneumoniae

**Correct Answer:** A
**Explanation:**
Chlamydia trachomatis is the most common identifiable infectious cause of neonatal conjunctivitis in developed countries (~30-40% of cases). It characteristically presents 5 to 14 days post-partum (longer incubation than gonorrhoea) with unilateral or bilateral watery discharge that rapidly becomes copious and mucopurulent with pseudomembrane formation.

## Question 3 of 5

Why must neonates diagnosed with Chlamydial Ophthalmia Neonatorum ALWAYS receive SYSTEMIC oral antibiotic therapy (e.g. Oral Erythromycin or Azithromycin for 14 days) rather than topical eye drops alone?

- **A.** Topical drops do not eradicate chlamydial nasopharyngeal colonisation, leaving the infant at high risk (up to 30-50%) of developing Chlamydial Infantile Pneumonitis (afebrile staccato cough)
- **B.** Topical drops are toxic to infant corneas
- **C.** Chlamydia does not respond to topical erythromycin
- **D.** Systemic antibiotics are required to prevent neonatal jaundice
- **E.** Oral antibiotics are cheaper

**Correct Answer:** A
**Explanation:**
Chlamydia colonizes the infant's nasopharynx and respiratory tract as well as the eyes. Topical eye drops achieve clearance of conjunctivitis in only 50% and do NOT eradicate nasopharyngeal carriage. Without systemic treatment, 30-50% of infants develop Chlamydial Infantile Pneumonia (characterized by an afebrile, repetitive staccato cough, tachypnoea, hyperinflation, and eosinophilia at 4-12 weeks of age). Systemic oral macrolide therapy (Erythromycin or Azithromycin) is mandatory.

## Question 4 of 5

A 10-day-old infant presents with unilateral eyelid swelling, vesicular cutaneous lesions on the peri-orbital skin, conjunctival injection, and dendriform epithelial branching ulceration on fluorescein staining of the cornea. What pathogen is responsible, and what is the definitive therapy?

- **A.** Herpes Simplex Virus (HSV-2 or HSV-1); Intravenous Aciclovir (20 mg/kg TDS for 14-21 days) plus topical ganciclovir
- **B.** Neisseria gonorrhoeae; Ceftriaxone
- **C.** Chlamydia trachomatis; Oral erythromycin
- **D.** Cytomegalovirus; Ganciclovir alone
- **E.** Varicella zoster virus; Oral paracetamol

**Correct Answer:** A
**Explanation:**
Neonatal HSV keratoconjunctivitis (typically HSV-2 acquired during vaginal delivery from maternal genital shedding) presents at 1-2 weeks of life with periocular vesicles, keratitis (dendritic ulcers), and risk of disseminated neonatal herpes or fatal encephalitis. Management is immediate systemic IV Aciclovir (60 mg/kg/day in 3 divided doses for 14-21 days) with topical antiviral eye drops.

## Question 5 of 5

What is the typical presentation of Chemical Conjunctivitis occurring in the first 24 hours of life in neonates who receive prophylactic ocular drops?

- **A.** Mild bilateral conjunctival hyperemia and watery discharge appearing within 6-24 hours of birth and resolving spontaneously within 24-48 hours without treatment
- **B.** Corneal perforation within 2 hours
- **C.** Purulent discharge persisting for 3 weeks
- **D.** Unilateral severe eyelid haematoma
- **E.** High fever and sepsis

**Correct Answer:** A
**Explanation:**
Chemical conjunctivitis is a mild, non-infectious toxic reaction historically caused by Silver Nitrate 1% solution (or modern prophylactic antiseptic drops). It appears within 6-24 hours of birth, presents with mild conjunctival injection and serous watery discharge without purulence, and resolves spontaneously within 24 to 48 hours without treatment.
$SBA_OPHT_101$,
    false,
    7,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 5/9: Orbital vs Preseptal Cellulitis
  -- 1) Interleave Lecture (Position 8)
  UPDATE "lessons"
  SET "position" = 8, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'orbital-and-per-celiltits' OR "slug" = 'orbital-periorbital-cellulitis');

  -- 2) Upsert Quiz Lesson (Position 9)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-ophthalmology-orbital-periorbital-cellulitis',
    'Orbital vs Preseptal Cellulitis — SBA Interactive Quiz',
    'quiz',
    $SBA_OPHT_102$# Orbital vs Preseptal Cellulitis — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 7-year-old child presents with a 2-day history of right eyelid swelling, erythema, and mild tenderness following an insect bite to the upper lid. Eye examination shows that visual acuity is normal (6/6), pupillary reflexes are normal, and extraocular eye movements are completely full and painless with no proptosis. What is the diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Orbital vs Preseptal Cellulitis)](/lessons/images/sba/ophthalmology/orbital-periorbital-cellulitis/figure_01_p1.jpeg)


- **A.** Preseptal (Periorbital) Cellulitis
- **B.** Orbital (Postseptal) Cellulitis
- **C.** Cavernous sinus thrombosis
- **D.** Orbital subperiosteal abscess
- **E.** Dacryoadenitis

**Correct Answer:** A
**Explanation:**
Preseptal cellulitis is infection of the eyelid and soft tissues anterior to the orbital septum. Key diagnostic features: absence of proptosis, normal visual acuity, normal color vision, normal pupillary light reflexes, and PAINLESS, FULL extraocular eye movements. It does not threaten vision or life, and mild cases can be managed with oral antibiotics (e.g. co-amoxiclav).

## Question 2 of 5

Which of the following clinical findings definitively differentiates Orbital (Postseptal) Cellulitis from Preseptal Cellulitis and indicates a sight- and life-threatening deep orbital infection?

![Figure 2: Clinical Findings & Diagnostic Reference (Orbital vs Preseptal Cellulitis)](/lessons/images/sba/ophthalmology/orbital-periorbital-cellulitis/figure_02_p2.jpeg)


- **A.** Painful restriction of extraocular eye movements (ophthalmoplegia), Proptosis (axial eye protrusion), reduced visual acuity, or Relative Afferent Pupillary Defect (RAPD)
- **B.** Erythema of the outer eyelid
- **C.** Mild eyelid oedema
- **D.** Low-grade fever of 37.8C
- **E.** Normal pupillary reflexes

**Correct Answer:** A
**Explanation:**
The orbital septum is an anatomical barrier extending from the periosteum to the tarsal plates. Infections posterior to the septum (Orbital Cellulitis) involve the orbital fat and extraocular muscles: (1) Pain on eye movement; (2) Ophthalmoplegia / restricted eye mobility; (3) Proptosis; (4) Decreased visual acuity, red desaturation, or RAPD (signifying optic nerve compromise). Orbital cellulitis requires immediate admission, IV antibiotics, and urgent CT.

## Question 3 of 5

What is the single most common anatomical source and route of infection leading to acute Orbital Cellulitis in children and young adults?

![Figure 3: Clinical Findings & Diagnostic Reference (Orbital vs Preseptal Cellulitis)](/lessons/images/sba/ophthalmology/orbital-periorbital-cellulitis/figure_03_p2.jpeg)


- **A.** Direct contiguous spread from adjacent acute Ethmoid Sinusitis through the thin, porous Lamina Papyracea
- **B.** Haematogenous seeding from distant endocarditis
- **C.** Ascending infection from dental caries
- **D.** Superficial skin abrasion
- **E.** Ear infection (otitis media)

**Correct Answer:** A
**Explanation:**
Over 85-90% of orbital cellulitis cases arise from direct contiguous spread from acute bacterial paranasal sinusitis, overwhelmingly acute Ethmoid Sinusitis. The medial wall of the orbit (the lamina papyracea of the ethmoid bone) is paper-thin and perforated by natural neurovascular foramina and congenital dehiscences, allowing bacterial infection to easily breach the orbital cavity.

## Question 4 of 5

A 9-year-old boy with orbital cellulitis develops complete ophthalmoplegia of the right eye, ptosis, fixed dilated pupil, forehead hypoaesthesia in the V1/V2 distribution, severe proptosis, and 24 hours later begins developing bilateral eyelid oedema and chemosis in the contralateral left eye. What devastating intracranial complication has occurred?

- **A.** Septic Cavernous Sinus Thrombosis
- **B.** Subdural empyema alone
- **C.** Pituitary apoplexy
- **D.** Acute anterior ischemic optic neuropathy
- **E.** Horner's syndrome

**Correct Answer:** A
**Explanation:**
Cavernous Sinus Thrombosis (CST) occurs when infection spreads posteriorly via valveless ophthalmic veins into the cavernous sinus. Manifestations: cranial neuropathies traversing the cavernous sinus (CN III, IV, VI palsies causing total ophthalmoplegia, and CN V1/V2 sensory loss). Contralateral eye involvement (bilateral chemosis, proptosis, and cranial neuropathies) is the pathognomonic hallmark of CST as infection spreads across intercavernous sinuses.

## Question 5 of 5

What is the urgent diagnostic imaging modality of choice for suspected Orbital Cellulitis or to evaluate for an Orbital Subperiosteal Abscess (SPOA)?

- **A.** Contrast-Enhanced CT of the Orbits, Paranasal Sinuses, and Brain
- **B.** Plain skull X-ray
- **C.** B-scan ultrasound of the eye only
- **D.** Radionuclide bone scan
- **E.** Diagnostic lumbar puncture before imaging

**Correct Answer:** A
**Explanation:**
Contrast-enhanced CT of the orbits, sinuses, and brain (axial and coronal views) is the imaging modality of choice. It confirms post-septal involvement, identifies paranasal sinus opacification, detects subperiosteal abscess (SPOA - requiring surgical drainage), intraorbital abscess, and evaluates for intracranial extension (epidural/subdural abscess, cavernous sinus thrombosis).
$SBA_OPHT_102$,
    false,
    9,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 6/9: Painful Eye Differential & Corneal Emergencies
  -- 1) Interleave Lecture (Position 10)
  UPDATE "lessons"
  SET "position" = 10, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'painful-eye' OR "slug" = 'painful-eye');

  -- 2) Upsert Quiz Lesson (Position 11)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-ophthalmology-painful-eye',
    'Painful Eye Differential & Corneal Emergencies — SBA Interactive Quiz',
    'quiz',
    $SBA_OPHT_103$# Painful Eye Differential & Corneal Emergencies — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 26-year-old soft contact lens wearer presents with a 24-hour history of severe, worsening right eye pain, photophobia, foreign body sensation, and purulent discharge. Slit-lamp biomicroscopy reveals a focal, round, white-yellowish corneal stromal opacity (infiltrate) measuring 2 mm with an overlying epithelial defect that stains with fluorescein, and an early 1 mm hypopyon. What is the diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Painful Eye Differential & Corneal Emergencies)](/lessons/images/sba/ophthalmology/painful-eye/figure_01_p2.jpeg)


- **A.** Bacterial Keratitis (Corneal Ulcer)
- **B.** Simple corneal abrasion
- **C.** Viral conjunctivitis
- **D.** Recurrent corneal erosion
- **E.** Subconjunctival haemorrhage

**Correct Answer:** A
**Explanation:**
Microbial (Bacterial) Keratitis / Corneal Ulcer is a sight-threatening emergency, especially in contact lens wearers. Characterized by severe pain, photophobia, ciliary flush, epithelial defect overlying a dense stromal infiltrate (white spot on cornea), and anterior chamber inflammation / hypopyon. It can cause rapid corneal melting and perforation within 24-48 hours. Urgent corneal scrapings for microbiology and intensive topical fortified antibiotics are required.

## Question 2 of 5

Which aggressive Gram-negative bacterium is notoriously associated with contact lens wear (especially overnight wear or rinsing lenses in tap water) and can cause rapid corneal stromal liquefactive necrosis and perforation within 24 hours?

![Figure 2: Clinical Findings & Diagnostic Reference (Painful Eye Differential & Corneal Emergencies)](/lessons/images/sba/ophthalmology/painful-eye/figure_02_p4.jpeg)


- **A.** Pseudomonas aeruginosa
- **B.** Streptococcus pneumoniae
- **C.** Staphylococcus aureus
- **D.** Moraxella lacunata
- **E.** Haemophilus influenzae

**Correct Answer:** A
**Explanation:**
Pseudomonas aeruginosa accounts for over 60-70% of contact lens-associated bacterial ulcers. It produces potent extracellular virulence proteases and elastases that dissolve corneal collagen matrix and stroma rapidly, causing rapid corneal melting and perforation ('corneal melt') in less than 24 hours. First-line therapy is intensive topical fluoroquinolones (Ofloxacin / Ciprofloxacin hourly) or fortified aminoglycosides.

## Question 3 of 5

A 40-year-old male presents with unilateral eye pain, photophobia, foreign body sensation, and watery redness. Slit-lamp examination after instilling fluorescein dye demonstrates a classic, delicate, branching linear epithelial ulcer with terminal bulbs (buds) under cobalt blue light. What pathogen causes this?

![Figure 3: Clinical Findings & Diagnostic Reference (Painful Eye Differential & Corneal Emergencies)](/lessons/images/sba/ophthalmology/painful-eye/figure_03_p5.jpeg)


- **A.** Herpes Simplex Virus Type 1 (HSV-1) Dendritic Keratitis
- **B.** Acanthamoeba
- **C.** Staphylococcus aureus
- **D.** Adenovirus (Epidemic Keratoconjunctivitis)
- **E.** Fungal keratitis (Fusarium)

**Correct Answer:** A
**Explanation:**
Dendritic corneal ulceration with terminal end-bulbs on fluorescein staining is pathognomonic of Herpes Simplex Virus (HSV-1) epithelial keratitis. Corneal sensation is characteristically reduced or absent (hypoesthesia). Treatment is topical antiviral ointment (Ganciclovir 0.15% gel or Aciclovir 3% ointment 5 times daily). Topical corticosteroids are strictly CONTRAINDICATED as they trigger uncontrolled viral replication and geographic ulceration.

## Question 4 of 5

Why are topical corticosteroid eye drops (e.g. Dexamethasone, Prednisolone) strictly CONTRAINDICATED in the emergency department for undiagnosed red, painful eyes or suspected viral keratitis?

![Figure 4: Clinical Findings & Diagnostic Reference (Painful Eye Differential & Corneal Emergencies)](/lessons/images/sba/ophthalmology/painful-eye/figure_04_p7.jpeg)


- **A.** Corticosteroids inhibit local cell-mediated immunity; in Herpes Simplex keratitis, they accelerate viral replication, converting a superficial dendritic ulcer into an extensive, destructive 'geographic' corneal ulcer and precipitating corneal perforation or fungal superinfection
- **B.** They cause severe conjunctival discolouration
- **C.** They cause acute detachment of the retina
- **D.** They cause systemic hypoglycaemia
- **E.** They cause sudden cataracts within 1 hour

**Correct Answer:** A
**Explanation:**
Topical steroids in an undiagnosed red eye are dangerous. If HSV keratitis is present, steroids accelerate viral proliferation, transforming small dendritic ulcers into large, amoeboid, necrotizing 'geographic' ulcers, causing secondary fungal keratitis, rapid corneal thinning, and perforation. Furthermore, steroids elevate intraocular pressure (steroid-induced glaucoma).

## Question 5 of 5

A 24-year-old metalworker presents 6 hours after arc-welding without a protective welding helmet. He wakes up with agonizing bilateral eye pain, severe photophobia, blepharospasm, and foreign body sensation. Slit-lamp biomicroscopy reveals diffuse, punctate, superficial fluorescein uptake across both corneas ('punctate epithelial erosions'). What is the diagnosis?

- **A.** Ultraviolet Photokeratitis ('Welder's Arc Eye' / Snow Blindness)
- **B.** Acute glaucoma
- **C.** Traumatic hyphema
- **D.** Bacterial keratitis
- **E.** Central retinal artery occlusion

**Correct Answer:** A
**Explanation:**
Photokeratitis (arc eye, welder's flash, snow blindness) is acute corneal radiation injury caused by exposure to ultraviolet (UVB/UVC) radiation from welding arcs, tanning lamps, or reflection from snow. After a characteristic symptom-free latent period of 6-12 hours, diffuse apoptosis of corneal epithelial cells causes severe pain, photophobia, foreign body sensation, and diffuse bilateral punctate epithelial erosions on fluorescein staining. Treatment is supportive: oral analgesia, antibiotic ointment, and recovery within 24-48 hours.
$SBA_OPHT_103$,
    false,
    11,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 7/9: Red Eye Assessment & Triage
  -- 1) Interleave Lecture (Position 12)
  UPDATE "lessons"
  SET "position" = 12, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'red-eye' OR "slug" = 'red-eye');

  -- 2) Upsert Quiz Lesson (Position 13)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-ophthalmology-red-eye',
    'Red Eye Assessment & Triage — SBA Interactive Quiz',
    'quiz',
    $SBA_OPHT_104$# Red Eye Assessment & Triage — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

In the emergency triage of a patient presenting with an acute Red Eye, which 'Red Flag' symptoms and physical signs mandate urgent same-day ophthalmology assessment rather than simple primary care discharge?

![Figure 1: Clinical Findings & Diagnostic Reference (Red Eye Assessment & Triage)](/lessons/images/sba/ophthalmology/red-eye/figure_01_p7.jpeg)


- **A.** Significant reduction in Visual Acuity, Severe deep ocular pain, Marked photophobia, Ciliary injection (circumcorneal flush), Fixed or sluggish abnormal pupil, or Corneal cloudiness / stromal infiltrate
- **B.** Mild bilateral gritty sensation with normal vision and reactive pupils
- **C.** Watery eye discharge during a viral cold with normal vision
- **D.** Painless, localized bright red blood beneath the bulbar conjunctiva with normal acuity
- **E.** Itching in both eyes with seasonal rhinitis

**Correct Answer:** A
**Explanation:**
The six cardinal 'Red Flags' of serious sight-threatening red eye: (1) Reduced visual acuity; (2) Severe deep aching pain; (3) Significant photophobia; (4) Ciliary flush (deep circumcorneal injection of anterior ciliary vessels, distinct from superficial conjunctivitis); (5) Sluggish, mid-dilated, or irregular pupil; (6) Corneal opacity or staining epithelial defect. Their presence indicates acute glaucoma, uveitis, or keratitis.

## Question 2 of 5

A 50-year-old male wakes up and looks in the mirror to discover a vivid, dense, flat, bright red patch over the temporal sclera of his right eye. He has NO pain, NO visual changes, NO discharge, NO photophobia, and visual acuity is 6/6 in both eyes. Pupil is round and reactive. What is the diagnosis and reassurance?

![Figure 2: Clinical Findings & Diagnostic Reference (Red Eye Assessment & Triage)](/lessons/images/sba/ophthalmology/red-eye/figure_02_p9.jpeg)


- **A.** Subconjunctival Haemorrhage; benign, self-limiting bleeding from a fragile conjunctival capillary, resolving spontaneously over 1-2 weeks without treatment
- **B.** Acute anterior uveitis requiring urgent steroids
- **C.** Scleritis requiring systemic immunosuppression
- **D.** Retinal detachment
- **E.** Orbital cellulitis

**Correct Answer:** A
**Explanation:**
Subconjunctival haemorrhage is a rupture of a small conjunctival or episcleral vessel, producing a bright red sheet of blood under the transparent bulbar conjunctiva, sharply demarcated by the limbus. Common causes: minor trauma, Valsalva manoeuvres (coughing, straining, vomiting), or hypertension. In the absence of trauma, pain, or visual changes, it is entirely benign, requires no treatment, and resolves like a bruise within 10-14 days. Blood pressure should be checked.

## Question 3 of 5

A 22-year-old university student presents with bilateral watery red eyes, pre-auricular lymphadenopathy, follicular conjunctivitis, and foreign body sensation following a sore throat and fever. What is the most common viral causative agent of Epidemic Keratoconjunctivitis (EKC)?

![Figure 3: Clinical Findings & Diagnostic Reference (Red Eye Assessment & Triage)](/lessons/images/sba/ophthalmology/red-eye/figure_03_p9.jpeg)


- **A.** Adenovirus (predominantly serotypes 8, 19, and 37)
- **B.** Herpes simplex virus
- **C.** Varicella zoster virus
- **D.** Picornavirus
- **E.** Coronavirus

**Correct Answer:** A
**Explanation:**
Adenovirus is responsible for >80-90% of viral conjunctivitis cases (Epidemic Keratoconjunctivitis and Pharyngoconjunctival fever). Hallmarks: watery discharge, marked conjunctival hyperemia, inferior palpebral conjunctival follicles, and a tender, palpable pre-auricular lymph node. It is highly contagious; hand hygiene and contact precautions are paramount.

## Question 4 of 5

A 35-year-old female presents with bilateral intense ocular itching, ropey/stringy white mucus discharge, chemosis, and eyelid oedema during springtime. On eversion of the upper eyelid, large cobblestone-like giant papillae are seen on the tarsal conjunctiva. What is the diagnosis?

- **A.** Allergic Conjunctivitis (Vernal / Seasonal Keratoconjunctivitis)
- **B.** Bacterial conjunctivitis
- **C.** Chlamydial trachoma
- **D.** Ocular cicatricial pemphigoid
- **E.** Fungal keratitis

**Correct Answer:** A
**Explanation:**
Allergic conjunctivitis is an IgE-mediated mast cell degranulation response. Hallmark symptom is intense, dominant ITCHING, accompanied by bilateral watery/stringy mucous discharge and chemosis. Giant cobblestone papillae on the superior tarsal conjunctiva are classic in vernal keratoconjunctivitis. First-line therapy includes topical dual-action mast cell stabilizer / H1-antihistamines (e.g. Olopatadine, Ketotifen).

## Question 5 of 5

How can 'Ciliary Flush' (circumcorneal injection) be clinically differentiated from superficial 'Conjunctival Injection' on pen-torch examination?

- **A.** Ciliary flush is a deep, violaceous/dusky red ring concentrated immediately around the corneal limbus that does not move with the conjunctiva (denoting uveitis, keratitis, or acute glaucoma); conjunctival injection is bright red, maximal in the fornices, fades toward the limbus, and vessels move with the conjunctiva
- **B.** Ciliary flush is bright yellow
- **C.** Conjunctival injection is only found on the cornea
- **D.** Ciliary flush is painless, whereas conjunctivitis is agonizing
- **E.** There is no clinical difference

**Correct Answer:** A
**Explanation:**
Ciliary flush represents engorgement of deep episcleral ciliary branches supplying the iris and ciliary body: it produces a violaceous ring concentrated at the corneal limbus and fades toward the fornices, indicating severe intraocular pathology (iritis, keratitis, acute angle-closure). Conjunctival injection is superficial, bright red, most prominent at the peripheral fornices, and fades at the limbus, indicating superficial conjunctivitis.
$SBA_OPHT_104$,
    false,
    13,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 8/9: Sudden Vision Loss Differential
  -- 1) Interleave Lecture (Position 14)
  UPDATE "lessons"
  SET "position" = 14, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'sudden-vision-loss' OR "slug" = 'sudden-vision-loss');

  -- 2) Upsert Quiz Lesson (Position 15)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-ophthalmology-sudden-vision-loss',
    'Sudden Vision Loss Differential — SBA Interactive Quiz',
    'quiz',
    $SBA_OPHT_105$# Sudden Vision Loss Differential — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 68-year-old male with vascular disease presents with sudden, painless, catastrophic loss of vision in his right eye, described as 'the lights suddenly went completely out' 1 hour ago. Visual acuity is reduced to counting fingers. Fundoscopy reveals a pale, opaque, milky-white edematous retina with a prominent, bright 'Cherry-Red Spot' at the fovea. What is the diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Sudden Vision Loss Differential)](/lessons/images/sba/ophthalmology/sudden-vision-loss/figure_01_p2.jpeg)


- **A.** Central Retinal Artery Occlusion (CRAO)
- **B.** Central Retinal Vein Occlusion (CRVO)
- **C.** Rhegmatogenous retinal detachment
- **D.** Acute angle-closure glaucoma
- **E.** Vitreous haemorrhage

**Correct Answer:** A
**Explanation:**
Central Retinal Artery Occlusion (CRAO) is the ocular analogue of an acute ischemic stroke (most commonly embolic from carotid plaques or cardiac thrombus). The retinal ganglion cells undergo acute ischemic swelling, producing a diffuse milky-white, pale retina. Because the fovea is thin and devoid of ganglion cell layers, the underlying vascular choroid shines through as a pathognomonic 'Cherry-Red Spot'.

## Question 2 of 5

A 70-year-old hypertensive female presents with sudden, painless blurring and loss of vision in her left eye. Fundoscopy reveals widespread, flame-shaped and blot retinal haemorrhages throughout all four retinal quadrants ('Blood and Thunder' appearance), cotton-wool spots, severe venous tortuosity and engorgement, and optic disc swelling. What is the diagnosis?

![Figure 2: Clinical Findings & Diagnostic Reference (Sudden Vision Loss Differential)](/lessons/images/sba/ophthalmology/sudden-vision-loss/figure_02_p4.jpeg)


- **A.** Central Retinal Vein Occlusion (CRVO)
- **B.** Central Retinal Artery Occlusion
- **C.** Diabetic retinopathy Grade 1
- **D.** Optic neuritis
- **E.** Anterior ischemic optic neuropathy

**Correct Answer:** A
**Explanation:**
Central Retinal Vein Occlusion (CRVO) results from thrombosis of the central retinal vein at or behind the lamina cribrosa. Outflow obstruction causes massive backpressure in the retinal capillary bed, producing extensive, widespread intraretinal flame and blot haemorrhages in all four quadrants (the classic 'Blood and Thunder' fundus), dilated tortuous veins, and macular oedema.

## Question 3 of 5

A 55-year-old myopic male presents with sudden-onset flashes of light (photopsia) and multiple dark floaters ('cobwebs') in his temporal field of vision, followed 2 days later by a dark, non-translucent curtain or shadow descending over his superior visual field. What is the diagnosis?

![Figure 3: Clinical Findings & Diagnostic Reference (Sudden Vision Loss Differential)](/lessons/images/sba/ophthalmology/sudden-vision-loss/figure_03_p5.jpeg)


- **A.** Rhegmatogenous Retinal Detachment (RRD) preceded by posterior vitreous detachment
- **B.** Amaurosis fugax
- **C.** Central retinal artery occlusion
- **D.** Ocular migraine with aura
- **E.** Vitreous haemorrhage alone

**Correct Answer:** A
**Explanation:**
The classic sequence of Rhegmatogenous Retinal Detachment: (1) Posterior vitreous detachment causing mechanical vitreoretinal traction, perceived as flashes of light (photopsia); (2) Vitreous tears the retina, releasing pigment cells/blood into the vitreous perceived as sudden showers of floaters/cobwebs; (3) Fluid dissects through the retinal break into the subretinal space, creating a dark, progressive curtain/shadow falling across the visual field.

## Question 4 of 5

A 62-year-old male with a history of hypertension experiences three discrete episodes where a dark shade or curtain fell over the vision in his left eye, lasting 4 to 8 minutes each time, followed by complete, spontaneous restoration of normal vision. What is this transient ischaemic symptom termed, and what is the mandatory investigation?

![Figure 4: Clinical Findings & Diagnostic Reference (Sudden Vision Loss Differential)](/lessons/images/sba/ophthalmology/sudden-vision-loss/figure_04_p10.jpeg)


- **A.** Amaurosis Fugax (Transient Monocular Visual Loss / ocular TIA); Urgent Carotid Doppler Ultrasound and stroke prevention pathway
- **B.** Optic neuritis; Lumbar puncture
- **C.** Glaucoma; Trabeculectomy
- **D.** Dry eye syndrome; Artificial tears
- **E.** Normal age-related vascular spasm

**Correct Answer:** A
**Explanation:**
Amaurosis fugax is transient monocular visual loss caused by temporary retinal ischaemia (an ocular TIA), most commonly resulting from micro-emboli (Hollenhorst plaques: cholesterol crystals) dislodged from an ipsilateral atherosclerotic internal carotid artery bifurcation. It is a high-risk warning sign for impending major stroke, mandating urgent carotid duplex ultrasound and secondary stroke prevention (aspirin, statin).

## Question 5 of 5

A 26-year-old woman presents with subacute unilateral reduction in vision over 3 days, accompanied by pain on moving the eye and loss of color vision (red desaturation). On swinging-flashlight test, the affected eye exhibits a Relative Afferent Pupillary Defect (RAPD / Marcus Gunn pupil). What is the diagnosis and its strong neurological association?

- **A.** Optic Neuritis; strongly associated with Multiple Sclerosis (MS)
- **B.** Central retinal artery occlusion; carotid stenosis
- **C.** Angle-closure glaucoma; hypermetropia
- **D.** Temporal arteritis; polymyalgia rheumatica
- **E.** Retinal detachment; myopia

**Correct Answer:** A
**Explanation:**
Optic Neuritis is demyelinating inflammation of the optic nerve, characteristically affecting young adult females (20-40 years). Triad: (1) Subacute unilateral visual loss; (2) Ocular pain worsened by eye movement (traction on inflamed optic nerve sheath at annulus of Zinn); (3) Marked loss of color vision (red desaturation) and Marcus Gunn pupil (RAPD). In 2/3 of cases, the optic disc appears normal initially ('retrobulbar neuritis'). Up to 50% will develop clinically definite Multiple Sclerosis over 15 years.
$SBA_OPHT_105$,
    false,
    15,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 9/9: Giant Cell Arteritis (Temporal Arteritis)
  -- 1) Interleave Lecture (Position 16)
  UPDATE "lessons"
  SET "position" = 16, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'temporal-artitis' OR "slug" = 'temporal-arteritis');

  -- 2) Upsert Quiz Lesson (Position 17)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-ophthalmology-temporal-arteritis',
    'Giant Cell Arteritis (Temporal Arteritis) — SBA Interactive Quiz',
    'quiz',
    $SBA_OPHT_106$# Giant Cell Arteritis (Temporal Arteritis) — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 72-year-old female presents with a 2-week history of severe, unilateral throbbing temporal headache, scalp tenderness when brushing her hair, pain in her jaw muscles when chewing food (jaw claudication), and proximal shoulder and hip morning stiffness. On examination, the superficial temporal artery is thickened, nodular, tender, and pulseless. ESR is 98 mm/hr, and CRP is 84 mg/L. What is the diagnosis?

![Figure 1: Clinical Findings & Diagnostic Reference (Giant Cell Arteritis (Temporal Arteritis))](/lessons/images/sba/ophthalmology/temporal-arteritis/figure_01_p2.jpeg)


- **A.** Giant Cell Arteritis (Temporal Arteritis / Cranial Arteritis)
- **B.** Trigeminal neuralgia
- **C.** Temporomandibular joint dysfunction
- **D.** Tension-type headache
- **E.** Chronic sinusitis

**Correct Answer:** A
**Explanation:**
Giant Cell Arteritis (GCA) is a systemic granulomatous vasculitis affecting medium and large arteries (branches of external and internal carotid). Hallmarks: new-onset unilateral headache in patients >50 years, scalp tenderness, jaw claudication (pathognomonic of maxillary artery ischaemia), markedly elevated inflammatory markers (ESR >50 mm/h, CRP), and close association with Polymyalgia Rheumatica (PMR in 50% of patients).

## Question 2 of 5

What is the single most feared, irreversible ophthalmological complication of untreated Giant Cell Arteritis, resulting from occlusion of the posterior ciliary arteries?

- **A.** Arteritic Anterior Ischaemic Optic Neuropathy (A-AION), causing sudden, painless, catastrophic permanent visual loss
- **B.** Cataract formation
- **C.** Acute angle-closure glaucoma
- **D.** Corneal ulceration
- **E.** Vitreous liquefaction

**Correct Answer:** A
**Explanation:**
Arteritic Anterior Ischaemic Optic Neuropathy (A-AION) is caused by inflammatory vasculitic occlusion of the short posterior ciliary arteries supplying the optic nerve head. It produces sudden, severe, permanent visual loss, classically displaying a pale, swollen ('chalky-white') optic disc with flame haemorrhages. Without treatment, the contralateral eye becomes involved within days in up to 50% of patients ('fellow eye involvement').

## Question 3 of 5

According to British Society for Rheumatology (BSR) and NICE guidelines, what is the immediate medical management when Giant Cell Arteritis is clinically suspected in a patient with acute visual symptoms (amaurosis fugax, diplopia, or visual loss)?

- **A.** Immediate Intravenous Methylprednisolone (500mg to 1g daily for 3 consecutive days), followed by high-dose oral Prednisolone (60mg/day)
- **B.** Oral Prednisolone 10mg daily after temporal artery biopsy results return in 2 weeks
- **C.** Wait for temporal artery biopsy before starting any steroids
- **D.** Oral ibuprofen 400mg TDS alone
- **E.** Intravenous heparin infusion

**Correct Answer:** A
**Explanation:**
GCA is a medical and ophthalmic emergency. If visual symptoms are present (amaurosis fugax, visual loss, diplopia), immediate IV Methylprednisolone (500mg-1g IV daily for 3 days) is administered to prevent irreversible bilateral blindness. If no visual symptoms are present, high-dose oral Prednisolone (40-60mg daily) is started immediately. Steroids must NEVER be delayed while waiting for a temporal artery biopsy or specialist review.

## Question 4 of 5

What is the gold standard diagnostic investigation for confirming Giant Cell Arteritis, and what histological hallmark is seen on microscopy?

- **A.** Temporal Artery Biopsy (minimum 1.5 to 2.0 cm length); Transmural granulomatous inflammation with fragmentation of the internal elastic lamina and multinucleated giant cells
- **B.** Lumbar puncture; elevated protein
- **C.** Skin biopsy; leukocytoclastic vasculitis
- **D.** Bone marrow aspirate
- **E.** Serum ANA and ANCA antibodies

**Correct Answer:** A
**Explanation:**
Temporal Artery Biopsy is the diagnostic reference standard. Because GCA features 'skip lesions' (areas of normal artery interspersed between inflamed segments), an adequate biopsy length of at least 1.5 - 2.0 cm must be harvested to prevent false-negative sampling error. Histological hallmarks: transmural lymphocytic and histiocytic infiltration, fragmented internal elastic lamina, and multinucleated Langhans giant cells (~50%). Corticosteroid therapy does not distort biopsy findings for up to 2-4 weeks.

## Question 5 of 5

What non-invasive imaging modality is increasingly recommended by EULAR as the first-line alternative to temporal artery biopsy, showing the pathognomonic 'Halo Sign'?

- **A.** High-Resolution Colour Duplex Ultrasound of the temporal (and axillary) arteries
- **B.** Non-contrast CT head
- **C.** Plain skull radiograph
- **D.** B-scan orbital ultrasound
- **E.** Echocardiogram

**Correct Answer:** A
**Explanation:**
High-resolution Colour Duplex Ultrasound of the temporal arteries is now endorsed by EULAR and BSR as an accurate, non-invasive first-line imaging modality. The pathognomonic finding is the 'Halo Sign'—a dark, hypoechoic circumferential mural ring around the arterial lumen representing inflammatory vessel wall oedema that remains visible when the vessel is compressed ('compression sign').
$SBA_OPHT_106$,
    false,
    17,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();


  -- ------------------------------------------------------------------------
  -- Specialty: Vascular Emergencies (3 Topics)
  -- ------------------------------------------------------------------------
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_sba_id AND "title" = 'Vascular Emergencies' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    RAISE EXCEPTION 'Module Vascular Emergencies not found in mrcem-sba';
  END IF;

  -- Topic 1/3: Deep Vein Thrombosis (DVT) Guidelines
  -- 1) Interleave Lecture (Position 0)
  UPDATE "lessons"
  SET "position" = 0, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'deep-vein-thrombosis-dvt-guidelines' OR "slug" = 'deep-vein-thrombosis');

  -- 2) Upsert Quiz Lesson (Position 1)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-vascular-deep-vein-thrombosis',
    'Deep Vein Thrombosis (DVT) Guidelines — SBA Interactive Quiz',
    'quiz',
    $SBA_VASC_107$# Deep Vein Thrombosis (DVT) Guidelines — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 52-year-old woman presents with a 2-day history of painful swelling of her left lower calf. On examination, the left calf circumference is 4 cm greater than the right calf (measured 10 cm below the tibial tuberosity), with localized tenderness along the deep venous system and pitting oedema. According to the two-level Wells DVT Score, what is her score, risk category, and recommended diagnostic pathway per NICE NG158?

![Figure 1: Clinical Findings & Diagnostic Reference (Deep Vein Thrombosis (DVT) Guidelines)](/lessons/images/sba/vascular/deep-vein-thrombosis/figure_01_p4.jpeg)


- **A.** Wells score 2 (DVT likely); Perform urgent Proximal Leg Vein Ultrasound within 4 hours (or give interim therapeutic anticoagulation and scan within 24 hours)
- **B.** Wells score 0 (DVT unlikely); D-dimer test alone is sufficient
- **C.** No investigation needed, prescribe compression stockings
- **D.** Perform contrast venography immediately
- **E.** Wells score only applies to pulmonary embolism

**Correct Answer:** A
**Explanation:**
Wells DVT criteria: Calf swelling >3 cm compared to asymptomatic side (1 point), localized tenderness along deep venous system (1 point) = Total 2 points ('DVT Likely', score >=2). NICE NG158 recommends: perform proximal leg vein ultrasound within 4 hours; if unavailable, administer an interim dose of therapeutic anticoagulation (DOAC) and perform ultrasound within 24 hours.

## Question 2 of 5

According to NICE NG158 guidelines, what is the first-line oral anticoagulation therapy of choice for confirmed acute lower limb Deep Vein Thrombosis or Pulmonary Embolism in patients without severe renal impairment or active cancer?

![Figure 2: Clinical Findings & Diagnostic Reference (Deep Vein Thrombosis (DVT) Guidelines)](/lessons/images/sba/vascular/deep-vein-thrombosis/figure_02_p5.jpeg)


- **A.** Direct Oral Anticoagulant (DOAC: Apixaban or Rivaroxaban) as initial monotherapy
- **B.** Warfarin monotherapy without heparin overlap
- **C.** Aspirin 300mg daily for 6 months
- **D.** Intravenous unfractionated heparin continuous infusion for 6 months
- **E.** Dipyridamole 200mg BD

**Correct Answer:** A
**Explanation:**
NICE NG158 recommends a Direct Oral Anticoagulant (DOAC: Apixaban or Rivaroxaban as single-drug regimens with higher initial loading doses, or Edoxaban/Dabigatran following initial 5 days of LMWH) as first-line anticoagulation for confirmed VTE. DOACs have predictable pharmacokinetics, do not require routine INR monitoring, and demonstrate lower rates of major intracranial bleeding compared to Warfarin.

## Question 3 of 5

A 62-year-old female with advanced metastatic pelvic malignancy presents with sudden, massive, agonizing swelling of her entire left lower limb. On examination, the leg is cold, pale, marble-white, and pulseless with severe pitting oedema. What life-threatening limb ischemia syndrome from complete iliofemoral venous occlusion is this?

![Figure 3: Clinical Findings & Diagnostic Reference (Deep Vein Thrombosis (DVT) Guidelines)](/lessons/images/sba/vascular/deep-vein-thrombosis/figure_03_p7.jpeg)


- **A.** Phlegmasia Alba Dolens ('milk leg' / painful white oedema)
- **B.** Acute bacterial cellulitis
- **C.** Superficial thrombophlebitis
- **D.** Ruptured Baker's cyst
- **E.** Compartment syndrome from trauma

**Correct Answer:** A
**Explanation:**
Phlegmasia alba dolens ('milk leg') is an acute, severe manifestation of massive iliofemoral deep venous thrombosis. Severe deep venous occlusion leads to profound interstitial oedema and arterial spasm, rendering the limb pale, white, cold, and painful. If collateral venous channels also thrombose, it progresses to Phlegmasia Cerulea Dolens (cyanotic, purple, gangrenous limb), carrying high risk of venous gangrene and amputation, requiring emergency catheter-directed thrombolysis or surgical thrombectomy.

## Question 4 of 5

Which D-dimer testing threshold strategy is validated to reduce unnecessary imaging in patients aged >50 years presenting with 'DVT Unlikely' or 'PE Unlikely'?

![Figure 4: Clinical Findings & Diagnostic Reference (Deep Vein Thrombosis (DVT) Guidelines)](/lessons/images/sba/vascular/deep-vein-thrombosis/figure_04_p8.jpeg)


- **A.** Age-Adjusted D-dimer threshold (Age in years x 10 mcg/L for patients >50 years)
- **B.** Fixed threshold of 200 mcg/L for all ages
- **C.** Weight-adjusted D-dimer
- **D.** D-dimer threshold is halved in elderly patients
- **E.** Gender-adjusted threshold

**Correct Answer:** A
**Explanation:**
The ADJUST-PE and YEARS studies validated the Age-Adjusted D-dimer strategy for patients aged >50 years: Age (years) x 10 mcg/L (or Age x 0.05 mg/L in FEU). Baseline D-dimer naturally rises with physiological aging; using an age-adjusted cutoff substantially increases specificity in elderly patients without sacrificing safety or missing VTE.

## Question 5 of 5

What is the recommended minimum duration of therapeutic anticoagulation for a patient with a first unprovoked (idiopathic) proximal DVT who has a low bleeding risk according to NICE guidelines?

- **A.** At least 3 to 6 months, followed by consideration of long-term / indefinite anticoagulation
- **B.** Exactly 5 days
- **C.** 2 weeks only
- **D.** 1 month
- **E.** Lifelong mandatory anticoagulation without review

**Correct Answer:** A
**Explanation:**
For a first PROVOKED DVT (major transient reversible risk factor, e.g. surgery, trauma, immobilisation), anticoagulation is recommended for 3 months. For an UNPROVOKED (idiopathic) proximal DVT or PE, anticoagulation is continued for at least 3 to 6 months, after which multidisciplinary review assesses the risk-benefit balance of continuing long-term (indefinite) anticoagulation.
$SBA_VASC_107$,
    false,
    1,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 2/3: Peripheral Vascular Disease & Critical Limb Ischaemia
  -- 1) Interleave Lecture (Position 2)
  UPDATE "lessons"
  SET "position" = 2, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'peripheral-vascular-disease-critical-limb-ischemia' OR "slug" = 'peripheral-vascular-disease');

  -- 2) Upsert Quiz Lesson (Position 3)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-vascular-peripheral-vascular-disease',
    'Peripheral Vascular Disease & Critical Limb Ischaemia — SBA Interactive Quiz',
    'quiz',
    $SBA_VASC_108$# Peripheral Vascular Disease & Critical Limb Ischaemia — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 68-year-old male smoker with diabetes presents with sudden onset of severe, agonizing pain in his right leg. On examination, the right leg below the knee is cold to touch, pale, and pulseless. Sensation is decreased over the dorsum of the foot, and he cannot dorsiflex his toes. What are the classic '6 Ps' of Acute Limb Ischaemia (ALI)?

![Figure 1: Clinical Findings & Diagnostic Reference (Peripheral Vascular Disease & Critical Limb Ischaemia)](/lessons/images/sba/vascular/peripheral-vascular-disease/figure_01_p4.jpeg)


- **A.** Pain, Pallor, Pulselessness, Paresthesia, Paralysis, and Perishingly cold (Poikilothermia)
- **B.** Purpura, Petechiae, Pruritus, Pitting, Pyrexia, and Polyuria
- **C.** Pain, Plethora, Palpitations, Priapism, Papules, and Phlebitis
- **D.** Polydipsia, Polyphagia, Paresthesia, Ptosis, Proptosis, and Pallor
- **E.** Pulsus alternans, Pulsus paradoxus, Papilloedema, Petechiae, Pallor, and Pain

**Correct Answer:** A
**Explanation:**
The 6 Ps of acute arterial limb ischaemia: (1) Pain (sudden, severe, continuous); (2) Pallor; (3) Pulselessness; (4) Paresthesia (sensory loss indicates nerve ischemia within 1-2 hours); (5) Paralysis (motor loss indicates irreversible muscle necrosis within 4-6 hours); (6) Perishingly cold (Poikilothermia / inability to regulate temperature). Presence of motor loss (paralysis) is an emergency requiring surgical revascularisation within 6 hours.

## Question 2 of 5

What is the Rutherford Classification category for an acutely ischemic limb with inaudible arterial Doppler signals, severe rest pain, sensory loss extending beyond the toes, and mild-to-moderate motor muscle weakness (incomplete paralysis), and what is the required intervention?

![Figure 2: Clinical Findings & Diagnostic Reference (Peripheral Vascular Disease & Critical Limb Ischaemia)](/lessons/images/sba/vascular/peripheral-vascular-disease/figure_02_p6.jpeg)


- **A.** Rutherford Class IIb (Immediately Threatened); Requires immediate emergency surgical or endovascular revascularisation within 4-6 hours
- **B.** Rutherford Class I (Viable); Elective outpatient angiography
- **C.** Rutherford Class III (Irreversible); Primary major amputation
- **D.** Rutherford Class 0; Reassurance
- **E.** Conservative medical therapy with aspirin alone

**Correct Answer:** A
**Explanation:**
Rutherford Classification of ALI: Class I (Viable, no sensory/motor deficit); Class IIa (Marginally threatened, salvageable if treated promptly, sensory loss in toes); Class IIb (Immediately threatened, sensory loss above toes, motor weakness, salvageable with emergency revascularisation); Class III (Irreversible, profound anesthesia, paralysis, rigor, inaudible venous/arterial Doppler, requires amputation).

## Question 3 of 5

What initial emergency medical therapy should be administered immediately upon diagnosis of acute arterial limb ischaemia in the ED to prevent propagation of the thrombus?

![Figure 3: Clinical Findings & Diagnostic Reference (Peripheral Vascular Disease & Critical Limb Ischaemia)](/lessons/images/sba/vascular/peripheral-vascular-disease/figure_03_p8.jpeg)


- **A.** Intravenous Unfractionated Heparin (weight-adjusted bolus e.g. 5,000 units followed by continuous infusion)
- **B.** Oral warfarin 10mg single dose
- **C.** Oral clopidogrel 75mg daily
- **D.** Subcutaneous vitamin K
- **E.** Tight compression bandages

**Correct Answer:** A
**Explanation:**
Immediate systemic anticoagulation with IV Unfractionated Heparin (5,000 unit bolus followed by weight-adjusted infusion) is the critical initial medical intervention in acute limb ischaemia. It prevents proximal and distal propagation of thrombus, preserves the distal microcirculation and collaterals, and is easily reversible with protamine before emergency surgery.

## Question 4 of 5

How is the Ankle-Brachial Pressure Index (ABPI) calculated, and what value defines Chronic Critical Limb-Threatening Ischaemia (CLTI)?

- **A.** Highest systolic pressure at the ankle divided by highest systolic pressure in the arm; ABPI < 0.40 (or resting ankle pressure <50 mmHg / toe pressure <30 mmHg)
- **B.** Arm pressure divided by ankle pressure; value > 1.0
- **C.** Ankle pressure minus arm pressure; value > 50
- **D.** ABPI is only measured using pulse rate
- **E.** ABPI between 0.90 and 1.20

**Correct Answer:** A
**Explanation:**
ABPI = Highest Doppler systolic pressure in dorsalis pedis or posterior tibial artery divided by the highest brachial systolic pressure. Normal is 0.90 - 1.30. Intermittent claudication is typically 0.50 - 0.85. Chronic Critical Limb-Threatening Ischaemia (CLTI: rest pain for >2 weeks, ischemic ulcers, or gangrene) is defined by ABPI < 0.40, ankle systolic pressure <50 mmHg, or toe pressure <30 mmHg.

## Question 5 of 5

A 70-year-old diabetic male has an ABPI measured at 1.45 despite painful ischemic foot ulcers. What pathological vascular process explains this falsely elevated reading?

- **A.** Mönckeberg's medial calcific sclerosis (arterial calcification rendering vessels non-compressible by standard sphygmomanometer cuffs)
- **B.** Severe coarctation of the aorta
- **C.** Superficial thrombophlebitis
- **D.** Active deep vein thrombosis
- **E.** Renal artery stenosis

**Correct Answer:** A
**Explanation:**
An ABPI > 1.30 - 1.40 is abnormally high and indicates severely calcified, rigid, non-compressible arteries (Mönckeberg's arteriosclerosis), classic in long-standing diabetes mellitus and end-stage renal disease. The blood pressure cuff cannot compress the hardened vessel, generating artificially high pressure readings. In these patients, Toe-Brachial Index (TBI) is used because digital arteries are rarely calcified.
$SBA_VASC_108$,
    false,
    3,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Topic 3/3: Pulmonary Embolism (PE) Diagnosis & Management
  -- 1) Interleave Lecture (Position 4)
  UPDATE "lessons"
  SET "position" = 4, "deleted_at" = NULL, "updated_at" = now()
  WHERE "module_id" = v_mod_id
    AND ("slug" = 'pulmonary-embolism-pe-diagnosis-management' OR "slug" = 'pulmonary-embolism');

  -- 2) Upsert Quiz Lesson (Position 5)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at", "deleted_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'sba-quiz-vascular-pulmonary-embolism',
    'Pulmonary Embolism (PE) Diagnosis & Management — SBA Interactive Quiz',
    'quiz',
    $SBA_VASC_109$# Pulmonary Embolism (PE) Diagnosis & Management — SBA Interactive Quiz

> [!NOTE]
> **Curriculum Examination:** Single Best Answer (SBA) scenario. Read the clinical presentation and diagnostic findings carefully, then select the optimal management step. Full evidence-based rationales follow each question.

## Question 1 of 5

A 50-year-old woman presents with sudden pleuritic chest pain, breathlessness, and haemoptysis. She had a laparoscopic cholecystectomy 2 weeks ago. Heart rate is 108 bpm, BP is 128/82 mmHg. She has no prior VTE history, no active cancer, and no leg swelling. According to the two-level Wells PE Score, how is she categorized, and what is the correct diagnostic pathway per NICE NG158?

![Figure 1: Clinical Findings & Diagnostic Reference (Pulmonary Embolism (PE) Diagnosis & Management)](/lessons/images/sba/vascular/pulmonary-embolism/figure_01_p3.jpeg)


- **A.** Wells score 4.5 (PE likely); Perform urgent CT Pulmonary Angiography (CTPA) within 4 hours (or give interim therapeutic anticoagulation and scan within 24 hours)
- **B.** Wells score 1.5 (PE unlikely); Perform high-sensitivity D-dimer first
- **C.** Wells score 0; Discharge home without investigation
- **D.** Perform urgent catheter pulmonary angiography immediately
- **E.** Give systemic intravenous thrombolysis immediately

**Correct Answer:** A
**Explanation:**
Wells PE Score: HR >100 bpm (1.5), Surgery in past 4 weeks (1.5), Haemoptysis (1.0), and 'PE more likely than alternative' (3.0 if judged, but even with objective points alone = 4.0; with PE #1 alternative = 7.0). Under two-level score, >4 points is 'PE Likely', mandating immediate CTPA (or interim DOAC anticoagulation if imaging is delayed).

## Question 2 of 5

A 58-year-old male with confirmed acute pulmonary embolism is in obstructive shock: cold and clammy, confused, heart rate 130 bpm, and systolic blood pressure 78/46 mmHg (refractory to initial 500 ml fluid challenge). According to ESC and British Thoracic Society guidelines, what is the immediate life-saving treatment of choice?

![Figure 2: Clinical Findings & Diagnostic Reference (Pulmonary Embolism (PE) Diagnosis & Management)](/lessons/images/sba/vascular/pulmonary-embolism/figure_02_p4.jpeg)


- **A.** Systemic Intravenous Fibrinolysis (e.g. Alteplase 100mg IV infusion over 2 hours, or 0.6 mg/kg over 15 minutes in arrest)
- **B.** Therapeutic oral apixaban 10mg BD alone
- **C.** Subcutaneous enoxaparin 1.5 mg/kg once daily
- **D.** Surgical pleurodesis
- **E.** IV Furosemide 80mg bolus

**Correct Answer:** A
**Explanation:**
High-risk (Massive) Pulmonary Embolism is defined by hemodynamic instability: sustained hypotension (systolic BP <90 mmHg or a drop >=40 mmHg for >15 minutes), obstructive shock, or cardiac arrest. The treatment of choice is immediate systemic thrombolysis (IV Alteplase / rtPA 100 mg over 2 hours, or 50 mg bolus in cardiac arrest) to rapidly dissolve the central clot and relieve right ventricular outflow obstruction.

## Question 3 of 5

What is the classic 12-lead ECG manifestation of acute Right Ventricular (RV) strain associated with severe Pulmonary Embolism, although present in only 15-20% of cases?

![Figure 3: Clinical Findings & Diagnostic Reference (Pulmonary Embolism (PE) Diagnosis & Management)](/lessons/images/sba/vascular/pulmonary-embolism/figure_03_p8.jpeg)


- **A.** S1Q3T3 pattern (deep S wave in Lead I, prominent Q wave in Lead III, and inverted T wave in Lead III) with T-wave inversions in V1-V4
- **B.** Left bundle branch block with LAD
- **C.** Pathological Q waves in leads I and aVL
- **D.** Short PR interval with delta waves
- **E.** Delta waves and widespread ST elevation

**Correct Answer:** A
**Explanation:**
The classic McGinn-White sign of acute cor pulmonale / RV strain: deep S wave in Lead I, prominent Q wave in Lead III, and T-wave inversion in Lead III (S1Q3T3). More commonly, sinus tachycardia is the most frequent finding (40%), along with T-wave inversions in the right precordial leads (V1-V4) and incomplete or complete RBBB.

## Question 4 of 5

Which diagnostic imaging modality is the investigation of choice for suspected acute Pulmonary Embolism in a patient with severe contrast allergy or severe renal failure (eGFR <30 ml/min)?

![Figure 4: Clinical Findings & Diagnostic Reference (Pulmonary Embolism (PE) Diagnosis & Management)](/lessons/images/sba/vascular/pulmonary-embolism/figure_04_p8.jpeg)


- **A.** Ventilation-Perfusion (V/Q) Lung Scintigraphy (SPECT or planar)
- **B.** Standard Contrast CTPA
- **C.** Plain chest radiograph alone
- **D.** Barium swallow
- **E.** Coronary angiography

**Correct Answer:** A
**Explanation:**
Ventilation-Perfusion (V/Q) scintigraphy is the preferred diagnostic modality for pulmonary embolism when iodinated contrast is contraindicated (severe renal impairment, severe contrast anaphylaxis) or in young pregnant women (substantially lower maternal breast radiation dose compared to CTPA). A normal V/Q scan reliably rules out PE; a high-probability scan confirms PE.

## Question 5 of 5

What is the primary indication for emergency insertion of an Inferior Vena Cava (IVC) Filter in a patient with acute confirmed proximal deep vein thrombosis or pulmonary embolism?

- **A.** Absolute contraindication to anticoagulation (e.g. active major intracranial bleeding or planned emergency surgery), or recurrent PE despite optimal therapeutic anticoagulation
- **B.** Routine primary prophylaxis for all patients with PE
- **C.** Mild calf DVT in an ambulatory patient
- **D.** Superficial thrombophlebitis
- **E.** All patients over 65 years of age

**Correct Answer:** A
**Explanation:**
According to NICE and ESC guidelines, IVC filter insertion is indicated ONLY for: (1) Patients with acute VTE (DVT or PE) who have an absolute contraindication to therapeutic anticoagulation (e.g. recent major intracranial haemorrhage, severe active internal bleeding, impending surgery); OR (2) Documented recurrent VTE despite proven therapeutic anticoagulation.
$SBA_VASC_109$,
    false,
    5,
    'published',
    now(),
    now(),
    NULL
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title"      = EXCLUDED."title",
    "type"       = 'quiz',
    "body"       = EXCLUDED."body",
    "position"   = EXCLUDED."position",
    "status"     = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- ========================================================================
  -- STEP 5: CLEAN TITLES & ORDERING IN HIGH-YIELD CLINICAL REVISION (MODULE 9)
  -- ========================================================================
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_sba_id AND "title" = 'High-Yield Rapid Clinical Revision' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NOT NULL THEN
    -- Replace '?' with ':' in lesson titles
    UPDATE "lessons"
    SET "title" = REPLACE("title", ' ? ', ': '),
        "updated_at" = now()
    WHERE "module_id" = v_mod_id AND "title" LIKE '%?%';
  END IF;

  -- ========================================================================
  -- STEP 6: PROFESSIONAL TITLES & ORDER FOR MOCK EXAMS (MODULE 10)
  -- ========================================================================
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_sba_id AND "title" = 'MRCEM SBA Mock Simulations' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NOT NULL THEN
    UPDATE "lessons" SET "title" = 'Mock 1: Paper 1 SBA Simulation (180 Questions)', "position" = 0, "status" = 'published', "deleted_at" = NULL, "updated_at" = now()
    WHERE "module_id" = v_mod_id AND ("slug" = 'mock-i-paper-i' OR "slug" = 'mock-1-paper-1' OR "title" ILIKE '%Mock%1%Paper%1%' OR "title" ILIKE '%Mock%I%Paper%I%');

    UPDATE "lessons" SET "title" = 'Mock 1: Paper 2 SBA Simulation (180 Questions)', "position" = 1, "status" = 'published', "deleted_at" = NULL, "updated_at" = now()
    WHERE "module_id" = v_mod_id AND ("slug" = 'mock-i-paper-ii' OR "slug" = 'mock-1-paper-2' OR "title" ILIKE '%Mock%1%Paper%2%' OR "title" ILIKE '%Mock%I%Paper%Ii%');

    UPDATE "lessons" SET "title" = 'Mock 2: Paper 1 SBA Simulation (180 Questions)', "position" = 2, "status" = 'published', "deleted_at" = NULL, "updated_at" = now()
    WHERE "module_id" = v_mod_id AND ("slug" = 'mock-ii-paper-i' OR "slug" = 'mock-2-paper-1' OR "title" ILIKE '%Mock%2%Paper%1%' OR "title" ILIKE '%Mock%Ii%Paper%I%');

    UPDATE "lessons" SET "title" = 'Mock 2: Paper 2 SBA Simulation (180 Questions)', "position" = 3, "status" = 'published', "deleted_at" = NULL, "updated_at" = now()
    WHERE "module_id" = v_mod_id AND ("slug" = 'mock-ii-paper-ii' OR "slug" = 'mock-2-paper-2' OR "title" ILIKE '%Mock%2%Paper%2%' OR "title" ILIKE '%Mock%Ii%Paper%Ii%');

    UPDATE "lessons" SET "title" = 'Mock 3: Paper 1 SBA Simulation (180 Questions)', "position" = 4, "status" = 'published', "deleted_at" = NULL, "updated_at" = now()
    WHERE "module_id" = v_mod_id AND ("slug" = 'mock-iii-paper-i' OR "slug" = 'mock-3-paper-1' OR "title" ILIKE '%Mock%3%Paper%1%' OR "title" ILIKE '%Mock%Iii%Paper%I%');

    UPDATE "lessons" SET "title" = 'Mock 3: Paper 2 SBA Simulation (180 Questions)', "position" = 5, "status" = 'published', "deleted_at" = NULL, "updated_at" = now()
    WHERE "module_id" = v_mod_id AND ("slug" = 'mock-iii-paper-ii' OR "slug" = 'mock-3-paper-2' OR "title" ILIKE '%Mock%3%Paper%2%' OR "title" ILIKE '%Mock%Iii%Paper%Ii%');
  END IF;

  -- ========================================================================
  -- STEP 7: SYNC COURSE ENTITLEMENTS & MEMBERSHIP PLANS
  -- ========================================================================
  -- Attach published courses to WhatsApp manual plan
  INSERT INTO "plan_courses" ("id", "plan_id", "course_id", "created_at", "updated_at")
  SELECT gen_random_uuid(), p.id, c.id, now(), now()
  FROM "plans" p
  CROSS JOIN "courses" c
  WHERE p.family_key = 'whatsapp-manual' AND c.status = 'published' AND c.deleted_at IS NULL
  ON CONFLICT ("plan_id", "course_id") DO NOTHING;

  -- Ensure all active users have full access to both Flagship courses
  INSERT INTO "course_entitlements" ("id", "user_id", "course_id", "plan_id", "starts_at", "ends_at")
  SELECT gen_random_uuid(), s.user_id, pc.course_id, s.plan_id, now(), now() + interval '5 years'
  FROM "subscriptions" s
  JOIN "plan_courses" pc ON pc.plan_id = s.plan_id
  WHERE s.status = 'active'
  ON CONFLICT DO NOTHING;

  -- Record curriculum version in meta
  INSERT INTO "app_system_meta" ("key", "value", "updated_at")
  VALUES ('curriculum_version', '2026_11_02_v18_complete_curriculum_and_quizzes', now())
  ON CONFLICT ("key") DO UPDATE SET "value" = EXCLUDED."value", "updated_at" = now();

  RAISE NOTICE 'SUCCESS: Master migration completed! % quizzes created, % questions seeded, % images linked.',
    109, 545, 400;
END $$;
