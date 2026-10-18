-- ==========================================================================
-- COURSE SEED: MRCEM Primary: Emergency Pharmacology & Toxicology
-- Generated with 100% full curriculum text & embedded clinical illustrations
-- ==========================================================================
DO $$
DECLARE
  v_exam_id uuid;
  v_course_id uuid;
  v_module_id uuid;
  v_whatsapp_plan_id uuid;
  v_primary_plan_id uuid;
  v_all_access_plan_id uuid;
BEGIN
  -- 1. Locate MRCEM Primary exam
  SELECT id INTO v_exam_id FROM "exams" WHERE "slug" = 'mrcem-primary' LIMIT 1;

  -- 2. Upsert Course: mrcem-pharmacology
  SELECT id INTO v_course_id FROM "courses" WHERE "slug" = 'mrcem-pharmacology' LIMIT 1;
  IF v_course_id IS NULL THEN
    INSERT INTO "courses" (
      "id", "exam_id", "slug", "title", "summary", "description", "is_free", "position", "status", "created_at", "updated_at"
    ) VALUES (
      gen_random_uuid(),
      v_exam_id,
      'mrcem-pharmacology',
      'MRCEM Primary: Emergency Pharmacology & Toxicology',
      'High-yield pharmacology of emergency resuscitation drugs, cardiovascular agents, analgesics, anesthetics, and acute toxidromes.',
      'Essential pharmacokinetics, mechanisms of action, adverse effects, and overdose management for emergency physicians. Covers bronchodilators, antiplatelets, anesthetics, and emergency antidotes.',
      false,
      4,
      'published',
      now(),
      now()
    ) RETURNING "id" INTO v_course_id;
  ELSE
    UPDATE "courses" SET
      "title" = 'MRCEM Primary: Emergency Pharmacology & Toxicology',
      "exam_id" = COALESCE(v_exam_id, "exam_id"),
      "summary" = 'High-yield pharmacology of emergency resuscitation drugs, cardiovascular agents, analgesics, anesthetics, and acute toxidromes.',
      "description" = 'Essential pharmacokinetics, mechanisms of action, adverse effects, and overdose management for emergency physicians. Covers bronchodilators, antiplatelets, anesthetics, and emergency antidotes.',
      "position" = 4,
      "status" = 'published',
      "deleted_at" = NULL,
      "updated_at" = now()
    WHERE "id" = v_course_id;
  END IF;

  -- ==========================================================================
  -- Module 1: Respiratory Pharmacology & Asthma Management (5 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Respiratory Pharmacology & Asthma Management' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Respiratory Pharmacology & Asthma Management', 0, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 0, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Anaphylaxis Management (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'anaphylaxis-management',
    'Anaphylaxis Management',
    'article',
    '# Anaphylaxis Management

- Anaphylaxis
>It''s a severe, life-threatening, generalized or systemic
hypersensitivity reaction, characterized by rapidly developing
and life-threatening airway, breathing and/or circulation
problems, usually associated with skin and mucosal changes.
- Causes
- Medication:
>Antibiotic (penicillin most common)

## >Nsaid

>Aspirin

## >Acei

>Anesthetic agent e.g.: muscle relaxant (Suxamethonium and
rocuronium) and contrast media
- Others
>Food: e.g.: peanut, egg seafood (most common in children).
>Insect sting

![Anaphylaxis Management - Clinical Figure 1](/lessons/images/respiratory-pharmacology-asthma-management/anaphylaxis-management/figure_01_p1.png)
*Anaphylaxis Management — Clinical Figure 1 (Page 1 Reference)*

>latex
>idiopathic
>C1 esterase etc.
- Management
- Key points
- Anaphylactic likely when following 3 criteria match:
> 1: Acute onset of illness with a sudden progression.
> 2: Life-threatening airway and/or breathing and/or circulation
problem.
> 3: Possible skin or mucosal changes (although these may be
absent and are not required for diagnosis).
>there is no role of antihistamine however it may
help alleviate cutaneous symptoms.
>The routine use of corticosteroids to treat anaphylaxis is not
advised. If the patient is suffering from ongoing asthma/shock
after initial resuscitation steroids may be considered.
>Use glucagon in patients who are taking beta blockers may
be resistant to the therapeutic effects of adrenaline.
>Adrenaline : can give second dose if reaction persist after 5
minutes interval. After 2 doses, adrenaline infusion should be
started.

![Anaphylaxis Management - Clinical Figure 2](/lessons/images/respiratory-pharmacology-asthma-management/anaphylaxis-management/figure_02_p2.png)
*Anaphylaxis Management — Clinical Figure 2 (Page 2 Reference)*

>Nice recommend: consider fast-track discharge after 2 hours
observation from resolution of anaphylaxis if : Good response
(within 5-10 minutes) to a singles dose of adrenaline given
within 30 minutes of onset of reaction and complete resolution
of symptoms and Pt already has unused adrenaline auto-
injectors and has been trained how to use them.
>6 hours observation: those pt who has 2 doses of IM
adrenaline or previous biphasic reaction.
>12 hours observation: those pt who has required more than
two doses of adrenaline, has severe asthma or their reaction
has involved severe respiratory compromise.
>The frequency of food sensitization in asthmatic children is
higher than expected in a general population. it has been
found that asthma is a risk factor for severe or fatal
anaphylactic reactions to foods
>Investigation : resus council recommend 3 tryptase level. First
as resuscitation started, 2nd 1-2 hours after symptoms started.
24 hours later.
- Anaphylactoid vs anaphylaxis:
>Anaphylactoid reaction: first time exposure to allergen, direct
release of histamine and other mediators from mast cells and
doesn''t cause degranulation. Non-immune (IgE) mediated
reaction.
>Anaphylaxis reaction: On further exposure to that allergen,
the responsible allergenic antigen binds to an antigen-specific
IgE antibody, leading to mast cell degranulation Histamine and
other mediators, including leukotrienes and cytokines are
released from mast cells and basophils following exposure to
this antigen.
>Summary: anaphylactoid first exposure and non-immune
mediated
>Anaphylaxis: further exposure/ Pt has exposed to allergen
previously (history) and immune mediated.',
    true,
    0,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Lesson: Anti - Histamine Drugs (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'anti-histamine-drugs',
    'Anti - Histamine Drugs',
    'article',
    '# Anti - Histamine Drugs

Anti histamine:
Block H1 histamine receptors
Indications:
Allergic rhinitis
Urticaria
Pruritis
Insect bites and stings
Anaphylaxis
Angioedema
Nausea and vomiting
Motion sickness and vertigo
Insomnia
Divided into 2 groups:

![Anti - Histamine Drugs - Clinical Figure 1](/lessons/images/respiratory-pharmacology-asthma-management/anti-histamine-drugs/figure_01_p1.png)
*Anti - Histamine Drugs — Clinical Figure 1 (Page 1 Reference)*',
    false,
    1,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Lesson: Asthma in Adults Management (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'asthma-in-adults-management',
    'Asthma in Adults Management',
    'article',
    '# Asthma in Adults Management

Levels of severity of acute asthma
attacks in adults
Example -1 : In exam, if they give you a scenario that a 34-
year-old asthma patient who is unable to complete a
sentence in one breath, his HR is 115 beats/min and SpO2 91%.
How would you classify the severity of asthma in this patient?
Answer: Life-threatening asthma
Explanation: Any patient with features of acute severe
asthma along with any one feature of life-threatening
asthma (as in above scenario his saturation is below <92%)
would be classified as having life-threatening asthma.

![Asthma in Adults Management - Clinical Figure 1](/lessons/images/respiratory-pharmacology-asthma-management/asthma-in-adults-management/figure_01_p1.png)
*Asthma in Adults Management — Clinical Figure 1 (Page 1 Reference)*

Management of acute asthma in
adults in the emergency department
Discharge plan
In all patients who received nebulized β 2 bronchodilator prior
to presentation, consider an extended observation period
prior to discharge.
If PEF <50% on presentation, give prednisolone 40-50
mg/day until recovery (minimum 5 days).
In all patients ensure treatment supply of inhaled steroid and
β 2 bronchodilator and check inhaler technique
Arrange GP follow-up within 2 working days post-discharge.
Fax or email discharge letter to GP
Refer to asthma liaison nurse/chest clinic.

![Asthma in Adults Management - Clinical Figure 2](/lessons/images/respiratory-pharmacology-asthma-management/asthma-in-adults-management/figure_02_p2.png)
*Asthma in Adults Management — Clinical Figure 2 (Page 2 Reference)*',
    false,
    2,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Lesson: Bronchodilator Drugs (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'bronchodilator-drugs',
    'Bronchodilator Drugs',
    'article',
    '# Bronchodilator Drugs

Bronchodilator therapy:
Note: Important points of theophylline:
Theophylline has narrow window between therapeutic and
toxic doses, and the half-life can be affected by a number of
factors, making a therapeutic dose difficult to achieve. It is
advised that serum levels of 10-20 mg/I six to eight hours after
the last tablet should be aimed for.
Factors that increase the half-life of theophylline include:
Heart failure
Cirrhosis
Viral infection
Drugs (Enzyme inhibitors)
Factors that decrease the half-life of theophylline include:
Smoking
Heavy drinking
Drugs (Enzyme inducers)
Enzyme inducers and Enzyme inhibitors

![Bronchodilator Drugs - Clinical Figure 1](/lessons/images/respiratory-pharmacology-asthma-management/bronchodilator-drugs/figure_01_p1.png)
*Bronchodilator Drugs — Clinical Figure 1 (Page 1 Reference)*

Aminophylline:
Aminophylline is a compound of theophylline with
ethylenediamine in a 2:1 ratio. The ethylenediamine improves
its solubility. It is less potent and shorter acting than
theophylline.
It is used in the treatment of:
Asthma

## Copd

Heart failure
Bradycardias
Note: Aminophylline has mild positive inotropic and
chronotropic effects, producing an increase in cardiac output
and a decrease in systemic vascular resistance, leading to a
decrease in arterial blood pressure. It has been used historically
in the treatment of refractory heart failure and is
recommended by the current ALS guidelines as an alternative
treatment for bradycardias.

![Bronchodilator Drugs - Clinical Figure 2](/lessons/images/respiratory-pharmacology-asthma-management/bronchodilator-drugs/figure_02_p2.png)
*Bronchodilator Drugs — Clinical Figure 2 (Page 2 Reference)*',
    false,
    3,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Lesson: Corticosteroids (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'corticosteroids',
    'Corticosteroids',
    'article',
    '# Corticosteroids

Corticosteroids:
Corticosteroids are a class of steroid hormones that are
naturally produced in the adrenal cortex as well
as administered as medications for therapeutic purposes.
We have already discussed naturally produced corticosteroids
in physiology. Now we will discuss in detail pharmacology of
administrated steroids.
Naturally occurring Classes of corticosteroids: Glucocorticoids
and mineralocorticoids, are involved in a wide range of
physiological processes, including stress response,
immune response, and regulation of inflammation.
Classification of administrated steroids:
Inhaled steroids: (beclomethasone, budesonide, fluticasone)
Uses: Prophylaxis in chronic asthma if: Exacerbations in last
2 years requiring systemic corticosteroid or nebulized
bronchodilator or B-agonists used more than twice per
week or Symptoms disturb sleep more than twice per week.
Hay fever (Nasal spray)

## Copd

Side effects: Rare which include Oral candidiasis, hoarseness
and sore mouth.
Note:  In high doses systemic adverse effects can occur which
include Adrenal suppression, Osteoporosis and Glaucoma.
Oral and injectable corticosteroids:
Oral and intravenous steroids: (prednisolone, dexamethasone,
hydrocortisone).
Specific uses:

Prednisolone: Has mainly glucocorticoid action 4 times more
potent than hydrocortisone primary used for disease
suppression in autoimmune/Rheumatoid conditions, Temporal
arteritis, Asthma and acute adrenal insufficiency.
Hydrocortisone: Short acting primarily known for its
glucocorticoid activity, but it also possesses mineralocorticoid
activity. Because of mineralocorticoid effect result into fluid
retention means unsuitable for long-term treatment for
disease suppression but is used long-term with fludrocortisone
in adrenal suppression.
Uses:
Adrenal insufficiency
Addison''s disease
Acute allergy
Asthma
Shock
Angioedema
Hypersensitivity reactions
Severe inflammatory bowel disease
Rheumatic disease
Dexamethasone: Long acting primarily known for its very high
glucocorticoid activity and insignificant mineralocorticoid
activity.
Uses:
Cerebral oedema
Perioperatively
Inflammatory disorders
Croup
Intractable nausea
Diagnosis of Cushing''s syndrome (Overnight Dexamethasone
suppression test)
Temporal arteritis
Side effects
Patients on long-term steroid use are at risk of the following:

Adrenal suppression: In long-term use, e.g., prednisolone
>7.5mg a day →  adrenal atrophy due to corticotrophin
suppression, therefore, withdraw steroid slowly to prevent
Addisonian crisis
Steroids should be doubled in times of stress/illness (unless on
high dose) because the body cannot respond to increased
requirements, to prevent Addisonian crisis .
Infections: Due to the suppression of the inflammatory
response patients are more susceptible to infection.
Reactivation of dormant infections, e.g., TB, may occur.
Complications:
Patients who are not immune to chicken pox (not previously
infected) are at risk of severe chicken pox, with complications
such as encephalitis, pneumonia, and hepatitis. Varicella
zoster immunoglobulin is required for postexposure
prophylaxis; this provides passive immunity.
Patients should also be advised to avoid exposure to measles
and should receive postexposure immunoglobulin within 72
hours if they are exposed.
All patients on long-term steroids should carry a ''steroid card''
to inform medical practitioners that they are on steroids or
have been on steroids (for up to a year as adrenal suppression
can be prolonged).',
    false,
    4,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- ==========================================================================
  -- Module 2: Cardiovascular Pharmacology & Anticoagulants (8 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Cardiovascular Pharmacology & Anticoagulants' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Cardiovascular Pharmacology & Anticoagulants', 1, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 1, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Anti - Platelet, Statins, Nitrate and Fibrinolytic Drugs (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'anti-platelet-statins-nitrate-and-fibrinolytic-drugs',
    'Anti - Platelet, Statins, Nitrate and Fibrinolytic Drugs',
    'article',
    '# Anti - Platelet, Statins, Nitrate and Fibrinolytic Drugs

Anti-platelet, Statins, nitrate and
fibrinolytic drugs:

![Anti - Platelet, Statins, Nitrate and Fibrinolytic Drugs - Clinical Figure 1](/lessons/images/cardiovascular-pharmacology-anticoagulants/anti-platelet-statins-nitrate-and-fibrinolytic-drugs/figure_01_p1.png)
*Anti - Platelet, Statins, Nitrate and Fibrinolytic Drugs — Clinical Figure 1 (Page 1 Reference)*',
    true,
    0,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Lesson: Anticoagulant Drugs (3 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'anticoagulant-drugs',
    'Anticoagulant Drugs',
    'article',
    '# Anticoagulant Drugs

Antiplatelet and anticoagulant
drugs
Anticoagulant drugs
Heparin:
Heparin is used for:
Prevention and treatment of DVT and Pulmonary embolism
Treatment of disseminated intravascular coagulation .
Heparin side effects:
Heparin induced thrombocytopenia .
Bleeding
Osteoporosis
Alopecia
Hyperkalemia
Contraindications:
People with active bleeding history or active peptic or
duodenal ulcer
Previous history of Heparin induced thrombocytopenia .

![Anticoagulant Drugs - Clinical Figure 1](/lessons/images/cardiovascular-pharmacology-anticoagulants/anticoagulant-drugs/figure_01_p1.png)
*Anticoagulant Drugs — Clinical Figure 1 (Page 1 Reference)*

Low molecular weight heparin vs Un
fractioned heparin:
Warfarin:
Warfarin is vitamin K antagonist acts by inhibiting vitamin K
dependent clotting factors (ii, vii, ix and x) or simply

> [!NOTE]
> **remember 27910 (Mnemonic) as well as anticoagulant protein**
C and S
Indications:
Prophylaxis and treatment of venous thromboembolism
Prophylaxis in atrial fibrillation
Prophylaxis in people with Mechanical Heart Valves
Side effects:
Bleeding is the most common adverse feature .
Narrow Therapeutic Window: Warfarin has a narrow
therapeutic window, meaning that even small fluctuations in
dosage can lead to a significant change in its anticoagulant
effects. Maintaining the correct INR range is crucial for
optimal benefit and to avoid complications.
Skin Necrosis and Purple Toe Syndrome
Nausea, vomiting , Diarrhea, Rash, jaundice, hepatic
dysfunction and pancreatitis
Warfarin in pregnancy: If given in 1st trimester may cause fetal
warfarin syndrome (nasal hypoplasia, bone stippling, bilateral
optic atrophy and intellectual disability)
If given in 2nd or 3rd trimester can cause optic atrophy,
cataracts, microcephaly, microphthalmia, intellectual disability
and fetal and/or maternal haemorrhage.

![Anticoagulant Drugs - Clinical Figure 2](/lessons/images/cardiovascular-pharmacology-anticoagulants/anticoagulant-drugs/figure_02_p2.png)
*Anticoagulant Drugs — Clinical Figure 2 (Page 2 Reference)*

Contraindications:
Active bleeding
Active peptic ulcer
Bleeding disorders (ITP, Haemophilia)
Pregnancy
Recent trauma or surgery
Monitoring: Both PT and aPTT are prolonged after warfarin
administration but PT is more prolonged. Warfarin therapy is
typically monitored using the prothrombin time (PT) test
along with the International Normalized Ratio (INR), rather
than the activated partial thromboplastin time  (aPTT)  test.
The target International Normalized Ratio (INR) value for
warfarin therapy varies depending on the medical condition
being treated. Warfarin therapy can be withhold or omitted if
INR rises above the range. Phytomenadione (Vitamin K)
antidote used to reverse the bleeding. Dried prothrombin
complex consists of factors ii, vii, ix and x can also be given in
major bleeding if prothrombin complex unavailable give
fresh frozen plasma
(High yield )
Managing the patients with increased INR and bleeding
If INR> 8 and no bleeding = Phytomenadione orally
If INR> 8 and minor bleeding = Phytomenadione Iv
If INR> 8 and major bleeding = Phytomenadione Iv and dried
prothrombin complex (Recall)
If INR 5-8 and no bleeding = Withhold warfarin
If INR 5-8 and minor bleeding = Phytomenadione Iv
Metabolism: Warfarin undergoes extensive metabolism in the
liver via the cytochrome P450 enzyme system, mainly through
the CYP2C9 enzyme.  cytochrome P450 enzyme inducer drugs
increase rate of metabolism and hepatic clearance of
concurrently administrated drugs which typically results in
decreased pharmacologic effects and decreasing
anticoagulant effects of warfarin. While enzyme inhibitor
drugs decrease hepatic clearance and increase pharmacologic
effect/increased anticoagulant effects and risk of bleeding.

![Anticoagulant Drugs - Clinical Figure 3](/lessons/images/cardiovascular-pharmacology-anticoagulants/anticoagulant-drugs/figure_03_p4.png)
*Anticoagulant Drugs — Clinical Figure 3 (Page 4 Reference)*',
    false,
    1,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Lesson: Basic Life Support and Advanced Life Support (3 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'basic-life-support-and-advanced-life-support',
    'Basic Life Support and Advanced Life Support',
    'article',
    '# Basic Life Support and Advanced Life Support

Basic life support and Advanced life
support algorithms
- Key difference b/w Paeds &
adult ALS

![Basic Life Support and Advanced Life Support - Clinical Figure 1](/lessons/images/cardiovascular-pharmacology-anticoagulants/basic-life-support-and-advanced-life-support/figure_01_p1.png)
*Basic Life Support and Advanced Life Support — Clinical Figure 1 (Page 1 Reference)*

![Basic Life Support and Advanced Life Support - Clinical Figure 2](/lessons/images/cardiovascular-pharmacology-anticoagulants/basic-life-support-and-advanced-life-support/figure_02_p1.png)
*Basic Life Support and Advanced Life Support — Clinical Figure 2 (Page 1 Reference)*

- Identify and treat reversible causes
Hypoxia
Hypovolemia (massive blood/fluid loss).
Hyperkalemia (renal patient).
Hypothermia (Pt may require prolong CPR).
Intubated Pt (tracheal tube may lie below the cord.
Thrombosis (massive PE if that''s the cause of cardiac arrest
then consider 50mg alteplase).
Tension pneumothorax following central line insertion.
Cardiac tamponade should always consider in penetration
injury.
After ROSC
Use an ABCDE approach.
Aim for SpO2 of 94-98% and normal PaCO2
12-lead ECG
Identify and treat the cause.
Targeted temperature management

![Basic Life Support and Advanced Life Support - Clinical Figure 3](/lessons/images/cardiovascular-pharmacology-anticoagulants/basic-life-support-and-advanced-life-support/figure_03_p2.png)
*Basic Life Support and Advanced Life Support — Clinical Figure 3 (Page 2 Reference)*',
    false,
    2,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Lesson: Betablocker and Calcium Channel Blockers (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'betablocker-and-calcium-channel-blockers',
    'Betablocker and Calcium Channel Blockers',
    'article',
    '# Betablocker and Calcium Channel Blockers

Beta blockers and calcium channel
blockers overview:
Labetalol: Labetalol is nonselective alpha and betablocker
commonly used to manage high blood pressure, especially in
hypertensive emergencies
Labetalol is used in the treatment of pheochromocytoma
together with alpha blocker.

> [!TIP]
> **High yield:**
> Antiarrhythmic drugs mechanism of action:
> (High Yield)
> Adenosine: Opens K+ channels in heart, slowing conduction
> in the AV node.

Digoxin Inhibits the Na/K ATPase in cardiac myocytes.

![Betablocker and Calcium Channel Blockers - Clinical Figure 1](/lessons/images/cardiovascular-pharmacology-anticoagulants/betablocker-and-calcium-channel-blockers/figure_01_p1.png)
*Betablocker and Calcium Channel Blockers — Clinical Figure 1 (Page 1 Reference)*

Flecainide Blocks Na+ channel in heart, slowing conduction
of the cardiac impulse.
Lidocaine Blocks Na+ channels in heart, slowing conduction
of the cardiac impulse.
Sotalol: Blocks beta-adrenoreceptors and K+ channels,
reducing heart rate and slowing conduction in the AV node.
Verapamil Blocks Ca2+ channels in heart, slowing conduction
in the AV node.
Amiodarone: Blocks Na+ and K+ channels and beta
adrenoreceptors prolonging phase 3 of cardiac action
potential and slowing conduction at SA and AV nodes.',
    false,
    3,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Lesson: Bradycardias (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'bradycardias',
    'Bradycardias',
    'article',
    '# Bradycardias

Definition
Bradycardia is a heart rate of fewer than 60 beats per minute.
Types
Sinus bradycardia
Sinus arrest
Junctional bradycardia
Atrioventricular blocks:
First degree
Second degree (Mobitz types I and II)
Third-degree (complete heart block)
Causes
Normal physiological variants as seen in athletes
Cardiac causes (ischemic & structural heart disease)
Infectious
Systemic illness (hypothyroidism, hypothermia)
Autonomic mediated (carotid hypersensitivity, vasovagal
syncope)
Head injury
Hyper-hypokalaemia
Drugs (High yield)
Beta-blockers
CCB
Amitriptyline
Quinidine
Clonidine
Digoxin
Organophosphate

Management approach (unstable Pt)
The ALS bradycardia algorithm recommends Atropine 500
mcg IV up to 3mg maximum if any Pt presents with the
following:
Adverse features or risk of asystole:
Shock
Syncope
Myocardial ischemia
Heart failure
Risk of asystole:
Recent asystole
Mobiztype-2 Av block
Complete heart block
Ventricular pause >3 seconds
Bradycardia (Resus council of the UK and European
resuscitation council guideline)
If bradycardia is accompanied by adverse signs (Shock,
Syncope, Myocardial ischaemia ,Heart failure as mentioned
above) give atropine 500mcg IV (IO) and, if necessary, repeat
every 3 - 5 min to a total of 3 mg.
If treatment with atropine is ineffective
consider second line drugs: These include isoprenaline
(5mcg starting dose), and adrenaline (2 -10mcg).
Consider giving glucagon if beta-blockers or calcium channel
blockers are a potential cause of the bradycardia.
Consider pacing in patients who are unstable, with
symptomatic bradycardia refractory to drug therapies.
If transthoracic pacing is ineffective, consider transvenous
pacing.
Atropine
Atropine antagonises the action of the parasympathetic
neurotransmitter acetylcholine at muscarinic receptors. It
therefore blocks the effects of the vagus nerve on both the SA
node and
the AV node, increasing sinus automaticity and facilitating AV node conduction.
Side effects: (Anti-muscarinic effects)
- Dry mouth
- Nausea and vomiting
- Blurred vision
- Urinary retention
- Tachyarrhythmias
Note: Anti-muscarinic should be avoided in Myasthenia
gravis, paralytic ileus, GI obstruction, Urinary retention and
prostatic enlargement',
    false,
    4,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Lesson: Digoxin (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'digoxin',
    'Digoxin',
    'article',
    '# Digoxin

Digoxin
Digoxin is a cardiac glycoside derived from the
plant foxglove that primarily works by inhibiting the Na+/K+
ATPase in the myocardium.
Mechanism: Digoxin has positive inotropic effects and
negative chronotropic effects
Binds to and inhibits the Na+/K+ pump on the myocyte cell
membrane (competes with the K+ ion) Increases
intracellular Na+ concentration.
Reduces the extrusion of intracellular Ca2+ via the Na+/Ca2+
exchange transporter Increased Ca2+ is stored in
the sarcoplasmic reticulum Increased amounts of Ca2+
released during each action potential force of
contraction increased .
Digoxin also increases vagal tone by enhancing Ach release at
muscarinic receptors, thus slowing the heart
rate, atrioventricular (AV) conduction, and the AV nodal
refractory period.
Indications: Heart failure, persistent and permanent atrial
fibrillation and flutter.
Note: In heart failure digoxin is useful in patient with reduced
ejection fraction, with an ejection fraction below 40%. However,
it has no benefit in mortality reduction.
Digoxin can only be used as monotherapy in sedentary
patients because it controls ventricular response at rest.
Monitoring: Digoxin has narrow therapeutic index.
Narrow therapeutic index means difference between the
effective therapeutic dose and the potentially toxic dose is
relatively small. This narrow window makes proper dosing
and monitoring critically important to ensure the medication''s
safety, effectiveness and to prevent toxicity. The
therapeutic plasma levels of digoxin are usually between 1.0-1.5 nmol/l. The likelihood of toxicity rises dramatically at levels
above 2 nmol/l.
Dose adjustments in renal failure and liver failure:
Renal failure: Digoxin is excreted renally, and impaired renal
function can cause increased digoxin levels and leads to
digoxin toxicity. In this case the patient should have their
digoxin dose reduced and their digoxin level and electrolytes
should be carefully monitored.
Liver failure: Liver failure has little influence on digoxin
metabolism or clearance; therefore, no dose adjustment is
necessary.
Digoxin toxicity: Precipitated by hypokalemia or drugs
causing hypokalemia, hypercalcemia, acidosis and renal
failure.
The features of digoxin toxicity include:
Hyperkaliemia
Nausea, vomiting and diarrhea .
Abdominal pain
Confusion, dizziness and psychosis
Tachyarrhythmias or bradyarrhythmia''s
Xanthopsia (yellow-green vision)
Treatment: Digoxin immune fab is the reversal agent
(Antidote) of digoxin toxicity.',
    false,
    5,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Lesson: Hypertensive Emergency (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'hypertensive-emergency',
    'Hypertensive Emergency',
    'article',
    '# Hypertensive Emergency

Hypertensive Emergency
A hypertensive emergency is defined as a clinical situation
in which there is a marked elevation of blood pressure (BP)
usually >180/120mmhg and associated with acute or
progressive end organ damage, e.g. cardiovascular, renal or
neurological dysfunction.
The commonest form of hypertension is essential
hypertension in which no specific cause can be identified
but various risk factors are associated such as : age, family
history, obesity, and salt ingestion.
Secondary hypertension: is high BP caused by another
medical condition such as renal disease, endocrine disorders,
neurological disease, coarctation of aorta, pregnancy-related
pre-eclampsia, eclampsia and immunological.
The most vulnerable organs are CNS, CVS Kidneys and uterus
in pregnancy.
Clinical features
Physical examination

![Hypertensive Emergency - Clinical Figure 1](/lessons/images/cardiovascular-pharmacology-anticoagulants/hypertensive-emergency/figure_01_p1.png)
*Hypertensive Emergency — Clinical Figure 1 (Page 1 Reference)*

Cardiovascular finding: Elevated JVP, the difference in pulse
and BP in limbs, 3rd heart sound, pulmonary crepitation.
Central neurological: Reduced level of consciousness/focal
neurological deficit retinal haemorrhages / papillodema
Management
General approach
Hypertensive urgencies: Most patients presenting to the ED
with significantly elevated BP will not demonstrate acute
progressive target organ damage so treatment option for
them either to moderate increase in their current anti-
hypertensive drugs or compliance with anti-hypertensive
medication should be ensured.
Hypertensive emergency management
Reduce MAP up to 25% in the first hour.
If Pt remains stable then further reduce BP to normal range
over 24hrs
Labetalol first line therapy in hypertensive
encephalopathy/malignant hypertension or intracranial
haemorrhage
IV beta blockers and nitrates are choice of agents for HE
complicated with cardiac ischemia/MI.
standard treatment (IV nitrates, diuretic, opiates) is the
treatment choice for HE with LV failure or pulmonary
oedema.
Beta-blocker (labetalol atenolol, esmolol) along with nitrates
or nitroprusside treatment of choice for aortic dissection
Alpha with Beta blocker (phentolamine and labetalol)
choice for phaeochromocytoma
Fenoldopam choice for AKI
IV labetalol/ hydralazine drug of choice for pre-eclampsia
and MgSo4 for eclampsia.',
    false,
    6,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Lesson: Tachyarrhythmia (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'tachyarrhythmia',
    'Tachyarrhythmia',
    'article',
    '# Tachyarrhythmia

Tachycardias
Two Types
Regular or irregular narrow complex
Regular or Irregular broad complex
1small box= 0.04s
1Large box=0.20s
PR interval 0.12-0.20
In narrow complex tachycardia QRS <0.12s
In broad complex QRS>0.12s
Note: Adenosine is a purine nucleoside acts by stimulating A1-
adenosine receptors and opening acetylcholine-sensitive
potassium channels. This hyperpolarizes the cell membrane in
the atrio-ventricular (AV) node and, by inhibiting the calcium
channels, slows conduction in the AV node.
Contraindications of adenosine (High yield)
Asthma and COPD
2nd or 3rd degree AV block
Sick sinus syndrome
Long QT syndrome
Severe hypotension
Decompensated heart failure

![Tachyarrhythmia - Clinical Figure 1](/lessons/images/cardiovascular-pharmacology-anticoagulants/tachyarrhythmia/figure_01_p1.png)
*Tachyarrhythmia — Clinical Figure 1 (Page 1 Reference)*

Tachycardia Unstable Pt
Adverse features
Shock (SBP<90, confusion, drowsiness, cold extremities,
pallor).
Syncope (loss of consciousness)
Myocardial ischemia (Chest pain, breathlessness, ECG
changes)
Heart failure (Pulmonary edema, raised JVP, Hepatomegaly).
Extreme heart rate: >150 mostly Pt are unstable.
Management
Give 3 synchronized DC shocks (120-150j for broad complex
and 70-120 for narrow complex)
If not successful, then administer Amiodarone 300mg over 10
to 20 minutes and repeat the shock.
Followed by 900mg over 24hrs.
Note: Any unstable patient requires electrical cardioversion
rather than drugs regardless of the underlying rhythm.
Atrial fibrillation managment
AF is diagnosed using an ECG which typically shows an
absolutely irregular RR interval and absent p waves.
NICE guideline classification
Paroxysmal AF
AF terminates spontaneously within seven days of onset and
most often within 48 hours of onset.
Persistent AF
AF presents continuously for seven days or more or is
terminated by cardioversion.
Permanent AF
AF which is accepted without attempted cardioversion, or
which cannot be terminated by cardioversion.
Pathophysiology

The primary pathological change seen in AF is progressive
atrial fibrosis.
Prothrombotic state: Structural and functional changes in
the atrial myocardium along with stasis of blood especially in
the Left atrial appendage allow an environment in which a
thrombus can form.
Damage to the myocardium causes the expression of
prothrombotic factors on the atrial endothelial surface. This
along with activation of platelets and inflammatory cells
leads to clot formation.
Clinical features
breathlessness
palpitations
syncope or dizziness
chest discomfort
stroke or transient ischaemic attack
Management of hemodynamically-
unstable AF
DC shock 120-150J should be given if a patient presents
with the following adverse features:
Shock
Syncope/reduce the level of consciousness.
Heart failure
Myocardial ischemia
Management of previously-
identified AF
In patients presenting to the ED who are known to have AF
long-term (>48 hours). a reason for why they are tachycardic
should be sorted. If a secondary/reversible cause has been
excluded then rate control should be considered
NICE recommends rate control (beta blockers and rate-
limiting CCB) as the first-line strategy for people with atrial
fibrillation, except in people:
whose atrial fibrillation has a reversible cause.

who have heart failure thought to be primarily caused by
atrial fibrillation.
with new-onset atrial fibrillation (<48hrs)
For whom a rhythm control strategy would be more suitable
based on clinical judgment
Note: digoxin can be used in sedentary patients.
Management of Recent-onset, Non-
Life-threatening AF
In the ED if a patient presents within 48 hrs. of onset
consider either pharmacological or electrical cardioversion.
Electrical: synchronized DC 120-150J.
Pharmacological: A choice of flecainide in people with no
evidence of structural or ischemic heart disease.
Amiodarone should be used in people with evidence of
structural heart disease.
Note: if Pt with AF is uncertain of time or greater than 48
hrs then anti-coagulate this pt for 3 weeks before
cardioversion and rate should be controlled with Beta
blockers.',
    false,
    7,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- ==========================================================================
  -- Module 3: CNS Pharmacology & Analgesia (7 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'CNS Pharmacology & Analgesia' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'CNS Pharmacology & Analgesia', 2, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 2, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Analgesics (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'analgesics',
    'Analgesics',
    'article',
    '# Analgesics

Analgesics:
Classification of analgesics:
Non opioid analgesics:
Paracetamol: Used in Pyrexia and mild to moderate pain
Side effects: Rare (rashes, blood disorders)
Metabolism: Paracetamol metabolized to mainly glucuronide
conjugates, small amount converted to the toxic NAPQI (N-
acetyl P-amino-benzoquinoneimine), which is quickly made
safe by conjugation with glutathione
Toxic overdose: More NAPQI produced glucuronide pathway
becomes saturated leads to cellular death
and hepatic necrosis.
Antidote overdose: N-acetylcysteine
NSAIDS: (Non-Steroidal anti-inflammatory drugs): Class of
analgesics used to treat pain, fever and inflammation.
Mechanism: Cyclo-oxygenase (COX) catalyzes the production
of prostaglandins through the intermediate arachidonic
acid and Prostaglandins regulate the body''s inflammatory
response.
COX has 2 isoenzymes:
COX-I regulates many physiological processes including
protection of gastric mucosa.
COX-II is expressed in inflammatory cells.
Note:  Most NSAIDs inhibit both COX-I and COX-II. Some newer
drugs inhibit just COX-II, therefore reducing gastric side
effects.
ibuprofen (Safest NSAID) but low anti-inflammatory
properties not useful in inflammatory conditions.

Naproxen: Good efficacy, lower side effects but greater
than ibuprofen. Used in musculoskeletal
disorders, Rheumatoid arthritis, Gout and dysmenorrhea.
Diclofenac: Similar in efficacy to naproxen but greater side
effects.
Mefenamic acid: Low anti-inflammatory properties but
greater side effects which include aplastic anemia
and hemolytic anemia.
Note: NSAIDs cause GERD by inhibiting the COX 1 enzymes (cox
1 stimulation produce prostaglandins that help to maintain the
gastric mucosal integrity) NSAIDs can cause ulcers by
interfering with the stomach''s ability to protect itself from
gastric acid (by inhibiting the function of prostaglandins)
NSAIDS Adverse effects:
Gl adverse effects (Most common) which include NSAIDS
induced peptic ulcer.
Hypersensitivity reactions
Renal failure contraindicated in reduced GFR
MI, Heart failure
Tinnitus
Hypertension
Thrombotic events
Fluid retention
Haemolytic anemia (Mefenamic acid)
Note: NSAIDs are contraindicated in a patient with heart
failure. (Diclofenac is contraindicated in people with ischemic
heart disease).
Risk of GI Side effects:
Lowest risk=ibuprofen (Safest NSAID)
Intermediate risk: Aspirin, naproxen
Highest risk=piroxicam, ketorolac, indomethacin
Management of gout (Important to know
here)
Acute gout: NSAIDS (specially naproxen)
Gout with heart failure: Colchicine
Chronic gout: Allopurinol also reduces further attacks of gout
by reducing uric acid.

Note: In gout under polarized light, gout crystals appear
needle-shaped and yellow, a property called negative
birefringence. Gout crystals are monosodium urate crystals
In Pseudo gout: Positive birefringence and pyrophosphate
crystals.
Colchicine mechanism of action: Colchicine has anti-
inflammatory properties. It disrupts cytoskeletal functions by
inhibiting beta-tubulin polymerization into microtubules,
preventing activation, degranulation, and migration of
neutrophils associated with mediating gout symptoms.
Colchicine is useful in patients with heart failure and those
taking anticoagulants
Avoid colchicine in patients with blood dyscrasias and bone
marrow disease .
Opioid analgesics:
Class of analgesics used to relieve moderate to severe
pain. Opioids have affinity for opioid µ receptors found in the
CNS, spinal cord and periphery
Classification of opioids:
Contraindications:
Raised ICP
Paralytic ileus
Acute respiratory depression

![Analgesics - Clinical Figure 1](/lessons/images/cns-pharmacology-analgesia/analgesics/figure_01_p3.png)
*Analgesics — Clinical Figure 1 (Page 3 Reference)*

Exacerbation of Asthma
Opioid toxicity: Severe respiratory depression coma
Antidote: Naloxone rapidly reverse the symptoms.',
    true,
    0,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Lesson: Anti - Psychotic Drugs (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'anti-psychotic-drugs',
    'Anti - Psychotic Drugs',
    'article',
    '# Anti - Psychotic Drugs

Anti-psychotics
Anti-psychotics acts by blocking dopamine D2 receptors in
the brain .
Side effects:
Extrapyramidal side effects occur most commonly associated
with antiemetic (metoclopramide, prochlorperazine) and anti-
psychotics (haloperidol). Haloperidol is the most
common causative antipsychotic drug.
Dystonia (abnormal face and body movements) most
commonly occur in young female and children treated with
Procyclidine or benztropine .
Tardive dyskinesia (rhythmic, involuntary movements of
tongue, face and jaw)
Other side effects:
Parkinsonian symptoms (Tremor, Rigidity, bradykinesia and
postural instability)
Hyperprolactinemia (Dopamine inhibits release of prolactin)
QT-interval prolongation',
    false,
    1,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Lesson: Anti - Emetic Drugs (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'anti-emetic-drugs',
    'Anti - Emetic Drugs',
    'article',
    '# Anti - Emetic Drugs

Antiemetics drug class, Members and
clinical use:
Metoclopramide
Metoclopramide is dopamine receptor antagonist acts directly
on GI tract as prokinetic drug, commonly associated with
extrapyramidal symptoms induce acute dystonic
reactions causing fascial and skeletal muscle spasm .
Antidote: Injection of anti-parkinsonism drug Such as
"Procyclidine will abort dystonic attack.
Note: Extrapyramidal symptoms are most commonly
associated with antiemetics and antipsychotics

![Anti - Emetic Drugs - Clinical Figure 1](/lessons/images/cns-pharmacology-analgesia/anti-emetic-drugs/figure_01_p1.png)
*Anti - Emetic Drugs — Clinical Figure 1 (Page 1 Reference)*',
    false,
    2,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Lesson: Anti - Epileptic Drugs (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'anti-epileptic-drugs',
    'Anti - Epileptic Drugs',
    'article',
    '# Anti - Epileptic Drugs

Anti-epileptic drugs
Carbamazepine, sodium valproate
and phenytoin
Mechanism of action: Carbamazepine, sodium valproate
and phenytoin all three drugs act by inhibiting Voltage gated
Na+ channels in neuronal cells.
Sodium valproate: May also enhance the inhibitory effects of
gamma-aminobutyric acid (GABA), an
important neurotransmitter that reduces neuronal
excitability.
Antiepileptic drugs in pregnancy: (Adverse features)
Carbamazepine: Hemorrhagic disease of the newborn and
Neural tube defects.
Phenytoin: Hemorrhagic disease of the newborn., Risk of
congenital malformations e.g. cleft lip, hypospadias and
cardiovascular defects.

![Anti - Epileptic Drugs - Clinical Figure 1](/lessons/images/cns-pharmacology-analgesia/anti-epileptic-drugs/figure_01_p1.png)
*Anti - Epileptic Drugs — Clinical Figure 1 (Page 1 Reference)*

Sodium valproate: Risk of major congenital malformations e.g.
neural tube, cardiac, craniofacial and limb defects.
Antiepileptic drug interaction:
All the cytochrome P450 enzyme inducer drugs which also
include antiepileptics phenytoin and carbamazepine increase
rate of metabolism and hepatic clearance of
concurrently administrated drugs which typically results in
decreased pharmacologic effects. Enzyme inducer drugs
reduce the effectiveness of Oral contraceptives pills taken in
pregnancy and thus pregnancy happens.
Note: Sodium valproate is metabolized in liver all the enzyme
inhibitor drugs decrease rate of metabolism of valproate and
toxicity occur.',
    false,
    3,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Lesson: Lithium (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'lithium',
    'Lithium',
    'article',
    '# Lithium

Lithium:
Used in the treatment of mania, bipolar disorders and
depression.
Side effects:
Gl disturbance (Nausea, Diarrhea)
Muscle weakness, Fine tremor
Polyuria and polydipsia (ADH antagonism - nephrogenic
diabetes insipidus)
Weight gain
Thyroid enlargement +/- hypothyroidism
Contraindications:
Na imbalance
Dehydration
Thyroid dysfunction
Renal impairment
Lithium monitoring:  Lithium has a narrow therapeutic effects.
While starting lithium routine monitoring is
recommended. The usual therapeutic range for lithium is 0.4-
0.8 mmol/l . The lower end of the range is usually the target for
maintenance therapy and treatment in the elderly. Toxic
effects are generally seen at levels > 1.5 mmol/l.
Lithium toxicity:
Early features:
Nausea
Vomiting
Diarrhea
Slurred speech
Polyuria
Muscle weakness

Late features:
Ataxia, coarse hand tremor
Blurred vision
Seizures, Stupor
Severe hypotension
Coma and death',
    false,
    4,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Lesson: Status Epilepticus Management (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'status-epilepticus-management',
    'Status Epilepticus Management',
    'article',
    '# Status Epilepticus Management

Status epilepticus management

![Status Epilepticus Management - Clinical Figure 1](/lessons/images/cns-pharmacology-analgesia/status-epilepticus-management/figure_01_p1.jpg)
*Status Epilepticus Management — Clinical Figure 1 (Page 1 Reference)*',
    false,
    5,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Lesson: Tricyclic - Antidepressants (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'tricyclic-antidepressants',
    'Tricyclic - Antidepressants',
    'article',
    '# Tricyclic - Antidepressants

Tri-cyclic antidepressants:
Mechanism of action: TCA e.g. Amitriptyline is in the tricyclic
antidepressant (TCA) drug, block the reuptake of
norepinephrine and serotonin from the synaptic cleft, thereby
potentiating the effects of serotonin and norepinephrine on
the postsynaptic receptors. The TCAs have also been shown to
inhibit muscarinic, histamine, and α -adrenergic receptors,
thereby leading to a host of undesirable side effects.
Tca also block muscarinic, histamine and  α  receptors and has
non-specific sedative effects.
Anticholinergic effects/parasympathetic blocking actions are
due to muscarinic receptor blockade (leads to Tachycardia,
urinary retention, blurred vision, acute angle closure
glaucoma, confusion, constipation, and dry
mouth
Sedation (due to histamine receptor blockade)
Postural hypotension (due to α  adrenergic receptor
blockade)
cardiac arrhythmias (due to sodium channel blocker)
Indications: Used in depression, neuropathic pain and
nocturnal enuresis.
Clinical features of TCA Toxicity:
Tachycardia - Sinus tachycardia is the most common rhythm
in TCA overdose. Wide complex tachycardia occurs with severe
TCA overdose.
Hypotension - As a result of alpha-1 antagonism, hypotension
is quite common.
Mydriasis,
Warm, dry, flushed skin
Decreased or absent bowel sounds
Urinary retention
Ophthalmic signs - Divergent squint, internuclear
ophthalmoplegic and gaze paralysis; nystagmus may also be seen.
Neurological signs - Ataxia, and myoclonic and
choreoathetoid movements, may be seen. Increased muscle
tone, hyperreflexia, and extensor plantar responses may occur.
Severe metabolic acidosis on ABG findingsInvestigations
ECG - This should be done as soon as possible to assess for
presence of QRS prolongation.
Any QRS duration >100 milliseconds in the setting of overdose,
or unknown cause of altered mental status, is suspicious for
TCA overdose.
The most common ECG abnormality seen in TCA overdose
is sinus tachycardia.
Other ECG changes that can occur include:
prolonged QTc duration
prolonged PR interval
AV block
non-specific ST and T wave changes
downward sloping ST elevation in leads V1 to V3 with right
bundle branch block (Brugada wave).
Treatment:
Follow ABC protocol, obtain intravenous access, attach a
cardiac monitor and obtain an ECG to look for QRS
prolongation.
Gastrointestinal decontamination (Time limited) - consider in
patients with ingestion within 1 hour .
Activated charcoal: 1 g/kg orally as a single dose, or 50g in
adults repeat every 1-2 hours if required.
Pt with QRS >100 milliseconds or pH <7.45 - Give sodium
bicarbonate bolus followed by infusion.',
    false,
    6,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- ==========================================================================
  -- Module 4: Anesthesia & Sedation Drugs (1 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Anesthesia & Sedation Drugs' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Anesthesia & Sedation Drugs', 3, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 3, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Anesthetic Drugs (4 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'anesthetic-drugs',
    'Anesthetic Drugs',
    'article',
    '# Anesthetic Drugs

Benzodiazepines and Muscle relaxants:
Local anesthetic drugs:
Anesthetic induction and
maintenance agents:

![Anesthetic Drugs - Clinical Figure 1](/lessons/images/anesthesia-sedation-drugs/anesthetic-drugs/figure_01_p1.png)
*Anesthetic Drugs — Clinical Figure 1 (Page 1 Reference)*

![Anesthetic Drugs - Clinical Figure 2](/lessons/images/anesthesia-sedation-drugs/anesthetic-drugs/figure_02_p1.png)
*Anesthetic Drugs — Clinical Figure 2 (Page 1 Reference)*

Anesthetic induction and
maintenance agents: (Continues)

![Anesthetic Drugs - Clinical Figure 3](/lessons/images/anesthesia-sedation-drugs/anesthetic-drugs/figure_03_p2.png)
*Anesthetic Drugs — Clinical Figure 3 (Page 2 Reference)*

![Anesthetic Drugs - Clinical Figure 4](/lessons/images/anesthesia-sedation-drugs/anesthetic-drugs/figure_04_p2.png)
*Anesthetic Drugs — Clinical Figure 4 (Page 2 Reference)*',
    true,
    0,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- ==========================================================================
  -- Module 5: Emergency Toxicology & Antidotes (3 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Emergency Toxicology & Antidotes' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Emergency Toxicology & Antidotes', 4, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 4, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Drugs Toxicity and Antidotes (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'drugs-toxicity-and-antidotes',
    'Drugs Toxicity and Antidotes',
    'article',
    '# Drugs Toxicity and Antidotes

![Drugs Toxicity and Antidotes - Clinical Figure 1](/lessons/images/emergency-toxicology-antidotes/drugs-toxicity-and-antidotes/figure_01_p1.png)
*Drugs Toxicity and Antidotes — Clinical Figure 1 (Page 1 Reference)*',
    true,
    0,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Lesson: Poisoning, Overdose and Toxidromes (3 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'poisoning-overdose-and-toxidromes',
    'Poisoning, Overdose and Toxidromes',
    'article',
    '# Poisoning, Overdose and Toxidromes

Poisoning and overdose
In toxicology, poisoning is defined as the state resulting from
the administration of excessive amounts of any
pharmaceutical agent.
A poison may be a drug, household product, industrial
chemical, or plant or animal derivative
Poisoning may be accidental or deliberate:
Poisoning is usually accidental in children aged under 6
years, and is most commonly due to exploration of their
environment, where children place objects in their mouth
and accidental ingestion occurs.
Deliberate self-poisoning is the deliberate ingestion of more
than the prescribed amount of a medical substance, or of a
substance not meant for human consumption, irrespective of
the motive for the episode.
Overdose is a term used to describe the use of a quantity of
drug in excess of its intended or prescribed dose and is a
major cause of poisoning. It may be accidental or deliberate
and involve the use of prescribed or illicit drugs.
Table - A: Drugs and clinical features

Table - B: Toxidromes

![Poisoning, Overdose and Toxidromes - Clinical Figure 1](/lessons/images/emergency-toxicology-antidotes/poisoning-overdose-and-toxidromes/figure_01_p2.png)
*Poisoning, Overdose and Toxidromes — Clinical Figure 1 (Page 2 Reference)*

![Poisoning, Overdose and Toxidromes - Clinical Figure 2](/lessons/images/emergency-toxicology-antidotes/poisoning-overdose-and-toxidromes/figure_01_p3.png)
*Poisoning, Overdose and Toxidromes — Clinical Figure 2 (Page 3 Reference)*

![Poisoning, Overdose and Toxidromes - Clinical Figure 3](/lessons/images/emergency-toxicology-antidotes/poisoning-overdose-and-toxidromes/figure_02_p3.png)
*Poisoning, Overdose and Toxidromes — Clinical Figure 3 (Page 3 Reference)*',
    false,
    1,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- Lesson: Summary of Drugs and Their Side Effects (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'summary-of-drugs-and-their-side-effects',
    'Summary of Drugs and Their Side Effects',
    'article',
    '# Summary of Drugs and Their Side Effects

Summary Of Drugs And Their Side
Effects

![Summary of Drugs and Their Side Effects - Clinical Figure 1](/lessons/images/emergency-toxicology-antidotes/summary-of-drugs-and-their-side-effects/figure_01_p1.png)
*Summary of Drugs and Their Side Effects — Clinical Figure 1 (Page 1 Reference)*',
    false,
    2,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = 'published',
    "deleted_at" = NULL,
    "updated_at" = now();

  -- 3. Connect Course to WhatsApp manual plan & standard plans
  SELECT id INTO v_whatsapp_plan_id FROM "plans" WHERE "family_key" = 'whatsapp-manual' AND "deleted_at" IS NULL LIMIT 1;
  IF v_whatsapp_plan_id IS NOT NULL THEN
    INSERT INTO "plan_courses" ("id", "plan_id", "course_id", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_whatsapp_plan_id, v_course_id, now(), now())
    ON CONFLICT ("plan_id", "course_id") DO NOTHING;
  END IF;

  SELECT id INTO v_primary_plan_id FROM "plans" WHERE "slug" = 'primary-pass' LIMIT 1;
  IF v_primary_plan_id IS NOT NULL THEN
    INSERT INTO "plan_courses" ("id", "plan_id", "course_id", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_primary_plan_id, v_course_id, now(), now())
    ON CONFLICT ("plan_id", "course_id") DO NOTHING;
  END IF;

  SELECT id INTO v_all_access_plan_id FROM "plans" WHERE "slug" = 'all-access' LIMIT 1;
  IF v_all_access_plan_id IS NOT NULL THEN
    INSERT INTO "plan_courses" ("id", "plan_id", "course_id", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_all_access_plan_id, v_course_id, now(), now())
    ON CONFLICT ("plan_id", "course_id") DO NOTHING;
  END IF;

  RAISE NOTICE 'Successfully seeded MRCEM Primary: Emergency Pharmacology & Toxicology (24 lessons, 30 images)';
END $$;
