-- ==========================================================================
-- SEED: Complete SBA Curriculum - All Topics from 'topic sba compressed'
-- Maps ALL 181 PDFs to correct modules in mrcem-sba course
-- Specialties: Cardio(21), Gastro(21), Trauma(13), Nephro(8),
--              Ophthalma(9), Pulmo(13), Resus(11), Urology(11), Vascular(3)
-- High-Yield: MOKA 1-65 + Expert Mocks (last reading folder)
-- ==========================================================================
DO $$
DECLARE
  v_course_id uuid;
  v_module_id uuid;
  v_lesson_id uuid;
BEGIN
  SELECT id INTO v_course_id FROM "courses" WHERE "slug" = 'mrcem-sba' LIMIT 1;
  IF v_course_id IS NULL THEN
    RAISE EXCEPTION 'mrcem-sba course not found.';
  END IF;



  -- =========================================================================
  -- MODULE: Cardiovascular Emergencies
  -- =========================================================================
  SELECT id INTO v_module_id FROM "modules"
  WHERE "course_id" = v_course_id
    AND "title" = 'Cardiovascular Emergencies'
    AND "deleted_at" IS NULL LIMIT 1;

  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id","course_id","title","position","created_at","updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Cardiovascular Emergencies', 10, now(), now())
    RETURNING "id" INTO v_module_id;
  END IF;


  -- Topic: Aortic Aneurysm
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-aortic-aneurysm'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-aortic-aneurysm', 'Aortic Aneurysm', 'quiz',
      $CSBA0001$# Aortic Aneurysm

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Aortic Aneurysm

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Aortic Aneurysm**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0001$,
      false, 0, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Aortic Aneurysm',
      "type"       = 'quiz',
      "body"       = $CSBA0001$# Aortic Aneurysm

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Aortic Aneurysm

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Aortic Aneurysm**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0001$,
      "position"   = 0,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Aortic Dissection
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-aortic-dissection'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-aortic-dissection', 'Aortic Dissection', 'quiz',
      $CSBA0002$# Aortic Dissection

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Aortic Dissection

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Aortic Dissection**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0002$,
      false, 10, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Aortic Dissection',
      "type"       = 'quiz',
      "body"       = $CSBA0002$# Aortic Dissection

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Aortic Dissection

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Aortic Dissection**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0002$,
      "position"   = 10,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Atrial Fibrillation & Flutter
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-atrial-fibrillation-flutter'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-atrial-fibrillation-flutter', 'Atrial Fibrillation & Flutter', 'quiz',
      $CSBA0003$# Atrial Fibrillation & Flutter

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Atrial Fibrillation & Flutter

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Atrial Fibrillation & Flutter**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0003$,
      false, 20, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Atrial Fibrillation & Flutter',
      "type"       = 'quiz',
      "body"       = $CSBA0003$# Atrial Fibrillation & Flutter

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Atrial Fibrillation & Flutter

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Atrial Fibrillation & Flutter**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0003$,
      "position"   = 20,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: ECG Axis Interpretation
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-ecg-axis-interpretation'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-ecg-axis-interpretation', 'ECG Axis Interpretation', 'quiz',
      $CSBA0004$# ECG Axis Interpretation

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: ECG Axis Interpretation

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **ECG Axis Interpretation**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0004$,
      false, 30, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'ECG Axis Interpretation',
      "type"       = 'quiz',
      "body"       = $CSBA0004$# ECG Axis Interpretation

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: ECG Axis Interpretation

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **ECG Axis Interpretation**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0004$,
      "position"   = 30,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Bifascicular & Trifascicular Blocks
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-bifascicular-trifascicular-blocks'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-bifascicular-trifascicular-blocks', 'Bifascicular & Trifascicular Blocks', 'quiz',
      $CSBA0005$# Bifascicular & Trifascicular Blocks

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Bifascicular & Trifascicular Blocks

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Bifascicular & Trifascicular Blocks**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0005$,
      false, 40, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Bifascicular & Trifascicular Blocks',
      "type"       = 'quiz',
      "body"       = $CSBA0005$# Bifascicular & Trifascicular Blocks

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Bifascicular & Trifascicular Blocks

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Bifascicular & Trifascicular Blocks**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0005$,
      "position"   = 40,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Emergency Bradycardia Management
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-emergency-bradycardia-management'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-emergency-bradycardia-management', 'Emergency Bradycardia Management', 'quiz',
      $CSBA0006$# Emergency Bradycardia Management

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Emergency Bradycardia Management

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Emergency Bradycardia Management**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0006$,
      false, 50, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Emergency Bradycardia Management',
      "type"       = 'quiz',
      "body"       = $CSBA0006$# Emergency Bradycardia Management

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Emergency Bradycardia Management

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Emergency Bradycardia Management**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0006$,
      "position"   = 50,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Cardiogenic Pulmonary Oedema
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-cardiogenic-pulmonary-oedema'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-cardiogenic-pulmonary-oedema', 'Cardiogenic Pulmonary Oedema', 'quiz',
      $CSBA0007$# Cardiogenic Pulmonary Oedema

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Cardiogenic Pulmonary Oedema

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Cardiogenic Pulmonary Oedema**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0007$,
      false, 60, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Cardiogenic Pulmonary Oedema',
      "type"       = 'quiz',
      "body"       = $CSBA0007$# Cardiogenic Pulmonary Oedema

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Cardiogenic Pulmonary Oedema

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Cardiogenic Pulmonary Oedema**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0007$,
      "position"   = 60,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Congenital Heart Disease in the ED
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-congenital-heart-disease-in-the-ed'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-congenital-heart-disease-in-the-ed', 'Congenital Heart Disease in the ED', 'quiz',
      $CSBA0008$# Congenital Heart Disease in the ED

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Congenital Heart Disease in the ED

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Congenital Heart Disease in the ED**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0008$,
      false, 70, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Congenital Heart Disease in the ED',
      "type"       = 'quiz',
      "body"       = $CSBA0008$# Congenital Heart Disease in the ED

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Congenital Heart Disease in the ED

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Congenital Heart Disease in the ED**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0008$,
      "position"   = 70,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Infective Endocarditis
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-infective-endocarditis'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-infective-endocarditis', 'Infective Endocarditis', 'quiz',
      $CSBA0009$# Infective Endocarditis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Infective Endocarditis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Infective Endocarditis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0009$,
      false, 80, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Infective Endocarditis',
      "type"       = 'quiz',
      "body"       = $CSBA0009$# Infective Endocarditis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Infective Endocarditis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Infective Endocarditis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0009$,
      "position"   = 80,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Hypertensive Emergencies
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-hypertensive-emergencies'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-hypertensive-emergencies', 'Hypertensive Emergencies', 'quiz',
      $CSBA0010$# Hypertensive Emergencies

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Hypertensive Emergencies

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Hypertensive Emergencies**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0010$,
      false, 90, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Hypertensive Emergencies',
      "type"       = 'quiz',
      "body"       = $CSBA0010$# Hypertensive Emergencies

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Hypertensive Emergencies

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Hypertensive Emergencies**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0010$,
      "position"   = 90,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Hypertension in Pregnancy & Preeclampsia
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-hypertension-in-pregnancy-preeclampsia'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-hypertension-in-pregnancy-preeclampsia', 'Hypertension in Pregnancy & Preeclampsia', 'quiz',
      $CSBA0011$# Hypertension in Pregnancy & Preeclampsia

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Hypertension in Pregnancy & Preeclampsia

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Hypertension in Pregnancy & Preeclampsia**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0011$,
      false, 100, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Hypertension in Pregnancy & Preeclampsia',
      "type"       = 'quiz',
      "body"       = $CSBA0011$# Hypertension in Pregnancy & Preeclampsia

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Hypertension in Pregnancy & Preeclampsia

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Hypertension in Pregnancy & Preeclampsia**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0011$,
      "position"   = 100,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Bundle Branch Blocks (LBBB & RBBB)
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-bundle-branch-blocks-lbbb-rbbb'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-bundle-branch-blocks-lbbb-rbbb', 'Bundle Branch Blocks (LBBB & RBBB)', 'quiz',
      $CSBA0012$# Bundle Branch Blocks (LBBB & RBBB)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Bundle Branch Blocks (LBBB & RBBB)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Bundle Branch Blocks (LBBB & RBBB)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0012$,
      false, 110, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Bundle Branch Blocks (LBBB & RBBB)',
      "type"       = 'quiz',
      "body"       = $CSBA0012$# Bundle Branch Blocks (LBBB & RBBB)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Bundle Branch Blocks (LBBB & RBBB)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Bundle Branch Blocks (LBBB & RBBB)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0012$,
      "position"   = 110,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Left Anterior vs Posterior Fascicular Block
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-left-anterior-vs-posterior-fascicular-block'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-left-anterior-vs-posterior-fascicular-block', 'Left Anterior vs Posterior Fascicular Block', 'quiz',
      $CSBA0013$# Left Anterior vs Posterior Fascicular Block

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Left Anterior vs Posterior Fascicular Block

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Left Anterior vs Posterior Fascicular Block**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0013$,
      false, 120, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Left Anterior vs Posterior Fascicular Block',
      "type"       = 'quiz',
      "body"       = $CSBA0013$# Left Anterior vs Posterior Fascicular Block

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Left Anterior vs Posterior Fascicular Block

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Left Anterior vs Posterior Fascicular Block**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0013$,
      "position"   = 120,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Long QT Syndrome & Torsades
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-long-qt-syndrome-torsades'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-long-qt-syndrome-torsades', 'Long QT Syndrome & Torsades', 'quiz',
      $CSBA0014$# Long QT Syndrome & Torsades

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Long QT Syndrome & Torsades

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Long QT Syndrome & Torsades**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0014$,
      false, 130, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Long QT Syndrome & Torsades',
      "type"       = 'quiz',
      "body"       = $CSBA0014$# Long QT Syndrome & Torsades

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Long QT Syndrome & Torsades

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Long QT Syndrome & Torsades**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0014$,
      "position"   = 130,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Acute Myocarditis
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-acute-myocarditis'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-acute-myocarditis', 'Acute Myocarditis', 'quiz',
      $CSBA0015$# Acute Myocarditis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Acute Myocarditis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Acute Myocarditis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0015$,
      false, 140, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Acute Myocarditis',
      "type"       = 'quiz',
      "body"       = $CSBA0015$# Acute Myocarditis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Acute Myocarditis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Acute Myocarditis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0015$,
      "position"   = 140,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Non-Invasive Ventilation (NIV) Guidelines
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-non-invasive-ventilation-niv-guidelines'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-non-invasive-ventilation-niv-guidelines', 'Non-Invasive Ventilation (NIV) Guidelines', 'quiz',
      $CSBA0016$# Non-Invasive Ventilation (NIV) Guidelines

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Non-Invasive Ventilation (NIV) Guidelines

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Non-Invasive Ventilation (NIV) Guidelines**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0016$,
      false, 150, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Non-Invasive Ventilation (NIV) Guidelines',
      "type"       = 'quiz',
      "body"       = $CSBA0016$# Non-Invasive Ventilation (NIV) Guidelines

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Non-Invasive Ventilation (NIV) Guidelines

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Non-Invasive Ventilation (NIV) Guidelines**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0016$,
      "position"   = 150,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Acute Pericarditis & Tamponade
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-acute-pericarditis-tamponade'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-acute-pericarditis-tamponade', 'Acute Pericarditis & Tamponade', 'quiz',
      $CSBA0017$# Acute Pericarditis & Tamponade

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Acute Pericarditis & Tamponade

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Acute Pericarditis & Tamponade**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0017$,
      false, 160, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Acute Pericarditis & Tamponade',
      "type"       = 'quiz',
      "body"       = $CSBA0017$# Acute Pericarditis & Tamponade

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Acute Pericarditis & Tamponade

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Acute Pericarditis & Tamponade**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0017$,
      "position"   = 160,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Tachyarrhythmias Management
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-tachyarrhythmias-management'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-tachyarrhythmias-management', 'Tachyarrhythmias Management', 'quiz',
      $CSBA0018$# Tachyarrhythmias Management

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Tachyarrhythmias Management

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Tachyarrhythmias Management**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0018$,
      false, 170, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Tachyarrhythmias Management',
      "type"       = 'quiz',
      "body"       = $CSBA0018$# Tachyarrhythmias Management

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Tachyarrhythmias Management

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Tachyarrhythmias Management**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0018$,
      "position"   = 170,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Ventricular Tachycardia (VT)
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-ventricular-tachycardia-vt'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-ventricular-tachycardia-vt', 'Ventricular Tachycardia (VT)', 'quiz',
      $CSBA0019$# Ventricular Tachycardia (VT)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Ventricular Tachycardia (VT)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Ventricular Tachycardia (VT)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0019$,
      false, 180, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Ventricular Tachycardia (VT)',
      "type"       = 'quiz',
      "body"       = $CSBA0019$# Ventricular Tachycardia (VT)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Ventricular Tachycardia (VT)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Ventricular Tachycardia (VT)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0019$,
      "position"   = 180,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Valvular Heart Disease in the ED
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-valvular-heart-disease-in-the-ed'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-valvular-heart-disease-in-the-ed', 'Valvular Heart Disease in the ED', 'quiz',
      $CSBA0020$# Valvular Heart Disease in the ED

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Valvular Heart Disease in the ED

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Valvular Heart Disease in the ED**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0020$,
      false, 190, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Valvular Heart Disease in the ED',
      "type"       = 'quiz',
      "body"       = $CSBA0020$# Valvular Heart Disease in the ED

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Valvular Heart Disease in the ED

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Valvular Heart Disease in the ED**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0020$,
      "position"   = 190,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Acute Coronary Syndromes (ACS)
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-acute-coronary-syndromes-acs'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-acute-coronary-syndromes-acs', 'Acute Coronary Syndromes (ACS)', 'quiz',
      $CSBA0021$# Acute Coronary Syndromes (ACS)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Acute Coronary Syndromes (ACS)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Acute Coronary Syndromes (ACS)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0021$,
      false, 200, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Acute Coronary Syndromes (ACS)',
      "type"       = 'quiz',
      "body"       = $CSBA0021$# Acute Coronary Syndromes (ACS)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Acute Coronary Syndromes (ACS)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Acute Coronary Syndromes (ACS)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0021$,
      "position"   = 200,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- =========================================================================
  -- MODULE: Gastroenterology Emergencies
  -- =========================================================================
  SELECT id INTO v_module_id FROM "modules"
  WHERE "course_id" = v_course_id
    AND "title" = 'Gastroenterology Emergencies'
    AND "deleted_at" IS NULL LIMIT 1;

  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id","course_id","title","position","created_at","updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Gastroenterology Emergencies', 10, now(), now())
    RETURNING "id" INTO v_module_id;
  END IF;


  -- Topic: Mallory-Weiss Tear
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-mallory-weiss-tear'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-mallory-weiss-tear', 'Mallory-Weiss Tear', 'quiz',
      $CSBA0022$# Mallory-Weiss Tear

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Mallory-Weiss Tear

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Mallory-Weiss Tear**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0022$,
      false, 0, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Mallory-Weiss Tear',
      "type"       = 'quiz',
      "body"       = $CSBA0022$# Mallory-Weiss Tear

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Mallory-Weiss Tear

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Mallory-Weiss Tear**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0022$,
      "position"   = 0,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Peptic Ulcer Disease
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-peptic-ulcer-disease'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-peptic-ulcer-disease', 'Peptic Ulcer Disease', 'quiz',
      $CSBA0023$# Peptic Ulcer Disease

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Peptic Ulcer Disease

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Peptic Ulcer Disease**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0023$,
      false, 10, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Peptic Ulcer Disease',
      "type"       = 'quiz',
      "body"       = $CSBA0023$# Peptic Ulcer Disease

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Peptic Ulcer Disease

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Peptic Ulcer Disease**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0023$,
      "position"   = 10,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Pyloric Stenosis
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-pyloric-stenosis'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-pyloric-stenosis', 'Pyloric Stenosis', 'quiz',
      $CSBA0024$# Pyloric Stenosis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Pyloric Stenosis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Pyloric Stenosis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0024$,
      false, 20, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Pyloric Stenosis',
      "type"       = 'quiz',
      "body"       = $CSBA0024$# Pyloric Stenosis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Pyloric Stenosis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Pyloric Stenosis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0024$,
      "position"   = 20,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Upper GI Bleeding
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-upper-gi-bleeding'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-upper-gi-bleeding', 'Upper GI Bleeding', 'quiz',
      $CSBA0025$# Upper GI Bleeding

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Upper GI Bleeding

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Upper GI Bleeding**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0025$,
      false, 30, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Upper GI Bleeding',
      "type"       = 'quiz',
      "body"       = $CSBA0025$# Upper GI Bleeding

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Upper GI Bleeding

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Upper GI Bleeding**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0025$,
      "position"   = 30,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Lower GI Bleeding
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-lower-gi-bleeding'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-lower-gi-bleeding', 'Lower GI Bleeding', 'quiz',
      $CSBA0026$# Lower GI Bleeding

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Lower GI Bleeding

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Lower GI Bleeding**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0026$,
      false, 40, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Lower GI Bleeding',
      "type"       = 'quiz',
      "body"       = $CSBA0026$# Lower GI Bleeding

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Lower GI Bleeding

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Lower GI Bleeding**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0026$,
      "position"   = 40,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Anal Pain & Rectal Bleeding
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-anal-pain-rectal-bleeding'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-anal-pain-rectal-bleeding', 'Anal Pain & Rectal Bleeding', 'quiz',
      $CSBA0027$# Anal Pain & Rectal Bleeding

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Anal Pain & Rectal Bleeding

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Anal Pain & Rectal Bleeding**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0027$,
      false, 50, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Anal Pain & Rectal Bleeding',
      "type"       = 'quiz',
      "body"       = $CSBA0027$# Anal Pain & Rectal Bleeding

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Anal Pain & Rectal Bleeding

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Anal Pain & Rectal Bleeding**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0027$,
      "position"   = 50,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Diverticular Disease
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-diverticular-disease'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-diverticular-disease', 'Diverticular Disease', 'quiz',
      $CSBA0028$# Diverticular Disease

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Diverticular Disease

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Diverticular Disease**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0028$,
      false, 60, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Diverticular Disease',
      "type"       = 'quiz',
      "body"       = $CSBA0028$# Diverticular Disease

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Diverticular Disease

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Diverticular Disease**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0028$,
      "position"   = 60,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Acute Appendicitis
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-acute-appendicitis'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-acute-appendicitis', 'Acute Appendicitis', 'quiz',
      $CSBA0029$# Acute Appendicitis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Acute Appendicitis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Acute Appendicitis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0029$,
      false, 70, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Acute Appendicitis',
      "type"       = 'quiz',
      "body"       = $CSBA0029$# Acute Appendicitis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Acute Appendicitis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Acute Appendicitis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0029$,
      "position"   = 70,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Pancreatitis & Loin Pain
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-pancreatitis-loin-pain'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-pancreatitis-loin-pain', 'Pancreatitis & Loin Pain', 'quiz',
      $CSBA0030$# Pancreatitis & Loin Pain

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Pancreatitis & Loin Pain

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Pancreatitis & Loin Pain**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0030$,
      false, 80, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Pancreatitis & Loin Pain',
      "type"       = 'quiz',
      "body"       = $CSBA0030$# Pancreatitis & Loin Pain

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Pancreatitis & Loin Pain

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Pancreatitis & Loin Pain**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0030$,
      "position"   = 80,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Gastroenteritis
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-gastroenteritis'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-gastroenteritis', 'Gastroenteritis', 'quiz',
      $CSBA0031$# Gastroenteritis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Gastroenteritis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Gastroenteritis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0031$,
      false, 90, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Gastroenteritis',
      "type"       = 'quiz',
      "body"       = $CSBA0031$# Gastroenteritis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Gastroenteritis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Gastroenteritis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0031$,
      "position"   = 90,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Inflammatory Bowel Disease (IBD)
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-inflammatory-bowel-disease-ibd'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-inflammatory-bowel-disease-ibd', 'Inflammatory Bowel Disease (IBD)', 'quiz',
      $CSBA0032$# Inflammatory Bowel Disease (IBD)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Inflammatory Bowel Disease (IBD)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Inflammatory Bowel Disease (IBD)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0032$,
      false, 100, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Inflammatory Bowel Disease (IBD)',
      "type"       = 'quiz',
      "body"       = $CSBA0032$# Inflammatory Bowel Disease (IBD)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Inflammatory Bowel Disease (IBD)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Inflammatory Bowel Disease (IBD)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0032$,
      "position"   = 100,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Ischaemic Bowel
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-ischaemic-bowel'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-ischaemic-bowel', 'Ischaemic Bowel', 'quiz',
      $CSBA0033$# Ischaemic Bowel

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Ischaemic Bowel

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Ischaemic Bowel**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0033$,
      false, 110, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Ischaemic Bowel',
      "type"       = 'quiz',
      "body"       = $CSBA0033$# Ischaemic Bowel

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Ischaemic Bowel

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Ischaemic Bowel**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0033$,
      "position"   = 110,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Gallstones & Biliary Emergencies
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-gallstones-biliary-emergencies'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-gallstones-biliary-emergencies', 'Gallstones & Biliary Emergencies', 'quiz',
      $CSBA0034$# Gallstones & Biliary Emergencies

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Gallstones & Biliary Emergencies

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Gallstones & Biliary Emergencies**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0034$,
      false, 120, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Gallstones & Biliary Emergencies',
      "type"       = 'quiz',
      "body"       = $CSBA0034$# Gallstones & Biliary Emergencies

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Gallstones & Biliary Emergencies

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Gallstones & Biliary Emergencies**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0034$,
      "position"   = 120,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Jaundice
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-jaundice'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-jaundice', 'Jaundice', 'quiz',
      $CSBA0035$# Jaundice

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Jaundice

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Jaundice**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0035$,
      false, 130, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Jaundice',
      "type"       = 'quiz',
      "body"       = $CSBA0035$# Jaundice

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Jaundice

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Jaundice**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0035$,
      "position"   = 130,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Bowel Obstruction
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-bowel-obstruction'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-bowel-obstruction', 'Bowel Obstruction', 'quiz',
      $CSBA0036$# Bowel Obstruction

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Bowel Obstruction

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Bowel Obstruction**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0036$,
      false, 140, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Bowel Obstruction',
      "type"       = 'quiz',
      "body"       = $CSBA0036$# Bowel Obstruction

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Bowel Obstruction

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Bowel Obstruction**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0036$,
      "position"   = 140,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Diarrhoea
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-diarrhoea'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-diarrhoea', 'Diarrhoea', 'quiz',
      $CSBA0037$# Diarrhoea

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Diarrhoea

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Diarrhoea**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0037$,
      false, 150, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Diarrhoea',
      "type"       = 'quiz',
      "body"       = $CSBA0037$# Diarrhoea

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Diarrhoea

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Diarrhoea**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0037$,
      "position"   = 150,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Constipation
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-constipation'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-constipation', 'Constipation', 'quiz',
      $CSBA0038$# Constipation

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Constipation

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Constipation**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0038$,
      false, 160, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Constipation',
      "type"       = 'quiz',
      "body"       = $CSBA0038$# Constipation

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Constipation

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Constipation**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0038$,
      "position"   = 160,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Alcoholic Liver Disease
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-alcoholic-liver-disease'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-alcoholic-liver-disease', 'Alcoholic Liver Disease', 'quiz',
      $CSBA0039$# Alcoholic Liver Disease

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Alcoholic Liver Disease

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Alcoholic Liver Disease**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0039$,
      false, 170, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Alcoholic Liver Disease',
      "type"       = 'quiz',
      "body"       = $CSBA0039$# Alcoholic Liver Disease

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Alcoholic Liver Disease

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Alcoholic Liver Disease**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0039$,
      "position"   = 170,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Cirrhosis & Portal Hypertension
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-cirrhosis-portal-hypertension'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-cirrhosis-portal-hypertension', 'Cirrhosis & Portal Hypertension', 'quiz',
      $CSBA0040$# Cirrhosis & Portal Hypertension

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Cirrhosis & Portal Hypertension

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Cirrhosis & Portal Hypertension**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0040$,
      false, 180, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Cirrhosis & Portal Hypertension',
      "type"       = 'quiz',
      "body"       = $CSBA0040$# Cirrhosis & Portal Hypertension

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Cirrhosis & Portal Hypertension

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Cirrhosis & Portal Hypertension**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0040$,
      "position"   = 180,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Hepatitis
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-hepatitis'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-hepatitis', 'Hepatitis', 'quiz',
      $CSBA0041$# Hepatitis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Hepatitis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Hepatitis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0041$,
      false, 190, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Hepatitis',
      "type"       = 'quiz',
      "body"       = $CSBA0041$# Hepatitis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Hepatitis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Hepatitis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0041$,
      "position"   = 190,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Foreign Body Ingestion
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-foreign-body-ingestion'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-foreign-body-ingestion', 'Foreign Body Ingestion', 'quiz',
      $CSBA0042$# Foreign Body Ingestion

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Foreign Body Ingestion

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Foreign Body Ingestion**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0042$,
      false, 200, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Foreign Body Ingestion',
      "type"       = 'quiz',
      "body"       = $CSBA0042$# Foreign Body Ingestion

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Foreign Body Ingestion

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Foreign Body Ingestion**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0042$,
      "position"   = 200,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- =========================================================================
  -- MODULE: Major Trauma & Injury Management
  -- =========================================================================
  SELECT id INTO v_module_id FROM "modules"
  WHERE "course_id" = v_course_id
    AND "title" = 'Major Trauma & Injury Management'
    AND "deleted_at" IS NULL LIMIT 1;

  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id","course_id","title","position","created_at","updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Major Trauma & Injury Management', 10, now(), now())
    RETURNING "id" INTO v_module_id;
  END IF;


  -- Topic: Head Trauma
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-head-trauma'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-head-trauma', 'Head Trauma', 'quiz',
      $CSBA0043$# Head Trauma

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Head Trauma

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Head Trauma**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0043$,
      false, 0, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Head Trauma',
      "type"       = 'quiz',
      "body"       = $CSBA0043$# Head Trauma

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Head Trauma

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Head Trauma**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0043$,
      "position"   = 0,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Devastating Brain Injury
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-devastating-brain-injury'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-devastating-brain-injury', 'Devastating Brain Injury', 'quiz',
      $CSBA0044$# Devastating Brain Injury

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Devastating Brain Injury

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Devastating Brain Injury**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0044$,
      false, 10, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Devastating Brain Injury',
      "type"       = 'quiz',
      "body"       = $CSBA0044$# Devastating Brain Injury

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Devastating Brain Injury

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Devastating Brain Injury**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0044$,
      "position"   = 10,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Laryngotracheal Injury
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-laryngotracheal-injury'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-laryngotracheal-injury', 'Laryngotracheal Injury', 'quiz',
      $CSBA0045$# Laryngotracheal Injury

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Laryngotracheal Injury

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Laryngotracheal Injury**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0045$,
      false, 20, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Laryngotracheal Injury',
      "type"       = 'quiz',
      "body"       = $CSBA0045$# Laryngotracheal Injury

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Laryngotracheal Injury

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Laryngotracheal Injury**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0045$,
      "position"   = 20,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Spinal Cord Injury
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-spinal-cord-injury'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-spinal-cord-injury', 'Spinal Cord Injury', 'quiz',
      $CSBA0046$# Spinal Cord Injury

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Spinal Cord Injury

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Spinal Cord Injury**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0046$,
      false, 30, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Spinal Cord Injury',
      "type"       = 'quiz',
      "body"       = $CSBA0046$# Spinal Cord Injury

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Spinal Cord Injury

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Spinal Cord Injury**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0046$,
      "position"   = 30,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Spinal Injury & Autonomic Dysreflexia
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-spinal-injury-autonomic-dysreflexia'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-spinal-injury-autonomic-dysreflexia', 'Spinal Injury & Autonomic Dysreflexia', 'quiz',
      $CSBA0047$# Spinal Injury & Autonomic Dysreflexia

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Spinal Injury & Autonomic Dysreflexia

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Spinal Injury & Autonomic Dysreflexia**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0047$,
      false, 40, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Spinal Injury & Autonomic Dysreflexia',
      "type"       = 'quiz',
      "body"       = $CSBA0047$# Spinal Injury & Autonomic Dysreflexia

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Spinal Injury & Autonomic Dysreflexia

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Spinal Injury & Autonomic Dysreflexia**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0047$,
      "position"   = 40,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Thoracic Trauma (Life-Threatening)
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-thoracic-trauma-life-threatening'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-thoracic-trauma-life-threatening', 'Thoracic Trauma (Life-Threatening)', 'quiz',
      $CSBA0048$# Thoracic Trauma (Life-Threatening)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Thoracic Trauma (Life-Threatening)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Thoracic Trauma (Life-Threatening)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0048$,
      false, 50, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Thoracic Trauma (Life-Threatening)',
      "type"       = 'quiz',
      "body"       = $CSBA0048$# Thoracic Trauma (Life-Threatening)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Thoracic Trauma (Life-Threatening)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Thoracic Trauma (Life-Threatening)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0048$,
      "position"   = 50,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Spontaneous Pneumothorax
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-spontaneous-pneumothorax'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-spontaneous-pneumothorax', 'Spontaneous Pneumothorax', 'quiz',
      $CSBA0049$# Spontaneous Pneumothorax

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Spontaneous Pneumothorax

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Spontaneous Pneumothorax**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0049$,
      false, 60, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Spontaneous Pneumothorax',
      "type"       = 'quiz',
      "body"       = $CSBA0049$# Spontaneous Pneumothorax

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Spontaneous Pneumothorax

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Spontaneous Pneumothorax**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0049$,
      "position"   = 60,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Thoracic Trauma & Flail Chest
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-thoracic-trauma-flail-chest'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-thoracic-trauma-flail-chest', 'Thoracic Trauma & Flail Chest', 'quiz',
      $CSBA0050$# Thoracic Trauma & Flail Chest

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Thoracic Trauma & Flail Chest

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Thoracic Trauma & Flail Chest**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0050$,
      false, 70, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Thoracic Trauma & Flail Chest',
      "type"       = 'quiz',
      "body"       = $CSBA0050$# Thoracic Trauma & Flail Chest

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Thoracic Trauma & Flail Chest

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Thoracic Trauma & Flail Chest**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0050$,
      "position"   = 70,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Abdominal Trauma
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-abdominal-trauma'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-abdominal-trauma', 'Abdominal Trauma', 'quiz',
      $CSBA0051$# Abdominal Trauma

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Abdominal Trauma

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Abdominal Trauma**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0051$,
      false, 80, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Abdominal Trauma',
      "type"       = 'quiz',
      "body"       = $CSBA0051$# Abdominal Trauma

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Abdominal Trauma

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Abdominal Trauma**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0051$,
      "position"   = 80,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Genitourinary Trauma
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-genitourinary-trauma'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-genitourinary-trauma', 'Genitourinary Trauma', 'quiz',
      $CSBA0052$# Genitourinary Trauma

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Genitourinary Trauma

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Genitourinary Trauma**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0052$,
      false, 90, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Genitourinary Trauma',
      "type"       = 'quiz',
      "body"       = $CSBA0052$# Genitourinary Trauma

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Genitourinary Trauma

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Genitourinary Trauma**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0052$,
      "position"   = 90,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Renal Cancer vs Bladder Cancer
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-renal-cancer-vs-bladder-cancer'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-renal-cancer-vs-bladder-cancer', 'Renal Cancer vs Bladder Cancer', 'quiz',
      $CSBA0053$# Renal Cancer vs Bladder Cancer

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Renal Cancer vs Bladder Cancer

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Renal Cancer vs Bladder Cancer**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0053$,
      false, 100, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Renal Cancer vs Bladder Cancer',
      "type"       = 'quiz',
      "body"       = $CSBA0053$# Renal Cancer vs Bladder Cancer

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Renal Cancer vs Bladder Cancer

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Renal Cancer vs Bladder Cancer**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0053$,
      "position"   = 100,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Maxillofacial Trauma
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-maxillofacial-trauma'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-maxillofacial-trauma', 'Maxillofacial Trauma', 'quiz',
      $CSBA0054$# Maxillofacial Trauma

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Maxillofacial Trauma

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Maxillofacial Trauma**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0054$,
      false, 110, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Maxillofacial Trauma',
      "type"       = 'quiz',
      "body"       = $CSBA0054$# Maxillofacial Trauma

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Maxillofacial Trauma

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Maxillofacial Trauma**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0054$,
      "position"   = 110,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Burn Injury
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-burn-injury'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-burn-injury', 'Burn Injury', 'quiz',
      $CSBA0055$# Burn Injury

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Burn Injury

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Burn Injury**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0055$,
      false, 120, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Burn Injury',
      "type"       = 'quiz',
      "body"       = $CSBA0055$# Burn Injury

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Burn Injury

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Burn Injury**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0055$,
      "position"   = 120,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- =========================================================================
  -- MODULE: Nephrology & Acid-Base Disorders
  -- =========================================================================
  SELECT id INTO v_module_id FROM "modules"
  WHERE "course_id" = v_course_id
    AND "title" = 'Nephrology & Acid-Base Disorders'
    AND "deleted_at" IS NULL LIMIT 1;

  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id","course_id","title","position","created_at","updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Nephrology & Acid-Base Disorders', 10, now(), now())
    RETURNING "id" INTO v_module_id;
  END IF;


  -- Topic: Hyper & Hypokalemia
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-hyper-hypokalemia'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-hyper-hypokalemia', 'Hyper & Hypokalemia', 'quiz',
      $CSBA0056$# Hyper & Hypokalemia

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Hyper & Hypokalemia

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Hyper & Hypokalemia**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0056$,
      false, 0, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Hyper & Hypokalemia',
      "type"       = 'quiz',
      "body"       = $CSBA0056$# Hyper & Hypokalemia

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Hyper & Hypokalemia

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Hyper & Hypokalemia**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0056$,
      "position"   = 0,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Hyperkalaemic Cardiac Arrest
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-hyperkalaemic-cardiac-arrest'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-hyperkalaemic-cardiac-arrest', 'Hyperkalaemic Cardiac Arrest', 'quiz',
      $CSBA0057$# Hyperkalaemic Cardiac Arrest

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Hyperkalaemic Cardiac Arrest

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Hyperkalaemic Cardiac Arrest**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0057$,
      false, 10, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Hyperkalaemic Cardiac Arrest',
      "type"       = 'quiz',
      "body"       = $CSBA0057$# Hyperkalaemic Cardiac Arrest

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Hyperkalaemic Cardiac Arrest

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Hyperkalaemic Cardiac Arrest**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0057$,
      "position"   = 10,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Hypokalemia
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-hypokalemia'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-hypokalemia', 'Hypokalemia', 'quiz',
      $CSBA0058$# Hypokalemia

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Hypokalemia

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Hypokalemia**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0058$,
      false, 20, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Hypokalemia',
      "type"       = 'quiz',
      "body"       = $CSBA0058$# Hypokalemia

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Hypokalemia

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Hypokalemia**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0058$,
      "position"   = 20,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Hypernatremia
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-hypernatremia'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-hypernatremia', 'Hypernatremia', 'quiz',
      $CSBA0059$# Hypernatremia

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Hypernatremia

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Hypernatremia**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0059$,
      false, 30, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Hypernatremia',
      "type"       = 'quiz',
      "body"       = $CSBA0059$# Hypernatremia

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Hypernatremia

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Hypernatremia**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0059$,
      "position"   = 30,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Hyponatremia
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-hyponatremia'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-hyponatremia', 'Hyponatremia', 'quiz',
      $CSBA0060$# Hyponatremia

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Hyponatremia

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Hyponatremia**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0060$,
      false, 40, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Hyponatremia',
      "type"       = 'quiz',
      "body"       = $CSBA0060$# Hyponatremia

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Hyponatremia

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Hyponatremia**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0060$,
      "position"   = 40,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Hypercalcemia
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-hypercalcemia'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-hypercalcemia', 'Hypercalcemia', 'quiz',
      $CSBA0061$# Hypercalcemia

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Hypercalcemia

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Hypercalcemia**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0061$,
      false, 50, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Hypercalcemia',
      "type"       = 'quiz',
      "body"       = $CSBA0061$# Hypercalcemia

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Hypercalcemia

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Hypercalcemia**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0061$,
      "position"   = 50,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Hypocalcemia
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-hypocalcemia'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-hypocalcemia', 'Hypocalcemia', 'quiz',
      $CSBA0062$# Hypocalcemia

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Hypocalcemia

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Hypocalcemia**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0062$,
      false, 60, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Hypocalcemia',
      "type"       = 'quiz',
      "body"       = $CSBA0062$# Hypocalcemia

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Hypocalcemia

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Hypocalcemia**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0062$,
      "position"   = 60,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Acute Kidney Injury (AKI)
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-acute-kidney-injury-aki'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-acute-kidney-injury-aki', 'Acute Kidney Injury (AKI)', 'quiz',
      $CSBA0063$# Acute Kidney Injury (AKI)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Acute Kidney Injury (AKI)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Acute Kidney Injury (AKI)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0063$,
      false, 70, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Acute Kidney Injury (AKI)',
      "type"       = 'quiz',
      "body"       = $CSBA0063$# Acute Kidney Injury (AKI)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Acute Kidney Injury (AKI)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Acute Kidney Injury (AKI)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0063$,
      "position"   = 70,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- =========================================================================
  -- MODULE: Ophthalmology Emergencies
  -- =========================================================================
  SELECT id INTO v_module_id FROM "modules"
  WHERE "course_id" = v_course_id
    AND "title" = 'Ophthalmology Emergencies'
    AND "deleted_at" IS NULL LIMIT 1;

  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id","course_id","title","position","created_at","updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Ophthalmology Emergencies', 10, now(), now())
    RETURNING "id" INTO v_module_id;
  END IF;


  -- Topic: Acute Glaucoma
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-acute-glaucoma'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-acute-glaucoma', 'Acute Glaucoma', 'quiz',
      $CSBA0064$# Acute Glaucoma

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Acute Glaucoma

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Acute Glaucoma**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0064$,
      false, 0, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Acute Glaucoma',
      "type"       = 'quiz',
      "body"       = $CSBA0064$# Acute Glaucoma

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Acute Glaucoma

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Acute Glaucoma**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0064$,
      "position"   = 0,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Orbital & Periorbital Cellulitis
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-orbital-periorbital-cellulitis'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-orbital-periorbital-cellulitis', 'Orbital & Periorbital Cellulitis', 'quiz',
      $CSBA0065$# Orbital & Periorbital Cellulitis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Orbital & Periorbital Cellulitis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Orbital & Periorbital Cellulitis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0065$,
      false, 10, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Orbital & Periorbital Cellulitis',
      "type"       = 'quiz',
      "body"       = $CSBA0065$# Orbital & Periorbital Cellulitis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Orbital & Periorbital Cellulitis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Orbital & Periorbital Cellulitis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0065$,
      "position"   = 10,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Red Eye
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-red-eye'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-red-eye', 'Red Eye', 'quiz',
      $CSBA0066$# Red Eye

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Red Eye

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Red Eye**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0066$,
      false, 20, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Red Eye',
      "type"       = 'quiz',
      "body"       = $CSBA0066$# Red Eye

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Red Eye

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Red Eye**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0066$,
      "position"   = 20,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Sudden Vision Loss
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-sudden-vision-loss'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-sudden-vision-loss', 'Sudden Vision Loss', 'quiz',
      $CSBA0067$# Sudden Vision Loss

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Sudden Vision Loss

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Sudden Vision Loss**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0067$,
      false, 30, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Sudden Vision Loss',
      "type"       = 'quiz',
      "body"       = $CSBA0067$# Sudden Vision Loss

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Sudden Vision Loss

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Sudden Vision Loss**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0067$,
      "position"   = 30,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Painful Eye
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-painful-eye'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-painful-eye', 'Painful Eye', 'quiz',
      $CSBA0068$# Painful Eye

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Painful Eye

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Painful Eye**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0068$,
      false, 40, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Painful Eye',
      "type"       = 'quiz',
      "body"       = $CSBA0068$# Painful Eye

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Painful Eye

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Painful Eye**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0068$,
      "position"   = 40,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Eye Trauma
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-eye-trauma'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-eye-trauma', 'Eye Trauma', 'quiz',
      $CSBA0069$# Eye Trauma

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Eye Trauma

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Eye Trauma**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0069$,
      false, 50, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Eye Trauma',
      "type"       = 'quiz',
      "body"       = $CSBA0069$# Eye Trauma

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Eye Trauma

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Eye Trauma**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0069$,
      "position"   = 50,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Temporal Arteritis (GCA)
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-temporal-arteritis-gca'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-temporal-arteritis-gca', 'Temporal Arteritis (GCA)', 'quiz',
      $CSBA0070$# Temporal Arteritis (GCA)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Temporal Arteritis (GCA)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Temporal Arteritis (GCA)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0070$,
      false, 60, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Temporal Arteritis (GCA)',
      "type"       = 'quiz',
      "body"       = $CSBA0070$# Temporal Arteritis (GCA)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Temporal Arteritis (GCA)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Temporal Arteritis (GCA)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0070$,
      "position"   = 60,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Inflammatory Eye Disease
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-inflammatory-eye-disease'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-inflammatory-eye-disease', 'Inflammatory Eye Disease', 'quiz',
      $CSBA0071$# Inflammatory Eye Disease

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Inflammatory Eye Disease

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Inflammatory Eye Disease**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0071$,
      false, 70, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Inflammatory Eye Disease',
      "type"       = 'quiz',
      "body"       = $CSBA0071$# Inflammatory Eye Disease

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Inflammatory Eye Disease

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Inflammatory Eye Disease**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0071$,
      "position"   = 70,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Ophthalmia Neonatorum
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-ophthalmia-neonatorum'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-ophthalmia-neonatorum', 'Ophthalmia Neonatorum', 'quiz',
      $CSBA0072$# Ophthalmia Neonatorum

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Ophthalmia Neonatorum

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Ophthalmia Neonatorum**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0072$,
      false, 80, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Ophthalmia Neonatorum',
      "type"       = 'quiz',
      "body"       = $CSBA0072$# Ophthalmia Neonatorum

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Ophthalmia Neonatorum

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Ophthalmia Neonatorum**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0072$,
      "position"   = 80,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- =========================================================================
  -- MODULE: Pulmonology & Respiratory Emergencies
  -- =========================================================================
  SELECT id INTO v_module_id FROM "modules"
  WHERE "course_id" = v_course_id
    AND "title" = 'Pulmonology & Respiratory Emergencies'
    AND "deleted_at" IS NULL LIMIT 1;

  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id","course_id","title","position","created_at","updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Pulmonology & Respiratory Emergencies', 10, now(), now())
    RETURNING "id" INTO v_module_id;
  END IF;


  -- Topic: Pulmonology Basics
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-pulmonology-basics'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-pulmonology-basics', 'Pulmonology Basics', 'quiz',
      $CSBA0073$# Pulmonology Basics

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Pulmonology Basics

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Pulmonology Basics**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0073$,
      false, 0, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Pulmonology Basics',
      "type"       = 'quiz',
      "body"       = $CSBA0073$# Pulmonology Basics

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Pulmonology Basics

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Pulmonology Basics**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0073$,
      "position"   = 0,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: COPD & Acute Exacerbation
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-copd-acute-exacerbation'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-copd-acute-exacerbation', 'COPD & Acute Exacerbation', 'quiz',
      $CSBA0074$# COPD & Acute Exacerbation

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: COPD & Acute Exacerbation

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **COPD & Acute Exacerbation**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0074$,
      false, 10, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'COPD & Acute Exacerbation',
      "type"       = 'quiz',
      "body"       = $CSBA0074$# COPD & Acute Exacerbation

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: COPD & Acute Exacerbation

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **COPD & Acute Exacerbation**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0074$,
      "position"   = 10,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Asthma
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-asthma'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-asthma', 'Asthma', 'quiz',
      $CSBA0075$# Asthma

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Asthma

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Asthma**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0075$,
      false, 20, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Asthma',
      "type"       = 'quiz',
      "body"       = $CSBA0075$# Asthma

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Asthma

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Asthma**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0075$,
      "position"   = 20,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Asthma in Children
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-asthma-in-children'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-asthma-in-children', 'Asthma in Children', 'quiz',
      $CSBA0076$# Asthma in Children

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Asthma in Children

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Asthma in Children**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0076$,
      false, 30, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Asthma in Children',
      "type"       = 'quiz',
      "body"       = $CSBA0076$# Asthma in Children

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Asthma in Children

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Asthma in Children**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0076$,
      "position"   = 30,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Acute Breathlessness
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-acute-breathlessness'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-acute-breathlessness', 'Acute Breathlessness', 'quiz',
      $CSBA0077$# Acute Breathlessness

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Acute Breathlessness

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Acute Breathlessness**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0077$,
      false, 40, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Acute Breathlessness',
      "type"       = 'quiz',
      "body"       = $CSBA0077$# Acute Breathlessness

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Acute Breathlessness

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Acute Breathlessness**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0077$,
      "position"   = 40,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Haemoptysis
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-haemoptysis'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-haemoptysis', 'Haemoptysis', 'quiz',
      $CSBA0078$# Haemoptysis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Haemoptysis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Haemoptysis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0078$,
      false, 50, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Haemoptysis',
      "type"       = 'quiz',
      "body"       = $CSBA0078$# Haemoptysis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Haemoptysis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Haemoptysis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0078$,
      "position"   = 50,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Croup
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-croup'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-croup', 'Croup', 'quiz',
      $CSBA0079$# Croup

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Croup

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Croup**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0079$,
      false, 60, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Croup',
      "type"       = 'quiz',
      "body"       = $CSBA0079$# Croup

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Croup

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Croup**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0079$,
      "position"   = 60,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Whooping Cough (Pertussis)
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-whooping-cough-pertussis'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-whooping-cough-pertussis', 'Whooping Cough (Pertussis)', 'quiz',
      $CSBA0080$# Whooping Cough (Pertussis)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Whooping Cough (Pertussis)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Whooping Cough (Pertussis)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0080$,
      false, 70, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Whooping Cough (Pertussis)',
      "type"       = 'quiz',
      "body"       = $CSBA0080$# Whooping Cough (Pertussis)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Whooping Cough (Pertussis)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Whooping Cough (Pertussis)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0080$,
      "position"   = 70,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Bronchiolitis
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-bronchiolitis'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-bronchiolitis', 'Bronchiolitis', 'quiz',
      $CSBA0081$# Bronchiolitis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Bronchiolitis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Bronchiolitis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0081$,
      false, 80, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Bronchiolitis',
      "type"       = 'quiz',
      "body"       = $CSBA0081$# Bronchiolitis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Bronchiolitis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Bronchiolitis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0081$,
      "position"   = 80,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Community-Acquired Pneumonia (CAP)
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-community-acquired-pneumonia-cap'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-community-acquired-pneumonia-cap', 'Community-Acquired Pneumonia (CAP)', 'quiz',
      $CSBA0082$# Community-Acquired Pneumonia (CAP)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Community-Acquired Pneumonia (CAP)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Community-Acquired Pneumonia (CAP)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0082$,
      false, 90, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Community-Acquired Pneumonia (CAP)',
      "type"       = 'quiz',
      "body"       = $CSBA0082$# Community-Acquired Pneumonia (CAP)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Community-Acquired Pneumonia (CAP)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Community-Acquired Pneumonia (CAP)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0082$,
      "position"   = 90,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: CAP in Children
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-cap-in-children'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-cap-in-children', 'CAP in Children', 'quiz',
      $CSBA0083$# CAP in Children

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: CAP in Children

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **CAP in Children**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0083$,
      false, 100, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'CAP in Children',
      "type"       = 'quiz',
      "body"       = $CSBA0083$# CAP in Children

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: CAP in Children

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **CAP in Children**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0083$,
      "position"   = 100,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Foreign Body in Airway
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-foreign-body-in-airway'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-foreign-body-in-airway', 'Foreign Body in Airway', 'quiz',
      $CSBA0084$# Foreign Body in Airway

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Foreign Body in Airway

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Foreign Body in Airway**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0084$,
      false, 110, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Foreign Body in Airway',
      "type"       = 'quiz',
      "body"       = $CSBA0084$# Foreign Body in Airway

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Foreign Body in Airway

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Foreign Body in Airway**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0084$,
      "position"   = 110,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Pneumonitis
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-pneumonitis'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-pneumonitis', 'Pneumonitis', 'quiz',
      $CSBA0085$# Pneumonitis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Pneumonitis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Pneumonitis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0085$,
      false, 120, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Pneumonitis',
      "type"       = 'quiz',
      "body"       = $CSBA0085$# Pneumonitis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Pneumonitis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Pneumonitis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0085$,
      "position"   = 120,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- =========================================================================
  -- MODULE: Resuscitation & Critical Care
  -- =========================================================================
  SELECT id INTO v_module_id FROM "modules"
  WHERE "course_id" = v_course_id
    AND "title" = 'Resuscitation & Critical Care'
    AND "deleted_at" IS NULL LIMIT 1;

  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id","course_id","title","position","created_at","updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Resuscitation & Critical Care', 10, now(), now())
    RETURNING "id" INTO v_module_id;
  END IF;


  -- Topic: BRUE (Brief Resolved Unexplained Event)
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-brue-brief-resolved-unexplained-event'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-brue-brief-resolved-unexplained-event', 'BRUE (Brief Resolved Unexplained Event)', 'quiz',
      $CSBA0086$# BRUE (Brief Resolved Unexplained Event)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: BRUE (Brief Resolved Unexplained Event)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **BRUE (Brief Resolved Unexplained Event)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0086$,
      false, 0, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'BRUE (Brief Resolved Unexplained Event)',
      "type"       = 'quiz',
      "body"       = $CSBA0086$# BRUE (Brief Resolved Unexplained Event)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: BRUE (Brief Resolved Unexplained Event)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **BRUE (Brief Resolved Unexplained Event)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0086$,
      "position"   = 0,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Choking (Adult & Paediatric)
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-choking-adult-paediatric'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-choking-adult-paediatric', 'Choking (Adult & Paediatric)', 'quiz',
      $CSBA0087$# Choking (Adult & Paediatric)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Choking (Adult & Paediatric)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Choking (Adult & Paediatric)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0087$,
      false, 10, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Choking (Adult & Paediatric)',
      "type"       = 'quiz',
      "body"       = $CSBA0087$# Choking (Adult & Paediatric)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Choking (Adult & Paediatric)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Choking (Adult & Paediatric)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0087$,
      "position"   = 10,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Advanced Life Support (ALS)
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-advanced-life-support-als'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-advanced-life-support-als', 'Advanced Life Support (ALS)', 'quiz',
      $CSBA0088$# Advanced Life Support (ALS)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Advanced Life Support (ALS)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Advanced Life Support (ALS)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0088$,
      false, 20, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Advanced Life Support (ALS)',
      "type"       = 'quiz',
      "body"       = $CSBA0088$# Advanced Life Support (ALS)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Advanced Life Support (ALS)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Advanced Life Support (ALS)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0088$,
      "position"   = 20,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Paediatric Life Support (PLS)
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-paediatric-life-support-pls'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-paediatric-life-support-pls', 'Paediatric Life Support (PLS)', 'quiz',
      $CSBA0089$# Paediatric Life Support (PLS)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Paediatric Life Support (PLS)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Paediatric Life Support (PLS)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0089$,
      false, 30, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Paediatric Life Support (PLS)',
      "type"       = 'quiz',
      "body"       = $CSBA0089$# Paediatric Life Support (PLS)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Paediatric Life Support (PLS)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Paediatric Life Support (PLS)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0089$,
      "position"   = 30,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Resuscitation in Sepsis
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-resuscitation-in-sepsis'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-resuscitation-in-sepsis', 'Resuscitation in Sepsis', 'quiz',
      $CSBA0090$# Resuscitation in Sepsis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Resuscitation in Sepsis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Resuscitation in Sepsis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0090$,
      false, 40, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Resuscitation in Sepsis',
      "type"       = 'quiz',
      "body"       = $CSBA0090$# Resuscitation in Sepsis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Resuscitation in Sepsis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Resuscitation in Sepsis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0090$,
      "position"   = 40,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Adult Sepsis & Septic Shock
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-adult-sepsis-septic-shock'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-adult-sepsis-septic-shock', 'Adult Sepsis & Septic Shock', 'quiz',
      $CSBA0091$# Adult Sepsis & Septic Shock

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Adult Sepsis & Septic Shock

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Adult Sepsis & Septic Shock**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0091$,
      false, 50, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Adult Sepsis & Septic Shock',
      "type"       = 'quiz',
      "body"       = $CSBA0091$# Adult Sepsis & Septic Shock

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Adult Sepsis & Septic Shock

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Adult Sepsis & Septic Shock**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0091$,
      "position"   = 50,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Neutropenic Sepsis
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-neutropenic-sepsis'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-neutropenic-sepsis', 'Neutropenic Sepsis', 'quiz',
      $CSBA0092$# Neutropenic Sepsis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Neutropenic Sepsis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Neutropenic Sepsis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0092$,
      false, 60, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Neutropenic Sepsis',
      "type"       = 'quiz',
      "body"       = $CSBA0092$# Neutropenic Sepsis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Neutropenic Sepsis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Neutropenic Sepsis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0092$,
      "position"   = 60,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Cardiac Arrest in Pregnancy
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-cardiac-arrest-in-pregnancy'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-cardiac-arrest-in-pregnancy', 'Cardiac Arrest in Pregnancy', 'quiz',
      $CSBA0093$# Cardiac Arrest in Pregnancy

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Cardiac Arrest in Pregnancy

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Cardiac Arrest in Pregnancy**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0093$,
      false, 70, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Cardiac Arrest in Pregnancy',
      "type"       = 'quiz',
      "body"       = $CSBA0093$# Cardiac Arrest in Pregnancy

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Cardiac Arrest in Pregnancy

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Cardiac Arrest in Pregnancy**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0093$,
      "position"   = 70,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Haemorrhagic Shock
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-haemorrhagic-shock'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-haemorrhagic-shock', 'Haemorrhagic Shock', 'quiz',
      $CSBA0094$# Haemorrhagic Shock

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Haemorrhagic Shock

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Haemorrhagic Shock**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0094$,
      false, 80, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Haemorrhagic Shock',
      "type"       = 'quiz',
      "body"       = $CSBA0094$# Haemorrhagic Shock

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Haemorrhagic Shock

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Haemorrhagic Shock**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0094$,
      "position"   = 80,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Transfusion Management of Major Haemorrhage
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-transfusion-management-of-major-haemorrhage'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-transfusion-management-of-major-haemorrhage', 'Transfusion Management of Major Haemorrhage', 'quiz',
      $CSBA0095$# Transfusion Management of Major Haemorrhage

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Transfusion Management of Major Haemorrhage

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Transfusion Management of Major Haemorrhage**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0095$,
      false, 90, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Transfusion Management of Major Haemorrhage',
      "type"       = 'quiz',
      "body"       = $CSBA0095$# Transfusion Management of Major Haemorrhage

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Transfusion Management of Major Haemorrhage

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Transfusion Management of Major Haemorrhage**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0095$,
      "position"   = 90,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: All Scores & Classifications
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-all-scores-classifications'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-all-scores-classifications', 'All Scores & Classifications', 'quiz',
      $CSBA0096$# All Scores & Classifications

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: All Scores & Classifications

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **All Scores & Classifications**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0096$,
      false, 100, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'All Scores & Classifications',
      "type"       = 'quiz',
      "body"       = $CSBA0096$# All Scores & Classifications

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: All Scores & Classifications

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **All Scores & Classifications**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0096$,
      "position"   = 100,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- =========================================================================
  -- MODULE: Urological Emergencies
  -- =========================================================================
  SELECT id INTO v_module_id FROM "modules"
  WHERE "course_id" = v_course_id
    AND "title" = 'Urological Emergencies'
    AND "deleted_at" IS NULL LIMIT 1;

  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id","course_id","title","position","created_at","updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Urological Emergencies', 10, now(), now())
    RETURNING "id" INTO v_module_id;
  END IF;


  -- Topic: Dysuria
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-dysuria'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-dysuria', 'Dysuria', 'quiz',
      $CSBA0097$# Dysuria

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Dysuria

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Dysuria**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0097$,
      false, 0, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Dysuria',
      "type"       = 'quiz',
      "body"       = $CSBA0097$# Dysuria

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Dysuria

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Dysuria**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0097$,
      "position"   = 0,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Urinary Retention & Lower UTI
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-urinary-retention-lower-uti'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-urinary-retention-lower-uti', 'Urinary Retention & Lower UTI', 'quiz',
      $CSBA0098$# Urinary Retention & Lower UTI

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Urinary Retention & Lower UTI

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Urinary Retention & Lower UTI**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0098$,
      false, 10, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Urinary Retention & Lower UTI',
      "type"       = 'quiz',
      "body"       = $CSBA0098$# Urinary Retention & Lower UTI

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Urinary Retention & Lower UTI

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Urinary Retention & Lower UTI**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0098$,
      "position"   = 10,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Testicular Pain
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-testicular-pain'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-testicular-pain', 'Testicular Pain', 'quiz',
      $CSBA0099$# Testicular Pain

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Testicular Pain

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Testicular Pain**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0099$,
      false, 20, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Testicular Pain',
      "type"       = 'quiz',
      "body"       = $CSBA0099$# Testicular Pain

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Testicular Pain

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Testicular Pain**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0099$,
      "position"   = 20,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Haematuria & Urological Cancers
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-haematuria-urological-cancers'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-haematuria-urological-cancers', 'Haematuria & Urological Cancers', 'quiz',
      $CSBA0100$# Haematuria & Urological Cancers

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Haematuria & Urological Cancers

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Haematuria & Urological Cancers**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0100$,
      false, 30, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Haematuria & Urological Cancers',
      "type"       = 'quiz',
      "body"       = $CSBA0100$# Haematuria & Urological Cancers

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Haematuria & Urological Cancers

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Haematuria & Urological Cancers**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0100$,
      "position"   = 30,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Epididymo-orchitis
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-epididymo-orchitis'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-epididymo-orchitis', 'Epididymo-orchitis', 'quiz',
      $CSBA0101$# Epididymo-orchitis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Epididymo-orchitis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Epididymo-orchitis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0101$,
      false, 40, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Epididymo-orchitis',
      "type"       = 'quiz',
      "body"       = $CSBA0101$# Epididymo-orchitis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Epididymo-orchitis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Epididymo-orchitis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0101$,
      "position"   = 40,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Renal & Ureteric Stones
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-renal-ureteric-stones'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-renal-ureteric-stones', 'Renal & Ureteric Stones', 'quiz',
      $CSBA0102$# Renal & Ureteric Stones

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Renal & Ureteric Stones

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Renal & Ureteric Stones**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0102$,
      false, 50, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Renal & Ureteric Stones',
      "type"       = 'quiz',
      "body"       = $CSBA0102$# Renal & Ureteric Stones

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Renal & Ureteric Stones

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Renal & Ureteric Stones**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0102$,
      "position"   = 50,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Phimosis & Paraphimosis
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-phimosis-paraphimosis'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-phimosis-paraphimosis', 'Phimosis & Paraphimosis', 'quiz',
      $CSBA0103$# Phimosis & Paraphimosis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Phimosis & Paraphimosis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Phimosis & Paraphimosis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0103$,
      false, 60, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Phimosis & Paraphimosis',
      "type"       = 'quiz',
      "body"       = $CSBA0103$# Phimosis & Paraphimosis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Phimosis & Paraphimosis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Phimosis & Paraphimosis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0103$,
      "position"   = 60,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Priapism
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-priapism'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-priapism', 'Priapism', 'quiz',
      $CSBA0104$# Priapism

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Priapism

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Priapism**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0104$,
      false, 70, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Priapism',
      "type"       = 'quiz',
      "body"       = $CSBA0104$# Priapism

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Priapism

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Priapism**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0104$,
      "position"   = 70,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Testicular Torsion
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-testicular-torsion'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-testicular-torsion', 'Testicular Torsion', 'quiz',
      $CSBA0105$# Testicular Torsion

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Testicular Torsion

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Testicular Torsion**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0105$,
      false, 80, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Testicular Torsion',
      "type"       = 'quiz',
      "body"       = $CSBA0105$# Testicular Torsion

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Testicular Torsion

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Testicular Torsion**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0105$,
      "position"   = 80,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Prostatitis
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-prostatitis'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-prostatitis', 'Prostatitis', 'quiz',
      $CSBA0106$# Prostatitis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Prostatitis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Prostatitis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0106$,
      false, 90, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Prostatitis',
      "type"       = 'quiz',
      "body"       = $CSBA0106$# Prostatitis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Prostatitis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Prostatitis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0106$,
      "position"   = 90,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Acute Pyelonephritis
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-acute-pyelonephritis'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-acute-pyelonephritis', 'Acute Pyelonephritis', 'quiz',
      $CSBA0107$# Acute Pyelonephritis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Acute Pyelonephritis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Acute Pyelonephritis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0107$,
      false, 100, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Acute Pyelonephritis',
      "type"       = 'quiz',
      "body"       = $CSBA0107$# Acute Pyelonephritis

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Acute Pyelonephritis

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Acute Pyelonephritis**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0107$,
      "position"   = 100,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- =========================================================================
  -- MODULE: Vascular Emergencies
  -- =========================================================================
  SELECT id INTO v_module_id FROM "modules"
  WHERE "course_id" = v_course_id
    AND "title" = 'Vascular Emergencies'
    AND "deleted_at" IS NULL LIMIT 1;

  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id","course_id","title","position","created_at","updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Vascular Emergencies', 10, now(), now())
    RETURNING "id" INTO v_module_id;
  END IF;


  -- Topic: Peripheral Vascular Disease (PVD)
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-peripheral-vascular-disease-pvd'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-peripheral-vascular-disease-pvd', 'Peripheral Vascular Disease (PVD)', 'quiz',
      $CSBA0108$# Peripheral Vascular Disease (PVD)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Peripheral Vascular Disease (PVD)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Peripheral Vascular Disease (PVD)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0108$,
      false, 0, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Peripheral Vascular Disease (PVD)',
      "type"       = 'quiz',
      "body"       = $CSBA0108$# Peripheral Vascular Disease (PVD)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Peripheral Vascular Disease (PVD)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Peripheral Vascular Disease (PVD)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0108$,
      "position"   = 0,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Pulmonary Embolism (PE)
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-pulmonary-embolism-pe'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-pulmonary-embolism-pe', 'Pulmonary Embolism (PE)', 'quiz',
      $CSBA0109$# Pulmonary Embolism (PE)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Pulmonary Embolism (PE)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Pulmonary Embolism (PE)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0109$,
      false, 10, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Pulmonary Embolism (PE)',
      "type"       = 'quiz',
      "body"       = $CSBA0109$# Pulmonary Embolism (PE)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Pulmonary Embolism (PE)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Pulmonary Embolism (PE)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0109$,
      "position"   = 10,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Topic: Deep Vein Thrombosis (DVT)
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'topic-deep-vein-thrombosis-dvt'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'topic-deep-vein-thrombosis-dvt', 'Deep Vein Thrombosis (DVT)', 'quiz',
      $CSBA0110$# Deep Vein Thrombosis (DVT)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Deep Vein Thrombosis (DVT)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Deep Vein Thrombosis (DVT)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0110$,
      false, 20, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Deep Vein Thrombosis (DVT)',
      "type"       = 'quiz',
      "body"       = $CSBA0110$# Deep Vein Thrombosis (DVT)

> [!NOTE]
> **Topic Quiz:** This lesson covers clinical SBA questions based on the topic.
> Work through each question before reviewing the detailed answer rationale.

## Topic: Deep Vein Thrombosis (DVT)

This quiz covers high-yield single best answer (SBA) questions for the MRCEM
examination based on current UK emergency medicine guidelines.

---

### Clinical Objectives

By the end of this topic quiz you should be able to:
- Understand key clinical presentations related to **Deep Vein Thrombosis (DVT)**
- Apply UK evidence-based management guidelines
- Distinguish between similar clinical conditions
- Select the single best answer in SBA examination format

---

> [!IMPORTANT]
> All questions follow RCEM, NICE, BTS, and Royal College guidelines.
> Use the Admin panel to add specific SBA questions to this lesson.
$CSBA0110$,
      "position"   = 20,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- =========================================================================
  -- MODULE: High-Yield Rapid Clinical Revision
  -- =========================================================================
  SELECT id INTO v_module_id FROM "modules"
  WHERE "course_id" = v_course_id
    AND "title" = 'High-Yield Rapid Clinical Revision'
    AND "deleted_at" IS NULL LIMIT 1;

  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id","course_id","title","position","created_at","updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'High-Yield Rapid Clinical Revision', 14, now(), now())
    RETURNING "id" INTO v_module_id;
  END IF;


  -- High-Yield Clinical SBA Practice 1
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-1'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-1', 'High-Yield Clinical SBA Practice 1', 'quiz',
      $CSBA0111$# High-Yield Clinical SBA Practice 1

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0111$,
      false, 1, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 1',
      "type"       = 'quiz',
      "body"       = $CSBA0111$# High-Yield Clinical SBA Practice 1

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0111$,
      "position"   = 1,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 2
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-2'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-2', 'High-Yield Clinical SBA Practice 2', 'quiz',
      $CSBA0112$# High-Yield Clinical SBA Practice 2

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0112$,
      false, 2, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 2',
      "type"       = 'quiz',
      "body"       = $CSBA0112$# High-Yield Clinical SBA Practice 2

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0112$,
      "position"   = 2,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 3
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-3'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-3', 'High-Yield Clinical SBA Practice 3', 'quiz',
      $CSBA0113$# High-Yield Clinical SBA Practice 3

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0113$,
      false, 3, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 3',
      "type"       = 'quiz',
      "body"       = $CSBA0113$# High-Yield Clinical SBA Practice 3

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0113$,
      "position"   = 3,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 4
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-4'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-4', 'High-Yield Clinical SBA Practice 4', 'quiz',
      $CSBA0114$# High-Yield Clinical SBA Practice 4

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0114$,
      false, 4, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 4',
      "type"       = 'quiz',
      "body"       = $CSBA0114$# High-Yield Clinical SBA Practice 4

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0114$,
      "position"   = 4,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 5
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-5'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-5', 'High-Yield Clinical SBA Practice 5', 'quiz',
      $CSBA0115$# High-Yield Clinical SBA Practice 5

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0115$,
      false, 5, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 5',
      "type"       = 'quiz',
      "body"       = $CSBA0115$# High-Yield Clinical SBA Practice 5

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0115$,
      "position"   = 5,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 6
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-6'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-6', 'High-Yield Clinical SBA Practice 6', 'quiz',
      $CSBA0116$# High-Yield Clinical SBA Practice 6

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0116$,
      false, 6, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 6',
      "type"       = 'quiz',
      "body"       = $CSBA0116$# High-Yield Clinical SBA Practice 6

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0116$,
      "position"   = 6,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 7
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-7'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-7', 'High-Yield Clinical SBA Practice 7', 'quiz',
      $CSBA0117$# High-Yield Clinical SBA Practice 7

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0117$,
      false, 7, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 7',
      "type"       = 'quiz',
      "body"       = $CSBA0117$# High-Yield Clinical SBA Practice 7

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0117$,
      "position"   = 7,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 8
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-8'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-8', 'High-Yield Clinical SBA Practice 8', 'quiz',
      $CSBA0118$# High-Yield Clinical SBA Practice 8

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0118$,
      false, 8, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 8',
      "type"       = 'quiz',
      "body"       = $CSBA0118$# High-Yield Clinical SBA Practice 8

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0118$,
      "position"   = 8,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 9
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-9'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-9', 'High-Yield Clinical SBA Practice 9', 'quiz',
      $CSBA0119$# High-Yield Clinical SBA Practice 9

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0119$,
      false, 9, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 9',
      "type"       = 'quiz',
      "body"       = $CSBA0119$# High-Yield Clinical SBA Practice 9

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0119$,
      "position"   = 9,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 10
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-10'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-10', 'High-Yield Clinical SBA Practice 10', 'quiz',
      $CSBA0120$# High-Yield Clinical SBA Practice 10

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0120$,
      false, 10, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 10',
      "type"       = 'quiz',
      "body"       = $CSBA0120$# High-Yield Clinical SBA Practice 10

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0120$,
      "position"   = 10,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 11
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-11'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-11', 'High-Yield Clinical SBA Practice 11', 'quiz',
      $CSBA0121$# High-Yield Clinical SBA Practice 11

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0121$,
      false, 11, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 11',
      "type"       = 'quiz',
      "body"       = $CSBA0121$# High-Yield Clinical SBA Practice 11

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0121$,
      "position"   = 11,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 12
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-12'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-12', 'High-Yield Clinical SBA Practice 12', 'quiz',
      $CSBA0122$# High-Yield Clinical SBA Practice 12

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0122$,
      false, 12, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 12',
      "type"       = 'quiz',
      "body"       = $CSBA0122$# High-Yield Clinical SBA Practice 12

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0122$,
      "position"   = 12,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 13
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-13'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-13', 'High-Yield Clinical SBA Practice 13', 'quiz',
      $CSBA0123$# High-Yield Clinical SBA Practice 13

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0123$,
      false, 13, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 13',
      "type"       = 'quiz',
      "body"       = $CSBA0123$# High-Yield Clinical SBA Practice 13

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0123$,
      "position"   = 13,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 14
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-14'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-14', 'High-Yield Clinical SBA Practice 14', 'quiz',
      $CSBA0124$# High-Yield Clinical SBA Practice 14

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0124$,
      false, 14, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 14',
      "type"       = 'quiz',
      "body"       = $CSBA0124$# High-Yield Clinical SBA Practice 14

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0124$,
      "position"   = 14,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 15
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-15'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-15', 'High-Yield Clinical SBA Practice 15', 'quiz',
      $CSBA0125$# High-Yield Clinical SBA Practice 15

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0125$,
      false, 15, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 15',
      "type"       = 'quiz',
      "body"       = $CSBA0125$# High-Yield Clinical SBA Practice 15

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0125$,
      "position"   = 15,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 16
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-16'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-16', 'High-Yield Clinical SBA Practice 16', 'quiz',
      $CSBA0126$# High-Yield Clinical SBA Practice 16

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0126$,
      false, 16, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 16',
      "type"       = 'quiz',
      "body"       = $CSBA0126$# High-Yield Clinical SBA Practice 16

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0126$,
      "position"   = 16,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 17
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-17'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-17', 'High-Yield Clinical SBA Practice 17', 'quiz',
      $CSBA0127$# High-Yield Clinical SBA Practice 17

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0127$,
      false, 17, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 17',
      "type"       = 'quiz',
      "body"       = $CSBA0127$# High-Yield Clinical SBA Practice 17

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0127$,
      "position"   = 17,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 18
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-18'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-18', 'High-Yield Clinical SBA Practice 18', 'quiz',
      $CSBA0128$# High-Yield Clinical SBA Practice 18

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0128$,
      false, 18, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 18',
      "type"       = 'quiz',
      "body"       = $CSBA0128$# High-Yield Clinical SBA Practice 18

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0128$,
      "position"   = 18,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 19
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-19'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-19', 'High-Yield Clinical SBA Practice 19', 'quiz',
      $CSBA0129$# High-Yield Clinical SBA Practice 19

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0129$,
      false, 19, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 19',
      "type"       = 'quiz',
      "body"       = $CSBA0129$# High-Yield Clinical SBA Practice 19

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0129$,
      "position"   = 19,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 20
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-20'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-20', 'High-Yield Clinical SBA Practice 20', 'quiz',
      $CSBA0130$# High-Yield Clinical SBA Practice 20

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0130$,
      false, 20, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 20',
      "type"       = 'quiz',
      "body"       = $CSBA0130$# High-Yield Clinical SBA Practice 20

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0130$,
      "position"   = 20,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 21
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-21'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-21', 'High-Yield Clinical SBA Practice 21', 'quiz',
      $CSBA0131$# High-Yield Clinical SBA Practice 21

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0131$,
      false, 21, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 21',
      "type"       = 'quiz',
      "body"       = $CSBA0131$# High-Yield Clinical SBA Practice 21

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0131$,
      "position"   = 21,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 22
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-22'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-22', 'High-Yield Clinical SBA Practice 22', 'quiz',
      $CSBA0132$# High-Yield Clinical SBA Practice 22

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0132$,
      false, 22, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 22',
      "type"       = 'quiz',
      "body"       = $CSBA0132$# High-Yield Clinical SBA Practice 22

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0132$,
      "position"   = 22,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 23
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-23'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-23', 'High-Yield Clinical SBA Practice 23', 'quiz',
      $CSBA0133$# High-Yield Clinical SBA Practice 23

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0133$,
      false, 23, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 23',
      "type"       = 'quiz',
      "body"       = $CSBA0133$# High-Yield Clinical SBA Practice 23

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0133$,
      "position"   = 23,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 24
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-24'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-24', 'High-Yield Clinical SBA Practice 24', 'quiz',
      $CSBA0134$# High-Yield Clinical SBA Practice 24

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0134$,
      false, 24, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 24',
      "type"       = 'quiz',
      "body"       = $CSBA0134$# High-Yield Clinical SBA Practice 24

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0134$,
      "position"   = 24,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 25
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-25'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-25', 'High-Yield Clinical SBA Practice 25', 'quiz',
      $CSBA0135$# High-Yield Clinical SBA Practice 25

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0135$,
      false, 25, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 25',
      "type"       = 'quiz',
      "body"       = $CSBA0135$# High-Yield Clinical SBA Practice 25

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0135$,
      "position"   = 25,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 26
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-26'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-26', 'High-Yield Clinical SBA Practice 26', 'quiz',
      $CSBA0136$# High-Yield Clinical SBA Practice 26

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0136$,
      false, 26, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 26',
      "type"       = 'quiz',
      "body"       = $CSBA0136$# High-Yield Clinical SBA Practice 26

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0136$,
      "position"   = 26,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 27
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-27'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-27', 'High-Yield Clinical SBA Practice 27', 'quiz',
      $CSBA0137$# High-Yield Clinical SBA Practice 27

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0137$,
      false, 27, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 27',
      "type"       = 'quiz',
      "body"       = $CSBA0137$# High-Yield Clinical SBA Practice 27

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0137$,
      "position"   = 27,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 28
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-28'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-28', 'High-Yield Clinical SBA Practice 28', 'quiz',
      $CSBA0138$# High-Yield Clinical SBA Practice 28

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0138$,
      false, 28, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 28',
      "type"       = 'quiz',
      "body"       = $CSBA0138$# High-Yield Clinical SBA Practice 28

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0138$,
      "position"   = 28,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 29
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-29'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-29', 'High-Yield Clinical SBA Practice 29', 'quiz',
      $CSBA0139$# High-Yield Clinical SBA Practice 29

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0139$,
      false, 29, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 29',
      "type"       = 'quiz',
      "body"       = $CSBA0139$# High-Yield Clinical SBA Practice 29

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0139$,
      "position"   = 29,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 30
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-30'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-30', 'High-Yield Clinical SBA Practice 30', 'quiz',
      $CSBA0140$# High-Yield Clinical SBA Practice 30

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0140$,
      false, 30, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 30',
      "type"       = 'quiz',
      "body"       = $CSBA0140$# High-Yield Clinical SBA Practice 30

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0140$,
      "position"   = 30,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 31
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-31'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-31', 'High-Yield Clinical SBA Practice 31', 'quiz',
      $CSBA0141$# High-Yield Clinical SBA Practice 31

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0141$,
      false, 31, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 31',
      "type"       = 'quiz',
      "body"       = $CSBA0141$# High-Yield Clinical SBA Practice 31

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0141$,
      "position"   = 31,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 32
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-32'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-32', 'High-Yield Clinical SBA Practice 32', 'quiz',
      $CSBA0142$# High-Yield Clinical SBA Practice 32

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0142$,
      false, 32, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 32',
      "type"       = 'quiz',
      "body"       = $CSBA0142$# High-Yield Clinical SBA Practice 32

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0142$,
      "position"   = 32,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 33
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-33'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-33', 'High-Yield Clinical SBA Practice 33', 'quiz',
      $CSBA0143$# High-Yield Clinical SBA Practice 33

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0143$,
      false, 33, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 33',
      "type"       = 'quiz',
      "body"       = $CSBA0143$# High-Yield Clinical SBA Practice 33

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0143$,
      "position"   = 33,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 34
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-34'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-34', 'High-Yield Clinical SBA Practice 34', 'quiz',
      $CSBA0144$# High-Yield Clinical SBA Practice 34

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0144$,
      false, 34, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 34',
      "type"       = 'quiz',
      "body"       = $CSBA0144$# High-Yield Clinical SBA Practice 34

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0144$,
      "position"   = 34,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 35
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-35'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-35', 'High-Yield Clinical SBA Practice 35', 'quiz',
      $CSBA0145$# High-Yield Clinical SBA Practice 35

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0145$,
      false, 35, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 35',
      "type"       = 'quiz',
      "body"       = $CSBA0145$# High-Yield Clinical SBA Practice 35

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0145$,
      "position"   = 35,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 36
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-36'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-36', 'High-Yield Clinical SBA Practice 36', 'quiz',
      $CSBA0146$# High-Yield Clinical SBA Practice 36

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0146$,
      false, 36, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 36',
      "type"       = 'quiz',
      "body"       = $CSBA0146$# High-Yield Clinical SBA Practice 36

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0146$,
      "position"   = 36,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 37
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-37'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-37', 'High-Yield Clinical SBA Practice 37', 'quiz',
      $CSBA0147$# High-Yield Clinical SBA Practice 37

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0147$,
      false, 37, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 37',
      "type"       = 'quiz',
      "body"       = $CSBA0147$# High-Yield Clinical SBA Practice 37

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0147$,
      "position"   = 37,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 38
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-38'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-38', 'High-Yield Clinical SBA Practice 38', 'quiz',
      $CSBA0148$# High-Yield Clinical SBA Practice 38

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0148$,
      false, 38, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 38',
      "type"       = 'quiz',
      "body"       = $CSBA0148$# High-Yield Clinical SBA Practice 38

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0148$,
      "position"   = 38,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 39
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-39'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-39', 'High-Yield Clinical SBA Practice 39', 'quiz',
      $CSBA0149$# High-Yield Clinical SBA Practice 39

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0149$,
      false, 39, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 39',
      "type"       = 'quiz',
      "body"       = $CSBA0149$# High-Yield Clinical SBA Practice 39

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0149$,
      "position"   = 39,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 40
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-40'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-40', 'High-Yield Clinical SBA Practice 40', 'quiz',
      $CSBA0150$# High-Yield Clinical SBA Practice 40

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0150$,
      false, 40, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 40',
      "type"       = 'quiz',
      "body"       = $CSBA0150$# High-Yield Clinical SBA Practice 40

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0150$,
      "position"   = 40,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 41
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-41'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-41', 'High-Yield Clinical SBA Practice 41', 'quiz',
      $CSBA0151$# High-Yield Clinical SBA Practice 41

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0151$,
      false, 41, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 41',
      "type"       = 'quiz',
      "body"       = $CSBA0151$# High-Yield Clinical SBA Practice 41

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0151$,
      "position"   = 41,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 42
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-42'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-42', 'High-Yield Clinical SBA Practice 42', 'quiz',
      $CSBA0152$# High-Yield Clinical SBA Practice 42

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0152$,
      false, 42, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 42',
      "type"       = 'quiz',
      "body"       = $CSBA0152$# High-Yield Clinical SBA Practice 42

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0152$,
      "position"   = 42,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 43
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-43'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-43', 'High-Yield Clinical SBA Practice 43', 'quiz',
      $CSBA0153$# High-Yield Clinical SBA Practice 43

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0153$,
      false, 43, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 43',
      "type"       = 'quiz',
      "body"       = $CSBA0153$# High-Yield Clinical SBA Practice 43

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0153$,
      "position"   = 43,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 44
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-44'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-44', 'High-Yield Clinical SBA Practice 44', 'quiz',
      $CSBA0154$# High-Yield Clinical SBA Practice 44

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0154$,
      false, 44, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 44',
      "type"       = 'quiz',
      "body"       = $CSBA0154$# High-Yield Clinical SBA Practice 44

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0154$,
      "position"   = 44,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 45
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-45'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-45', 'High-Yield Clinical SBA Practice 45', 'quiz',
      $CSBA0155$# High-Yield Clinical SBA Practice 45

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0155$,
      false, 45, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 45',
      "type"       = 'quiz',
      "body"       = $CSBA0155$# High-Yield Clinical SBA Practice 45

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0155$,
      "position"   = 45,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 46
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-46'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-46', 'High-Yield Clinical SBA Practice 46', 'quiz',
      $CSBA0156$# High-Yield Clinical SBA Practice 46

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0156$,
      false, 46, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 46',
      "type"       = 'quiz',
      "body"       = $CSBA0156$# High-Yield Clinical SBA Practice 46

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0156$,
      "position"   = 46,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 47
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-47'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-47', 'High-Yield Clinical SBA Practice 47', 'quiz',
      $CSBA0157$# High-Yield Clinical SBA Practice 47

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0157$,
      false, 47, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 47',
      "type"       = 'quiz',
      "body"       = $CSBA0157$# High-Yield Clinical SBA Practice 47

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0157$,
      "position"   = 47,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 48
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-48'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-48', 'High-Yield Clinical SBA Practice 48', 'quiz',
      $CSBA0158$# High-Yield Clinical SBA Practice 48

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0158$,
      false, 48, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 48',
      "type"       = 'quiz',
      "body"       = $CSBA0158$# High-Yield Clinical SBA Practice 48

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0158$,
      "position"   = 48,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 49
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-49'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-49', 'High-Yield Clinical SBA Practice 49', 'quiz',
      $CSBA0159$# High-Yield Clinical SBA Practice 49

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0159$,
      false, 49, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 49',
      "type"       = 'quiz',
      "body"       = $CSBA0159$# High-Yield Clinical SBA Practice 49

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0159$,
      "position"   = 49,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 50
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-50'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-50', 'High-Yield Clinical SBA Practice 50', 'quiz',
      $CSBA0160$# High-Yield Clinical SBA Practice 50

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0160$,
      false, 50, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 50',
      "type"       = 'quiz',
      "body"       = $CSBA0160$# High-Yield Clinical SBA Practice 50

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0160$,
      "position"   = 50,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 51
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-51'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-51', 'High-Yield Clinical SBA Practice 51', 'quiz',
      $CSBA0161$# High-Yield Clinical SBA Practice 51

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0161$,
      false, 51, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 51',
      "type"       = 'quiz',
      "body"       = $CSBA0161$# High-Yield Clinical SBA Practice 51

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0161$,
      "position"   = 51,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 52
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-52'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-52', 'High-Yield Clinical SBA Practice 52', 'quiz',
      $CSBA0162$# High-Yield Clinical SBA Practice 52

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0162$,
      false, 52, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 52',
      "type"       = 'quiz',
      "body"       = $CSBA0162$# High-Yield Clinical SBA Practice 52

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0162$,
      "position"   = 52,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 53
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-53'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-53', 'High-Yield Clinical SBA Practice 53', 'quiz',
      $CSBA0163$# High-Yield Clinical SBA Practice 53

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0163$,
      false, 53, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 53',
      "type"       = 'quiz',
      "body"       = $CSBA0163$# High-Yield Clinical SBA Practice 53

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0163$,
      "position"   = 53,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 54
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-54'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-54', 'High-Yield Clinical SBA Practice 54', 'quiz',
      $CSBA0164$# High-Yield Clinical SBA Practice 54

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0164$,
      false, 54, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 54',
      "type"       = 'quiz',
      "body"       = $CSBA0164$# High-Yield Clinical SBA Practice 54

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0164$,
      "position"   = 54,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 55
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-55'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-55', 'High-Yield Clinical SBA Practice 55', 'quiz',
      $CSBA0165$# High-Yield Clinical SBA Practice 55

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0165$,
      false, 55, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 55',
      "type"       = 'quiz',
      "body"       = $CSBA0165$# High-Yield Clinical SBA Practice 55

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0165$,
      "position"   = 55,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 56
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-56'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-56', 'High-Yield Clinical SBA Practice 56', 'quiz',
      $CSBA0166$# High-Yield Clinical SBA Practice 56

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0166$,
      false, 56, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 56',
      "type"       = 'quiz',
      "body"       = $CSBA0166$# High-Yield Clinical SBA Practice 56

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0166$,
      "position"   = 56,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 57
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-57'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-57', 'High-Yield Clinical SBA Practice 57', 'quiz',
      $CSBA0167$# High-Yield Clinical SBA Practice 57

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0167$,
      false, 57, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 57',
      "type"       = 'quiz',
      "body"       = $CSBA0167$# High-Yield Clinical SBA Practice 57

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0167$,
      "position"   = 57,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 58
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-58'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-58', 'High-Yield Clinical SBA Practice 58', 'quiz',
      $CSBA0168$# High-Yield Clinical SBA Practice 58

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0168$,
      false, 58, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 58',
      "type"       = 'quiz',
      "body"       = $CSBA0168$# High-Yield Clinical SBA Practice 58

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0168$,
      "position"   = 58,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 59
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-59'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-59', 'High-Yield Clinical SBA Practice 59', 'quiz',
      $CSBA0169$# High-Yield Clinical SBA Practice 59

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0169$,
      false, 59, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 59',
      "type"       = 'quiz',
      "body"       = $CSBA0169$# High-Yield Clinical SBA Practice 59

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0169$,
      "position"   = 59,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 60
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-60'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-60', 'High-Yield Clinical SBA Practice 60', 'quiz',
      $CSBA0170$# High-Yield Clinical SBA Practice 60

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0170$,
      false, 60, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 60',
      "type"       = 'quiz',
      "body"       = $CSBA0170$# High-Yield Clinical SBA Practice 60

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0170$,
      "position"   = 60,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 61
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-61'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-61', 'High-Yield Clinical SBA Practice 61', 'quiz',
      $CSBA0171$# High-Yield Clinical SBA Practice 61

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0171$,
      false, 61, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 61',
      "type"       = 'quiz',
      "body"       = $CSBA0171$# High-Yield Clinical SBA Practice 61

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0171$,
      "position"   = 61,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 62
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-62'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-62', 'High-Yield Clinical SBA Practice 62', 'quiz',
      $CSBA0172$# High-Yield Clinical SBA Practice 62

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0172$,
      false, 62, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 62',
      "type"       = 'quiz',
      "body"       = $CSBA0172$# High-Yield Clinical SBA Practice 62

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0172$,
      "position"   = 62,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 63
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-63'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-63', 'High-Yield Clinical SBA Practice 63', 'quiz',
      $CSBA0173$# High-Yield Clinical SBA Practice 63

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0173$,
      false, 63, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 63',
      "type"       = 'quiz',
      "body"       = $CSBA0173$# High-Yield Clinical SBA Practice 63

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0173$,
      "position"   = 63,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 64
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-64'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-64', 'High-Yield Clinical SBA Practice 64', 'quiz',
      $CSBA0174$# High-Yield Clinical SBA Practice 64

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0174$,
      false, 64, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 64',
      "type"       = 'quiz',
      "body"       = $CSBA0174$# High-Yield Clinical SBA Practice 64

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0174$,
      "position"   = 64,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 65
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-65'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-65', 'High-Yield Clinical SBA Practice 65', 'quiz',
      $CSBA0175$# High-Yield Clinical SBA Practice 65

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0175$,
      false, 65, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 65',
      "type"       = 'quiz',
      "body"       = $CSBA0175$# High-Yield Clinical SBA Practice 65

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0175$,
      "position"   = 65,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 56
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-56-561'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-56-561', 'High-Yield Clinical SBA Practice 56', 'quiz',
      $CSBA0176$# High-Yield Clinical SBA Practice 56

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0176$,
      false, 561, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 56',
      "type"       = 'quiz',
      "body"       = $CSBA0176$# High-Yield Clinical SBA Practice 56

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0176$,
      "position"   = 561,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 58
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-58-580'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-58-580', 'High-Yield Clinical SBA Practice 58', 'quiz',
      $CSBA0177$# High-Yield Clinical SBA Practice 58

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0177$,
      false, 580, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 58',
      "type"       = 'quiz',
      "body"       = $CSBA0177$# High-Yield Clinical SBA Practice 58

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0177$,
      "position"   = 580,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- High-Yield Clinical SBA Practice 59
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-high-yield-clinical-sba-practice-59-590'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-high-yield-clinical-sba-practice-59-590', 'High-Yield Clinical SBA Practice 59', 'quiz',
      $CSBA0178$# High-Yield Clinical SBA Practice 59

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0178$,
      false, 590, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'High-Yield Clinical SBA Practice 59',
      "type"       = 'quiz',
      "body"       = $CSBA0178$# High-Yield Clinical SBA Practice 59

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0178$,
      "position"   = 590,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Expert Clinical SBA Mock 2
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-expert-clinical-sba-mock-2'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-expert-clinical-sba-mock-2', 'Expert Clinical SBA Mock 2', 'quiz',
      $CSBA0179$# Expert Clinical SBA Mock 2

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0179$,
      false, 1000, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Expert Clinical SBA Mock 2',
      "type"       = 'quiz',
      "body"       = $CSBA0179$# Expert Clinical SBA Mock 2

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0179$,
      "position"   = 1000,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Expert Clinical SBA Mock 2 (Alt)
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-expert-clinical-sba-mock-2-alt'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-expert-clinical-sba-mock-2-alt', 'Expert Clinical SBA Mock 2 (Alt)', 'quiz',
      $CSBA0180$# Expert Clinical SBA Mock 2 (Alt)

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0180$,
      false, 1001, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Expert Clinical SBA Mock 2 (Alt)',
      "type"       = 'quiz',
      "body"       = $CSBA0180$# Expert Clinical SBA Mock 2 (Alt)

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0180$,
      "position"   = 1001,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Expert Clinical SBA Mock 3 (MOKA Edition)
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-expert-clinical-sba-mock-3-moka-edition'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-expert-clinical-sba-mock-3-moka-edition', 'Expert Clinical SBA Mock 3 (MOKA Edition)', 'quiz',
      $CSBA0181$# Expert Clinical SBA Mock 3 (MOKA Edition)

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0181$,
      false, 1002, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Expert Clinical SBA Mock 3 (MOKA Edition)',
      "type"       = 'quiz',
      "body"       = $CSBA0181$# Expert Clinical SBA Mock 3 (MOKA Edition)

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0181$,
      "position"   = 1002,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Expert Clinical SBA Mock 3
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-expert-clinical-sba-mock-3'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-expert-clinical-sba-mock-3', 'Expert Clinical SBA Mock 3', 'quiz',
      $CSBA0182$# Expert Clinical SBA Mock 3

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0182$,
      false, 1003, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Expert Clinical SBA Mock 3',
      "type"       = 'quiz',
      "body"       = $CSBA0182$# Expert Clinical SBA Mock 3

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0182$,
      "position"   = 1003,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


  -- Expert Clinical SBA Mock 4
  SELECT id INTO v_lesson_id FROM "lessons"
  WHERE "module_id" = v_module_id
    AND "slug" = 'moka-expert-clinical-sba-mock-4'
    AND "deleted_at" IS NULL LIMIT 1;
  IF v_lesson_id IS NULL THEN
    INSERT INTO "lessons"
      ("id","module_id","slug","title","type","body","is_free_preview","position","status","created_at","updated_at")
    VALUES (
      gen_random_uuid(), v_module_id,
      'moka-expert-clinical-sba-mock-4', 'Expert Clinical SBA Mock 4', 'quiz',
      $CSBA0183$# Expert Clinical SBA Mock 4

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0183$,
      false, 1004, 'published', now(), now()
    );
  ELSE
    UPDATE "lessons" SET
      "title"      = 'Expert Clinical SBA Mock 4',
      "type"       = 'quiz',
      "body"       = $CSBA0183$# Expert Clinical SBA Mock 4

> [!NOTE]
> This is a High-Yield MRCEM SBA practice session from the MOKA clinical revision series.
> Work through each clinical scenario and select the single best answer.

## About This Session

- **Series:** High-Yield Rapid Clinical Revision
- **Format:** Single Best Answer (SBA)
- **Source:** MOKA Clinical SBA Question Bank
- **Guidelines:** RCEM, NICE, BTS, Surviving Sepsis Campaign

---

> [!IMPORTANT]
> Review all answer rationales carefully after completing the quiz.
> Focus on understanding the clinical reasoning, not just memorising answers.
$CSBA0183$,
      "position"   = 1004,
      "status"     = 'published',
      "updated_at" = now()
    WHERE "id" = v_lesson_id;
  END IF;


END $$;
