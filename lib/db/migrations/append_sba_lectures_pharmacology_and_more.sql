-- ============================================================================
-- Emergix Academy: Append 19 SBA Clinical Masterclass Lectures
-- Generated: 2026-11-10
-- Safety: NON-DESTRUCTIVE. Appends to existing mrcem-sba course.
-- ============================================================================
DO $$
DECLARE
  v_course_id uuid;
  v_mod_id uuid;
  v_max_pos integer;
BEGIN
  -- 1. Locate Course: mrcem-sba
  SELECT id INTO v_course_id FROM "courses" WHERE "slug" = 'mrcem-sba' LIMIT 1;
  IF v_course_id IS NULL THEN
    RAISE EXCEPTION 'Course mrcem-sba not found. Ensure courses are initialized.';
  END IF;

  -- ───────────────────────────────────────────────────────────────────
  -- Module: Pharmacology and poisoning
  -- ───────────────────────────────────────────────────────────────────
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Pharmacology and poisoning' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    SELECT COALESCE(MAX("position"), 0) + 1 INTO v_max_pos FROM "modules" WHERE "course_id" = v_course_id;
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Pharmacology and poisoning', v_max_pos, now(), now())
    RETURNING "id" INTO v_mod_id;
    RAISE NOTICE 'Created new module: Pharmacology and poisoning (position %)', v_max_pos;
  ELSE
    RAISE NOTICE 'Found existing module: Pharmacology and poisoning (id %)', v_mod_id;
  END IF;

  -- Lesson: Paracetamol Overdose & Acetylcysteine Management
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'paracetamol-overdose',
    'Paracetamol Overdose & Acetylcysteine Management',
    'article',
    $L_PARACETAMOL_OVERDOSE$# Paracetamol Overdose & Acetylcysteine Management


> [!NOTE]
> **MRCEM SBA Masterclass Track:** Pharmacology and poisoning
> High-yield clinical guidance, diagnostic algorithms, and evidence-based emergency management based on RCEM, NICE, and UK guidelines.


Paracetamol (acetaminophen)
overdose
The National Poisons Information Service (NPIS) in the UK
defines different types of paracetamol overdose as follows:
Acute overdose
Acute overdose involves ingestion of a potentially toxic dose
of paracetamol 1 hour or less.
For adults and children aged 6 years and over - serious
toxicity is unlikely to occur from a single ingestion of less
than 75 mg/kg of paracetamol taken in less than 1 hour.
Admit the patients if they meet any of the following criteria:
- have ingested paracetamolin the context of self-harm,
- are symptomatic,
- have ingested 75 mg/kg or more of paracetamolin 1 hour or
less, or
- where the time of ingestion is uncertain but the dose
ingested is 75 mg/kg or more.
For children aged under 6 years - serious toxicity is unlikely
to occur from a single ingestion of less than 150 mg/kg
of paracetamol taken in less than 1 hour.
Admit children if they meet any of the following criteria:
- are symptomatic,
- have ingested 150 mg/kg or more of paracetamolin 1 hour or
less, or
- where there is uncertainty about the dose ingested or
circumstance of ingestion.
Staggered overdose:

MRCEM INTERMEDIATE SBA ( Complete Course Guide With Question bank)
For Diet 2 Late 2026
Overview Comments
/26, 10:30 AM Paracetamol overdose | MRCEM EXPERT LLC

excessive amounts of paracetamol ingested over longer than
1 hour; usually in the context of self-harm.
All patients who have taken a staggered overdose should be
admit for medical assessment.
The MHRA advises that all patients who have ingested a
staggered overdose should be treated with acetylcysteine
without delay.
Staggered overdose example - fatal dose of paracetamol is
12 grams, if an individual takes 6 tablets (equal to 2.5 grams)
at 8:00 PM and 5 tablets (2.5 grams) at 10:00 PM and 10
tablets at 11:30 PM (equal to 5 grams), and 5 tablets at 2:00
AM, the total dose he has taken during the period of 6 hours
is 12.5 grams, which is a highly toxic dose, but the different
doses are taken over the period of 6 hours not
simultaneously, such type of overdose is
called Staggered overdose.
Therapeutic excess
It is the ingestion of a potentially toxic dose of paracetamol
with intent to treat pain or fever and without self-harm intent
during its clinical use.
All patients should be admit for medical assessment if they
meet any of the following criteria:
- are symptomatic,
- have ingested more than a licensed dose and more than or
equal to 75 mg/kg in any 24-hour period, or
- have ingested more than the licensed dose but less than
75 mg/kg/24 hours on each of the preceding 2 or more days.
Clinical features
Nausea and vomiting (the early features of poisoning, usually
settle within 24 hours).
The recurrence of nausea and vomiting after 2-3 days, often
associated with the onset of right subcostal pain and
/26, 10:30 AM Paracetamol overdose | MRCEM EXPERT LLC

tenderness, usually indicates development of hepatic
necrosis.
Liver damage is maximal 3-4 days after paracetamol
overdose and may lead to liver failure, encephalopathy, coma,
and death.
Investigations
serum paracetamol concentration
Acute single overdose <8 hours since ingestion - Wait until
4 hours after paracetamol ingestion before taking the
sample in patients who have ingested paracetamol as an
acute overdose (i.e., all doses taken within 1 hour).
Acute single overdose >8 hours since ingestion - Take
blood immediately for urgent measurement of serum
paracetamol concentration (before acetylcysteine is given if
possible) in patients who have ingested paracetamol as an
acute overdose (i.e., all doses taken within 1 hour).
Staggered overdose or therapeutic excess - Take the
sample 4 hours after the last dose of paracetamol was
ingested in patients who have ingested all paracetamol
tablets over more than 1 hour but less than 24 hours.
liver function tests - Suspect acute liver injury if alanine
aminotransferase (ALT) is above the upper limit of normal.
prothrombin time and INR - Discuss urgently with a senior
colleague if prothrombin time >30 seconds or INR is >1.3.
Others
FBC, U&E
Blood glucose
Management
Management of Acute overdose
/26, 10:30 AM Paracetamol overdose | MRCEM EXPERT LLC


## Management


of staggered and therapeutic overdose
Acetylcysteine dose and administration
For the standard 21-hour regimen, acetylcysteine is given in
a total dose that is divided into 3 consecutive intravenous
/26, 10:30 AM Paracetamol overdose | MRCEM EXPERT LLC

infusions over a total of 21 hours.
The requisite dose of acetylcysteine is added to glucose 5%
or sodium chloride 0.9% Intravenous Infusion.
12-hour Acetylcysteine regimen
modified 12-hour regimen(also known as the Scottish and
Newcastle Acetylcysteine Protocol (SNAP). The SNAP
regimen [unlicensed] is not endorsed by the MHRA. It should
only be used after discussion with a senior clinician.
1st infusion intravenous NAC 100 mg/kg in 200ml 5% dextrose
or 0.9% NS over 2hrs
2nd infusion intravenous NAC 200 mg/kg in 1000ml 5%
dextrose or 0.9% NS over 10hrs
NAC adverse effects
Nausea and vomiting
Tachycardia
Urticaria
Flushing
Shock
Bronchospasm
Key points
Patients are often asymptomatic or have only mild
gastrointestinal symptoms at initial presentation.
Untreated paracetamol poisoning may cause varying degrees
of liver injury over the 2 to 4 days following ingestion,
including fulminant hepatic failure
/26, 10:30 AM Paracetamol overdose | MRCEM EXPERT LLC

Serious toxicity may occur in patients ingesting more than
150 mg/kg in any 24-hour period.
Rarely, toxicity can occur with ingestions between 75 and
150 mg/kg in any 24-hour period.
The concentration is plotted on a paracetamol treatment
graph (given below), with a reference line ('treatment line')
joining plots of 100 mg/litre (0.66 mmol/litre) at 4 hours and
3.13 mg/litre (0.02 mmol/litre) at 24 hours, see Paracetamol
overdose treatment graph.
Give double the calculated dose of acetylcysteine if a patient
is receiving haemodialysis.
Give acetylcysteine if:
Serum paracetamol concentration is detectable (>10mg/L) in
18- 24hr or >24hrs
OR
ALT is above the upper limit of normal
OR
INR >1.3 (in the absence of another cause, e.g., warfarin).
OR
- have ingested 150 mg/kg or more of paracetamol
paracetamol graph
/26, 10:30 AM Paracetamol overdose | MRCEM EXPERT LLC

Anaphylactic reaction due to NAC
In patients experiencing an adverse reaction consider
temporarily stopping the acetylcysteine
Re-start acetylcysteine infusion once the reaction has
settled. Consider slowing the infusion rate (e.g., administer
the first bag over twice as long as usual; the normal infusion
rate can be used for subsequent bags).
Give acetylcysteine even if the patient has a history of a
previous adverse reaction as the benefits outweigh the risks.
Consider using a slower initial infusion of acetylcysteine in
these patients to reduce the risk of a further reaction, as well
as giving prophylactic treatment (e.g., antihistamines).
Pretreatment with nebulised salbutamol in patients with a
history of bronchospasm following acetylcysteine.
- Monitor all patients closely for acetylcysteine infusion
reactions over the first few hours.
Nausea, vomiting, flushing, urticarial rash, angioedema,
tachycardia, and bronchospasm are relatively common
Be aware that vomiting is relatively common during
intravenous acetylcysteine administration. In clinical practice,
manage with an anti-emetic (e.g., ondansetron).
Complication
Nausea and vomiting
NAC related coagulation
Liver failure
Anaphylactoid reaction
Referral for liver transplant
The king college criteria predict patient with poor prognosis
and select patients most likely benefits from immediate liver
transplant referral.
King's college criteria
Arterial pH< 7.3 OR
/26, 10:30 AM Paracetamol overdose | MRCEM EXPERT LLC

INR 6.5 (Prothrombin Time >100s)
Creatinine >300 micromoles/L,
Grade 3 or 4 encephalopathy
Case discussion:
Case-1 A 34-year-old male presented to the ED after having
taken an intentional dose of twenty 500mg Paracetamol 6
hours ago. His weight is 70kg. his serum paracetamol level is
80 mg/l. how would you manage this patient?
Answer: Start NAC
Explanation
To follow normogram, paracetamol plasma concentration
with a reference line (treatment line) is 70mg/L at 6 hours.
However, the patient paracetamol plasma concentration
above the treatment line, therefore NAC should be
commenced.
/26, 10:30 AM Paracetamol overdose | MRCEM EXPERT LLC

22% Complete
Case-2 A 25-year-old male presented to the ED after taking
intentional overdose of thirty 500mg paracetamol tablets 6
hours ago. His weight is 72kg. He has no PMH and
examination is unremarkable. How would you manage this
patient?
Answer: Start NAC
Explanation
Calculate the ingestion dose: 30 × = 208mg/kg
NAC should be commenced in any patients who have
ingested 150 mg/kg or more of paracetamol.
Previous Next
/26, 10:30 AM Paracetamol overdose | MRCEM EXPERT LLC



## Clinical Figures, Diagnostic Algorithms & Radiographs


> [!TIP]
> Click any figure below to examine diagnostic algorithms, anatomy landmarks, or radiological details at full clinical resolution.



![Paracetamol Overdose & Acetylcysteine Management - Clinical Evaluation & Algorithm (Page 4)](/lessons/images/sba/pharmacology-and-poisoning/paracetamol-overdose/figure_01_p4.png)

*Paracetamol Overdose & Acetylcysteine Management - Figure 1: Clinical Evaluation & Algorithm (Page 4) (Page 4 Reference)*



![Paracetamol Overdose & Acetylcysteine Management - Clinical Evaluation & Algorithm (Page 4)](/lessons/images/sba/pharmacology-and-poisoning/paracetamol-overdose/figure_02_p4.png)

*Paracetamol Overdose & Acetylcysteine Management - Figure 2: Clinical Evaluation & Algorithm (Page 4) (Page 4 Reference)*



![Paracetamol Overdose & Acetylcysteine Management - Clinical Evaluation & Algorithm (Page 5)](/lessons/images/sba/pharmacology-and-poisoning/paracetamol-overdose/figure_03_p5.png)

*Paracetamol Overdose & Acetylcysteine Management - Figure 3: Clinical Evaluation & Algorithm (Page 5) (Page 5 Reference)*



![Paracetamol Overdose & Acetylcysteine Management - Clinical Evaluation & Algorithm (Page 6)](/lessons/images/sba/pharmacology-and-poisoning/paracetamol-overdose/figure_04_p6.png)

*Paracetamol Overdose & Acetylcysteine Management - Figure 4: Clinical Evaluation & Algorithm (Page 6) (Page 6 Reference)*



## High-Yield RCEM Examination Pearls


- **Core Syllabus Alignment:** Master the evidence-based diagnostic criteria, dosages, and contraindications for **Paracetamol Overdose & Acetylcysteine Management**.
- **Emergency Disposition:** Always document clear clinical justification when discharging or admitting patients under UK emergency guidelines.
- **SBA Decision Making:** In Single Best Answer questions, select the safest, first-line evidence-backed management step before secondary investigations.$L_PARACETAMOL_OVERDOSE$,
    false,
    0,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "status" = 'published',
    "updated_at" = now();

  -- Lesson: Clinical Toxidromes & Poisoning Approach
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'poisoning-overdose-and-toxidromes',
    'Clinical Toxidromes & Poisoning Approach',
    'article',
    $L_POISONING_OVERDOSE_AND_TOXIDROMES$# Clinical Toxidromes & Poisoning Approach


> [!NOTE]
> **MRCEM SBA Masterclass Track:** Pharmacology and poisoning
> High-yield clinical guidance, diagnostic algorithms, and evidence-based emergency management based on RCEM, NICE, and UK guidelines.


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

MRCEM INTERMEDIATE SBA ( Complete Course Guide With Question bank)
For Diet 2 Late 2026
Overview Comments
/26, 10:30 AM Poisoning, overdose and Toxidromes | MRCEM EXPERT LLC

Table - B: Toxidromes
/26, 10:30 AM Poisoning, overdose and Toxidromes | MRCEM EXPERT LLC

22% Complete
Mark as Complete
Previous Next
/26, 10:30 AM Poisoning, overdose and Toxidromes | MRCEM EXPERT LLC



## Clinical Figures, Diagnostic Algorithms & Radiographs


> [!TIP]
> Click any figure below to examine diagnostic algorithms, anatomy landmarks, or radiological details at full clinical resolution.



![Clinical Toxidromes & Poisoning Approach - Clinical Evaluation & Algorithm (Page 2)](/lessons/images/sba/pharmacology-and-poisoning/poisoning-overdose-and-toxidromes/figure_01_p2.png)

*Clinical Toxidromes & Poisoning Approach - Figure 1: Clinical Evaluation & Algorithm (Page 2) (Page 2 Reference)*



![Clinical Toxidromes & Poisoning Approach - Clinical Evaluation & Algorithm (Page 3)](/lessons/images/sba/pharmacology-and-poisoning/poisoning-overdose-and-toxidromes/figure_02_p3.png)

*Clinical Toxidromes & Poisoning Approach - Figure 2: Clinical Evaluation & Algorithm (Page 3) (Page 3 Reference)*



## High-Yield RCEM Examination Pearls


- **Core Syllabus Alignment:** Master the evidence-based diagnostic criteria, dosages, and contraindications for **Clinical Toxidromes & Poisoning Approach**.
- **Emergency Disposition:** Always document clear clinical justification when discharging or admitting patients under UK emergency guidelines.
- **SBA Decision Making:** In Single Best Answer questions, select the safest, first-line evidence-backed management step before secondary investigations.$L_POISONING_OVERDOSE_AND_TOXIDROMES$,
    false,
    1,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "status" = 'published',
    "updated_at" = now();

  -- Lesson: Tricyclic Antidepressant (TCA) Toxicity
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'tricyclic-antidepressant-tca-toxicity',
    'Tricyclic Antidepressant (TCA) Toxicity',
    'article',
    $L_TRICYCLIC_ANTIDEPRESSANT_TCA_TOXICITY$# Tricyclic Antidepressant (TCA) Toxicity


> [!NOTE]
> **MRCEM SBA Masterclass Track:** Pharmacology and poisoning
> High-yield clinical guidance, diagnostic algorithms, and evidence-based emergency management based on RCEM, NICE, and UK guidelines.


Tricyclic antidepressants (TCAs)
An antidepressant overdose occurs when a person ingests an
amount of medication that is more than a reasonable and
normal dose.
Risk factors
history of depression
obsessive-compulsive disorder
chronic pain
attention deficit hyperactivity disorders.
Clinical features
Tachycardia - Sinus tachycardia is the most common rhythm
in TCA overdose. Wide complex tachycardia occurs with
severe TCA overdose.
Hypotension - As a result of alpha-1 antagonism,
hypotension is quite common.
Mydriasis,
Warm, dry, flushed skin
Decreased or absent bowel sounds
Urinary retention
Ophthalmic signs - Divergent squint, internuclear
ophthalmoplegic and gaze paralysis; nystagmus may also be
seen.
Neurological signs - Ataxia, and myoclonic and
choreoathetoid movements, may be seen. Increased muscle
tone, hyperreflexia, and extensor plantar responses may
occur.
Investigations

MRCEM INTERMEDIATE SBA ( Complete Course Guide With Question bank)
For Diet 2 Late 2026
Overview Comments
/26, 10:30 AM Tricyclic anti-depressant toxicity (TCA toxicity) | MRCEM EXPERT LLC

ECG - This should be done as soon as possible to assess for
presence of QRS prolongation.
Any QRS duration >100 milliseconds in the setting of
overdose, or unknown cause of altered mental status, is
suspicious for TCA overdose.
The most common ECG abnormality seen in TCA overdose is
sinus tachycardia.
Other ECG changes that can occur include:
prolonged QTc duration
prolonged PR interval
AV block
non-specific ST and T wave changes
downward sloping ST elevation in leads V1 to V3 with right
bundle branch block (Brugada wave).
It is useful to look for the presence of a terminal 40
milliseconds rightward axis shift, seen as an R-wave
deflection in aVR or an S wave in I or aVL. Although it can be
present in many other conditions.
ECG shows Sinus tachycardia, widened QRS, dominant
terminal R wave in aVR
Sodium bicarbonate therapeutic trial - One to 2 mmol/kg
(or mEq/kg) rapid intravenous bolus should be given as soon
as QRS prolongation is confirmed. If the QRS narrows after
/26, 10:30 AM Tricyclic anti-depressant toxicity (TCA toxicity) | MRCEM EXPERT LLC

the bolus of sodium bicarbonate therapy, a cardiac monitor
- should be attached and a bicarbonate infusion commenced.
If the QRS fails to narrow after this bolus, then the presence
of a sodium channel blocker is unlikely and the QRS
prolongation probably has non-toxicological causes (because
sodium channel blockade is the only toxicological
explanation for QRS prolongation).
ABG - results in metabolic acidosis
Management
Follow ABC protocol , obtain intravenous access, attach a
cardiac monitor and obtain an ECG to look for QRS
prolongation.
Gastrointesinal decontamination(Time limited) - consider in
patients with ingestion within 1 hour
Activated charcoal: 1 g/kg orally as a single dose, or 50g in
adults repeat every 1-2 hours if required.
Pt with QRS >100 milliseconds or pH <7.45 - Give sodium
bicarbonate bolus followed by infusion : Once narrowing of
a QRS is produced by rapid sodium bicarbonate bolus, the
patient should be placed on a bicarbonate infusion.
For sodium bicarbonate dose take specialist help.
The patient's pH should be maintained between 7.45 and 7.55
(ideal is 7.5).
Pt with arrhythmias - sodium bicarbonate plus antiarrhythmic therapy: Consider use of magnesium sulfate
(magnesium sulfate: 2 g intravenously initially, followed by 3
mg/min infusion) for tachyarrhythmias that persist despite
correction of acidosis and administration of sodium
bicarbonate.
For significant bradyarrhythmias (such as Mobitz Type II or
complete heart block) that are unresponsive to treatment
with sodium bicarbonate, consider use of isoproterenol
/26, 10:30 AM Tricyclic anti-depressant toxicity (TCA toxicity) | MRCEM EXPERT LLC

22% Complete
Mark as Complete
(isoprenaline) as a temporary measure until temporary
pacing is established.
For severe life-threatening arrhythmias that are resistant to
sodium bicarbonate, consider the use of intravenous lipid
emulsion (1 mL/kg intravenously initially, followed by 3
mL/kg/hour infusion, maximum 500 mL).
Pt with hypotension - Give intravenous fluids plus sodium
bicarbonate: Hypotension should be treated with
intravenous crystalloid/colloid initially.
Vasopressors, such as norepinephrine (noradrenaline) or
phenylephrine, should only be commenced in discussion
with a medical toxicologist and intensive care physician.
Pt in cardiac arrest - hyperventilation plus sodium
bicarbonate: Cardiac arrest caused by TCAs should be
treated by systemic alkalinisation with sodium bicarbonate
and hyperventilation.
Pt with seizures - sodium bicarbonate plus benzodiazepine
or barbiturate or propofol:
Persistent seizures should be treated with a benzodiazepine,
such as diazepam or lorazepam. Administration of
benzodiazepines may cause further impairment of
consciousness level and respiratory depression.
Consider the use of barbiturates or propofol if seizures are
not controlled with benzodiazepines.
Phenytoin is contraindicated as it does not improve seizures
and may worsen cardiac toxicity.
Previous Next
/26, 10:30 AM Tricyclic anti-depressant toxicity (TCA toxicity) | MRCEM EXPERT LLC



## Clinical Figures, Diagnostic Algorithms & Radiographs


> [!TIP]
> Click any figure below to examine diagnostic algorithms, anatomy landmarks, or radiological details at full clinical resolution.



![Tricyclic Antidepressant (TCA) Toxicity - Clinical Evaluation & Algorithm (Page 2)](/lessons/images/sba/pharmacology-and-poisoning/tricyclic-antidepressant-tca-toxicity/figure_01_p2.png)

*Tricyclic Antidepressant (TCA) Toxicity - Figure 1: Clinical Evaluation & Algorithm (Page 2) (Page 2 Reference)*



## High-Yield RCEM Examination Pearls


- **Core Syllabus Alignment:** Master the evidence-based diagnostic criteria, dosages, and contraindications for **Tricyclic Antidepressant (TCA) Toxicity**.
- **Emergency Disposition:** Always document clear clinical justification when discharging or admitting patients under UK emergency guidelines.
- **SBA Decision Making:** In Single Best Answer questions, select the safest, first-line evidence-backed management step before secondary investigations.$L_TRICYCLIC_ANTIDEPRESSANT_TCA_TOXICITY$,
    false,
    2,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "status" = 'published',
    "updated_at" = now();

  -- ───────────────────────────────────────────────────────────────────
  -- Module: Pain & Sedation
  -- ───────────────────────────────────────────────────────────────────
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Pain & Sedation' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    SELECT COALESCE(MAX("position"), 0) + 1 INTO v_max_pos FROM "modules" WHERE "course_id" = v_course_id;
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Pain & Sedation', v_max_pos, now(), now())
    RETURNING "id" INTO v_mod_id;
    RAISE NOTICE 'Created new module: Pain & Sedation (position %)', v_max_pos;
  ELSE
    RAISE NOTICE 'Found existing module: Pain & Sedation (id %)', v_mod_id;
  END IF;

  -- Lesson: Management of Acute Pain in Children
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'management-of-pain-in-children',
    'Management of Acute Pain in Children',
    'article',
    $L_MANAGEMENT_OF_PAIN_IN_CHILDREN$# Management of Acute Pain in Children


> [!NOTE]
> **MRCEM SBA Masterclass Track:** Pain & Sedation
> High-yield clinical guidance, diagnostic algorithms, and evidence-based emergency management based on RCEM, NICE, and UK guidelines.


Pain assessment
Pain assessment forms an integral part of the Manchester
Triage Scale.
Multiple assessment tools are in use. The better known unidirection scales have some evidence in the context of an ED
environment, and even where the atmosphere is tense and
the child and parent are using such tools for the first time,
- are satisfactory for the purpose of pain assessment and
management.
The pain ladder contains objective and subjective
descriptions with a numerical scale. Some scales are based
solely on faces, and the APLS pain ladder combines objective
and subjective descriptions with panda faces .
RCEM recommends the use of the attached assessment tool
or a locally developed alternative.
Assessment of acute pain in children in the
Emergency Department

MRCEM INTERMEDIATE SBA ( Complete Course Guide With Question bank)
For Diet 2 Late 2026
Overview Comments
/26, 10:25 AM P1M1 - Management of Pain in children | MRCEM EXPERT LLC


## Management


(RCEM guideline)
Psychological strategies: involving parents, cuddles, childfriendly environment, and explanation with reassurance all
help build trust. Also, distraction with toys, blowing bubbles,
reading, or story-telling using superhero or magical imagery
to make the pain go away.
The use of non-pharmacological adjuncts: such as limb
immobilisation, dressings for burns.
Pharmacological agents, via a variety of routes described
below
Algorithm for treatment of acute pain in
children in the Emergency Department
/26, 10:25 AM P1M1 - Management of Pain in children | MRCEM EXPERT LLC

RCEM key recommendation
The RCEM Quality in Emergency Care Committee (QEC)
standard of analgesia for moderate & severe pain within 20
minutes of arrival in the ED should be applied to children in
all Emergency Departments. Patients in severe pain should
- have the effectiveness of analgesia re-evaluated within 60
minutes of receiving the first dose of analgesia.
Patients in moderate pain should be offered oral analgesia at
triage / assessment. Patients with moderate pain should
- have the effectiveness of analgesia re-evaluated within 60
minutes of the first dose of analgesia.
In treating pain, pay attention to the other factors distressing
the child such as fear of the unfamiliar environment and
people, parental distress, people in uniforms, needle
avoidance, fear of injury severity etc.
Previous Next
/26, 10:25 AM P1M1 - Management of Pain in children | MRCEM EXPERT LLC

22% Complete
/26, 10:25 AM P1M1 - Management of Pain in children | MRCEM EXPERT LLC



## Clinical Figures, Diagnostic Algorithms & Radiographs


> [!TIP]
> Click any figure below to examine diagnostic algorithms, anatomy landmarks, or radiological details at full clinical resolution.



![Management of Acute Pain in Children - Clinical Evaluation & Algorithm (Page 2)](/lessons/images/sba/pain-and-sedation/management-of-pain-in-children/figure_01_p2.png)

*Management of Acute Pain in Children - Figure 1: Clinical Evaluation & Algorithm (Page 2) (Page 2 Reference)*



![Management of Acute Pain in Children - Clinical Evaluation & Algorithm (Page 3)](/lessons/images/sba/pain-and-sedation/management-of-pain-in-children/figure_02_p3.png)

*Management of Acute Pain in Children - Figure 2: Clinical Evaluation & Algorithm (Page 3) (Page 3 Reference)*



## High-Yield RCEM Examination Pearls


- **Core Syllabus Alignment:** Master the evidence-based diagnostic criteria, dosages, and contraindications for **Management of Acute Pain in Children**.
- **Emergency Disposition:** Always document clear clinical justification when discharging or admitting patients under UK emergency guidelines.
- **SBA Decision Making:** In Single Best Answer questions, select the safest, first-line evidence-backed management step before secondary investigations.$L_MANAGEMENT_OF_PAIN_IN_CHILDREN$,
    false,
    0,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "status" = 'published',
    "updated_at" = now();

  -- Lesson: Management of Acute Pain in Adults
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'management-of-pain-in-adults',
    'Management of Acute Pain in Adults',
    'article',
    $L_MANAGEMENT_OF_PAIN_IN_ADULTS$# Management of Acute Pain in Adults


> [!NOTE]
> **MRCEM SBA Masterclass Track:** Pain & Sedation
> High-yield clinical guidance, diagnostic algorithms, and evidence-based emergency management based on RCEM, NICE, and UK guidelines.



## Assessment


of Acute Pain in the
Emergency Department
A numeric rating score for pain is recommended for those
patients presenting to Emergency Departments. Special
consideration, however, must take place for those patients
with cognitive impairment, who may not be able to express
the degree of pain clearly.
Using this method of pain scoring it should be possible to
adequately assess into one of four categories and treat pain
appropriately.
• Once the category has been established, appropriate
analgesia may be prescribed according to the flow chart
(given below).
Algorithm for Treatment of
Undifferentiated Acute Pain in the
Emergency Department
 
MRCEM INTERMEDIATE SBA ( Complete Course Guide With Question bank)
For Diet 2 Late 2026 
 Overview Comments
/26, 10:26 AM P2M2 - Management of Pain in Adults | MRCEM EXPERT LLC

Drugs notes
Paracetamol
Available as oral, rectal and intravenous preparations
The standard oral and IV dose for adults is 1gram qds.
However, IV dose must be adjusted for those patients
weighing less than 50kg (adults 40-49kg 750mg qds, 35-39kg
500mg qds).
Non-Steroidal Anti-inflammatory Drugs (NSAIDs)
Available as oral, rectal, intravenous and intra-muscular
preparations (although it should be noted IM diclofenac has
been associated with sterile abscesses following IM use).
Ibuprofen 400mg PO tds; fewer side effects than other
NSAIDs
Naproxen 500mg PO initially then 250mg every 6-8hrs in
acute musculoskeletal disorders; stronger anti-inflammatory
properties than ibuprofen.
/26, 10:26 AM P2M2 - Management of Pain in Adults | MRCEM EXPERT LLC

Avoid NSAIDS - in asthmatics who are known to get
worsening bronchospasm with NSAIDS, also avoid in patients
with previous or known peptic ulcer disease.
Opiates
Codeine Phosphate is available as oral and IM preparations,
30-60mg qds are typical adult doses however consider lower
doses in the elderly.
Morphine is available as oral, intravenous and intra-muscular
preparations.
Morphine 0.1-0.2mg/kg IV is a typical adult dose, however a
titrated dose to provide the desired response is
recommended; consider lower doses in the elderly.
Others
Entonox®, a 50% mixture of nitrous oxide and oxygen, is very
useful for short term and rapid relief of severe pain and for
performing short lasting uncomfortable procedures.
It should not be viewed as a definitive analgesic and EDs
need mechanisms in place to ensure rapid assessment and
institution of appropriate analgesia when paramedics bring
patients to the ED who are using Entonox as their sole source
of analgesia.
Contraindication: head injuries, chest injuries, suspected
bowel obstruction, middle ear disease, early pregnancy and
B12 or folate deficiency.
Methoxyflurane is volatile anaesthetic (PenthroxTM)
designed to be self-administered via a "green whistle".
It has been shown to be a safe and effective when used for
pain relief in adult patients with minor trauma. Following its
use in the pre-hospital setting, it has also been introduced
into some emergency departments.
Contraindications - renal or hepatic failure, cardiac
insufficiency or respiratory depression, known or suspected
susceptibility to malignant hyperthermia.
/26, 10:26 AM P2M2 - Management of Pain in Adults | MRCEM EXPERT LLC

Low-dose Ketamine is an effective analgesic at subanaesthetic doses either as a sole agent or as an adjunct to
an opiate.
Analgesic doses are generally considered to be 0.1 - 0.3
mg/kg IV (0.5-1.0mg/kg IM); the higher the dose within this
range the greater the chance of dissociative effects, these are
also more likely in older age groups.
Contraindications - schizophrenia, active pulmonary disease
or infection, cardiovascular disease, hydrocephalus, globe
injury or glaucoma.
Non-systemic drug treatment of
pain
Oral and intravenous drugs should not be thought of as the
only treatment for acute pain for patients presenting to
Emergency Departments. There are several 11 alternatives
that may prove more effective or reduce the need for dose
increases or more potent medication.
Relaxation techniques
Relaxation techniques are dependent on appropriately
trained members of staff and are particularly helpful in
children. There are many techniques available. Typically,
some techniques work well for one person and other
techniques work better for another. A quiet environment will
also help in this regard.
Local and regional anaesthesia
The use of local anaesthetic agents are an excellent form of
pain relief. This may be regionally, such as fascia iliaca blocks
or locally such as 'ring' blocks.
Immobilisation
/26, 10:26 AM P2M2 - Management of Pain in Adults | MRCEM EXPERT LLC

22% Complete
Appropriate immobilisation of fractures produces excellent
analgesia. However, in order to immobilise an area, good
analgesia may be required initially. Once the area is
immobilised the level of analgesia required may be reduced
significantly.
Early reduction of fractures and dislocations
As with immobilisation, once a fracture or dislocation is
reduced, using appropriate analgesia, ongoing pain relief will
decrease.
Previous Next
/26, 10:26 AM P2M2 - Management of Pain in Adults | MRCEM EXPERT LLC



## Clinical Figures, Diagnostic Algorithms & Radiographs


> [!TIP]
> Click any figure below to examine diagnostic algorithms, anatomy landmarks, or radiological details at full clinical resolution.



![Management of Acute Pain in Adults - Clinical Evaluation & Algorithm (Page 1)](/lessons/images/sba/pain-and-sedation/management-of-pain-in-adults/figure_01_p1.png)

*Management of Acute Pain in Adults - Figure 1: Clinical Evaluation & Algorithm (Page 1) (Page 1 Reference)*



![Management of Acute Pain in Adults - Clinical Evaluation & Algorithm (Page 2)](/lessons/images/sba/pain-and-sedation/management-of-pain-in-adults/figure_02_p2.png)

*Management of Acute Pain in Adults - Figure 2: Clinical Evaluation & Algorithm (Page 2) (Page 2 Reference)*



## High-Yield RCEM Examination Pearls


- **Core Syllabus Alignment:** Master the evidence-based diagnostic criteria, dosages, and contraindications for **Management of Acute Pain in Adults**.
- **Emergency Disposition:** Always document clear clinical justification when discharging or admitting patients under UK emergency guidelines.
- **SBA Decision Making:** In Single Best Answer questions, select the safest, first-line evidence-backed management step before secondary investigations.$L_MANAGEMENT_OF_PAIN_IN_ADULTS$,
    false,
    1,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "status" = 'published',
    "updated_at" = now();

  -- Lesson: Procedural Sedation & Analgesia (PSA)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'procedural-sedation-analgesia',
    'Procedural Sedation & Analgesia (PSA)',
    'article',
    $L_PROCEDURAL_SEDATION_ANALGESIA$# Procedural Sedation & Analgesia (PSA)


> [!NOTE]
> **MRCEM SBA Masterclass Track:** Pain & Sedation
> High-yield clinical guidance, diagnostic algorithms, and evidence-based emergency management based on RCEM, NICE, and UK guidelines.


Procedural Sedation &
Analgesia:
> Sedation is a continuum which extends from a normal
conscious level to being fully unresponsive.
> Indication for procedural sedation:
- Emergent: e.g. cardioversion for life-threatening dysrhythmia,
reduction of markedly angulated fracture/dislocation with soft
tissue or vascular compromise, intractable pain or suffering

MRCEM INTERMEDIATE SBA ( Complete Course Guide With Question bank)
For Diet 2 Late 2026
Overview Comments
/26, 10:28 AM Procedural Sedation & Analgesia | MRCEM EXPERT LLC

- Urgent: e.g. care of dirty wounds and lacerations, animal and
human bites, fracture reduction, shoulder reduction, hip
reduction, arthrocentesis, neuroimaging for trauma
- Semi-urgent: e.g. care of clean wounds and lacerations,
foreign body removal, sexual assault examination
> Pt selection
- Patients who are ASA I, II and rarely selected ASA III can be
sedated in the ED. However patients with life threatening
arrhythmias will require sedation for Cardioversion and the
time dependency of these conditions overrides this.
- ASA III or IV patient should be referred for a procedure in
theatre unless they present with life/limb threatening
conditions.
- the deeper the sedation the more prolonged the period of
fasting. This can be 4-6h for none urgent procedures.
- Location: Level 2 and 3 Procedural sedation should take place
in the Resuscitation room or in a dedicated Sedation
room/cubicle.
- Selected Level 1 sedation may take place in alternative areas
of the department.
> Equipment
- Tilting Trolley,
- Source and means for providing supplemental oxygen,
- Source of suction,
- Pulse oximeter with alarm,
- A device for monitoring blood pressure,
- Crash Trolley should be immediately accessible
> Monitoring
/26, 10:28 AM Procedural Sedation & Analgesia | MRCEM EXPERT LLC

> All patients who require sedation will alter their
consciousness and must be on full continuous monitoring:
- Cardiac monitor with alarm (Level 2,3),
- End tidal CO2 Monitor (Level 2,3)
- NIBP every 5 min (Level 2,3)
- SpO2,
- ECG.
> Medications
- Intravenous Analgesic/Sedative drugs should be given slowly
- over 30 - 60 seconds and in small, incremental doses that are
titrated to the desired end-point of analgesia and sedation
- It is best to regard procedural sedation as a 2 step process -
analgesia then sedation
- Analgesic agents
> Sedating Agents
/26, 10:28 AM Procedural Sedation & Analgesia | MRCEM EXPERT LLC

> Prior to procedure following things should be done:
- Pt selection via ASA classification as mentioned above in
table
- The patient has no allergy or sensitivity to the prescribed
medication
- The patient's Fasting Status has been documented
- An urgent procedure means fasting state is not required (e.g.
for Cardioversion VT) while a wrist manipulation may be
delayed
- Informed consent ( verbal/or written) has been obtained and
documented in the medical record prior to procedure
/26, 10:28 AM Procedural Sedation & Analgesia | MRCEM EXPERT LLC

- Assessing/measuring the patient's: estimated weight or vital
signs, baseline oxygen saturation, a focused physical
examination including auscultation of the heart and lungs.
- the patient has a functioning IV line and IV Fluids
> During procedure
> Analgesia and sedation:
- Fentanyl is the drug of choice with morphine a close second.
Boli should be given until the patient is comfortable or sedated
(i.e. eyes closing, speech slurring) or respiratory depression RR<
10 or ET CO2 > 50mmHg/6.5kPa.
- wait 3 - 5 minutes post analgesic delivery then add in the
procedural sedation
- complete the procedure and allow the patient to return to
alertness
> Pt monitoring during procedure
- All patients must be on oxygen at 15 l minute via a
nonrebreather
- the patient's vital signs recorded every 3 minutes
- SpO2 should be kept above 96%
- The ECG should record the patients rate and rhythm and
unless the procedure is Cardioversion pulse should be kept 60100bpm and the SBP>100mmHg
- the patient's head position should be checked frequently to
ensure a patent airway
- If the patient becomes unstable during the procedure,
appropriate medical consultation should be sought
immediately
> Complication
/26, 10:28 AM Procedural Sedation & Analgesia | MRCEM EXPERT LLC

- Laryngospasm/stridor (< 0.3%): this is a rare and alarming
problem. It usually subsides as the patient wakes
- Apnoea - expect 15-30 s apnoea in around 1:20 patients in
level 3 sedation.
- Hypoxia from respiratory depression (SpO2<90). Provide high
flow oxygen.
- Transient hypotension - SBP<100mmHg this is common and
if persistent should be treated with fluid boli 250-500ml.
- Bradycardia (HR<50 bpm). Be prepared to monitor and treat
with Atropine 500mcg if compromising patient
> Discharge criteria:
- Patient has stable vital signs and oxygen saturation level
- Patient's swallow, cough and gag reflexes are present
- Patient is alert or appropriate to baseline
- Patient can sit unaided if appropriate to baseline and
procedure
- Patient can walk without/with assistance if appropriate to
baseline and procedure
- Nausea and dizziness are minimal o hydration is adequate
- Adequate analgesia
- Discharge order and instructions has been written by
physician
- Responsible adult to accompany patient if discharged
- Appropriate follow up has been arranged
Previous Next
/26, 10:28 AM Procedural Sedation & Analgesia | MRCEM EXPERT LLC

22% Complete
Mark as Complete
/26, 10:28 AM Procedural Sedation & Analgesia | MRCEM EXPERT LLC



## Clinical Figures, Diagnostic Algorithms & Radiographs


> [!TIP]
> Click any figure below to examine diagnostic algorithms, anatomy landmarks, or radiological details at full clinical resolution.



![Procedural Sedation & Analgesia (PSA) - Clinical Evaluation & Algorithm (Page 1)](/lessons/images/sba/pain-and-sedation/procedural-sedation-analgesia/figure_01_p1.png)

*Procedural Sedation & Analgesia (PSA) - Figure 1: Clinical Evaluation & Algorithm (Page 1) (Page 1 Reference)*



![Procedural Sedation & Analgesia (PSA) - Clinical Evaluation & Algorithm (Page 1)](/lessons/images/sba/pain-and-sedation/procedural-sedation-analgesia/figure_02_p1.png)

*Procedural Sedation & Analgesia (PSA) - Figure 2: Clinical Evaluation & Algorithm (Page 1) (Page 1 Reference)*



![Procedural Sedation & Analgesia (PSA) - Clinical Evaluation & Algorithm (Page 3)](/lessons/images/sba/pain-and-sedation/procedural-sedation-analgesia/figure_03_p3.png)

*Procedural Sedation & Analgesia (PSA) - Figure 3: Clinical Evaluation & Algorithm (Page 3) (Page 3 Reference)*



![Procedural Sedation & Analgesia (PSA) - Clinical Evaluation & Algorithm (Page 4)](/lessons/images/sba/pain-and-sedation/procedural-sedation-analgesia/figure_04_p4.png)

*Procedural Sedation & Analgesia (PSA) - Figure 4: Clinical Evaluation & Algorithm (Page 4) (Page 4 Reference)*



## High-Yield RCEM Examination Pearls


- **Core Syllabus Alignment:** Master the evidence-based diagnostic criteria, dosages, and contraindications for **Procedural Sedation & Analgesia (PSA)**.
- **Emergency Disposition:** Always document clear clinical justification when discharging or admitting patients under UK emergency guidelines.
- **SBA Decision Making:** In Single Best Answer questions, select the safest, first-line evidence-backed management step before secondary investigations.$L_PROCEDURAL_SEDATION_ANALGESIA$,
    false,
    2,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "status" = 'published',
    "updated_at" = now();

  -- Lesson: Ketamine Procedural Sedation in Children
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'ketamine-procedural-sedation-in-children',
    'Ketamine Procedural Sedation in Children',
    'article',
    $L_KETAMINE_PROCEDURAL_SEDATION_IN_CHILDREN$# Ketamine Procedural Sedation in Children


> [!NOTE]
> **MRCEM SBA Masterclass Track:** Pain & Sedation
> High-yield clinical guidance, diagnostic algorithms, and evidence-based emergency management based on RCEM, NICE, and UK guidelines.


Ketamine Procedural Sedation
In Children:
> Ketamine is a unique dissociative drug and that acts as a
dissociative sedative through binding of the N-methyl-Daspartate (NMDA) receptor.
> Characteristics of ketamine sedation
- Dissociation - trance-like state with eyes open but not
responding
- Catalepsy - normal or slightly increased muscle tone
maintained
- Analgesia - excellent analgesia is typical
- Amnesia - usually total
- Airway reflexes maintained
- Cardiovascular state - blood pressure and heart rate increase
slightly
- Nystagmus is typical, usually horizontal; eyes remain open
and glazed
> Ketamine dose & duration:
- Initial dose : 1mg/kg over 60 seconds
- Further dose: 0.5mg/kg slow injection
- Clinical onset: 1 minutes
- Effective sedation: 10-20 minutes

MRCEM INTERMEDIATE SBA ( Complete Course Guide With Question bank)
For Diet 2 Late 2026
Overview Comments
/26, 10:28 AM Ketamine Procedural Sedation In Children | MRCEM EXPERT LLC

- Time to discharge average: 90 minutes
> Ketamine indications
- Ketamine can be used for procedural sedation in children
who will need a painful or frightening procedure during the
course of their emergency care.
- Children over 12 months of age (there is an increased risk of
airway complications in children less than 12 months and
especially less than 3months).
- potential procedures where ketamine maybe employed
- Suturing
- Fracture reduction / manipulation
- Joint reduction
- Burn management
- Incision and Drainage of abscess
- Tube thoracostomy placement
- Foreign body removal
- Wound exploration / irrigation
> Contraindications:
- Pulmonary Hypertension
- Age less than 12 months due to an increased risk of
laryngospasm and airway complications
- A high risk of laryngospasm (active respiratory infection,
active asthma)
- Unstable or abnormal airway. Tracheal surgery or stenosis.
- Active upper or lower respiratory tract infection
/26, 10:28 AM Ketamine Procedural Sedation In Children | MRCEM EXPERT LLC

- Proposed procedure within the mouth or pharynx
- Patients with severe psychological problems such as
cognitive or motor delay or severe behavioural problems
- Significant cardiac disease (angina, heart failure, malignant
hypertension)
- Intracranial hypertension with CSF obstruction
- Intra-ocular pathology (glaucoma, penetrating injury)
- Previous psychotic illness
- Uncontrolled epilepsy
- Hyperthyroidism or Thyroid medication
- Porphyria
- Prior adverse reaction to ketamine
- Altered conscious level due to acute illness or injury
- Drug / alcohol intoxication
> Adverse Effects
- Mild agitation (20%)
- Hypersalivation and lacrimation (<10%), evidence suggests coadministration of anti-cholinergic agents (e.g. atropine) are not
necessary.
- Involuntary movements / ataxia (5%)
- Vomiting 5-10% of children will vomit in recovery period
- Transient rash 10%
> Prior to procedure following things are required and be
checked:
> At least three dedicated staff are required for the duration of
/26, 10:28 AM Ketamine Procedural Sedation In Children | MRCEM EXPERT LLC

the procedure:
- A doctor to manage the sedation and airway,
- A clinician to perform the procedure
- An experienced nurse to monitor and support the patient,
family and clinical staff.
> Ketamine procedural sedation should be only used by
clinicians experienced in its use and capable of managing any
complications
> The child should be managed in high dependency or
resuscitation area with immediate access to full resuscitation
facilities
> Supplemental oxygen should be given prior to and during the
procedure
> Discuss the proposed procedure and use of ketamine with
parent or guardian and obtain written consent.
> Where time permits, topical anaesthesia (EMLA®, Ametop®,
etc.) should be used to reduce the pain of intravenous
cannulation.
> During procedures:
- Draw up ketamine dose. Calculate key resuscitation drugs
and ensure they are readily available.
- Encourage the child and parents to talk (dream) about happy
topics. This helps minimise unpleasant emergence
phenomena.
- Parents should be encouraged to stay with the child until
sedation is achieved and whilst the child is recovering.
- The effects of ketamine are usually evident 1-2 minutes after
administration. Painful procedures should not be initiated until
2 minutes after ketamine has been administered.
/26, 10:28 AM Ketamine Procedural Sedation In Children | MRCEM EXPERT LLC

22% Complete
Mark as Complete
- Adequate sedation is usually indicated by loss of response to
verbal stimuli and nystagmus, heart rate, blood pressure and
respiration rate may all increase slightly.
- Lacrimation or salivation may be observed.
- After the procedure the child should recover in a quiet,
observed and monitored area under the continuous
observation of a trained member of staff
> Recovery:
> Recovery should be complete between 60 and 120 minutes,
depending on the dose used.
> The child can be safely discharged once they are at
presedation levels:
- Conscious and responding appropriately
- Nystagmus resolved
- Able to walk unassisted (older children)
- Vital signs are within normal limits
- Respiratory status not compromised
- Pain and discomfort addressed
> Complications: laryngospasm, apnoea, airway
misalignment/noisy breathing and emergency phenomena
(ketamine is known to induce agitation and hallucinations in
both adults and children as the dissociative effects wear off).
Previous Next
/26, 10:28 AM Ketamine Procedural Sedation In Children | MRCEM EXPERT LLC


## High-Yield RCEM Examination Pearls


- **Core Syllabus Alignment:** Master the evidence-based diagnostic criteria, dosages, and contraindications for **Ketamine Procedural Sedation in Children**.
- **Emergency Disposition:** Always document clear clinical justification when discharging or admitting patients under UK emergency guidelines.
- **SBA Decision Making:** In Single Best Answer questions, select the safest, first-line evidence-backed management step before secondary investigations.$L_KETAMINE_PROCEDURAL_SEDATION_IN_CHILDREN$,
    false,
    3,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "status" = 'published',
    "updated_at" = now();

  -- Lesson: Bier's Block (Intravenous Regional Anaesthesia)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'biers-block-ivra',
    'Bier''s Block (Intravenous Regional Anaesthesia)',
    'article',
    $L_BIERS_BLOCK_IVRA$# Bier's Block (Intravenous Regional Anaesthesia)


> [!NOTE]
> **MRCEM SBA Masterclass Track:** Pain & Sedation
> High-yield clinical guidance, diagnostic algorithms, and evidence-based emergency management based on RCEM, NICE, and UK guidelines.


Anaesthesia for Distal Forearm
Fractures (Bier's Block)
-Indication: Reduction of wrist fractures, most commonly
Colles' fracture.
-Contraindication:
> Allergy to local anaesthetic
> Children - consider whether appropriate on individual basis
> Hypertension >200mm Hg
> Infection in the limb
> Lymphoedema
> Methaemoglobinaemia
> Morbid obesity (as the cuff is unreliable on obese arms)
> Peripheral vascular disease
> Procedures needed in both arms
> Raynaud's phenomenon
> Scleroderma
> Severe hypertension
> Sickle cell disease or trait
> Pagets Disease
> Uncooperative or confused patient
-Drugs and dose:

MRCEM INTERMEDIATE SBA ( Complete Course Guide With Question bank)
For Diet 2 Late 2026
Overview Comments
/26, 10:27 AM Bier's Block | MRCEM EXPERT LLC

> Drug:
> 0.5% or 1% prilocaine without preservative
> No preparation with adrenaline
> If 0.5% prilocaine unavailable, use half volume of 1% plain
prilocaine and the same volume of normal saline (eg instead of
40ml 0.5% plain prilocaine, use 20 ml 1% plain prilocaine and
dilute with 20ml normal saline).
> Dose:
> Prilocaine 3mg/Kg.There are no reported problems at this
dose.
> During a period of prilocaine shortage in the UK, the
following regime was found to be an acceptable alternative;
0.5% plain lidocaine at a dose of 3 mg/kg up to a maximum of
200 mg (40 ml)
-Technique:
> Immediately prior to the procedure an invasive procedures
checklist should be completed which include consent, Pt
weigh in kg, drug dose etc
- Procedure
> Place double cuff tourniquet on upper arm and not on
forearm as adequate arterial compression cannot be obtained.
> Padding must always be applied prior to cuff placement and
applying a well fitted double cuff will be a 2 person procedure
> Inflate the proximal cuff to 100mmHg above the systolic BP or
up to a maximum of 300mmHg. If rotation of cuff is considered
then the machine should have a fail-safe selected preventing
decompression of proximal cuff prior to inflation of distal cuff.
> Record the time of inflation
/26, 10:27 AM Bier's Block | MRCEM EXPERT LLC

> Check for the absence of radial pulse
> Inject 0.5% plain prilocaine, prepared according to patient
weight, slowly and record the time of injection.
> Remove the cannula and apply pressure as the venupuncture
site is prone to bleed (thus use of 22G)
> Warn the patient about the cold/hot sensation and mottled
appearance of the arm
> Check for anaesthesia, may sense movement but not pain
after 10 minutes which is when the manipulation should be
done and plaster applied by 2nd member of staff
> Lower arm on to a pillow and obtain check x-ray
> Tourniquet dials must be under observation at all times
> Watch for signs of toxicity
> The cuff must be inflated for a minimum of 20 minutes and a
maximum of 45 minutes. If rotation of cuff required because of
pain at cuff site or prolonged procedure (2nd manipulation)
this should done after the manipulation and plaster is applied.
The distal cuff will then be inflated over an anesthetised area
and be more comfortable for the patient.
> If satisfied with the post reduction position of fracture, deflate
the cuff observing the patient and monitor
> If fail safe selection applied the distal cuff will need to be
inflated first prior to deflations
> Record the time of deflation
> Check limb circulation prior to discharge and arrange patient
follow up and analgesia as appropriate
-Complications:
- Systemic toxicity and Methaemoglobinaemia (A problem
specific to prilocaine, usually in doses >16mg/kg but can occur
/26, 10:27 AM Bier's Block | MRCEM EXPERT LLC

22% Complete
Mark as Complete
with other drugs (lidocaine, GTN, phenytoin, metoclopramide,
poppers, cocaine)
> Intralipid is helpful in local anaesthetic toxicity
Previous Next
/26, 10:27 AM Bier's Block | MRCEM EXPERT LLC


## High-Yield RCEM Examination Pearls


- **Core Syllabus Alignment:** Master the evidence-based diagnostic criteria, dosages, and contraindications for **Bier's Block (Intravenous Regional Anaesthesia)**.
- **Emergency Disposition:** Always document clear clinical justification when discharging or admitting patients under UK emergency guidelines.
- **SBA Decision Making:** In Single Best Answer questions, select the safest, first-line evidence-backed management step before secondary investigations.$L_BIERS_BLOCK_IVRA$,
    false,
    4,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "status" = 'published',
    "updated_at" = now();

  -- Lesson: Digital Nerve Block Technique & Anaesthesia
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'digital-nerve-block',
    'Digital Nerve Block Technique & Anaesthesia',
    'article',
    $L_DIGITAL_NERVE_BLOCK$# Digital Nerve Block Technique & Anaesthesia


> [!NOTE]
> **MRCEM SBA Masterclass Track:** Pain & Sedation
> High-yield clinical guidance, diagnostic algorithms, and evidence-based emergency management based on RCEM, NICE, and UK guidelines.


Digital Nerve Block
> Digital nerve block is used frequently for simple procedures
on the fingers and toes.
> Indication:
> Nailbed injuries
> Finger/toe laceration
> Nail avulsion
> Foreign bodies in digit
> Digit dislocation and fracture
> Contraindications;
> Allergic to LA
> Compromised digital circulation or infection
> Drug and dose:
> Plain lidocaine 1% is often used, but bupivacaine 0.5% plain is
preferable.
> Use 1-2mL of LA on each side of the finger, thumb, or big toe.
Use smaller volumes in the other toes or in children.
> Avoid to use adrenaline or any other vasoconstrictor
> Excessive pain or paraesthesia suggest needle is against or in
a nerve,therefore, needle should be removed immediately
> Aspirate before injection to avoid injection into blood vessels.

MRCEM INTERMEDIATE SBA ( Complete Course Guide With Question bank)
For Diet 2 Late 2026
Overview Comments
/26, 10:27 AM Digital Nerve Block | MRCEM EXPERT LLC

22% Complete
Mark as Complete
> Each digit is innervated by four digital nerves,therefore, It Is
necessary to block all fours nerves to achieve complete
anaesthesia (a ring block).
> Procedure:
> Place the hand or toe on sterile surface
> Hold the syringe containing 1% lignocaine or bupivacaine
0.5% perpendicular to the digit and insert the needle into
subcutaneous tissue of the digital webspace.
> Aspirate to make sure needle isn't in vessels then slowly inject
2ml of anaesthetic into subcutaneous tissue and infiltrate,
surrounding the nerve as you withdraw.
> Repeat same procedure on the opposite side of digit.
> Anaesthesia will develop after 5 minutes
> Complications: infection, bleeding, distal paresthesia from
nerve injury, distal infarction from vasospasm.
Previous Next
/26, 10:27 AM Digital Nerve Block | MRCEM EXPERT LLC


## High-Yield RCEM Examination Pearls


- **Core Syllabus Alignment:** Master the evidence-based diagnostic criteria, dosages, and contraindications for **Digital Nerve Block Technique & Anaesthesia**.
- **Emergency Disposition:** Always document clear clinical justification when discharging or admitting patients under UK emergency guidelines.
- **SBA Decision Making:** In Single Best Answer questions, select the safest, first-line evidence-backed management step before secondary investigations.$L_DIGITAL_NERVE_BLOCK$,
    false,
    5,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "status" = 'published',
    "updated_at" = now();

  -- Lesson: Fascia Iliaca Compartment Block (FICB)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'fascia-iliaca-block',
    'Fascia Iliaca Compartment Block (FICB)',
    'article',
    $L_FASCIA_ILIACA_BLOCK$# Fascia Iliaca Compartment Block (FICB)


> [!NOTE]
> **MRCEM SBA Masterclass Track:** Pain & Sedation
> High-yield clinical guidance, diagnostic algorithms, and evidence-based emergency management based on RCEM, NICE, and UK guidelines.


- Fascia iliaca compartment block
> The fascia iliaca compartment is a potential space lying
between the fascia ilaca anteriorly and the iliacus and psoas
muscles (iliopsoas) posteriorly. The fascia iliaca attaches to the
iliac crest laterally and to the fascia overlying the psoas muscle
medially.
> Anatomical landmarks are the inguinal ligament, anterior
superior iliac spine (ASIS), and pubic tubercle.
> The advantage of FIB over Femoral Nerve Block:
> there is lower risk of intraneural and intra-vascular injection
> There is also a theoretical advantage of Lateral Cutaneous
Nerve of the thigh blockade.
> Indication:
> Pre-, peri- and postoperative analgesia after fractured neck of
femur (NOF).
> hip and knee surgery, above knee amputation.
> Contraindications
> Allergy to LA
> Infection and/or inflammation over the injection site
> Previous femoral bypass surgery or near a graft site
> Anticoagulation.
> Procedure: Explain the procedure and gain consent from the
patient.

MRCEM INTERMEDIATE SBA ( Complete Course Guide With Question bank)
For Diet 2 Late 2026
Overview Comments
/26, 10:27 AM Fascia Iliaca Block | MRCEM EXPERT LLC

> Prepare the equipment, including relevant specialized long
needles and LA:
- Use 30mL of 0.25% levobupivacaine in adults weighing ≤ 50kg.
- Use 40mL of 0.25% levobupivacaine in adults weighing >50kg.
> Clean the skin and identify the anterior superior iliac spine
and pubic tubercle on the side of the fracture, and place a
finger on each of these, then draw an imaginary line between
them and divide this line up into thirds, thereby identifying the
junction of the lateral third and medial two-thirds-the
injection site is 1cm below (caudal to) this point. The femoral
pulse is well medial to this.
> Direct the needle in the sagittal plane, and having pierced
the skin, advance through two distinct palpable 'pops'
(penetration through first the fascia lata and then the fascia
iliaca).
> Advance a further 1-2mm, then attempt to aspirate, and if no
blood is aspirated.
> Stop if there is pain or paraesthesiae on injection. Attempt to
aspirate after every 5mL of injection.
> At the end of procedure, withdraw the needle and apply a
small amount of pressure to the injection site.
> Continue regular observations (pulse, BP, RR, SpO2 ) every
5min for at least 30min.
> Complications: block failure, haematoma, neuropraxia, local
anaesthetic systemic toxicity (LAST), quadriceps weakness,
perforation of peritoneal cavity contents and bladder puncture.
> Treat local anaesthetic toxicity with intralipid
Previous Next
/26, 10:27 AM Fascia Iliaca Block | MRCEM EXPERT LLC

22% Complete
Mark as Complete
/26, 10:27 AM Fascia Iliaca Block | MRCEM EXPERT LLC


## High-Yield RCEM Examination Pearls


- **Core Syllabus Alignment:** Master the evidence-based diagnostic criteria, dosages, and contraindications for **Fascia Iliaca Compartment Block (FICB)**.
- **Emergency Disposition:** Always document clear clinical justification when discharging or admitting patients under UK emergency guidelines.
- **SBA Decision Making:** In Single Best Answer questions, select the safest, first-line evidence-backed management step before secondary investigations.$L_FASCIA_ILIACA_BLOCK$,
    false,
    6,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "status" = 'published',
    "updated_at" = now();

  -- ───────────────────────────────────────────────────────────────────
  -- Module: Musculoskeletal (non-traumatic)
  -- ───────────────────────────────────────────────────────────────────
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Musculoskeletal (non-traumatic)' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    SELECT COALESCE(MAX("position"), 0) + 1 INTO v_max_pos FROM "modules" WHERE "course_id" = v_course_id;
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Musculoskeletal (non-traumatic)', v_max_pos, now(), now())
    RETURNING "id" INTO v_mod_id;
    RAISE NOTICE 'Created new module: Musculoskeletal (non-traumatic) (position %)', v_max_pos;
  ELSE
    RAISE NOTICE 'Found existing module: Musculoskeletal (non-traumatic) (id %)', v_mod_id;
  END IF;

  -- Lesson: Acute Limping Child Differential & Kocher Criteria
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'acute-limping-child',
    'Acute Limping Child Differential & Kocher Criteria',
    'article',
    $L_ACUTE_LIMPING_CHILD$# Acute Limping Child Differential & Kocher Criteria


> [!NOTE]
> **MRCEM SBA Masterclass Track:** Musculoskeletal (non-traumatic)
> High-yield clinical guidance, diagnostic algorithms, and evidence-based emergency management based on RCEM, NICE, and UK guidelines.


Limping Child:
Infective causes:
- Osteomyelitis
> It's an infection of the bone
> It's not very common, but it happens approximately 2% of
children who present to an ED with limp will have
osteomyelitis.
> Investigations: Plain films, ESR, and CRP, however, MRI is
best modality to evaluate.
>Management: non-operative with IV antibiotics
- Septic arthritis

MRCEM INTERMEDIATE SBA ( Complete Course Guide With Question bank)
For Diet 2 Late 2026
Overview Comments
/26, 10:31 AM Acute Limping Child | MRCEM EXPERT LLC

> The hip is the most common joint affected, followed by the
knee.
> Clinical features: unable to weight bear and fever and joint
inflammation
> Investigation: lab work can be helpful, as well as adjunct use
of US of the hip to look for an effusion.
> Management: Prompt surgical drainage and IV antibiotics
- Transient Synovitis
> It's an inflammatory disease of the hip
> The typical age is between 3 and 6 years, sometimes just after
a URI (upper respiratory infection) or viral illness
> Clinical feature:
> child should be well, afebrile, no or mild restriction of hip
movement.
> Investigation: US to look for effusion
> Child well response to NSAID
> Kocher's criteria is useful to differentiate between septic
arthritis and transient synovitis.
/26, 10:31 AM Acute Limping Child | MRCEM EXPERT LLC

> The four predictors are:
- Inability to walk
- Feverof 38.5 °C or greater
- ESR> 40 mm/h
- WBC> 12,000/mm3 (12 x 109/L)
> Mnemonics: WALK FEW
> Probability of Septic Arthritis (Kocher)
- 0Predictor - <0.2 % (less likely SA)
- 1Predictor - 3%
- 2Predictors - 40%
- 3Predictors - 93.1%
- 4Predictors - 99.6% (highest likelihood of SA)
- Pyomyositis
> It can be viral or bacterial and sometimes occurs after
subacute minor trauma
/26, 10:31 AM Acute Limping Child | MRCEM EXPERT LLC

> Clinical features:
> Pain , fever and Pt may appear irritable
> Calves are affected and always tender
> Management: viral cause manage with hydration and
supportive therapy
> Bacterial cause manage with antibiotics and require
admission
Other causes
- Perthes' disease
> It's also known as Legg-Calvé-Perthes.
> It's an idiopathic avascular necrosis of the hip, usually
affecting children from 3 to 12 years
> Clinical features:
> Pt present with a slow onset pain and with an antalgic gait.
And limitation to internal rotation and abduction of the hip.
> Investigation: frog-leg lateral view x-ray will reveal widening
of joint space and decrease in size of femoral head with patchy
density. MRI can evaluate better.
> Complications: chronic pain and osteoarthritis
/26, 10:31 AM Acute Limping Child | MRCEM EXPERT LLC

Slipped upper femoral epiphysis:
> It's a displacement of femoral epiphysis from metaphysis
> More common in children who are overweight and common
in 10-15 years of age
> It may associated with endocrine pathology
> Clinical features:
> Pt will present with severe pain with externally rotated leg.
> There maybe shortening of the affected limb
> Investigation: AP or frog-leg lateral view x-ray will reveal
displacement of femoral head.
> The Trethowan sign is used to diagnose slipped upper
femoral epiphysis . In this sign, the line of Klein passes above
the femoral head instead of intersecting the femoral epiphysis
as in the normal hip. It is best seen on both AP and lateral view.
> Management:
> Urgent evaluation and management is crucial to avoid
further displacement and development of avascular necrosis.
/26, 10:31 AM Acute Limping Child | MRCEM EXPERT LLC

Toddler fracture
> A toddler's fracture is a spiral fracture of the tibia caused by a
twisting motion when falling.
> Toddler's fractures occur in children 1 to 3 years of age.
> most commonly in the distal of the tibia.
> Clinical features:
> Bone tenderness, redness or bruising and swelling in the
affected area.
> Toddler may refuse to bear weight
> Investigation: initial x-ray maybe normal so repeat the film
/26, 10:31 AM Acute Limping Child | MRCEM EXPERT LLC

> Management: Managed with an above or below knee
backslab.
Osgood-Schlatter disease:
> It is an apophysitis of the tibial tubercle resulting from
repeated normal stresses or overuse.
> Children are usually between 10 and 15 years of age at time of
onset; it more commonly occurs in running or jumping
athletes.
> Clinical features:
> Pain and tenderness over the anterior aspect of the knee and
the tibial tuberosity.
> Pain is aggravated by activities such as running, kneeling,
squatting, and climbing stairs
/26, 10:31 AM Acute Limping Child | MRCEM EXPERT LLC

> Pain improve with rest
> Investigations: x-ray is not required routinely but are usually
obtained.
> It may reveal soft tissue swelling and fragmentation of tibial
tubercle.
> Management: he disease is self-limited, and most patients'
symptoms respond to rest and temporary avoidance of the
offending activity.
Sever's disease:
> Sever's disease also known as calcaneal apophysitis.
> It is an inflammation of the growth plate in the calcaneus
(heel).
/26, 10:31 AM Acute Limping Child | MRCEM EXPERT LLC

> It is one of the most common causes of heel pain in growing
children, especially children who are doing running and
jumping sports.
> Clinical features:
> Heel pain and tenderness underneath the heel
> Mild swelling at the heel
> Investigation: x-rays are generally not used to diagnose
Sever's disease but in some cases may request a heel x-ray
> Management: Limiting the pain-inducing activities for a
short period of time may be beneficial
Salter-harris classification:
/26, 10:31 AM Acute Limping Child | MRCEM EXPERT LLC

> Salter-harris x-rays interpretation
/26, 10:31 AM Acute Limping Child | MRCEM EXPERT LLC

/26, 10:31 AM Acute Limping Child | MRCEM EXPERT LLC

22% Complete
Mark as Complete
Previous Next
/26, 10:31 AM Acute Limping Child | MRCEM EXPERT LLC



## Clinical Figures, Diagnostic Algorithms & Radiographs


> [!TIP]
> Click any figure below to examine diagnostic algorithms, anatomy landmarks, or radiological details at full clinical resolution.



![Acute Limping Child Differential & Kocher Criteria - Clinical Evaluation & Algorithm (Page 1)](/lessons/images/sba/musculoskeletal-non-traumatic/acute-limping-child/figure_01_p1.png)

*Acute Limping Child Differential & Kocher Criteria - Figure 1: Clinical Evaluation & Algorithm (Page 1) (Page 1 Reference)*



![Acute Limping Child Differential & Kocher Criteria - Clinical Evaluation & Algorithm (Page 2)](/lessons/images/sba/musculoskeletal-non-traumatic/acute-limping-child/figure_02_p2.png)

*Acute Limping Child Differential & Kocher Criteria - Figure 2: Clinical Evaluation & Algorithm (Page 2) (Page 2 Reference)*



![Acute Limping Child Differential & Kocher Criteria - Clinical Evaluation & Algorithm (Page 4)](/lessons/images/sba/musculoskeletal-non-traumatic/acute-limping-child/figure_03_p4.png)

*Acute Limping Child Differential & Kocher Criteria - Figure 3: Clinical Evaluation & Algorithm (Page 4) (Page 4 Reference)*



![Acute Limping Child Differential & Kocher Criteria - Clinical Evaluation & Algorithm (Page 6)](/lessons/images/sba/musculoskeletal-non-traumatic/acute-limping-child/figure_04_p6.png)

*Acute Limping Child Differential & Kocher Criteria - Figure 4: Clinical Evaluation & Algorithm (Page 6) (Page 6 Reference)*



![Acute Limping Child Differential & Kocher Criteria - Clinical Evaluation & Algorithm (Page 7)](/lessons/images/sba/musculoskeletal-non-traumatic/acute-limping-child/figure_05_p7.png)

*Acute Limping Child Differential & Kocher Criteria - Figure 5: Clinical Evaluation & Algorithm (Page 7) (Page 7 Reference)*



![Acute Limping Child Differential & Kocher Criteria - Clinical Evaluation & Algorithm (Page 8)](/lessons/images/sba/musculoskeletal-non-traumatic/acute-limping-child/figure_06_p8.png)

*Acute Limping Child Differential & Kocher Criteria - Figure 6: Clinical Evaluation & Algorithm (Page 8) (Page 8 Reference)*



## High-Yield RCEM Examination Pearls


- **Core Syllabus Alignment:** Master the evidence-based diagnostic criteria, dosages, and contraindications for **Acute Limping Child Differential & Kocher Criteria**.
- **Emergency Disposition:** Always document clear clinical justification when discharging or admitting patients under UK emergency guidelines.
- **SBA Decision Making:** In Single Best Answer questions, select the safest, first-line evidence-backed management step before secondary investigations.$L_ACUTE_LIMPING_CHILD$,
    false,
    0,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "status" = 'published',
    "updated_at" = now();

  -- Lesson: Knee Injuries, Ottawa Knee Rules & Ligamentous Assessment
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'knee-injuries',
    'Knee Injuries, Ottawa Knee Rules & Ligamentous Assessment',
    'article',
    $L_KNEE_INJURIES$# Knee Injuries, Ottawa Knee Rules & Ligamentous Assessment


> [!NOTE]
> **MRCEM SBA Masterclass Track:** Musculoskeletal (non-traumatic)
> High-yield clinical guidance, diagnostic algorithms, and evidence-based emergency management based on RCEM, NICE, and UK guidelines.


General approach to knee
injuries
History
Knee injuries most commonly results from sport, particularly
football and rugby.
Carefully elicit the exact mechanism of injury, as it provides
clues to the diagnosis.
Eg: valgus stress can damage medial collateral ligament
Varus stress can damage lateral collateral ligament
Unhappy triad anterior cruciate ligament associated with
medial collateral and/or medial meniscal injuries may tear
during forced flexion or hyperextension.
Posterior cruciate injuries may follow falls or dashboard
impact where the tibia is forced backwards violently.
Rapid-onset tense swelling in a knee is usually an acute
haemarthrosis.
In a hot, swollen, painful, and stiff knee without a history of
significant trauma, consider and exclude septic arthritis.
Examination
Carefully examine both legs with Pt supine
Look for bruising, swelling, redness, abrasions, or other
wounds
- Assess tone and bulk of the quadriceps muscle, and compare
sides
- Assess the collateral ligaments: valgus and varus stress tests
- Assess cruciate ligaments with anterior and posterior drawer
test.
Ottawa knee rule

MRCEM INTERMEDIATE SBA ( Complete Course Guide With Question bank)
For Diet 2 Late 2026
Overview Comments
/26, 10:24 AM Knee injuries | MRCEM EXPERT LLC

Use the Ottawa knee rules to assist the decision (in those
aged between 18 and 55y) as to whether or not to X-ray.
Tenderness at the head of the fibula
Isolated tenderness of the patella
Inability to flex knee to 90 degrees
Inability to transfer weight for four steps both immediately
after the injury and in the ED.
Patellar fracture
MOI
A direct blow or fall onto the patella or sudden violent knee
flexion or contraction of the quadriceps muscle.
Clinical features: pain, swelling, crepitus, and difficulty
extending the knee. There may be associated haemarthrosis.
Diagnosis: X-rays may be difficult to interpret. Take care not
to mistake a bipartite patella for a fracture. the accessory
bone is typically upper and lateral part of patella in bipartite
patella.
Management:
Vertical patellar fracture : Give analgesia ,immobilize in a nonweightbearing above-knee POP backslab, supply crutches,
and arrange orthopaedic follow-up
Tranverse fractures:
High risk of displacement due to the pull of the quadriceps.
Give analgesia ,immobilization in a POP backslab, and refer
to the orthopaedic team for probable ORIF.
/26, 10:24 AM Knee injuries | MRCEM EXPERT LLC

Bipartite patella
Bipartite patella is caused by the kneecap failing to form
properly during childhood.

/26, 10:24 AM Knee injuries | MRCEM EXPERT LLC

Dislocation of Patella
Typically dislocate laterally
Pt may be a history of recurrent dislocation
Clinical features: Painful knee, held in flexion, with obvious
lateral displacement of the patella.
Note: X-rays are not generally required prior to reduction of
the dislocation
Reduction:
usually be achieved using Entonox
Stand on the lateral side of the affected limb and hold the
affected knee gently. Using a thumb, lever the patella
medially in one smooth, firm movement, whilst gently
extending the knee at the same time.
Once reduced, obtain X-rays, immobilize in a canvas ('cricket
pad') back-splint or backslab cast POP, provide analgesia,
and arrange orthopaedic follow-up.
MRI scan is recommended at follow-up may help to identify
the extent of damage.
/26, 10:24 AM Knee injuries | MRCEM EXPERT LLC

Knee dislocation
Primarily occurs in younger population
Anterior dislocations are more common than posterior
dislocation.
MOI : It is a result of tremendous ligamentous disruption due
to either high-velocity mechanisms eg: motor vehicle
crashes, fall from height or low-velocity mechanisms, martial
arts, walking, or trampoline falls.
/26, 10:24 AM Knee injuries | MRCEM EXPERT LLC

Dislocations can also occur spontaneously in morbidly obese
patients
The popliteal artery and nerve are commonly injured,
therefore, document the distal pulse and sensation
Management:
Give the analgesia (opiod)
Reduce the dislocation by simple traction on the limb under
GA or sedation
- Check distal pulses and sensation after reduction
Immobilize in a long leg POP backslab, and arrange
orthopaedic admission.
Any sign of vascular injury, need emergent vascular surgery
consultation for surgical exploration and possible
angiography in the operating room.
Complications
Injury to popliteal artery and vein
Peroneal nerve injury
Compartment syndrome
/26, 10:24 AM Knee injuries | MRCEM EXPERT LLC

Tibial plateau fracture
Falls onto an extended leg can cause compression fractures
of the proximal tibia
Valgus stress: leads to crush or fracture the lateral tibial
plateau. It's commonly seen in pedestrians injured following
impact with car bumpers
Varus stress: leads to crush or fracture the medial tibial
plateau and usually associated with rupture of the opposite
collateral ligaments
Clinical features: tenderness over medial and lateral margin
of tibia. Look for swelling, haemarthrosis, or ligamentous
/26, 10:24 AM Knee injuries | MRCEM EXPERT LLC

instability.
Diagnosis : Radiograph or CT
Management: Give analgesia, immobilization in a long POP
backslab and refer to orthopedic for ± ORIF and bone
grafting
Admit all patients with acute haemarthrosis.
Small isolated avulsion without haemarthrosis require
immobilization, crutches, and analgesia, and arrange
orthopaedic follow-up.
Soft tissue Knee injuries
Acute haemarthrosis
An acute haemarthrosis indicates serious injury
Common causes include cruciate ligament rupture, tibial
avulsion, and tibial plateau or other fractures
Clinical features: Rapid-onset swelling following a knee
injury.
Knee often warm, tense, and painful
Diagnosis: Radiograph will reveal effusion or normal
Management: Give analgesia and aspirate haemarthrosis
however require strict aseptic technique. Or refer to
/26, 10:24 AM Knee injuries | MRCEM EXPERT LLC

orthopedic.

Cruciate ligament rupture
Anterior cruciate ligament injury
An audible 'pop' at the time of injury is highly suggestive of
anterior cruciate ligament rupture.
Anterior cruciate ligament tears often occur in association
with tears of the medial collateral ligament and medial
meniscus (unhappy triad)
Examination will reveal presence of haemarthrosis,
abnormal increase anterior glide of the tibia ('+ve anterior
drawer test').
+ve Lachman and pivot shift test
X-rays reveal avulsion of the anterior tibial spine.
Management: Give analgesia and refer to orthopedic.
Posterior cruciate ligament injury
Less common
/26, 10:24 AM Knee injuries | MRCEM EXPERT LLC

The tibia may appear to sag back when the knee is flexed, so
the tibia can be pulled into a more normal position, causing a
'false +ve' anterior drawer test.
X-rays may reveal the relevant posterior tibial spine to be
avulsed
Management: Give analgesia and refer to orthopedic
Collateral ligament injuries
Medial collateral ligament (MCL)
MCL injuries of the knee are one of the commonest sportsrelated knee injuries. MCL injuries can occur in almost all
sports and all age groups.
An audible 'pop' is often reported at the time of injury,
MOI -It usually result from a direct blow to the knee causing
excessive valgus stress.
It is commonly injured in association with anterior cruciate
ligament(ACL) and medial miniscal tear
Examination will reveal tenderness along the medial aspect
of the knee and bruising, and a knee effusion
Management - Provide crutches, analgesia, quadriceps
exercises, and orthopaedic follow-up
/26, 10:24 AM Knee injuries | MRCEM EXPERT LLC

Ruptured patellar tendon
Clincal features:
Pt completely unable to straight or raise the leg and a highriding patella
There is frequently an associated avulsion of the tibial
tuberosity.
Management - Refer to orthopedic
/26, 10:24 AM Knee injuries | MRCEM EXPERT LLC

Rupture of quadricep tendon
MOI: it results Complete rupture of the distal quadriceps
insertion can result from a direct injury or from sudden,
violent contraction of the quadriceps muscle.
Examination reveal complete inability to straight or raise the
leg.
Management: Refer to orthopedic for repair
Locked knee
/26, 10:24 AM Knee injuries | MRCEM EXPERT LLC

22% Complete
Mark as Complete
The "locked knee" describes when a knee cannot actively or
passively fully extend
The most common cause of an acutely locked knee is a torn
meniscus (meniscal injury)
Investigations - Obtain knee X-rays (including a tunnel
view).
Management - Give analgesia, and refer to orthopedic for
arthroscopy.
Previous Next
/26, 10:24 AM Knee injuries | MRCEM EXPERT LLC



## Clinical Figures, Diagnostic Algorithms & Radiographs


> [!TIP]
> Click any figure below to examine diagnostic algorithms, anatomy landmarks, or radiological details at full clinical resolution.



![Knee Injuries, Ottawa Knee Rules & Ligamentous Assessment - Clinical Evaluation & Algorithm (Page 3)](/lessons/images/sba/musculoskeletal-non-traumatic/knee-injuries/figure_01_p3.png)

*Knee Injuries, Ottawa Knee Rules & Ligamentous Assessment - Figure 1: Clinical Evaluation & Algorithm (Page 3) (Page 3 Reference)*



![Knee Injuries, Ottawa Knee Rules & Ligamentous Assessment - Clinical Evaluation & Algorithm (Page 3)](/lessons/images/sba/musculoskeletal-non-traumatic/knee-injuries/figure_02_p3.png)

*Knee Injuries, Ottawa Knee Rules & Ligamentous Assessment - Figure 2: Clinical Evaluation & Algorithm (Page 3) (Page 3 Reference)*



![Knee Injuries, Ottawa Knee Rules & Ligamentous Assessment - Clinical Evaluation & Algorithm (Page 5)](/lessons/images/sba/musculoskeletal-non-traumatic/knee-injuries/figure_03_p5.png)

*Knee Injuries, Ottawa Knee Rules & Ligamentous Assessment - Figure 3: Clinical Evaluation & Algorithm (Page 5) (Page 5 Reference)*



![Knee Injuries, Ottawa Knee Rules & Ligamentous Assessment - Clinical Evaluation & Algorithm (Page 7)](/lessons/images/sba/musculoskeletal-non-traumatic/knee-injuries/figure_04_p7.png)

*Knee Injuries, Ottawa Knee Rules & Ligamentous Assessment - Figure 4: Clinical Evaluation & Algorithm (Page 7) (Page 7 Reference)*



![Knee Injuries, Ottawa Knee Rules & Ligamentous Assessment - Clinical Evaluation & Algorithm (Page 8)](/lessons/images/sba/musculoskeletal-non-traumatic/knee-injuries/figure_05_p8.png)

*Knee Injuries, Ottawa Knee Rules & Ligamentous Assessment - Figure 5: Clinical Evaluation & Algorithm (Page 8) (Page 8 Reference)*



![Knee Injuries, Ottawa Knee Rules & Ligamentous Assessment - Clinical Evaluation & Algorithm (Page 9)](/lessons/images/sba/musculoskeletal-non-traumatic/knee-injuries/figure_06_p9.png)

*Knee Injuries, Ottawa Knee Rules & Ligamentous Assessment - Figure 6: Clinical Evaluation & Algorithm (Page 9) (Page 9 Reference)*



![Knee Injuries, Ottawa Knee Rules & Ligamentous Assessment - Clinical Evaluation & Algorithm (Page 11)](/lessons/images/sba/musculoskeletal-non-traumatic/knee-injuries/figure_07_p11.png)

*Knee Injuries, Ottawa Knee Rules & Ligamentous Assessment - Figure 7: Clinical Evaluation & Algorithm (Page 11) (Page 11 Reference)*



![Knee Injuries, Ottawa Knee Rules & Ligamentous Assessment - Clinical Evaluation & Algorithm (Page 12)](/lessons/images/sba/musculoskeletal-non-traumatic/knee-injuries/figure_08_p12.png)

*Knee Injuries, Ottawa Knee Rules & Ligamentous Assessment - Figure 8: Clinical Evaluation & Algorithm (Page 12) (Page 12 Reference)*



![Knee Injuries, Ottawa Knee Rules & Ligamentous Assessment - Clinical Evaluation & Algorithm (Page 13)](/lessons/images/sba/musculoskeletal-non-traumatic/knee-injuries/figure_09_p13.png)

*Knee Injuries, Ottawa Knee Rules & Ligamentous Assessment - Figure 9: Clinical Evaluation & Algorithm (Page 13) (Page 13 Reference)*



## High-Yield RCEM Examination Pearls


- **Core Syllabus Alignment:** Master the evidence-based diagnostic criteria, dosages, and contraindications for **Knee Injuries, Ottawa Knee Rules & Ligamentous Assessment**.
- **Emergency Disposition:** Always document clear clinical justification when discharging or admitting patients under UK emergency guidelines.
- **SBA Decision Making:** In Single Best Answer questions, select the safest, first-line evidence-backed management step before secondary investigations.$L_KNEE_INJURIES$,
    false,
    1,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "status" = 'published',
    "updated_at" = now();

  -- Lesson: Ankle & Foot Injuries, Ottawa Ankle Rules & Fractures
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'ankle-foot-injuries',
    'Ankle & Foot Injuries, Ottawa Ankle Rules & Fractures',
    'article',
    $L_ANKLE_FOOT_INJURIES$# Ankle & Foot Injuries, Ottawa Ankle Rules & Fractures


> [!NOTE]
> **MRCEM SBA Masterclass Track:** Musculoskeletal (non-traumatic)
> High-yield clinical guidance, diagnostic algorithms, and evidence-based emergency management based on RCEM, NICE, and UK guidelines.


-Ankle injuries
-Ottawa ankle rules for adults and Xray the ankles if patients:
> Were unable to weight-bear for four steps both immediately
after the injury and at the time of examination.
>Have tenderness over the posterior surface of the distal 6cm
(or tip) of the lateral malleolus.
>Have tenderness over the posterior surface of the distal 6cm
(or tip) of the medial malleolus.
-A foot radiograph is required if there
is any pain in midfoot zone and any
of these finding:
>Bone tenderness at navicular bone
>Bone tenderness at the base of fifth metatarsal
>Inability to bear weight for at least four steps both
immediately after injury and at the time of evaluation
-Weber classification of lateral
malleolus fractures

MRCEM INTERMEDIATE SBA ( Complete Course Guide With Question bank)
For Diet 2 Late 2026
Overview Comments
/26, 10:25 AM Ankle & Foot injuries | MRCEM EXPERT LLC

-Ankle fracture
>Radiographically, ankle fractures are described as
unimalleolar, bimalleolar and trimalleolar.
> A bimalleolar fracture is fracture of the lateral and medial
malleoli.
>A trimalleolar fracture additionally involves the posterior
malleolus
>The ankle mortice joint allows very little rotation or angulation
at the ankle joint, so forced twisting or angulation of the ankle
joint causes fractures,ligament injuries.it also disrupt the distal
tibiofibular syndesmosis.
-Management
>Small avulsion fracture treated with rest, elevation, analgesia
and early mobilization.
>Larger avulsion fractures require initial immobilization in a
boot ± crutches and orthopaedic follow-up
>Undisplaced, isolated medial or lateral malleolar fractures are
usually stable. provide analgesia and crutches, and immobilize
in a well-padded BKPOP cast. Advise limb elevation, and
arrange orthopaedic follow-up.
/26, 10:25 AM Ankle & Foot injuries | MRCEM EXPERT LLC

>Displaced fractures of the medial or lateral malleolus and
Bimalleolar or trimalleolar fractures are unstable. Having
attempted to reduce any significant talar shift (with
appropriate sedation), place in a BKPOP, obtain fresh X-rays,
and refer to the orthopaedic team.
-Ankle dislocation
>Dislocation of the ankle is a true emergency. Treat promptly
on diagnosis.
>Most ankle dislocations are associated with a fracture
-Clinical features: Examination reveal gross deformity of the
ankle, severe stretching of the skin (resulting in fracture
blisters, skin necrosis, or even converting the injury to a
compound fracture), and often deficits in peripheral pulses or
sensation.
-Management:
>Prompt closed reduction and immobilization in POP without
pre-reduction x-ray however Pt require adequate analgesia or
sedation for reduction.
>Give Penthrox®, IV analgesia/sedation, as needed, with full
precautions.
>Warn that there may be a brief increase in discomfort as the
/26, 10:25 AM Ankle & Foot injuries | MRCEM EXPERT LLC

ankle reduces.
>After reduction, re-check pulses and sensation; immobilize in
a POP slab, and arrange check X-rays
>Refer the patient to the orthopaedic immediately
-Ankle sprain
>The most common type of ankle sprain is one to the lateral
ankle. Typically, these are minor and are due to an inversion
injury when the ankle is plantarflexed.
>The structures most frequently injured in inversion injuries are
the lateral joint capsule and the anterior talofibular ligament.
-Management:
> RICE (rest, ice, compression, elevation)
> Most patients with minor sprains can expect full recovery in 4
weeks. Pt can resume sports within 2 weeks.
/26, 10:25 AM Ankle & Foot injuries | MRCEM EXPERT LLC

> If Pt inability to bear weight Provide crutches to those
completely unable to weight-bear despite analgesia, with
advice to elevate the ankle. Arrange review at 2-4 days.
> On review if Pt still unable to weightbear, consider 10 days'
immobilization in a boot or below-knee cast, with subsequent
outpatient follow-up.
-Complication: Peroneal tendon subluxation, Peroneal nerve
injury.
-Foot fracture and dislocations
>Foot injuries are a common presentation in the ED and are
frequently missed.1-3 These injuries typically occur in work,
athletic, and traffic environments.
-Talar injuries
-MOI: extreme dorsiflexion or a fall from a great height. "Major"
talus fractures are those involving the head, neck, or body of
the talus and can result in avascular necrosis.
-Diagnosis: plain radiograph however CT provide better
visualization.
-Management: provide analgesia and immobilization in a
backslab POP, and refer promptly to orthopaedic for MUA or
ORIF.
/26, 10:25 AM Ankle & Foot injuries | MRCEM EXPERT LLC

-Calcaneal fracture
-MOI: Calcaneal fractures most often follow a fall from height
directly onto the heels.
>Always exclude associated injuries of the cervical and lumbar
spine, pelvis, hips, or knees
>Calcaneal fractures are usually bilateral
-Clinical features: swelling, bruising, and tenderness over the
calcaneum.
-Diagnosis: Plain radiographs, specifically the lateral view, are
needed for fracture diagnosis. The Boehler angle is measured
/26, 10:25 AM Ankle & Foot injuries | MRCEM EXPERT LLC

using the lateral view and represents the intersection of two
lines
-Management: Refer all fractures to orthopedic
-Navicular injuries
-MOI: Navicular fractures are typically caused by a direct blow
or axial loading.
-Clinical features: tenderness and ecchymosis are found about
the navicular
-Diagnosis: Radiograph however, CT is best for evaluating the
talonavicular joint surfaces.
-Management: Nondisplaced fractures should be treated in a
non-weight-bearing short leg cast for 6 to 8 weeks and arrange
orthopedic follow-up in 2 weeks.
>Displaced fractures refer to orthopedic.
-Complication: avascular necrosis , nonunion, flatfoot
deformity.
/26, 10:25 AM Ankle & Foot injuries | MRCEM EXPERT LLC

-Metatarsal fractures and dislocations
(Lis-franc fracture-dislocation)
-Moi: Heavy objects falling onto the feet or being run over by a
vehicle tyre or wheel.
>It is common in football and soccer players.
-Diagnosis: request a standard foot x-ray.
>Look to check that the medial side of the second MT is
correctly aligned with the medial side of the middle cuneiform.
-Management:
>Support in a backslab POP, and refer if there are multiple,
displaced, or dislocated MT fractures.
/26, 10:25 AM Ankle & Foot injuries | MRCEM EXPERT LLC

-Isolated avulsion fractures of the
fifth MT base (dancer's fracture)
-MOI: Inversion may avulse the base of the fifth MT by the
peroneus brevis.
>Always examine this area in ankle injuries, and request foot Xrays if tender.
-Management: Give analgesia, elevation, and support in a
padded crepe bandage.
>In severe cases arrange follow-up with fracture clinic.
/26, 10:25 AM Ankle & Foot injuries | MRCEM EXPERT LLC

-Jones fracture (of the fifth MT)
>This is a transverse fracture of the fifth MT just distal to the
inter-MT join.
-Management: Provide analgesia, crutches, BKPOP or boot,
and orthopaedic follow-up.
/26, 10:25 AM Ankle & Foot injuries | MRCEM EXPERT LLC

-Stress fracture MTs (March fracture)
-MOI: Prolonged or unusual exercise
>The most common site is the second MT shaft.
-Clinical features: swelling, localized tenderness over the MT
shaft.
-Management: Provide analgesia, elevation, rest, and modified
daily activity, as required. Suggest a padded insole.
/26, 10:25 AM Ankle & Foot injuries | MRCEM EXPERT LLC

22% Complete
Mark as Complete
Previous Next
/26, 10:25 AM Ankle & Foot injuries | MRCEM EXPERT LLC



## Clinical Figures, Diagnostic Algorithms & Radiographs


> [!TIP]
> Click any figure below to examine diagnostic algorithms, anatomy landmarks, or radiological details at full clinical resolution.



![Ankle & Foot Injuries, Ottawa Ankle Rules & Fractures - Clinical Evaluation & Algorithm (Page 2)](/lessons/images/sba/musculoskeletal-non-traumatic/ankle-foot-injuries/figure_01_p2.png)

*Ankle & Foot Injuries, Ottawa Ankle Rules & Fractures - Figure 1: Clinical Evaluation & Algorithm (Page 2) (Page 2 Reference)*



![Ankle & Foot Injuries, Ottawa Ankle Rules & Fractures - Clinical Evaluation & Algorithm (Page 3)](/lessons/images/sba/musculoskeletal-non-traumatic/ankle-foot-injuries/figure_02_p3.png)

*Ankle & Foot Injuries, Ottawa Ankle Rules & Fractures - Figure 2: Clinical Evaluation & Algorithm (Page 3) (Page 3 Reference)*



## High-Yield RCEM Examination Pearls


- **Core Syllabus Alignment:** Master the evidence-based diagnostic criteria, dosages, and contraindications for **Ankle & Foot Injuries, Ottawa Ankle Rules & Fractures**.
- **Emergency Disposition:** Always document clear clinical justification when discharging or admitting patients under UK emergency guidelines.
- **SBA Decision Making:** In Single Best Answer questions, select the safest, first-line evidence-backed management step before secondary investigations.$L_ANKLE_FOOT_INJURIES$,
    false,
    2,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "status" = 'published',
    "updated_at" = now();

  -- Lesson: Forearm & Wrist Injuries (Colles, Smith, Galeazzi & Monteggia)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'forearm-injuries',
    'Forearm & Wrist Injuries (Colles, Smith, Galeazzi & Monteggia)',
    'article',
    $L_FOREARM_INJURIES$# Forearm & Wrist Injuries (Colles, Smith, Galeazzi & Monteggia)


> [!NOTE]
> **MRCEM SBA Masterclass Track:** Musculoskeletal (non-traumatic)
> High-yield clinical guidance, diagnostic algorithms, and evidence-based emergency management based on RCEM, NICE, and UK guidelines.


-Ulna fractures
-Isolated ulnar fractures (nightstick
fracture)
>It's often result from a direct blow to the forearm while in
defensive stance.
-Management : treat undisplaced fracture with elbow POP
flexed at 90 degrees
>Refer displaced or angulated fractures to orthopedic
-Monteggia's fracture-dislocation
>Fracture of the proximal third of the ulna with a radial head

MRCEM INTERMEDIATE SBA ( Complete Course Guide With Question bank)
For Diet 2 Late 2026
Overview Comments
/26, 10:22 AM Forearm injuries | MRCEM EXPERT LLC

dislocation is referred to as monteggia's fracture
>It occurs following a fall onto an outstretched hand or a direct
blow
-Clinical features: pain and swelling at the elbow.
-Diagnosis : ulnar fracture is clearly visible on radiographs
>Check entire elbow x-ray to confirm that radial shaft normally
aligned with radial head. An abnormal radiocapitellar line may
aid in the diagnosis
-Management: Early consult with Orthopedic, Monteggia's
fracture-dislocations are generally treated with open reduction
and internal fixation of the ulna fracture and closed reduction
of the radial head dislocation.
-Complications: nonunion, recurrent dislocation, chronic pain,
paralysis of the posterior interosseous nerve, the deep branch
of the radial nerve that controls finger extension
/26, 10:22 AM Forearm injuries | MRCEM EXPERT LLC

monteggia's fracture (Reference wikipedia)
-Radial fractures
-Galeazzi fracture-dislocation
>Fracture of the distal third of the radial shaft accompanied by
a dislocation of the distal radioulnar joint is known as Galeazzi
fracture-dislocation.
>Always look for subluxation of ulna in radial fracture
>Mechanism of injury results from falls on the outstretched
hand in forced pronation or from a direct blow
-Clinical features
/26, 10:22 AM Forearm injuries | MRCEM EXPERT LLC

>Localized tenderness and swelling over the distal radius and
wrist
-Diagnosis
>AP radiograph will reveal slightly increased distal radioulnar
joint space
>Lateral view will reveal displacement of ulna dorsally.
-Management
>Urgent orthopedic consultation in the ED.
>Control pain with analgesia and immobilization in a
temporary POP backslab
/26, 10:22 AM Forearm injuries | MRCEM EXPERT LLC

22% Complete
Mark as Complete
Galeazzi fracture-dislocation
Previous Next
/26, 10:22 AM Forearm injuries | MRCEM EXPERT LLC



## Clinical Figures, Diagnostic Algorithms & Radiographs


> [!TIP]
> Click any figure below to examine diagnostic algorithms, anatomy landmarks, or radiological details at full clinical resolution.



![Forearm & Wrist Injuries (Colles, Smith, Galeazzi & Monteggia) - Clinical Evaluation & Algorithm (Page 1)](/lessons/images/sba/musculoskeletal-non-traumatic/forearm-injuries/figure_01_p1.png)

*Forearm & Wrist Injuries (Colles, Smith, Galeazzi & Monteggia) - Figure 1: Clinical Evaluation & Algorithm (Page 1) (Page 1 Reference)*



![Forearm & Wrist Injuries (Colles, Smith, Galeazzi & Monteggia) - Clinical Evaluation & Algorithm (Page 3)](/lessons/images/sba/musculoskeletal-non-traumatic/forearm-injuries/figure_02_p3.png)

*Forearm & Wrist Injuries (Colles, Smith, Galeazzi & Monteggia) - Figure 2: Clinical Evaluation & Algorithm (Page 3) (Page 3 Reference)*



![Forearm & Wrist Injuries (Colles, Smith, Galeazzi & Monteggia) - Clinical Evaluation & Algorithm (Page 5)](/lessons/images/sba/musculoskeletal-non-traumatic/forearm-injuries/figure_03_p5.png)

*Forearm & Wrist Injuries (Colles, Smith, Galeazzi & Monteggia) - Figure 3: Clinical Evaluation & Algorithm (Page 5) (Page 5 Reference)*



## High-Yield RCEM Examination Pearls


- **Core Syllabus Alignment:** Master the evidence-based diagnostic criteria, dosages, and contraindications for **Forearm & Wrist Injuries (Colles, Smith, Galeazzi & Monteggia)**.
- **Emergency Disposition:** Always document clear clinical justification when discharging or admitting patients under UK emergency guidelines.
- **SBA Decision Making:** In Single Best Answer questions, select the safest, first-line evidence-backed management step before secondary investigations.$L_FOREARM_INJURIES$,
    false,
    3,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "status" = 'published',
    "updated_at" = now();

  -- Lesson: Bone Malignancies & Pathological Fractures in Emergency Care
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'bone-malignancy',
    'Bone Malignancies & Pathological Fractures in Emergency Care',
    'article',
    $L_BONE_MALIGNANCY$# Bone Malignancies & Pathological Fractures in Emergency Care


> [!NOTE]
> **MRCEM SBA Masterclass Track:** Musculoskeletal (non-traumatic)
> High-yield clinical guidance, diagnostic algorithms, and evidence-based emergency management based on RCEM, NICE, and UK guidelines.


- Osteosarcoma (osteogenic sarcoma)
> Primary tumor in less than 20 years of age
> In adults usually secondary predisposing factors, such as
Paget disease of bone, bone infarcts, radiation, familial
retinoblastoma, Li-Fraumeni syndrome.
> Location: Metaphysis of long bones (often in knee region).
> Clinical features: painful enlarging mass or pathologic
fractures
> Investigation: sunburst pattern on x-ray
> Management: surgery, chemotherapy

MRCEM INTERMEDIATE SBA ( Complete Course Guide With Question bank)
For Diet 2 Late 2026
Overview Comments
/26, 10:31 AM Bone Malignancy | MRCEM EXPERT LLC

- Ewing sarcoma
> Most common in White patients, generally males < 15 years
old.
> Location: Diaphysis of long bones (especially femur), pelvic
flat bones.
> Investigation: x-ray reveal ill-defined lytic lesion of the femur
diaphysis with a permeative pattern of destruction
> Management: Chemotherapy
/26, 10:31 AM Bone Malignancy | MRCEM EXPERT LLC

- Giant cell tumor
> Common in 20-40 years of age
> Location: Epiphysis of long bones (often in knee region)
> Locally aggressive benign tumor Neoplastic mononuclear
cells that express RANKL and reactive multinucleated giant
(osteoclastlike) cells. "Osteoclastoma".
> Investigation: "Soap bubble" appearance on x-ray.
> Management: Radiotherapy and chemotherapy
/26, 10:31 AM Bone Malignancy | MRCEM EXPERT LLC

22% Complete
Mark as Complete
Previous Next
/26, 10:31 AM Bone Malignancy | MRCEM EXPERT LLC



## Clinical Figures, Diagnostic Algorithms & Radiographs


> [!TIP]
> Click any figure below to examine diagnostic algorithms, anatomy landmarks, or radiological details at full clinical resolution.



![Bone Malignancies & Pathological Fractures in Emergency Care - Clinical Evaluation & Algorithm (Page 2)](/lessons/images/sba/musculoskeletal-non-traumatic/bone-malignancy/figure_01_p2.png)

*Bone Malignancies & Pathological Fractures in Emergency Care - Figure 1: Clinical Evaluation & Algorithm (Page 2) (Page 2 Reference)*



![Bone Malignancies & Pathological Fractures in Emergency Care - Clinical Evaluation & Algorithm (Page 3)](/lessons/images/sba/musculoskeletal-non-traumatic/bone-malignancy/figure_02_p3.png)

*Bone Malignancies & Pathological Fractures in Emergency Care - Figure 2: Clinical Evaluation & Algorithm (Page 3) (Page 3 Reference)*



![Bone Malignancies & Pathological Fractures in Emergency Care - Clinical Evaluation & Algorithm (Page 4)](/lessons/images/sba/musculoskeletal-non-traumatic/bone-malignancy/figure_03_p4.png)

*Bone Malignancies & Pathological Fractures in Emergency Care - Figure 3: Clinical Evaluation & Algorithm (Page 4) (Page 4 Reference)*



## High-Yield RCEM Examination Pearls


- **Core Syllabus Alignment:** Master the evidence-based diagnostic criteria, dosages, and contraindications for **Bone Malignancies & Pathological Fractures in Emergency Care**.
- **Emergency Disposition:** Always document clear clinical justification when discharging or admitting patients under UK emergency guidelines.
- **SBA Decision Making:** In Single Best Answer questions, select the safest, first-line evidence-backed management step before secondary investigations.$L_BONE_MALIGNANCY$,
    false,
    4,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "status" = 'published',
    "updated_at" = now();

  -- ───────────────────────────────────────────────────────────────────
  -- Module: Safeguarding & Psycho-social emergencies in children
  -- ───────────────────────────────────────────────────────────────────
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Safeguarding & Psycho-social emergencies in children' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    SELECT COALESCE(MAX("position"), 0) + 1 INTO v_max_pos FROM "modules" WHERE "course_id" = v_course_id;
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Safeguarding & Psycho-social emergencies in children', v_max_pos, now(), now())
    RETURNING "id" INTO v_mod_id;
    RAISE NOTICE 'Created new module: Safeguarding & Psycho-social emergencies in children (position %)', v_max_pos;
  ELSE
    RAISE NOTICE 'Found existing module: Safeguarding & Psycho-social emergencies in children (id %)', v_mod_id;
  END IF;

  -- Lesson: Child Abuse & Non-Accidental Injury (NAI) Recognition
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'child-abuse-non-accidental-injuries',
    'Child Abuse & Non-Accidental Injury (NAI) Recognition',
    'article',
    $L_CHILD_ABUSE_NON_ACCIDENTAL_INJURIES$# Child Abuse & Non-Accidental Injury (NAI) Recognition


> [!NOTE]
> **MRCEM SBA Masterclass Track:** Safeguarding & Psycho-social emergencies in children
> High-yield clinical guidance, diagnostic algorithms, and evidence-based emergency management based on RCEM, NICE, and UK guidelines.


Child abuse: head injuries,
wounds and burns
Following features suggest NAI
- Bruise over medial aspect of upper arms or thighs
- Bruise in non-mobile babies
- bruises on any non-bony part of the body or face including
the eyes, ears and buttocks
- Uncommon injuries bilaterally
- Finger 'imprinting eg: slap mark
- Imprints or marks of belt or stick
- Petechiae on the face may reflect smothering and
asphyxiation (it was suggested that 2-10% of SIDS may have
been smothered), however, petechiae also occur with forceful
coughing or vomiting.
Bruising
- Bruise over the knees and shins is consider as normal finding
in children (toddler)
- bruises over the lateral aspect of their elbows and hips in
older children during play are considered as normal finding.
Fractures
> Following fracture suggests NAI
- Rib and spinal fractures
- Multiple fractures of different ages

MRCEM INTERMEDIATE SBA ( Complete Course Guide With Question bank)
For Diet 2 Late 2026
Overview Comments
/26, 10:34 AM Child Abuse-Non-Accidental Injuries | MRCEM EXPERT LLC

- Fracture in infant who are not independently mobile
- Long bone fracture (eg: humerus, femur, radius , ulna etc) in
children<3 years
- Salter-Harris type I and II fractures of knee, wrist and elbow.
Head injuries (intracranial injury)
> Suspect child NAI if a child has an intracranial injury
in the absence of major confirmed accidental trauma
or known medical cause, in one or more of the
following circumstances:
- The explanation is absent or unsuitable
- The child is aged under 3 years
- retinal haemorrhages
- rib or long bone fractures
- there are multiple subdural haemorrhages with or without
subarachnoid haemorrhage in infant or toddler
Thermal injuries
> Suspect NAI if a child has burn or scald injury
- the explanation for the injury is unsuitable or absent
- if the child is not independently mobile
- Burn to any soft tissue area for example, the backs of hands,
soles of feet, buttocks, back.
- in the shape of an implement eg: cigarette, iron
> Following scalds indicates force immersion
- scalds to buttocks, perineum and lower limbs
- scalds to limbs in a glove or stocking distribution
- scalds to limbs with symmetrical distribution
- scalds with sharply delineated borders.
/26, 10:34 AM Child Abuse-Non-Accidental Injuries | MRCEM EXPERT LLC

Emotional abuse
-following signs may be indicators of emotional abuse:
-Children who are excessively withdrawn, fearful, or anxious
about doing
something wrong;
-Parents or carers who withdraw their attention from their
child, giving the child the 'cold shoulder'
-Parents or carers blaming their problems on their child; and
-Parents or carers who humiliate their child, for example, by
name-calling or making negative comparisons.
Neglect
-following signs may be indicators of neglect
-Children who are living in a home that is indisputably dirty or
unsafe;
-Children who are left hungry or dirty
-Children who are left without adequate clothing, e.g. not
having a winter coat;
-Children who are living in dangerous conditions, i.e. around
drugs, alcohol or violence
-Children who are often angry, aggressive or self-harm
-Children who fail to receive basic health care
-Parents who fail to seek medical treatment when their
children are ill or are injured
Management of child abuse
- Any suspicion of child abuse, involve senior clinician
paediatrician or ED consultant
- All hospitals have their own protocols and designated lead
professional ,who is available for advice
- He or she will assess the child and arrange hospital
admission for further investigations (eg: skeletal survey).
- Involve the police and social care
- Child may require forensic examination
/26, 10:34 AM Child Abuse-Non-Accidental Injuries | MRCEM EXPERT LLC

- Treat painful or life threatening injuries
- Ensure that all documentation is legible and meticulous
- Follow local protocol for multi-agency referral and social care
Sexual abuse
- Both boys and girls are affected
- The abuser is often a male relative or carer who is well known
to the child.
> Following features suggest child abuse
- injury to the genitalia or anus.
- Perineal pain, discharge, or bleeding.
- Behavioural disturbance, enuresis, and encopresis.
- Inappropriate sexual behaviour.
- The child may allege sexual abuse.
- STI (including anogenital warts).
- Pregnancy.
- Repeated UTIs.
Management:
- Record child statement word by word
- Don't perform genital examination
- Involve senior doctor at early stage
- Treat injuries which require urgent intervention
- Advise Pt to avoid destroying evidence (eg: don't shower,
bath, change or wash clothes etc)
- Refer or consult urgently to a specialist in the forensic
assessment of sexual assaults for the purposes of conducting a
forensic examination and to consider the need for
/26, 10:34 AM Child Abuse-Non-Accidental Injuries | MRCEM EXPERT LLC

22% Complete
Mark as Complete
contraception and potential for sexually transmitted infection
(STI).
- Police or a Sexual Assault Referral Centre (SARC) will be able
to arrange a specialist assessment.
- Child may require follow-up for STIs and psychological
sequelae and support.
Previous Next
/26, 10:34 AM Child Abuse-Non-Accidental Injuries | MRCEM EXPERT LLC


## High-Yield RCEM Examination Pearls


- **Core Syllabus Alignment:** Master the evidence-based diagnostic criteria, dosages, and contraindications for **Child Abuse & Non-Accidental Injury (NAI) Recognition**.
- **Emergency Disposition:** Always document clear clinical justification when discharging or admitting patients under UK emergency guidelines.
- **SBA Decision Making:** In Single Best Answer questions, select the safest, first-line evidence-backed management step before secondary investigations.$L_CHILD_ABUSE_NON_ACCIDENTAL_INJURIES$,
    false,
    0,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "status" = 'published',
    "updated_at" = now();

  -- Lesson: Female Genital Mutilation (FGM) Management & Legal Duty
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'female-genital-mutilation-fgm',
    'Female Genital Mutilation (FGM) Management & Legal Duty',
    'article',
    $L_FEMALE_GENITAL_MUTILATION_FGM$# Female Genital Mutilation (FGM) Management & Legal Duty


> [!NOTE]
> **MRCEM SBA Masterclass Track:** Safeguarding & Psycho-social emergencies in children
> High-yield clinical guidance, diagnostic algorithms, and evidence-based emergency management based on RCEM, NICE, and UK guidelines.


Female Genital Mutilation:
> It is also known as female genital circumcision or cutting
> Common in African countries
FGM and UK law
> FGM is illegal unless it is a surgical operation on a girl or
woman irrespective of her age:
- which is necessary for her physical or mental health
- she is in any stage of labour, or has just given birth, for
purposes connected with the labour or birth.
> It is illegal to arrange, or assist in arranging, for a UK national
or UK resident to be taken overseas for the purpose of FGM.
> It is an offence for those with parental responsibility to fail to
protect a girl from the risk of FGM.
> If FGM is confirmed in a girl under 18 years of age, must
report to police within 1 month
Diagnosis Features:
- Pt may report history of prior genital instrumentation
- Painful period and pain with urination
- Definitive diagnosis made after physical examination
Complication of FGM
> Short-term complication:
- Haemorrhage
- Urinary retention

MRCEM INTERMEDIATE SBA ( Complete Course Guide With Question bank)
For Diet 2 Late 2026
Overview Comments
/26, 10:34 AM Female Genital Mutilation (FGM) | MRCEM EXPERT LLC

22% Complete
Mark as Complete
- Genital swelling
- Infection
> Long-term complication
- Genital scarring
- Recurrent urinary infection
- Dyspareunia
- Genital infection and pelvic inflammatory disease
- HIV, Hep B
- Infertility
Management:
- Accurately record examination findings
- All women and girls with acute or recent FGM require police
and social services referral.
- All children with FGM or suspected FGM should be seen
within child safeguarding service
Previous Next
/26, 10:34 AM Female Genital Mutilation (FGM) | MRCEM EXPERT LLC


## High-Yield RCEM Examination Pearls


- **Core Syllabus Alignment:** Master the evidence-based diagnostic criteria, dosages, and contraindications for **Female Genital Mutilation (FGM) Management & Legal Duty**.
- **Emergency Disposition:** Always document clear clinical justification when discharging or admitting patients under UK emergency guidelines.
- **SBA Decision Making:** In Single Best Answer questions, select the safest, first-line evidence-backed management step before secondary investigations.$L_FEMALE_GENITAL_MUTILATION_FGM$,
    false,
    1,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "status" = 'published',
    "updated_at" = now();

  -- ───────────────────────────────────────────────────────────────────
  -- Module: Infectious Diseases & Global Health
  -- ───────────────────────────────────────────────────────────────────
  SELECT id INTO v_mod_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Infectious Diseases & Global Health' AND "deleted_at" IS NULL LIMIT 1;
  IF v_mod_id IS NULL THEN
    SELECT COALESCE(MAX("position"), 0) + 1 INTO v_max_pos FROM "modules" WHERE "course_id" = v_course_id;
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Infectious Diseases & Global Health', v_max_pos, now(), now())
    RETURNING "id" INTO v_mod_id;
    RAISE NOTICE 'Created new module: Infectious Diseases & Global Health (position %)', v_max_pos;
  ELSE
    RAISE NOTICE 'Found existing module: Infectious Diseases & Global Health (id %)', v_mod_id;
  END IF;

  -- Lesson: Kawasaki Disease Diagnosis & Emergency Management
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'kawasaki-disease',
    'Kawasaki Disease Diagnosis & Emergency Management',
    'article',
    $L_KAWASAKI_DISEASE$# Kawasaki Disease Diagnosis & Emergency Management


> [!NOTE]
> **MRCEM SBA Masterclass Track:** Infectious Diseases & Global Health
> High-yield clinical guidance, diagnostic algorithms, and evidence-based emergency management based on RCEM, NICE, and UK guidelines.


Kawasaki Disease:
- It's an acute, febrile, self-limiting, systemic vasculitis of
unknown origin that almost exclusively affects young children.
Risk factors
- Asian ancestry
- age 3 months to 4 years
- male sex
Diagnostic features
- Fever for more than 5 days at least 4 of the following features
- Polymorphic rash
- Bilateral conjunctival injection
- mucosal erythema with strawberry tongue.
- Swelling and erythema of the hands and feet occur in the
acute stage, followed by desquamation in the second week.
- Unilateral non-purulent cervical lymphadenopathy is present
in about 40% of cases.
- Coronary aneurysms develop in 20% to 25% of untreated
patients.
Investigation:
> FBC
- Haemoglobin low for age (Mild-moderate normocytic anemia
present in acute phase)

MRCEM INTERMEDIATE SBA ( Complete Course Guide With Question bank)
For Diet 2 Late 2026
Overview Comments
/26, 10:34 AM Kawasaki Disease | MRCEM EXPERT LLC

22% Complete
Mark as Complete
- Platelet > 450,000/mm ( thrombocytosis present in subacute
phase)
- WBC>15,000/mm
- Serum albumin<3.0 g/dl
- serum erythrocyte sedimentation rate (ESR)
- serum CRP
- LFTs (Elevated alanine aminotransferase)
- ECG
- Echocardiogram( perform during and after acute illness and if
echo reveal cardiac abnormality then refer child to
paediatrician for further cardiac work-up
Management:
- intravenous immunoglobulin and/or aspirin. In resistant
cases, corticosteroids or a tumour necrosis factor (TNF)-alpha
inhibitor may be indicated.
Previous Next
/26, 10:34 AM Kawasaki Disease | MRCEM EXPERT LLC


## High-Yield RCEM Examination Pearls


- **Core Syllabus Alignment:** Master the evidence-based diagnostic criteria, dosages, and contraindications for **Kawasaki Disease Diagnosis & Emergency Management**.
- **Emergency Disposition:** Always document clear clinical justification when discharging or admitting patients under UK emergency guidelines.
- **SBA Decision Making:** In Single Best Answer questions, select the safest, first-line evidence-backed management step before secondary investigations.$L_KAWASAKI_DISEASE$,
    false,
    0,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "status" = 'published',
    "updated_at" = now();

  -- Lesson: UK Statutory Notifiable Diseases & Reporting Guidelines
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_mod_id,
    'notifiable-diseases-reporting',
    'UK Statutory Notifiable Diseases & Reporting Guidelines',
    'article',
    $L_NOTIFIABLE_DISEASES_REPORTING$# UK Statutory Notifiable Diseases & Reporting Guidelines


> [!NOTE]
> **MRCEM SBA Masterclass Track:** Infectious Diseases & Global Health
> High-yield clinical guidance, diagnostic algorithms, and evidence-based emergency management based on RCEM, NICE, and UK guidelines.


Diseases notifiable to local authority
proper officers under the Health
Protection (Notification) Regulations
2010:
- Acute encephalitis
- Acute infectious hepatitis
- Acute meningitis
- Acute poliomyelitis
- Anthrax
- Botulism
- Brucellosis
- Cholera
- COVID-19
- Diphtheria
- Enteric fever (typhoid or paratyphoid fever)
- Food poisoning
- Haemolytic uraemic syndrome (HUS)
- Infectious bloody diarrhoea
- Invasive group A streptococcal disease
- Legionnaires' disease
- Leprosy

MRCEM INTERMEDIATE SBA ( Complete Course Guide With Question bank)
For Diet 2 Late 2026
Overview Comments
/26, 10:35 AM List of Notifiable Diseases | MRCEM EXPERT LLC

22% Complete
Mark as Complete
- Malaria
- Measles
- Meningococcal septicaemia
- Monkeypox
- Mumps
- Plague
- Rabies
- Rubella
- Severe Acute Respiratory Syndrome (SARS)
- Scarlet fever
- Smallpox
- Tetanus
- Tuberculosis
- Typhus
- Viral haemorrhagic fever (VHF)
- Whooping cough
- Yellow fever
Report other diseases that may present significant risk to
human health under the category 'other significant disease'.
Previous Next
/26, 10:35 AM List of Notifiable Diseases | MRCEM EXPERT LLC


## High-Yield RCEM Examination Pearls


- **Core Syllabus Alignment:** Master the evidence-based diagnostic criteria, dosages, and contraindications for **UK Statutory Notifiable Diseases & Reporting Guidelines**.
- **Emergency Disposition:** Always document clear clinical justification when discharging or admitting patients under UK emergency guidelines.
- **SBA Decision Making:** In Single Best Answer questions, select the safest, first-line evidence-backed management step before secondary investigations.$L_NOTIFIABLE_DISEASES_REPORTING$,
    false,
    1,
    'published',
    now(),
    now()
  ) ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "status" = 'published',
    "updated_at" = now();

  -- Refresh course update timestamp
  UPDATE "courses" SET "updated_at" = now() WHERE "id" = v_course_id;

  RAISE NOTICE 'Successfully appended 19 SBA lectures across 5 modules with 38 figures.';
END $$;