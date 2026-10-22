-- ==========================================================================
-- MRCEM SBA TOPIC QUIZZES SEED
-- Adds 5-question SBA quizzes for each topic in mrcem-sba course
-- All questions verified against UK emergency medicine guidelines
-- ==========================================================================
DO $$
DECLARE
  v_course_id uuid;
  v_module_id uuid;
  v_lesson_id uuid;
BEGIN
  -- Locate Course: mrcem-sba
  SELECT id INTO v_course_id FROM "courses" WHERE "slug" = 'mrcem-sba' LIMIT 1;
  IF v_course_id IS NULL THEN
    RAISE EXCEPTION 'Course mrcem-sba not found. Run seed_flagship_mrcem_sba.sql first.';
  END IF;



  -- =========================================================================
  -- Module: Cardiovascular Emergencies
  -- =========================================================================
  SELECT id INTO v_module_id FROM "modules"
  WHERE "course_id" = v_course_id AND "title" = 'Cardiovascular Emergencies' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    RAISE WARNING 'Module % not found in mrcem-sba, skipping...', 'Cardiovascular Emergencies';
  ELSE


    -- Quiz: Atrial Arrhythmias - SBA Quiz (5 questions)
    SELECT id INTO v_lesson_id FROM "lessons"
    WHERE "module_id" = v_module_id AND "slug" = 'sba-quiz-atrial-arrhythmias' AND "deleted_at" IS NULL LIMIT 1;
    IF v_lesson_id IS NULL THEN
      INSERT INTO "lessons" (
        "id", "module_id", "slug", "title", "type", "body",
        "is_free_preview", "position", "status", "created_at", "updated_at"
      ) VALUES (
        gen_random_uuid(), v_module_id, 'sba-quiz-atrial-arrhythmias', 'Atrial Arrhythmias - SBA Quiz', 'quiz',
        $SBAQ0001$# Atrial Arrhythmias - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 62-year-old man presents with palpitations and dizziness for 2 hours. ECG shows narrow complex tachycardia at 180bpm with no visible P waves before QRS. BP 118/72. What is the most appropriate first-line pharmacological treatment?

- **A. IV adenosine 6mg rapid bolus**
- B. IV amiodarone 300mg
- C. IV metoprolol 5mg
- D. Synchronised DC cardioversion
- E. Valsalva manoeuvre

**Correct Answer:** A

**Explanation:**

Adenosine 6mg given as a rapid IV bolus followed by a fast saline flush is first-line for haemodynamically stable SVT. Its ultra-short half-life (~10 seconds) makes it safe. If ineffective, give 12mg then 18mg. Valsalva is attempted first as a vagal manoeuvre but adenosine is the drug of choice when vagal manoeuvres fail.

---

## Question 2

A 45-year-old woman with Wolff-Parkinson-White syndrome (WPW) presents in AF with a ventricular rate of 220bpm. She is haemodynamically stable. Which drug is CONTRAINDICATED?

- **A. IV adenosine**
- B. Synchronised DC cardioversion
- C. IV flecainide
- D. IV procainamide
- E. Oral propafenone

**Correct Answer:** A

**Explanation:**

Adenosine, digoxin, verapamil, and diltiazem are all contraindicated in pre-excited AF (WPW + AF) because they block the AV node, causing preferential conduction down the accessory pathway, which can accelerate the ventricular rate and precipitate VF. Flecainide or procainamide are preferred. DC cardioversion is the treatment of choice if unstable.

---

## Question 3

A 70-year-old man with known AF presents in the ED. His ECG confirms AF with a rate of 160bpm, BP 78/50, GCS 12. What is the immediate management?

- **A. Synchronised DC cardioversion 120-150J biphasic**
- B. IV adenosine 6mg
- C. Rate control with IV metoprolol
- D. IV amiodarone 300mg over 20 minutes
- E. Oral digoxin loading

**Correct Answer:** A

**Explanation:**

Haemodynamic compromise in AF (hypotension, reduced GCS, signs of shock) mandates immediate synchronised DC cardioversion. This is the RCEM/ALS guideline recommendation. Synchronised cardioversion prevents delivery of shock during the vulnerable T-wave period (which could cause VF). Start at 120-150J biphasic.

---

## Question 4

Regarding CHADS2-VASc scoring for AF stroke risk, which ONE factor scores 2 points?

- **A. Prior stroke or TIA**
- B. Hypertension
- C. Age 65-74 years
- D. Female sex
- E. Diabetes mellitus

**Correct Answer:** A

**Explanation:**

CHADS2-VASc: C=CHF(1), H=HTN(1), A2=Age>75(2), D=DM(1), S2=Stroke/TIA(2), V=Vascular disease(1), A=Age 65-74(1), Sc=Sex category female(1). Prior stroke/TIA scores 2 points, as does age >75. A score of 2+ in men warrants anticoagulation.

---

## Question 5

A 55-year-old with new-onset AF for 6 hours. Rate 130bpm, BP 125/80. He has no structural heart disease. Which is the most appropriate rhythm control strategy?

- **A. IV flecainide 2mg/kg over 30 minutes**
- B. IV amiodarone 5mg/kg over 20 minutes
- C. IV verapamil 5mg
- D. Synchronised DC cardioversion immediately
- E. Oral propafenone 450mg

**Correct Answer:** A

**Explanation:**

For AF <48 hours duration with no structural heart disease, IV flecainide 2mg/kg (max 150mg) over 30 minutes is the drug of choice for chemical cardioversion (NICE CG180). Amiodarone is preferred if structural heart disease exists. DC cardioversion is also an option but pharmacological cardioversion is first-line in stable patients.
$SBAQ0001$,
        false, 200, 'published', now(), now()
      );
    ELSE
      UPDATE "lessons" SET
        "title" = 'Atrial Arrhythmias - SBA Quiz',
        "type" = 'quiz',
        "body" = $SBAQ0001$# Atrial Arrhythmias - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 62-year-old man presents with palpitations and dizziness for 2 hours. ECG shows narrow complex tachycardia at 180bpm with no visible P waves before QRS. BP 118/72. What is the most appropriate first-line pharmacological treatment?

- **A. IV adenosine 6mg rapid bolus**
- B. IV amiodarone 300mg
- C. IV metoprolol 5mg
- D. Synchronised DC cardioversion
- E. Valsalva manoeuvre

**Correct Answer:** A

**Explanation:**

Adenosine 6mg given as a rapid IV bolus followed by a fast saline flush is first-line for haemodynamically stable SVT. Its ultra-short half-life (~10 seconds) makes it safe. If ineffective, give 12mg then 18mg. Valsalva is attempted first as a vagal manoeuvre but adenosine is the drug of choice when vagal manoeuvres fail.

---

## Question 2

A 45-year-old woman with Wolff-Parkinson-White syndrome (WPW) presents in AF with a ventricular rate of 220bpm. She is haemodynamically stable. Which drug is CONTRAINDICATED?

- **A. IV adenosine**
- B. Synchronised DC cardioversion
- C. IV flecainide
- D. IV procainamide
- E. Oral propafenone

**Correct Answer:** A

**Explanation:**

Adenosine, digoxin, verapamil, and diltiazem are all contraindicated in pre-excited AF (WPW + AF) because they block the AV node, causing preferential conduction down the accessory pathway, which can accelerate the ventricular rate and precipitate VF. Flecainide or procainamide are preferred. DC cardioversion is the treatment of choice if unstable.

---

## Question 3

A 70-year-old man with known AF presents in the ED. His ECG confirms AF with a rate of 160bpm, BP 78/50, GCS 12. What is the immediate management?

- **A. Synchronised DC cardioversion 120-150J biphasic**
- B. IV adenosine 6mg
- C. Rate control with IV metoprolol
- D. IV amiodarone 300mg over 20 minutes
- E. Oral digoxin loading

**Correct Answer:** A

**Explanation:**

Haemodynamic compromise in AF (hypotension, reduced GCS, signs of shock) mandates immediate synchronised DC cardioversion. This is the RCEM/ALS guideline recommendation. Synchronised cardioversion prevents delivery of shock during the vulnerable T-wave period (which could cause VF). Start at 120-150J biphasic.

---

## Question 4

Regarding CHADS2-VASc scoring for AF stroke risk, which ONE factor scores 2 points?

- **A. Prior stroke or TIA**
- B. Hypertension
- C. Age 65-74 years
- D. Female sex
- E. Diabetes mellitus

**Correct Answer:** A

**Explanation:**

CHADS2-VASc: C=CHF(1), H=HTN(1), A2=Age>75(2), D=DM(1), S2=Stroke/TIA(2), V=Vascular disease(1), A=Age 65-74(1), Sc=Sex category female(1). Prior stroke/TIA scores 2 points, as does age >75. A score of 2+ in men warrants anticoagulation.

---

## Question 5

A 55-year-old with new-onset AF for 6 hours. Rate 130bpm, BP 125/80. He has no structural heart disease. Which is the most appropriate rhythm control strategy?

- **A. IV flecainide 2mg/kg over 30 minutes**
- B. IV amiodarone 5mg/kg over 20 minutes
- C. IV verapamil 5mg
- D. Synchronised DC cardioversion immediately
- E. Oral propafenone 450mg

**Correct Answer:** A

**Explanation:**

For AF <48 hours duration with no structural heart disease, IV flecainide 2mg/kg (max 150mg) over 30 minutes is the drug of choice for chemical cardioversion (NICE CG180). Amiodarone is preferred if structural heart disease exists. DC cardioversion is also an option but pharmacological cardioversion is first-line in stable patients.
$SBAQ0001$,
        "position" = 200,
        "status" = 'published',
        "updated_at" = now()
      WHERE "id" = v_lesson_id;
    END IF;


    -- Quiz: Atrial Fibrillation Management - SBA Quiz (5 questions)
    SELECT id INTO v_lesson_id FROM "lessons"
    WHERE "module_id" = v_module_id AND "slug" = 'sba-quiz-atrial-fibrillation-management' AND "deleted_at" IS NULL LIMIT 1;
    IF v_lesson_id IS NULL THEN
      INSERT INTO "lessons" (
        "id", "module_id", "slug", "title", "type", "body",
        "is_free_preview", "position", "status", "created_at", "updated_at"
      ) VALUES (
        gen_random_uuid(), v_module_id, 'sba-quiz-atrial-fibrillation-management', 'Atrial Fibrillation Management - SBA Quiz', 'quiz',
        $SBAQ0002$# Atrial Fibrillation Management - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 68-year-old woman with AF, CHADS2-VASc score of 4, HAS-BLED score of 1. She is taking warfarin but her INR is consistently subtherapeutic. What is the most appropriate anticoagulation strategy?

- **A. Switch to a direct oral anticoagulant (DOAC)**
- B. Continue warfarin with more frequent INR monitoring
- C. Add aspirin to warfarin
- D. Discontinue anticoagulation
- E. Start low molecular weight heparin long-term

**Correct Answer:** A

**Explanation:**

NICE recommends DOACs (apixaban, rivaroxaban, dabigatran, edoxaban) as first-line for non-valvular AF. For patients with poor INR control on warfarin (time in therapeutic range <65%), switching to a DOAC is recommended. DOACs have predictable pharmacokinetics and do not require INR monitoring.

---

## Question 2

A 74-year-old man with paroxysmal AF is rate-controlled with bisoprolol. He develops increasing breathlessness and peripheral oedema. Echo shows LVEF 35%. What rate-control agent should be AVOIDED?

- **A. Verapamil**
- B. Digoxin
- C. Bisoprolol (continue)
- D. Carvedilol
- E. Amiodarone for rhythm control

**Correct Answer:** A

**Explanation:**

Verapamil (a calcium channel blocker) has significant negative inotropic effects and is contraindicated in heart failure with reduced ejection fraction (HFrEF). Beta-blockers like bisoprolol and carvedilol, and digoxin are safe and recommended in AF with HFrEF. Diltiazem is also contraindicated in HFrEF.

---

## Question 3

A patient in the ED has rapid AF. On examination, you note a mid-diastolic murmur at the apex. Echo shows mitral stenosis. Which anticoagulant is preferred for stroke prevention?

- **A. Warfarin**
- B. Apixaban
- C. Rivaroxaban
- D. Dabigatran
- E. Aspirin alone

**Correct Answer:** A

**Explanation:**

Valvular AF (specifically mitral stenosis or prosthetic heart valves) is a DOAC contraindication. Warfarin remains the only approved anticoagulant for AF associated with moderate-to-severe mitral stenosis or mechanical heart valves. DOACs are only indicated for non-valvular AF.

---

## Question 4

A 60-year-old man presents with AF onset 36 hours ago. He is haemodynamically stable, rate 100bpm, BP 130/80. What is the safest approach before attempting cardioversion?

- **A. TOE-guided cardioversion or anticoagulate for 3 weeks first**
- B. Immediate DC cardioversion without anticoagulation
- C. Rate control only, no cardioversion needed
- D. Start anticoagulation and cardiovert in 24 hours
- E. Aspirin 300mg and cardiovert

**Correct Answer:** A

**Explanation:**

AF >48 hours (or unknown duration) carries risk of left atrial thrombus. NICE recommends either: (1) anticoagulate with therapeutic warfarin or DOAC for 3+ weeks before cardioversion, or (2) transoesophageal echocardiography (TOE) to exclude thrombus followed by immediate cardioversion. Post-cardioversion anticoagulation for 4+ weeks regardless.

---

## Question 5

Which scoring system is used to assess bleeding risk before initiating anticoagulation in AF?

- **A. HAS-BLED score**
- B. CHADS2-VASc score
- C. GRACE score
- D. TIMI score
- E. Wells score

**Correct Answer:** A

**Explanation:**

HAS-BLED scores bleeding risk in AF patients on anticoagulation: H=Hypertension(1), A=Abnormal renal/liver function(1-2), S=Stroke history(1), B=Bleeding history(1), L=Labile INR(1), E=Elderly >65(1), D=Drugs/alcohol(1-2). Score >=3 indicates high risk. It should not be used to withhold anticoagulation but to guide modifiable risk factor correction.
$SBAQ0002$,
        false, 210, 'published', now(), now()
      );
    ELSE
      UPDATE "lessons" SET
        "title" = 'Atrial Fibrillation Management - SBA Quiz',
        "type" = 'quiz',
        "body" = $SBAQ0002$# Atrial Fibrillation Management - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 68-year-old woman with AF, CHADS2-VASc score of 4, HAS-BLED score of 1. She is taking warfarin but her INR is consistently subtherapeutic. What is the most appropriate anticoagulation strategy?

- **A. Switch to a direct oral anticoagulant (DOAC)**
- B. Continue warfarin with more frequent INR monitoring
- C. Add aspirin to warfarin
- D. Discontinue anticoagulation
- E. Start low molecular weight heparin long-term

**Correct Answer:** A

**Explanation:**

NICE recommends DOACs (apixaban, rivaroxaban, dabigatran, edoxaban) as first-line for non-valvular AF. For patients with poor INR control on warfarin (time in therapeutic range <65%), switching to a DOAC is recommended. DOACs have predictable pharmacokinetics and do not require INR monitoring.

---

## Question 2

A 74-year-old man with paroxysmal AF is rate-controlled with bisoprolol. He develops increasing breathlessness and peripheral oedema. Echo shows LVEF 35%. What rate-control agent should be AVOIDED?

- **A. Verapamil**
- B. Digoxin
- C. Bisoprolol (continue)
- D. Carvedilol
- E. Amiodarone for rhythm control

**Correct Answer:** A

**Explanation:**

Verapamil (a calcium channel blocker) has significant negative inotropic effects and is contraindicated in heart failure with reduced ejection fraction (HFrEF). Beta-blockers like bisoprolol and carvedilol, and digoxin are safe and recommended in AF with HFrEF. Diltiazem is also contraindicated in HFrEF.

---

## Question 3

A patient in the ED has rapid AF. On examination, you note a mid-diastolic murmur at the apex. Echo shows mitral stenosis. Which anticoagulant is preferred for stroke prevention?

- **A. Warfarin**
- B. Apixaban
- C. Rivaroxaban
- D. Dabigatran
- E. Aspirin alone

**Correct Answer:** A

**Explanation:**

Valvular AF (specifically mitral stenosis or prosthetic heart valves) is a DOAC contraindication. Warfarin remains the only approved anticoagulant for AF associated with moderate-to-severe mitral stenosis or mechanical heart valves. DOACs are only indicated for non-valvular AF.

---

## Question 4

A 60-year-old man presents with AF onset 36 hours ago. He is haemodynamically stable, rate 100bpm, BP 130/80. What is the safest approach before attempting cardioversion?

- **A. TOE-guided cardioversion or anticoagulate for 3 weeks first**
- B. Immediate DC cardioversion without anticoagulation
- C. Rate control only, no cardioversion needed
- D. Start anticoagulation and cardiovert in 24 hours
- E. Aspirin 300mg and cardiovert

**Correct Answer:** A

**Explanation:**

AF >48 hours (or unknown duration) carries risk of left atrial thrombus. NICE recommends either: (1) anticoagulate with therapeutic warfarin or DOAC for 3+ weeks before cardioversion, or (2) transoesophageal echocardiography (TOE) to exclude thrombus followed by immediate cardioversion. Post-cardioversion anticoagulation for 4+ weeks regardless.

---

## Question 5

Which scoring system is used to assess bleeding risk before initiating anticoagulation in AF?

- **A. HAS-BLED score**
- B. CHADS2-VASc score
- C. GRACE score
- D. TIMI score
- E. Wells score

**Correct Answer:** A

**Explanation:**

HAS-BLED scores bleeding risk in AF patients on anticoagulation: H=Hypertension(1), A=Abnormal renal/liver function(1-2), S=Stroke history(1), B=Bleeding history(1), L=Labile INR(1), E=Elderly >65(1), D=Drugs/alcohol(1-2). Score >=3 indicates high risk. It should not be used to withhold anticoagulation but to guide modifiable risk factor correction.
$SBAQ0002$,
        "position" = 210,
        "status" = 'published',
        "updated_at" = now()
      WHERE "id" = v_lesson_id;
    END IF;


    -- Quiz: Bradycardia - SBA Quiz (5 questions)
    SELECT id INTO v_lesson_id FROM "lessons"
    WHERE "module_id" = v_module_id AND "slug" = 'sba-quiz-bradycardia' AND "deleted_at" IS NULL LIMIT 1;
    IF v_lesson_id IS NULL THEN
      INSERT INTO "lessons" (
        "id", "module_id", "slug", "title", "type", "body",
        "is_free_preview", "position", "status", "created_at", "updated_at"
      ) VALUES (
        gen_random_uuid(), v_module_id, 'sba-quiz-bradycardia', 'Bradycardia - SBA Quiz', 'quiz',
        $SBAQ0003$# Bradycardia - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 72-year-old man presents with dizziness and near-syncope. HR 38bpm, BP 90/60, GCS 15. ECG shows complete heart block. What is the FIRST treatment?

- **A. IV atropine 500mcg**
- B. Transcutaneous pacing
- C. IV isoprenaline infusion
- D. IV adrenaline 1mg
- E. Permanent pacemaker insertion

**Correct Answer:** A

**Explanation:**

For haemodynamically significant bradycardia, IV atropine 500mcg is the first-line treatment per ALS/RCEM guidelines. It can be repeated up to 3mg total. If atropine is ineffective or in high-degree AV block, transcutaneous pacing is the next step. Transvenous pacing is used if transcutaneous pacing fails.

---

## Question 2

A 65-year-old man with complete heart block does not respond to two doses of atropine 500mcg. BP 75/50, HR 30. What is the next step?

- **A. Transcutaneous external pacing**
- B. IV adenosine
- C. IV amiodarone 300mg
- D. DC cardioversion
- E. Observation only

**Correct Answer:** A

**Explanation:**

When atropine fails in complete heart block, transcutaneous pacing (TCP) is the next step. TCP delivers electrical impulses through adhesive pads to the chest. It is painful in conscious patients (require IV analgesia/sedation). Seek expert help for urgent transvenous pacing if TCP fails or is not tolerated.

---

## Question 3

Which drug-induced bradycardia can be specifically reversed pharmacologically?

- **A. Beta-blocker toxicity with high-dose insulin therapy or glucagon**
- B. Digoxin toxicity with calcium gluconate
- C. Calcium channel blocker toxicity with atropine alone
- D. Amiodarone toxicity with sodium bicarbonate
- E. Organophosphate toxicity with flumazenil

**Correct Answer:** A

**Explanation:**

Beta-blocker overdose can be treated with glucagon 5-10mg IV (increases cAMP independent of beta-receptors) and high-dose insulin euglycaemic therapy (HIET). Digoxin toxicity is treated with Digifab (digoxin-specific antibody fragments). CCB toxicity also responds to HIET, calcium gluconate, and lipid emulsion therapy.

---

## Question 4

A 55-year-old woman with hypothyroidism presents with HR 42, BP 105/70, and increasing tiredness. ECG shows sinus bradycardia. What is the most important initial investigation?

- **A. Thyroid function tests (TFTs)**
- B. Troponin
- C. Echocardiogram
- D. Holter monitor
- E. Coronary angiography

**Correct Answer:** A

**Explanation:**

Hypothyroidism is a common and reversible cause of bradycardia. TFTs (TSH elevated, free T4 low in primary hypothyroidism) are the most important investigation. Other causes include sick sinus syndrome, AV block, inferior MI, increased vagal tone, and drugs (beta-blockers, digoxin, amiodarone).

---

## Question 5

In Wenckebach (Mobitz Type I) second-degree AV block, what is the characteristic ECG finding?

- **A. Progressive PR prolongation until a P wave is not conducted (dropped QRS)**
- B. Fixed PR interval with randomly dropped QRS
- C. Complete dissociation of P waves and QRS
- D. Widened QRS with LBBB morphology
- E. Delta waves with short PR interval

**Correct Answer:** A

**Explanation:**

Mobitz Type I (Wenckebach) shows progressive PR interval prolongation until a P wave is blocked (dropped QRS), then the cycle resets. It occurs at the AV node level and is usually benign - often seen in inferior MI or high vagal tone. Mobitz Type II has a fixed PR with suddenly dropped QRS and carries risk of progressing to complete heart block.
$SBAQ0003$,
        false, 220, 'published', now(), now()
      );
    ELSE
      UPDATE "lessons" SET
        "title" = 'Bradycardia - SBA Quiz',
        "type" = 'quiz',
        "body" = $SBAQ0003$# Bradycardia - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 72-year-old man presents with dizziness and near-syncope. HR 38bpm, BP 90/60, GCS 15. ECG shows complete heart block. What is the FIRST treatment?

- **A. IV atropine 500mcg**
- B. Transcutaneous pacing
- C. IV isoprenaline infusion
- D. IV adrenaline 1mg
- E. Permanent pacemaker insertion

**Correct Answer:** A

**Explanation:**

For haemodynamically significant bradycardia, IV atropine 500mcg is the first-line treatment per ALS/RCEM guidelines. It can be repeated up to 3mg total. If atropine is ineffective or in high-degree AV block, transcutaneous pacing is the next step. Transvenous pacing is used if transcutaneous pacing fails.

---

## Question 2

A 65-year-old man with complete heart block does not respond to two doses of atropine 500mcg. BP 75/50, HR 30. What is the next step?

- **A. Transcutaneous external pacing**
- B. IV adenosine
- C. IV amiodarone 300mg
- D. DC cardioversion
- E. Observation only

**Correct Answer:** A

**Explanation:**

When atropine fails in complete heart block, transcutaneous pacing (TCP) is the next step. TCP delivers electrical impulses through adhesive pads to the chest. It is painful in conscious patients (require IV analgesia/sedation). Seek expert help for urgent transvenous pacing if TCP fails or is not tolerated.

---

## Question 3

Which drug-induced bradycardia can be specifically reversed pharmacologically?

- **A. Beta-blocker toxicity with high-dose insulin therapy or glucagon**
- B. Digoxin toxicity with calcium gluconate
- C. Calcium channel blocker toxicity with atropine alone
- D. Amiodarone toxicity with sodium bicarbonate
- E. Organophosphate toxicity with flumazenil

**Correct Answer:** A

**Explanation:**

Beta-blocker overdose can be treated with glucagon 5-10mg IV (increases cAMP independent of beta-receptors) and high-dose insulin euglycaemic therapy (HIET). Digoxin toxicity is treated with Digifab (digoxin-specific antibody fragments). CCB toxicity also responds to HIET, calcium gluconate, and lipid emulsion therapy.

---

## Question 4

A 55-year-old woman with hypothyroidism presents with HR 42, BP 105/70, and increasing tiredness. ECG shows sinus bradycardia. What is the most important initial investigation?

- **A. Thyroid function tests (TFTs)**
- B. Troponin
- C. Echocardiogram
- D. Holter monitor
- E. Coronary angiography

**Correct Answer:** A

**Explanation:**

Hypothyroidism is a common and reversible cause of bradycardia. TFTs (TSH elevated, free T4 low in primary hypothyroidism) are the most important investigation. Other causes include sick sinus syndrome, AV block, inferior MI, increased vagal tone, and drugs (beta-blockers, digoxin, amiodarone).

---

## Question 5

In Wenckebach (Mobitz Type I) second-degree AV block, what is the characteristic ECG finding?

- **A. Progressive PR prolongation until a P wave is not conducted (dropped QRS)**
- B. Fixed PR interval with randomly dropped QRS
- C. Complete dissociation of P waves and QRS
- D. Widened QRS with LBBB morphology
- E. Delta waves with short PR interval

**Correct Answer:** A

**Explanation:**

Mobitz Type I (Wenckebach) shows progressive PR interval prolongation until a P wave is blocked (dropped QRS), then the cycle resets. It occurs at the AV node level and is usually benign - often seen in inferior MI or high vagal tone. Mobitz Type II has a fixed PR with suddenly dropped QRS and carries risk of progressing to complete heart block.
$SBAQ0003$,
        "position" = 220,
        "status" = 'published',
        "updated_at" = now()
      WHERE "id" = v_lesson_id;
    END IF;


    -- Quiz: Acute Coronary Syndrome - SBA Quiz (5 questions)
    SELECT id INTO v_lesson_id FROM "lessons"
    WHERE "module_id" = v_module_id AND "slug" = 'sba-quiz-acute-coronary-syndrome' AND "deleted_at" IS NULL LIMIT 1;
    IF v_lesson_id IS NULL THEN
      INSERT INTO "lessons" (
        "id", "module_id", "slug", "title", "type", "body",
        "is_free_preview", "position", "status", "created_at", "updated_at"
      ) VALUES (
        gen_random_uuid(), v_module_id, 'sba-quiz-acute-coronary-syndrome', 'Acute Coronary Syndrome - SBA Quiz', 'quiz',
        $SBAQ0004$# Acute Coronary Syndrome - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 58-year-old man presents with 2 hours of crushing central chest pain radiating to the left arm. ECG shows 3mm ST elevation in leads II, III, aVF. BP 110/70. What is the MOST urgent intervention?

- **A. Primary PCI (pPCI) within 120 minutes of first medical contact**
- B. IV thrombolysis with alteplase
- C. IV morphine and GTN spray
- D. Aspirin 300mg and wait for repeat ECG
- E. Urgent echocardiogram

**Correct Answer:** A

**Explanation:**

STEMI (inferior) requires immediate reperfusion. Primary PCI is the preferred strategy if achievable within 120 minutes of first medical contact (NICE NG185). Aspirin 300mg + ticagrelor/clopidogrel loading should be given immediately. Thrombolysis is given only if pPCI cannot be delivered within 120 minutes.

---

## Question 2

A 52-year-old woman presents with chest pain. Troponin at 0 hours is 12 ng/L (normal <14). Troponin at 3 hours is 52 ng/L. ECG shows no ST changes. What is the diagnosis and management?

- **A. NSTEMI - risk stratify with GRACE score and consider coronary angiography**
- B. Unstable angina - discharge with GTN spray
- C. STEMI equivalent - immediate pPCI
- D. Takotsubo cardiomyopathy - echo
- E. Aortic dissection - CT aortogram

**Correct Answer:** A

**Explanation:**

A rise in troponin (delta troponin) of >5 ng/L from 0h-1h or >3h confirms myocardial injury/NSTEMI. NSTEMI is managed with dual antiplatelet therapy, anticoagulation, and risk stratification using GRACE score. High GRACE score (>140) warrants in-hospital coronary angiography within 24h. Low-risk patients can be investigated electively.

---

## Question 3

Which of the following is a contraindication to thrombolysis in STEMI?

- **A. Haemorrhagic stroke within the last 3 months**
- B. Current antiplatelet therapy
- C. Age over 75 years
- D. Diabetes mellitus
- E. Anterior STEMI

**Correct Answer:** A

**Explanation:**

Absolute contraindications to thrombolysis include: prior haemorrhagic stroke (ever), ischaemic stroke within 3 months, active internal bleeding, known aortic dissection, severe uncontrolled hypertension (>180/110), and significant head trauma within 3 months. Relative contraindications include warfarin with high INR, prolonged CPR, and recent major surgery.

---

## Question 4

A patient with confirmed NSTEMI is on aspirin and ticagrelor. Which additional anticoagulant is recommended by NICE?

- **A. Fondaparinux 2.5mg SC**
- B. Unfractionated heparin IV infusion
- C. Enoxaparin 1mg/kg BD
- D. Warfarin loading
- E. Bivalirudin only for PCI

**Correct Answer:** A

**Explanation:**

NICE NG185 recommends fondaparinux 2.5mg SC as first-line anticoagulation in NSTEMI (unless immediate coronary angiography planned, in which case IV UFH or bivalirudin is used). Fondaparinux has shown superior outcomes vs enoxaparin with less bleeding in the OASIS-5 trial. Continue until revascularisation or for 8 days.

---

## Question 5

A 65-year-old man with STEMI is given aspirin 300mg. Which second antiplatelet agent should be given BEFORE primary PCI?

- **A. Ticagrelor 180mg loading dose**
- B. Clopidogrel 75mg
- C. Aspirin 150mg extra
- D. Prasugrel 60mg
- E. IV abciximab

**Correct Answer:** A

**Explanation:**

NICE NG185 recommends ticagrelor (180mg loading, then 90mg BD) as the preferred P2Y12 inhibitor for STEMI/NSTEMI. Prasugrel is an alternative for PCI if ticagrelor is contraindicated, but is contraindicated in prior stroke/TIA, age >75, or weight <60kg. Clopidogrel 600mg is used if ticagrelor/prasugrel are contraindicated.
$SBAQ0004$,
        false, 230, 'published', now(), now()
      );
    ELSE
      UPDATE "lessons" SET
        "title" = 'Acute Coronary Syndrome - SBA Quiz',
        "type" = 'quiz',
        "body" = $SBAQ0004$# Acute Coronary Syndrome - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 58-year-old man presents with 2 hours of crushing central chest pain radiating to the left arm. ECG shows 3mm ST elevation in leads II, III, aVF. BP 110/70. What is the MOST urgent intervention?

- **A. Primary PCI (pPCI) within 120 minutes of first medical contact**
- B. IV thrombolysis with alteplase
- C. IV morphine and GTN spray
- D. Aspirin 300mg and wait for repeat ECG
- E. Urgent echocardiogram

**Correct Answer:** A

**Explanation:**

STEMI (inferior) requires immediate reperfusion. Primary PCI is the preferred strategy if achievable within 120 minutes of first medical contact (NICE NG185). Aspirin 300mg + ticagrelor/clopidogrel loading should be given immediately. Thrombolysis is given only if pPCI cannot be delivered within 120 minutes.

---

## Question 2

A 52-year-old woman presents with chest pain. Troponin at 0 hours is 12 ng/L (normal <14). Troponin at 3 hours is 52 ng/L. ECG shows no ST changes. What is the diagnosis and management?

- **A. NSTEMI - risk stratify with GRACE score and consider coronary angiography**
- B. Unstable angina - discharge with GTN spray
- C. STEMI equivalent - immediate pPCI
- D. Takotsubo cardiomyopathy - echo
- E. Aortic dissection - CT aortogram

**Correct Answer:** A

**Explanation:**

A rise in troponin (delta troponin) of >5 ng/L from 0h-1h or >3h confirms myocardial injury/NSTEMI. NSTEMI is managed with dual antiplatelet therapy, anticoagulation, and risk stratification using GRACE score. High GRACE score (>140) warrants in-hospital coronary angiography within 24h. Low-risk patients can be investigated electively.

---

## Question 3

Which of the following is a contraindication to thrombolysis in STEMI?

- **A. Haemorrhagic stroke within the last 3 months**
- B. Current antiplatelet therapy
- C. Age over 75 years
- D. Diabetes mellitus
- E. Anterior STEMI

**Correct Answer:** A

**Explanation:**

Absolute contraindications to thrombolysis include: prior haemorrhagic stroke (ever), ischaemic stroke within 3 months, active internal bleeding, known aortic dissection, severe uncontrolled hypertension (>180/110), and significant head trauma within 3 months. Relative contraindications include warfarin with high INR, prolonged CPR, and recent major surgery.

---

## Question 4

A patient with confirmed NSTEMI is on aspirin and ticagrelor. Which additional anticoagulant is recommended by NICE?

- **A. Fondaparinux 2.5mg SC**
- B. Unfractionated heparin IV infusion
- C. Enoxaparin 1mg/kg BD
- D. Warfarin loading
- E. Bivalirudin only for PCI

**Correct Answer:** A

**Explanation:**

NICE NG185 recommends fondaparinux 2.5mg SC as first-line anticoagulation in NSTEMI (unless immediate coronary angiography planned, in which case IV UFH or bivalirudin is used). Fondaparinux has shown superior outcomes vs enoxaparin with less bleeding in the OASIS-5 trial. Continue until revascularisation or for 8 days.

---

## Question 5

A 65-year-old man with STEMI is given aspirin 300mg. Which second antiplatelet agent should be given BEFORE primary PCI?

- **A. Ticagrelor 180mg loading dose**
- B. Clopidogrel 75mg
- C. Aspirin 150mg extra
- D. Prasugrel 60mg
- E. IV abciximab

**Correct Answer:** A

**Explanation:**

NICE NG185 recommends ticagrelor (180mg loading, then 90mg BD) as the preferred P2Y12 inhibitor for STEMI/NSTEMI. Prasugrel is an alternative for PCI if ticagrelor is contraindicated, but is contraindicated in prior stroke/TIA, age >75, or weight <60kg. Clopidogrel 600mg is used if ticagrelor/prasugrel are contraindicated.
$SBAQ0004$,
        "position" = 230,
        "status" = 'published',
        "updated_at" = now()
      WHERE "id" = v_lesson_id;
    END IF;


    -- Quiz: Hypertensive Emergency - SBA Quiz (5 questions)
    SELECT id INTO v_lesson_id FROM "lessons"
    WHERE "module_id" = v_module_id AND "slug" = 'sba-quiz-hypertensive-emergency' AND "deleted_at" IS NULL LIMIT 1;
    IF v_lesson_id IS NULL THEN
      INSERT INTO "lessons" (
        "id", "module_id", "slug", "title", "type", "body",
        "is_free_preview", "position", "status", "created_at", "updated_at"
      ) VALUES (
        gen_random_uuid(), v_module_id, 'sba-quiz-hypertensive-emergency', 'Hypertensive Emergency - SBA Quiz', 'quiz',
        $SBAQ0005$# Hypertensive Emergency - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 55-year-old woman presents with BP 220/130, severe headache, papilloedema, and creatinine 250 umol/L (baseline 90). What is the target for BP reduction in the first hour?

- **A. Reduce by no more than 20-25% in the first hour**
- B. Reduce to <120/80 immediately
- C. Reduce diastolic to <90 within 30 minutes
- D. Reduce to <140/90 within 6 hours
- E. No treatment - wait for repeat measurement

**Correct Answer:** A

**Explanation:**

Hypertensive emergency (end-organ damage) requires careful BP reduction. Reducing BP too rapidly risks cerebral hypoperfusion, watershed infarcts, and worsening renal function. Guidelines recommend reducing mean arterial pressure by 20-25% in the first hour, then gradually to 160/100 over the next 2-6 hours, using IV agents like labetalol, nicardipine, or sodium nitroprusside.

---

## Question 2

A 42-year-old pregnant woman at 36 weeks gestation presents with BP 165/112, headache, and proteinuria 3+. Reflexes are brisk. What is the drug of first choice for acute BP control?

- **A. IV labetalol**
- B. IV sodium nitroprusside
- C. Oral nifedipine MR
- D. IV hydralazine
- E. Oral methyldopa

**Correct Answer:** A

**Explanation:**

Severe pre-eclampsia with BP >160/110 requires urgent treatment. IV labetalol is first-line in the UK for acute hypertension in pre-eclampsia. Oral nifedipine (immediate release) is an alternative. Sodium nitroprusside is contraindicated in pregnancy (cyanide toxicity to fetus). Magnesium sulphate is given for seizure prophylaxis/eclampsia, not for BP control.

---

## Question 3

A 68-year-old man with hypertensive emergency is started on IV sodium nitroprusside. After 24 hours, he develops confusion and metabolic acidosis. What is the likely cause?

- **A. Cyanide toxicity**
- B. Reflex tachycardia
- C. Hypertensive encephalopathy
- D. Hyperkalaemia from renal failure
- E. Cerebrovascular accident

**Correct Answer:** A

**Explanation:**

Sodium nitroprusside is metabolised to cyanide, which inhibits mitochondrial cytochrome oxidase. Prolonged infusion (>24-48h) or high doses can cause cyanide toxicity: metabolic lactic acidosis, confusion, tachycardia, and seizures. Treatment is with hydroxocobalamin or dicobalt edetate. Dose should be kept minimal and use avoided in renal/hepatic impairment.

---

## Question 4

A 60-year-old man presents with acute aortic dissection (Type A) and BP 190/115. Which is the most appropriate INITIAL management of blood pressure?

- **A. IV labetalol to target systolic 100-120 mmHg**
- B. IV sodium nitroprusside alone
- C. Oral amlodipine
- D. IV nicardipine alone
- E. No antihypertensive - surgery first

**Correct Answer:** A

**Explanation:**

In acute aortic dissection, BP and heart rate control are critical to reduce aortic wall stress. Target systolic 100-120 mmHg and HR <60bpm before surgery. IV labetalol (alpha+beta blocker) is preferred as it reduces both. If pure vasodilators like nitroprusside are used alone, reflex tachycardia increases aortic shear stress - always add a beta-blocker first.

---

## Question 5

A 52-year-old man presents with hypertensive emergency and features of acute pulmonary oedema (BP 210/125, SpO2 88% on air, bilateral crackles). What is the preferred BP-lowering agent?

- **A. IV glyceryl trinitrate (GTN) infusion**
- B. IV labetalol
- C. IV furosemide alone
- D. IV sodium nitroprusside
- E. Oral amlodipine

**Correct Answer:** A

**Explanation:**

In hypertensive emergency with acute pulmonary oedema, IV GTN (nitrate) is the preferred agent as it reduces preload and afterload, relieving pulmonary congestion. Start at 1-2 mg/hour and titrate. IV furosemide alone is insufficient for rapid BP control. Labetalol can worsen heart failure. NIV (BiPAP) should also be initiated for respiratory support.
$SBAQ0005$,
        false, 240, 'published', now(), now()
      );
    ELSE
      UPDATE "lessons" SET
        "title" = 'Hypertensive Emergency - SBA Quiz',
        "type" = 'quiz',
        "body" = $SBAQ0005$# Hypertensive Emergency - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 55-year-old woman presents with BP 220/130, severe headache, papilloedema, and creatinine 250 umol/L (baseline 90). What is the target for BP reduction in the first hour?

- **A. Reduce by no more than 20-25% in the first hour**
- B. Reduce to <120/80 immediately
- C. Reduce diastolic to <90 within 30 minutes
- D. Reduce to <140/90 within 6 hours
- E. No treatment - wait for repeat measurement

**Correct Answer:** A

**Explanation:**

Hypertensive emergency (end-organ damage) requires careful BP reduction. Reducing BP too rapidly risks cerebral hypoperfusion, watershed infarcts, and worsening renal function. Guidelines recommend reducing mean arterial pressure by 20-25% in the first hour, then gradually to 160/100 over the next 2-6 hours, using IV agents like labetalol, nicardipine, or sodium nitroprusside.

---

## Question 2

A 42-year-old pregnant woman at 36 weeks gestation presents with BP 165/112, headache, and proteinuria 3+. Reflexes are brisk. What is the drug of first choice for acute BP control?

- **A. IV labetalol**
- B. IV sodium nitroprusside
- C. Oral nifedipine MR
- D. IV hydralazine
- E. Oral methyldopa

**Correct Answer:** A

**Explanation:**

Severe pre-eclampsia with BP >160/110 requires urgent treatment. IV labetalol is first-line in the UK for acute hypertension in pre-eclampsia. Oral nifedipine (immediate release) is an alternative. Sodium nitroprusside is contraindicated in pregnancy (cyanide toxicity to fetus). Magnesium sulphate is given for seizure prophylaxis/eclampsia, not for BP control.

---

## Question 3

A 68-year-old man with hypertensive emergency is started on IV sodium nitroprusside. After 24 hours, he develops confusion and metabolic acidosis. What is the likely cause?

- **A. Cyanide toxicity**
- B. Reflex tachycardia
- C. Hypertensive encephalopathy
- D. Hyperkalaemia from renal failure
- E. Cerebrovascular accident

**Correct Answer:** A

**Explanation:**

Sodium nitroprusside is metabolised to cyanide, which inhibits mitochondrial cytochrome oxidase. Prolonged infusion (>24-48h) or high doses can cause cyanide toxicity: metabolic lactic acidosis, confusion, tachycardia, and seizures. Treatment is with hydroxocobalamin or dicobalt edetate. Dose should be kept minimal and use avoided in renal/hepatic impairment.

---

## Question 4

A 60-year-old man presents with acute aortic dissection (Type A) and BP 190/115. Which is the most appropriate INITIAL management of blood pressure?

- **A. IV labetalol to target systolic 100-120 mmHg**
- B. IV sodium nitroprusside alone
- C. Oral amlodipine
- D. IV nicardipine alone
- E. No antihypertensive - surgery first

**Correct Answer:** A

**Explanation:**

In acute aortic dissection, BP and heart rate control are critical to reduce aortic wall stress. Target systolic 100-120 mmHg and HR <60bpm before surgery. IV labetalol (alpha+beta blocker) is preferred as it reduces both. If pure vasodilators like nitroprusside are used alone, reflex tachycardia increases aortic shear stress - always add a beta-blocker first.

---

## Question 5

A 52-year-old man presents with hypertensive emergency and features of acute pulmonary oedema (BP 210/125, SpO2 88% on air, bilateral crackles). What is the preferred BP-lowering agent?

- **A. IV glyceryl trinitrate (GTN) infusion**
- B. IV labetalol
- C. IV furosemide alone
- D. IV sodium nitroprusside
- E. Oral amlodipine

**Correct Answer:** A

**Explanation:**

In hypertensive emergency with acute pulmonary oedema, IV GTN (nitrate) is the preferred agent as it reduces preload and afterload, relieving pulmonary congestion. Start at 1-2 mg/hour and titrate. IV furosemide alone is insufficient for rapid BP control. Labetalol can worsen heart failure. NIV (BiPAP) should also be initiated for respiratory support.
$SBAQ0005$,
        "position" = 240,
        "status" = 'published',
        "updated_at" = now()
      WHERE "id" = v_lesson_id;
    END IF;


    -- Quiz: Ventricular Tachycardia - SBA Quiz (5 questions)
    SELECT id INTO v_lesson_id FROM "lessons"
    WHERE "module_id" = v_module_id AND "slug" = 'sba-quiz-ventricular-tachycardia' AND "deleted_at" IS NULL LIMIT 1;
    IF v_lesson_id IS NULL THEN
      INSERT INTO "lessons" (
        "id", "module_id", "slug", "title", "type", "body",
        "is_free_preview", "position", "status", "created_at", "updated_at"
      ) VALUES (
        gen_random_uuid(), v_module_id, 'sba-quiz-ventricular-tachycardia', 'Ventricular Tachycardia - SBA Quiz', 'quiz',
        $SBAQ0006$# Ventricular Tachycardia - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 60-year-old man with known ischaemic cardiomyopathy presents with a regular broad complex tachycardia at 170bpm. BP 90/60. What is the immediate management?

- **A. Synchronised DC cardioversion 150J biphasic**
- B. IV adenosine 6mg rapid bolus
- C. IV verapamil 5mg
- D. Amiodarone 300mg over 60 minutes
- E. Chest compressions

**Correct Answer:** A

**Explanation:**

Haemodynamically unstable VT (broad complex tachycardia with haemodynamic compromise) requires immediate synchronised DC cardioversion. Never use AV nodal blocking drugs (adenosine, verapamil) for broad complex tachycardia of unknown origin as they can cause VF. Amiodarone is used for haemodynamically stable VT.

---

## Question 2

A 55-year-old woman presents with regular broad complex tachycardia at 160bpm, BP 130/80, GCS 15. She is haemodynamically stable. What is the first-line pharmacological treatment?

- **A. IV amiodarone 300mg over 20-60 minutes**
- B. IV adenosine 6mg
- C. IV verapamil 5mg
- D. IV lidocaine 100mg
- E. IV magnesium sulphate 8mmol

**Correct Answer:** A

**Explanation:**

For haemodynamically stable broad complex tachycardia (presumed VT), IV amiodarone 300mg over 20-60 minutes is first-line (ALS/RCEM). Lidocaine can be used as an alternative (100mg IV over 2 minutes). Adenosine can be considered if SVT with aberrancy is suspected, but should be avoided in known cardiac disease. Magnesium is first-line for Torsades de Pointes.

---

## Question 3

A patient develops pulseless VT during cardiac monitoring. What is the immediate action?

- **A. Unsynchronised defibrillation (defibrillation) 150-200J biphasic**
- B. Synchronised cardioversion
- C. IV amiodarone 300mg
- D. IV lidocaine 1mg/kg
- E. Precordial thump

**Correct Answer:** A

**Explanation:**

Pulseless VT is treated as VF - immediate unsynchronised defibrillation (not synchronised cardioversion, as synchronisation may fail to detect QRS). Follow ALS algorithm: defibrillate -> CPR 2 minutes -> reassess. Amiodarone 300mg IV is given after the 3rd shock. The precordial thump is no longer routinely recommended.

---

## Question 4

A patient in VT is given IV amiodarone without response. ECG now shows VT with a twisting morphology around the isoelectric baseline. What is the next treatment?

- **A. IV magnesium sulphate 8mmol over 15 minutes**
- B. IV adenosine 12mg
- C. Increase amiodarone dose
- D. DC cardioversion 150J
- E. IV verapamil 5mg

**Correct Answer:** A

**Explanation:**

Torsades de Pointes (TdP) is a polymorphic VT associated with a prolonged QT interval - the QRS complexes appear to 'twist' around the baseline. First-line treatment is IV magnesium sulphate 8mmol (2g) over 10-15 minutes, even in normomagnesaemic patients. Stop all QT-prolonging drugs. Correct electrolytes. If recurrent, overdrive pacing may be needed.

---

## Question 5

In which condition is implantable cardioverter-defibrillator (ICD) implantation indicated for primary prevention of sudden cardiac death?

- **A. LVEF <35% on optimised medical therapy**
- B. Paroxysmal AF with normal LVEF
- C. History of sustained SVT
- D. LQTS with normal QTc on drug treatment
- E. Hypertensive heart disease with LVH only

**Correct Answer:** A

**Explanation:**

ICD for primary prevention is indicated in patients with LVEF <35% (heart failure with reduced ejection fraction) on optimised medical therapy (ACE inhibitor/ARB + beta-blocker + mineralocorticoid receptor antagonist) who are expected to survive >1 year with good functional status (NICE TA314). This applies to both ischaemic and non-ischaemic cardiomyopathy.
$SBAQ0006$,
        false, 250, 'published', now(), now()
      );
    ELSE
      UPDATE "lessons" SET
        "title" = 'Ventricular Tachycardia - SBA Quiz',
        "type" = 'quiz',
        "body" = $SBAQ0006$# Ventricular Tachycardia - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 60-year-old man with known ischaemic cardiomyopathy presents with a regular broad complex tachycardia at 170bpm. BP 90/60. What is the immediate management?

- **A. Synchronised DC cardioversion 150J biphasic**
- B. IV adenosine 6mg rapid bolus
- C. IV verapamil 5mg
- D. Amiodarone 300mg over 60 minutes
- E. Chest compressions

**Correct Answer:** A

**Explanation:**

Haemodynamically unstable VT (broad complex tachycardia with haemodynamic compromise) requires immediate synchronised DC cardioversion. Never use AV nodal blocking drugs (adenosine, verapamil) for broad complex tachycardia of unknown origin as they can cause VF. Amiodarone is used for haemodynamically stable VT.

---

## Question 2

A 55-year-old woman presents with regular broad complex tachycardia at 160bpm, BP 130/80, GCS 15. She is haemodynamically stable. What is the first-line pharmacological treatment?

- **A. IV amiodarone 300mg over 20-60 minutes**
- B. IV adenosine 6mg
- C. IV verapamil 5mg
- D. IV lidocaine 100mg
- E. IV magnesium sulphate 8mmol

**Correct Answer:** A

**Explanation:**

For haemodynamically stable broad complex tachycardia (presumed VT), IV amiodarone 300mg over 20-60 minutes is first-line (ALS/RCEM). Lidocaine can be used as an alternative (100mg IV over 2 minutes). Adenosine can be considered if SVT with aberrancy is suspected, but should be avoided in known cardiac disease. Magnesium is first-line for Torsades de Pointes.

---

## Question 3

A patient develops pulseless VT during cardiac monitoring. What is the immediate action?

- **A. Unsynchronised defibrillation (defibrillation) 150-200J biphasic**
- B. Synchronised cardioversion
- C. IV amiodarone 300mg
- D. IV lidocaine 1mg/kg
- E. Precordial thump

**Correct Answer:** A

**Explanation:**

Pulseless VT is treated as VF - immediate unsynchronised defibrillation (not synchronised cardioversion, as synchronisation may fail to detect QRS). Follow ALS algorithm: defibrillate -> CPR 2 minutes -> reassess. Amiodarone 300mg IV is given after the 3rd shock. The precordial thump is no longer routinely recommended.

---

## Question 4

A patient in VT is given IV amiodarone without response. ECG now shows VT with a twisting morphology around the isoelectric baseline. What is the next treatment?

- **A. IV magnesium sulphate 8mmol over 15 minutes**
- B. IV adenosine 12mg
- C. Increase amiodarone dose
- D. DC cardioversion 150J
- E. IV verapamil 5mg

**Correct Answer:** A

**Explanation:**

Torsades de Pointes (TdP) is a polymorphic VT associated with a prolonged QT interval - the QRS complexes appear to 'twist' around the baseline. First-line treatment is IV magnesium sulphate 8mmol (2g) over 10-15 minutes, even in normomagnesaemic patients. Stop all QT-prolonging drugs. Correct electrolytes. If recurrent, overdrive pacing may be needed.

---

## Question 5

In which condition is implantable cardioverter-defibrillator (ICD) implantation indicated for primary prevention of sudden cardiac death?

- **A. LVEF <35% on optimised medical therapy**
- B. Paroxysmal AF with normal LVEF
- C. History of sustained SVT
- D. LQTS with normal QTc on drug treatment
- E. Hypertensive heart disease with LVH only

**Correct Answer:** A

**Explanation:**

ICD for primary prevention is indicated in patients with LVEF <35% (heart failure with reduced ejection fraction) on optimised medical therapy (ACE inhibitor/ARB + beta-blocker + mineralocorticoid receptor antagonist) who are expected to survive >1 year with good functional status (NICE TA314). This applies to both ischaemic and non-ischaemic cardiomyopathy.
$SBAQ0006$,
        "position" = 250,
        "status" = 'published',
        "updated_at" = now()
      WHERE "id" = v_lesson_id;
    END IF;

  END IF;  -- end module check


  -- =========================================================================
  -- Module: Resuscitation & Critical Care
  -- =========================================================================
  SELECT id INTO v_module_id FROM "modules"
  WHERE "course_id" = v_course_id AND "title" = 'Resuscitation & Critical Care' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    RAISE WARNING 'Module % not found in mrcem-sba, skipping...', 'Resuscitation & Critical Care';
  ELSE


    -- Quiz: Advanced Life Support - SBA Quiz (5 questions)
    SELECT id INTO v_lesson_id FROM "lessons"
    WHERE "module_id" = v_module_id AND "slug" = 'sba-quiz-advanced-life-support' AND "deleted_at" IS NULL LIMIT 1;
    IF v_lesson_id IS NULL THEN
      INSERT INTO "lessons" (
        "id", "module_id", "slug", "title", "type", "body",
        "is_free_preview", "position", "status", "created_at", "updated_at"
      ) VALUES (
        gen_random_uuid(), v_module_id, 'sba-quiz-advanced-life-support', 'Advanced Life Support - SBA Quiz', 'quiz',
        $SBAQ0007$# Advanced Life Support - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

An adult patient in cardiac arrest. The rhythm is VF. CPR is ongoing. What is the correct sequence for defibrillation?

- **A. Defibrillate -> 2 min CPR -> reassess -> repeat if shockable**
- B. Defibrillate -> check pulse immediately -> defibrillate again if VF
- C. CPR 2 min -> defibrillate -> adrenaline -> check pulse
- D. 3 stacked shocks -> CPR 2 min -> adrenaline
- E. Defibrillate -> IV amiodarone -> CPR 1 min

**Correct Answer:** A

**Explanation:**

ALS algorithm (Resuscitation Council UK 2021): Defibrillate once (150-360J biphasic) -> immediately resume CPR for 2 minutes -> reassess rhythm. If still shockable, defibrillate again. Adrenaline 1mg IV given after the 3rd shock then every 3-5 minutes. Amiodarone 300mg given after 3rd shock for VF/pVT. Never stack shocks or check pulse immediately after defibrillation.

---

## Question 2

After the 3rd defibrillation in refractory VF, what drugs should be given?

- **A. Adrenaline 1mg IV + amiodarone 300mg IV**
- B. Adrenaline 1mg + lidocaine 100mg
- C. Atropine 3mg + adrenaline 1mg
- D. Amiodarone 300mg alone
- E. Magnesium sulphate 8mmol + adrenaline

**Correct Answer:** A

**Explanation:**

After the 3rd shock, give adrenaline 1mg IV (repeat every 3-5 min throughout) AND amiodarone 300mg IV as an anti-arrhythmic. A further dose of amiodarone 150mg can be given after the 5th shock. Lidocaine 100mg is an alternative if amiodarone is unavailable. Atropine is no longer recommended in cardiac arrest.

---

## Question 3

A patient is in PEA (pulseless electrical activity) arrest. What are the reversible causes to address?

- **A. 4Hs and 4Ts: Hypoxia, Hypovolaemia, Hypo/hyperkalaemia, Hypothermia; Tension pneumothorax, Tamponade, Thrombosis, Toxins**
- B. Hyperglycaemia, Hypertension, Hyperthermia, Haemorrhage; Toxins, Tracheal obstruction, Thromboembolism, Trauma
- C. VF, VT, PEA, Asystole
- D. ABCDE approach only
- E. Atropine, Adrenaline, Amiodarone, Adenosine

**Correct Answer:** A

**Explanation:**

The Resuscitation Council UK mandates addressing reversible causes during cardiac arrest: 4Hs (Hypoxia, Hypovolaemia, Hypo/Hyperkalaemia & metabolic, Hypothermia) and 4Ts (Tension pneumothorax, Tamponade cardiac, Thrombosis pulmonary/coronary, Toxins). These are especially important in PEA and asystole where there is no shockable rhythm.

---

## Question 4

A 70kg adult has VF refractory to 5 defibrillations and two doses of adrenaline. What additional intervention should be considered?

- **A. Mechanical CPR device + consider extracorporeal CPR (ECPR) if available**
- B. Increase defibrillation energy to maximum 720J
- C. Stop resuscitation after 30 minutes
- D. IV calcium gluconate 10ml 10%
- E. IV magnesium 8mmol + lidocaine

**Correct Answer:** A

**Explanation:**

Refractory cardiac arrest (VF persisting after >3 shocks) warrants consideration of ECPR (extracorporeal CPR using ECMO) in appropriate settings and patient selection. Mechanical CPR devices (LUCAS, AutoPulse) provide consistent compressions. Consider reversible causes. Amiodarone, lidocaine, magnesium for TdP should be used. Double sequential defibrillation is being studied but not standard.

---

## Question 5

What is the correct compression rate and depth for adult CPR?

- **A. 100-120 compressions/min, 5-6 cm depth**
- B. 80-100 compressions/min, 4-5 cm depth
- C. 120-140 compressions/min, 6-7 cm depth
- D. 60-80 compressions/min, 3-4 cm depth
- E. 100-120 compressions/min, 7-8 cm depth

**Correct Answer:** A

**Explanation:**

Resuscitation Council UK 2021 guidelines: Adult CPR should deliver 100-120 chest compressions per minute at a depth of 5-6 cm (not exceeding 6 cm). Allow full chest recoil between compressions. Compression:ventilation ratio 30:2. Once advanced airway placed, ventilate at 10 breaths/min continuously without interrupting compressions.
$SBAQ0007$,
        false, 200, 'published', now(), now()
      );
    ELSE
      UPDATE "lessons" SET
        "title" = 'Advanced Life Support - SBA Quiz',
        "type" = 'quiz',
        "body" = $SBAQ0007$# Advanced Life Support - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

An adult patient in cardiac arrest. The rhythm is VF. CPR is ongoing. What is the correct sequence for defibrillation?

- **A. Defibrillate -> 2 min CPR -> reassess -> repeat if shockable**
- B. Defibrillate -> check pulse immediately -> defibrillate again if VF
- C. CPR 2 min -> defibrillate -> adrenaline -> check pulse
- D. 3 stacked shocks -> CPR 2 min -> adrenaline
- E. Defibrillate -> IV amiodarone -> CPR 1 min

**Correct Answer:** A

**Explanation:**

ALS algorithm (Resuscitation Council UK 2021): Defibrillate once (150-360J biphasic) -> immediately resume CPR for 2 minutes -> reassess rhythm. If still shockable, defibrillate again. Adrenaline 1mg IV given after the 3rd shock then every 3-5 minutes. Amiodarone 300mg given after 3rd shock for VF/pVT. Never stack shocks or check pulse immediately after defibrillation.

---

## Question 2

After the 3rd defibrillation in refractory VF, what drugs should be given?

- **A. Adrenaline 1mg IV + amiodarone 300mg IV**
- B. Adrenaline 1mg + lidocaine 100mg
- C. Atropine 3mg + adrenaline 1mg
- D. Amiodarone 300mg alone
- E. Magnesium sulphate 8mmol + adrenaline

**Correct Answer:** A

**Explanation:**

After the 3rd shock, give adrenaline 1mg IV (repeat every 3-5 min throughout) AND amiodarone 300mg IV as an anti-arrhythmic. A further dose of amiodarone 150mg can be given after the 5th shock. Lidocaine 100mg is an alternative if amiodarone is unavailable. Atropine is no longer recommended in cardiac arrest.

---

## Question 3

A patient is in PEA (pulseless electrical activity) arrest. What are the reversible causes to address?

- **A. 4Hs and 4Ts: Hypoxia, Hypovolaemia, Hypo/hyperkalaemia, Hypothermia; Tension pneumothorax, Tamponade, Thrombosis, Toxins**
- B. Hyperglycaemia, Hypertension, Hyperthermia, Haemorrhage; Toxins, Tracheal obstruction, Thromboembolism, Trauma
- C. VF, VT, PEA, Asystole
- D. ABCDE approach only
- E. Atropine, Adrenaline, Amiodarone, Adenosine

**Correct Answer:** A

**Explanation:**

The Resuscitation Council UK mandates addressing reversible causes during cardiac arrest: 4Hs (Hypoxia, Hypovolaemia, Hypo/Hyperkalaemia & metabolic, Hypothermia) and 4Ts (Tension pneumothorax, Tamponade cardiac, Thrombosis pulmonary/coronary, Toxins). These are especially important in PEA and asystole where there is no shockable rhythm.

---

## Question 4

A 70kg adult has VF refractory to 5 defibrillations and two doses of adrenaline. What additional intervention should be considered?

- **A. Mechanical CPR device + consider extracorporeal CPR (ECPR) if available**
- B. Increase defibrillation energy to maximum 720J
- C. Stop resuscitation after 30 minutes
- D. IV calcium gluconate 10ml 10%
- E. IV magnesium 8mmol + lidocaine

**Correct Answer:** A

**Explanation:**

Refractory cardiac arrest (VF persisting after >3 shocks) warrants consideration of ECPR (extracorporeal CPR using ECMO) in appropriate settings and patient selection. Mechanical CPR devices (LUCAS, AutoPulse) provide consistent compressions. Consider reversible causes. Amiodarone, lidocaine, magnesium for TdP should be used. Double sequential defibrillation is being studied but not standard.

---

## Question 5

What is the correct compression rate and depth for adult CPR?

- **A. 100-120 compressions/min, 5-6 cm depth**
- B. 80-100 compressions/min, 4-5 cm depth
- C. 120-140 compressions/min, 6-7 cm depth
- D. 60-80 compressions/min, 3-4 cm depth
- E. 100-120 compressions/min, 7-8 cm depth

**Correct Answer:** A

**Explanation:**

Resuscitation Council UK 2021 guidelines: Adult CPR should deliver 100-120 chest compressions per minute at a depth of 5-6 cm (not exceeding 6 cm). Allow full chest recoil between compressions. Compression:ventilation ratio 30:2. Once advanced airway placed, ventilate at 10 breaths/min continuously without interrupting compressions.
$SBAQ0007$,
        "position" = 200,
        "status" = 'published',
        "updated_at" = now()
      WHERE "id" = v_lesson_id;
    END IF;


    -- Quiz: Sepsis Management - SBA Quiz (5 questions)
    SELECT id INTO v_lesson_id FROM "lessons"
    WHERE "module_id" = v_module_id AND "slug" = 'sba-quiz-sepsis-management' AND "deleted_at" IS NULL LIMIT 1;
    IF v_lesson_id IS NULL THEN
      INSERT INTO "lessons" (
        "id", "module_id", "slug", "title", "type", "body",
        "is_free_preview", "position", "status", "created_at", "updated_at"
      ) VALUES (
        gen_random_uuid(), v_module_id, 'sba-quiz-sepsis-management', 'Sepsis Management - SBA Quiz', 'quiz',
        $SBAQ0008$# Sepsis Management - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 68-year-old woman presents with confusion, temperature 38.8C, HR 115, RR 24, BP 88/52. Lactate 3.8 mmol/L. Urine dipstick shows nitrites and leucocytes. Which is the single most time-critical intervention?

- **A. IV broad-spectrum antibiotics within 1 hour**
- B. IV fluid 30ml/kg crystalloid
- C. Blood cultures x2 sets
- D. Urinary catheter for urine output monitoring
- E. Vasopressors (noradrenaline)

**Correct Answer:** A

**Explanation:**

In septic shock, antibiotic administration within 1 hour of recognition is the highest priority intervention. Every hour of delay in antibiotic administration in septic shock is associated with a significant increase in mortality. Blood cultures should be taken before antibiotics but should not delay antibiotic administration by more than 45 minutes (Surviving Sepsis Campaign).

---

## Question 2

Following initial fluid resuscitation of 30ml/kg crystalloid for septic shock, the patient remains hypotensive (MAP 62 mmHg). What is the next intervention?

- **A. Start noradrenaline (norepinephrine) via central/intraosseous access**
- B. Give another 30ml/kg fluid bolus
- C. IV hydrocortisone 100mg
- D. IV vasopressin 0.03 units/min
- E. IV dobutamine

**Correct Answer:** A

**Explanation:**

If hypotension persists after adequate fluid resuscitation, vasopressors should be started to maintain MAP >65 mmHg. Noradrenaline (norepinephrine) is the first-line vasopressor in septic shock (Surviving Sepsis Campaign). Vasopressin or adrenaline can be added as second-line. Dobutamine is used for cardiogenic shock or as an inotrope in septic shock with reduced cardiac output.

---

## Question 3

The UK Sepsis Trust (2016) defines the 'Sepsis 6' bundle. Which of the following is NOT part of the Sepsis 6?

- **A. Perform CT chest**
- B. Administer high-flow oxygen
- C. Take blood cultures
- D. Give IV antibiotics
- E. Measure serum lactate

**Correct Answer:** A

**Explanation:**

The Sepsis 6 (complete within 1 hour): (1) Administer high-flow O2, (2) Take blood cultures, (3) Give IV antibiotics, (4) Give IV fluid (500ml crystalloid bolus), (5) Check lactate/FBC, (6) Measure urine output (catheterise). CT chest is not part of the Sepsis 6 but may be required to identify source.

---

## Question 4

A 45-year-old immunocompromised patient presents with neutropenic sepsis. Which antibiotic regimen is recommended?

- **A. IV piperacillin-tazobactam 4.5g 8-hourly**
- B. IV amoxicillin 1g + gentamicin
- C. Oral co-amoxiclav 625mg
- D. IV cefuroxime 1.5g
- E. IV vancomycin alone

**Correct Answer:** A

**Explanation:**

NICE NG151 recommends prompt IV beta-lactam with antipseudomonal activity for neutropenic sepsis. Piperacillin-tazobactam (Tazocin) 4.5g IV 8-hourly is the standard first-line agent. Meropenem is an alternative for high-risk patients. Vancomycin is added if MRSA is suspected or if PICC/Hickman line infection. Aminoglycosides avoided in renal impairment.

---

## Question 5

What lactate level defines septic shock in the Sepsis-3 definition?

- **A. Lactate >2 mmol/L despite adequate fluid resuscitation**
- B. Lactate >4 mmol/L
- C. Lactate >1 mmol/L with hypotension
- D. Lactate >3 mmol/L
- E. Any elevated lactate with fever

**Correct Answer:** A

**Explanation:**

Sepsis-3 (JAMA 2016) defines septic shock as a subset of sepsis with: (1) vasopressor requirement to maintain MAP >65 mmHg AND (2) lactate >2 mmol/L despite adequate fluid resuscitation, in the absence of hypovolaemia. This combination is associated with >40% hospital mortality. Lactate >4 mmol/L indicates severe hypoperfusion.
$SBAQ0008$,
        false, 210, 'published', now(), now()
      );
    ELSE
      UPDATE "lessons" SET
        "title" = 'Sepsis Management - SBA Quiz',
        "type" = 'quiz',
        "body" = $SBAQ0008$# Sepsis Management - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 68-year-old woman presents with confusion, temperature 38.8C, HR 115, RR 24, BP 88/52. Lactate 3.8 mmol/L. Urine dipstick shows nitrites and leucocytes. Which is the single most time-critical intervention?

- **A. IV broad-spectrum antibiotics within 1 hour**
- B. IV fluid 30ml/kg crystalloid
- C. Blood cultures x2 sets
- D. Urinary catheter for urine output monitoring
- E. Vasopressors (noradrenaline)

**Correct Answer:** A

**Explanation:**

In septic shock, antibiotic administration within 1 hour of recognition is the highest priority intervention. Every hour of delay in antibiotic administration in septic shock is associated with a significant increase in mortality. Blood cultures should be taken before antibiotics but should not delay antibiotic administration by more than 45 minutes (Surviving Sepsis Campaign).

---

## Question 2

Following initial fluid resuscitation of 30ml/kg crystalloid for septic shock, the patient remains hypotensive (MAP 62 mmHg). What is the next intervention?

- **A. Start noradrenaline (norepinephrine) via central/intraosseous access**
- B. Give another 30ml/kg fluid bolus
- C. IV hydrocortisone 100mg
- D. IV vasopressin 0.03 units/min
- E. IV dobutamine

**Correct Answer:** A

**Explanation:**

If hypotension persists after adequate fluid resuscitation, vasopressors should be started to maintain MAP >65 mmHg. Noradrenaline (norepinephrine) is the first-line vasopressor in septic shock (Surviving Sepsis Campaign). Vasopressin or adrenaline can be added as second-line. Dobutamine is used for cardiogenic shock or as an inotrope in septic shock with reduced cardiac output.

---

## Question 3

The UK Sepsis Trust (2016) defines the 'Sepsis 6' bundle. Which of the following is NOT part of the Sepsis 6?

- **A. Perform CT chest**
- B. Administer high-flow oxygen
- C. Take blood cultures
- D. Give IV antibiotics
- E. Measure serum lactate

**Correct Answer:** A

**Explanation:**

The Sepsis 6 (complete within 1 hour): (1) Administer high-flow O2, (2) Take blood cultures, (3) Give IV antibiotics, (4) Give IV fluid (500ml crystalloid bolus), (5) Check lactate/FBC, (6) Measure urine output (catheterise). CT chest is not part of the Sepsis 6 but may be required to identify source.

---

## Question 4

A 45-year-old immunocompromised patient presents with neutropenic sepsis. Which antibiotic regimen is recommended?

- **A. IV piperacillin-tazobactam 4.5g 8-hourly**
- B. IV amoxicillin 1g + gentamicin
- C. Oral co-amoxiclav 625mg
- D. IV cefuroxime 1.5g
- E. IV vancomycin alone

**Correct Answer:** A

**Explanation:**

NICE NG151 recommends prompt IV beta-lactam with antipseudomonal activity for neutropenic sepsis. Piperacillin-tazobactam (Tazocin) 4.5g IV 8-hourly is the standard first-line agent. Meropenem is an alternative for high-risk patients. Vancomycin is added if MRSA is suspected or if PICC/Hickman line infection. Aminoglycosides avoided in renal impairment.

---

## Question 5

What lactate level defines septic shock in the Sepsis-3 definition?

- **A. Lactate >2 mmol/L despite adequate fluid resuscitation**
- B. Lactate >4 mmol/L
- C. Lactate >1 mmol/L with hypotension
- D. Lactate >3 mmol/L
- E. Any elevated lactate with fever

**Correct Answer:** A

**Explanation:**

Sepsis-3 (JAMA 2016) defines septic shock as a subset of sepsis with: (1) vasopressor requirement to maintain MAP >65 mmHg AND (2) lactate >2 mmol/L despite adequate fluid resuscitation, in the absence of hypovolaemia. This combination is associated with >40% hospital mortality. Lactate >4 mmol/L indicates severe hypoperfusion.
$SBAQ0008$,
        "position" = 210,
        "status" = 'published',
        "updated_at" = now()
      WHERE "id" = v_lesson_id;
    END IF;

  END IF;  -- end module check


  -- =========================================================================
  -- Module: Nephrology & Acid-Base Disorders
  -- =========================================================================
  SELECT id INTO v_module_id FROM "modules"
  WHERE "course_id" = v_course_id AND "title" = 'Nephrology & Acid-Base Disorders' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    RAISE WARNING 'Module % not found in mrcem-sba, skipping...', 'Nephrology & Acid-Base Disorders';
  ELSE


    -- Quiz: Hyperkalemia Management - SBA Quiz (5 questions)
    SELECT id INTO v_lesson_id FROM "lessons"
    WHERE "module_id" = v_module_id AND "slug" = 'sba-quiz-hyperkalemia-management' AND "deleted_at" IS NULL LIMIT 1;
    IF v_lesson_id IS NULL THEN
      INSERT INTO "lessons" (
        "id", "module_id", "slug", "title", "type", "body",
        "is_free_preview", "position", "status", "created_at", "updated_at"
      ) VALUES (
        gen_random_uuid(), v_module_id, 'sba-quiz-hyperkalemia-management', 'Hyperkalemia Management - SBA Quiz', 'quiz',
        $SBAQ0009$# Hyperkalemia Management - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 65-year-old dialysis patient presents with weakness. ECG shows peaked T waves, wide QRS (180ms), and sine wave pattern. K+ is 8.2 mmol/L. What is the FIRST priority treatment?

- **A. IV calcium gluconate 10ml 10% over 2-3 minutes**
- B. IV insulin 10 units + dextrose 50ml 50%
- C. Salbutamol 10mg nebulised
- D. Calcium resonium 15g orally
- E. Emergency haemodialysis

**Correct Answer:** A

**Explanation:**

Cardiac membrane stabilisation with IV calcium gluconate (10ml of 10% = 2.25 mmol calcium) is the FIRST intervention in severe hyperkalaemia with ECG changes. It does not reduce potassium but stabilises the myocardium within 1-3 minutes, protecting against VF. It should be given immediately before other treatments. Calcium chloride can be used but causes more tissue necrosis if extravasated.

---

## Question 2

Following calcium gluconate for severe hyperkalaemia, what is the best drug combination to shift potassium intracellularly?

- **A. Insulin (10 units actrapid) + 50ml 50% dextrose**
- B. Furosemide 80mg IV + saline
- C. Sodium bicarbonate 50ml 8.4% alone
- D. Salbutamol 10mg nebulised alone
- E. Calcium resonium 30g enema

**Correct Answer:** A

**Explanation:**

Insulin drives K+ into cells via Na/K ATPase stimulation - most effective intracellular shift agent. Given with 50ml 50% dextrose (25g glucose) to prevent hypoglycaemia - monitor BG 30 minutely for 6 hours. This lowers K+ by 1-1.5 mmol/L within 15-30 minutes. Salbutamol 10-20mg nebulised is additive. Sodium bicarbonate is only beneficial in severe metabolic acidosis.

---

## Question 3

A patient with CKD stage 4 presents with K+ 6.8 mmol/L and ECG showing peaked T waves only. BP 170/100. What is the appropriate management to ELIMINATE potassium from the body?

- **A. Patiromer or sodium zirconium cyclosilicate (SZC) orally**
- B. IV furosemide 40mg
- C. Calcium resonium 15g 6-hourly
- D. Haemodialysis immediately
- E. Normal saline 1L IV

**Correct Answer:** A

**Explanation:**

To eliminate potassium from the body, potassium binders are preferred over old calcium resonium (which causes constipation and intestinal necrosis). NICE recommends patiromer or SZC (Lokelma) as safer alternatives. Furosemide increases urinary K+ excretion in patients with residual renal function. Haemodialysis is reserved for refractory cases or anuric patients.

---

## Question 4

Which ECG change is the FIRST to appear in progressive hyperkalaemia?

- **A. Peaked (tall, tented) T waves**
- B. Widened QRS complex
- C. Sine wave pattern
- D. P wave flattening
- E. VF

**Correct Answer:** A

**Explanation:**

ECG changes in hyperkalaemia progress with rising K+: (1) Peaked/tented T waves (K+ ~5.5-6.5), (2) PR prolongation, (3) P wave flattening/disappearance (K+ ~6.5-7), (4) QRS widening, (5) Sine wave pattern, (6) VF or asystole. Peaked T waves are the earliest ECG sign and should prompt immediate K+ measurement and treatment initiation.

---

## Question 5

A patient on spironolactone develops K+ 6.5 mmol/L. After emergency treatment, which medication should be STOPPED?

- **A. Spironolactone**
- B. Amlodipine
- C. Ramipril (ACE inhibitor)
- D. Furosemide
- E. Bisoprolol

**Correct Answer:** A

**Explanation:**

Spironolactone (and other potassium-sparing diuretics: amiloride, eplerenone) cause hyperkalaemia by blocking aldosterone's action in the collecting duct, reducing K+ excretion. ACE inhibitors and ARBs also cause hyperkalaemia. In the emergency setting, both spironolactone AND ACE inhibitors/ARBs should be reviewed and often held/stopped until K+ normalises.
$SBAQ0009$,
        false, 200, 'published', now(), now()
      );
    ELSE
      UPDATE "lessons" SET
        "title" = 'Hyperkalemia Management - SBA Quiz',
        "type" = 'quiz',
        "body" = $SBAQ0009$# Hyperkalemia Management - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 65-year-old dialysis patient presents with weakness. ECG shows peaked T waves, wide QRS (180ms), and sine wave pattern. K+ is 8.2 mmol/L. What is the FIRST priority treatment?

- **A. IV calcium gluconate 10ml 10% over 2-3 minutes**
- B. IV insulin 10 units + dextrose 50ml 50%
- C. Salbutamol 10mg nebulised
- D. Calcium resonium 15g orally
- E. Emergency haemodialysis

**Correct Answer:** A

**Explanation:**

Cardiac membrane stabilisation with IV calcium gluconate (10ml of 10% = 2.25 mmol calcium) is the FIRST intervention in severe hyperkalaemia with ECG changes. It does not reduce potassium but stabilises the myocardium within 1-3 minutes, protecting against VF. It should be given immediately before other treatments. Calcium chloride can be used but causes more tissue necrosis if extravasated.

---

## Question 2

Following calcium gluconate for severe hyperkalaemia, what is the best drug combination to shift potassium intracellularly?

- **A. Insulin (10 units actrapid) + 50ml 50% dextrose**
- B. Furosemide 80mg IV + saline
- C. Sodium bicarbonate 50ml 8.4% alone
- D. Salbutamol 10mg nebulised alone
- E. Calcium resonium 30g enema

**Correct Answer:** A

**Explanation:**

Insulin drives K+ into cells via Na/K ATPase stimulation - most effective intracellular shift agent. Given with 50ml 50% dextrose (25g glucose) to prevent hypoglycaemia - monitor BG 30 minutely for 6 hours. This lowers K+ by 1-1.5 mmol/L within 15-30 minutes. Salbutamol 10-20mg nebulised is additive. Sodium bicarbonate is only beneficial in severe metabolic acidosis.

---

## Question 3

A patient with CKD stage 4 presents with K+ 6.8 mmol/L and ECG showing peaked T waves only. BP 170/100. What is the appropriate management to ELIMINATE potassium from the body?

- **A. Patiromer or sodium zirconium cyclosilicate (SZC) orally**
- B. IV furosemide 40mg
- C. Calcium resonium 15g 6-hourly
- D. Haemodialysis immediately
- E. Normal saline 1L IV

**Correct Answer:** A

**Explanation:**

To eliminate potassium from the body, potassium binders are preferred over old calcium resonium (which causes constipation and intestinal necrosis). NICE recommends patiromer or SZC (Lokelma) as safer alternatives. Furosemide increases urinary K+ excretion in patients with residual renal function. Haemodialysis is reserved for refractory cases or anuric patients.

---

## Question 4

Which ECG change is the FIRST to appear in progressive hyperkalaemia?

- **A. Peaked (tall, tented) T waves**
- B. Widened QRS complex
- C. Sine wave pattern
- D. P wave flattening
- E. VF

**Correct Answer:** A

**Explanation:**

ECG changes in hyperkalaemia progress with rising K+: (1) Peaked/tented T waves (K+ ~5.5-6.5), (2) PR prolongation, (3) P wave flattening/disappearance (K+ ~6.5-7), (4) QRS widening, (5) Sine wave pattern, (6) VF or asystole. Peaked T waves are the earliest ECG sign and should prompt immediate K+ measurement and treatment initiation.

---

## Question 5

A patient on spironolactone develops K+ 6.5 mmol/L. After emergency treatment, which medication should be STOPPED?

- **A. Spironolactone**
- B. Amlodipine
- C. Ramipril (ACE inhibitor)
- D. Furosemide
- E. Bisoprolol

**Correct Answer:** A

**Explanation:**

Spironolactone (and other potassium-sparing diuretics: amiloride, eplerenone) cause hyperkalaemia by blocking aldosterone's action in the collecting duct, reducing K+ excretion. ACE inhibitors and ARBs also cause hyperkalaemia. In the emergency setting, both spironolactone AND ACE inhibitors/ARBs should be reviewed and often held/stopped until K+ normalises.
$SBAQ0009$,
        "position" = 200,
        "status" = 'published',
        "updated_at" = now()
      WHERE "id" = v_lesson_id;
    END IF;


    -- Quiz: Acute Kidney Injury - SBA Quiz (5 questions)
    SELECT id INTO v_lesson_id FROM "lessons"
    WHERE "module_id" = v_module_id AND "slug" = 'sba-quiz-acute-kidney-injury' AND "deleted_at" IS NULL LIMIT 1;
    IF v_lesson_id IS NULL THEN
      INSERT INTO "lessons" (
        "id", "module_id", "slug", "title", "type", "body",
        "is_free_preview", "position", "status", "created_at", "updated_at"
      ) VALUES (
        gen_random_uuid(), v_module_id, 'sba-quiz-acute-kidney-injury', 'Acute Kidney Injury - SBA Quiz', 'quiz',
        $SBAQ0010$# Acute Kidney Injury - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 70-year-old man presents with oliguria (urine output 15ml/hr). Creatinine has risen from 90 to 280 umol/L in 48 hours. Blood pressure is 80/50. What is the most important initial investigation to guide management?

- **A. Urinary catheter for strict fluid balance + bladder scan to exclude retention**
- B. CT abdomen/pelvis
- C. Renal biopsy
- D. Renal ultrasound for obstruction
- E. Urine electrolytes (FENa)

**Correct Answer:** A

**Explanation:**

The first step in AKI is categorising the cause: pre-renal (hypovolaemia - most common), renal (intrinsic), or post-renal (obstruction). Bladder scan/urinary catheter excludes urinary retention (most common reversible post-renal cause). KDIGO AKI stages: Stage 1 = Cr x1.5-1.9 baseline; Stage 2 = x2-2.9; Stage 3 = x3 or >354 or RRT needed.

---

## Question 2

A patient with AKI and K+ 5.8 mmol/L, pH 7.15, bicarbonate 10, and fluid-overloaded lungs. What is the definitive treatment?

- **A. Emergency renal replacement therapy (haemodialysis)**
- B. IV sodium bicarbonate 100ml 8.4%
- C. Insulin and dextrose
- D. Furosemide 250mg IV
- E. IV calcium gluconate and monitor

**Correct Answer:** A

**Explanation:**

Indications for emergency RRT/dialysis (AEIOU): A=Acidosis refractory (pH <7.1), E=Electrolytes (K+ >6.5 refractory), I=Intoxication (drugs), O=Overload fluid refractory, U=Uraemia (encephalopathy, pericarditis). This patient has refractory acidosis, hyperkalaemia, and fluid overload - meeting multiple indications for emergency dialysis.

---

## Question 3

Which drug is most commonly associated with causing acute tubular necrosis (ATN)?

- **A. IV contrast media (contrast-induced nephropathy)**
- B. Paracetamol
- C. NSAIDs (causing pre-renal AKI)
- D. ACE inhibitors
- E. Metformin

**Correct Answer:** A

**Explanation:**

Causes of ATN: ischaemic (most common - prolonged hypotension, sepsis, haemorrhage) and nephrotoxic. IV contrast (contrast-induced nephropathy/CIN) is a leading preventable cause. Prevention: pre-hydration with IV saline, use low/iso-osmolar contrast, avoid in CKD (eGFR <30). Aminoglycosides, vancomycin, cisplatin, and rhabdomyolysis are other nephrotoxic causes.

---

## Question 4

A patient with known NSAID use develops AKI. What mechanism is responsible?

- **A. Afferent arteriolar vasoconstriction reducing glomerular filtration**
- B. Direct tubular toxicity
- C. Allergic interstitial nephritis (immune-mediated)
- D. Increased renin release
- E. Glomerulonephritis

**Correct Answer:** A

**Explanation:**

NSAIDs inhibit prostaglandin synthesis. In states of reduced effective circulating volume (heart failure, CKD, dehydration), prostaglandins dilate the afferent arteriole to maintain GFR. NSAID inhibition causes afferent vasoconstriction, reducing GFR and causing pre-renal AKI. ACE inhibitors/ARBs act on the efferent arteriole. The combination of NSAID + ACE inhibitor + diuretic ('triple whammy') dramatically increases AKI risk.

---

## Question 5

A 35-year-old man presents with AKI, macroscopic haematuria, and palpable purpura on his legs. BP 165/95. What is the most likely diagnosis?

- **A. IgA nephropathy or vasculitis**
- B. Diabetic nephropathy
- C. Contrast-induced nephropathy
- D. Post-streptococcal GN
- E. Minimal change disease

**Correct Answer:** A

**Explanation:**

AKI with haematuria and purpuric rash (palpable purpura) in a young adult suggests small vessel vasculitis, particularly IgA vasculitis (Henoch-Schonlein purpura) or ANCA-associated vasculitis (GPA/MPA). IgA nephropathy can present with macroscopic haematuria after URTI. Urgent nephrology referral and renal biopsy are needed. Post-streptococcal GN typically has an antecedent throat infection.
$SBAQ0010$,
        false, 210, 'published', now(), now()
      );
    ELSE
      UPDATE "lessons" SET
        "title" = 'Acute Kidney Injury - SBA Quiz',
        "type" = 'quiz',
        "body" = $SBAQ0010$# Acute Kidney Injury - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 70-year-old man presents with oliguria (urine output 15ml/hr). Creatinine has risen from 90 to 280 umol/L in 48 hours. Blood pressure is 80/50. What is the most important initial investigation to guide management?

- **A. Urinary catheter for strict fluid balance + bladder scan to exclude retention**
- B. CT abdomen/pelvis
- C. Renal biopsy
- D. Renal ultrasound for obstruction
- E. Urine electrolytes (FENa)

**Correct Answer:** A

**Explanation:**

The first step in AKI is categorising the cause: pre-renal (hypovolaemia - most common), renal (intrinsic), or post-renal (obstruction). Bladder scan/urinary catheter excludes urinary retention (most common reversible post-renal cause). KDIGO AKI stages: Stage 1 = Cr x1.5-1.9 baseline; Stage 2 = x2-2.9; Stage 3 = x3 or >354 or RRT needed.

---

## Question 2

A patient with AKI and K+ 5.8 mmol/L, pH 7.15, bicarbonate 10, and fluid-overloaded lungs. What is the definitive treatment?

- **A. Emergency renal replacement therapy (haemodialysis)**
- B. IV sodium bicarbonate 100ml 8.4%
- C. Insulin and dextrose
- D. Furosemide 250mg IV
- E. IV calcium gluconate and monitor

**Correct Answer:** A

**Explanation:**

Indications for emergency RRT/dialysis (AEIOU): A=Acidosis refractory (pH <7.1), E=Electrolytes (K+ >6.5 refractory), I=Intoxication (drugs), O=Overload fluid refractory, U=Uraemia (encephalopathy, pericarditis). This patient has refractory acidosis, hyperkalaemia, and fluid overload - meeting multiple indications for emergency dialysis.

---

## Question 3

Which drug is most commonly associated with causing acute tubular necrosis (ATN)?

- **A. IV contrast media (contrast-induced nephropathy)**
- B. Paracetamol
- C. NSAIDs (causing pre-renal AKI)
- D. ACE inhibitors
- E. Metformin

**Correct Answer:** A

**Explanation:**

Causes of ATN: ischaemic (most common - prolonged hypotension, sepsis, haemorrhage) and nephrotoxic. IV contrast (contrast-induced nephropathy/CIN) is a leading preventable cause. Prevention: pre-hydration with IV saline, use low/iso-osmolar contrast, avoid in CKD (eGFR <30). Aminoglycosides, vancomycin, cisplatin, and rhabdomyolysis are other nephrotoxic causes.

---

## Question 4

A patient with known NSAID use develops AKI. What mechanism is responsible?

- **A. Afferent arteriolar vasoconstriction reducing glomerular filtration**
- B. Direct tubular toxicity
- C. Allergic interstitial nephritis (immune-mediated)
- D. Increased renin release
- E. Glomerulonephritis

**Correct Answer:** A

**Explanation:**

NSAIDs inhibit prostaglandin synthesis. In states of reduced effective circulating volume (heart failure, CKD, dehydration), prostaglandins dilate the afferent arteriole to maintain GFR. NSAID inhibition causes afferent vasoconstriction, reducing GFR and causing pre-renal AKI. ACE inhibitors/ARBs act on the efferent arteriole. The combination of NSAID + ACE inhibitor + diuretic ('triple whammy') dramatically increases AKI risk.

---

## Question 5

A 35-year-old man presents with AKI, macroscopic haematuria, and palpable purpura on his legs. BP 165/95. What is the most likely diagnosis?

- **A. IgA nephropathy or vasculitis**
- B. Diabetic nephropathy
- C. Contrast-induced nephropathy
- D. Post-streptococcal GN
- E. Minimal change disease

**Correct Answer:** A

**Explanation:**

AKI with haematuria and purpuric rash (palpable purpura) in a young adult suggests small vessel vasculitis, particularly IgA vasculitis (Henoch-Schonlein purpura) or ANCA-associated vasculitis (GPA/MPA). IgA nephropathy can present with macroscopic haematuria after URTI. Urgent nephrology referral and renal biopsy are needed. Post-streptococcal GN typically has an antecedent throat infection.
$SBAQ0010$,
        "position" = 210,
        "status" = 'published',
        "updated_at" = now()
      WHERE "id" = v_lesson_id;
    END IF;

  END IF;  -- end module check


  -- =========================================================================
  -- Module: Pulmonology & Respiratory Emergencies
  -- =========================================================================
  SELECT id INTO v_module_id FROM "modules"
  WHERE "course_id" = v_course_id AND "title" = 'Pulmonology & Respiratory Emergencies' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    RAISE WARNING 'Module % not found in mrcem-sba, skipping...', 'Pulmonology & Respiratory Emergencies';
  ELSE


    -- Quiz: Asthma Management - SBA Quiz (5 questions)
    SELECT id INTO v_lesson_id FROM "lessons"
    WHERE "module_id" = v_module_id AND "slug" = 'sba-quiz-asthma-management' AND "deleted_at" IS NULL LIMIT 1;
    IF v_lesson_id IS NULL THEN
      INSERT INTO "lessons" (
        "id", "module_id", "slug", "title", "type", "body",
        "is_free_preview", "position", "status", "created_at", "updated_at"
      ) VALUES (
        gen_random_uuid(), v_module_id, 'sba-quiz-asthma-management', 'Asthma Management - SBA Quiz', 'quiz',
        $SBAQ0011$# Asthma Management - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 22-year-old woman presents with acute severe asthma. PEFR 40% predicted, RR 28, HR 118, SpO2 94%. Unable to speak in full sentences. What is the INITIAL treatment?

- **A. High-flow O2 + nebulised salbutamol 5mg + ipratropium 0.5mg + oral/IV prednisolone 40-50mg**
- B. IV salbutamol 250mcg bolus
- C. IV aminophylline loading dose
- D. IM adrenaline 0.5mg
- E. IV magnesium sulphate 1.2-2g

**Correct Answer:** A

**Explanation:**

Acute severe asthma (PEFR 33-50%, any one of: RR>25, HR>110, inability to complete sentences) - BTS/SIGN guidelines: O2 to maintain SpO2 94-98%, nebulised salbutamol 5mg (driven by O2) + ipratropium 500mcg, oral/IV prednisolone 40-50mg. IV magnesium and IV aminophylline are reserved for life-threatening or near-fatal asthma or failure to respond.

---

## Question 2

A patient with life-threatening asthma (SpO2 <92%, silent chest, exhaustion) fails to respond to initial treatment. What is the next pharmacological intervention?

- **A. IV magnesium sulphate 1.2-2g over 20 minutes**
- B. IV aminophylline 5mg/kg loading dose
- C. IM adrenaline 500mcg
- D. Nebulised heliox
- E. IV ketamine 1-2mg/kg

**Correct Answer:** A

**Explanation:**

Life-threatening asthma criteria: SpO2 <92%, silent chest, cyanosis, poor respiratory effort, exhaustion, altered consciousness, PEFR <33%. After initial bronchodilators and steroids, add IV magnesium sulphate 1.2-2g over 20 minutes (BTS/SIGN). IV aminophylline is an alternative but has a narrow therapeutic index. IM adrenaline is used in near-fatal/arrested patients.

---

## Question 3

Which PEFR threshold defines near-fatal asthma?

- **A. PEFR <33% predicted or best**
- B. PEFR <50% predicted
- C. PEFR <75% predicted
- D. PEFR <60% predicted
- E. Any PEFR with hypoxia

**Correct Answer:** A

**Explanation:**

BTS/SIGN asthma severity: Moderate (PEFR 50-75%), Acute Severe (PEFR 33-50%), Life-threatening (PEFR <33% with any life-threatening feature: SpO2<92%, silent chest, cyanosis, exhaustion, altered consciousness), Near-fatal (hypercapnia, requiring IPPV). PEFR <33% is the threshold for life-threatening asthma.

---

## Question 4

An asthmatic patient's ABG shows pH 7.33, pCO2 5.8 kPa, pO2 8.2 kPa. What does this indicate?

- **A. Impending respiratory failure - rising CO2 is an ominous sign in acute asthma**
- B. Compensated respiratory acidosis - normal in asthma attack
- C. Metabolic acidosis from salbutamol
- D. Patient is improving
- E. Mild asthma, discharge on steroids

**Correct Answer:** A

**Explanation:**

In acute asthma, the expected ABG is: respiratory alkalosis (hypocapnia - patient hyperventilates). A NORMAL or RISING pCO2 in an acute asthmatic attack is an ominous sign indicating respiratory fatigue and impending respiratory failure. This patient requires immediate senior review, ITU/HDU consideration, and preparation for RSI/intubation. Never be falsely reassured by a 'normal' CO2.

---

## Question 5

A 30-year-old with asthma is discharged after an acute attack. Which inhaler should be prescribed for maintenance alongside SABA?

- **A. Inhaled corticosteroid (ICS) - e.g., beclomethasone**
- B. Long-acting beta-agonist (LABA) alone - e.g., salmeterol
- C. Oral montelukast alone
- D. Regular oral prednisolone
- E. Short-acting anticholinergic - ipratropium

**Correct Answer:** A

**Explanation:**

BTS/SIGN step-up: Step 1 = SABA (salbutamol) PRN. Step 2 = Add low-dose ICS (beclomethasone 200-400mcg/day). Step 3 = Add LABA (salmeterol) to ICS. Step 4 = Increase ICS dose. Never prescribe LABA without ICS (LABAs alone increase asthma mortality). After ED attendance, start/step-up ICS and refer to GP follow-up within 48 hours.
$SBAQ0011$,
        false, 200, 'published', now(), now()
      );
    ELSE
      UPDATE "lessons" SET
        "title" = 'Asthma Management - SBA Quiz',
        "type" = 'quiz',
        "body" = $SBAQ0011$# Asthma Management - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 22-year-old woman presents with acute severe asthma. PEFR 40% predicted, RR 28, HR 118, SpO2 94%. Unable to speak in full sentences. What is the INITIAL treatment?

- **A. High-flow O2 + nebulised salbutamol 5mg + ipratropium 0.5mg + oral/IV prednisolone 40-50mg**
- B. IV salbutamol 250mcg bolus
- C. IV aminophylline loading dose
- D. IM adrenaline 0.5mg
- E. IV magnesium sulphate 1.2-2g

**Correct Answer:** A

**Explanation:**

Acute severe asthma (PEFR 33-50%, any one of: RR>25, HR>110, inability to complete sentences) - BTS/SIGN guidelines: O2 to maintain SpO2 94-98%, nebulised salbutamol 5mg (driven by O2) + ipratropium 500mcg, oral/IV prednisolone 40-50mg. IV magnesium and IV aminophylline are reserved for life-threatening or near-fatal asthma or failure to respond.

---

## Question 2

A patient with life-threatening asthma (SpO2 <92%, silent chest, exhaustion) fails to respond to initial treatment. What is the next pharmacological intervention?

- **A. IV magnesium sulphate 1.2-2g over 20 minutes**
- B. IV aminophylline 5mg/kg loading dose
- C. IM adrenaline 500mcg
- D. Nebulised heliox
- E. IV ketamine 1-2mg/kg

**Correct Answer:** A

**Explanation:**

Life-threatening asthma criteria: SpO2 <92%, silent chest, cyanosis, poor respiratory effort, exhaustion, altered consciousness, PEFR <33%. After initial bronchodilators and steroids, add IV magnesium sulphate 1.2-2g over 20 minutes (BTS/SIGN). IV aminophylline is an alternative but has a narrow therapeutic index. IM adrenaline is used in near-fatal/arrested patients.

---

## Question 3

Which PEFR threshold defines near-fatal asthma?

- **A. PEFR <33% predicted or best**
- B. PEFR <50% predicted
- C. PEFR <75% predicted
- D. PEFR <60% predicted
- E. Any PEFR with hypoxia

**Correct Answer:** A

**Explanation:**

BTS/SIGN asthma severity: Moderate (PEFR 50-75%), Acute Severe (PEFR 33-50%), Life-threatening (PEFR <33% with any life-threatening feature: SpO2<92%, silent chest, cyanosis, exhaustion, altered consciousness), Near-fatal (hypercapnia, requiring IPPV). PEFR <33% is the threshold for life-threatening asthma.

---

## Question 4

An asthmatic patient's ABG shows pH 7.33, pCO2 5.8 kPa, pO2 8.2 kPa. What does this indicate?

- **A. Impending respiratory failure - rising CO2 is an ominous sign in acute asthma**
- B. Compensated respiratory acidosis - normal in asthma attack
- C. Metabolic acidosis from salbutamol
- D. Patient is improving
- E. Mild asthma, discharge on steroids

**Correct Answer:** A

**Explanation:**

In acute asthma, the expected ABG is: respiratory alkalosis (hypocapnia - patient hyperventilates). A NORMAL or RISING pCO2 in an acute asthmatic attack is an ominous sign indicating respiratory fatigue and impending respiratory failure. This patient requires immediate senior review, ITU/HDU consideration, and preparation for RSI/intubation. Never be falsely reassured by a 'normal' CO2.

---

## Question 5

A 30-year-old with asthma is discharged after an acute attack. Which inhaler should be prescribed for maintenance alongside SABA?

- **A. Inhaled corticosteroid (ICS) - e.g., beclomethasone**
- B. Long-acting beta-agonist (LABA) alone - e.g., salmeterol
- C. Oral montelukast alone
- D. Regular oral prednisolone
- E. Short-acting anticholinergic - ipratropium

**Correct Answer:** A

**Explanation:**

BTS/SIGN step-up: Step 1 = SABA (salbutamol) PRN. Step 2 = Add low-dose ICS (beclomethasone 200-400mcg/day). Step 3 = Add LABA (salmeterol) to ICS. Step 4 = Increase ICS dose. Never prescribe LABA without ICS (LABAs alone increase asthma mortality). After ED attendance, start/step-up ICS and refer to GP follow-up within 48 hours.
$SBAQ0011$,
        "position" = 200,
        "status" = 'published',
        "updated_at" = now()
      WHERE "id" = v_lesson_id;
    END IF;


    -- Quiz: COPD Exacerbation - SBA Quiz (5 questions)
    SELECT id INTO v_lesson_id FROM "lessons"
    WHERE "module_id" = v_module_id AND "slug" = 'sba-quiz-copd-exacerbation' AND "deleted_at" IS NULL LIMIT 1;
    IF v_lesson_id IS NULL THEN
      INSERT INTO "lessons" (
        "id", "module_id", "slug", "title", "type", "body",
        "is_free_preview", "position", "status", "created_at", "updated_at"
      ) VALUES (
        gen_random_uuid(), v_module_id, 'sba-quiz-copd-exacerbation', 'COPD Exacerbation - SBA Quiz', 'quiz',
        $SBAQ0012$# COPD Exacerbation - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 70-year-old COPD patient presents with increased breathlessness and purulent sputum. SpO2 84%, RR 28. What is the target SpO2?

- **A. 88-92%**
- B. 94-98%
- C. 96-100%
- D. >95%
- E. 80-85%

**Correct Answer:** A

**Explanation:**

COPD patients with hypercapnic respiratory failure may depend on hypoxic drive. Aim SpO2 88-92% (not >94-98% as in normal patients). Over-oxygenation causes CO2 retention (Haldane effect and loss of hypoxic drive). Use 24% Venturi mask (1-2L/min) initially, titrate up. Check ABG to guide oxygen therapy. Start at lowest FiO2 achieving target SpO2.

---

## Question 2

A COPD patient with acute exacerbation has pH 7.25, pCO2 9.0 kPa, pO2 7.5 kPa on 28% oxygen. What is the next intervention?

- **A. Non-invasive ventilation (NIV - BiPAP)**
- B. Increase FiO2 to 60%
- C. IV aminophylline
- D. Intubation and mechanical ventilation
- E. IV doxapram infusion

**Correct Answer:** A

**Explanation:**

NIV (BiPAP) is indicated in COPD exacerbation with: pH <7.35, pCO2 >6 kPa despite controlled O2. BTS guidelines: Start NIV at IPAP 12-15cmH2O, EPAP 4-5cmH2O. NIV reduces need for intubation, ICU admission, and mortality. Reassess after 1 hour - if pH <7.25 or worsening, escalate to ITU for invasive ventilation. IV doxapram is rarely used as a respiratory stimulant.

---

## Question 3

Which organism is the most common bacterial cause of COPD exacerbation?

- **A. Haemophilus influenzae**
- B. Streptococcus pneumoniae
- C. Moraxella catarrhalis
- D. Pseudomonas aeruginosa
- E. Klebsiella pneumoniae

**Correct Answer:** A

**Explanation:**

Causes of COPD exacerbation: ~50% viral (rhinovirus, influenza, RSV), ~50% bacterial. Most common bacteria: Haemophilus influenzae (most common), Streptococcus pneumoniae, Moraxella catarrhalis. Pseudomonas is more common in severe COPD (FEV1<30%), bronchiectasis, or frequent exacerbations requiring antibiotics. First-line antibiotic: amoxicillin, doxycycline, or clarithromycin.

---

## Question 4

Which spirometry pattern is consistent with COPD?

- **A. Obstructive pattern: FEV1/FVC <0.70 post-bronchodilator**
- B. Restrictive pattern: FVC reduced, FEV1/FVC normal
- C. Mixed pattern: both FEV1 and FVC reduced equally
- D. Normal spirometry excludes COPD
- E. FEV1/FVC >0.70 with reduced TLC

**Correct Answer:** A

**Explanation:**

COPD is diagnosed by post-bronchodilator spirometry showing FEV1/FVC <0.70 (fixed obstruction - distinguishes from asthma which shows reversibility). GOLD staging: GOLD 1 = FEV1 >80%, GOLD 2 = 50-79%, GOLD 3 = 30-49%, GOLD 4 = <30%. COPD diagnosis requires both symptoms (chronic cough, sputum, dyspnoea) AND airflow obstruction on spirometry.

---

## Question 5

A COPD patient presents with acute exacerbation. Which systemic steroid regimen is recommended by NICE?

- **A. Prednisolone 30mg orally for 5 days**
- B. Prednisolone 60mg orally for 14 days
- C. IV hydrocortisone 200mg 6-hourly
- D. Dexamethasone 8mg IV single dose
- E. Inhaled corticosteroids only

**Correct Answer:** A

**Explanation:**

NICE NG115 recommends prednisolone 30mg orally for 5 days for COPD exacerbation (shorter courses are as effective as longer). In patients unable to take orals, IV hydrocortisone 100-200mg can be used. Steroids reduce treatment failure, exacerbation duration, and improve lung function. They do not affect mortality or hospital admission rate but reduce length of stay.
$SBAQ0012$,
        false, 210, 'published', now(), now()
      );
    ELSE
      UPDATE "lessons" SET
        "title" = 'COPD Exacerbation - SBA Quiz',
        "type" = 'quiz',
        "body" = $SBAQ0012$# COPD Exacerbation - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 70-year-old COPD patient presents with increased breathlessness and purulent sputum. SpO2 84%, RR 28. What is the target SpO2?

- **A. 88-92%**
- B. 94-98%
- C. 96-100%
- D. >95%
- E. 80-85%

**Correct Answer:** A

**Explanation:**

COPD patients with hypercapnic respiratory failure may depend on hypoxic drive. Aim SpO2 88-92% (not >94-98% as in normal patients). Over-oxygenation causes CO2 retention (Haldane effect and loss of hypoxic drive). Use 24% Venturi mask (1-2L/min) initially, titrate up. Check ABG to guide oxygen therapy. Start at lowest FiO2 achieving target SpO2.

---

## Question 2

A COPD patient with acute exacerbation has pH 7.25, pCO2 9.0 kPa, pO2 7.5 kPa on 28% oxygen. What is the next intervention?

- **A. Non-invasive ventilation (NIV - BiPAP)**
- B. Increase FiO2 to 60%
- C. IV aminophylline
- D. Intubation and mechanical ventilation
- E. IV doxapram infusion

**Correct Answer:** A

**Explanation:**

NIV (BiPAP) is indicated in COPD exacerbation with: pH <7.35, pCO2 >6 kPa despite controlled O2. BTS guidelines: Start NIV at IPAP 12-15cmH2O, EPAP 4-5cmH2O. NIV reduces need for intubation, ICU admission, and mortality. Reassess after 1 hour - if pH <7.25 or worsening, escalate to ITU for invasive ventilation. IV doxapram is rarely used as a respiratory stimulant.

---

## Question 3

Which organism is the most common bacterial cause of COPD exacerbation?

- **A. Haemophilus influenzae**
- B. Streptococcus pneumoniae
- C. Moraxella catarrhalis
- D. Pseudomonas aeruginosa
- E. Klebsiella pneumoniae

**Correct Answer:** A

**Explanation:**

Causes of COPD exacerbation: ~50% viral (rhinovirus, influenza, RSV), ~50% bacterial. Most common bacteria: Haemophilus influenzae (most common), Streptococcus pneumoniae, Moraxella catarrhalis. Pseudomonas is more common in severe COPD (FEV1<30%), bronchiectasis, or frequent exacerbations requiring antibiotics. First-line antibiotic: amoxicillin, doxycycline, or clarithromycin.

---

## Question 4

Which spirometry pattern is consistent with COPD?

- **A. Obstructive pattern: FEV1/FVC <0.70 post-bronchodilator**
- B. Restrictive pattern: FVC reduced, FEV1/FVC normal
- C. Mixed pattern: both FEV1 and FVC reduced equally
- D. Normal spirometry excludes COPD
- E. FEV1/FVC >0.70 with reduced TLC

**Correct Answer:** A

**Explanation:**

COPD is diagnosed by post-bronchodilator spirometry showing FEV1/FVC <0.70 (fixed obstruction - distinguishes from asthma which shows reversibility). GOLD staging: GOLD 1 = FEV1 >80%, GOLD 2 = 50-79%, GOLD 3 = 30-49%, GOLD 4 = <30%. COPD diagnosis requires both symptoms (chronic cough, sputum, dyspnoea) AND airflow obstruction on spirometry.

---

## Question 5

A COPD patient presents with acute exacerbation. Which systemic steroid regimen is recommended by NICE?

- **A. Prednisolone 30mg orally for 5 days**
- B. Prednisolone 60mg orally for 14 days
- C. IV hydrocortisone 200mg 6-hourly
- D. Dexamethasone 8mg IV single dose
- E. Inhaled corticosteroids only

**Correct Answer:** A

**Explanation:**

NICE NG115 recommends prednisolone 30mg orally for 5 days for COPD exacerbation (shorter courses are as effective as longer). In patients unable to take orals, IV hydrocortisone 100-200mg can be used. Steroids reduce treatment failure, exacerbation duration, and improve lung function. They do not affect mortality or hospital admission rate but reduce length of stay.
$SBAQ0012$,
        "position" = 210,
        "status" = 'published',
        "updated_at" = now()
      WHERE "id" = v_lesson_id;
    END IF;

  END IF;  -- end module check


  -- =========================================================================
  -- Module: Gastroenterology Emergencies
  -- =========================================================================
  SELECT id INTO v_module_id FROM "modules"
  WHERE "course_id" = v_course_id AND "title" = 'Gastroenterology Emergencies' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    RAISE WARNING 'Module % not found in mrcem-sba, skipping...', 'Gastroenterology Emergencies';
  ELSE


    -- Quiz: Upper GI Bleeding - SBA Quiz (5 questions)
    SELECT id INTO v_lesson_id FROM "lessons"
    WHERE "module_id" = v_module_id AND "slug" = 'sba-quiz-upper-gi-bleeding' AND "deleted_at" IS NULL LIMIT 1;
    IF v_lesson_id IS NULL THEN
      INSERT INTO "lessons" (
        "id", "module_id", "slug", "title", "type", "body",
        "is_free_preview", "position", "status", "created_at", "updated_at"
      ) VALUES (
        gen_random_uuid(), v_module_id, 'sba-quiz-upper-gi-bleeding', 'Upper GI Bleeding - SBA Quiz', 'quiz',
        $SBAQ0013$# Upper GI Bleeding - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 55-year-old man presents with haematemesis. HR 120, BP 90/60, Hb 7.2 g/dL. He takes naproxen and warfarin. What is the MOST urgent initial priority?

- **A. IV access x2, fluid resuscitation, cross-match, urgent senior review**
- B. Urgent OGD within 1 hour
- C. IV omeprazole 80mg bolus
- D. Correct INR with FFP before anything else
- E. NG tube insertion

**Correct Answer:** A

**Explanation:**

Initial management of acute UGIB with haemodynamic instability: A=airway protection, B=O2, C=large-bore IV access x2, immediate volume resuscitation (crystalloid/colloid), urgent cross-match for blood transfusion, NPO, call senior/gastroenterology. OGD should occur within 24h (within 12h if high-risk - Rockall >4). IV omeprazole/PPIs reduce re-bleeding but come after resuscitation.

---

## Question 2

Regarding blood transfusion in UGIB, what is the recommended Hb threshold for transfusion in a haemodynamically stable patient?

- **A. Hb <70 g/L (7 g/dL)**
- B. Hb <80 g/L
- C. Hb <90 g/L
- D. Hb <100 g/L
- E. Only when symptomatic regardless of Hb

**Correct Answer:** A

**Explanation:**

NICE NG141 (UGIB): Transfuse at Hb <70 g/L in haemodynamically stable patients. Target Hb 70-90 g/L (avoid over-transfusion which increases re-bleeding risk). Exception: Patients with ACS, active haemorrhage, or those likely to be haemodynamically compromised - transfuse at higher threshold. Restrictive transfusion strategy (Hb <70) reduces mortality in UGIB compared to liberal transfusion.

---

## Question 3

A patient presents with massive UGIB and cirrhosis. Which specific agent should be given to reduce portal hypertension and bleeding?

- **A. IV terlipressin 2mg 6-hourly**
- B. IV omeprazole 80mg bolus
- C. IV vitamin K
- D. IV tranexamic acid
- E. Octreotide infusion 25-50mcg/hour

**Correct Answer:** A

**Explanation:**

Variceal UGIB (cirrhosis): Give IV terlipressin 2mg 6-hourly (vasopressin analogue - reduces portal pressure) alongside resuscitation. Antibiotic prophylaxis (IV ceftriaxone) is also recommended in cirrhotic patients with UGIB to reduce SBP risk. Urgent OGD for band ligation or sclerotherapy of varices. TIPSS (transjugular intrahepatic portosystemic shunt) if refractory.

---

## Question 4

In variceal bleeding, which is the preferred endoscopic treatment?

- **A. Oesophageal band ligation (EBL)**
- B. Sclerotherapy alone
- C. Oesophageal tamponade (Sengstaken-Blakemore tube)
- D. TIPSS as first-line
- E. Surgical oesophageal transection

**Correct Answer:** A

**Explanation:**

Oesophageal band ligation (EBL/EVL) is the preferred endoscopic treatment for oesophageal varices - it has higher rates of variceal eradication and fewer complications than sclerotherapy. Sengstaken-Blakemore tube is a temporary rescue measure when endoscopy fails. TIPSS is used for refractory bleeding or Child-Pugh C patients. Early TIPSS within 72h improves outcomes in high-risk patients.

---

## Question 5

A patient presents with haematemesis and epigastric pain. OGD reveals a bleeding duodenal ulcer with a visible vessel. What is the Forrest classification and management?

- **A. Forrest Ia (spurting haemorrhage) or Ib (oozing) - endoscopic haemostasis**
- B. Forrest IIa (visible vessel, no bleeding) - observe only
- C. Forrest III (clean base) - discharge on PPI
- D. Forrest IIb (adherent clot) - no intervention needed
- E. Any Forrest class - immediate surgery

**Correct Answer:** A

**Explanation:**

Forrest classification guides endoscopic management: Ia=active spurting, Ib=active oozing - highest re-bleeding risk, endoscopic treatment mandatory. IIa=visible vessel (non-bleeding, 43% re-bleed risk), endoscopic treatment. IIb=adherent clot (22% re-bleed), attempt to remove and treat. IIc=flat pigmented spot (7%), III=clean base (2%) - medical management, early discharge. Post-endoscopy: IV omeprazole infusion 8mg/hr for 72h.
$SBAQ0013$,
        false, 200, 'published', now(), now()
      );
    ELSE
      UPDATE "lessons" SET
        "title" = 'Upper GI Bleeding - SBA Quiz',
        "type" = 'quiz',
        "body" = $SBAQ0013$# Upper GI Bleeding - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 55-year-old man presents with haematemesis. HR 120, BP 90/60, Hb 7.2 g/dL. He takes naproxen and warfarin. What is the MOST urgent initial priority?

- **A. IV access x2, fluid resuscitation, cross-match, urgent senior review**
- B. Urgent OGD within 1 hour
- C. IV omeprazole 80mg bolus
- D. Correct INR with FFP before anything else
- E. NG tube insertion

**Correct Answer:** A

**Explanation:**

Initial management of acute UGIB with haemodynamic instability: A=airway protection, B=O2, C=large-bore IV access x2, immediate volume resuscitation (crystalloid/colloid), urgent cross-match for blood transfusion, NPO, call senior/gastroenterology. OGD should occur within 24h (within 12h if high-risk - Rockall >4). IV omeprazole/PPIs reduce re-bleeding but come after resuscitation.

---

## Question 2

Regarding blood transfusion in UGIB, what is the recommended Hb threshold for transfusion in a haemodynamically stable patient?

- **A. Hb <70 g/L (7 g/dL)**
- B. Hb <80 g/L
- C. Hb <90 g/L
- D. Hb <100 g/L
- E. Only when symptomatic regardless of Hb

**Correct Answer:** A

**Explanation:**

NICE NG141 (UGIB): Transfuse at Hb <70 g/L in haemodynamically stable patients. Target Hb 70-90 g/L (avoid over-transfusion which increases re-bleeding risk). Exception: Patients with ACS, active haemorrhage, or those likely to be haemodynamically compromised - transfuse at higher threshold. Restrictive transfusion strategy (Hb <70) reduces mortality in UGIB compared to liberal transfusion.

---

## Question 3

A patient presents with massive UGIB and cirrhosis. Which specific agent should be given to reduce portal hypertension and bleeding?

- **A. IV terlipressin 2mg 6-hourly**
- B. IV omeprazole 80mg bolus
- C. IV vitamin K
- D. IV tranexamic acid
- E. Octreotide infusion 25-50mcg/hour

**Correct Answer:** A

**Explanation:**

Variceal UGIB (cirrhosis): Give IV terlipressin 2mg 6-hourly (vasopressin analogue - reduces portal pressure) alongside resuscitation. Antibiotic prophylaxis (IV ceftriaxone) is also recommended in cirrhotic patients with UGIB to reduce SBP risk. Urgent OGD for band ligation or sclerotherapy of varices. TIPSS (transjugular intrahepatic portosystemic shunt) if refractory.

---

## Question 4

In variceal bleeding, which is the preferred endoscopic treatment?

- **A. Oesophageal band ligation (EBL)**
- B. Sclerotherapy alone
- C. Oesophageal tamponade (Sengstaken-Blakemore tube)
- D. TIPSS as first-line
- E. Surgical oesophageal transection

**Correct Answer:** A

**Explanation:**

Oesophageal band ligation (EBL/EVL) is the preferred endoscopic treatment for oesophageal varices - it has higher rates of variceal eradication and fewer complications than sclerotherapy. Sengstaken-Blakemore tube is a temporary rescue measure when endoscopy fails. TIPSS is used for refractory bleeding or Child-Pugh C patients. Early TIPSS within 72h improves outcomes in high-risk patients.

---

## Question 5

A patient presents with haematemesis and epigastric pain. OGD reveals a bleeding duodenal ulcer with a visible vessel. What is the Forrest classification and management?

- **A. Forrest Ia (spurting haemorrhage) or Ib (oozing) - endoscopic haemostasis**
- B. Forrest IIa (visible vessel, no bleeding) - observe only
- C. Forrest III (clean base) - discharge on PPI
- D. Forrest IIb (adherent clot) - no intervention needed
- E. Any Forrest class - immediate surgery

**Correct Answer:** A

**Explanation:**

Forrest classification guides endoscopic management: Ia=active spurting, Ib=active oozing - highest re-bleeding risk, endoscopic treatment mandatory. IIa=visible vessel (non-bleeding, 43% re-bleed risk), endoscopic treatment. IIb=adherent clot (22% re-bleed), attempt to remove and treat. IIc=flat pigmented spot (7%), III=clean base (2%) - medical management, early discharge. Post-endoscopy: IV omeprazole infusion 8mg/hr for 72h.
$SBAQ0013$,
        "position" = 200,
        "status" = 'published',
        "updated_at" = now()
      WHERE "id" = v_lesson_id;
    END IF;


    -- Quiz: Acute Pancreatitis - SBA Quiz (5 questions)
    SELECT id INTO v_lesson_id FROM "lessons"
    WHERE "module_id" = v_module_id AND "slug" = 'sba-quiz-acute-pancreatitis' AND "deleted_at" IS NULL LIMIT 1;
    IF v_lesson_id IS NULL THEN
      INSERT INTO "lessons" (
        "id", "module_id", "slug", "title", "type", "body",
        "is_free_preview", "position", "status", "created_at", "updated_at"
      ) VALUES (
        gen_random_uuid(), v_module_id, 'sba-quiz-acute-pancreatitis', 'Acute Pancreatitis - SBA Quiz', 'quiz',
        $SBAQ0014$# Acute Pancreatitis - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 45-year-old alcoholic presents with severe epigastric pain radiating to the back, vomiting, and serum amylase 2500 IU/L (>3x ULN). What is the diagnosis and immediate management priority?

- **A. Acute pancreatitis - IV fluid resuscitation (aggressive crystalloid) is the priority**
- B. Acute pancreatitis - urgent ERCP within 24 hours
- C. Peptic ulcer perforation - urgent CT
- D. Mesenteric ischaemia - CT angiography
- E. Acute pancreatitis - IV antibiotics immediately

**Correct Answer:** A

**Explanation:**

Acute pancreatitis (elevated amylase/lipase >3x ULN + clinical features). Immediate management: aggressive IV crystalloid resuscitation (250-500ml/hr Hartmann's solution - recommended over saline which may worsen acidosis), analgesia (IV morphine/pethidine), nil by mouth, NG tube if vomiting, urinary catheter for fluid balance. IV antibiotics not routine (only if infected necrosis suspected).

---

## Question 2

Which scoring system is used to assess the severity of acute pancreatitis and predict complications?

- **A. Glasgow/Imrie score (or BISAP, CTSI, Ranson)**
- B. APACHE II (hospital use)
- C. GRACE score
- D. Child-Pugh score
- E. Rockall score

**Correct Answer:** A

**Explanation:**

Severity scoring in acute pancreatitis: Glasgow/Imrie score (>3 = severe, performed at 48h): PaO2<8kPa, Age>55, Neutrophils>15, Calcium<2, Urea>16, Enzymes(LDH>600), Albumin<32, Sugar(glucose>10) - mnemonic PANCREAS. BISAP score: BUN>25, Impaired mental status, SIRS, Age>60, Pleural effusion. CT Severity Index (CTSI) uses imaging findings.

---

## Question 3

A patient with acute pancreatitis develops fever, rigors, and worsening pain on day 10. CT shows pancreatic necrosis with gas bubbles. What is the diagnosis and management?

- **A. Infected pancreatic necrosis - CT-guided fine needle aspiration and antibiotics (meropenem)**
- B. Sterile necrosis - supportive management only
- C. Pancreatic pseudocyst - endoscopic drainage
- D. Pancreatic abscess - immediate surgery
- E. Peripancreatic fluid collection - observe

**Correct Answer:** A

**Explanation:**

Infected pancreatic necrosis typically presents after day 7-10 with fever, rising CRP, and deterioration. CT showing gas in the necrosis is pathognomonic. Management: IV meropenem (penetrates necrosis well), CT/US-guided FNA for Gram stain/culture. Minimally invasive step-up approach (percutaneous drainage -> videoscopic retroperitoneal debridement) preferred over open necrosectomy. ERCP if gallstone pancreatitis.

---

## Question 4

A 35-year-old woman presents with acute pancreatitis. Ultrasound shows gallstones. ALT is 3x upper limit of normal. What intervention is indicated?

- **A. ERCP with sphincterotomy if evidence of CBD obstruction**
- B. Emergency cholecystectomy within 24 hours
- C. ERCP for all gallstone pancreatitis
- D. Conservative management - ERCP not indicated
- E. Ursodeoxycholic acid to dissolve stones

**Correct Answer:** A

**Explanation:**

In gallstone pancreatitis: ERCP with sphincterotomy is indicated if there is evidence of common bile duct obstruction (cholangitis, rising bilirubin, dilated CBD on US). Routine ERCP without biliary obstruction does not improve outcomes (UK guidelines). Laparoscopic cholecystectomy should be performed during the same admission or within 2 weeks of mild pancreatitis.

---

## Question 5

What is the most common cause of acute pancreatitis in the UK?

- **A. Gallstones**
- B. Alcohol
- C. Hypertriglyceridaemia
- D. Post-ERCP
- E. Drug-induced

**Correct Answer:** A

**Explanation:**

UK causes of acute pancreatitis: Gallstones 45-50% (most common), Alcohol 35-40%, Unknown/Idiopathic 10-15%, Other (post-ERCP, hypertriglyceridaemia, hypercalcaemia, drugs - azathioprine, steroids, thiazides, GLP-1 agonists, mumps, trauma). Gallstones cause pancreatitis by blocking the pancreatic duct orifice at the ampulla of Vater. Every patient should have USS and LFTs at presentation.
$SBAQ0014$,
        false, 210, 'published', now(), now()
      );
    ELSE
      UPDATE "lessons" SET
        "title" = 'Acute Pancreatitis - SBA Quiz',
        "type" = 'quiz',
        "body" = $SBAQ0014$# Acute Pancreatitis - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 45-year-old alcoholic presents with severe epigastric pain radiating to the back, vomiting, and serum amylase 2500 IU/L (>3x ULN). What is the diagnosis and immediate management priority?

- **A. Acute pancreatitis - IV fluid resuscitation (aggressive crystalloid) is the priority**
- B. Acute pancreatitis - urgent ERCP within 24 hours
- C. Peptic ulcer perforation - urgent CT
- D. Mesenteric ischaemia - CT angiography
- E. Acute pancreatitis - IV antibiotics immediately

**Correct Answer:** A

**Explanation:**

Acute pancreatitis (elevated amylase/lipase >3x ULN + clinical features). Immediate management: aggressive IV crystalloid resuscitation (250-500ml/hr Hartmann's solution - recommended over saline which may worsen acidosis), analgesia (IV morphine/pethidine), nil by mouth, NG tube if vomiting, urinary catheter for fluid balance. IV antibiotics not routine (only if infected necrosis suspected).

---

## Question 2

Which scoring system is used to assess the severity of acute pancreatitis and predict complications?

- **A. Glasgow/Imrie score (or BISAP, CTSI, Ranson)**
- B. APACHE II (hospital use)
- C. GRACE score
- D. Child-Pugh score
- E. Rockall score

**Correct Answer:** A

**Explanation:**

Severity scoring in acute pancreatitis: Glasgow/Imrie score (>3 = severe, performed at 48h): PaO2<8kPa, Age>55, Neutrophils>15, Calcium<2, Urea>16, Enzymes(LDH>600), Albumin<32, Sugar(glucose>10) - mnemonic PANCREAS. BISAP score: BUN>25, Impaired mental status, SIRS, Age>60, Pleural effusion. CT Severity Index (CTSI) uses imaging findings.

---

## Question 3

A patient with acute pancreatitis develops fever, rigors, and worsening pain on day 10. CT shows pancreatic necrosis with gas bubbles. What is the diagnosis and management?

- **A. Infected pancreatic necrosis - CT-guided fine needle aspiration and antibiotics (meropenem)**
- B. Sterile necrosis - supportive management only
- C. Pancreatic pseudocyst - endoscopic drainage
- D. Pancreatic abscess - immediate surgery
- E. Peripancreatic fluid collection - observe

**Correct Answer:** A

**Explanation:**

Infected pancreatic necrosis typically presents after day 7-10 with fever, rising CRP, and deterioration. CT showing gas in the necrosis is pathognomonic. Management: IV meropenem (penetrates necrosis well), CT/US-guided FNA for Gram stain/culture. Minimally invasive step-up approach (percutaneous drainage -> videoscopic retroperitoneal debridement) preferred over open necrosectomy. ERCP if gallstone pancreatitis.

---

## Question 4

A 35-year-old woman presents with acute pancreatitis. Ultrasound shows gallstones. ALT is 3x upper limit of normal. What intervention is indicated?

- **A. ERCP with sphincterotomy if evidence of CBD obstruction**
- B. Emergency cholecystectomy within 24 hours
- C. ERCP for all gallstone pancreatitis
- D. Conservative management - ERCP not indicated
- E. Ursodeoxycholic acid to dissolve stones

**Correct Answer:** A

**Explanation:**

In gallstone pancreatitis: ERCP with sphincterotomy is indicated if there is evidence of common bile duct obstruction (cholangitis, rising bilirubin, dilated CBD on US). Routine ERCP without biliary obstruction does not improve outcomes (UK guidelines). Laparoscopic cholecystectomy should be performed during the same admission or within 2 weeks of mild pancreatitis.

---

## Question 5

What is the most common cause of acute pancreatitis in the UK?

- **A. Gallstones**
- B. Alcohol
- C. Hypertriglyceridaemia
- D. Post-ERCP
- E. Drug-induced

**Correct Answer:** A

**Explanation:**

UK causes of acute pancreatitis: Gallstones 45-50% (most common), Alcohol 35-40%, Unknown/Idiopathic 10-15%, Other (post-ERCP, hypertriglyceridaemia, hypercalcaemia, drugs - azathioprine, steroids, thiazides, GLP-1 agonists, mumps, trauma). Gallstones cause pancreatitis by blocking the pancreatic duct orifice at the ampulla of Vater. Every patient should have USS and LFTs at presentation.
$SBAQ0014$,
        "position" = 210,
        "status" = 'published',
        "updated_at" = now()
      WHERE "id" = v_lesson_id;
    END IF;

  END IF;  -- end module check


  -- =========================================================================
  -- Module: Major Trauma & Injury Management
  -- =========================================================================
  SELECT id INTO v_module_id FROM "modules"
  WHERE "course_id" = v_course_id AND "title" = 'Major Trauma & Injury Management' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    RAISE WARNING 'Module % not found in mrcem-sba, skipping...', 'Major Trauma & Injury Management';
  ELSE


    -- Quiz: Head Trauma - SBA Quiz (5 questions)
    SELECT id INTO v_lesson_id FROM "lessons"
    WHERE "module_id" = v_module_id AND "slug" = 'sba-quiz-head-trauma' AND "deleted_at" IS NULL LIMIT 1;
    IF v_lesson_id IS NULL THEN
      INSERT INTO "lessons" (
        "id", "module_id", "slug", "title", "type", "body",
        "is_free_preview", "position", "status", "created_at", "updated_at"
      ) VALUES (
        gen_random_uuid(), v_module_id, 'sba-quiz-head-trauma', 'Head Trauma - SBA Quiz', 'quiz',
        $SBAQ0015$# Head Trauma - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 28-year-old motorcyclist presents after RTA with GCS 9 (E2V3M4), BP 130/80, HR 95. CT head shows an extradural haematoma with 15mm midline shift. What is the priority management?

- **A. Immediate neurosurgical referral for craniotomy and haematoma evacuation**
- B. IV dexamethasone 8mg
- C. IV mannitol 1g/kg and monitor ICP
- D. Intubation and hyperventilation to pCO2 4kPa
- E. CT angiography of cerebral vessels

**Correct Answer:** A

**Explanation:**

Extradural haematoma (EDH) - arterial bleed (typically from middle meningeal artery) - 'lucid interval' followed by rapid deterioration. EDH with >10mm thickness, >5mm midline shift, or GCS<8 requires EMERGENCY surgical evacuation. Neurosurgical referral within 4 hours. IV mannitol can temporarily reduce ICP as a bridge to surgery. Steroids have no role in traumatic brain injury.

---

## Question 2

What is the 'gold standard' for detecting traumatic intracranial pathology in the acute setting?

- **A. Non-contrast CT head**
- B. MRI brain
- C. CT head with contrast
- D. Skull X-ray
- E. Lumbar puncture

**Correct Answer:** A

**Explanation:**

Non-contrast CT head is the gold standard for detecting acute traumatic intracranial pathology (haematoma, skull fracture, cerebral oedema, pneumocephalus). MRI is more sensitive for diffuse axonal injury but is impractical in the acute trauma setting. NICE NG234 criteria for CT head within 1 hour: GCS <13 on assessment, suspected open/depressed skull fracture, signs of basal skull fracture, post-traumatic seizure, focal neurological deficit, vomiting >1 episode.

---

## Question 3

A 65-year-old on warfarin (INR 3.5) falls and sustains a head injury. GCS 15, no neurological deficit. What is the safest management regarding anticoagulation and imaging?

- **A. CT head immediately + reverse anticoagulation if intracranial haemorrhage found**
- B. Observe for 24 hours - no CT needed if GCS 15
- C. Wait for INR to normalise before CT
- D. CT head + reverse all anticoagulation prophylactically
- E. Discharge with head injury advice only

**Correct Answer:** A

**Explanation:**

NICE NG234: Patients on anticoagulants (warfarin, DOACs, heparin) who sustain head injury warrant immediate CT head, regardless of neurological status, due to significantly increased risk of intracranial haemorrhage. If haemorrhage found: IV vitamin K + PCC (Beriplex/Octaplex) 25-50 units/kg to reverse warfarin rapidly. Hold anticoagulation and involve haematology/neurosurgery.

---

## Question 4

What is the correct formula for calculating cerebral perfusion pressure (CPP)?

- **A. CPP = MAP - ICP (target CPP 50-70 mmHg)**
- B. CPP = SBP - ICP
- C. CPP = MAP + ICP
- D. CPP = DBP - ICP
- E. CPP = HR x SBP / ICP

**Correct Answer:** A

**Explanation:**

Cerebral Perfusion Pressure (CPP) = Mean Arterial Pressure (MAP) - Intracranial Pressure (ICP). Target CPP 50-70 mmHg in TBI. Interventions to optimise CPP: raise MAP (vasopressors/fluids) and reduce ICP (head elevation 30 degrees, sedation, osmotherapy with mannitol or hypertonic saline, CSF drainage, hyperventilation as temporary measure). Normal ICP <15 mmHg; ICP >20 mmHg requires treatment.

---

## Question 5

A trauma patient has battle sign, periorbital ecchymosis, and CSF rhinorrhoea. What diagnosis is indicated?

- **A. Basal skull fracture**
- B. Temporal bone fracture
- C. Zygoma fracture
- D. Frontal sinus fracture
- E. Le Fort III fracture

**Correct Answer:** A

**Explanation:**

Basal skull fracture signs: Battle's sign (retroauricular bruising - fracture of petrous temporal bone), periorbital ecchymosis 'raccoon eyes' (anterior cranial fossa fracture), CSF rhinorrhoea (anterior fossa) or otorrhoea (petrous fracture), haemotympanum. Antibiotic prophylaxis for CSF leaks is controversial (UK guidelines do not recommend routine prophylaxis). Neurosurgical assessment required.
$SBAQ0015$,
        false, 200, 'published', now(), now()
      );
    ELSE
      UPDATE "lessons" SET
        "title" = 'Head Trauma - SBA Quiz',
        "type" = 'quiz',
        "body" = $SBAQ0015$# Head Trauma - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 28-year-old motorcyclist presents after RTA with GCS 9 (E2V3M4), BP 130/80, HR 95. CT head shows an extradural haematoma with 15mm midline shift. What is the priority management?

- **A. Immediate neurosurgical referral for craniotomy and haematoma evacuation**
- B. IV dexamethasone 8mg
- C. IV mannitol 1g/kg and monitor ICP
- D. Intubation and hyperventilation to pCO2 4kPa
- E. CT angiography of cerebral vessels

**Correct Answer:** A

**Explanation:**

Extradural haematoma (EDH) - arterial bleed (typically from middle meningeal artery) - 'lucid interval' followed by rapid deterioration. EDH with >10mm thickness, >5mm midline shift, or GCS<8 requires EMERGENCY surgical evacuation. Neurosurgical referral within 4 hours. IV mannitol can temporarily reduce ICP as a bridge to surgery. Steroids have no role in traumatic brain injury.

---

## Question 2

What is the 'gold standard' for detecting traumatic intracranial pathology in the acute setting?

- **A. Non-contrast CT head**
- B. MRI brain
- C. CT head with contrast
- D. Skull X-ray
- E. Lumbar puncture

**Correct Answer:** A

**Explanation:**

Non-contrast CT head is the gold standard for detecting acute traumatic intracranial pathology (haematoma, skull fracture, cerebral oedema, pneumocephalus). MRI is more sensitive for diffuse axonal injury but is impractical in the acute trauma setting. NICE NG234 criteria for CT head within 1 hour: GCS <13 on assessment, suspected open/depressed skull fracture, signs of basal skull fracture, post-traumatic seizure, focal neurological deficit, vomiting >1 episode.

---

## Question 3

A 65-year-old on warfarin (INR 3.5) falls and sustains a head injury. GCS 15, no neurological deficit. What is the safest management regarding anticoagulation and imaging?

- **A. CT head immediately + reverse anticoagulation if intracranial haemorrhage found**
- B. Observe for 24 hours - no CT needed if GCS 15
- C. Wait for INR to normalise before CT
- D. CT head + reverse all anticoagulation prophylactically
- E. Discharge with head injury advice only

**Correct Answer:** A

**Explanation:**

NICE NG234: Patients on anticoagulants (warfarin, DOACs, heparin) who sustain head injury warrant immediate CT head, regardless of neurological status, due to significantly increased risk of intracranial haemorrhage. If haemorrhage found: IV vitamin K + PCC (Beriplex/Octaplex) 25-50 units/kg to reverse warfarin rapidly. Hold anticoagulation and involve haematology/neurosurgery.

---

## Question 4

What is the correct formula for calculating cerebral perfusion pressure (CPP)?

- **A. CPP = MAP - ICP (target CPP 50-70 mmHg)**
- B. CPP = SBP - ICP
- C. CPP = MAP + ICP
- D. CPP = DBP - ICP
- E. CPP = HR x SBP / ICP

**Correct Answer:** A

**Explanation:**

Cerebral Perfusion Pressure (CPP) = Mean Arterial Pressure (MAP) - Intracranial Pressure (ICP). Target CPP 50-70 mmHg in TBI. Interventions to optimise CPP: raise MAP (vasopressors/fluids) and reduce ICP (head elevation 30 degrees, sedation, osmotherapy with mannitol or hypertonic saline, CSF drainage, hyperventilation as temporary measure). Normal ICP <15 mmHg; ICP >20 mmHg requires treatment.

---

## Question 5

A trauma patient has battle sign, periorbital ecchymosis, and CSF rhinorrhoea. What diagnosis is indicated?

- **A. Basal skull fracture**
- B. Temporal bone fracture
- C. Zygoma fracture
- D. Frontal sinus fracture
- E. Le Fort III fracture

**Correct Answer:** A

**Explanation:**

Basal skull fracture signs: Battle's sign (retroauricular bruising - fracture of petrous temporal bone), periorbital ecchymosis 'raccoon eyes' (anterior cranial fossa fracture), CSF rhinorrhoea (anterior fossa) or otorrhoea (petrous fracture), haemotympanum. Antibiotic prophylaxis for CSF leaks is controversial (UK guidelines do not recommend routine prophylaxis). Neurosurgical assessment required.
$SBAQ0015$,
        "position" = 200,
        "status" = 'published',
        "updated_at" = now()
      WHERE "id" = v_lesson_id;
    END IF;


    -- Quiz: Burns - SBA Quiz (5 questions)
    SELECT id INTO v_lesson_id FROM "lessons"
    WHERE "module_id" = v_module_id AND "slug" = 'sba-quiz-burns' AND "deleted_at" IS NULL LIMIT 1;
    IF v_lesson_id IS NULL THEN
      INSERT INTO "lessons" (
        "id", "module_id", "slug", "title", "type", "body",
        "is_free_preview", "position", "status", "created_at", "updated_at"
      ) VALUES (
        gen_random_uuid(), v_module_id, 'sba-quiz-burns', 'Burns - SBA Quiz', 'quiz',
        $SBAQ0016$# Burns - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 35-year-old man sustains 30% TBSA flame burns (2nd and 3rd degree). Weight 70kg. Using the Parkland formula, what volume of Hartmann's solution should be given in the first 8 hours?

- **A. 2100ml (half of 4200ml total first 24 hours)**
- B. 4200ml in first 8 hours
- C. 2100ml in first 24 hours
- D. 8400ml in first 8 hours
- E. 500ml/hr regardless of TBSA

**Correct Answer:** A

**Explanation:**

Parkland formula: 4ml x kg x %TBSA = total volume in first 24 hours with Hartmann's solution. 4 x 70 x 30 = 8400ml. Give HALF (4200ml) in first 8 hours from TIME OF BURN (not time of arrival). Give remaining half over next 16 hours. Monitor urine output 0.5ml/kg/hr (adults) as guide to adequacy. 2nd degree burns (partial thickness) are included; 3rd degree (full thickness) and areas <1% are excluded.

---

## Question 2

Which topical agent is considered first-line for burn wound care in the UK?

- **A. Silver sulfadiazine 1% cream (SSD) or mafenide acetate**
- B. Povidone-iodine solution
- C. Hydrogen peroxide
- D. Systemic antibiotics
- E. Antibiotic-impregnated Mepitel dressing

**Correct Answer:** A

**Explanation:**

Silver sulfadiazine (SSD/Flamazine) 1% cream is a broad-spectrum antimicrobial widely used for burn wound care. Mepitel (soft silicone) and Mepilex dressings are increasingly used as alternatives. Povidone-iodine and hydrogen peroxide are toxic to wound cells and discouraged. Prophylactic systemic antibiotics are not recommended. Dressings: change at 48-72h or as needed.

---

## Question 3

A 40-year-old is rescued from a house fire. GCS 13, SpO2 94%, hoarse voice, singed nasal hairs, soot in pharynx. What is the most urgent action?

- **A. Early intubation for airway protection**
- B. High-flow oxygen and observe
- C. Bronchodilators and steroids
- D. Emergency surgical tracheostomy
- E. CT chest to assess inhalation injury

**Correct Answer:** A

**Explanation:**

Signs of inhalation injury (singed nasal/facial hair, soot/carbonaceous deposits, hoarseness, stridor, respiratory distress) indicate airway compromise risk. Oedema progresses rapidly over hours making intubation increasingly difficult. EARLY elective RSI intubation is essential - do not delay until stridor occurs as this indicates critical airway obstruction. Obtain anaesthetic/ENT support urgently.

---

## Question 4

What is the 'rule of nines' TBSA for a complete arm in an adult?

- **A. 9%**
- B. 18%
- C. 4.5%
- D. 1%
- E. 13.5%

**Correct Answer:** A

**Explanation:**

Rule of nines (adult): Head+Neck=9%, Anterior trunk=18%, Posterior trunk=18%, Each arm=9% (forearm 4.5% + upper arm 4.5%), Each leg=18% (thigh 9% + lower leg+foot 9%), Genitalia=1%. Total=100%. Palm of patient's hand (including fingers) = ~1% TBSA for irregular burns. Children use the Lund and Browder chart (head larger, legs smaller proportionally).

---

## Question 5

A patient with full-thickness circumferential burns to both lower legs develops calf pain and tightening. Compartment pressures are elevated. What procedure is required?

- **A. Escharotomy**
- B. Fasciotomy
- C. Debridement and grafting
- D. Limb elevation only
- E. IV mannitol for compartment syndrome

**Correct Answer:** A

**Explanation:**

Escharotomy is incision through the burn eschar (not the fascia) to relieve compartment syndrome caused by circumferential full-thickness burns. The burn eschar acts as a constricting band as underlying tissue swells. Perform with electrocautery along medial and lateral lines of the limb. Fasciotomy (deeper incision through fascia) is needed if compartment pressures remain elevated after escharotomy. Monitor pulses/Doppler.
$SBAQ0016$,
        false, 210, 'published', now(), now()
      );
    ELSE
      UPDATE "lessons" SET
        "title" = 'Burns - SBA Quiz',
        "type" = 'quiz',
        "body" = $SBAQ0016$# Burns - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 35-year-old man sustains 30% TBSA flame burns (2nd and 3rd degree). Weight 70kg. Using the Parkland formula, what volume of Hartmann's solution should be given in the first 8 hours?

- **A. 2100ml (half of 4200ml total first 24 hours)**
- B. 4200ml in first 8 hours
- C. 2100ml in first 24 hours
- D. 8400ml in first 8 hours
- E. 500ml/hr regardless of TBSA

**Correct Answer:** A

**Explanation:**

Parkland formula: 4ml x kg x %TBSA = total volume in first 24 hours with Hartmann's solution. 4 x 70 x 30 = 8400ml. Give HALF (4200ml) in first 8 hours from TIME OF BURN (not time of arrival). Give remaining half over next 16 hours. Monitor urine output 0.5ml/kg/hr (adults) as guide to adequacy. 2nd degree burns (partial thickness) are included; 3rd degree (full thickness) and areas <1% are excluded.

---

## Question 2

Which topical agent is considered first-line for burn wound care in the UK?

- **A. Silver sulfadiazine 1% cream (SSD) or mafenide acetate**
- B. Povidone-iodine solution
- C. Hydrogen peroxide
- D. Systemic antibiotics
- E. Antibiotic-impregnated Mepitel dressing

**Correct Answer:** A

**Explanation:**

Silver sulfadiazine (SSD/Flamazine) 1% cream is a broad-spectrum antimicrobial widely used for burn wound care. Mepitel (soft silicone) and Mepilex dressings are increasingly used as alternatives. Povidone-iodine and hydrogen peroxide are toxic to wound cells and discouraged. Prophylactic systemic antibiotics are not recommended. Dressings: change at 48-72h or as needed.

---

## Question 3

A 40-year-old is rescued from a house fire. GCS 13, SpO2 94%, hoarse voice, singed nasal hairs, soot in pharynx. What is the most urgent action?

- **A. Early intubation for airway protection**
- B. High-flow oxygen and observe
- C. Bronchodilators and steroids
- D. Emergency surgical tracheostomy
- E. CT chest to assess inhalation injury

**Correct Answer:** A

**Explanation:**

Signs of inhalation injury (singed nasal/facial hair, soot/carbonaceous deposits, hoarseness, stridor, respiratory distress) indicate airway compromise risk. Oedema progresses rapidly over hours making intubation increasingly difficult. EARLY elective RSI intubation is essential - do not delay until stridor occurs as this indicates critical airway obstruction. Obtain anaesthetic/ENT support urgently.

---

## Question 4

What is the 'rule of nines' TBSA for a complete arm in an adult?

- **A. 9%**
- B. 18%
- C. 4.5%
- D. 1%
- E. 13.5%

**Correct Answer:** A

**Explanation:**

Rule of nines (adult): Head+Neck=9%, Anterior trunk=18%, Posterior trunk=18%, Each arm=9% (forearm 4.5% + upper arm 4.5%), Each leg=18% (thigh 9% + lower leg+foot 9%), Genitalia=1%. Total=100%. Palm of patient's hand (including fingers) = ~1% TBSA for irregular burns. Children use the Lund and Browder chart (head larger, legs smaller proportionally).

---

## Question 5

A patient with full-thickness circumferential burns to both lower legs develops calf pain and tightening. Compartment pressures are elevated. What procedure is required?

- **A. Escharotomy**
- B. Fasciotomy
- C. Debridement and grafting
- D. Limb elevation only
- E. IV mannitol for compartment syndrome

**Correct Answer:** A

**Explanation:**

Escharotomy is incision through the burn eschar (not the fascia) to relieve compartment syndrome caused by circumferential full-thickness burns. The burn eschar acts as a constricting band as underlying tissue swells. Perform with electrocautery along medial and lateral lines of the limb. Fasciotomy (deeper incision through fascia) is needed if compartment pressures remain elevated after escharotomy. Monitor pulses/Doppler.
$SBAQ0016$,
        "position" = 210,
        "status" = 'published',
        "updated_at" = now()
      WHERE "id" = v_lesson_id;
    END IF;

  END IF;  -- end module check


  -- =========================================================================
  -- Module: Ophthalmology Emergencies
  -- =========================================================================
  SELECT id INTO v_module_id FROM "modules"
  WHERE "course_id" = v_course_id AND "title" = 'Ophthalmology Emergencies' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    RAISE WARNING 'Module % not found in mrcem-sba, skipping...', 'Ophthalmology Emergencies';
  ELSE


    -- Quiz: Acute Red Eye - SBA Quiz (5 questions)
    SELECT id INTO v_lesson_id FROM "lessons"
    WHERE "module_id" = v_module_id AND "slug" = 'sba-quiz-acute-red-eye' AND "deleted_at" IS NULL LIMIT 1;
    IF v_lesson_id IS NULL THEN
      INSERT INTO "lessons" (
        "id", "module_id", "slug", "title", "type", "body",
        "is_free_preview", "position", "status", "created_at", "updated_at"
      ) VALUES (
        gen_random_uuid(), v_module_id, 'sba-quiz-acute-red-eye', 'Acute Red Eye - SBA Quiz', 'quiz',
        $SBAQ0017$# Acute Red Eye - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 35-year-old contact lens wearer presents with acute onset severe eye pain, photophobia, reduced visual acuity, and a hypopyon. Slit-lamp shows a corneal ulcer. What is the priority management?

- **A. Stop contact lens use + urgent ophthalmology referral + corneal scraping for culture + topical fluoroquinolone antibiotics**
- B. Topical chloramphenicol and review in 1 week
- C. Topical steroids to reduce inflammation
- D. Systemic antibiotics only
- E. Patching the eye and analgesia

**Correct Answer:** A

**Explanation:**

Acanthamoeba/bacterial keratitis from contact lens use is an ocular emergency. Features: severe pain, photophobia, hypopyon (pus in anterior chamber). Immediate management: (1) Stop lenses, (2) Corneal scraping for microscopy/culture before antibiotics, (3) Intensive topical fluoroquinolone (ciprofloxacin/ofloxacin eye drops hourly), (4) Urgent ophthalmology. Steroids contraindicated until organism identified (worsen fungal/Acanthamoeba).

---

## Question 2

A 70-year-old presents with acute unilateral severe eye pain, red eye, haloes around lights, nausea, fixed mid-dilated pupil, and IOP 45 mmHg. What is the diagnosis and first-line treatment?

- **A. Acute angle-closure glaucoma - IV/oral acetazolamide + pilocarpine drops**
- B. Uveitis - topical steroids and mydriatics
- C. Orbital cellulitis - IV antibiotics
- D. Conjunctivitis - topical chloramphenicol
- E. Corneal ulcer - topical fluoroquinolones

**Correct Answer:** A

**Explanation:**

Acute angle-closure glaucoma: IOP >21 (typically >40 mmHg), fixed mid-dilated pupil (pupil dilation closes the angle), severe pain, haloes, N&V, visual impairment. Immediate treatment: IV acetazolamide 500mg (carbonic anhydrase inhibitor - reduces aqueous production), 2% pilocarpine drops to constrict pupil and open angle, IV mannitol if severe. Urgent ophthalmology for laser peripheral iridotomy.

---

## Question 3

A 25-year-old presents with gradual onset, painless, bilateral red eyes with bilateral mucopurulent discharge. He recently had a urethral discharge. What organism is most likely?

- **A. Neisseria gonorrhoeae**
- B. Chlamydia trachomatis
- C. Staphylococcus aureus
- D. Haemophilus influenzae
- E. Pseudomonas aeruginosa

**Correct Answer:** A

**Explanation:**

Gonococcal conjunctivitis: copious purulent discharge, rapid onset, bilateral, associated with urethral discharge (STI). Requires urgent corneal examination (risk of corneal perforation within hours). Treatment: systemic ceftriaxone 1g IM + topical penicillin/gentamicin. Chlamydial conjunctivitis is more indolent with mucoid discharge. GUM referral + partner notification. Eye swab for NAAT and culture.

---

## Question 4

Regarding chemical (alkali) eye injury, what is the FIRST and most important treatment?

- **A. Immediate copious irrigation with water or saline for at least 20-30 minutes**
- B. Topical anaesthetic drops then refer to ophthalmology
- C. Check pH and irrigate only if pH abnormal
- D. Neutralise alkali with dilute acid solution
- E. Cover with eye pad and transport to hospital

**Correct Answer:** A

**Explanation:**

Chemical eye injuries: Alkali burns (ammonia, lime, cement) penetrate deeper and faster than acids. IMMEDIATE irrigation is the single most important treatment - irrigate with water/saline at the scene (before transport). Continue irrigation for minimum 20-30 minutes in ED. Target conjunctival pH 7.4. Never attempt neutralisation. Remove contact lenses. Topical anaesthetic helps compliance. Urgent ophthalmology after pH normalises.

---

## Question 5

A 60-year-old presents with sudden painless loss of vision in one eye. Fundoscopy shows a pale retina with a cherry red spot at the macula. What is the diagnosis?

- **A. Central retinal artery occlusion (CRAO)**
- B. Central retinal vein occlusion
- C. Vitreous haemorrhage
- D. Retinal detachment
- E. Acute angle-closure glaucoma

**Correct Answer:** A

**Explanation:**

CRAO: sudden, painless, monocular vision loss, RAPD (relative afferent pupillary defect), pale/white retina (ischaemia), cherry-red spot at macula (choroidal circulation preserved). Treat within 90-120 minutes for chance of recovery (like stroke). Treatments: ocular massage, breathing into paper bag (hypercapnia causes vasodilation), IOP-lowering agents, aspirin. Urgent stroke pathway (25% have ipsilateral carotid stenosis, high stroke risk). RAPD = Marcus Gunn pupil.
$SBAQ0017$,
        false, 200, 'published', now(), now()
      );
    ELSE
      UPDATE "lessons" SET
        "title" = 'Acute Red Eye - SBA Quiz',
        "type" = 'quiz',
        "body" = $SBAQ0017$# Acute Red Eye - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 35-year-old contact lens wearer presents with acute onset severe eye pain, photophobia, reduced visual acuity, and a hypopyon. Slit-lamp shows a corneal ulcer. What is the priority management?

- **A. Stop contact lens use + urgent ophthalmology referral + corneal scraping for culture + topical fluoroquinolone antibiotics**
- B. Topical chloramphenicol and review in 1 week
- C. Topical steroids to reduce inflammation
- D. Systemic antibiotics only
- E. Patching the eye and analgesia

**Correct Answer:** A

**Explanation:**

Acanthamoeba/bacterial keratitis from contact lens use is an ocular emergency. Features: severe pain, photophobia, hypopyon (pus in anterior chamber). Immediate management: (1) Stop lenses, (2) Corneal scraping for microscopy/culture before antibiotics, (3) Intensive topical fluoroquinolone (ciprofloxacin/ofloxacin eye drops hourly), (4) Urgent ophthalmology. Steroids contraindicated until organism identified (worsen fungal/Acanthamoeba).

---

## Question 2

A 70-year-old presents with acute unilateral severe eye pain, red eye, haloes around lights, nausea, fixed mid-dilated pupil, and IOP 45 mmHg. What is the diagnosis and first-line treatment?

- **A. Acute angle-closure glaucoma - IV/oral acetazolamide + pilocarpine drops**
- B. Uveitis - topical steroids and mydriatics
- C. Orbital cellulitis - IV antibiotics
- D. Conjunctivitis - topical chloramphenicol
- E. Corneal ulcer - topical fluoroquinolones

**Correct Answer:** A

**Explanation:**

Acute angle-closure glaucoma: IOP >21 (typically >40 mmHg), fixed mid-dilated pupil (pupil dilation closes the angle), severe pain, haloes, N&V, visual impairment. Immediate treatment: IV acetazolamide 500mg (carbonic anhydrase inhibitor - reduces aqueous production), 2% pilocarpine drops to constrict pupil and open angle, IV mannitol if severe. Urgent ophthalmology for laser peripheral iridotomy.

---

## Question 3

A 25-year-old presents with gradual onset, painless, bilateral red eyes with bilateral mucopurulent discharge. He recently had a urethral discharge. What organism is most likely?

- **A. Neisseria gonorrhoeae**
- B. Chlamydia trachomatis
- C. Staphylococcus aureus
- D. Haemophilus influenzae
- E. Pseudomonas aeruginosa

**Correct Answer:** A

**Explanation:**

Gonococcal conjunctivitis: copious purulent discharge, rapid onset, bilateral, associated with urethral discharge (STI). Requires urgent corneal examination (risk of corneal perforation within hours). Treatment: systemic ceftriaxone 1g IM + topical penicillin/gentamicin. Chlamydial conjunctivitis is more indolent with mucoid discharge. GUM referral + partner notification. Eye swab for NAAT and culture.

---

## Question 4

Regarding chemical (alkali) eye injury, what is the FIRST and most important treatment?

- **A. Immediate copious irrigation with water or saline for at least 20-30 minutes**
- B. Topical anaesthetic drops then refer to ophthalmology
- C. Check pH and irrigate only if pH abnormal
- D. Neutralise alkali with dilute acid solution
- E. Cover with eye pad and transport to hospital

**Correct Answer:** A

**Explanation:**

Chemical eye injuries: Alkali burns (ammonia, lime, cement) penetrate deeper and faster than acids. IMMEDIATE irrigation is the single most important treatment - irrigate with water/saline at the scene (before transport). Continue irrigation for minimum 20-30 minutes in ED. Target conjunctival pH 7.4. Never attempt neutralisation. Remove contact lenses. Topical anaesthetic helps compliance. Urgent ophthalmology after pH normalises.

---

## Question 5

A 60-year-old presents with sudden painless loss of vision in one eye. Fundoscopy shows a pale retina with a cherry red spot at the macula. What is the diagnosis?

- **A. Central retinal artery occlusion (CRAO)**
- B. Central retinal vein occlusion
- C. Vitreous haemorrhage
- D. Retinal detachment
- E. Acute angle-closure glaucoma

**Correct Answer:** A

**Explanation:**

CRAO: sudden, painless, monocular vision loss, RAPD (relative afferent pupillary defect), pale/white retina (ischaemia), cherry-red spot at macula (choroidal circulation preserved). Treat within 90-120 minutes for chance of recovery (like stroke). Treatments: ocular massage, breathing into paper bag (hypercapnia causes vasodilation), IOP-lowering agents, aspirin. Urgent stroke pathway (25% have ipsilateral carotid stenosis, high stroke risk). RAPD = Marcus Gunn pupil.
$SBAQ0017$,
        "position" = 200,
        "status" = 'published',
        "updated_at" = now()
      WHERE "id" = v_lesson_id;
    END IF;

  END IF;  -- end module check


  -- =========================================================================
  -- Module: Urological Emergencies
  -- =========================================================================
  SELECT id INTO v_module_id FROM "modules"
  WHERE "course_id" = v_course_id AND "title" = 'Urological Emergencies' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    RAISE WARNING 'Module % not found in mrcem-sba, skipping...', 'Urological Emergencies';
  ELSE


    -- Quiz: Testicular Torsion - SBA Quiz (5 questions)
    SELECT id INTO v_lesson_id FROM "lessons"
    WHERE "module_id" = v_module_id AND "slug" = 'sba-quiz-testicular-torsion' AND "deleted_at" IS NULL LIMIT 1;
    IF v_lesson_id IS NULL THEN
      INSERT INTO "lessons" (
        "id", "module_id", "slug", "title", "type", "body",
        "is_free_preview", "position", "status", "created_at", "updated_at"
      ) VALUES (
        gen_random_uuid(), v_module_id, 'sba-quiz-testicular-torsion', 'Testicular Torsion - SBA Quiz', 'quiz',
        $SBAQ0018$# Testicular Torsion - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 16-year-old boy presents with sudden onset severe left testicular pain for 3 hours, with a high-riding left testis and absent cremasteric reflex. What is the management?

- **A. Immediate surgical exploration within 6 hours - do NOT wait for USS**
- B. Urgent scrotal ultrasound with Doppler first
- C. Antibiotics for epididymo-orchitis and review
- D. Analgesia and urology outpatient review
- E. Manual detorsion and elective orchidopexy later

**Correct Answer:** A

**Explanation:**

Testicular torsion is a surgical emergency. Testicular salvage rates: <6h=90-100%, 6-12h=50%, 12-24h=10%, >24h=minimal. Clinical diagnosis (sudden severe pain, high-riding testis, absent cremasteric reflex) mandates IMMEDIATE surgical exploration WITHOUT waiting for Doppler USS - USS may be falsely reassuring and delays surgery. Bilateral orchidopexy ('bell-clapper' deformity is bilateral). Never delay surgery for imaging.

---

## Question 2

A 30-year-old man presents with gradual onset testicular pain and swelling over 3 days, fever 38.2C, and dysuria. Examination shows tender epididymis and testis. What organism is most likely in this age group?

- **A. Chlamydia trachomatis**
- B. E. coli
- C. Neisseria gonorrhoeae
- D. Pseudomonas aeruginosa
- E. Streptococcus

**Correct Answer:** A

**Explanation:**

Epididymo-orchitis in sexually active men <35 years: most commonly caused by STIs - Chlamydia trachomatis (most common) and Neisseria gonorrhoeae. Treatment: doxycycline 100mg BD x 10-14 days + single dose IM ceftriaxone 500mg (for gonorrhoea cover). In men >35: E. coli and other coliform bacteria (associated with UTI/urinary tract abnormality). Treatment: quinolones (ciprofloxacin). GUM referral for STI screening.

---

## Question 3

A 25-year-old man has a painless, non-transilluminable firm mass in the left testis. What is the most likely diagnosis and immediate investigation?

- **A. Testicular tumour - urgent scrotal USS and tumour markers (AFP, bHCG, LDH)**
- B. Hydrocele - reassure
- C. Epididymal cyst - reassure and review
- D. Orchitis - antibiotics
- E. Varicocele - refer electively

**Correct Answer:** A

**Explanation:**

A firm, non-transilluminable testicular mass in a young man is testicular cancer until proven otherwise. Most common solid organ malignancy in men aged 15-35. Immediate investigations: Scrotal USS (high sensitivity/specificity), serum tumour markers: AFP (elevated in non-seminomatous GCT), bHCG (elevated in both seminoma and NSGCT), LDH. DO NOT biopsy percutaneously. Urgent urology referral for surgical orchidectomy via inguinal approach.

---

## Question 4

A 50-year-old man with known renal stones presents with severe right loin-to-groin pain, haematuria, and vomiting. CT KUB shows a 4mm stone at the right VUJ. What is the first-line management?

- **A. Analgesia (IV diclofenac or morphine) + alpha-blocker (tamsulosin) for medical expulsive therapy**
- B. Immediate ureteroscopy and stone removal
- C. ESWL (extracorporeal shockwave lithotripsy) urgently
- D. IV fluids to 'flush' the stone
- E. Urology admission and percutaneous nephrostomy

**Correct Answer:** A

**Explanation:**

Ureteric colic management: Analgesia first (IV diclofenac 75mg or IM diclofenac is first-line - NSAIDs superior to opiates for ureteric colic). Medical expulsive therapy: alpha-blocker tamsulosin 400mcg OD increases spontaneous passage of stones <10mm. Stones <5mm at VUJ have 90% chance of spontaneous passage. Indications for urgent urology: bilateral obstruction, infection (pyonephrosis), single kidney, failure to pass within 6 weeks.

---

## Question 5

A patient with a 7mm ureteric stone develops fever 39.5C, rigors, and right loin pain. WBC 18. What is the diagnosis and management?

- **A. Obstructive uropathy with pyonephrosis - emergency decompression + IV antibiotics**
- B. Ureteric colic with UTI - oral antibiotics and analgesia
- C. Pyelonephritis only - IV antibiotics
- D. Renal abscess - CT and percutaneous drainage
- E. Septic arthritis - IV antibiotics

**Correct Answer:** A

**Explanation:**

Infected obstructed kidney (pyonephrosis) = urological emergency. Stone + fever = sepsis until proven otherwise. Immediate: IV broad-spectrum antibiotics (e.g., piperacillin-tazobactam or meropenem + gentamicin), blood cultures, urgent urology for emergency decompression (percutaneous nephrostomy or ureteric stent). Do not delay drainage - infected obstruction can cause rapid renal destruction and septic shock. CT urogram confirms diagnosis.
$SBAQ0018$,
        false, 200, 'published', now(), now()
      );
    ELSE
      UPDATE "lessons" SET
        "title" = 'Testicular Torsion - SBA Quiz',
        "type" = 'quiz',
        "body" = $SBAQ0018$# Testicular Torsion - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 16-year-old boy presents with sudden onset severe left testicular pain for 3 hours, with a high-riding left testis and absent cremasteric reflex. What is the management?

- **A. Immediate surgical exploration within 6 hours - do NOT wait for USS**
- B. Urgent scrotal ultrasound with Doppler first
- C. Antibiotics for epididymo-orchitis and review
- D. Analgesia and urology outpatient review
- E. Manual detorsion and elective orchidopexy later

**Correct Answer:** A

**Explanation:**

Testicular torsion is a surgical emergency. Testicular salvage rates: <6h=90-100%, 6-12h=50%, 12-24h=10%, >24h=minimal. Clinical diagnosis (sudden severe pain, high-riding testis, absent cremasteric reflex) mandates IMMEDIATE surgical exploration WITHOUT waiting for Doppler USS - USS may be falsely reassuring and delays surgery. Bilateral orchidopexy ('bell-clapper' deformity is bilateral). Never delay surgery for imaging.

---

## Question 2

A 30-year-old man presents with gradual onset testicular pain and swelling over 3 days, fever 38.2C, and dysuria. Examination shows tender epididymis and testis. What organism is most likely in this age group?

- **A. Chlamydia trachomatis**
- B. E. coli
- C. Neisseria gonorrhoeae
- D. Pseudomonas aeruginosa
- E. Streptococcus

**Correct Answer:** A

**Explanation:**

Epididymo-orchitis in sexually active men <35 years: most commonly caused by STIs - Chlamydia trachomatis (most common) and Neisseria gonorrhoeae. Treatment: doxycycline 100mg BD x 10-14 days + single dose IM ceftriaxone 500mg (for gonorrhoea cover). In men >35: E. coli and other coliform bacteria (associated with UTI/urinary tract abnormality). Treatment: quinolones (ciprofloxacin). GUM referral for STI screening.

---

## Question 3

A 25-year-old man has a painless, non-transilluminable firm mass in the left testis. What is the most likely diagnosis and immediate investigation?

- **A. Testicular tumour - urgent scrotal USS and tumour markers (AFP, bHCG, LDH)**
- B. Hydrocele - reassure
- C. Epididymal cyst - reassure and review
- D. Orchitis - antibiotics
- E. Varicocele - refer electively

**Correct Answer:** A

**Explanation:**

A firm, non-transilluminable testicular mass in a young man is testicular cancer until proven otherwise. Most common solid organ malignancy in men aged 15-35. Immediate investigations: Scrotal USS (high sensitivity/specificity), serum tumour markers: AFP (elevated in non-seminomatous GCT), bHCG (elevated in both seminoma and NSGCT), LDH. DO NOT biopsy percutaneously. Urgent urology referral for surgical orchidectomy via inguinal approach.

---

## Question 4

A 50-year-old man with known renal stones presents with severe right loin-to-groin pain, haematuria, and vomiting. CT KUB shows a 4mm stone at the right VUJ. What is the first-line management?

- **A. Analgesia (IV diclofenac or morphine) + alpha-blocker (tamsulosin) for medical expulsive therapy**
- B. Immediate ureteroscopy and stone removal
- C. ESWL (extracorporeal shockwave lithotripsy) urgently
- D. IV fluids to 'flush' the stone
- E. Urology admission and percutaneous nephrostomy

**Correct Answer:** A

**Explanation:**

Ureteric colic management: Analgesia first (IV diclofenac 75mg or IM diclofenac is first-line - NSAIDs superior to opiates for ureteric colic). Medical expulsive therapy: alpha-blocker tamsulosin 400mcg OD increases spontaneous passage of stones <10mm. Stones <5mm at VUJ have 90% chance of spontaneous passage. Indications for urgent urology: bilateral obstruction, infection (pyonephrosis), single kidney, failure to pass within 6 weeks.

---

## Question 5

A patient with a 7mm ureteric stone develops fever 39.5C, rigors, and right loin pain. WBC 18. What is the diagnosis and management?

- **A. Obstructive uropathy with pyonephrosis - emergency decompression + IV antibiotics**
- B. Ureteric colic with UTI - oral antibiotics and analgesia
- C. Pyelonephritis only - IV antibiotics
- D. Renal abscess - CT and percutaneous drainage
- E. Septic arthritis - IV antibiotics

**Correct Answer:** A

**Explanation:**

Infected obstructed kidney (pyonephrosis) = urological emergency. Stone + fever = sepsis until proven otherwise. Immediate: IV broad-spectrum antibiotics (e.g., piperacillin-tazobactam or meropenem + gentamicin), blood cultures, urgent urology for emergency decompression (percutaneous nephrostomy or ureteric stent). Do not delay drainage - infected obstruction can cause rapid renal destruction and septic shock. CT urogram confirms diagnosis.
$SBAQ0018$,
        "position" = 200,
        "status" = 'published',
        "updated_at" = now()
      WHERE "id" = v_lesson_id;
    END IF;

  END IF;  -- end module check


  -- =========================================================================
  -- Module: Vascular Emergencies
  -- =========================================================================
  SELECT id INTO v_module_id FROM "modules"
  WHERE "course_id" = v_course_id AND "title" = 'Vascular Emergencies' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    RAISE WARNING 'Module % not found in mrcem-sba, skipping...', 'Vascular Emergencies';
  ELSE


    -- Quiz: Pulmonary Embolism - SBA Quiz (5 questions)
    SELECT id INTO v_lesson_id FROM "lessons"
    WHERE "module_id" = v_module_id AND "slug" = 'sba-quiz-pulmonary-embolism' AND "deleted_at" IS NULL LIMIT 1;
    IF v_lesson_id IS NULL THEN
      INSERT INTO "lessons" (
        "id", "module_id", "slug", "title", "type", "body",
        "is_free_preview", "position", "status", "created_at", "updated_at"
      ) VALUES (
        gen_random_uuid(), v_module_id, 'sba-quiz-pulmonary-embolism', 'Pulmonary Embolism - SBA Quiz', 'quiz',
        $SBAQ0019$# Pulmonary Embolism - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 55-year-old woman presents with sudden onset pleuritic chest pain and dyspnoea 5 days post-hip replacement. HR 110, BP 100/70, SpO2 90%. ECG shows sinus tachycardia and S1Q3T3. What is the MOST appropriate imaging?

- **A. CTPA (CT pulmonary angiography)**
- B. V/Q scan
- C. Chest X-ray
- D. Echo
- E. D-dimer only

**Correct Answer:** A

**Explanation:**

CTPA is the gold standard investigation for PE in haemodynamically stable patients. In massive PE (haemodynamically unstable) thrombolysis may be given without CTPA if high clinical suspicion and echo shows right heart strain. V/Q scan is an alternative when CTPA is contraindicated (allergy to contrast, renal impairment, pregnancy). D-dimer is only useful to EXCLUDE PE in low-probability patients (Wells score <4).

---

## Question 2

A 45-year-old with confirmed massive PE presents with BP 80/50, HR 128, oxygen therapy needed. What is the definitive treatment?

- **A. Systemic thrombolysis: alteplase 10mg IV bolus + 90mg over 2 hours**
- B. IV unfractionated heparin alone
- C. Enoxaparin 1.5mg/kg SC
- D. Emergency surgical pulmonary embolectomy
- E. Inferior vena cava filter

**Correct Answer:** A

**Explanation:**

Massive PE (haemodynamic instability - SBP <90 or drop >40, RV failure) = thrombolysis. Alteplase 10mg IV bolus + 90mg over 2 hours is standard. Contraindications to thrombolysis (prior haemorrhagic stroke, recent surgery/trauma) warrant consideration of surgical embolectomy or catheter-directed thrombolysis. UFH should be stopped during thrombolysis. IVC filters for recurrent PE despite anticoagulation or anticoagulation contraindicated.

---

## Question 3

Using the Wells score for PE, which combination gives a score of 7.5 (high probability)?

- **A. Clinical signs of DVT (3) + alternative diagnosis less likely (3) + HR >100 (1.5)**
- B. Immobilisation >3 days (1.5) + HR >100 (1.5) + surgery in last 4 weeks (1.5)
- C. Previous DVT (1.5) + haemoptysis (1) + malignancy (1)
- D. All three: clinical DVT signs + alternative less likely + HR >100
- E. Wells score is not used for PE - only DVT

**Correct Answer:** A

**Explanation:**

Wells PE score: Clinical DVT signs=3, PE most likely diagnosis=3, HR>100=1.5, Immobilisation/surgery within 4 weeks=1.5, Previous DVT/PE=1.5, Haemoptysis=1, Active malignancy=1. Score <2=low, 2-6=moderate, >6=high. Two-tier: >4=PE likely (CTPA), <=4=PE unlikely (D-dimer first). High probability without D-dimer first.

---

## Question 4

A 25-year-old woman on the COCP presents with a confirmed PE. What is the preferred long-term anticoagulation?

- **A. Apixaban 10mg BD for 7 days then 5mg BD for 3-6 months**
- B. Warfarin for 3-6 months with INR 2-3
- C. LMWH throughout (enoxaparin SC)
- D. Dabigatran 150mg BD for 6 months
- E. Aspirin 150mg OD for 12 months

**Correct Answer:** A

**Explanation:**

NICE NG158: DOACs (apixaban or rivaroxaban) are first-line for PE treatment. Apixaban: 10mg BD x7 days then 5mg BD x3-6 months. Rivaroxaban: 15mg BD x21 days then 20mg OD. COCP should be discontinued (increases thrombosis risk). DOACs preferred over warfarin (no INR monitoring, fewer drug interactions, non-inferior efficacy). LMWH is preferred in active malignancy (or edoxaban/rivaroxaban in cancer).

---

## Question 5

A patient with low-probability Wells score (<4) for PE has a D-dimer of 180 ng/ml (normal <500). What is the appropriate management?

- **A. PE excluded - no further investigation needed, consider alternative diagnoses**
- B. CTPA to confirm exclusion
- C. V/Q scan to confirm exclusion
- D. Start LMWH empirically pending further investigation
- E. Echocardiogram to look for RV strain

**Correct Answer:** A

**Explanation:**

NICE NG158: D-dimer is used as a 'rule out' test in low-probability/unlikely PE (Wells <4 or 2-level score 'PE unlikely'). D-dimer <500 ng/ml effectively excludes PE in this context (sensitivity >95%, negative predictive value >99%). No further imaging required. D-dimer is not useful in high-probability PE (CTPA directly) or in patients who are pregnant, postoperative, elderly, or with inflammatory conditions (high false-positive rate).
$SBAQ0019$,
        false, 200, 'published', now(), now()
      );
    ELSE
      UPDATE "lessons" SET
        "title" = 'Pulmonary Embolism - SBA Quiz',
        "type" = 'quiz',
        "body" = $SBAQ0019$# Pulmonary Embolism - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 55-year-old woman presents with sudden onset pleuritic chest pain and dyspnoea 5 days post-hip replacement. HR 110, BP 100/70, SpO2 90%. ECG shows sinus tachycardia and S1Q3T3. What is the MOST appropriate imaging?

- **A. CTPA (CT pulmonary angiography)**
- B. V/Q scan
- C. Chest X-ray
- D. Echo
- E. D-dimer only

**Correct Answer:** A

**Explanation:**

CTPA is the gold standard investigation for PE in haemodynamically stable patients. In massive PE (haemodynamically unstable) thrombolysis may be given without CTPA if high clinical suspicion and echo shows right heart strain. V/Q scan is an alternative when CTPA is contraindicated (allergy to contrast, renal impairment, pregnancy). D-dimer is only useful to EXCLUDE PE in low-probability patients (Wells score <4).

---

## Question 2

A 45-year-old with confirmed massive PE presents with BP 80/50, HR 128, oxygen therapy needed. What is the definitive treatment?

- **A. Systemic thrombolysis: alteplase 10mg IV bolus + 90mg over 2 hours**
- B. IV unfractionated heparin alone
- C. Enoxaparin 1.5mg/kg SC
- D. Emergency surgical pulmonary embolectomy
- E. Inferior vena cava filter

**Correct Answer:** A

**Explanation:**

Massive PE (haemodynamic instability - SBP <90 or drop >40, RV failure) = thrombolysis. Alteplase 10mg IV bolus + 90mg over 2 hours is standard. Contraindications to thrombolysis (prior haemorrhagic stroke, recent surgery/trauma) warrant consideration of surgical embolectomy or catheter-directed thrombolysis. UFH should be stopped during thrombolysis. IVC filters for recurrent PE despite anticoagulation or anticoagulation contraindicated.

---

## Question 3

Using the Wells score for PE, which combination gives a score of 7.5 (high probability)?

- **A. Clinical signs of DVT (3) + alternative diagnosis less likely (3) + HR >100 (1.5)**
- B. Immobilisation >3 days (1.5) + HR >100 (1.5) + surgery in last 4 weeks (1.5)
- C. Previous DVT (1.5) + haemoptysis (1) + malignancy (1)
- D. All three: clinical DVT signs + alternative less likely + HR >100
- E. Wells score is not used for PE - only DVT

**Correct Answer:** A

**Explanation:**

Wells PE score: Clinical DVT signs=3, PE most likely diagnosis=3, HR>100=1.5, Immobilisation/surgery within 4 weeks=1.5, Previous DVT/PE=1.5, Haemoptysis=1, Active malignancy=1. Score <2=low, 2-6=moderate, >6=high. Two-tier: >4=PE likely (CTPA), <=4=PE unlikely (D-dimer first). High probability without D-dimer first.

---

## Question 4

A 25-year-old woman on the COCP presents with a confirmed PE. What is the preferred long-term anticoagulation?

- **A. Apixaban 10mg BD for 7 days then 5mg BD for 3-6 months**
- B. Warfarin for 3-6 months with INR 2-3
- C. LMWH throughout (enoxaparin SC)
- D. Dabigatran 150mg BD for 6 months
- E. Aspirin 150mg OD for 12 months

**Correct Answer:** A

**Explanation:**

NICE NG158: DOACs (apixaban or rivaroxaban) are first-line for PE treatment. Apixaban: 10mg BD x7 days then 5mg BD x3-6 months. Rivaroxaban: 15mg BD x21 days then 20mg OD. COCP should be discontinued (increases thrombosis risk). DOACs preferred over warfarin (no INR monitoring, fewer drug interactions, non-inferior efficacy). LMWH is preferred in active malignancy (or edoxaban/rivaroxaban in cancer).

---

## Question 5

A patient with low-probability Wells score (<4) for PE has a D-dimer of 180 ng/ml (normal <500). What is the appropriate management?

- **A. PE excluded - no further investigation needed, consider alternative diagnoses**
- B. CTPA to confirm exclusion
- C. V/Q scan to confirm exclusion
- D. Start LMWH empirically pending further investigation
- E. Echocardiogram to look for RV strain

**Correct Answer:** A

**Explanation:**

NICE NG158: D-dimer is used as a 'rule out' test in low-probability/unlikely PE (Wells <4 or 2-level score 'PE unlikely'). D-dimer <500 ng/ml effectively excludes PE in this context (sensitivity >95%, negative predictive value >99%). No further imaging required. D-dimer is not useful in high-probability PE (CTPA directly) or in patients who are pregnant, postoperative, elderly, or with inflammatory conditions (high false-positive rate).
$SBAQ0019$,
        "position" = 200,
        "status" = 'published',
        "updated_at" = now()
      WHERE "id" = v_lesson_id;
    END IF;


    -- Quiz: Deep Vein Thrombosis - SBA Quiz (3 questions)
    SELECT id INTO v_lesson_id FROM "lessons"
    WHERE "module_id" = v_module_id AND "slug" = 'sba-quiz-deep-vein-thrombosis' AND "deleted_at" IS NULL LIMIT 1;
    IF v_lesson_id IS NULL THEN
      INSERT INTO "lessons" (
        "id", "module_id", "slug", "title", "type", "body",
        "is_free_preview", "position", "status", "created_at", "updated_at"
      ) VALUES (
        gen_random_uuid(), v_module_id, 'sba-quiz-deep-vein-thrombosis', 'Deep Vein Thrombosis - SBA Quiz', 'quiz',
        $SBAQ0020$# Deep Vein Thrombosis - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 50-year-old presents with a swollen, tender right calf for 2 days. Wells DVT score is 3 (likely DVT). What is the next step?

- **A. Proximal USS same-day or DOAC empirically if USS not available same-day**
- B. D-dimer test first
- C. CTPA to exclude PE
- D. MRI venography
- E. Compression bandage only and GP review

**Correct Answer:** A

**Explanation:**

NICE NG158 DVT pathway: Wells DVT score 2+ (likely) -> proximal leg USS. If USS positive = confirmed DVT, start anticoagulation. If USS unavailable same-day: start DOAC empirically and arrange USS within 24 hours. Wells score 1- (unlikely) -> D-dimer first; if elevated -> USS. Treat confirmed DVT with DOAC (rivaroxaban/apixaban) for 3-6 months.

---

## Question 2

A 35-year-old pregnant woman develops a confirmed left leg DVT. Which anticoagulant is recommended?

- **A. LMWH (e.g., enoxaparin) throughout pregnancy and 6 weeks postpartum**
- B. Warfarin throughout pregnancy
- C. Apixaban throughout pregnancy
- D. Aspirin only
- E. Fondaparinux

**Correct Answer:** A

**Explanation:**

Pregnancy: DOACs (apixaban, rivaroxaban, dabigatran, edoxaban) are CONTRAINDICATED in pregnancy and breastfeeding (teratogenic or insufficient safety data). Warfarin is teratogenic in first trimester and causes fetal haemorrhage. LMWH (weight-adjusted enoxaparin) is safe throughout pregnancy. Continue LMWH for 6 weeks postpartum minimum. Fondaparinux is used if LMWH allergy (crosses placenta but limited evidence of fetal harm).

---

## Question 3

A patient on enoxaparin develops DVT despite therapeutic dosing. Anti-Xa levels are in range. What is the most likely explanation in a cancer patient?

- **A. Cancer-associated thrombosis (hypercoagulable state) - escalate LMWH or switch to DOAC (edoxaban/rivaroxaban)**
- B. Non-compliance with injections
- C. Protein C deficiency
- D. Anti-phospholipid syndrome
- E. Heparin-induced thrombocytopenia (HIT)

**Correct Answer:** A

**Explanation:**

Cancer-associated thrombosis (CAT) has the highest risk of VTE recurrence (up to 20% despite anticoagulation). If DVT occurs on therapeutic LMWH in cancer patients, options include: increase LMWH dose by 20-25%, or switch to a DOAC (edoxaban or rivaroxaban - both have evidence in CAT). The treatment duration is usually the duration of active cancer or active treatment. Anticoagulant choice should be patient/tumour specific.
$SBAQ0020$,
        false, 210, 'published', now(), now()
      );
    ELSE
      UPDATE "lessons" SET
        "title" = 'Deep Vein Thrombosis - SBA Quiz',
        "type" = 'quiz',
        "body" = $SBAQ0020$# Deep Vein Thrombosis - SBA Quiz

> [!NOTE]
> **Instructions:** Single Best Answer questions. Each question has one correct answer.
> Select the best option based on current UK emergency medicine guidelines.

---

## Question 1

A 50-year-old presents with a swollen, tender right calf for 2 days. Wells DVT score is 3 (likely DVT). What is the next step?

- **A. Proximal USS same-day or DOAC empirically if USS not available same-day**
- B. D-dimer test first
- C. CTPA to exclude PE
- D. MRI venography
- E. Compression bandage only and GP review

**Correct Answer:** A

**Explanation:**

NICE NG158 DVT pathway: Wells DVT score 2+ (likely) -> proximal leg USS. If USS positive = confirmed DVT, start anticoagulation. If USS unavailable same-day: start DOAC empirically and arrange USS within 24 hours. Wells score 1- (unlikely) -> D-dimer first; if elevated -> USS. Treat confirmed DVT with DOAC (rivaroxaban/apixaban) for 3-6 months.

---

## Question 2

A 35-year-old pregnant woman develops a confirmed left leg DVT. Which anticoagulant is recommended?

- **A. LMWH (e.g., enoxaparin) throughout pregnancy and 6 weeks postpartum**
- B. Warfarin throughout pregnancy
- C. Apixaban throughout pregnancy
- D. Aspirin only
- E. Fondaparinux

**Correct Answer:** A

**Explanation:**

Pregnancy: DOACs (apixaban, rivaroxaban, dabigatran, edoxaban) are CONTRAINDICATED in pregnancy and breastfeeding (teratogenic or insufficient safety data). Warfarin is teratogenic in first trimester and causes fetal haemorrhage. LMWH (weight-adjusted enoxaparin) is safe throughout pregnancy. Continue LMWH for 6 weeks postpartum minimum. Fondaparinux is used if LMWH allergy (crosses placenta but limited evidence of fetal harm).

---

## Question 3

A patient on enoxaparin develops DVT despite therapeutic dosing. Anti-Xa levels are in range. What is the most likely explanation in a cancer patient?

- **A. Cancer-associated thrombosis (hypercoagulable state) - escalate LMWH or switch to DOAC (edoxaban/rivaroxaban)**
- B. Non-compliance with injections
- C. Protein C deficiency
- D. Anti-phospholipid syndrome
- E. Heparin-induced thrombocytopenia (HIT)

**Correct Answer:** A

**Explanation:**

Cancer-associated thrombosis (CAT) has the highest risk of VTE recurrence (up to 20% despite anticoagulation). If DVT occurs on therapeutic LMWH in cancer patients, options include: increase LMWH dose by 20-25%, or switch to a DOAC (edoxaban or rivaroxaban - both have evidence in CAT). The treatment duration is usually the duration of active cancer or active treatment. Anticoagulant choice should be patient/tumour specific.
$SBAQ0020$,
        "position" = 210,
        "status" = 'published',
        "updated_at" = now()
      WHERE "id" = v_lesson_id;
    END IF;

  END IF;  -- end module check


END $$;
