-- ==========================================================================
-- FLAGSHIP COURSE: MRCEM SBA
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
  -- 1. Locate MRCEM SBA exam (fallback to primary if exam slug differs)
  SELECT id INTO v_exam_id FROM "exams" WHERE "slug" = 'mrcem-sba' LIMIT 1;
  IF v_exam_id IS NULL THEN
    SELECT id INTO v_exam_id FROM "exams" WHERE "slug" = 'mrcem-primary' LIMIT 1;
  END IF;

  -- 2. Upsert Course: mrcem-sba
  SELECT id INTO v_course_id FROM "courses" WHERE "slug" = 'mrcem-sba' LIMIT 1;
  IF v_course_id IS NULL THEN
    INSERT INTO "courses" (
      "id", "exam_id", "slug", "title", "summary", "description", "is_free", "position", "status", "created_at", "updated_at"
    ) VALUES (
      gen_random_uuid(),
      v_exam_id,
      'mrcem-sba',
      'MRCEM SBA',
      'High-yield Single Best Answer (SBA) question bank and timed mock exam simulation papers with full clinical rationales.',
      'Master the MRCEM SBA (Intermediate) examination with high-yield clinical case-based questions. Features timed mock exam simulation papers, expert MOKA clinical scenarios, and topical clinical modules with comprehensive explanations and diagnostic algorithms.',
      false,
      2,
      'published',
      now(),
      now()
    ) RETURNING "id" INTO v_course_id;
  ELSE
    UPDATE "courses" SET
      "title" = 'MRCEM SBA',
      "exam_id" = COALESCE(v_exam_id, "exam_id"),
      "summary" = 'High-yield clinical SBA question bank with timed mock exams and expert clinical scenarios.',
      "description" = 'Master the MRCEM SBA (Intermediate) examination with high-yield clinical case-based questions. Features timed mock exam simulation papers, expert MOKA clinical scenarios, and topical clinical modules with comprehensive explanations and diagnostic algorithms.',
      "position" = 2,
      "status" = 'published',
      "deleted_at" = NULL,
      "updated_at" = now()
    WHERE "id" = v_course_id;
  END IF;

  -- =========================================================================
  -- CLEANUP: Remove misplaced Primary Basic Science quiz modules from mrcem-sba
  -- These quizzes (1-41) belong to mrcem-primary, not mrcem-sba
  -- =========================================================================
  UPDATE "modules"
  SET "deleted_at" = now(), "updated_at" = now()
  WHERE "course_id" = v_course_id
    AND "title" IN (
      'High-Yield SBA Quizzes: Part 1 (Quizzes 01 - 10)',
      'High-Yield SBA Quizzes: Part 2 (Quizzes 11 - 20)',
      'High-Yield SBA Quizzes: Part 3 (Quizzes 21 - 30)',
      'High-Yield SBA Quizzes: Part 4 (Quizzes 31 - 41)'
    )
    AND "deleted_at" IS NULL;

  -- Also soft-delete lessons inside those modules
  UPDATE "lessons"
  SET "deleted_at" = now(), "updated_at" = now()
  WHERE "module_id" IN (
    SELECT id FROM "modules"
    WHERE "course_id" = v_course_id
      AND "title" IN (
        'High-Yield SBA Quizzes: Part 1 (Quizzes 01 - 10)',
        'High-Yield SBA Quizzes: Part 2 (Quizzes 11 - 20)',
        'High-Yield SBA Quizzes: Part 3 (Quizzes 21 - 30)',
        'High-Yield SBA Quizzes: Part 4 (Quizzes 31 - 41)'
      )
  )
  AND "deleted_at" IS NULL;


  -- Module 5: MRCEM SBA Mock Simulations
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'MRCEM SBA Mock Simulations' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'MRCEM SBA Mock Simulations', 4, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 4, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Mock – I Paper – Ii
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'mock-i-paper-ii',
    'Mock – I Paper – Ii',
    'article',
    '# Mock – I Paper – Ii

> [!NOTE]
> **Instructions:** Single best answer scenario. Read carefully before reviewing the detailed rationale.

Mrcem Primary Complete Course ,High Yield Stuff and Questions Bank ( For
Diet ii Late 2026)
Overview  Comments
Share your score colleagues

LinkedIn  Facebook  Twitter

## Question 18 of 90

1. A 27-year-old man falls from a ladder. Neurological
examination reveals an isolated defect of proprioception.
Which tract is most likely injured?

## Question 1 of 90

- **A.** Dorsal column
- **B.** Lateral corticospinal
- **C.** Lateral spinothalamic
- **D.** Anterior spinothalamic
- **E.** Posterior spinothalamic tract

## Question 1 of 70

2. What is the normal right ventricular systolic pressure?
Normal RV systolic pressure is 20–30 mmHg and
normal diastolic pressure is 3–7 mmHg.

## Question 2 of 90

- **A.** 3-7mmhg
- **B.** 20-30mmhg
- **C.** 10-20mmhg
- **D.** 5-10mmhg
- **E.** 7-12mmhg
3. The phrenic nerve receive contributions from which of
the following?

## Question 3 of 90

- **A.** Posterior rami of C3 -C5
- **B.** Anterior rami to C4 -C7
- **C.** Posterior rami of C1 -C3
- **D.** Anterior rami of C3 – C5
- **E.** Anterior rami of C1 -C3

## Question 2 of 70

The phrenic nerve originates from cervical spinal
roots C3, C4 and C5
provide motor innervation to the diaphragm
(RECALL).
provide sensory innervation the central part of the
diaphragm, the pericardium and the mediastinal
part of the parietal pleura. (RECALL)
7. Regarding the pathophysiology of peptic ulcer disease
which one of the following statements is true?
Brunner''s glands are located in the submucosa of
the duodenum. They secrete an alkaline fluid
containing mucin, which protects the mucosa from
the acidic stomach contents entering the
duodenum and provide alkaline condition for the
intestinal enzymes to be active
High Yield:
A cell of pancreas =Glucagon
B cells of pancreas -=Insulin

## Question 7 of 90

- **A.** Bicarbonate secretion from pancreatic ductal
cells
- **B.** Bicarbonate secretion from Brunner''s glands
- **C.** Gastric inhibitory polypeptide secretion from K
cells
- **D.** H+ Secretion from Brunner''s glands
- **E.** H+ Secretion from pancreatic ductal cells

## Question 3 of 70

D cells of pancreas =Somatostatin
E cells of pancreas = Ghrelin (Ghrelin released
mainly by the stomach and in small amounts
released by small intestine and pancreas. Ghrelin
regulates appetite and satiety (Recall)
F cells of pancreas = Pancreatic polypeptide
G cells in pyloric antrum = Gastrin
I cell in duodenum and jejunum = CCK
K cells in duodenum and jejunum = GIP
S cells in duodenum =Secretin
8. A new born baby brought into ED by his mother with
complaint of grunting and respiratory distress. You suspect
infant respiratory distress syndrome. Regarding surfactant
which one of the following is true?
surfactant produced by type 2 alveolar epithelial
cells pneumocytes (Recall). it decreases surface
tension and increases lung compliance
Surfactant is made-up of 80% of phospholipids
(Recall)
10% of proteins
10% of neutral lipids, mainly cholesterol

## Question 8 of 90

- **A.** Decrease lung compliance
- **B.** Decrease surface tension
- **C.** Increase surface tension
- **D.** Produced by type 1 pneumocytes
- **E.** Surfactant increases in smokers

## Question 4 of 70

Note: Type 1 alveolar epithelium is responsible for
gaseous exchange. Impaired gas exchange
(Hypoxia) is due to deficiency of Type 1 (Recall)
9. A patient presents with life-threatening asthma and
requires a salbutamol Infusion. Which electrolyte
abnormality is most likely to occur during this
administration?
Salbutamol Is beta 2 agonist reduces the serum
potassium levels by increasing the shift of
extracellular potassium into the intracellular space.
Salbutamol also used in the treatment of
hyperkalemia (RECALL)
Drugs causing hypokalemia:
B2 agonist (salbutamol)
Theophylline
Corticosteroids
Thiazide
Furosemide

## Question 9 of 90

- **A.** Hypomagnesaemia
- **B.** Hypokalemia
- **C.** Hypercalcemia
- **D.** Hyponatremia
- **E.** Hyperkalemia
11. A patient requires intubation due to respiratory failure.
Your consultant wants to ensure you correctly

## Question 11 of 90

## Question 5 of 70

preoxygenate the patient to replace nitrogen with oxygen,
allowing a safer apnea time during Intubation
Which lung volume measurement best describes the
volume of nitrogen that you are displacing?
The functional residual capacity (FRC) is the most
important store of oxygen in the body. The greater
the FRC, the longer apnoea can be tolerated before
critical hypoxia develops. The aim of preoxygenation
is to replace nitrogen in the FRC with oxygen; this
process is also referred to as denitrogenation . This
has a significant impact on body oxygen store and
therefore increases tolerance to apnoea
substantially.
Intubation in the supine position can lead to a
decrease in functional residual capacity (Recall)
- **A.** Functional residual capacity
- **B.** Inspiratory capacity
- **C.** V Vital capacity
- **D.** Total lung capacity
- **E.** Residual volume
12. Regarding the intrinsic muscles of hand, Froment''s sign
tests the function of which one of the following muscles?

## Question 12 of 90

- **A.** Adductor pollicis
- **B.** Flexor policies Longus

## Question 6 of 70

Froment''s sign: Patient is asked to hold a piece of
paper between thumb and flat palm as paper is
pulled away, patient will flex thumb at inter-
phalangeal joint to maintain hold, this sign tests the
function of adductor pollicis muscle which is supply
by the ulnar nerve. (RECALL)
- **C.** Abductor pollicis
- **D.** Flexor policies breves
- **E.** Opponents pollicis
14. What is the vertebral level of bifurcation of the trachea
in a living person?
The trachea extends from inferior end of larynx at C6
vertebra and ends at the level of sternal angle (T4-T5
Intervertebral disc) where it divides into left and
right main bronchi.

## Question 14 of 90

- **A.** T2/T3
- **B.** T5/T6
- **C.** T6/T7
- **D.** T4/T5
- **E.** T3/T4
15. The conus medullaris of the spinal cord lies at which of
the following vertebral level in adults?

## Question 15 of 90

## Question 7 of 70

Conus medullaris lies at birth= L3 level
By the age of 21= L1/L2
- **A.** L3/L4
- **B.** L4/L5
- **C.** T11/T12
- **D.** L1/L2
- **E.** T12/L1
16. A 40-year-old male presents to ER with headache and
hypertensive emergency.  You prescribe sodium
nitroprusside. What is the mechanism of action of sodium
nitroprusside?
Sodium nitroprusside breaks down in circulation to
release nitric oxide (NO).
Nitrates are potent coronary vasodilators.
Nitric oxide activates guanylyl cyclase, causing
increase in the intracellular concentration of cGMP
in vascular smooth muscle cells. cGMP activates
the protein kinase G, which ultimately cause
vascular smooth muscle relaxation (RECALL).

## Question 16 of 90

- **A.** Alpha adrenoceptor agonist
- **B.** Renin inhibitor
- **C.** Ca+ channel blocker
- **D.** Release nitric oxide
- **E.** Ca+ channel activator

## Question 8 of 70

17. A 50-year-old woman presents to the ED with
generalized weakness and breathlessness. she also gives
a history of flu like illness 10 days ago. Her chest X-ray
shows cardiomegaly. A diagnosis of myocarditis is made.
which of the following pathogen is most likely involved in
myocarditis?
Myocarditis is inflammation of the heart muscle
(myocardium)
The most commonly implicated etiology is viral, of
which enteroviruses, notably Coxsackie B, are the
most common.
Coxsackie is the most common cause of hand,
foot and mouth disease typically spread via
respiratory aerosol and feco-oral route (Recall)

## Question 17 of 90

- **A.** Staphylococcus aureus
- **B.** Corynebacterium diphtheria
- **C.** Coxsackievirus
- **D.** Varicella zoster virus
- **E.** Epstein Barr virus
18. A 45-year-old man with a history of longstanding
excessive alcohol intake presents with massive ascites,
you are required to perform large-volume paracentesis,
which one of the following fluids is best given during
paracentesis?

## Question 18 of 90

- **A.** 20% Albumin
- **B.** Half Saline

## Question 9 of 70

Administer 1 unit (100ml) HAS 20% (Human
Albumin Solution, 20% i.e., 20g albumin  per 100ml)
(STAT) following every 3 liters of ascites drained.
Note: Paracentesis without albumin replacement
leads to a fall in pulmonary capillary wedge
pressure, maximal at 6 hours, and can result in
circulatory and renal dysfunction.
Note:  Ascites results from high pressure in the
blood vessels of the liver (portal hypertension
Recall) and low levels of a albumin.
- **C.** Ringer lactate
- **D.** 10% Albumin
- **E.** 0.9% N/Saline
19. Sensory innervation of the nasopharynx is supplied by
which of the following nerve?
Each subdivision of the pharynx has different
sensory innervation:
The nasopharynx is supplied by the maxillary nerve

## Question 19 of 90

- **A.** Glossopharyngeal nerve
- **B.** Vagus nerve
- **C.** Maxillary nerve
- **D.** Facial nerve
- **E.** Mandibular nerve

## Question 10 of 70

The oropharynx is supplied d by the
glossopharyngeal (RECALL)
The laryngopharynx is supplied by the vagus nerve.
21. A young athlete presents to the ED after sustaining an
injury to the right upper extremity. Physical examination
reveals weak right forearm flexion and an absent biceps
reflex. Given these findings, sensation loss in which of the
following areas is most likely to be found in this patient?
High yield:

## Question 21 of 90

- **A.** Posterior forearm
- **B.** Medial forearm
- **C.** Posterior arm
- **D.** Lateral forearm
- **E.** Thenar eminence
24. A 70-year-old woman has a pathological fracture of her
femur. Her blood tests reveal hypercalcemia,
hypophosphatemia, and raised parathyroid hormone.

## Question 24 of 90

## Question 11 of 70

What is the most likely diagnosis?
Note: In osteomalacia : Elevated alkaline
phosphatase, Decreased vit D, Hypocalcemia and
increased PTH
- **A.** Primary hyperparathyroidism
- **B.** Paget''s disease
- **C.** Myeloma
- **D.** Bony metastasis
- **E.** Osteomalacia
27. Which one of the following receptors is mainly
responsible for smooth muscle contraction and blood
vessels constriction?

## Question 27 of 90

- **A.** Beta 3
- **B.** Alpha 2
- **C.** Alpha 1
- **D.** Beta 1

## Question 12 of 70

A useful way to remember: Alpha 1 for constriction,
Alpha 2 for inhibition, B 1 for heart, and B2 for
relaxation
High yield:
Note: Nitroprusside is metabolized to nitric oxide,
which causes both arterial and venous dilation
(Recall) This effect is immediate and results in a
decrease in both preload and afterload. (Recall)
- **E.** Beta 2
29. A 35-year-old male presents with fever and cough
productive of small amounts of clear sputum. Chest
radiography documents bilateral lower lobe infiltrates that
are more pronounced on the right side. Causative agent is?

## Question 29 of 90

- **A.** Streptococcus pnemoniae
- **B.** Mycoplasma pneumoniae
- **C.** Pseudomonas
- **D.** Influenza virus
- **E.** S. aureus

## Question 13 of 70

Pneumococcal pneumonia is a common lung
infection caused by the organism Streptococcus
pneumoniae.
Streptococcus pneumoniae is one of the most
common causes of community-acquired
pneumonia. The clinical presentation of
pneumococcal pneumonia includes fever, cough
and malaise and may also include chest pain and
dyspnea or tachypnoea. Radiographic appearances
considered classic for pneumococcal pneumonia
include lobar consolidations and air bronchograms
in adults and round pneumonia in children.
Note: Streptococcus pneumoniae is a commensal
pathogen (Recall).
30. Which of the following is not a physiological change in
pregnancy?
Physiological changes in pregnancy

## Question 30 of 90

- **A.** Increased cardiac output
- **B.** Decreased gastric motility
- **C.** Decrease in tidal volume
- **D.** Increased red cell volume
- **E.** Increased plasma volume

## Question 14 of 70

31. A 40-year-old male presents to the ED with headache.
His BP was found to be 180/90. He is currently under
investigation for suspected Cushing’s syndrome. What is
the most common cause of Cushing disease?
Cushing’s disease refers to the specific condition of
excessive corticosteroids as a result of ACTH-
secreting pituitary adenoma.

## Question 31 of 90

- **A.** Small cell lung cancer
- **B.** Pituitary adenoma
- **C.** Squamous cell lung cancer
- **D.** Adrenal adenoma
- **E.** Adrenal carcinoma
32. A 35 years old male presents to the ED with complaint
of swelling in the right inguinal region. Regarding hernia
which one of the following types protrudes through
Hesselbach''s triangle?

## Question 32 of 90

- **A.** Direct inguinal hernia
- **B.** Indirect inguinal hernia
- **C.** Spigelian hernia
- **D.** Femoral hernia
- **E.** Paraumbilical hernia

## Question 15 of 70

Direct inguinal hernia lies medial to inferior
epigastric vessels while indirect inguinal hernia lies
lateral to inferior epigastric vessels. (RECALL)
Most common type of inguinal hernia=indirect
inguinal hernia (Recall)
Most common side of inguinal hernia=Right side
(RECALL)
The floor of the inguinal canal is the inguinal
ligament, otherwise known as the Poupart
ligament, which is formed by the external oblique
aponeurosis (RECALL)
Type of hernia that enters the deep inguinal
ring=indirect inguinal hernia (RECALL)
Type of hernia that protrudes through Hesselbach’s
triangle=Direct inguinal hernia (RECALL).
33. A 40-year-old male presents to ER with a deep
laceration to the proximal part of the forearm. On
examination when patient is asked to make a fist, he is
unable to flex the metacarpophalangeal joints or
interphalangeal joints of index and middle or thumb, ring
and little fingers are intact but there is loss of sensation
over the lateral palm and the Palmer surface of lateral three
and a half fingers. Nerve has most likely been affected is?
Nerve roots: C6 – T1 (also contains fibers from C5 in
some individuals).

## Question 33 of 90

- **A.** Radial Nerve
- **B.** Median nerve
- **C.** Musculocutaneous nerve
- **D.** Median and radial nerve
- **E.** Ulnar nerve

## Question 16 of 70

Motor functions: Innervates the flexor and pronator
muscles in the anterior compartment of the forearm
(except the flexor carpi ulnaris and part of the flexor
digitorum profundus, innervated by the ulnar nerve
(RECALL)). Also supplies innervation to the thenar
muscles and lateral two lumbricals in the hand.
(RECALL)
Sensory functions: Gives rise to the palmar
cutaneous branch, which innervates the lateral
aspect of the palm, and the digital cutaneous
branch, which innervates the lateral three and a half
fingers on the anterior (palmar) surface of the hand
In Median nerve injury little finger is spared.
(Innervated by ulnar nerve) RECALL
wasting of thenar eminence: nerve involved=
median nerve (RECALL)
wasting of Hypothenar eminence: nerve involved=
ulnar nerve (RECALL)
34. A 64-year-old man presents to the emergency
department with sudden painless loss of vision in his left
eye. Which one of the following arteries is most likely
occluded?
Central retinal artery occlusion causes sudden
painless loss of vision
Central retinal artery is a branch of ophthalmic
artery, and Opthalmic artery is a first major branch

## Question 34 of 90

- **A.** External carotid artery
- **B.** Vertebral artery
- **C.** Facial artery
- **D.** Internal carotid artery
- **E.** Posterior auricular artery

## Question 17 of 70

of internal carotid artery
35. A 42-year-old man had a long history of heavy smoking,
poorly controlled blood pressure (BP), and irregular health
checkups. He developed projectile vomiting and then
sudden loss of consciousness. He was taken to the
emergency room within 30 min. The vital signs showed BP
165/95 mmHg, GCS score of E1M2V1, and bilateral
pinpoint pupil, this is most likely a case of?
Pontine hemorrhage is a form of intracerebral
hemorrhage usually result from poorly controlled
hypertension, characterized by sudden loss of
consciousness, quadriplegia, pinpoint pupil, and
respiratory difficulty

## Question 35 of 90

- **A.** Pontine hemorrhage
- **B.** Metastatic thyroid carcinoma
- **C.** Wallenberg syndrome
- **D.** Subdural hematoma
- **E.** Vertebral artery dissection
36. A 55 years old male known case of HIV presented to
the ED with Complain of Cough and breathlessness. You
suspect pneumocystis jiroveci pneumonia, which one of the
following is treatment of choice?

## Question 36 of 90

- **A.** Respiratory Quinolones
- **B.** Trimethoprim and sulfamethoxazole

## Question 18 of 70

Trimethoprim and sulfamethoxazole is
recommended first line treatment against
pneumocystis jiroveci pneumonia.
Note: Trimethoprim causes folate deficiency that’s
why teratogenic in early pregnancy.
- **C.** Ceftriaxone
- **D.** Gentamycin
- **E.** Tetracyclines and sulfamethoxazole
37. Regarding the epithelium of respiratory tract. Which of
the following is true?
Respiratory tract from the trachea down until the
respiratory bronchioles is lined with Ciliated
columnar epithelium

## Question 37 of 90

- **A.** Transitional epithelium
- **B.** Simple squamous epithelium
- **C.** Simple stratified epithelium
- **D.** Ciliated columnar epithelium
- **E.** Stratified columnar epithelium
38. From sitting to standing there is compensation by which
mechanism?

## Question 38 of 90

- **A.** Increase TPR

## Question 19 of 70

Normally from sitting to standing position, there is
of pooling of blood in veins of the leg due to gravity
that''s why central venous pressure, stroke volume
and cardiac output fall and fall in blood pressure
this fall in BP rapidly sense by baroreceptor reflex
which cause vasoconstriction and an increase in
heart rate and contractility, so restoring the stroke
volume, cardiac output and blood pressure.
- **B.** Increase heart rate
- **C.** Increase venous return
- **D.** Decrease heart rate
- **E.** Decrease Cardiac output
40. A 30 years old male presents to the ED with complain
of abdominal bloating, nausea, and bouts of watery
diarrhea. You suspect infection of giardia lamblia. Giardia
lamblia attaches to gut mucosa via?
Microorganism & Mechanism of Attachment
Neisseria gonorrhoeae, E-Coli=Adheres to the
genital mucosa using fimbriae

## Question 40 of 90

- **A.** Specialized sucking disc
- **B.** Attaches by its haemagglutinin antigen
- **C.** Specialized hooks
- **D.** Curli fibers
- **E.** Using fimbriae

## Question 20 of 70

Influenza Attaches =by its haemagglutinin
antigen (Recall)
Giardia lamblia=Attaches to gut mucosa via a
specialized sucking disc
41. Whilst in your physiology lecture you ask medical
students, which of the following causes a right shift in the
oxygen dissociation curve?

Causes of left ward shift
Increased affinity for oxygen (Less willing to give up
oxygen)
Increased pH
Decreased pCO2
Decreased temperature
Decreased H+
Decreased 2-3DPG
CO poisoning
Methemoglobinemia
Fetal hemoglobin (Recall)
Causes of Right ward shift

## Question 41 of 90

- **A.** Increase PH
- **B.** Decrease PCO2
- **C.** Decrease H+
- **D.** Fetal Hb
- **E.** Decrease PH

## Question 21 of 70

: Decreased affinity for oxygen (More willing to give
up oxygen)
Decreased pH (Recall)
Increased pCO2
Increased H+
Increased Temperature
Increased 2-3DPG
Pregnancy (oxygen to the fetus)
42. A 30-year-old male presents to the ED with a 3.5-week
history of a cough and hemoptysis. These symptoms began
after he was diagnosed with upper respiratory tract
infection. He denies having any fever, night sweats, and
has not noticed any changes to his weight. Currently, his
blood pressure is 155/90 mm Hg, and his pulse is 85 bpm.
A physical exam is notable for bilateral crackles and he
also has edema on his lower extremities. Lab values reveal
a creatinine of 4.5 mg/dL. Urine tests show the presence of
proteinuria and also hematuria. A chest X-ray demonstrates
the presence of bilateral pulmonary infiltrates. Pulmonary
function testing reveals an increased carbon monoxide
diffusion capacity (DLCO). What condition might this patient
have?
Chief complaints in case of Goodpasture syndrome
(GPS):

## Question 42 of 90

- **A.** Nephrotic syndrome
- **B.** IgA nephropathy
- **C.** Goodpasture syndrome
- **D.** PSGN
- **E.** Lupus nephritis

## Question 22 of 70

Shortness of breath: caused by alveolar
hemorrhage.
Hemoptysis: due to lung involvement
Hematuria due to kidney involvement
Clinical Workup:
Presence of pulmonary infiltrates on chest X-ray:
caused by pulmonary hemorrhage.
Increased carbon monoxide diffusion capacity
(DLCO) on pulmonary function testing: the present
of blood in the alveoli (due to alveolar hemorrhage)
results in increased DLCO
Linear deposition of IgG in the glomeruli
(immunofluorescence)
44. Which of the following are the phagocytic cells derived
from monocytes?
Monocytes circulate in the bloodstream for about
one to three days and then typically migrate into
tissues throughout the body where they
differentiate into macrophages and dendritic cells.

## Question 44 of 90

- **A.** Macrophages
- **B.** Mast cells
- **C.** Eosinophils
- **D.** NK cells
- **E.** Neutrophils
45. A 20 years old male presents to the ED following stab
wound to antecubital fossa with complaint of unable to flex
his index and middle finger resulting in unopposed

## Question 45 of 90

## Question 23 of 70

extension of index and middle finger. Which one of the
following nerves is most likely injured?
common injuries affecting the median nerve
include:
Supracondylar fracture of humerus
Stab wound to antecubital fossa
Compression of carpel tunnel syndrome (RECALL)
Median nerve innervation
Motor supply: all the anterior compartment of
forearm muscles (Flexor compartment) (except
flexor Carpi ulnaris and medial half of flexor
digitorum profundus), the thenar muscles (flexor
policies brevis, abductor pollicis brevis, opponent
policies) and lateral two lumbricals are supplied by
median nerve
Sensory supply: lateral aspect of palm and palmar
surface and fingertips of lateral three and half
digits. (RECALL).
- **A.** Radial nerve
- **B.** Median nerve
- **C.** Musculocutaneous nerve
- **D.** Ulnar nerve
- **E.** Axillary nerve
46. A 32-year-old dialysis patient collapses at home. He is
due for dialysis today. He has severe hyperkaliemia k+ 7.4,
and you perform a 12 lead ECG

## Question 46 of 90

## Question 24 of 70

What ECG feature would you be most likely to see
immediately prior to deterioration to cardiac arrest?
- **A.** Prolonged PR interval
- **B.** Broad QRS complexes
- **C.** Peaked T waves
- **D.** Sinus tachycardia
- **E.** Flattened P waves
47. A 50-year-old male presents to ER with generalized
weakness, on performing neurological examination you
noticed that he has unilateral absence of biceps reflex.
Which spinal nerves is responsible for this reflex?

## Question 47 of 90

- **A.** L1-L2
- **B.** C5-C6
- **C.** C7-C8

## Question 25 of 70

Biceps reflex root value =C5-C
Triceps reflex root value= C7-C8
knee = L3-L4(RECALL)
Ankle= S1
- **D.** C8- T1
- **E.** C6-C7
49. A 32-year-old male presents to ED with ongoing
continuous vomiting. He is several dehydrated. Which of
the following hormone released in response to
dehydration?
ADH reduces water loss via lowered urine volume.
Extracellular dehydration (hypovolemia) stimulates
specific vascular receptors that signal brain centers
to initiate drinking and ADH release
ADH acts on kidney to promote water retention and
on the vascular system cause vasoconstriction ADH
also known as vasopressin.
• ADH and oxytocin are released from posterior
pituitary gland (RECALL).

## Question 49 of 90

- **A.** Antidiuretic hormone
- **B.** Growth hormone
- **C.** Oxytocin
- **D.** Parathyroid
- **E.** Somatostatin

## Question 26 of 70

50. A 30-year-old male presents to ED after being stabbed
in the Axilla. On examination you note the loss of sensation
over the lateral forearm and you suspect a
Musculocutaneous nerve injury. The Musculocutaneous
nerve arise from which of the following cord of brachial
plexus?
The Musculocutaneous nerve(C5-C7) arise from the
lateral cord of brachial plexus
Motor supply: anterior compartment of arm
muscles (coracobrachialis, biceps brachii,
brachialis) RECALLL
SENSORY supply: Lateral forearm (RECALL)
Function: flexion and supination of forearm
(RECALL)

## Question 50 of 90

- **A.** Lateral posterior cord
- **B.** Posterior cord
- **C.** Medial cord
- **D.** Lateral cord
- **E.** Medial and posterior cord
51. An 18-year-old boy presents to the ED with a
nosebleed. On examination, you suspect the site of
bleeding to be in little’s area which of the following blood
vessels are likely to be involved?

## Question 51 of 90

- **A.** Anterior ethmoidal and posterior superior
alveolar arteries

## Question 27 of 70

Little’s area also known as Kieselbach''s plexus is
formed by:
Superior labial artery
Sphenopalatine artery
The greater palatine artery
The anterior ethmoidal artery
- **B.** Descending palatine and ascending pharyngeal
arteries
- **C.** Ascending pharyngeal and descending palatine
arteries
- **D.** Sphenopalatine and superior labial arteries
- **E.** Descending palatine and anterior ethmoidal
arteries
52. A patient with a known spinal cord ependymoma
presents to his neurologist for a checkup. He complains
that he has had difficulty walking, which he attributes to left
leg weakness. On exam, he is noted to have 1/5 strength in
his left lower extremity, as well as decreased vibration and
position sensation in the left lower extremity and decreased
pain and temperature sensation in the right lower extremity.
Which of the following spinal cord lesions is most
consistent with his presentation?

## Question 52 of 90

- **A.** Syringomyelia
- **B.** Posterior cord syndrome
- **C.** Left-sided Brown-Sequard (hemisection)
- **D.** Right-sided Brown-Sequard (hemisection)

## Question 28 of 70

- **E.** Anterior cord syndrome
53. Regarding the blood supply of abdomen, superior
mesenteric artery supply which one of the following
structures?
1. coeliac trunk supply the
Abdominal oesophagus
stomach
pancreas
liver
spleen
gallbladder
duodenum proximal to major duodenal papilla
2. Superior mesenteric artery supply the:
Distal duodenum

## Question 53 of 90

- **A.** Kidneys
- **B.** Ascending colon
- **C.** Oesophagus
- **D.** Sigmoid colon
- **E.** Descending colon

## Question 29 of 70

Jejunum
Ileum
cecum
Appendix
Ascending colon (RECALL)
Proximal two third of transverse colon
3.Inferior mesenteric artery supply the:
Distal transverse colon
Descending colon (RECALL)
Sigmoid colon
Proximal rectum
54. What is the quantitative relationship between gas
solubility and pressure?
Henry''s law: At a constant temperature, the amount
of a given gas that dissolves in a given type and
volume of liquid is directly proportional to the
partial pressure of that gas in equilibrium with that
liquid." An equivalent way of stating the law is that
the solubility of a gas in a liquid is directly
proportional to the partial pressure of the gas above
the liquid.

## Question 54 of 90

- **A.** Ficks law
- **B.** Boyle’s law
- **C.** Henry''s law
- **D.** Charles law
- **E.** Entropy

## Question 30 of 70

55. A 20-year-old woman underwent arthroscopy on her
right ankle because of chronic ankle pain after a sprain.
After arthroscopy, the patient complained of pain on the
dorsum of her right foot and felt a radiating pain from the
anterolateral portal to the dorsomedial aspect of her foot,
this was most probably due to injury to which of the
following nerve?
Motor innervation of superficial fibular nerve
The superficial fibular nerve supplies the fibularis
longus and the fibularis brevis. These muscles form
the lateral compartment of the lower leg.
They act to evert the foot (Recall) and thus act at
the subtalar joint (eversion is the action of turning
the foot outwards).
Sensory Functions
Superficial peroneal nerve carries sensations from
the anterolateral aspect of the leg and the greater
part of the dorsum of the foot (except for the first
web space).

## Question 55 of 90

- **A.** Superficial fibular nerve
- **B.** Sural nerve
- **C.** Saphenous nerve
- **D.** Deep fibular nerve
- **E.** Tibial nerve
57. The orbicularis Oris muscle perform which of the
following function?

## Question 57 of 90

## Question 31 of 70

The orbicularis Oris muscle act to close purse the
lips. This muscle also helps in puckering the lips due
to which it is sometimes known as the “kissing
muscle.” The musicians also use this muscle.
- **A.** Blowing of the cheeks
- **B.** Closing of eyes
- **C.** Closing of the mouth
- **D.** Pursing the lips
- **E.** Opening of the mouth
58. Which of the following type of blood vessels contributes
the most of systemic vascular resistance?
Resistance is a force that opposes the flow of a fluid.
In blood vessels, most of the resistance is due to
vessel diameter. As vessel diameter decreases, the
resistance increases and blood flow decreases.
smaller arteries and arterioles contain more muscle
and are resistance vessels.

## Question 58 of 90

- **A.** Arteriole
- **B.** Arteries
- **C.** Venules
- **D.** Capillaries
- **E.** Veins

## Question 32 of 70

Veins have large diameter than equivalent arteries
and provide less resistance
59. A 5o years old male presents to the ED with complaint
of shortness of breath. He is known case of restrictive lung
disease. In restrictive lung disease which of the following
results would you expect to find on spirometry?
In restrictive pattern both FEV1 and FVC reduced
but FEV1/FVC ratio increased due to greater elastic
recoil

## Question 59 of 90

- **A.** Low FEV1/FVC ratio
- **B.** Increased FEV1
- **C.** Increased FEV1 /FVC ratio
- **D.** Normal FVC
- **E.** High FVC

## Question 33 of 70

60. Which one of the following organelles has essential role
in achieving uterine involution?
Cell organelle involved in uterine involution is
lysosome
While Hormone uterine involution is oxytocin

## Question 60 of 90

- **A.** Lysosome
- **B.** Mitochondria
- **C.** Rough endoplasmic reticulum
- **D.** Golgi body
- **E.** Smooth endoplasmic reticulum

## Question 34 of 70

Note: Mitochondria are responsible for the
production of chemical energy in the form of ATP.
(Recall)
61. What is the vertebral level of bifurcation of the trachea
in a living person?
The trachea extends from inferior end of larynx at C6
vertebra and ends at the level of sternal angle (T4-T5
Intervertebral disc) where it divides into left and
right main bronchi.

## Question 61 of 90

- **A.** T2/T3
- **B.** T5/T6
- **C.** T4/T5
- **D.** T6/T7
- **E.** T3/T4
62. A 10 years old child admitted in hospital and being
treated for DKA. In DKA treating complication cerebral
edema, hypertonic saline is used. How hypertonic saline
will decrease cerebral edema?

## Question 62 of 90

- **A.** There is no net movement of water
- **B.** Na and k move out of cells
- **C.** K move out of the cell

## Question 35 of 70

when hypertonic saline is administrated ECF
becomes more concentrated compared with ICF.
Osmotic potential draw movement of water
molecules from inside to out of the cells.
Note: After heavy exercise when person drink water
it increases intracellular fluid ICF volume (Recall)
because water is hypotonic to body fluids dilute
extracellular fluid relative to intracellular fluid,
osmotic potential draws water into cells.
- **D.** Water moves out of the cells
- **E.** Water moves into the cell
63. A 60-year-old woman with a known malignancy on the
anterior two thirds of the tongue presents with neck
swelling.
What is the most likely group of lymph nodes to be involved
first?
Lymphatic Drainage of Oral Cavity
1: The parotid nodes: sit upon the parotid gland
and drain it

## Question 63 of 90

- **A.** Submandibular
- **B.** Cervical
- **C.** Preauricular
- **D.** Submental
- **E.** Superior clavicular

## Question 36 of 70

2: The submandibular nodes: lie on the lateral wall
of the submandibular gland and drain the cheek,
the upper lip, the lower lip, the maxillary sinus, the
upper and lower teeth, the anterior two thirds of
the tongue, the floor of the mouth, the vestibule
and the gums
Submandibular nodes drain into deep cervical
nodes
Anterolateral tongue also drain into deep cervical
nodes (Recall)
3: The submental nodes: are found in the
submental triangle below the chin and drain the
tip of the tongue (Recall) and medial part of lower
lip
Cervical Nodes
1. The superficial cervical nodes: lie on the external
jugular vein and drain the skin over the angle of the
jaw and the skin covering the lower portion of the
parotid gland.
2. The deep cervical nodes are as follows:
3. The jugulodigastric node sits posteroinferiorly to
the jaw and drains the tonsils and the tongue
(Recall)
4. The jugulo omohyoid node: is found close to the
omohyoid muscle and drains the tongue (post 1/3).
64. A 4-year-old African child with sickle cell disease was
brought into the ED with a complaint of bone pain
associated with a limp. Imaging revealed lucent bone
lesion, you suspect osteomyelitis, what is the most likely
causative pathogen?

## Question 64 of 90

- **A.** Pseudomonas
- **B.** Salmonella

## Question 37 of 70

Salmonella enterica is a gram-negative rod that
causes enterocolitis (Food poisoning), Enteric fever
(Typhoid), Septicemia, and osteomyelitis
Primarily transmitted through fecal-oral route
usually from ingestion of contaminated poultry,
eggs, and uncooked meat
High yield:
Regarding osteomyelitis
Most common cause generally: Staph Aureus
(Recall)
The most common cause in IV drug abuser: Staph
Aureus
The most common cause in sickle cell disease:
Salmonella
Most common cause after hip replacement surgery:
Staph epidermidis
- **C.** Staph aureus
- **D.** E-Coli
- **E.** Staph epidermidis
66. A patient presents in ER with severe Constipation, his
blood Reports show hypocalcemia. Hypocalcemia causes
an increase in which of the following hormone?

## Question 66 of 90

- **A.** Parathyroid
- **B.** Thyroxine
- **C.** T3, T4

## Question 38 of 70

Parathyroid hormone (PTH) levels are mainly
controlled by a feedback loop of calcium levels in
your blood to your parathyroid glands. In other
words, low calcium levels in your blood stimulate
parathyroid hormone release, whereas high calcium
levels in your blood prevent your glands from
releasing parathyroid hormone
Increase in blood po4 concentration also stimulate
the PTH hormone release
Circulating parathyroid hormone targets the distal
convoluted tubule and collecting duct, directly
increasing calcium reabsorption (RECALL).
- **D.** ADH
- **E.** Somatostatin
67. A 30-year-old male patient brought into ED
unresponsive after initial assessment you suspect opioid
toxicity you started naloxone. Naloxone works on which
one of the following receptors?
Naloxone is opioid mu receptor antagonist rapidly
reverse the symptoms of opioid toxicity.

## Question 67 of 90

- **A.** NMDA receptor Antagonist
- **B.** Gaba receptor
- **C.** NMDA receptor agonist
- **D.** Opioid mu receptors antagonist
- **E.** Opioid mu receptors agonist

## Question 39 of 70

68. A 45 years old male presents to the ED with complaint
of dizziness and increased pigmentation all over the body.
Initial assessment at triage he was hypotensive. Lab value
reveals hyponatremia and hyperkalemia. Which one of the
following hormone deficiency caused this condition?
Insufficiency of adrenal cortex is called Addison''s
disease
Deficiency of aldosterone as seen is adrenal
Insufficiency result in hyponatremia ,hyperkalemia
and metabolic acidosis (Recall)
Cushing''s Syndrome: Set of symptoms that occur
when there is excess of cortisol
Most common cause is exogenous Glucosteroids
Cushing''s disease: when Cushing syndrome is
caused by ACTH producing pituitary tumor (Most
common endogenous cause (Recall)
ACTH secreting pituitary adenoma
Excess cortisol due to adrenal adenoma (Recall)

## Question 68 of 90

- **A.** PTH
- **B.** Aldosterone
- **C.** ADH
- **D.** Androgens
- **E.** Cortisol

## Question 40 of 70

69. A 50-year-old male presents to the Emergency
department with the complaint of swelling in ankle. She has
recently been started on loop diuretics by her GP. loops
diuretic act to inhibit the?
loop diuretic e.g.: furosemide inhibit the Na+k+2CL-
symporter on luminal membrane in the thick
ascending limb of loop of Henle thus preventing the
reabsorption of Nacl and water
while thiazides act mainly on early segment of
distal tubule where they inhibit the Nacl
reabsorption by binding to the Na+cl- cotransporter
(RECALL).

## Question 69 of 90

- **A.** Na-K-2CL- channel
- **B.** carbonic anhydrase
- **C.** Na-K-channel
- **D.** H-K- channel
- **E.** Na-K-ATPase
70. Detoxification of lipid drugs and other harmful
compounds in ER is carried out by?

## Question 70 of 90

- **A.** Cytochrome P450
- **B.** Cytochrome 360
- **C.** Cytochrome D
- **D.** Cytochrome bf

## Question 41 of 70

Cytochrome P450 enzymes function to metabolize
potentially toxic compounds. There are 57 human
genes coding for various cytochrome450.
- **E.** Cytochrome F
71. Whilst performing neurological examination, you ask
medical students what is the sensory level of Umbilicus?
T1= medial antecubital fossa (Recall)
T2= Apex of axilla
T3= third intercostal space
T4= level of nipples (RECALL)
T5= 5th intercostal space
T6= level of xiphisternum (RECALL)
T10= level of Umbilicus
T11= midway between Umbilicus and inguinal
ligament
T12= midpoint of inguinal ligament

## Question 71 of 90

- **A.** T11
- **B.** T10
- **C.** T8
- **D.** T9
- **E.** T7

## Question 42 of 70

72. A 40-year-old man injured his right wrist during a fall, X-
rays demonstrate a lunate dislocation. He is complaining of
severe wrist pain and numbness in his hand
Damage to what structure is most likely to be causing these
symptoms?
Lunate dislocation occurs by falling on a dorsiflexed
wrist. The lunate is forced anteriorly, and
compresses the median nerve in carpal tunnel
causing the symptoms of carpal tunnel syndrome.

## Question 72 of 90

- **A.** Distal radius
- **B.** Ulnar nerve
- **C.** Radial artery
- **D.** Median nerve
- **E.** Scapholunate ligament
73. You have been asked to make a Quick assessment of
patient''s upper limb neurology as a part of secondary
survey. You test each dermatome and note the patient has
no sensation at the medial antecubital fossa. The medial
antecubital fossa tests which of the following dermatomes?

## Question 73 of 90

- **A.** T1
- **B.** C8
- **C.** C5
- **D.** C7

## Question 43 of 70

DERMATOMES
C2= occipital protuberance (RECALL)
C3= supraclavicular fossa
C4= Acromioclavicular joint (RECALL)
C5 = lateral antecubital fossa
C6= thumb (RECALL)
C7=middle finger
C8=little finger
T1= medial antecubital fossa
T2= Apex of axilla
- **E.** C6
74. A 44-year-old male suffered from fracture of neck of the
fibula now he is unable to do dorsiflexion of ankle, which
one of the following nerves is most likely injured?
The common peroneal nerve is also known as
common fibular nerve is a branch of sciatic nerve,
arise at apex of popliteal fossa, continue by

## Question 74 of 90

- **A.** Tibial nerve
- **B.** Obturator nerve
- **C.** Femoral nerve
- **D.** Common peroneal nerve
- **E.** Sciatic nerve

## Question 44 of 70

wrapping around the neck of fibula where it is
most likely to be damaged (RECALL)
Function: The common peroneal nerve Innervate
the short head of the biceps femoris muscle.
common fibular nerve innervates all the muscles of
anterior and later compartments of the lower leg.
The anterior muscular compartment of the lower
extremity consists of the tibialis anterior muscle,
the extensor hallucis longus muscle, and the
extensor digitorum longus muscle. This
compartment is responsible primarily for the
dorsiflexion of the foot (RECALL).
76. A 25-year-old man presents with diabetic ketoacidosis.
You start to treat him with short-acting insulin and
intravenous fluids as per your local protocol.
Which electrolyte disturbance is the most at risk of
developing as a result of your treatment?
Insulin excess lowers the serum potassium
concentration by driving the K+ into the cells
primarily by enhancing the activity of NA-K-ATPase
pump.
ECG changes in hypokalemia and hyperkalemia

## Question 76 of 90

- **A.** Hypophosphatasemia
- **B.** Hypokalemia
- **C.** Hypermagnesemia
- **D.** Hyponatremia
- **E.** Hyperchloremia

## Question 45 of 70

77. A patient with a history of sinusitis presents unwell with
fever, periorbital edema, visual disturbance, ptosis and
altered sensation to the face. You suspect cavernous sinus
thrombosis.
Which cranial nerve is most commonly affected?
Cavernous sinus thrombosis (CST) refers to the
formation of a clot within the cavernous sinus. It is
important to note that the superior ophthalmic vein
forms an anastomosis with the facial vein.
Therefore, the ophthalmic veins represent a
potential route by which infection can spread from
an extracranial to an intracranial site.

## Question 77 of 90

- **A.** Abducent
- **B.** Trochlear
- **C.** Trigeminal
- **D.** Oculomotor
- **E.** Facial

## Question 46 of 70

Note: The abducens nerve (CN VI) is most
commonly affected in cavernous sinus thrombosis
Structures passing through cavernous sinus
useful mnemonic: O TOM CAT
OTOM (oculomotor nerve, trochlear nerve,
ophthalmic branch, maxillary branch) refers to the
lateral wall contents from superior to inferior
CAT (internal carotid artery, abducens nerve,
trochlear nerve) refers to the horizontal contents,
from medial to lateral.
78. A 51-year-old-male patient with myasthenia gravis
presents with difficulty swallowing and a cough that has
been present for several weeks. A CT scan is performed,
which shows the presence of a tumor of the thymus.
Which SINGLE statement regarding the thymus is true?
The thymus:
Is a specialized primary lymphoid organ of the
immune system, within which T-lymphocytes
mature.

## Question 78 of 90

- **A.** The cortex contains fewer lymphocytes than the
medulla
- **B.** It is mainly located within the anterior
mediastinum
- **C.** The medulla contains Hassall’s corpuscles
- **D.** The cortex is located centrally
- **E.** It increases in size after puberty

## Question 47 of 70

After puberty, it decreases in size and is slowly
replaced by fat.
It is mainly located within the superior
mediastinum, posterior to the manubrium sterni.
A certain degree of anatomical variation exists, and
in some individuals, it can extend superiorly into the
neck or inferiorly into the anterior mediastinum.
The thymus has an asymmetrical, flat shape with a
lobular structure.
The lobules are comprised of a series of follicles,
which consist of a medullary and a cortical portion.
The cortex: Is located peripherally within each
follicle and is mainly composed of lymphocytes,
supported by a network of finely branched epithelial
reticular cells.
The medulla: Is located centrally within each follicle
79. Which one of the following hormones helps in the
secretion of HCL from the stomach?
Gastrin is a hormone that is produced by G-cells in
the lining of the stomach and upper small intestine.
Gastrin stimulates the stomach to release gastric
acid.

## Question 79 of 90

- **A.** Renin
- **B.** Pepsin
- **C.** Gastrin
- **D.** Secretin
- **E.** Cholecystokinin

## Question 48 of 70

80. At journal club you present a paper on the use of a
biomarker to predict the presence of clinically important
infection.
When assessing applicability to facilitate safe discharge
what is the most useful statistical attribute?
The negative predictive value (NPV) describes the
probability of not having the disease. If the test
result is negative, the chances of the patient to have
the disease is low and can be safely discharge.

## Question 80 of 90

- **A.** Negative predictive value
- **B.** Sensitivity
- **C.** Positive predictive value
- **D.** Positive likelihood ratio
- **E.** Specificity
82. Which of the following inhibits acetylcholine-mediated
bronchospasm?

## Question 82 of 90

- **A.** Naproxen
- **B.** Theophylline
- **C.** Ipratropium
- **D.** Salmeterol
- **E.** Ephedrine

## Question 49 of 70

Acetylcholine plays an important role in the
pathophysiology of asthma via binding to airway
muscarinic receptors to trigger bronchoconstriction,
mucus secretion and inflammation.
Ipratropium acts as an antagonist of the muscarinic
acetylcholine receptor inhibit parasympathetic
induced bronchoconstriction.
83. 45 years old male presented to the ED post thyroid
surgery with complain of periorbital numbness, paresthesia
of hand and feet and abnormal movement what is the
cause of his condition?
PTH is primarily released in response to decreased
calcium. PTH causes demineralization of bones
and causes increased plasma calcium level
(Recall) and decreased phosphate levels
Post-thyroid surgery most likely complication is
parathyroid insufficiency leads to hypocalcemia
Note: Parathyroid Harmone increases calcium
reabsorption in the distal convoluted tubule of
nephron (Recall)  and increases excretion of
phosphate by inhibiting reabsorption in the
proximal convoluted tubule of nephron

## Question 83 of 90

- **A.** Thyroid Crisis
- **B.** Hypomagnesemia
- **C.** Hypocalcemia
- **D.** Hypothyroidism
- **E.** Hypokalemia

## Question 50 of 70

84. Which of the following anesthetic agent cause vitamin
B12 deficiency?
Exposure to nitrous oxide for prolonged periods, can
cause vitamin B12 deficiency. Due to interference
with the action of vitamin B12, resulting in
megaloblastic anemia, neurologic manifestations
such as myeloneuropathy and subacute combined
degeneration of the spinal cord.

## Question 84 of 90

- **A.** Thiopental sodium
- **B.** Etomidate
- **C.** Ketamine
- **D.** Nitrous oxide
- **E.** Propofol
85. Elderly male presented with c/o high-grade fever with
chills rigors and dysphagia. Also had h/o tooth sensitivity,
for which consulted dentist and found to have decayed
tooth. On examination you bilateral swelling in the floor of
mouth. Infection of which space is most common for above
presentation?

## Question 85 of 90

- **A.** Parapharyngeal space
- **B.** Retropharyngeal space
- **C.** Submandibular space
- **D.** Sub mental space

## Question 51 of 70

Ludwigs''s angina is life threatening cellulitis of the
soft tissue of the floor of the mouth and neck.
Originates from dental infection in the molars
specially 2nd and 3rd molars
involves three compartments of the floor of the
mouth, sublingual, submental, and submandibular
(Most commonly).
- **E.** Sub lingual space
86. A Patient presents to the ED complaining of jaw pain
which radiates towards his ear while eating, which of the
following nerve is responsible for this sensation of pain?
The Auriculotemporal nerve branch of mandibular
innervates the skin behind the temporomandibular
joint and within the superior surface of the parotid
gland. It has a course along a temporalis
superficialis and innervates the tragus (RECALL)
and part of the adjoining auricle of the ear and the
posterior part of the temple.

## Question 86 of 90

- **A.** Auriculotemporal nerve
- **B.** Zygomaticofacial Nerve
- **C.** Infra trochlear nerve
- **D.** Supra-Trochlear nerve
- **E.** Zygomaticotemporal nerve
87. A 30-year-old male unable to laterally rotate his arm
following fracture of surgical neck of humerus, which of the
following muscle most likely to be involved?

## Question 87 of 90

## Question 52 of 70

The axillary nerve is most commonly damaged due
to fracture of surgical neck of humerus, which
supply the teres minor muscle which helps is lateral
rotation of arm and also supply the deltoid muscle
which cause abduction of arm...
Axillary nerve root value =C5 and C6 (RECALL).
- **A.** Teres major
- **B.** Supraspinatus
- **C.** Latissimus dorsi
- **D.** Teres minor
- **E.** Rhomboid major
88. A 55-year-old male presented to ER with Achilles
tendon rupture. He has recently started a course of
antibiotics from his general physician. Which of the
following antibiotics was he most likely prescribed?
Side effects of Quinolone (Ciprofloxacin)
ruptured tendon
QT prolongation (recall)

## Question 88 of 90

- **A.** Penicillin
- **B.** Metronidazole
- **C.** Tetracycline
- **D.** Ciprofloxacin
- **E.** Doxycycline

## Question 53 of 70

Photosensitivity
convulsions
There is increased risk of convulsion when
Quinolones are taken with NSAIDS or theophylline.
There is an increased risk of tendon damage when
Quinolones are taken with corticosteroids.
(RECALL)
Ciprofloxacin increases plasma concentration of
theophylline(aminophylline). (RECALL)
89. Regarding the blood supply of the colon, descending
colon receives its blood supply from which one of the
following arteries?
As a general rule, midgut-derived structures are
supplied by the superior mesenteric artery, and
hindgut-derived structures by the inferior
mesenteric artery.
The ascending colon: receives arterial supply from
two branches of the superior mesenteric artery; the
ileocolic and right colic arteries.
The transverse colon: is derived from both the
midgut and hindgut, and so it is supplied by
branches of the superior mesenteric artery and
inferior mesenteric artery:

## Question 89 of 90

- **A.** Gastro-pancreatic artery
- **B.** Coeliac axis
- **C.** Inferior mesenteric artery
- **D.** Gastric artery
- **E.** Superior mesenteric artery

## Question 54 of 70

Right colic artery (from the superior mesenteric
artery
Middle colic artery (from the superior mesenteric
artery)
Left colic artery (from the inferior mesenteric artery)
The descending colon: is supplied by a single
branch of the inferior mesenteric artery; the left
colic artery. The sigmoid colon receives arterial
supply via the sigmoid arteries (branches of the
inferior mesenteric artery).
90. All of the following drugs causes high anion gap
metabolic acidosis except?
Anion gap can be calculated as (Na + K ) -- (Cl +
Hco3) Recall. Normal anion gap is 10-16 mmol/L

## Question 90 of 90

- **A.** Propylene glycol
- **B.** Methylene glycol
- **C.** Isoniazid
- **D.** D lactates
- **E.** Aspirin

## Question 55 of 70

Note: salicylate (Aspirin) overdose initially causes
respiratory alkalosis (Recall) followed by
metabolic acidosis
4. A 17-year-old girl presents with a maculopapular rash.
She has a seven-day history of fever and sore throat and
was prescribed an antibiotic 3 days ago.
Which antibiotic is most likely to have been prescribed?

## Question 4 of 90

- **A.** Ciprofloxacin

## Question 56 of 70

It is given primarily in streptococcal tonsillitis
Phenoxymethylpenicillin also known as penicillin v
is Used to treat bacterial infections, including ear,
chest, throat and skin infection.
It is also used for prophylaxis against streptococcal
infection following rheumatic fever and against
pneumococcal infection following splenectomy or
sickle cell disease.
- **B.** Clarithromycin
- **C.** Cephalexin
- **D.** Amoxicillin
- **E.** Phenoxymethylpenicillin
5. Which of the following is the earliest electrocardiogram
(EKG) finding in acute myocardial infarction (MI)?

## Question 5 of 90

- **A.** Q waves
- **B.** ST elevation
- **C.** ST depression
- **D.** T-wave inversion
- **E.** Hyperacute T waves

## Question 57 of 70

6. A 34-year-old male presents to ER with an upper limb
injury. He complains of the weakness of flexion of the
thumb, index, and middle finger of his right hand. Which of
the following nerves is most likely affected?
The anterior interosseous nerve is the terminal
motor branch of the median nerve. It branches from
the median nerve in the proximal forearm between
the two heads of the pronator teres muscle to run
deep along the interosseous membrane. From
proximal to distal, it innervates the flexor pollicis

## Question 6 of 90

- **A.** Palmer Digital branch
- **B.** Posterior interosseous nerve
- **C.** Posterior interosseous nerve
- **D.** Deep branch of ulnar nerve
- **E.** Anterior interosseous nerve

## Question 58 of 70

longus, lateral half of the flexor digitorum profundus
, and the pronator quadratus
Anterior interosseous nerve syndrome is an isolated
palsy of these three muscles. It manifests mostly as
pain in the forearm accompanied frequently by a
characteristic weakness of the flexion index and
thumb finger.
In supracondylar fracture, the Most common nerve
injured is the median nerve (RECALL)
10. A 50-year-old male presents to ED with the complaint of
headache and chest pain, he is currently taking captopril
and Hydrochlorothiazide for hypertension. Thiazide diuretic
act at which of the following sites in nephron?
Thiazides act mainly on early segment of distal
tubule where they inhibit the nacl reabsorption by
binding to the Na-cl- cotransporter.
while loop diuretic inhibits the Na-k-2CL- symporter
on luminal membrane in the thick ascending limb
of loop of Henle thus preventing the reabsorption of
NaCl and water (RECALL)

## Question 10 of 90

- **A.** Late part of distal convoluted tubule
- **B.** Thin ascending limb of loop of Henle
- **C.** Collecting duct
- **D.** Thick ascending limb of loop of Henle
- **E.** Early part of distal convoluted tubule
13. An elderly male patient presents to the ED with acute
confusion. Lab value reveals Hyponatremia and

## Question 13 of 90

## Question 59 of 70

hyperkalemia, which one of the following hormones is most
likely deficient?
Aldosterone deficit results in hyponatremia and
hypovolemia, accompanied by hyperkalemia and
metabolic acidosis
Aldosterone acts mainly at renal distal convoluted
tubule to cause sodium retention and potassium
loss (RECALL)
Conn’s syndrome (hyperaldosteronism) cause
hypernatremia and hypokalemia (RECALL).
- **A.** Cortisol
- **B.** Thyroxine
- **C.** Growth hormone
- **D.** ADH
- **E.** Aldosterone
20. A 40-year-old male presents to the ED with headache.
His BP was found to be 180/90. He is currently under
investigation for suspected Cushing’s syndrome. What is
the most common cause of Cushing disease?

## Question 20 of 90

- **A.** Squamous cell lung cancer
- **B.** Adrenal adenoma
- **C.** Adrenal carcinoma
- **D.** Small cell lung cancer
- **E.** Pituitary adenoma

## Question 60 of 70

Cushing’s disease refers to the specific condition of
excessive corticosteroids as a result of ACTH
secreting pituitary adenoma.
Cushing’s syndrome is the name given to clinical
symptoms and signs induced by chronic
glucocorticoid excess.
Clinical findings:
Buffalo hump
Purple striae
Central Obesity
Thinning skin that bruises easily
Acne
Fatigue
Muscle weakness
High blood sugar
Increased thirst
Increased urination
High blood pressure (hypertension)
Anxiety
22. A 40 years old male presents to the ED with
exacerbation of asthma. Which one of the following beta
blockers is safe for asthma?

## Question 22 of 90

- **A.** Propanol
- **B.** Carvedilol
- **C.** Nadolol
- **D.** Labetalol
- **E.** Bisoprolol

## Question 61 of 70

Cardio selective beta blockers like nebivolol,
bisoprolol and metoprolol are safe in both asthma
and diabetes
23. A 38-year-old male brought into the ER having trauma
to the face, his frontalis muscle is spared but the orbicularis
oculi muscle is affected. Which of the following branch of
facial nerve most likely involved?
Within the parotid gland, the facial nerve
terminates by bifurcating into five motor branches.
These innervate the muscles of facial expression:
Temporal: Innervates the frontalis, orbicularis oculi
(upper half) and corrugator supercilii.
Zygomatic: Innervates the orbicularis oculi. (Lower
half)
In this case frontalis muscle is spared which is
innervated by temporal branch, so here most likely
affected nerve is zygomatic branch (lower half of
orbicularis oculi)
Buccal: Innervates the orbicularis Oris, buccinators
and zygomaticus.
Marginal mandibular: Innervates the depressor labii
inferioris, depressor anguli orris and mentalis.
Cervical : Innervates the platysma (RECALLL).

## Question 23 of 90

- **A.** Buccal Branch
- **B.** Temporal branch
- **C.** Cervical Branch
- **D.** Mental Branch
- **E.** Zygomatic branch

## Question 62 of 70

25. A 50-year-old man complains of intermittent abdominal
pain on lifting and coughing. You suspect a Spigelian
hernia. Weakness of which structure is most likely to be
responsible?
Spigelian hernia also known as hernia of Linea
semilunaris is a protrusion through a defect in the
aponeurosis of the transversus abdominis muscle.
Clinically, they present as a small tender mass at the
lower lateral edge of the rectus abdominus*. They
have a high risk of strangulation, and so should be
repaired urgently.

## Question 25 of 90

- **A.** Transversalis fascia
- **B.** Internal inguinal ring
- **C.** Femoral sheath
- **D.** Iliopsoas fascia
- **E.** Transversus abdominus aponeurosis
26. A 30-year-old man presents to the ED with an anterior
shoulder dislocation while playing, now he is unable to
initiate abduction of the arm following reduction of a
dislocated shoulder. Which one of the following muscles is
most likely injured?

## Question 26 of 90

- **A.** Teres major
- **B.** Teres minor
- **C.** Infraspinatus

## Question 63 of 70

Supraspinatus is part of the rotator cuff group of
muscles which initiate the abduction of shoulder
from 0 to 15 degrees and then assists the deltoid
with continued abduction. Supraspinatus muscle
supplied by suprascapular nerve, "empty can test"
use to examine this muscle.
Teres minor muscle assessment test=Hornblower’s
test) RECALL)
Subscapularis muscle assessment test (lift-off Test)
RECALL
Most commonly torn tendon of rotator cuff is
supraspinatus muscle (RECALL)
Teres minor and deltoid muscle innervated by
Axillary nerve (RECALL)
Supraspinatus Is innervated by suprascapular nerve
Subscapular is innervated by subscapular nerve
- **D.** Subscapularis
- **E.** Supraspinatus
28. A 50-year-old woman presents to the ED with
palpitations. Her ECG reveals QT prolongation. She has
been taking an antibiotic for a skin infection.
Which antibiotic is the most likely to have caused her ECG
abnormalities?

## Question 28 of 90

- **A.** Flucloxacillin
- **B.** Clindamycin
- **C.** Doxycycline
- **D.** Tetracycline

## Question 64 of 70

DRUGS CAUSING QT PROLONGATION
Remember with ABCDEF
ANTI-ARRYTHMICS: amiodarone, procainamide,
quinidine, sotalol
ANTIBIOTICS: macrolides, fluoroquinolones
ANTIPSYCHOTICS: chlorpromazine, haloperidol
D ANTIDEPRESSANTS: SSRIS (citalopram,
escitalopram); TCAS (amitriptyline)
ANTI-EMETICS: domperidone, ondansetron
ANTIFUNGALS: azoles (fluconazole), pentamidine
- **E.** Clarithromycin
39. You are teaching group of medical students'' venous
drainage of lower limb, Regarding the course of great
saphenous vein, which one of the following is correct?

## Question 39 of 90

- **A.** Begins as the upward continuation of the lateral
marginal vein of the foot
- **B.** Travels with saphenous nerve along its course
- **C.** Join the femoral vein above the inguinal
ligament
- **D.** Runs behind the medial malleolus
- **E.** Enters the femoral vein on its anteromedial side

## Question 65 of 70

The great saphenous vein: originate from medial
side of the dorsal venous arch in the foot, passes
anterior to the medial malleolus (not posterior),
travels up the medial side of leg, knee and thigh to
pass in to saphenous opening in deep fascia
covering the femoral triangle and join with the
femoral vein below the inguinal ligament.
The small saphenous vein: originate from lateral
side of dorsal venous arch in the foot, passes
posterior to lateral malleolus and up the back of leg
to pierce the deep fascia and join the popliteal vein
in popliteal fossa posterior to knee...
Note: Cutaneous innervation to medial side of foot
by=saphenous nerve (Recall).
43. 45 years old male presented to the ED post thyroid
surgery with complain of periorbital numbness, paresthesia
of hand and feet and abnormal movement what is the
cause of his condition?
PTH is primarily released in response to decreased
calcium. PTH causes demineralization of bones
and causes increased plasma calcium level
(Recall) and decreased phosphate levels
Post-thyroid surgery most likely complication is
parathyroid insufficiency leads to hypocalcemia

## Question 43 of 90

- **A.** Hypomagnesemia
- **B.** Hypokalemia
- **C.** Thyroid Crisis
- **D.** Hypothyroidism
- **E.** Hypocalcemia

## Question 66 of 70

Note: Parathyroid Harmone increases calcium
reabsorption in the distal convoluted tubule of
nephron (Recall)  and increases excretion of
phosphate by inhibiting reabsorption in the
proximal convoluted tubule of nephron
48. A 54-year-old woman presents with acute back pain
and complains of numbness around her rectum. Which
dermatome best describes this area of numbness?

## Question 48 of 90

- **A.** S1
- **B.** S3
- **C.** L5
- **D.** S2
- **E.** S5
56. A 30-year-old farmer has sustained a deep laceration to
the popliteal fossa and damaged the more medial nerve.
Which of the following clinical features you would most
likely to see on examination?

## Question 56 of 90

- **A.** Loss of flexion of the leg at the knee joint
- **B.** Foot drop

## Question 67 of 70

Tibial and common fibular nerve are the most
superficial contents of the popliteal fossa. Both are
the branches of sciatic nerve
The common fibular nerve follows the biceps
femoris tendon, travelling along the lateral margin
of the popliteal
Tibial nerve lies more medial
Boundaries and contents of popliteal fossa
- **C.** Weakness of dorsiflexion and eversion
- **D.** Loss of extension of the leg at the knee joint
- **E.** Weakness of plantarflexion and inversion
65. A 32 years old male was brought into the ED by
paramedics with a complaint of head injury. After initial
assessment and imaging results empty Sella turcica.
Empty Sella turcica occurs due to fracture of which bone?

## Question 65 of 90

- **A.** Frontal
- **B.** Parietal

## Question 68 of 70

The Sella turcica is a saddle-shape depression in the
sphenoid bone of the human skull contains the
pituitary gland and distal portion of the pituitary
stalk
- **C.** Occipital
- **D.** Temporal
- **E.** Sphenoid
75. A 58-year-old male presents to ED with shortness of
breath caused by acute decompensated heart failure with
pulmonary congestion. which of the following pulmonary
receptor is likely to be involved in causing her dyspnea?
J-receptors respond to events such as pulmonary
edema, pulmonary emboli pneumonia, and
barotrauma, which cause a decrease in
oxygenation and thus lead to an increase in
ventilation/respiration.
J receptors are activated in pulmonary edema in a
patient with congestive heart failure and causes
reflex increase in breathing rate (Recall) also
thought to be involve in sensation of dyspnea

## Question 75 of 90

- **A.** Stretch receptors
- **B.** Muscle receptors
- **C.** Chemoreceptors
- **D.** Irritant receptors
- **E.** Juxtrapulmonary (J) receptors

## Question 69 of 70

0% Complete
Mark as Complete
Previous Next
Note: Irritant receptors sense chemicals dust and
cold air and activation causes coughing (Recall)
and bronchoconstriction.
81. A 40-year-old male is brought to the ER having
sustained a stab wound to the posterolateral back. Which
of the following muscle most likely affected?
Latissimus dorsi muscle is a broad, flat muscle that
occupies the majority of the lower posterior thorax.
The muscle''s primary function is of the upper
extremity but is also considered to be a respiratory
accessory muscle
latissimus dorsi muscle is innervated by
thoracodorsal nerve (RECALL)
latissimus dorsi produces adduction, medial
rotation and extension of humerus at
glenohumeral joint (RECALL).

## Question 81 of 90

- **A.** Anterior scalene muscle
- **B.** Rhomboid major
- **C.** Trapezius
- **D.** Serratus anterior
- **E.** Latissimus dorsi

## Question 70 of 70',
    false,
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
    "updated_at" = now();

  -- Lesson: Mock - I Paper - I
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'mock-i-paper-i',
    'Mock - I Paper - I',
    'article',
    '# Mock - I Paper - I

> [!NOTE]
> **Instructions:** Single best answer scenario. Read carefully before reviewing the detailed rationale.

Mrcem Primary Complete Course ,High Yield Stuff and Questions Bank ( For Diet ii Late 2026)
Overview  Comments
Share your score colleagues

LinkedIn  Facebook  Twitter

## Question 19 of 90

2. A 54-year-old man presents with visual impairment.
When testing the pupillary light reaction, the right pupil
dilates when the light source moves from the right pupil to
the left.
Which nerve is likely to be abnormal?
In this question examiner is more focused on left
eye that means when light source is tested in left
eye, left eye do not constrict that means loss of
ipsilateral direct pupillary reflex and right pupil
dilation refers to loss of contralateral consensual
pupillary light reflex.
In Complete transection of optic nerve:
loss of ipsilateral direct pupillary reflex
loss of contralateral consensual pupillary light reflex
Optic nerve: (High yield)
Transmit special sensory information from the
retina of the eye to the primary visual cortex of the
brain.
Enters skull via optic canal of the sphenoid bone

## Question 2 of 90

- **A.** Left optic nerve
- **B.** Right oculomotor nerve
- **C.** Ophthalmic division of the left trigeminal nerve
- **D.** Right optic nerve
- **E.** Left oculomotor nerve

## Question 1 of 54

Note: Relative afferent pupillary defect (RAPD):
Seen in optic nerve disease or asymmetrical disease
of the retina in which pupils respond differently to
light stimuli shone in one eye at a time
swinging light test if there is no RAPD the pupils of
both eyes constrict equally regardless of which eye
is stimulated by the light.
In an abnormal swinging-light test if there is a
RAPD there is less pupil constriction in the eye with
the retinal or optic nerve disease

> [!TIP]
> **Clinical pearls:**
> Pituitary adenoma: Pituitary gland lies in close
> proximity to optic chiasm,tumor of pituitary gland
> compresses optic nerve at chiasm produces visual
> defect called bitemporal hemianopia
> 5. Transverse thoracic plane lies at the level of which of the
> following anatomically relations?
> Transverse thoracic plane lies at the level of 2nd
> intercostal space and intervertebral disc between
> T4 & T5
> CLAPTRAP is useful mnemonic to remember
> structures transected by transverse thoracic plane.

- **C.** cardiac plexus
L: ligamentum arteriosum
- **A.** aortic arch (inner concavity) RECALL
P: pulmonary trunk bifurcation
T: tracheal bifurcation (carina) RECALL
R: right-to-left movement of the thoracic duct
(posterior to the esophagus)
- **A.** azygos vein drains into superior vena cava

## Question 5 of 90

- **A.** 4th intercostal space
- **B.** 3rd intercostal space
- **C.** 1st intercostal space
- **D.** 2nd intercostal space
- **E.** 5th intercostal space

## Question 2 of 54

P: pre-vertebral fascia and pre-tracheal fascia end
6. A 30 years old male presents to the ED with lacerated
wound on his posterolateral back. Which of the following
muscle is most likely affected?
Latissimus dorsi is the superficial muscle of the
posterolateral back innervated by Thoracodorsal
Nerve (RECALL)
Ask the patient to shrug his/her shoulder if patient
unable to do this indicates spinal accessory nerve
injury and paralysis of trapezius muscle (RECALL)
Winging of scapula is due to paralysis of serratus
anterior muscle innervated by Long thoracic nerve
(RECALL)

## Question 6 of 90

- **A.** Sternocleidomastoid
- **B.** Trapezius
- **C.** Latissimus dorsi
- **D.** Rhomboid minor
- **E.** Levator Scapulae
7. A 29-year-old woman presents to the Emergency
Department after injuring her left elbow. She is complaining
of a weak grip on her left hand. You ask her to hold on to a
piece of paper with both hands as you try to pull it away
from her. The result of this clinical test is shown in image
What nerve is most likely to be damaged?

## Question 7 of 90

- **A.** Axillary
- **B.** Radial
- **C.** Median

## Question 3 of 54

Froment sign caused by damage to the ulnar nerve
and paralysis of adductor pollicis muscle (RECALL)

> [!TIP]
> **Clinical Pearls: (High Yield)**
> Froment''s sign: Froment’s sign is a test for ulnar
> nerve palsy specifically paralysis of the adductor
> pollicis:
> Patient is asked to hold a piece of paper between
> thumb and index finger as paper is pulled away,
> patient will flex thumb at inter-phalangeal joint to
> maintain hold, this sign tests the function of
> adductor pollicis muscle which is supplied by the
> ulnar nerve.

A positive test is when the patient is unable to
adduct the thumb.
Claw hand:
Injury to the ulnar nerve is commonly caused by a
fracture of the medial epicondyle and results in a
claw hand, in which the ring and little fingers are
hyperextended at the metacarpophalangeal joints
and flexed at the interphalangeal joints.
Partial claw hand deformity is due to an isolated
ulnar nerve injury.
Complete claw hand deformity: Involves all digits
and results from combined ulnar and median nerve
injury.
- **D.** Ulnar
- **E.** Musculocutaneous
9. A 23 years old pregnant woman from southern Vietnam
came into the ED with complaint of fever with chills for 2
days. You suspect malaria. What is the antimalarial drug of
choice for this patient?

## Question 9 of 90

- **A.** Quinine
- **B.** Doxycycline
- **C.** Primaquine

## Question 4 of 54

Quinine is the antimalarial drug of choice in
pregnancy; however, chloroquine should be
considered in non-falciparum malaria while those
areas where chloroquine is resistant especially
southern Vietnam Quinine is best given in
pregnancy
- **D.** Clindamycin
- **E.** Chloroquine
10. A 54-year-old man presents with visual impairment. On
examination right eye is fixed dilated and deviated
downwards and outwards. Which of the following nerve is
most likely affected?
Depressed and abducted eye, diplopia on
downwards movement, ptosis, fixed and dilated
pupil with loss of accommodation, and abnormal
pupillary light reflex are all clinical effects of injury
of oculomotor nerve.
Note: Orbital blowout fracture and diplopia on
upward gaze is due to entrapment of inferior
rectus muscle (RECALL)

## Question 10 of 90

- **A.** Ophthalmic division of trigeminal nerve
- **B.** Abducent nerve
- **C.** Optic nerve
- **D.** Oculomotor nerve
- **E.** Trochlear nerve
11. A 22 years old girl presents to the ED with complaint of
amenorrhea. Excess of which of the following Harmone
caused this condition?

## Question 11 of 90

## Question 5 of 54

Hyperprolactinemia causes
amenorrhea/oligomenorrhea (Recall), loss of libido
and erectile dysfunction
- **A.** Prolactin
- **B.** Growth Harmone
- **C.** FSH
- **D.** TSH
- **E.** Oxytocin
12. ADH acts primarily at which of the following sites in
renal nephron?
ADH binds to V2 receptors (Recall) and increases
the number of aquaporin-2 at the apical plasma
membrane of Distal convoluted tubule and
collecting duct and increases water permeability
allowing greater water reabsorption.
Diabetes insipidus
Central DI: Low ADH (Recall) less water absorbed
Nephrogenic DI: ADH resistance, Lithium is the
most common acquired cause of nephrogenic DI.
(Recall)
Biochemical values include high plasma osmolality
>295 mOsm/kg, low urine osmolality <300
mOsm/kg (Recall) and hypernatremia > 145.
Note:
Syndrome of inappropriate ADH secretion:
increased ADH activity (Recall) (Euvolemic hypo
osmolar hyponatremia) Recall
Biochemical values include low plasma osmolality <
275 mOsm/kg, increased urine osmolality > 100
mOsm/kg and increased urine sodium or decreased
plasma sodium (Recall)
Drugs causing S.I.A.D.H= S.S.R.I (Fluoxetine Recall),
antipsychotics, anticonvulsants and T.C.A

## Question 12 of 90

- **A.** Distal convoluted tubule
- **B.** Thin ascending limb of loop of Henle
- **C.** Thick ascending limb of loop of Henle
- **D.** Descending limb of loop of Henle
- **E.** Proximal convoluted tubule

## Question 6 of 54

13. A 25 Years old male presents to the ED with complaints
of fever, photophobia, and neck stiffness. You suspect
meningitis. Which of the following is the feature of
Neisseria meningitis?
Neisseria meningitis is gram negative encapsulated
diplococci causing Neisseria meningitis and
meningococcal sepsis

## Question 13 of 90

- **A.** Gram –Ve diplococci
- **B.** Gram +Ve rod
- **C.** Gram –Ve rod
- **D.** Gram +Ve Cocco bacilli
- **E.** Gram +Ve diplococci
15. A 30-year-old diabetic patient presented to the
emergency department with a two-day history of pain in her
right eye worsened with eye movement. The diagnosis of
optic neuritis was made by ophthalmologist. What will be
the cause of optic neuritis?
Optic Neuritis is an acute inflammatory
demyelinating disorder of optic nerve. The myelin
undergoes destruction causing axons to poorly
conduct impulses.
Demyelination disrupts the normal saltatory
conduction process, leading to impaired
transmission of signals along the optic nerve.
inflammatory demyelination as the pathological
hallmark of disease; after the acute event, axonal
damage leading to axonal loss can lead to severe
and sometimes irreversible neurological
impairment.

## Question 15 of 90

- **A.** Retinitis
- **B.** Retinal detachment
- **C.** Hyperglycemia
- **D.** Demyelination
- **E.** Neuromyelitis

## Question 7 of 54

17. Which of the following nerve is damaged in
supracondylar fracture?
Note: Nerve most likely damaged in antecubital
fossa is Median nerve.(RECALL)

## Question 17 of 90

- **A.** Axillary nerve
- **B.** Ulnar nerve
- **C.** Median nerve
- **D.** Radial nerve
- **E.** Common peroneal
18. A 45 Years old male suffered penetrating trauma to the
parotid gland with facial nerve injury. Orbicularis oculi
muscle is affected and frontalis muscle is spared. Which of
the following terminal branch of the facial nerve is most
likely injured?

## Question 18 of 90

- **A.** Zygomatic branch
- **B.** Temporal branch
- **C.** Buccal branch
- **D.** Marginal mandibular branch
- **E.** Greater petrosal nerve

## Question 8 of 54

Note: Skin of upper forehead, eye lid and
conjunctiva are innervated by supraorbital nerve
(RECALL) branch of Opthalmic division of
trigeminal nerve
Supratrochlear nerve:  Innervate skin of lower
central forehead and conjunctiva.
19. A 29 years old male presents to the ED with complaint
of foot drop and loss of sensation on the dorsum of the
foot. Which of the following nerve is most likely damaged?
Common fibular nerve wraps around the neck of
fibula and enter lateral compartment of leg where it
gives rise terminal branches:
Superficial fibular nerve: Runs around lateral
compartment of leg and skin over lower
anterolateral leg, and dorsum of foot (except skin
over webspace of 1st and 2nd toe)
Deep fibular nerve: Anterior compartment of leg
and skin over webspace between 1st and 2nd toes
(RECALL)

> [!TIP]
> **Clinical pearls:**
> 1: Common fibular nerve injury: Damage to the
> common fibular (peroneal) nerve may occur as a
> result of fracture of the head or neck of the fibula
> because it passes behind the head of the fibula and
> then winds laterally around the neck. The nerve
> damage results in foot drop (loss of dorsiflexion)
> and loss of sensation on the dorsum of the foot and
> lateral aspect of the leg and causes paralysis of all

## Question 19 of 90

- **A.** Common peroneal nerve
- **B.** Sciatic nerve
- **C.** Sural nerve
- **D.** Tibial nerve
- **E.** Posterior tibial nerve

## Question 9 of 54

muscles in the anterior and lateral compartments
of the leg (dorsiflexors and evertors muscles of the
foot).
2: Superficial fibular nerve: May be damaged by
fracture of the fibula. As the muscles that the
superficial fibular nerve innervates are evertors,
injury to the nerve may result in a loss of eversion
and loss of sensation over the lower anterolateral
leg and dorsum of foot.
3: Deep fibular nerve:
Motor Loss: Loss of dorsiflexion of ankle resulting in
foot drop. In foot drop foot will appear permanently
plantarflexed, foot drop with high-stepping gait,
weakness of foot inversion.
Sensory Loss: Loss of sensation over webspace
between 1st and 2nd toes.
Note: Footdrop is due to Common fibular or
common peroneal nerve or also due to deep
fibular nerve injury.
Note: It is very important to remember direct
innervation of common fibular nerve.
Deep fibular nerve root: L4-L5
Superficial fibular nerve root: L4-S1.
Muscles of lateral compartment of leg: (High
Yield)
20. A 52 years old chronic smoker presented to the ED with
complaint of sudden severe headache. After initial
assessment and imaging revealed a ruptured berry
aneurysm. Which of the following blood vessel is most
likely location of the aneurysm?
Berry (saccular) aneurysms are the most common
type of intracranial aneurysm, representing 90% of
cerebral aneurysms. The most frequent location is
the anterior communicating artery (35%), followed
by the internal carotid artery

## Question 20 of 90

- **A.** Posterior cerebellar artery
- **B.** Anterior communicating artery
- **C.** Internal carotid artery
- **D.** Anterior cerebellar artery
- **E.** Middle cerebral artery

## Question 10 of 54

High Yield: Clinical effects of occlusion of cerebral
arteries
21. Which one of the following viscera Iie immediately
posterior to the left atrium?
Esophagus Iie immediately posterior to the left
atrium.
Dysphagia megalatriensis, also known as
cardiovascular dysphagia is an impairment of
swallowing due to esophageal compression from a
dilated left atrium.
Oesophagus: (High Yield)
Fibromuscular tube that transports food from
pharynx to stomach, divided into three parts:
Cervical: continuous with the oropharynx,
commences at the lower border of cricoid cartilage
(at level of C5/6) or cricopharyngeus muscle
Thoracic: From thoracic aperture (T1) to the
oesophageal hiatus (T11)
Abdominal: From oesophageal hiatus and is
continuous with the cardia of the stomach at the
gastro-oesophageal junction
Oesophageal constrictions
The anatomical relations of the oesophagus give
rise to four constrictions, where food/foreign
objects are most likely to become impacted.

## Question 21 of 90

- **A.** Subclavian artery
- **B.** Trachea
- **C.** Arch of aorta
- **D.** Esophagus
- **E.** Thymus gland

## Question 11 of 54

Oesophageal constrictions should not be confused
with pathological constrictions.
Cervical constriction: due to cricoid cartilage at the
level of C5/6
Thoracic constriction: due to aortic arch at the level
of T4/5
Abdominal constriction: at oesophageal hiatus at
T10/11 vertebral
Relations of the oesophagus
22. You are teaching group of medical students regarding
anatomy of soles of foot. You ask medical student''s plantar
arteries and nerves lie between the which layer of sole of
foot.
Tendon of flexor digitorum brevis lie within the ist
layer
Plantar arteries and nerves lie within ist and 2nd
layer
Tendons of flexor hallucis longus and flexor
digitorum longus lie within 2nd layer
Flexor hallucis brevis muscle lies within 3rd layer
Tendons of tibialis posterior and fibularis longus
muscle lie within 4th layer

## Question 22 of 90

- **A.** 4th and 5th layer
- **B.** 2nd and 3th layer
- **C.** 1st and 2nd layer
- **D.** 2nd and 4th layer
- **E.** 3rd and 4th layer
24. 30 years old man is brought into the Ed by paramedics
with a gunshot wound on his abdomen. On laparotomy
retroperitoneal hemorrhage found. Which of the following
structures is the most likely source of bleeding?

## Question 24 of 90

- **A.** Liver
- **B.** Suprarenal glands
- **C.** First part of duodenum
- **D.** Spleen

## Question 12 of 54

SADPUCKER useful mnemonic to remember
retroperitoneal organs
S: Suprarenal (adrenal) gland
- **A.** aorta/IVC
- **D.** duodenum (Second and third part)
P: pancreas (except tail)
U: ureters
- **C.** colon (ascending and descending)
K: kidneys
- **E.** (o)esophagus
R: rectum
- **E.** Sigmoid colon
26. A 35 Years old male with a history of RTA was brought
into the ED with injury on occipital region. On examination,
patient has bitemporal hemianopia. Which structure Is most
likely damaged?
Contralateral Homonyms hemianopia = optic tract
(Recall)
Bitemporal hemianopia = optic chiasma
Parietal upper optic radiation: Contralateral
homonymous inferior quadrantanopia
Temporal lower optic radiation: Contralateral
homonymous superior quadrantanopia (Recall)
Occipital visual cortex: Contralateral homonymous
hemianopia with macular sparing e.g.: Lesion of
right temporal lobe would result in left
homonymous superior quadrantanopia causing
left temporal and right nasal vision loss (Recall)
Remember the lesions of visual pathway (High
yield)

## Question 26 of 90

- **A.** Optic radiation
- **B.** Optic tract
- **C.** Optic chiasm
- **D.** Lateral geniculate body
- **E.** Visual area

## Question 13 of 54

27. A 40 years old male presents to the ED with complain
of ptosis with left-sided droopy eye and dry left face. You
suspect Horner''s syndrome. Which of the following nerve is
most likely affected?
Sympathetic fibers if unilaterally damaged may
produce ipsilateral Horner''s syndrome. Horner''s
syndrome characterized by triad of:
Ptosis
Miosis
Anhidrosis

## Question 27 of 90

- **A.** Cervical Sympathetic chain
- **B.** Infratrochlear nerve
- **C.** Long Ciliary nerve
- **D.** Vagus nerve
- **E.** Facial nerve
28. A 3O years old male with history of trauma came into
the ED with abdominal pain. Which of the following vessels
are compromised in rectus sheath hematoma?
Rectus sheath encloses rectus abdominis,
pyramidalis muscle (RECALL), inferior and
superior epigastric vessels, and termination of
intercostal nerves T7-T11.
High Yield:
Rectus sheath: The rectus sheath is formed by the
aponeuroses of the three flat muscles and encloses
the rectus abdominis and pyramidalis muscles. It
has an anterior and posterior wall for most of its
length.
Anterior wall: Formed by the aponeuroses of the
external oblique, and of half of the internal oblique.
Posterior wall:  Half of the aponeuroses of the
internal oblique and of the transversus abdominis.
Approximately midway between the umbilicus and
the pubic symphysis, all the aponeuroses move to

## Question 28 of 90

- **A.** Inferior mesenteric
- **B.** Superior mesenteric
- **C.** Gastroepiploic vessels
- **D.** Inferior epigastric vessel
- **E.** Celiac artery

## Question 14 of 54

the anterior wall of the rectus sheath. At this point,
there is no posterior wall to the sheath; the rectus
abdominis is in direct contact with the transversalis
fascia. Point, where the posterior layer of the rectus
sheath ends, is the arcuate line.
Contents of the rectus sheath
Rectus abdominus and the pyramidalis muscle
The superior and inferior epigastric vessels
The termination of intercostal nerves T7-T11
The 12th thoracic nerve and the accompanying
vessels
29. Whilst in your cardiology rotation you are asked to
perform cardiovascular examination. One of your senior
registrars asks, what is the best site to auscultate mitral
valve?
Areas of auscultation of heart:
Note: Aortic valve: Second right intercostal space
(Recall)
Heart sounds, Mechanical event and
correspondence with ECG (High Yield)

## Question 29 of 90

- **A.** Right 5th ICS in midclavicular line
- **B.** Apex of heart
- **C.** 5th intercostal space to the lower left sternal
border
- **D.** Second right intercostal space
- **E.** Second left intercostal space
30. You are teaching group of medical students'' lymphatic
system and lymph nodes of the body. You ask medical

## Question 30 of 90

## Question 15 of 54

students lymphatics of glans penis drain primarily to which
of the following lymph nodes?
Lymphatics from glans penis and penile urethra
drain primarily into the deep inguinal nodes
Lymphatics from penile skin and prepuce drain
into superficial inguinal nodes (RECALL)
- **A.** Deep inguinal node
- **B.** External iliac nodes
- **C.** Superficial inguinal nodes
- **D.** Internal iliac nodes
- **E.** Paraaortic lymph nodes
31. A 32-year-old male with a history of RTA presented to
ED with Complain of pain in his Right shoulder. X-ray was
done which shows anterior shoulder dislocation. Which of
the following nerve is most likely damaged?
Intrinsic muscles of the shoulder: Connecting the
scapula to the humerus
There are six muscles in this group the deltoid, teres
major, and the four rotator cuff muscles
(supraspinatus, infraspinatus, subscapularis, and
teres minor).
Anatomical course: (High Yield)
Axillary nerve arises in the axilla passes medially to
the surgical neck of the humerus, where it divides
into three terminal branches:

## Question 31 of 90

- **A.** Lower subscapular nerve
- **B.** Axillary nerve
- **C.** Median nerve
- **D.** Suprascapular nerve
- **E.** Ulnar nerve

## Question 16 of 54

Anterior terminal branch:  winds around the
surgical neck of the humerus and provides motor
innervation to the anterior aspect of the deltoid
muscle.
Posterior terminal branch:  Gives motor innervation
to the posterior aspect of the deltoid muscle and
teres minor. It also innervates the skin over the
inferior part of the deltoid as the upper lateral
cutaneous nerve of the arm.
Articular branch: supplies the glenohumeral joint

> [!TIP]
> **Clinical Pearls:**
> Axillary nerve injury is commonly caused by
> fracture of surgical neck of humerus or inferior
> dislocation of humerus.

Causes weak lateral rotation and abduction of the
arm. (Supraspinatus can abduct the arm but not to
a horizontal level).
Loss of sensation over the inferior portion of the
deltoid (the ‘regimental badge area’).
Quadrangular space: Axillary nerve and posterior
circumflex humeral artery and vein pass through it
and can be compressed as a result of trauma,
muscle hypertrophy resulting in weakness of deltoid
and teres minor.
Note: Axillary nerve injury also results in
weakness of deltoid (RECALL) and teres minor
and resulting in weakness of abduction and
lateral rotation.
32. A 30 years old man is brought into the Ed by
paramedics with a lacerated wound on his abdomen. which
of the following Structures is most likely affected by a tear
of the superior mesenteric artery?
The superior mesenteric artery supplies the midgut
structures from the second part of duodenum
including the caecum, appendix, ascending colon,
and proximal two-thirds of the transverse colon.
Inferior mesenteric artery supplies the descending
colon and sigmoid colon.

## Question 32 of 90

- **A.** Only ascending colon
- **B.** Ascending and transverse colon
- **C.** Transverse colon only
- **D.** Transverse and descending colon
- **E.** Sigmoid colon
33. The probability of rejecting the null hypothesis when it is
true;

## Question 33 of 90

## Question 17 of 54

In statistical hypothesis testing, a type1 error is the
mistaken rejection of an actually true null
hypothesis (also known as false positive” finding or
conclusion; example: innocent person is convicted”).
While type 2 error is the failure to reject the null
hypothesis that is actually false (also known as false
negative. Finding or conclusion example: guilty
person is not convicted) much of statistical theory
revolves around the minimization of one or both of
these errors, though the complete elimination of
either is a statistical impossibility if the outcome is
not determined by a known, observable casual
process. By selecting low threshold (cut-off) value
and modifying the alpha level, the quality of
hypothesis test can be increased. The knowledge of
type 1 error and type 2 error is widely used in
medical science, biometrics and computer science.
- **A.** Type 1 error
- **B.** Level of significance
- **C.** Type 2 error
- **D.** Power of statistical test
- **E.** Type 3 error
34.
You are reviewing a patient with infected arteriovenous
fistula and he will undergo hemofiltration tomorrow. Which
of the following best describes the Transport of molecules
across the membrane that occurs in haemofiltration?
Ultrafiltration refers to the process of movement of
fluids through a membrane caused by a pressure
gradient
In dialysis, fluid is removed by ultrafiltration using
the dialysis membrane. The pressure on the
dialysate side is lower so water moves from the
blood (place of higher pressure) to the dialysate
(place of lower pressure). This is how the
hemodialysis treatment removes fluid.

## Question 34 of 90

- **A.** Active transport
- **B.** Facilitated diffusion
- **C.** Simple diffusion
- **D.** Ultrafiltration
- **E.** Osmosis

## Question 18 of 54

35. A 45-year-old male sustained lacerated wound on his
right knee 2 days back and came into ED with a Complaint
of Severe pain in his right knee associated with fever and
swelling of joint. You suspect septic arthritis. what is the
single most causative agent in this case?
Septic arthritis is an infection of any kind that finds
its way into joint space, it is a most rapid and
destructive joint disease, acute onset of
monoarticular arthritis with pain swelling, and
warmth, the knee is the most common site others
include the hip, wrist, shoulder, and ankle.
the most common type of bacteria that causes
septic arthritis is called staphylococcus aureus.
others include streptococcus, gram-negative rods,
Neisseria Gonorrhea causes septic arthritis in
sexually active young adults (Recall)

## Question 35 of 90

- **A.** S.Epidermidis
- **B.** Streptococcus
- **C.** Staph Aureus
- **D.** Staph pyogenes
- **E.** E- Coli
37. You are teaching group of medical students'' full
neurological examination while assessing dermatomal
supply of trunk you ask medical students, what is the
dermatome of nipple?
Dermatomal supply of trunk:

## Question 37 of 90

- **A.** T2
- **B.** T3
- **C.** T4
- **D.** T8
- **E.** T6

## Question 19 of 54

High yield:
38. Whilst in your emergency department your consultant
asks you to perform chest examination. Righr middle lobe
is best auscultated between which of the following ribs?
The superior lobe of the right lung is best
auscultated above the 4th rib anteriorly.
The middle lobe of the right lung is best auscultated
between the 4th and the 6th rib anteriorly.
The superior lobe of the left lung is best auscultated
above the 6th rib anteriorly.
The inferior lobes of the left and right lungs are best
auscultated in the back between T3 & T10.

## Question 38 of 90

- **A.** Rib 1-2
- **B.** Rib 4-6
- **C.** Rib 2-3
- **D.** Rib 2-4
- **E.** Rib 3-4
39. Which one of the following hormones is released from
posterior pituitary?

## Question 39 of 90

- **A.** FSH

## Question 20 of 54

Two hormones released from the posterior pituitary
gland are ADH and Oxytocin
Note: ADH release from posterior pituitary
synthesized in hypothalamus. (Recall)
ADH is released in response to raised plasma
osmolality seen in dehydration (Recall)
Pituitary
Harmone
Inhibited By
Clinical
deficiency
Excess
Growth
Harmone
Somatostatin
(Recall)
dwarfism in
children
Acromegaly in adults or
gigantism in children
Prolactin
Dopamine
(Recall)
Failure of
postpartum
lactation
Hyperprolactinemia causes
amenorrhea/oligomenorrhea
(Recall), loss of libido and
erectile dysfunction
ACTH Cortisol
(Recall)
Adrenal
insufficiency
Cushing''s disease
FSH/LH
Prolactin and
oestrogen
/testosterone
Infertility Gonadal insufficiency
- **B.** ADH
- **C.** ACTH
- **D.** TSH
- **E.** Prolactin
40. You are going to perform full cardiovascular
examination in a patient with known cardiac disease. Your
consultant asks how does the 4  heart is produced?

## Question 40 of 90

th
- **A.** Caused by filling of an abnormally stiff ventricle
in atrial diastole
- **B.** Caused by closure of the semilunar (aortic and
pulmonary) valves
- **C.** Caused by filling of an abnormally stiff ventricle
in atrial systole
- **D.** Caused by closure of the atrioventricular (mitral
and tricuspid) valves
- **E.** Caused by rapid flow of blood from the atria into
the ventricles during the ventricular filling

## Question 21 of 54

Note: Dicrotic notch on the arterial waveform
represent closure of aortic valve (Recall) used to
demarcate the end of systole and the beginning
of diastole.
High Yield
The isovolumic relaxation phase starts when the
aortic valve closes (Recall) and ends when the
mitral valve opens. During this phase, the left
ventricular pressure drops until it becomes lower
than that of the left atrium. This allows opening of
the atrioventricular valve and the filling of the
ventricle.
41. A 20 Years old girl presents to the ED with complaint of
headache, Palpitations and diaphoresis. After initial
assessment you suspect pheochromocytoma. This clinical
condition occurs due to excess of which of the following
hormones?

## Question 41 of 90

- **A.** ACTH
- **B.** PTH
- **C.** Catecholamines

## Question 22 of 54

Pheochromocytoma is catecholamine secreting
tumor arises from chromaffin cells of adrenal
medulla
Catecholamines include adrenaline, nor adrenaline
and dopamine.
Adrenaline is predominant Harmone in
pheochromocytoma
- **D.** Oxytocin
- **E.** ADH
44. which of the following muscle unlock the knee from the
extended position?
At full extension, the tibia and femur “lock” into
position, providing stability in the leg and improving
load-bearing capacity. The popliteus muscle at the
back of the leg unlocks the knee by rotating the
femur on the tibia, allowing flexion of the joint.

## Question 44 of 90

- **A.** Popliteus
- **B.** Soleus
- **C.** Sartorius
- **D.** Gastrocnemius
- **E.** Plantaris
45. A 45-year-old male sustained a lacerated wound on his
right knee 2 days back and came into ED with a Complaint
of Severe pain in his right knee associated with fever and
swelling of the joint. Gram staining revealed gram +ve cocci
in clusters what is the single most causative agent in this
case?
Staph aureus is gram +Ve diplococci in clusters
causing septic arthritis

## Question 45 of 90

- **A.** Staph pyogenes
- **B.** Streptococcus
- **C.** Staph Aureus
- **D.** E- Coli
- **E.** S.Epidermidis

## Question 23 of 54

46. 70 years old male presents to the ED with complain of
expressive Broca''s dysphasia. The brocas speech area is
located in which of the following regions?
Broca’s speech area is located in frontal lobe
Broca’s aphasia or expressive aphasia is when
people find it very difficult to find and say the right
words. People with Broca''s aphasia may only be
able to say single words or very short sentences,
although it’s usually possible for other people to
understand what they mean
Wernicke''s aphasia (fluent aphasia) in the
temporal lobe.
Wernicke’s aphasia or receptive aphasia is when
someone is able to speak well and use long
sentences, but what they say does not make any
sense.

## Question 46 of 90

- **A.** Midbrain
- **B.** Parietal lobe
- **C.** Temporal lobe
- **D.** Frontal lobe
- **E.** Occipital lobe
47. A 45 years old male presents to the ED with history of
severe vomiting for the last 4 days.. The patient is irritable,
weak, and reporting muscle cramping and weakness. On
assessment, the patient is experiencing bradypnea with a
respiratory rate of 10. The patient has the following ABGs
result: HCO3 36, pH 7.52, PaCO2 48. Which condition
below is presenting?
If the primary acid-base disorder is from a
respiratory cause, the kidneys will compensate
(renal compensation).
If the primary disorder is from a metabolic cause,
the lungs will compensate (respiratory

## Question 47 of 90

- **A.** Respiratory alkalosis fully compensated
- **B.** Metabolic alkalosis partially compensated
- **C.** Metabolic acidosis not compensated
- **D.** Metabolic alkalosis fully compensated
- **E.** Metabolic acidosis partially compensated

## Question 24 of 54

compensation).
Metabolic acidosis= Respiratory compensation
(decrease in PaCO2)
Metabolic alkalosis= Respiratory compensation
(increase in PaCO2)
Respiratory acidosis= Renal compensation (increase
in HCO3-)
Respiratory alkalosis= Renal compensation
(decrease in HCO3-)
48. Regarding propranolol use in thyroid crises, which one
of the following is true?
Propranolol is used as short-term symptomatic
therapy till the effect of Carbimazole develops.

## Question 48 of 90

- **A.** As short-term symptomatic therapy till effect of
Carbimazole develops
- **B.** To potentiate the effect of radioactive iodine
- **C.** As long-term therapy after subtotal
thyroidectomy
- **D.** In patients not responding to Carbimazole
- **E.** In patients Carbimazole contraindicated
50. You are teaching group of medical students about origin
and insertion of muscles. Which of the following muscle
originate from the anterior superior iliac spine?
Origin of most important lower limb
muscles

## Question 50 of 90

- **A.** Sartorius
- **B.** Psoas major
- **C.** Pectineus
- **D.** Rectus femoris
- **E.** Iliacus

## Question 25 of 54

Note: Greater trochanter of femur is site of
insertion of gluteus Medius, gluteus minims and
piriformis (RECALL)
51. 27 years old male presents to the ED with complain of
dysphagia. Which of the following nerve is responsible for
contracting the esophageal phase of swallowing?
Pharyngeal phase of swallowing: glossopharyngeal
nerve and vagus nerve
Esophageal phase of swallowing: Vagus nerve

## Question 51 of 90

- **A.** Vagus nerve
- **B.** Hypoglossal nerve
- **C.** Facial nerve
- **D.** Glossopharyngeal nerve
- **E.** Auriculotemporal nerve
53. A 25 years old male patient with a history of trauma
presents into the ED with complaint of pain in epigastrium
radiating to the back. Which of the following is the
segmental innervation of the pancreas?
Innervations:

## Question 53 of 90

- **A.** T6 –T10
- **B.** L2-L4
- **C.** T4-T8
- **D.** T4 –T10
- **E.** L1-L2

## Question 26 of 54

The segmental level of innervation of pancreas= T6-
T10
Gallbladder=phrenic(C3-C5)
Ascending and transverse colon= fibers travel
through lesser splanchnic nerve to =T10-T11 spinal
cord segment
Descending and sigmoid colon=pain fibers travel
through lumber splanchnic nerve to= L1 and L2
spinal segments
Ureter=Sympathetic supply from inferior
hypogastric plexus
parasympathetic supply from pelvic splanchnic
nerve(S2-S4)
Visceral afferent fibers follow sympathetic fibers to
enter in spinal cord via =T10-L1 nerve fibers
Bladder= Efferent parasympathetic fibers from
pelvic splanchnic nerve=S2 to S4
ovary=sympathetic fibers of ovarian and lumber
splanchnic nerve to cell bodies in the = T10-T12 and
L1 spinal sensory ganglion
Testes= visceral afferent fibers follow the
sympathetic fibers to=T10-L1
Rectum= visceral afferent fibers follow
parasympathetic supply to =S2-S4 sensory ganglia.
54. You are required to perform resuscitative thoracotomy
in a patient with massive hemothorax. Which one of the
following muscles are divided during anterolateral
thoracotomy?
Antero lateral thoracotomy muscle divided serratus
anterior and pectoralis major
Antero lateral thoracotomy: Nerve injury long
thoracic nerve (Recall)
Post: lateral thoracotomy muscle divided latissimus
dorsi
Post: lateral thoracotomy nerve injury:
Thoracodorsal nerve injury
Internal mammary artery (RECALL) and Aorta are
likely to be damaged also

## Question 54 of 90

- **A.** Anterior scalene
- **B.** Latissimus dorsi
- **C.** Serratus anterior
- **D.** Trapezius
- **E.** Pectoralis minor
55. Which of the following best describes the course of the
great saphenous vein:

## Question 55 of 90

- **A.** Passes behind posterior malleolus

## Question 27 of 54

The great saphenous vein passes anterior to the
medial malleolus, travels up the medial side of the
leg, and thigh to pass through the saphenous
opening in the deep fascia of thigh, and joins with
femoral vein.
Small saphenous vein passes posterior to lateral
malleolus
- **B.** Anterior to medial malleolus
- **C.** Posterior to medial malleolus
- **D.** Anterior to lateral malleolus
- **E.** Posterior to lateral malleolus
56. A 25 Years old male presents to the ED with complaints
of fever, photophobia, neck stiffness, and non-blanching
skin rash. What is the most likely Causative agent?
Neisseria meningitidis is the most common cause
of bacterial meningitis. Meningococci/Neisseria
meningitidis are gram-negative diplococci that
cause meningitis and meningococcemia.
Symptoms, usually severe, include headache,
nausea, vomiting, photophobia, lethargy, rash,
multiple organ failure, shock, and disseminated
intravascular coagulation. Diagnosis is clinical,
confirmed by culture

## Question 56 of 90

- **A.** Streptococcus aureus
- **B.** Streptococcus pyogenes
- **C.** Hemophilus influenza
- **D.** Neisseria meningitis
- **E.** E-Coli
57. which of the following best describes the function of
mitochondria is?

## Question 57 of 90

- **A.** Carbohydrate synthesis
- **B.** Energy production
- **C.** Protein packaging
- **D.** Lipid synthesis
- **E.** Protein synthesis

## Question 28 of 54

It acts as the site of aerobic respiration and
produces cellular energy in the form of ATP
(powerHouse of the cell).
58. A 43 years old undergone surgery of posterior part of
the neck after which he lost sensation around the clavicle.
Which of the following dermatome is best localized on the
supraclavicular region?
High Yield:
Dermatomes of Upper Limb:
Dermatome: A dermatome is defined as ‘a strip of
skin that is innervated by a single spinal nerve and
clinically very important and help in diagnosis of
spinal cord injury
Myotomes and associated
movements:
Myotome: Group of muscles innervated by a single
spinal nerve
Reflexes of upper Limb:

## Question 58 of 90

- **A.** C3
- **B.** T2
- **C.** C2
- **D.** C5
- **E.** C4
59. A 30-year-old woman presents to the ED with
weakness and fatigue. On examination, she has yellow
tinge skin, jaundice, and mild splenomegaly. CBC shows

## Question 59 of 90

## Question 29 of 54

her Hb 7g/dl. The patient only takes one medication. Which
of the following medications is most likely to cause
hemolytic anemia?
Among NSAIDs, Mefenamic acid causes hemolytic
anemia.
Co-amoxiclav causes Cholestatic jaundice
(RECALL)
Summary Of Drugs And Their
Side Effects (High Yield)
- **A.** Propranolol
- **B.** Mefenamic acid
- **C.** Lithium
- **D.** TCA
- **E.** Ibuprofen
61. A 60 Years old male known case of Diabetes mellitus
presents into the ED with complaint of eye pain that’s
worsened by eye movement and loss of color vision. You
suspect optic neuritis which one of the following conditions
is strongly associated with it?

## Question 61 of 90

- **A.** Diabetes Mellitus
- **B.** Multiple sclerosis
- **C.** Hyperglycemia
- **D.** Sarcoidosis

## Question 30 of 54

Optic neuritis is an inflammatory demyelination of
the optic nerve, and is strongly associated with
multiple sclerosis.
- **E.** Crohn''s disease
62. A 30 years old male was brought into the ED following a
fall from a height. His examination reveals bilateral
weakness in both arm power of 3/5 and his lower limb
power is 4/5, he also has variable sensory impairment
What is the most likely diagnosis?
-Spinal cord injuries spinal
tracts and their normal
function
Spinal cord syndrome
Anterior cord syndrome
(Recall)

## Question 62 of 90

- **A.** Central Cord Syndrome
- **B.** Complete Cord Transection
- **C.** Posterior Cord Syndrome
- **D.** Anterior Cord Syndrome
- **E.** Brown Sequard Syndrome

## Question 31 of 54

63. A 38-year-old woman known case of hyperthyroidism
presented with palpitations, sweating, and agitation. On
examination, she is hyperpyrexic, hypertensive, and
tachycardic. She has not been able to take her medicine.
which of the following medication would you prescribe
immediately to treat her symptoms?
Propranolol is the preferred agent in
hyperthyroidism and thyroid storm due to its
additional effect of blocking the peripheral
conversion of inactive T4 to active form T3. They are
highly effective for symptomatic relief (tachycardia,
tremors)
In hyperthyroidism (grave’s disease) =increased T3,
T4 levels, decrease TSH levels (RECALLL)
In hypothyroidism (Hashimoto''s thyroiditis)
=Decrease T3, T4, increase TSH (RECALL)

## Question 63 of 90

- **A.** Atropine
- **B.** Carbimazole
- **C.** Hydrocortisone
- **D.** Propranolol
- **E.** Iodine solution
64. A 24-year-old male presented to ER with a fracture of
both the tibia and fibula while playing. The patient
demonstrates foot drop. Most common nerve involved in
foot drop?
Most commonly, foot drop is caused by an injury to
the peroneal nerve (fibular nerve)
common peroneal/fibular nerve (L4 to S2) supply
skin over the lower lateral leg (RECALL) and dorsal
aspect of foot and toes (except lateral side of little
toe supplied by sural branch of tibial nerve)
Wrist drop= Radial Nerve (RECALL)
Claw hand= ulnar nerve (RECALL)
Ape hand= median nerve

## Question 64 of 90

- **A.** Tibial nerve
- **B.** Common peroneal nerve
- **C.** Sciatic nerve
- **D.** Obturator nerve
- **E.** Femoral nerve

## Question 32 of 54

65. You are going to attempt lumbar puncture in a patient
with suspected meningitis. What is the recommended
vertebral level to perform LP?
A lumbar puncture (LP) is a procedure in which a
needle is inserted into the spinal canal. It is most
commonly used to collect a sample of
cerebrospinal fluid (CSF) for diagnostic testing (e.g.,
for suspected meningitis and subarachnoid
hemorrhage)
Lumbar puncture is preferentially performed at
L3/L4 or L4/L5 (cauda equina level), to avoid the
spinal cord which ends at L1/L2.
The layers penetrated by the spinal needle in an LP
are as follows:
Skin
subcutaneous tissue
supraspinous ligament (RECALL)
Interspinous ligament
ligamentum flavum
Epidural space or extradural
dura mater
arachnoid mater
subarachnoid space (contains CSF)

## Question 65 of 90

- **A.** L4/L5
- **B.** T11/T12
- **C.** L2/L3
- **D.** L1/L2
- **E.** T12/L1
66. A 70-year-old male is scheduled to undergo repair of an
inguinal hernia that is easily reduced by pushing the
abdominal contents back through the external ring. Direct
inguinal hernia is due to weakness in which of the following
layer?

## Question 66 of 90

- **A.** lacunar ligament
- **B.** External oblique aponeurosis
- **C.** Transversalis fascia
- **D.** Transversus abdominis
- **E.** Deep inguinal ring

## Question 33 of 54

Direct inguinal hernia is common in elderly bulge
through weakened fascia of abdominal wall
(Transversalis fascia)) directly behind superficial
inguinal ring and medial to the inferior epigastric
vessels (Recall)
Indirect inguinal hernia enters inguinal canal at the
deep inguinal ring and lateral to inferior epigastric
vessels
67. You are discussing ECG waveform with group of
medical students. You ask ur students, What does the
second heart sound correspond to on the ECG waveform:
Heart sounds, Mechanical event and
correspondence with ECG (High
YIELD)
Remember the table on your fingertips many recalls
from this table

## Question 67 of 90

- **A.** P wave
- **B.** T wave
- **C.** QRS complex
- **D.** ST segment
- **E.** PR interval
68. A 20 years old young boy after assault in the college
presents to the ED with superficial lacerated wound on his
anterior triangle of neck. Which of the following muscle is
most likely injured?

## Question 68 of 90

- **A.** Platysma
- **B.** Sternocleidomastoid
- **C.** Scalene muscle

## Question 34 of 54

Neck fascia is divided into superficial and deep
fascia
Superficial fascia includes: Superficial veins (External
jugular), superficial lymph nodes, fat and platysma
muscle
Deep fascia includes: Trapezius,
sternocleidomastoid, Visceras of neck and
vasculature includes common carotid artery,
internal jugular vein and vagus nerve in the carotid
sheath.
- **D.** Trapezius muscle
- **E.** Suprahyoid
70. You are asked to perform ascitic tap on a CLD patient
and teach a group of medical students. You ask medical
students what is the site to perform ascitic tap.
Ascites or hemoperitoneum accumulates in
Morrisons pouch or Hepatorenal recess or Right
perihepatic space which is lowest space in
peritoneal cavity in Supine position
Subphrenic or right subphrenic (pus from
appendicitis or ruptured duodenal ulcer accumulate
here

## Question 70 of 90

- **A.** Right perihepatic space
- **B.** Left subphrenic space
- **C.** Right subphrenic space
- **D.** Left perihepatic space
- **E.** Left lower quadrant
71. A 65 Years old woman presents with a painful shoulder
after falling on the ground. On examination and rotator cuff
assessment she is unable to perform the Lift Off test.
Which rotator cuff muscle has been most likely injured?
Assessment of rotator cuff muscles

## Question 71 of 90

- **A.** Subscapularis
- **B.** Supraspinatus
- **C.** Infraspinatus
- **D.** Teres major
- **E.** Teres minor

## Question 35 of 54

Note: Supraspinatus is the most commonly
injured rotator cuff muscle and helps to initiate
abduction from 0 degree to 15 degrees (RECALL)
and then assist the deltoid with continued
abduction.
73. A 24 years old female who is 3 months pregnant came
into the ED with complaint of lower abdominal pain. You
suspect ectopic pregnancy. Ectopic pregnancy occurs most
commonly in which part of uterine tube?
Ectopic pregnancies most commonly occur in
ampulla.

## Question 73 of 90

- **A.** Infundibulum
- **B.** Fimbriae
- **C.** Ampulla
- **D.** Isthmus
- **E.** Cervix
74. Vibrio cholera causes watery diarrhea due to which of
following final pathways?
Cholera toxin activates adenylate cyclase and
increases cyclic adenosine monophosphate (CAMP).
CAMP activates the Cl-secretory channels and
produces a primary secretion of Cl- with Na+ and
H20.

## Question 74 of 90

- **A.** Decrease Camp
- **B.** Increase proton secretory channels
- **C.** Increase cl- ion secretion
- **D.** Increased hco3 secretory channels
- **E.** Decreased cl- ion secretion

## Question 36 of 54

76. A 62-year-old patient with pericardial effusion comes to
a local hospital for aspiration of pericardial fluid by
pericardiocentesis. The needle is inserted into the
pericardial cavity through which of the following intercostal
spaces adjacent to the sternum?
Pericardiocentesis is a procedure performed to
remove pericardial fluid from the pericardial sac
that surrounds the myocardium
The needle insertion site is 1-2 cm lateral to the apex
beat within the fifth intercostal space. Advance the
needle over the superior border of the rib to avoid
intercostal nerves and vessels.
High yield:
Sites for Abdominal Paracentesis:
Midline Approach =2 cm below Umbilicus in midline
Lateral Approach = 3 to 5 cm Superior and Medial to
Anterior Superior Iliac Spine.
Needle Thoracocentesis in Pneumothorax =2nd
Intercostal Space Midclavicular line. (RECALL)
Chest Tube Intubation, Pleural tap = Midaxillary Line
5th Intercostal Space.

## Question 76 of 90

- **A.** Left fifth intercostal space
- **B.** Left fourth intercostal space
- **C.** Right sixth intercostal space
- **D.** Right fourth intercostal space
- **E.** Right fifth intercostal space
77. At which of the following site maximal absorption of
vitamin B12 occur?
Maximal water reabsorption occurs in Jejunum
(Recall)
Maximal Iron absorption occurs in duodenum
(Recall)

## Question 77 of 90

- **A.** Duodenum
- **B.** Jejunum
- **C.** Proximal ileum
- **D.** Terminal ileum
- **E.** Stomach

## Question 37 of 54

Maximal calcium absorption occurs in duodenum
(Recall)
Maximal vit B12 absorption occurs in terminal ileum
Note: Sub acute cord syndrome: Due to vitamin B12
deficiency also known as subacute combined
degeneration of spinal cord (Recall) there is
mainly degeneration pf posterior and lateral cord
Drugs causing Vit B12 Deficiency: Ethanol,
chloramphenicol, H2 receptor blockers, PPI
(Omeprazole) Recall
78. Which one of the following vessels is compressed in
thoracic outlet syndrome?
Thoracic outlet syndrome (TOS) refers to the clinical
features that arise from compression of the
neurovascular bundle within the thoracic outlet.
Compression of brachial plexus
Compression of subclavian artery
Compression of subclavian vein
Structures that pass through the thoracic inlet
include: (High Yield)
Trachea and oesophagus
Thoracic duct and apices of the lung
phrenic nerve
vagus nerve
Recurrent laryngeal nerves
Sympathetic trunks
Left and right common carotid arteries.
left subclavian arteries.
Internal jugular veins
Brachiocephalic veins
Subclavian veins
lymph nodes and lymphatic vessels

## Question 78 of 90

- **A.** Vertebral artery
- **B.** Subclavian artery and vein
- **C.** Brachiocephalic trunk
- **D.** Internal carotid artery
- **E.** Common carotid artery
79. A 25 years old male presents to the ED with a
complaint of progressive difficulty in walking. When you
observe him, he walks with waddling gait and pelvis falling
towards the left side on each step. Which of the following
nerve is most likely injured?

## Question 79 of 90

- **A.** Sciatic nerve

## Question 38 of 54

Trendelenburg gait or waddling gait occurs when
your hip abductor muscles are weakened. This
muscle group includes the gluteus medius and
minimus innervated by superior gluteal nerve. The
weakness of these muscles causes drooping of
the pelvis to the contralateral side while walking
(RECALL)
- **B.** Inferior gluteal nerve
- **C.** Ilioinguinal nerve
- **D.** Superior gluteal nerve
- **E.** Obturator nerve
80. A 45-year-old male was found unconscious at home
and was brought into the ED by paramedics. On initial
assessment at triage, his BM was 1.5mmol/l. According to
hypoglycemia management guidelines what initial
treatment should be given in unconscious patient:
IM glucagon should be given initially in an
unconscious patient while those patients who are
alert and able to swallow oral dextrose should be
given

## Question 80 of 90

- **A.** 70 to 80 ml of 50% glucose
- **B.** Wait for iv-line access and give iv 10 % dextrose
- **C.** 1mg IM glucagon
- **D.** IM Pabrinex
- **E.** 5% dextrose orally
81. A 55 Years old male with history of hypertension came
into the ED with a complaint of sudden severe abdominal
pain. After initial assessment at triage, you suspect
abdominal aortic aneurysm. Which one of the following is
the most common site of abdominal aortic aneurysm?

## Question 81 of 90

- **A.** Suprarenal aorta
- **B.** Epigastrium
- **C.** Below diaphragm

## Question 39 of 54

The most common location of arterial aneurysm
formation is the abdominal aorta, while the most
common site of abdominal aortic aneurysm is
infrarenal aorta (90 to 99%)
- **D.** Infrarenal aorta
- **E.** At the level of umbilicus
82. A cardiac patient presents to the Emergency
department with an acutely painful, red, hot, swollen big
toe. He has past medical history of gout and severe heart
failure. Gout is diagnosed. Which of the following is the
drug of choice for this patient?
Colchicine mechanism of action: Colchicine
has anti-inflammatory properties. It disrupts
cytoskeletal functions by inhibiting beta-tubulin
polymerization into microtubules (Recall),
preventing activation, degranulation, and migration
of neutrophils associated with mediating gout
symptoms.
Colchicine is useful in patients with heart failure and
those taking anticoagulants
Avoid colchicine in patients with blood dyscrasias
and bone marrow disease
NSAIDs are contraindicated in a patient with heart
failure. (Diclofenac is contraindicated in people with
ischemic heart disease).

## Question 82 of 90

- **A.** NSAID
- **B.** Paracetamol
- **C.** Allopurinol
- **D.** Colchicine
- **E.** Prednisolone
84. Which of the following NSAIDs has the least
gastrointestinal side effects?

## Question 84 of 90

- **A.** Piroxicam
- **B.** Ibuprofen
- **C.** Naproxen
- **D.** Diclofenac
- **E.** Indomethacin

## Question 40 of 54

NSAIDS-induced GI side effects:
Lowest risk=ibuprofen
Highest risk=piroxicam, ketorolac
NSAIDs cause GERD by inhibiting the COX 1
enzymes (cox 1 stimulation produce prostaglandins
that help to maintain the gastric mucosal integrity)
NSAIDs can cause ulcers by interfering with the
stomach''s ability to protect itself from gastric acid
(by inhibiting the function of prostaglandins)
RECALL
NSAID causes hemolytic anemia=Mefenamic acid
(RECALL).
85. A 32 Years old lady came into the ED with Complaint of
pain in the foot. She gives history of taking certain
antibiotics prescribed by her GP. Which of the following
antibiotics class are associated with tendon injury?
Tendon damage and QT interval prolongation both
are the common side effects of quinolones
QT prolongation leads to Torsades de pointes
High Yield:
Summary Of Drugs And Their
Side Effects

## Question 85 of 90

- **A.** Quinolones
- **B.** Cephalosporins
- **C.** Macrolides
- **D.** Tetracyclines
- **E.** Aminoglycosides

## Question 41 of 54

86. A 32 Years old male sustained a dirty wound on his leg
while running on the ground. Which of the following
pathogen is conditional causing infection after puncture
wounds?
Pathogen and Types: (High
Yield)

## Question 86 of 90

- **A.** E.Coli
- **B.** Treponema pallidum
- **C.** Staphylococcus aureus
- **D.** Pseudomonas aeruginosa
- **E.** Neisseria gonorrhoeae
88. A 40 years old male presents to the ED with chest pain
and the following ECG is taken. Which artery is most likely
be occluded? ￼
ECG demonstrates Acute Inferior Myocardial
Infarction due to occlusion of RCA
St-elevation in inferior leads (II, III,aVF) with
reciprocal ST-depression in I, aVL
Note: Both inferior wall MI and posterior wall MI
occurs due to occlusion of Right coronary artery.

## Question 88 of 90

- **A.** Left anterior descending
- **B.** Right coronary artery
- **C.** Obtuse marginal artery
- **D.** left main coronary artery
- **E.** Left circumflex
89. A 52-year-old man is unwell with crushing central chest
pain. An ECG shows significant ST segment changes.

## Question 89 of 90

## Question 42 of 54

Angiography shows occlusion of the circumflex branch of
the left coronary artery.
This condition most commonly results in ischemia in which
area of the heart?
LCA divides into the anterior interventricular branch
and the circumflex branch. The circumflex branch
follows the coronary sulcus to the left border and
onto the posterior surface of the heart and supply
left atrium and left ventricle
- **A.** Anterior part of the left ventricle
- **B.** Anterior part of the right ventricle
- **C.** Inferior part of the left ventricle
- **D.** Posterior part of the left ventricle
- **E.** Inferior part of the right ventricle
90. A 10-year-old male presents to the ED with abdominal
pain, vomiting and bleeding per rectum. After initial
assessment and imaging is suggestive of Meckel''s
diverticulum. The blood supply of Meckel''s diverticulum is
from which of the following:
Rich blood supply to Meckle''s diverticulum is from
Superior mesenteric artery
Proximal to the major duodenal papilla – supplied
by the gastroduodenal artery (branch of the
common hepatic artery from the coeliac trunk
Distal to the major duodenal papilla – supplied by
the inferior pancreaticoduodenal artery (branch of a
superior mesenteric artery)
Meckel''s Diverticulum: (High Yield)
True diverticula of all 3 layers of the small intestines
Caused by incomplete obliteration of the vitelline
duct.
Rule of 2s: 2 years old, 2 ft from ileocecal valve, 2 in
long, 2% of population
Usually, asymptomatic

## Question 90 of 90

- **A.** Gastroduodenal artery
- **B.** Inferior mesenteric artery
- **C.** Superior mesenteric artery
- **D.** Inferior pancreaticoduodenal artery
- **E.** Celiac trunk

## Question 43 of 54

Painless bleeding due to an ulcer caused by
heterotopic gastric tissue most common
presentation in children.
Obstruction is caused by intussusception, volvulus,
and hernia most common presentation in adults.
1. A 26-Year-old girl presents to the ED with trauma to the
internal auditory meatus. Which of the following nerves are
most likely injured:
The internal auditory meatus also referred to as the
internal acoustic meatus lies in the temporal bone
and exists between the inner ear and posterior
cranial fossa. It includes the vestibulocochlear nerve
(CN VIII), facial nerve (CN VII), the labyrinthine
artery, and the vestibular ganglion.

## Question 1 of 90

- **A.** Vestibulocochlear nerve and accessory nerve
- **B.** Facial nerve and abducens nerve
- **C.** Trochlear nerve and abducens nerve
- **D.** Facial nerve and glossopharyngeal nerve
- **E.** Vestibulocochlear nerve and facial nerve
3. Whilst in your physiology lecture you ask medical
students, what is the method to calculate mean arterial
pressure?
Pulse pressure is difference between the Systolic
and Diastolic pressure e.g., 120-80=40
Mean arterial pressure:  Diastolic pressure + 1/3
(pulse pressure) e.g., 80+ 1/3 (120-80) = 93.2
Cerebral perfusion pressure= MAP- intracranial
pressure (RECALL)

## Question 3 of 90

- **A.** Systolic pressure + 1/3 (pulse pressure)
- **B.** Diastolic pressure + Systolic pressure/2
- **C.** Diastolic pressure + Systolic pressure
- **D.** Diastolic pressure + pulse pressure
- **E.** Diastolic pressure + 1/3 (pulse pressure)

## Question 44 of 54

4. A 60-year-old male presents to ED with the complaint of
scrotal pain and swelling, you suspect epididymo-orchitis,
and prescribe Quinolone. What is the mechanism of action
of Quinolone?
Quinolone interferes with the bacterial nucleic acid
synthesis
Acyclovir= inhibits bacterial DNA synthesis
(RECALL)
Aminoglycosides=inhibit bacterial protein synthesis
(bind bacterial 30s subunit) RECALL
Cephalosporin=bacterial cell wall synthesis inhibitor
chloramphenicol= inhibit bacterial protein synthesis
macrolides=inhibit protein synthesis (bind to the
bacterial 50s ribosomal subunit)
Metronidazole= bacterial nucleic acid synthesis
inhibitor (RECALL)
penicillin=inhibit bacterial cell wall synthesis
Tetracycline= inhibits bacterial protein synthesis
(binds to 30S subunit of ribosomes)
Trimethoprim=inhibit bacterial metabolism.

## Question 4 of 90

- **A.** Inhibition of bacterial protein synthesis
- **B.** Inhibition of bacterial metabolism
- **C.** Inhibition the bacterial cell wall synthesis
- **D.** Inhibition of bacterial cell membrane synthesis
- **E.** Inhibition of bacterial nucleic acid synthesis
8. First part of duodenum lies at which level of vertebral
level?
First part of the duodenum extends from the
pyloric sphincter of the stomach wraps around
head of pancreas in C-shaped and ends at
duodenojejunal flexure (Recall)
First part lies at vertebral level L1.
2nd part L2-L3
3rd part longest section crossing inferior vena cava
and Aorta at level L3

## Question 8 of 90

- **A.** T8
- **B.** L2
- **C.** T12
- **D.** T6
- **E.** L1

## Question 45 of 54

4th part: pass upward on left of abdominal Aorta at
L2

> [!TIP]
> **Clinical pearls: (High Yield)**
> Duodenal ulcer: erosion of the mucosa in the
> duodenum
> most likely to occur in the superior portion of the
> duodenum.

The most common causes of duodenal ulcers are
Helicobacter pylori infection and chronic NSAID
therapy.
Duodenal ulcer most likely erosion of the
gastroduodenal artery
14. A 21-year-old male patient brought into the ED after
road traffic collision. After initial assessment and imaging
showed damage to the L1 nerve root. Which of the
following muscles are most likely affected?

## Question 14 of 90

- **A.** Internal and external oblique
- **B.** Rectus abdominis and transverse abdominis
- **C.** External oblique and transversus abdominis
- **D.** Gluteus maximus and gluteus minimus
- **E.** Internal oblique and transversus abdominis
16. A 25-year-old male with history of dysphagia to solid
foods came with complaint of nausea and vomiting. The
esophagus passes through diaphragm at which vertebral
level?

## Question 16 of 90

- **A.** T8
- **B.** T12
- **C.** L2
- **D.** T11
- **E.** T10

## Question 46 of 54

23. A 7-year-old child is brought into the ED by his mother.
His mother states that child had wild berries then he
suddenly started to have tachycardia, dry skin and urinary
retention. What is the likely cause of this condition?
Atropa belladonna commonly known as deadly
nightshade is a perennial herbaceous plant with
leaves and berries that are extremely toxic contains
atropine and scopolamine both antagonist at
muscarinic receptor and block parasympathetic

## Question 23 of 90

- **A.** Increased parasympathetic response
- **B.** Sympathomimetic activity
- **C.** Hypnotic response of wild berries
- **D.** Cholinergic response
- **E.** Parasympathetic block
25. You are going to attempt carotid sinus massage in a
patient with SVT. You ask your colleague at which of the
following level you should apply pressure?
The carotid sinus is the reflex area of the carotid
artery consisting of baroreceptors which monitor
blood pressure. The carotid sinus is located at the
bifurcation of the common carotid artery, which is
found at the level of the thyroid cartilage and
medial to the sternocleidomastoid muscle

## Question 25 of 90

- **A.** Hyoid bone
- **B.** Thyrohyoid membrane
- **C.** Cricoid cartilage
- **D.** Temporomandibular joint
- **E.** Thyroid cartilage
36. Which of the following diet is a rich source of calcium?

## Question 36 of 90

## Question 47 of 54

Rcem key:  soyabean is a rich source of calcium
Note: Dairy products which include cheese, leafy
vegetables, and Soybean is rich in calcium.
Almond is also rich in calcium but if both almond
and cheese are in option choose dairy product
cheese because cheese has more calcium than
almond per 100gm.
- **A.** Broccoli
- **B.** Broccoli
- **C.** Tomato
- **D.** Sun flower
- **E.** Soyabean
42. A 23-year-old male presents to the ED with a complaint
of loss of sensation in the medial half of palm. Regarding
ulnar nerve receives its fibers from which of the following
nerve roots?
BRANCHES OF LATERAL CORD   "LML"
1.Lateral pectoral nerve
2.Musculocutaneous nerve
3.Lateral root of median nerve
BRANCHES OF MEDIAL CORD     "M4U"
1.Medial pectoral nerve
2.Medial cutaneous nerve of arm
3.Medial cutaneous nerve of forearm
4.Medial root of median nerve
5.Ulnar nerve
BRANCHES OF POSTERIOR CORD   "ULTRA"
1.Upper subscapular nerve
2.Lower subscapular nerve

## Question 42 of 90

- **A.** C6-C7
- **B.** C5-C6
- **C.** C7-C8
- **D.** C7-T1
- **E.** C8-T1

## Question 48 of 54

3.Thoracodorsal nerve
4.Radial nerve
5.Axillary nerve
Way to remember root value of upper limb
nerves
C3, C4: Supraclavicular nerve
C5, C6: Axillary nerve (RECALL)
C5, C6, C7: Musculocutaneous Nerve and long
thoracic nerve
C6, C7, C8: Thoracodorsal Nerve
C5, C6, C7, C8 and T1: Median and Radial Nerve
C8-T1: Ulnar nerve
43. You are teaching group of medical students in ED and
topic of discussion is blood supply of the heart. Which
structure is most likely affected by occlusion of right
coronary artery?
Cardiac blood supply:
1: The Right coronary artery supplies:
The right atrium and most of right ventricle
The sinoatrial and atrioventricular node
Posterior interventricular artery, also known as the
posterior descending artery (PDA), is a branch of the
right coronary artery supply posterior 1/3 of
interventricular septum and posterior aspect of
right and left ventricle. Most common artery
infracted in posterior wall MI
Note: Occlusion of right coronary artery can result
into ischemia of SA and AV node and
subsequently bradycardia or heart block (Recall)
2: The left coronary artery supplies via main
branches below:
Anterior interventricular branch (LAD)
LCX
High yield:

## Question 43 of 90

- **A.** Bundles of His
- **B.** Left atrium
- **C.** Interventricular septum
- **D.** Left ventricle
- **E.** SA node

## Question 49 of 54

Localization of lesion in ST elevation MI and
occluded coronary artery. Only remember
myocardial area and occluded coronary artery.
Easy to remember:
Septal and Anterior wall MI: LAD (Anterior
interventricular branch) occluded.
Lateral wall MI: LCX occluded.
49. A 30 years old male with a history of RTA was brought
into the ED with a complaint of irregular breathing. Which of
the following muscle is the accessory muscle of expiration?
Diaphragm: Normal quiet inspiration
Normal expiration: Passive recoil of lungs
Inspiration: External intercostal muscle
Expiration: Internal intercostal muscle
Accessory muscle of inspiration:
Sternocleidomastoid
Accessory muscle of expiration: Transversus
abdominal muscles
Forced expiration: Internal intercostal muscle and
rectus abdominus (RECALL)

## Question 49 of 90

- **A.** Sternocleidomastoid
- **B.** Internal intercostal muscle
- **C.** External intercostal muscle
- **D.** Diaphragm
- **E.** Transversus abdominus
52. A 50-year-old male known case of hypertension
presents to the ED with complaint of vertigo, ataxia, ptosis,
and miosis. Which of the following blood vessel is most
likely occluded?

## Question 52 of 90

## Question 50 of 54

Posterior inferior cerebellar artery occlusion result
in type of stroke called Lateral medullary syndrome
or Wallenberg''s syndrome characterized by variety
of symptoms which include:
Vertigo, vomiting, nystagmus
Crossed sensory disturbance
Ipsilateral Horner sign
Dysphagia, dysarthria
Ipsilateral ataxia
Occlusion of AICA is considered rare, but generally
results in a lateral pontine syndrome, also known as
AICA syndrome
- **A.** Middle cerebral artery
- **B.** Superior cerebral artery
- **C.** Anterior inferior cerebral artery
- **D.** Pontine artery
- **E.** Posterior inferior cerebral artery
60. A 40 years old male presents into the ED with a
complaint of being unable to move his jaw. You ask your
junior colleague to test the jaw reflex. If jaw reflex is lost
which of the following nerve is most likely injured?

## Question 60 of 90

- **A.** Opthalmic division of trigeminal nerve
- **B.** Vagus nerve
- **C.** Facial nerve
- **D.** Glossopharyngeal nerve
- **E.** Mandibular division of trigeminal nerve

## Question 51 of 54

69. Which one of the following muscles are flexor of thigh
at hip joint and flexor of leg at knee joint?
All the muscles of anterior compartment of thigh
are flexors of thigh at hip joint while Quadriceps
femoris (Rectus femoris, Vastus lateralis, Vastus
medialis and Vastus intermedius) is extensor of leg
at knee joint. Some exceptions are:
Sartorius is also flexor of leg at knee joint and lateral
rotator and abductor at hip joint
Rectus femoris is also flexor of thigh at hip joint
(RECALL)
Lateral rotators of hip: Anterior C.O.Thigh muscles
include Sartorius, iliacus and psoas major
Lateral rotators of hip: Muscles of the hip region
include Piriformis (RECALL), obturator internus and
externus, gamellus superior and inferior and
quadratus lumborum
Note: All the muscles of anterior compartment of
thigh are innervated by femoral nerve except psoas
major that is through lumbar plexus (RECALL)

## Question 69 of 90

- **A.** Pectineus
- **B.** Rectus femoris
- **C.** Psoas major
- **D.** Iliacus
- **E.** Sartorius
72. Regarding propranolol use in thyroid crises, which one
of the following is true?
Propranolol is used as short-term symptomatic
therapy till the effect of Carbimazole develops.

## Question 72 of 90

- **A.** To potentiate the effect of radioactive iodine
- **B.** In patients Carbimazole contraindicated
- **C.** In patients not responding to Carbimazole
- **D.** As long-term therapy after subtotal
thyroidectomy
- **E.** As short-term symptomatic therapy till effect of
Carbimazole develops

## Question 52 of 54

75. A 30 Years old presents into the ED with a complaint of
pain in his jaw radiating to his ear. Which of the following
nerve is most likely affected?
Note: Skin of ear lobule is innervated by greater
auricular nerve (Sensory branch from cervical
plexus) RECALL

## Question 75 of 90

- **A.** Supratrochlear nerve
- **B.** Facial nerve
- **C.** Buccal Nerve
- **D.** Inferior alveolar nerve
- **E.** Auriculotemporal Nerve
83. A 52-year-old male presents to ED complaining of
dizziness and discomfort. After initial assessment at triage
his heart rate is found to be 40-60 bpm regular rhythm.
ECG demonstrates a normal QRS complex with absent P
waves. Which part of the conducting system is most likely
acting as pacemaker in this patient?
Conductive Pathway of Heart:
SA node initiates the cardiac muscle (pacemaker) →
Internodal fibers and AV node (delay impulse
from the atria to ventricle) →  AV bundle branches
→  Purkinje fibers (from apex to ventricles).

## Question 83 of 90

- **A.** Bundle branches
- **B.** Bundle of His
- **C.** Sinoatrial node
- **D.** Purkinje fibers
- **E.** Atrioventricular node

## Question 53 of 54

0% Complete
Mark as Complete
Previous Next
The sinoatrial node (SAN) is the primary pacemaker
located in Right atrium. The SAN will normally
discharge at a rate of 60-100 bpm. If the impulse
generated in the Sa node is blocked, a group of cells
further down the heart will become its pacemaker.
The atrioventricular node (AVN) is the secondary
pacemaker located between right atrium and
ventricle near the atrial septum, and will normally
discharge at about 40-60 beats per minute
Purkinje fibers produce spontaneous action
potential at rate of 20-40 bpm.
87. Whilst in your cardiology rotation coronary angiography
of a 44-year-old male patient revealed an occlusion of the
circumflex branch of left coronary artery. This patient has
been suffering from myocardial infarction in which of the
following area?
Left coronary artery gives rise to two branches
The anterior interventricular branch: supply the
right and left ventricle, the apex and anterior two
third of interventricular septum.
Left circumflex branch: supplying the left atrium
and left ventricle
The right coronary artery supplies:
the right atrium and most of right ventricle
the sinoatrial and atrioventricular node

## Question 87 of 90

- **A.** Right and left ventricle
- **B.** Right and left atria
- **C.** Interventricular septum
- **D.** Apex of heart
- **E.** Left atrium and ventricle

## Question 54 of 54',
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
    "updated_at" = now();

  -- Lesson: Mock Ii - Paper Ii
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'mock-ii-paper-ii',
    'Mock Ii - Paper Ii',
    'article',
    '# Mock Ii - Paper Ii

> [!NOTE]
> **Instructions:** Single best answer scenario. Read carefully before reviewing the detailed rationale.

Mrcem Primary Complete Course ,High Yield Stuff and Questions Bank ( For Diet ii Late 2026)
Overview  Comments
Share your score colleagues

LinkedIn  Facebook  Twitter

## Question 20 of 90

1. A 32-year-old male presents to the ED with complain of
difficulty gripping objects in his right hand. On examination,
he had a weak grip strength in his right hand and was
unable to flex his index and middle fingers accompanied by
loss of opposition of thumb. Which one of the following
nerves is most likely injured?

## Question 1 of 90

- **A.** Median nerve
- **B.** Musculocutaneous nerve
- **C.** Brachial plexus
- **D.** Ulnar nerve
- **E.** Radial nerve
2.   A 43-year-old driver by profession presents to the ED
with seasonal allergies. Which of the following medications
would be most appropriate for the management of his
allergy symptoms?

## Question 2 of 90

- **A.** Doxylamine
- **B.** Fexofenadine

## Question 1 of 58

First generation H1 antihistamine are sedating and
is contraindicated in the treatment of pilots,
machine operator and drivers.
The non-sedating antihistamine include (Recall):
Fexofenadine, loratadine, Desloratadine, and
certizine
- **C.** Hydroxyzine
- **D.** Cyclizine
- **E.** Chlorphenamine
3. A 40-year-old male was playing basketball when he fell
and landed on his right shoulder. He experienced
immediate pain and had difficulty moving his arm. He was
taken to the emergency room, where an X-ray showed that
he had fractured the surgical neck of his right humerus. On
examination he has loss of sensation over inferior portion
of deltoid. Which one of the following muscles is likely to be
injured?
Axillary nerve injury is commonly caused
by fracture of surgical neck of humerus or inferior
dislocation of humerus.
Causes weak lateral rotation and abduction of the
arm. (Supraspinatus can abduct the arm but not to
a horizontal level).
Loss of sensation over the inferior portion of the
deltoid (the ‘regimental badge area’).
Quadrangular space: Axillary nerve and posterior
circumflex humeral artery and vein pass through it
and can be compressed as a result of trauma,
muscle hypertrophy resulting in weakness of deltoid
and teres minor.

## Question 3 of 90

- **A.** Teres minor
- **B.** Supraspinatus
- **C.** Subscapularis
- **D.** Biceps Bracchi
- **E.** Teres major
4. A 25-year-old professional tennis player presents to the
ED with complaint of loss of flexion and abduction at wrist.
She states that during a practice match, she falls and
injures her wrist. Which one of the following forearm
muscles is likely to be injured?

## Question 4 of 90

- **A.** Extensor carpi radialis muscle

## Question 2 of 58

Flexor carpi radialis muscle= Flexion and abduction
at wrist
Flexion carpi ulnaris muscle= Flexion and adduction
at wrist
Forearm muscles
Anterior forearm muscles superficial
compartment
- **B.** Flexor carpi ulnaris muscle
- **C.** Pronator teres muscle
- **D.** Flexor carpi radialis muscle
- **E.** Extensor digitorum muscle
5. A 35-year-old lady brought into the ED with history of
RTA. She has fractured right femur with significant blood
loss and in state of shock. What is the mechanism involving
her presentation of shock?
In response to hypovolemia, the body tries to
compensate by activating the sympathetic nervous
system. This leads to an increase in heart rate,
vasoconstriction (narrowing of blood vessels), and
the release of hormones such as adrenaline and
norepinephrine. These responses are intended to
maintain blood flow to vital organs such as the
brain and heart, but they can also cause peripheral
vasoconstriction, reduced blood flow to non-vital
organs, and decreased urine output. If the blood
loss continues, the body''s compensatory
mechanisms may become overwhelmed, and
shock can occur.

## Question 5 of 90

- **A.** Sympathetic inhibition
- **B.** Parasympathetic activation
- **C.** Sympathetic activation
- **D.** Cushing reaction
- **E.** Parasympathetic inhibition

## Question 3 of 58

7.  A 74-year-old man with a previous anaphylactic reaction
to amoxicillin has had symptoms and signs of pneumonia
with a CURB 65 score of 4. His blood cultures grew
mycoplasma pneumonia.
Which single antibiotic is most appropriate for this
patient??
CURB-65 Score is used for Severity assessment of
community acquired pneumonia (Recall)
Confusion (abbreviated mental test, AMT scores 8)
Urea (>7 mmol/L)
Respiratory rate (2 30/min)
Blood pressure (< 90 systolic or $ 60 diastolic)
65 (age ≥  65
Risk
Score 0 to 1 low risk
Score 2: Intermediate risk
Score 3 to 5: High risk
Loe severity CAP: Ist choice Amoxicillin
High severity CAP: Ist choice Co-Amoxiclav
Note: Clarithromycin is widely used alternative
treatment in patients with penicillin allergy

## Question 7 of 90

- **A.** : Clavulanic acid
- **B.** Ciprofloxacin
- **C.** Co amoxiclav
- **D.** Clarithromycin
- **E.** Meropenem
8. A 65-year-old man with a history of hypertension and
diabetes mellitus presents to the emergency room with
sudden onset right-sided weakness and facial droop. Upon
examination, the physician notes right-sided hemiparesis,
dysarthria, and neglect of the left side of his body. The
patient reports a severe headache and dizziness prior to
the onset of his symptoms. Which one of the following
vessels is most likely affected?

## Question 8 of 90

- **A.** Internal carotid artery (ICA)
- **B.** Basilar artery
- **C.** Anterior cerebral artery (ACA)

## Question 4 of 58

Based on the patient''s symptoms, the most likely
affected vessel is the Middle cerebral artery. The
MCA supplies blood to the lateral surface of the
brain, including the motor and sensory areas
responsible for movement and sensation on the
opposite side of the body. The patient''s right-sided
hemiparesis and neglect of the left side of his body
are consistent with an MCA infarct
More easy to remember:
ACA: Contralateral weakness in lower limb
MCA: Contralateral weakness in face/arm greater
than lower limb
- **D.** Middle cerebral artery (MCA)
- **E.** Posterior cerebral artery (PCA)
9. A 30-year-old female had bloody diarrhea 2 weeks ago.
Now she presents to the ED with complaint of joint pain,
mouth ulcers and brown raised plaques on palms and
soles. Reactive arthritis diagnosis was made. Which one of
the following organisms cause reactive arthritis?
Reactive arthritis (Reiter''s syndrome) is a triad of
urethritis, arthritis and conjunctivitis.

## Question 9 of 90

- **A.** Campylobacter jejuni
- **B.** Staphylococcus aureus
- **C.** Neisseria gonorrhea
- **D.** Pseudomonas aeruginosa
- **E.** Clostridium difficili

## Question 5 of 58

Organisms causing reactive arthritis: Chlamydia,
Salmonella, Campylobacter jejuni and Shigella
10. A 35-year-old patient who works as a mechanic
presents with complaints of numbness and tingling in the
ring finger and little finger of his right hand. On
examination, you suspect that he may have ulnar nerve
entrapment at Guyon''s canal. Which one of the following
carpal bone is most likely injured?
Fracture of both pisiform and hook of hamate can
result into entrapment of ulnar nerve in Guyon''s
canal
Ulnar canal (Guyon''s canal)
Transmits ulnar neurovascular bundle from forearm
into the hand.
Borders:
Medial (ulnar): pisiform, flexor carpi ulnaris tendon
Lateral (radial): hook of hamate.
Roof: palmar carpal ligament.
Floor: flexor retinaculum
Contents: Ulnar nerve and artery

> [!TIP]
> **Clinical Pearl:**
> Ulnar canal syndrome refers to compression of the
> ulnar nerve within the ulnar canal.

## Question 10 of 90

- **A.** Lunate
- **B.** Scaphoid
- **C.** Trapezoid
- **D.** Hook of hamate
- **E.** Capitate
11. During a routine physical examination, you perform
auscultation of the heart to listen to the sounds produced
by the valves. What is the area of auscultation of aortic
valve?
High yield:

## Question 11 of 90

- **A.** Second right intercostal space
- **B.** Left 5th intercostal space
- **C.** Apex of heart
- **D.** Right 5th intercostal space
- **E.** Second left intercostal space

## Question 6 of 58

Areas of auscultation of heart. Remember on
fingertips.
12. A 60-year-old male with a history of hypertension and
smoking presents to the emergency department with chest
pain. An ECG shows ST-segment elevation in the inferior
leads, and a diagnosis of acute myocardial infarction (MI) is
made. The infarcted tissue in the heart is likely to undergo
which type of necrosis?
Cell death:
High yield: Be familiar with all types and examples.

## Question 12 of 90

- **A.** Fat necrosis
- **B.** Liquefactive necrosis
- **C.** Caseous necrosis
- **D.** Coagulative necrosis
- **E.** Fibrinoid necrosis
13. Which part of the intestine becomes distended to
trigger the opening of the ileocecal valve, allowing the
contents of the small intestine to pass into the large
intestine?

## Question 13 of 90

- **A.** Cecum
- **B.** Jejunum

## Question 7 of 58

The ileocecal valve is located at the junction of the
ileum (last part of the small intestine) and the
cecum (first part of the large intestine). When the
ileum becomes distended, due to the accumulation
of digested food, it triggers the opening of the
ileocecal valve, allowing the contents of the small
intestine to pass into the large intestine
- **C.** Appendix
- **D.** Ileum
- **E.** Duodenum
14. A 30 years old laborer is brought into the ED by
Ambulance after falling approximately 6m on building site
and sustain head injury. His Gcs 5/15 early treatment given,
patient intubated stabilized and shifted to icu. After some
time, patient started to deteriorate again with uncontrolled
hypertension and bradycardia. Which one of the following
reflex leads to this condition?
Cushing reflex is physiological response to increase
intracranial pressure resulting in Cushing triad of:
Increased intracranial pressure
Increased blood pressure
Bradycardia

## Question 14 of 90

- **A.** Medullary reflex
- **B.** Autonomic reflex
- **C.** Cushing reflex
- **D.** Cortical reflex
- **E.** Baroreceptor reflex

## Question 8 of 58

15. A 30-year-old farmer has sustained a deep laceration to
the popliteal fossa. During examination your consultant ask
what anatomical structure makes the upper lateral
boundary of the popliteal fossa?
Boundaries and contents of
popliteal fossa

## Question 15 of 90

- **A.** Tibial collateral ligament
- **B.** Lateral epicondyle of the femur
- **C.** Biceps femoris muscle
- **D.** Lateral head of the gastrocnemius muscle
- **E.** Popliteus muscle
16. A 6o years old lady was brought into the ED with
fracture of right hip. Which of the following is the primary
cause of postmenopausal fractures?
Postmenopausal fractures are often caused by
osteoporosis, which is a condition characterized by
decreased bone density and increased bone
fragility. During menopause, there is a decrease in
estrogen production, which can lead to
accelerated bone loss and increased risk of
fractures. Other factors that can contribute to
postmenopausal fractures include age, genetics,
nutrition, physical inactivity, smoking, and certain
medical conditions or medications that can affect
bone health.

## Question 16 of 90

- **A.** Decreased estrogen production
- **B.** Increased bone strength
- **C.** Increased bone density
- **D.** Excessive physical activity
- **E.** Increased estrogen production

## Question 9 of 58

Note: Choose hormonal imbalance option if
question stem is different from this and no other
character of osteoporosis is matched in options.
18. A 14 years old male brought into the ED with complaint
of fever and neck rigidity. You suspect meningitis, what are
the typical CSF changes in meningitis?
Normal CSF glucose is less and 60% of the level of
serum glucose
Glucose is more than half of blood glucose (Normal)
in viral meningitis. In bacterial and TB meningitis
CSF to serum glucose ratio falls
Tuberculous meningitis has more mononuclear cells
than polymorphs in CSF. Predominant cells in viral
and TB meningitis are Lymphocytes while
predominant cells in bacterial meningitis are
Neutrophils
In bacterial meningitis CSF protein is raised to 0.5–
2.0 g/L.)
CSF is clear in viral meningitis and CSF is turbid in
bacterial meningitis

## Question 18 of 90

- **A.** CSF can appear turbid in Viral meningitis
- **B.** Tuberculous meningitis has more polymorphs
than mononuclear cells in CSF
- **C.** CSF can appear clear in viral meningitis
- **D.** Glucose is less than half of blood glucose in viral
meningitis
- **E.** In bacterial meningitis the CSF protein is 0.4 g/L
20. A mother brought his five years old son into the ED with
a complaint of hematemesis after swallowing a button
battery. CT scan shows its stuck at T10. Which vessel has
been damaged and bleeding?
When a button battery is swallowed and becomes
lodged in the esophagus or stomach, it can erode

## Question 20 of 90

- **A.** Inferior mesenteric artery
- **B.** Left gastric artery
- **C.** Splenic artery
- **D.** Right gastric artery
- **E.** Gastroduodenal artery

## Question 10 of 58

through the tissue and cause a perforation or fistula
to form. In children, this is most seen at the site of
the left gastroesophageal junction, which is the
point where the esophagus meets the stomach on
the left side. The left gastric artery is a branch of the
celiac artery that supplies blood to the stomach
and is located in this area. If the battery erodes
through the tissue and into the left gastric artery, it
can cause life-threatening bleeding.
Oesophageal constrictions
The anatomical relations of the oesophagus give
rise to four constrictions, where food/foreign
objects are most likely to become impacted.
Oesophageal constrictions should not be confused
with pathological constrictions.
Cervical constriction: due to cricoid cartilage at the
level of C5/6
Thoracic constriction: due to aortic arch at the level
of T4/5
Abdominal constriction: at oesophageal hiatus at
T10/11 vertebral
High yield:
Peptic ulcer:
Bleeding gastric ulcer = Left gastric artery (Recall)
Bleeding duodenal ulcer = Gastroduodenal artery
(Recall)
21. Which of the following best describes the mechanism of
action of botulinum toxin?

## Question 21 of 90

- **A.** It inhibits the breakdown of acetylcholine,
prolonging muscle contraction.
- **B.** It promotes the production of acetylcholine,
causing sustained muscle contraction.

## Question 11 of 58

Botulinum toxin blocks the release of acetylcholine
from nerve endings at the neuromuscular junction
(Recall), leading to muscle paralysis.
- **C.** It blocks the release of acetylcholine, leading to
muscle paralysis
- **D.** It enhances the release of acetylcholine, leading
to increased muscle contraction
- **E.** It binds to acetylcholine receptors on muscle
cells, preventing muscle relaxation.
22. A 25 years old pregnant lady presents to the ED with
complaint of nausea, vomiting, pelvic cramps and spotting.
She gives history of taking doxycycline prescribed by her
GP. Which of the following is common side effect of
doxycycline use in pregnancy?
Intake of tetracycline (Doxycycline) by pregnant
women results in the discoloration and deformity of
teeth in the fetus. It can also produce impairment
of bone growth. tetracyclines are also
contraindicated in children less than 10 years
Note:
Doxycycline is used for malaria prophylaxis
(Recall)
Lithium can cause fetal goiter and cardiac
abnormalities. (Recall)

## Question 22 of 90

- **A.** Neural tube defect
- **B.** Cardiac defect
- **C.** Congenital goiter
- **D.** Tooth discoloration
- **E.** CNS malformation
23. A 35-year-old construction worker reports pain and
swelling in the anatomical snuff box of his right hand after
falling off a ladder and landing on his outstretched hand.
You suspect injury of structures in anatomical snuff box.
The medial border of the snuff box is formed by the tendon
of which muscle?

## Question 23 of 90

- **A.** Extensor pollicis longus
- **B.** Flexor pollicis longus
- **C.** Abductor pollicis longus

## Question 12 of 58

Anatomical snuffbox
is a triangular depression found on the lateral
aspect of the dorsum of the hand. It is best seen
when the thumb is extended.

> [!TIP]
> **Clinical Pearl:**
> Fracture of scaphoid bone: Falling on outstretched
> hand. The scaphoid bone of the hand is the most
> commonly fractured carpal bone
> Clinical feature: Pain and tenderness in the
> anatomical snuffbox.

- **D.** Flexor pollicis brevis
- **E.** Opponent pollicis
24. A 27-year-old runner is out for her morning jog when
she steps on a rock and her left foot suddenly twists inward
and she also sustained a lateral malleolus tear. Which one
of the following ligaments is commonly torn in this injury?
Inversion injury along with tear of lateral
malleolus, tear of ATFL > CFL> PTFL
Ankle ligaments
Eversion injury = medial ligament or medial deltoid
ligament injury associated with tear of medial
malleolus most commonly
inversion injury= Lateral collateral ligament injured
(subdivided into 3 ligaments) most frequent
ligament injury during ankle sprain or inversion
injury commonly affected ligament is Anterior
talofibular ligament followed by calcaneofibular
ligament (both are ligaments of lateral collateral
ligament) associated with tear of lateral malleolus
most commonly

## Question 24 of 90

- **A.** Posterior talofibular ligament (PTFL)
- **B.** Calcaneofibular ligament (CFL)
- **C.** Deltoid ligament
- **D.** Anterior talofibular ligament (ATFL)
- **E.** Syndesmotic ligament

## Question 13 of 58

Least injured during inversion injury post
talofibular ligament
The spring ligament (plantar calcaneonavicular
ligament) is a broad thick ligament that extends
from the calcaneus to the navicular bone. It
supports the head of the talus, maintaining the
stability of the talocalcaneonavicular joint and
resists depression of the medial arch of the foot.
The spring ligament takes the weight of the body
from the talus and transmits it to the forefoot.
25. A 60-year-old man presents to ED complaining of
difficulty passing urine and nocturia. On examination, you
note the prostate is enlarged and you suspect BPH. Which
of the following lobes of the prostate are most likely
hypertrophied:
Prostate gland is largest accessory gland of the
male reproductive system. Histologically divided
into three zones
1: Central zone: surrounds the ejaculatory ducts
2: Transitional zone: centrally and surrounds the
urethra. The glands of the transitional zone are
those that typically undergo hyperplasia (BPH) also
median lobe of prostate most hypertrophied in
BPH.
3: Peripheral zone: makes up the main body of the
gland and is located posteriorly. High incidence of
prostatic carcinoma. This is zone palpated on PR
examination.

## Question 25 of 90

- **A.** Peripheral zone
- **B.** Median lobe
- **C.** Lateral lobe
- **D.** Anterior lobe
- **E.** Posterior lobe
26. A 55-year-old man is admitted to the emergency
department with acute respiratory distress. His oxygen
saturation is low, and he is struggling to breathe. The
medical team determines that the patient requires
intubation to secure his airway and provide mechanical
ventilation. Before intubation, the team prepares to
preoxygenate the patient to minimize the risk of hypoxemia
during the procedure. Regarding preoxygenation for
intubation, which lung volume needs to be replaced with
oxygen?

## Question 26 of 90

## Question 14 of 58

During preoxygenation for intubation, the
functional residual capacity (FRC) of the lungs
needs to be replaced with oxygen. The FRC is the
volume of air that remains in the lungs at the end of
a normal exhalation. During preoxygenation, the
goal is to fill the patient''s lungs with oxygen-rich air
to increase the amount of oxygen available in the
body before intubation and to prevent hypoxemia
(low oxygen levels in the blood) during the
procedure.
By taking deep breaths and exhaling slowly, the
patient can increase the amount of air they have in
their lungs at end-expiration, which maximizes the
FRC. When the patient is breathing 100% oxygen,
this oxygen-rich air replaces the air in the lungs and
maximizes the oxygen reservoir available for the
patient. Replacing the FRC with oxygen ensures
that the patient has adequate oxygen reserves to
prevent hypoxemia and allow for safe intubation.
Intubation in the supine position can lead to a
decrease in functional residual capacity (Recall)
- **A.** Functional residual capacity (FRC)
- **B.** Inspiratory reserve volume (IRV)
- **C.** Residual volume (RV)
- **D.** Total lung capacity (TLC)
- **E.** Expiratory reserve volume (ERV)
27. A 55 years old male known case of benign prostatic
hyperplasia presents into the ED with complaint of urinary
retention. He was prescribed doxazosin for urinary
retention, drug given act on which receptor?
Doxazosin is an Alpha 1 adrenoreceptor blocker. It
relieves the symptoms of urinary retention
Note: Anti-muscarinic drugs cause urinary
retention, dry mouth, pupil dilation and
constipation (Recall)

## Question 27 of 90

- **A.** Anticholinesterase
- **B.** dopamine
- **C.** Alpha 1 adrenoreceptor blocker
- **D.** Acetylcholine
- **E.** Anti muscarinic

## Question 15 of 58

29. A 22-year-old male presents to the ED with complaint of
pain in his fingers, while assessing movements you
suspect loss of extension of distal interphalangeal joint, DIP
joint injury causes?

## Question 29 of 90

- **A.** Metacarpo-phalangeal joint subluxation
- **B.** Boutonniere deformity
- **C.** Carpal tunnel syndrome
- **D.** Mallet finger
- **E.** Z-Deformity
30. A 60-year-old diabetic patient presents to the ED with
complaints of increased thirst, frequent urination, and
fatigue. Lab results reveal elevated blood glucose levels
and the presence of glucose in the patient''s urine. Which
part of the kidney reabsorbs maximal glucose?
Maximal glucose reabsorption occurs in proximal
convoluted tubule.

## Question 30 of 90

- **A.** Proximal convoluted tubule
- **B.** Collecting duct
- **C.** : Renal papilla
- **D.** Distal convoluted tubule
- **E.** Loop of Henle
31. A 27 years old male patient diagnosed and treated for
hepatitis B. In hep-B infection, which one of the following
serology reports you will see?

## Question 31 of 90

- **A.** Anti HBs
- **B.** HbsAg+ and HbeAg+ve
- **C.** HbsAg+ and HbeAg-ve

## Question 16 of 58

Acute hepatitis B
HBsAg +Ve, HBeAg +Ve, anti-
HBc IgM
Chronic hepatitis B
HBsAg +Ve, HBeAg +Ve, anti-
HBc IgG
Immunity following
infection
Anti-HBs, anti-HBe, anti-HBc
IgG
Immunity due to
vaccination
Anti-HBs
- **D.** Anti-HBs, anti-HBe
- **E.** HbeAg+ and HbeAb-ve
32. A 55-year-old man with a history of hypertension and
high cholesterol presents to the emergency room with
complaints of chest pain and shortness of breath. Upon
examination, the physician notes ST segment elevation in
leads V4-V6 of the electrocardiogram. The patient is
diagnosed with a myocardial infarction (MI) of the lateral
wall of the heart. Further tests confirm the occlusion of
which artery?
Easy to remember:
Septal and Anterior wall MI: LAD (Anterior
interventricular branch) occluded.
Lateral wall MI: LCX occluded.
Cardiac blood supply:
1: The Right coronary artery supplies:
The right atrium and most of right ventricle
The sinoatrial and atrioventricular node
Posterior interventricular artery, also known as the
posterior descending artery (PDA), is a branch of the
right coronary artery supply posterior 1/3 of
interventricular septum and posterior aspect of
right and left ventricle. Most common artery
infracted in posterior wall MI
Note: Occlusion of right coronary artery can result
into ischemia of SA and AV node and
subsequently bradycardia or heart block
2: The left coronary artery supplies via main
branches below:
Anterior interventricular branch (LAD)

## Question 32 of 90

- **A.** Circumflex artery (LCX)
- **B.** Left anterior descending artery (LAD)
- **C.** Right coronary artery (RCA)
- **D.** Posterior descending artery (PDA)
- **E.** Left main coronary artery (LMCA)

## Question 17 of 58

LCX
34. What is the main mechanism of action of diltiazem?
Diltiazem and verapamil are non-dipyridamole
calcium channel blocker
FDA-approved Indications of diltiazem
Atrial arrhythmia, including atrial fibrillation with
the rapid ventricular rate (RVR)
Hypertension
Paroxysmal supraventricular tachycardia
Chronic stable angina
Angina Due to Coronary Artery Spasm( Prinzmetal''s
angina)
Dihydropyridine calcium channel blockers include
amlodipine, felodipine and nifedipine

## Question 34 of 90

- **A.** Opens the Na+channel
- **B.** Blocks Ca+ channels
- **C.** Close the K+ channels
- **D.** Blocks the Na+ channel
- **E.** Opens the Ca+ channels
35. Which one of the following feedback mechanisms is
involved in the release of oxytocin from the posterior gland
during childbirth and labor?
Positive feedback:
Promotes changes in one direction leading
amplified effect. Cause vicious cycle and death,
sometimes it can be useful.
Examples:

## Question 35 of 90

- **A.** Negative feedback mechanism
- **B.** Neutral feedback mechanism
- **C.** Direct feedback mechanism
- **D.** Positive feedback mechanism
- **E.** Indirect feedback mechanism

## Question 18 of 58

Childbirth (During labor): The release of oxytocin
from the posterior gland during childbirth and
labor
Blood clotting.
Generation of nerve signals.
Sensation of needing to urinate.
Follicular phase of menstrual cycle
Negative feedback:
Components: Regulated variable, Sensor, Controller,
and Effector.
A regulated variable is sensed, information is fed
back to the controller, and the effector acts to
oppose change (hence the term negative) Control
most systems of body."
Examples: Osmoregulation, regulation of blood,
pressure, temperature regulation, regulation of CO2
in ECF.
36. A 47-year-old gardener has accidentally stabbed his
right foot with a garden fork while working in sandals. He
tells you that he had a full course of vaccinations as a child.
wound is contaminated with manure. What would you
advise him regarding tetanus prophylaxis?
Wound contaminated with soil, manure is high risk
wound. This patient is up to date with
immunisation and more than 10 years are passed
following last dose. He requires immediate
reinforcing of both tetanus immunoglobulin and
vaccine at different sites. Tetanus priming dose are
given at 2,3,4, preschool booster (4 years and 3
months) and then booster dose after every 10 years.
Tetanus prone wound
Clean wounds are defined as: wounds less than 6
hours old, non-penetrating with negligible tissue
damage.
Tetanus-prone wounds include puncture-type
injuries acquired in a contaminated environment
and likely therefore to contain tetanus spores e.g.,
gardening injuries, compound fractures, wounds or

## Question 36 of 90

- **A.** He should have a tetanus booster and human
tetanus immunoglobulin in the same site
- **B.** There is no need for any treatment as he is fully
vaccinated
- **C.** He should have his tetanus antibodies checked
before deciding on a booster
- **D.** He should have a tetanus booster in his left arm
and human tetanus immunoglobulin in his right arm
- **E.** He should have a tetanus booster

## Question 19 of 58

burns with systemic sepsis and certain animal bites
and scratches.
High risk tetanus-prone wound: Heavy
contamination with material likely to contain
tetanus spores e.g., soil, manure, wounds or burns
that show extensive devitalised tissue and wounds
or burns that require surgical intervention that is
delayed for more than six hours are high risk even if
the contamination was not initially heavy.
39. A 26-year-old male returns home from a holiday and
complains of three days of dysuria and a purulent urethral
discharge. He is diagnosed to be a case of gonorrhea.
Which of the following is the appropriate treatment?
Neisseria gonorrhoeae causes urethritis in 1st week
(3-4 days) post exposure and unprotected sex while
Chlamydia trachomatis causes urethritis after 2-3
weeks post exposure and unprotected sex
Gonorrhoea is usually treated with a single
antibiotic injection (usually in the buttocks or
thigh). With effective treatment, most of your
symptoms should improve within a few days.
First line IM Ceftriaxone 500mg single dose.

## Question 39 of 90

- **A.** Ceftriaxone IM
- **B.** Clarithromycin
- **C.** Gentamicin
- **D.** Vancomycin IV
- **E.** Streptomycin

## Question 20 of 58

41. A 32-year-old presents to the ED with complaint of
cough with sputum, fever, and night sweats for 1 month. On
examination, there is hilar lymphadenopathy. Regarding
features of Active TB accompanied with which one of the
following features?
In the case of active pulmonary TB, a patient can
have crepitations, and bronchial breath sounds, and
specially over upper lobes cavitations or
consolidations
The Mantoux test is a widely used test for latent
TB (Recall): It involves injecting a small amount of a
substance called PPD tuberculin into the skin of
your forearm. It''s also called the tuberculin skin test
(TST).

## Question 41 of 90

- **A.** Fibrotic lung
- **B.** ZN staining negative
- **C.** Positive Mantoux test
- **D.** X-Ray cavitations
- **E.** Usually lower lobe consolidation on X-Ray
42. A 40 years old male presents to the ED with complaint
of lacerated wound on medial compartment of thigh, on
examination he is unable to perform extension and medial
rotation. Which one of the following muscles is most likely
injured?
EXP: All the muscles of medial compartment of
thigh are innervated by obturator nerve except
hamstring portion of adductor magnus.

## Question 42 of 90

- **A.** Adductor magnus
- **B.** Gracilis
- **C.** Obturator externus
- **D.** Adductor longus
- **E.** Adductor brevis

## Question 21 of 58

Adductor
magnus
Adduction and
medial rotation at
hip
Hamstring part:
Adduction and
extension of thigh
at hip
Adductor part:
Obturator nerve
Hamstring part:
Sciatic nerve
(tibial division)
Recall
43. Whilst in your surgical rotation your consultant performs
appendectomy. What is the most common site for the
appendix found at appendicectomy?
The most common position of the appendix overall
is retrocecal, followed by pelvic type.
Note: Pus from ruptured appendix accumulate in
right subphrenic space (Recall)

## Question 43 of 90

- **A.** Below terminal ileum overlying psoas
- **B.** Retrocecal
- **C.** Anterior to terminal ileum
- **D.** Retro-ileal
- **E.** Pelvic
44. 20 weeks pregnant Lady presents to the ED with
herpetic rash. You plan to give iv acyclovir, what is the
mechanism of action of acyclovir?
Acyclovir acts to inhibit viral synthesis of DNA
High yield:
Regarding antibiotics:
1: Protein synthesis inhibitor
Aminoglycosides
Macrolides
Chloramphenicol

## Question 44 of 90

- **A.** Viral RNA synthesis inhibitor
- **B.** Viral protein synthesis inhibitor
- **C.** viral DNA synthesis inhibitor
- **D.** Bacterial cell wall inhibitor
- **E.** Bacterial DNA synthesis inhibitor

## Question 22 of 58

Tetracycline
2: Nucleic acid Synthesis inhibitor
Metronidazole
Quinolones
3: Cell wall inhibitor
B lactam antibiotics
45. A 45-year-old male patient presents to the emergency
department with shortness of breath (SOB) and a normal
alveolar-arterial (A-a) gradient. Regarding (A-a) gradient
which one of the following diseases can present with it?
A-a gradient
Difference between alveolar Po2 and arterial Po2
A-a gradient: PA02-Pao2 (where PA02 alveolar po2
and Pao2 is arterial po2)
The A-a gradient is used to determine whether O2
has equilibrated between alveolar gas and arterial
blood and helps determine causes of hypoxemia.
The normal A-a gradient is between 0- and 10mm
Hg. Since O2 normally equilibrates between alveolar
gas and arterial blood, PAo2 is approximately equal
to Pao2. g., Hypoventilation: CNS depression,
neuromuscular disease (including myasthenia
gravis and kyphoscoliosis), Obesity and Low
inspired fio2 on high altitude
The A-a gradient is increased (>10 mm Hg) if O2
does not equilibrate between alveolar gas and
arterial blood (e.g., diffusion defect, V/Q defect,
and right-to-left shunt) and PAo2 is greater than
Pao ₂

## Question 45 of 90

- **A.** Pneumonia
- **B.** COPD
- **C.** Myasthenia gravis
- **D.** Pulmonary emboli
- **E.** Asthma
46. A 24-year-old man is stabbed in the abdomen with a
kitchen knife. A CT demonstrates a diaphragmatic injury
involving the esophageal hiatus.
Which structure is most likely to be damaged?

## Question 46 of 90

- **A.** Inferior vena cava
- **B.** Azygos vein

## Question 23 of 58

- **C.** Vagus nerve
- **D.** Thoracic duct
- **E.** Aorta
47. A 40-year-old diabetic patient is brought to the
emergency department with symptoms of hypoglycemia,
including sweating, confusion, and lethargy. The team
administers a dose of glucagon to the patient to help raise
their blood glucose levels and his symptoms resolved.
What is the action of glucagon in hypoglycemia?
Glucagon acts by binding to specific receptors on
liver cells (Recall), which activates an enzyme called
glycogen phosphorylase. This enzyme catalyzes the
breakdown of glycogen into glucose, which is then
released into the bloodstream. In the case of
hypoglycemia, glucagon stimulates the liver to
break down its stored glycogen and release glucose
into the bloodstream, which helps to raise the
patient''s blood sugar levels.

## Question 47 of 90

- **A.** Glucogenolysis
- **B.** Gluconeogenesis
- **C.** Glycogenolysis
- **D.** Inhibition of insulin secretion
- **E.** Glycogenesis
48. You see a 32-year-old woman in the resuscitation room
who has presented with tachyarrhythmia. You decide to
perform carotid sinus massage. At what level in the neck is
the carotid sinus most likely to be found?

## Question 48 of 90

- **A.** hyoid bone
- **B.** cricothyroid membrane
- **C.** inferior border of 5th cervical vertebra
- **D.** superior border of thyroid cartilage

## Question 24 of 58

Carotid Sinus Massage is a Vagal maneuver
transiently increase the arterial pressure in the
carotid sinuses and aortic arch. This action triggers
the baroreceptor reflex, which results in increased
parasympathetic output to the heart via the vagus
nerve and lowers the heart rate.
The carotid sinus Is located at the superior border
of the thyroid cartilage, medial to the
sternocleidomastoid muscle.
- **E.** superior border of cricoid cartilage
50. A 50 years old female known case of inflammatory
bowel disease presents to the ED with complaint of pain in
right lower quadrant and bloody diarrhea. Regarding
management of I.B.D which one of the following treatment
options is best given initially?
A stepwise approach that is used for IBD
management is outlined below.
The first step in pharmacologic therapy for IBD is
aminosalicylates (Mesalazine)  If the patient does
not respond to an appropriate dose of
aminosalicylates, the second step is the addition of
corticosteroids, which tend to result in a significant
decrease in inflammation. Once the response is
seen, the dose can be tapered
For those with mild to moderate disease limited to
the rectum, aminosalicylate agents like
mesalamine are the mainstay of treatment and are
best given rectally

## Question 50 of 90

- **A.** Oral azathioprine
- **B.** Hydrocortisone IV
- **C.** Rectal prednisolone
- **D.** Rectal mesalazine
- **E.** Oral prednisolone
51. A 55--year--old male presents to the ED with complaint
of shortness of breath. He is known case of asthma. Which
of the following results would you expect to find on
spirometry?

## Question 51 of 90

- **A.** Low FEV1/FVC ratio
- **B.** Increased FEV1
- **C.** Low TLC

## Question 25 of 58

Obstructive lung disease like (Asthma and COPD):
Low FEV1/FVC ratio
Restrictive lung disease: High FEV1/FVC ratio
Note: Be familiar with all the spirometry findings in
obstructive and restrictive lung disease.
- **D.** Increased FEV1 /FVC ratio
- **E.** High FVC
52. Paramedic brought a man into the ED who suffered a
traumatic brain injury. Among other areas, his
hypothalamus was damaged due to the impact of the
collision. Hypothalamic injury leads to increase in which
one of the following hormones?

An Injury to the hypothalamus can cause an increase
in prolactin levels. Prolactin is a hormone that is
primarily produced by the pituitary gland, but its
release is controlled by the hypothalamus.
The hypothalamus produces a hormone called
dopamine, which inhibits the release of prolactin
from the pituitary gland. If the hypothalamus is
injured, it may not produce enough dopamine,
leading to an increase in prolactin levels. This

## Question 52 of 90

- **A.** ACTH
- **B.** LH
- **C.** TSH
- **D.** Prolactin
- **E.** FSH

## Question 26 of 58

condition is known as hyperprolactinemia, and it can
cause a range of symptoms, including irregular
periods, breast milk production (even in non-
pregnant or non-nursing women), decreased sex
drive, and erectile dysfunction in men. In severe
cases, it can also cause infertility and osteoporosis.
53. A 10-year-old child was brought into the ED following
head trauma with complaint of hydrocephalus. Imaging
resulted in swelling of one lateral ventricle which of the
following is the most likely site of blockage
The flow of CSF Useful Mnemonic
Little Infants Try Crying for Food. Sub arachnoid
space
Lateral ventricle
Interventricular foramina of (Monro)
Third ventricle
Cerebral aqueduct
Forth ventricle
Foramina of Luschka
Sub arachnoid space
Note: From subarachnoid space CSF is reabsorbed
by arachnoid granulations (Recall) back into the
circulation

## Question 53 of 90

- **A.** Foramen Monro
- **B.** Subarachnoid space
- **C.** Foramen Luska
- **D.** Sub arachnoid cisterns
- **E.** Aqueduct of Sylvius
55. Β-blocker was prescribed for hypertension in a female
asthma patient. After about a week of treatment, the
asthma attacks got worse, and the patient was asked to
stop taking the β-blocker. Which of the following β-blockers
would you suggest as an alternative in this patient that is
less likely to worsen her asthma?

## Question 55 of 90

- **A.** Carvedilol
- **B.** Labetalol
- **C.** Atenolol
- **D.** Sotalol

## Question 27 of 58

Beta-blockers antagonize catecholamine-induced
increases in heart rate, reduce blood pressure and
improve left ventricular function, producing proven
clinical benefits in people with cardiovascular
disease but blocking airway β 2-receptors can cause
severe and sometimes fatal bronchoconstriction in
people with asthma, although cardio selective β 1-
blockers may be safer than non-selective
The cardio-selective beta-blockers include atenolol,
Bisoprolol, Esmolol, Acebutolol, Metoprolol, and
Nebivolol.
- **E.** Propranolol
56. Regarding the movements of extrinsic muscles of
shoulder joint, which one of the following muscles performs
adduction and internal rotation?
Extrinsic muscles of shoulder Joint:

> [!TIP]
> **Clinical pearl: Ask the patient to shrug his/her**
> shoulder if the patient is unable to do this indicates
> spinal accessory nerve injury and paralysis of
> trapezius muscle

## Question 56 of 90

- **A.** Rhomboid major
- **B.** Rhomboid minor
- **C.** Latissimus dorsi
- **D.** Levator scapulae
- **E.** Pectoralis minor

## Question 28 of 58

57. You are required to perform procedural sedation in a
patient who require ketamine. Which of the following are
among the most common adverse effects associated with
ketamine?

Ketamine is an anesthetic, used to induce loss of
consciousness. Ketamine is NMDA receptor
antagonist Psychosis and tachycardia are among
the most common adverse events associated with
ketamine.
Contraindications: Head trauma, Raised intracranial
pressure and hypertension

## Question 57 of 90

- **A.** Hyponatremia
- **B.** Hyperkalemia
- **C.** Hypotension
- **D.** Tachycardia
- **E.** Bradycardia
58. A 15-year-old girl is found to be hyperglycemic. Urine
testing reveals glucose. This urinalysis result is most likely
to be due to what process in the carrier protein of proximal
tubule?

## Question 58 of 90

- **A.** . Activation
- **B.** Saturation
- **C.** Destruction
- **D.** . Inborn error of metabolism
- **E.** Inhibition

## Question 29 of 58

The renal tubule plays a significant role in glucose
reabsorption. If the plasma glucose rises, renal
tubular reabsorption of glucose will increase
linearly until it reaches its maximum tubular
resorptive capacity. The capacity of the proximal
tubule to reabsorb glucose to prevent its passing to
the urine is known as the renal threshold. At
threshold, the system becomes saturated and the
maximal reabsorption rate, the glucose transport
maximum is reached and no more glucose can be
absorbed. Due to increase in plasma glucose, the
filtered glucose exceeds the capacity of the tubular
system and the kidneys begin excreting it in the
urine, the beginning of glycosuria
59. A 36 years old male sustained trauma to his right foot
and presents to the ED with infected wound. Which one of
the following local factors impede wound healing?
Wound healing is impaired by a poor blood supply
to the wound and a poor venous drainage from the
wound. Increased skin tension caused by tight
sutures and the presence of infection, foreign
bodies and necrotic tissue are other local factors
that impede healing.

## Question 59 of 90

- **A.** Decreased local mobility
- **B.** The presence of necrotic tissue
- **C.** Damage to the sensory nerves around the
wound
- **D.** Increased blood supply
- **E.** Decreased skin tension
60. You are called to attend to a patient with blood glucose
of 2.0 mmol/L. He is conscious and alert. What is the most
appropriate initial treatment?

## Question 60 of 90

- **A.** 1 mg subcutaneous glucagon
- **B.** Intravenous 10% glucose infusion at rate of 100
ml/h
- **C.** 15-20 g glucose orally
- **D.** Intravenous 20% glucose infusion at rate of 100
ml/hr
- **E.** 1 mg intramuscular glucagon

## Question 30 of 58

In adults who are conscious, cooperative and can
swallow: Give 15 - 20 g quick acting carbohydrate of
the patient''s choice where possible e.g., 90 - 120 mL
of Lucozade or 5-7 Dextrosol tablets • Repeat
capillary blood glucose 10 - 15 minutes later. If blood
glucose is still < 4.0 mmol/L, repeat step 1 (no more
than 3 treatments in total) • If blood glucose remains
< 4.0 mmol/L after 45 minutes or 3 cycles, consider 1
mg glucagon IM OR IV 10% glucose infusion at
100ml/hr
Note: If the patient is unconscious and no iv line is
accessed first choice would be im glucagon and in
question iv line accessed then choose IV 10%
glucose.
62. A 24-year-old man self presents to ED following a fight
in a nearby street. He has sustained multiple stab wounds
and laceration medial compartment of thigh. Which one of
the following nerves is most likely injured in
adductor canal?
The adductor canal serves as a passageway for
structures moving between the anterior thigh and
posterior leg.
It transmits the femoral artery, femoral vein
(posterior to the artery), nerve to the vastus
medialis and the saphenous nerve – the largest
cutaneous branch of the femoral nerve.

## Question 62 of 90

- **A.** Femoral nerve
- **B.** Saphenous nerve
- **C.** Obturator nerve
- **D.** Sciatic nerve
- **E.** Tibial nerve
63. What type of immunity is provided by intravenous (IV)
administration of immunoglobulin G?

## Question 63 of 90

- **A.** Cell mediated
- **B.** . Humoral
- **C.** Passive
- **D.** . Active
- **E.** Both humoral and cell mediated

## Question 31 of 58

Intravenous administration of immunoglobulin
provides the patient with passive immunity.
Cellular(cell-mediated) immune response acts
directly to destroy pathogens without using
antibodies but instead fights infection from
macrophages that kills pathogens. The humoral
immune response (or antibody-mediated response)
protects the body by circulating antibodies to fight
against pathogens (e.g., bacteria).
Passive immunity occurs when antibodies are
transferred by antibodies from an immune host,
such as from a placenta to a fetus. Passive
immunity is short lived. Active immunity is longer
lived and comes from the host itself.
64. The following anti-tubercular drug is a potent CYP450
enzyme inducer?
Rifampin is a potent inducer of cytochrome P450
enzymes
Side effects of Anti TB drugs:
1: Rifampicin: Orange-red discoloration of body
fluids, Hepatitis
2: Isoniazid: Hepatitis, Peripheral neuritis
3: Pyrazinamide: Hepatotoxicity, Hyperuricemia
4: Ethambutol: Optic neuritis, Red-green color
blindness

## Question 64 of 90

- **A.** Pyrazinamide
- **B.** Rifampicin
- **C.** Isoniazid
- **D.** Streptomycin
- **E.** Ethambutol

## Question 32 of 58

5: Streptomycin: ototoxicity, Nephrotoxicity, and
contraindicated in pregnancy
65. A 22-year-old professional marathon runner presents
with shortness of breath. Which resting parameter would
you expect to have a higher value when compared to an
untrained patient?

## Question 65 of 90

- **A.** Blood pressure
- **B.** Cardiac stroke volume
- **C.** Heart rate
- **D.** Cardiac output
- **E.** Oxygen consumption
67.  A 43-year-old overweight patient presents to ED
complaining of fever and severe right upper quadrant pain.
The pain radiates to her right shoulder tip. Murphy’s sign is
positive and you diagnose acute cholecystitis. Which of the
following nerves is responsible for the pain referred to as
the shoulder tip?
Motor innervation: The phrenic nerve provides
motor innervation to the diaphragm; the main
muscle of respiration.
Sensory Functions Sensory fibers from the phrenic
nerve supply the central part of the diaphragm,
including the surrounding pleura and peritoneum.
The nerve also supplies sensation to the
mediastinal pleura and the pericardium (Pain of
pericarditis)
Note: Inflammation of gall bladder may present
with pain in the right shoulder due to irritation of
phrenic nerve (Diaphragmatic peritoneum).

## Question 67 of 90

- **A.** Lesser thoracic splanchnic nerve
- **B.** Greater thoracic splanchnic nerve
- **C.** Vagus nerve
- **D.** Phrenic nerve
- **E.** Intercostal nerves

## Question 33 of 58

68. A 27-year-old patient presents to the emergency
department with a gluteal stab wound that he sustained
during an altercation. The patient reports difficulty moving
his right leg and is unable to flex his knee. On physical
examination, you note decreased sensation to light touch
over the lateral aspect of his right leg and foot. Which one
of the following nerves is most likely injured?
Tibial nerve or posterior tibial nerve gives sensory
innervation to posterolateral side of the leg, lateral
side of the foot and heel (Plantar aspect of foot)
Tibial nerve or Posterior
tibial nerve
Branch of sciatic nerve. Arises at apex of popliteal
fossa receiving nerve fibers from L4-S3.
Functions:
Motor: Innervates all the muscles in posterior
compartment of the leg and the majority of the
intrinsic foot muscles.
Sensory: In the popliteal fossa, the tibial nerve gives
off cutaneous branches. These combine with
branches from the common fibular nerve to form
the sural nerve. This sensory nerve innervates the
skin of the posterolateral side of the leg and the
lateral side of the foot and heel.
Note: In summary, the tibial nerve provides both
motor and sensory innervation to the lower leg and
foot, in this scenario patient unable to flex his knee
is because of tibial nerve injury while the sural
nerve only provides sensory innervation to a small
area of the lateral lower leg and foot.
Also note sensory innervation specifically to
Achilles tendon and plantar foot is because of
tibial nerve and sensory innervation to lateral
aspect of lower leg and lateral heel is because of
sural nerve (Arises from both tibial and common
fibular nerve)

## Question 68 of 90

- **A.** Sural nerve
- **B.** Tibial nerve
- **C.** Saphenous nerve
- **D.** Common fibular nerve
- **E.** Obturator nerve

## Question 34 of 58

69.
A 19-Year-old girl presents to the ED with complaint of
fever and non-painful pump on site of injury. She gives
history of exposure to cats and scratch by young cats. Cat
scratch disease is caused by which one of the following
types of bacteria?
Bartonella henselae: Gram negative bacilli or
coccobacilli
Cat-scratch disease (CSD) or felinosis is an
infectious disease caused by Bartonella henselae
most often results from a scratch or bite of a cat.

## Question 69 of 90

- **A.** Gram positive cocci
- **B.** Gram negative bacilli
- **C.** Gram positive bacilli
- **D.** Gram negative cocci
- **E.** Acid fast bacteria
70. A 60-year-old man, fell down a flight of stairs and
landed awkwardly on his left hip. He immediately felt a
sharp pain in his hip and was unable to bear the weight on
his left leg. He was taken to the emergency room, where X-
rays revealed a fracture in his left femur and greater
trochanter. Regarding greater trochanter of femur which
one of the following muscles is inserted on it?

## Question 70 of 90

## Question 35 of 58

The greater trochanter of the femur serves as an
attachment site for several muscles, including the
gluteus medius and minimus, which are important
for hip stability and movement. The gluteus medius
attaches to the lateral surface of the greater
trochanter and functions to abduct and medially
rotate the hip.
- **A.** Gluteus Medius
- **B.** Quadratus femoris
- **C.** Tensor fasciae Latae
- **D.** Gluteus maximus
- **E.** Sartorius
72. A 15-year-old boy presents to the emergency
department with a history of fever, headache, and swollen
and painful salivary glands for the past week. He reports
having difficulty eating and drinking due to the pain in his
glands. He also complains of easy bruising, petechiae, and
gum bleeding for the past few days. On examination, his
platelet count is found to be decreased, and he is noted to
have acute kidney injury. Based on clinical presentation
what is the likely diagnosis?

## Question 72 of 90

- **A.** Idiopathic thrombocytopenic purpura (ITP)
- **B.** Systemic lupus erythematosus (SLE)
- **C.** TTP

## Question 36 of 58

Note:  HSP can also present with similar symptoms.
HSP is a systemic vasculitis that affects small blood
vessels and is characterized by the deposition of
immune complexes in the vessel walls. It primarily
affects children and is characterized by a triad of
symptoms including palpable purpura (red or
purple spots on the skin), arthritis, and abdominal
pain. HSP can also cause renal involvement and
hematuria. If in question stem mentioned
abdominal pain, arthritis and renal involvement
go with HSP.
- **D.** Infectious mononucleosis (IM)
- **E.** Henoch-Schönlein purpura (HSP)
74. A 26-year-old male brought into the ED by paramedics
with lacerated wound on left upper quadrant. You suspect
splenic injury. Which rib fracture is likely to be associated
with spleen injury?
Spleen injury most Likely associated with fracture
of rib 10.

## Question 74 of 90

- **A.** Rib 1
- **B.** Rib 8
- **C.** Rib 4
- **D.** Rib 10
- **E.** Rib 6
75. An 18-year-old patient presents to the Emergency
Department following an injury to the distal crease of her
wrist. An image of her hand at rest is shown below.

## Question 75 of 90

## Question 37 of 58

Paralysis to which of the following muscles is most likely
responsible for this deformity?
Interossei and medial two lumbricals are innervated
by ulnar nerve
Claw hand:  Injury to the ulnar nerve is commonly
caused by a fracture of the medial epicondyle and
results in a claw hand, in which the ring and little
fingers are hyperextended at the
metacarpophalangeal joints and flexed at the
interphalangeal joints.
Partial claw hand deformity is due to an isolated
ulnar nerve injury.
Complete claw hand deformity: Involves all digits
and results from combined ulnar and median nerve
injury.
Ulnar nerve injury at elbow and wrist
- **A.** Interossei and medial two lumbricals
- **B.** Extensor digiti minimi
- **C.** Extensor digitorum
- **D.** Flexor digitorum longus
- **E.** Flexor digitorum profundus
76. A 10 days old baby brought into the ED with complaint
of intestinal obstruction and diagnosed to have
Hirschsprung disease. Hirschsprung disease occur due to
absence of which one of the following enteric neurons?

## Question 76 of 90

- **A.** Glial cells
- **B.** Myenteric plexus
- **C.** Endothelial cells
- **D.** Pacinian corpuscles
- **E.** Mucosal plexus

## Question 38 of 58

Hirschsprung disease results from the absence of
parasympathetic ganglion cells in the myenteric
and submucosal plexus of the rectum and/or colon
78. A 35-year-old patient presents to the clinic with a
complaint of difficulty walking due to pain in the front of
their lower leg. The patient reports that the pain started a
few days ago after a strenuous workout session. On
physical examination, you note tenderness and swelling
over the tibialis anterior muscle. Injury of tibialis anterior
muscle will result in loss of which movement of foot?
Anterior leg consists of four muscles

## Question 78 of 90

- **A.** Dorsiflexion and great toe extension
- **B.** Dorsiflexion and inversion
- **C.** Dorsiflexion and eversion
- **D.** Plantarflexion and inversion
- **E.** Plantarflexion and eversion
79. A 14 years old child swallows a coin, it lodged in
esophagus, which one of the following structures compress
esophagus at thoracic level?
The anatomical relations of the oesophagus give
rise to four constrictions, where food/foreign
objects are most likely to become impacted
The esophagus has 3 anatomic constrictions.

## Question 79 of 90

- **A.** Left vagus nerve
- **B.** Left brachiocephalic vein
- **C.** Diaphragmatic hiatus
- **D.** Aortic Arch
- **E.** Posterior surface of the heart

## Question 39 of 58

1: Pharyngoesophageal constriction is at the
junction with the pharynx
2: Thoracic(aortobronchial) constriction: The
second is at the crossing with the aortic arch and
the left main bronchus
3: Diaphragmatic constriction: The third is at the
junction with the stomach
81. A 50-year-old female presents to the emergency
department with severe abdominal pain that has been
worsening for the past few days. The patient reports that
the pain is located in the upper right quadrant of her
abdomen and is accompanied by nausea and vomiting.
Imaging studies reveal the presence of gallstones in the
patient''s gallbladder. What hormone is responsible for the
patient''s gallstone-associated pain?
The hormone responsible for gallstone-associated
pain is cholecystokinin (CCK). CCK is released from
the intestinal cells in response to the presence of
fatty acids and amino acids in the duodenum. It
stimulates the contraction of the gallbladder,
leading to the release of bile into the duodenum. In
patients with gallstones, the contraction of the
gallbladder can cause intense pain as the stones
are forced through the narrow bile ducts. The pain
typically occurs after a meal when CCK levels are
highest.

## Question 81 of 90

- **A.** Glucagon
- **B.** CCK
- **C.** Somatostatin
- **D.** Gastrin
- **E.** Secretin
82. You are examining a patient of femoral hernia; your
consultant asks which structure is bordered medially to the
femoral canal?

## Question 82 of 90

- **A.** Inguinal ligament
- **B.** Pectineal ligament
- **C.** Lacunar ligament
- **D.** Femoral vein
- **E.** Femoral nerve

## Question 40 of 58

Femoral canal lies most medial of the femoral
sheath.
Femoral sheath encloses femoral artery, femoral
vein and femoral canal. Femoral nerve does not lie
within femoral sheath. (Recall)
Borders of the femoral canal: (Useful mnemonic
LAMP: FILP)
Lateral border: Femoral vein (Immediately lateral)
Recall.
Anterior border: Inguinal ligament
Medial border: Lacunar ligament
Posterior ligament: Pectineal ligament, Pectineus
muscle and superior ramus of pubic bone.
High Yield:
Contents of femoral triangle:
From lateral to medial: Useful mnemonic (NAVEL)
Femoral nerve
Femoral artery
Femoral vein
Empty space (consists of femoral canal)
Lymph nodes
Note: Femoral nerve lies lateral to femoral artery
and vein (Recall)
84.    A 34-year-old presents to ER with severe right
shoulder pain after a fall from a height. X-ray reveals a
fracture in the middle third of the right clavicle. The medial
end of the fractured clavicle is displaced upward due to
traction by the?
Clavicle acts to transmit forces from upper limb to
axial skeleton.
After fracture:
Lateral end is displaced inferiorly by the weight of
the arm and displaced medially by the pectoralis
major
Medial end is pulled superiorly due to traction by
the sternocleidomastoid muscle.

## Question 84 of 90

- **A.** Pectoralis minor muscle
- **B.** Serratus anterior muscle
- **C.** Rhomboid muscle
- **D.** Sternocleidomastoid muscle
- **E.** Subclavius muscle

## Question 41 of 58

85. A 25-year-old male presents to the ED with complaint of
left upper quadrant pain, which structure prevent diffuse
peritonitis across abdomen?
Omentum
Peritoneal fold extending from the stomach to
adjacent neurovascular structures divided into the
greater and lesser omentum
The greater omentum is a fatty apron that hangs
down from the greater curvature of the stomach,
and it plays a role in the immune response to
infections and inflammation in the abdomen. The
greater omentum is known to have a protective
function in the peritoneal cavity, where it can limit
the spread of infection or inflammation to other
parts of the abdomen and help isolate the affected
area.
Therefore, if diffuse peritonitis is suspected due to a
perforation in the LUQ, the greater omentum may
play a role in containing the spread of the infection
or inflammation and preventing it from becoming
more widespread in the peritoneal cavity.

## Question 85 of 90

- **A.** Sigmoid colon
- **B.** Small intestinal mesentery
- **C.** Hepatogastric ligament
- **D.** Greater omentum
- **E.** Cecum
89. A motorcyclist falls from his bike in an accident and gets
a deep gash that severs the superficial peroneal nerve near
its origin. Which of the following muscles is paralyzed?

## Question 89 of 90

- **A.** Extensor hallucis longus
- **B.** Fibularis tertius
- **C.** Extensor digitorum brevis
- **D.** Fibularis longus

## Question 42 of 58

Muscles in the Lateral
compartment of leg:
Consists of two muscles, fibularis
longus and brevis, also called peroneus longus
and peroneus brevis.
Note: Insertion of fibularis longus is Ist metatarsal
and medial cuneiform (Recall)
Insertion of fibularis brevis is 5th metatarsal
(Recall)
- **E.** Extensor digitorum longus
90. A 48-year-old woman complains of bilateral leg swelling
which has developed over the last week. She has recently
been diagnosed with hypertension and commenced on
treatment 2 weeks ago. Which hypertensive is most likely
to have been prescribed?
Pedal edema is one of the most common adverse
effects of calcium channel blockers. It has been
more common with dihydropyridine calcium
channel blockers such as: amlodipine, felodipine,
nifedipine (the main cause for calcium channel
blocker induced edema increased capillary
hydrostatic pressure by arteriolar dilation). but it
also seems to occur to a lesser extent with non-
dihydropyridine such as verapamil and diltiazem.
The most common side effect of verapamil is
constipation (Recall)

## Question 90 of 90

- **A.** . Atenolol
- **B.** Bendroflumethiazide
- **C.** Ramipril
- **D.** Amlodipine
- **E.** . Sotalol
6. Regarding Einthoven''s triangle, which one following
show maximum deflection during ventricular
depolarization?

## Question 6 of 90

## Question 43 of 58

The three limb electrodes, I, II and III form a triangle
(Einthoven''s Triangle), at the right arm (RA), left arm
(LA) and left leg (LL).
Lead 1= Left arm(+Ve) and right arm (-Ve)
Lead2 = left leg(+Ve) and Right arm (-Ve)
Lead 3= Left leg(+Ve) and left arm (-Ve)
Lead 2 normally shows largest deflection during
ventricular depolarization as the muscle mass is
greatest and depolarization travels from apex to
base
- **A.** Left arm and right arm
- **B.** Right arm and right leg
- **C.** Left arm and Right leg
- **D.** Left arm and left leg
- **E.** Right arm and left leg
17. A 44 years old woman presents to the ED with pain in
his right eye, after initial assessment you suspect corneal
ulcer. Regarding sensory innervation, which one of the
following nerves carry pain sensation from cornea?
Opthalmic division of trigeminal nerve gives
sensory innervation to:
Forehead and scalp
Upper eyelid and conjunctiva
Cornea
Dorsum of nose
High Yield:
1: Supraorbital nerve: (Branch of Opthalmic division
of trigeminal nerve) innervate Skin of upper eyelid,
conjunctiva and upper forehead
2: Infraorbital nerve (Branch of maxillary division of
trigeminal nerve) innervating skin of lower eyelid,
side of nose, cheek and upper lip

## Question 17 of 90

- **A.** Maxillary division of trigeminal nerve
- **B.** Mandibular division of trigeminal nerve
- **C.** Optic nerve
- **D.** Facial nerve
- **E.** Opthalmic division of trigeminal nerve

## Question 44 of 58

2:  Supratrochlear nerve:(Branch of Opthalmic
division of trigeminal nerve) innervate Skin of
lower forehead
3: Naso ciliary nerve (Branch of Opthalmic division
of trigeminal nerve) innervate cornea, ciliary body
and iris.
Infratrochlear nerve: Bridge of nose
19. A 32-year-old male presents to the ED with complain of
difficulty gripping objects in his right hand. On examination,
he had a weak grip strength in his right hand and was
unable to flex his index and middle fingers. However, he
was able to flex his ring and little finger. Which one of the
following nerves is most likely injured?

High yield median nerve injury
Note: Flexion of the ring and little fingers at
MCPJ and DIPJ are preserved as these are
functions of medial half of flexor digitorum
profundus and medial two lumbricals
innervated by ulnar nerve

## Question 19 of 90

- **A.** Ulnar nerve
- **B.** Musculocutaneous nerve
- **C.** Radial nerve
- **D.** Brachial plexus
- **E.** Median nerve
28. A 49 years old deep sea driver having decompression
sickness. Which one of the following laws demonstrate
mechanism of dissolved gases in deep sea drivers?

## Question 28 of 90

- **A.** Boyles law
- **B.** Ficks law
- **C.** Daltons law
- **D.** Charles law
- **E.** Henry law

## Question 45 of 58

Henry law states that the amount of dissolved gas
in a liquid is proportional to its partial pressure
above the liquid.
So, breathing gas at higher-than-normal pressures
will cause their bodies to absorb more gases than
are absorbed at lower pressures. Absorbed gases
can cause decompression sickness as well as toxic
effects.
Henry law is applicable in Scuva diving (Recall) or
deep-sea diver
33. You have been asked to give a teaching session on
head injuries to a group of medical students. You are
discussing cerebral blood flow and the relation with
intracranial pressure. Which of the following statements is
true regarding. cerebral blood flow (CBF), cerebral
perfusion pressure (CPP), and intracranial pressure (ICP)?
Cerebral perfusion pressure (CPP) is the pressure
gradient that drives blood flow through the brain. It
is defined as the difference between the mean
arterial pressure (MAP) and the intracranial pressure
(ICP) and is represented by the following formula:
CPP = MAP - ICP.
Normal ICP ranges from 5 to 15 mmHg. The
statement "Normal ICP is 65 to 195 mmHg" is
incorrect and represents a severe elevation of ICP
that could cause brain damage.

## Question 33 of 90

- **A.** CBF autoregulation is lost below a CPP of 60
mmHg.
- **B.** The only resistance to CBF is ICP
- **C.** Normal ICP is 65 to 195 mmHg.
- **D.** CPP closely parallels diastolic blood pressure
- **E.** CPP means arterial pressure (MAP) - ICP
37. A 50-year-old patient named John has been admitted to
the hospital with a hip fracture after a fall. He is scheduled
to undergo surgery to repair the fracture the following day.
The anesthesiologist has recommended a fascia iliaca
block to manage his pain after the surgery. Which one of
the following nerves is blocked by fascia iliaca rather than
femoral block?

## Question 37 of 90

- **A.** Femoral nerve
- **B.** Sciatic nerve
- **C.** Sural nerve

## Question 46 of 58

Both the fascia iliaca block and the femoral block
are regional anesthesia techniques used to manage
pain in the lower extremities. The fascia iliaca block
involves the injection of local anesthetic
bupivacaine into the fascial compartment located
deep to the inguinal ligament, targeting the
femoral, lateral femoral cutaneous, and obturator
nerves. This block provides analgesia to the hip
joint, femur, and anterior thigh.
The femoral block, on the other hand, targets only
the femoral nerve by injecting local anesthetic
around the nerve at the level of the inguinal crease.
This block provides analgesia to the anterior thigh
and knee.
While both blocks can be effective in managing
pain, the fascia iliaca block provides a broader area
of analgesia and may be preferred for procedures
involving the hip joint or for patients who have pain
in the hip and thigh region. The femoral block may
be preferred for procedures involving the anterior
thigh or knee. The choice of block will depend on
the specific needs of the patient and the nature of
the procedure
- **D.** Saphenous nerve
- **E.** Lateral femoral cutaneous nerve of thigh
38. In patients with chronic kidney disease, which part of
the kidney is primarily targeted by parathyroid hormone
(PTH) to regulate calcium and phosphorus homeostasis?
PTH increases Ca reabsorption by activating
adenylate cyclase in the distal tubule.
Thiazide diuretics increase Ca reabsorption in the
early distal tubule and therefore decrease Ca
excretion. For this reason, thiazides are used in the
treatment of idiopathic hypercalciuria.
High yield:
Renal calcium handling
60% of plasma Ca is filtered across the glomerular
capillaries.

## Question 38 of 90

- **A.** Collecting duct
- **B.** Loop of Henle
- **C.** Glomerulus
- **D.** Proximal convoluted tubule
- **E.** Distal convoluted tubule

## Question 47 of 58

Together the proximal tubule and thick ascending
limb reabsorb more than 90% of filtered Ca by
passive processes that are coupled to Na
reabsorption.
Loop diuretics (furosemide) cause increased urinary
calcium excretion (hypercalciuria). Because Ca
reabsorption is linked to Na reabsorption in LOH,
inhibiting Na reabsorption with a loop diuretic also
inhibits Ca reabsorption. If volume is replaced, loop
diuretics can be used in the treatment of
hypercalcemia.
Together, distal tubule and collecting duct
reabsorbs 8% of filtered Ca by an active process.
PTH increases Ca reabsorption by activating
adenylate cyclase in the distal tubule.
Thiazide diuretics increase Ca reabsorption in the
early distal tubule and therefore decrease Ca
excretion. For this reason, thiazides are used in the
treatment of idiopathic hypercalciuria.
40. A 50 years old male with history of RTA brought into the
ED in Shock. After initial assessment CVP line placed in his
left subclavian, what is the most common complication of
placing CVP in subclavian vein?

## Question 40 of 90

- **A.** High risk of carotid artery injury
- **B.** Local haematoma
- **C.** External jugular injury
- **D.** Hydrothorax
- **E.** Pneumothorax
49.
A 32-year-old male with a history of RTA presented to ED
with Complain of pain in his Right shoulder. X-ray was done
which shows anterior shoulder dislocation. Which one of
the following ligaments is most likely injured?

## Question 49 of 90

- **A.** Acromioclavicular ligament

## Question 48 of 58

The shoulder joint
Type: synovial ball and socket joint
Shoulder joint is formed by the articulation of the
head of the humerus with the glenoid cavity of the
scapula
Ligaments of the shoulder joint:
In the shoulder joint, the ligaments play a key role
in stabilizing the bony structures.
Glenohumeral ligaments (superior, middle and
inferior) They act to stabilize the anterior aspect of
the joint. They are the main source of stability for
the shoulder (Recall), holding it in place and
preventing it from dislocating anteriorly.
Coracohumeral ligament: It supports the superior
part of the joint capsule.
Transverse humeral ligament: This ligament spans
the distance between the two tubercles of the
humerus. It holds the tendon of the long head of
the biceps in the intertubercular groove
Coraco–clavicular ligament: This ligament
composed of the trapezoid and conoid ligaments
and runs from the clavicle to the coracoid process of
the scapula. They work alongside the
acromioclavicular ligament to maintain the
alignment of the clavicle in relation to the scapula.
Coracoacromial ligament. This ligament runs
between the acromion and coracoid process of the
scapula it forms the coraco-acromial arch.  This
structure overlies the shoulder joint, preventing
superior displacement of the humeral head.
Stability of the joint
Rotator cuff muscles [SITS MUSCLES] Recall
Glenoid labrum: A fibrocartilaginous ridge
surrounding the glenoid cavity
Ligaments: Extra Capsular ligaments form the
coraco-acromial arch.
Biceps tendon – it acts as a minor humeral head
depressor, thereby contributing to stability.
Movements of the shoulder joint: Shoulder joint is
highly mobile ball and socket joint allows various
movements like flexion, extension, adduction,
abduction, medial rotation, lateral rotation and
circumduction

> [!TIP]
> **CLINICAL PEARL:**
> Shoulder joint dislocations
- **B.** Transverse humeral ligament
- **C.** Coracoacromial ligament
- **D.** Coraco–clavicular ligament
- **E.** Glenohumeral ligament

## Question 49 of 58

Anterior shoulder dislocation: Most common
injury results from forceful abduction, extension
and external rotation
Clinical features:
Arm usually abducted and externally rotated
Humeral head often palpated anteriorly
Patient cannot touch contralateral shoulder with
hand of affected extremity.
Complications of anterior shoulder dislocation:
Injury to axillary nerve (Recall)
Injury to axillary artery
Injury to rotator cuff
Posterior Shoulder dislocation:  occurs
occasionally results from direct blow to the arm
that produces forceful internal rotation and
adduction.
Clinical features:
Arm usually adducted and internally rotated
Patient unable to perform external rotation
Complications of posterior shoulder dislocation [
less common neurovascular injury]
Fracture of posterior glenoid labrum
Fracture of humeral shaft or lesser tuberosity
Note: Light bulb sign on the X-ray is the diagnostic
feature of posterior shoulder dislocation
54. Which one of the following hormones is involved in
secretion of bile?
Bile production is stimulated by: Bile salts, Secretin,
glucagon and gastrin
Bile secretion/ release of bile is stimulated by CCK
Note: For details check bile and bile salts in
gastrointestinal physiology.

## Question 54 of 90

- **A.** Motilin
- **B.** Glucagon
- **C.** Somatostatin
- **D.** GIP
- **E.** CCK
61. How is aspirin beneficial in inhibiting platelets
aggregation by blocking which of the following pathway?

## Question 61 of 90

## Question 50 of 58

Aspirin works as an antiplatelet agent by
irreversibly blocking the enzyme cyclooxygenase-1
(COX-1) inside the platelets. This enzyme is
necessary to generate thromboxane A2, a potent
platelet activator from arachidonic acid. Aspirin also
inhibits COX-2 which explains part of its anti-
inflammatory properties.
Clopidogrel selectively inhibits the binding of
adenosine diphosphate (ADP) to its platelet P2Y12
receptor, inhibiting the platelet adhesion and
aggregation.
Abciximab binds to the glycoprotein (GP) IIb/IIIa
receptor of platelets and inhibits platelet
aggregation.
- **A.** Inhibition of GPilb/Illa receptor sites
- **B.** Inhibition of binding of ADP to its platelet
receptor
- **C.** Inhibition of the breakdown of cAMP
- **D.** Inhibition of the calcium release
- **E.** Inhibition of platelet thromboxane A2 synthesis
66. A 35-year-old female patient presents to the emergency
department with palpitations. An electrocardiogram (ECG)
reveals that she is experiencing supraventricular
tachycardia (SVT). You plan to give her adenosine. What is
the mechanism of action of adenosine on the heart when
given in SVT?
Adenosine stimulates A1-adenosine receptors and
opens acetylcholine sensitive K+ channels,
increasing K+ efflux. This hyperpolarises the cell
membrane in the atrioventricular node and, by
inhibiting the calcium channels, slows conduction

## Question 66 of 90

- **A.** Adenosine dilates the coronary arteries
- **B.** Adenosine increases the heart rate
- **C.** Adenosine inhibits the sympathetic nervous
system
- **D.** Adenosine activates the parasympathetic
nervous system
- **E.** Adenosine slows the conduction through the AV
node

## Question 51 of 58

in the AVN. As it has a very short duration of action
(half-life only about 8 - 10 seconds)
Contraindications:
Adenosine is contraindicated in: Asthma and COPD
(can cause bronchospasm), Decompensated heart
failure, Long QT syndrome, Second- or third-degree
AV block and sick sinus syndrome (unless
pacemaker fitted) and Severe hypotension
71. A 19-year-old man attends the ED after sustaining a
head injury. He has a facial nerve palsy and a CT sacn
sacn shows a fracture of the temporal bone. His facial
nerve has most likely been injured at which foramen of the
skull base?
The facial nerve exits the cranial cavity through the
internal acoustic meatus (Recall) and enters the
facial canal of the temporal bone. The nerve then
exits the skull through the Stylomastoid foramen
(lie between the styloid and mastoid processes of
the temporal bone) to enter the parotid gland,
ultimately branching into five terminal branches to
supply the face.
The facial nerve and its branches pass through
the parotid gland, as does the external carotid
artery, which gives off its two terminal branches,
the maxillary artery and the superficial temporal
artery, inside the gland. Deep penetrating wound
to the parotid gland will damage these vessels
(Recall)

## Question 71 of 90

- **A.** Foramen lacerum
- **B.** Jugular foramen
- **C.** Foramen Magnum
- **D.** Foramen ovale
- **E.** Stylomastoid foramen
73. A 35-year-old woman presents to the emergency
department with sudden onset of severe lower back pain
and numbness in both legs. She reports difficulty with
walking and standing up from a seated position. Upon
further evaluation, the healthcare provider notes decreased
sensation in the saddle area and decreased anal tone,
suggestive of possible cauda equina syndrome. Regarding
anatomy of cauda equina lies at which vertebral level?

## Question 73 of 90

- **A.** T12-S2
- **B.** C5-C6

## Question 52 of 58

The spinal cord is housed in the vertebral canal. It is
continuation of medulla oblongata and terminates
as the conus medullaris at the second lumbar
vertebrae of adults.
At birth, the conus medullaris lies at L3. By the age
of 21, it sits at L1/L2, thus the spinal cord only
occupies about 2/3s of the space available to it in
the vertebral canal.
Below the conus medullaris is cauda equina which
lies below L1 from L2 to sacrum
Note: The cauda equina contains a bundle of nerves
which project distally within the enclosed cavity of
the lumbar cistern from the spinal cord and conus
medullaris toward the coccyx. Each nerve exits at its
respective vertebral level toward targets which are
supplied by the L2-S5 spinal cord level.
- **C.** T12-L1
- **D.** C3-C5
- **E.** S3-S5
77. An 8-year-old child is planned for tonsillectomy for the
grade 3 enlarged tonsils. During surgery which artery will
be most common cause of primary haemorrhage during
surgery
Main supply to tonsils is from tonsillar branch of
facial artery. While all others supply minutely to
tonsils

## Question 77 of 90

- **A.** Branches of internal carotid
- **B.** Descending palatine artery from maxillary
- **C.** Ascending pharyngeal artery
- **D.** Dorsal lingual branches
- **E.** Tonsillar branch of facial artery
80. A 45-year-old electrician presents to the ED with
complaint of unable to abduct his little finger on his left
hand. He tries to move it but finds that the muscle on the
side of his palm, known as the hypothenar eminence, is no
longer functioning properly. Which one of the following
hypothenar muscles is likely injured?

## Question 80 of 90

- **A.** Opponens digiti minimi muscle
- **B.** Flexor digiti minimi muscle

## Question 53 of 58

Muscles of the hand:
Hypothenar muscles:
Hypothenar muscle located at base of middle
finger and form hypothenar eminence. All are
innervated by ulnar nerve
Thenar muscles:
Three short muscles located in the base of the
thumb. All are innervated by median nerve.
- **C.** Palmaris brevis muscle
- **D.** Adductor pollicis muscle
- **E.** Abductor digiti minimi muscle
83. A 28-year-old male patient with history of severe allergy
to peanuts accidentally ingests some food containing
peanuts. Within minutes, he developed difficulty breathing,
swelling of the face and throat, and hives. You suspect
anaphylaxis and one dose of adrenaline was given. Which
of the following receptors does adrenaline act on during
anaphylaxis?
Adrenaline acts on beta-2 adrenergic receptors,
which are found in the lungs, heart, and blood
vessels. Stimulation of beta-2 adrenergic receptors
causes relaxation of bronchial smooth muscle,
increased cardiac output, and vasodilation, which
can help to counteract the effects of anaphylaxis.

## Question 83 of 90

- **A.** Alpha-1 adrenergic receptors
- **B.** Dopamine receptors
- **C.** Beta-1 adrenergic receptors
- **D.** Alpha 2 adrenergic receptors
- **E.** Beta-2 adrenergic receptors
86. A 30 years old laborer is brought into the ED by
Ambulance after falling approximately 6m on building site
and sustained fracture to the base of skull. On Examination
there is numbness over lip and maxilla.

## Question 86 of 90

## Question 54 of 58

Which part of skull bone is fractured?
Mandibular branch of trigeminal: Passes through
foramen ovale
Maxillary branch of trigeminal:  Passes through
foramen rotundum
Note: Maxillary division of trigeminal via its branch
infraorbital nerve gives sensory innervation to
lower eyelid, cheek, side of nose and upper lip
(Recall)
- **A.** Stylomastoid foramen
- **B.** Foramen ovale
- **C.** Superior orbital fissure
- **D.** Foramen spinosum
- **E.** Foramen rotundum
87. 17-year-old male presented to the ED following road
traffic accident. On examination, he had penetrating wound
over Achilles'' tendon, and she had loss of sensation over
posterolateral distal leg and planter foot.

What nerve was injured in this injury?

Tibial nerve or posterior tibial nerve gives sensory
innervation to posterolateral side of the leg, lateral
side of the foot and heel (Plantar aspect of foot)
Tibial nerve or Posterior tibial
nerve
Branch of sciatic nerve. Arises at apex of popliteal
fossa receiving nerve fibers from L4-S3.
Functions:

## Question 87 of 90

- **A.** Sural nerve
- **B.** Anterior-tibial nerve
- **C.** Sciatic nerve
- **D.** Common fibular nerve
- **E.** Posterior tibial nerve

## Question 55 of 58

Motor: Innervates all the muscles in posterior
compartment of the leg and the majority of the
intrinsic foot muscles.
Sensory: In the popliteal fossa, the tibial nerve gives
off cutaneous branches. These combine with
branches from the common fibular nerve to form
the sural nerve. This sensory nerve innervates the
skin of the posterolateral side of the leg and the
lateral side of the foot and heel.
Sensory branches of tibial nerve:

> [!TIP]
> **Clinical pearls: Damage to the tibial nerve**
> causes loss of plantar flexion of the foot and
> impaired inversion. This presents difficulty in
> getting the heel off the ground and a shuffling
> gait, resulting in characteristic clawing of the
> toes and sensory loss on the sole of the foot,
> affecting posture and locomotion.

Note: The nerve block that is commonly used
for pain management in heel injuries is the
posterior tibial nerve block. (RECALL)

## Question 56 of 58

88. After a bone fracture, the body initiates a healing
process. Which one of the following cells are responsible
for re-modelling stage of bone healing?

## Question 88 of 90

- **A.** Osteocyte
- **B.** Macrophages
- **C.** Chondrocytes
- **D.** Neutrophils
- **E.** Osteoclasts

## Question 57 of 58

0% Complete
Mark as Complete
Previous Next
Stages of bone/fracture
healing:
Hematoma formation (Immediately in Day 1)
Inflammation and proliferation (8 hours to 1-2
weeks) predominant cells neutrophils and
macrophages
Callus formation (2-3 weeks)
Consolidation (2 to 3 months)
Re-modelling (2 months to years) Osteoclasts are
responsible.
High yield:
Factors that prevent efficient healing:
Malnutrition
Infection
Corticosteroids therapy
Poor blood supply
Complications of Healing
Hypertrophic scar
Keloid formation
Failure to heal (abscess or empyema formation)
Failure to unite (skin, muscle or fascia wound
breakdown)
Fracture complications

## Question 58 of 58',
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
    "updated_at" = now();

  -- Lesson: Mock – Ii Paper – I
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'mock-ii-paper-i',
    'Mock – Ii Paper – I',
    'article',
    '# Mock – Ii Paper – I

> [!NOTE]
> **Instructions:** Single best answer scenario. Read carefully before reviewing the detailed rationale.

Mrcem Primary Complete Course ,High Yield Stuff and Questions Bank ( For
Diet ii Late 2026)
Overview  Comments
Share your score colleagues

LinkedIn  Facebook  Twitter

## Question 13 of 90

2. A 35-year-old woman presents with fatigue and yellow
sclera. Blood tests reveal a high bilirubin which is found to
be unconjugated bilirubin. What pathology is the most likely
cause for her jaundice?

## Question 2 of 90

- **A.** Sickle cell disease
- **B.** Hepatitis
- **C.** Hepatocellular carcinoma
- **D.** Gallstone in the bile duct
- **E.** Carcinoma of the head of the pancreas

## Question 1 of 81

4. A 55 years old male known case of hypertension
presents to the ED with complaint of tingling and numbness
in his right index finger. You suspect carpal tunnel
syndrome. Which one of the following structures lie within
the carpal tunnel?
The carpel tunnel is the space that lies between the
flexor retinaculum. The ulnar nerve, ulnar artery and
tendon of Palmaris longus runs superficial to flexor
retinaculum and thus are not within carpel tunnel.
Flexor pollicis longus enter the carpel tunnel before
reaching its insertion on the distal phalanx of the
thumb
Pronator quadratus is confined to the distal forearm
and does not reach the carpel tunnel.
Note: Carpal tunnel syndrome is caused by pressure
on the median nerve (RECALL)

## Question 4 of 90

- **A.** Ulnar nerve
- **B.** Palmaris longus tendon
- **C.** Flexor pollicis longus tendon
- **D.** Pronator quadratus
- **E.** Ulnar artery

## Question 2 of 81

5. Blood brain barrier is the barrier between cerebral
capillary blood and the CSF consists of which one of the
following cells?
Blood brain barrier is the barrier between cerebral
capillary blood and the CSE CSF fills the ventricles
and the subarachnoid space.
It consists of the endothelial cells of the cerebral
capillaries and the choroid plexus epithelium.

## Question 5 of 90

- **A.** Endothelial cells
- **B.** Oligodendrocytes
- **C.** Astrocytes
- **D.** Plasma cells
- **E.** Ependymal cells
6. In a randomised controlled trial, the following types of
biases are reduced by randomisation:

## Question 6 of 90

- **A.** Recall bias
- **B.** Publication bias
- **C.** Selection bias
- **D.** Ascertainment bias
- **E.** Bias in handling dropouts

## Question 3 of 81

Subjects are randomised in a randomised con -
trolled trial to ensure that the groups are iden tical
apart from the intervention. Randomisation means
that each subject has a predetermined chance of
being allocated to each group, but the group to be
allocated can not be predicted. This will minimise
any selec tion bias.
Ascertainment bias occurs when the results of a
trial are systematically distorted by knowledge of
which intervention each partici pant is receiving.
This type of bias is minimised by blinding of
researchers, clinicians, and patients. Bias caused by
dropouts occur because characteristics of subjects
who left the trial before completion may be
diverent from those who do not. This type of bias is
minimised by appropriate analysis (for exam ple,
intention to treat analysis, worst case scenario
analysis).
Recall bias occurs when the subjects’ recall of
past events is distorted by subsequent events.
This type of bias occurs mainly in retrospective
studies (for example, case control studies Recall)
rather than randomised controlled trials.
Publication bias occurs dur ing the dissemination of
the results.
8. A mother brought her 3-year-old child into ED with
complaint of runny nose, severe coughing from the last 2
weeks and developed subconjunctival hemorrhage. What is
the most likely causative agent?

## Question 8 of 90

- **A.** Bordetella Pertussis
- **B.** Strep group A
- **C.** Hemophilus influenzae type B

## Question 4 of 81

Note: Hemophilus influenza is also gram-
negative Cocco bacilli (Recall)
- **D.** Parainfluenza virus
- **E.** RSV
9. Which vitamin is also known as anti-sterility vitamin?

## Question 9 of 90

- **A.** Vitamin D
- **B.** Vitamin E
- **C.** Vitamin C

## Question 5 of 81

vitamin e act as antioxidant prevents the cells from
damage caused by free radicals. Sperm DNA
damage is an emerging cause of male infertility
that is likely to be more common among men with
increased reactive oxygen species in the ejaculate.
Vitamin E can protect the sperm membrane from
oxidative damage and increased levels are
associated with low levels of reactive oxygen
species.
- **D.** Vitamin K
- **E.** Vitamin A
12. A 2-year-old child brought into the ED by his parents
with a history of fever associated with harsh cough, runny
nose and hoarse of the voice for the last two days. On
examination the child has mild tachycardia, tachypnoea
and his SpO2 is 98%. Which of the following is the most
likely infectious cause of his condition?

## Question 12 of 90

- **A.** Glandular fever
- **B.** Strep group A
- **C.** Hemophilus influenzae type B
- **D.** Parainfluenza
- **E.** RSV

## Question 6 of 81

13. Baby defecate after eating due to which one of the
following physiological reflex?

## Question 13 of 90

- **A.** Entero-colic reflex
- **B.** Vagal reflex
- **C.** Gastro-colic reflex
- **D.** Oesophageo-gastric reflex
- **E.** Oesophageo-colic reflex

## Question 7 of 81

The gastrocolic reflex is a physiological reflex that
controls the motility of the lower gastrointestinal
tract following a meal. As a result of the gastrocolic
reflex, the colon has increased motility in response
to the stretch of the stomach with the ingestion of
food.
14. Which one of the following pathogens causes
ophthalmia neonatorum occurring in the 1  28 days of life?
Ophthalmia neonatorum is conjunctivitis occurring
within the first 4 weeks of life.
The most serious cause is infection with Neisseria
gonorrhea in first week most likely in 3-4 days of
life, but in the UK, it is caused more commonly by
Chlamydia in first 28 days of life.

## Question 14 of 90

st
- **A.** Treponema pallidum
- **B.** Trichomonas vaginalis
- **C.** Chlamydia trachomatis
- **D.** Neisseria gonorrhoeae
- **E.** Gardnerella vaginalis
15. Type-III hypersensitivity is triggered by?

## Question 15 of 90

- **A.** T-cells
- **B.** Deposition of antigen antibody complexes

## Question 8 of 81

Mechanism of hypersensitivity reactions:
Type I reactions (i.e., immediate hypersensitivity
reactions) involve immunoglobulin E (IgE)–
mediated release of histamine and other mediators
from mast cells and basophils. (RECALL)
Type II reactions (i.e., cytotoxic hypersensitivity
reactions) involve immunoglobulin G or
immunoglobulin M antibodies bound to cell
surface antigens, with subsequent complement
fixation.
Type III reactions (i.e., Immune-complex reactions)
involve circulating antigen-antibody immune
complexes that deposit in post capillary venules,
with subsequent complement fixation. An example
is serum sickness.
Type IV reactions (i.e., delayed hypersensitivity
reactions, cell-mediated immunity) are mediated
by T cells rather than by antibodies (RECALL).
- **C.** Nk cells and IgG
- **D.** Mast cells and IgE
- **E.** IgM
16. How does parathyroid (PTH) affect renal handling of
calcium?

## Question 16 of 90

- **A.** Increase calcium reabsorption of proximal
tubule
- **B.** Increase reabsorption of calcium at glomerulus

## Question 9 of 81

PTH increases calcium reabsorption exclusively in
the distal nephron.
25-30% of dietary Calcium is absorbed from gut, out
of this % of calcium, 50% is ionized (means free or
unbound in plasma) and 45% is bound to albumin.
Remaining 5% with other ions
Only free ionized Calcium is filtered freely in
glomerulus:
70% absorbed in PCT (RECALL)
20% in thick ascending loop of Henle
9% in DCT
1% in Collecting duct
- **C.** Decrease calcium reabsorption in the distal
tubule
- **D.** Increase calcium reabsorption in the distal
tubule
- **E.** Decrease calcium reabsorption of proximal
tubule
17. A 23-year-old male presents to the ED with a lacerated
wound on his wrist. You ask junior fellows wrist joint is an
example of ?

## Question 17 of 90

- **A.** Synovial plane joint
- **B.** Synovial ball and socket joint
- **C.** Synovial condyloid joint
- **D.** Synovial pivot joint

## Question 10 of 81

Wrist joint: Synovial condyloid joint
Sternoclavicular joint: Synovial saddle-shaped
joint
Acromioclavicular joint: Synovial plane joint
Shoulder joint: Synovial ball and socket joint
Elbow joint: Synovial hinge joint
Radioulnar joints: Synovial pivot joint
The joint between atlas and axis is Pivot joint
- **E.** Synovial hinge joint
18. Damage to Wernicke''s area will most likely result in
which of the following clinical features?
Broca''s aphasia: This is a non-fluent aphasia which
causes individuals to speak slower. It occurs when
the brain’s frontal lobe suffers damage. Individuals
with Broca’s Aphasia often feel frustrated due to
being able to comprehend what others are saying,
but unable to express themselves. also called
Expressive dysphasia. Individuals affected only can
speak in very short phrases, or have trouble getting
words out. (RECALL)
Wernicke’s aphasia: This is a fluent aphasia as this
type of aphasia does not affect the speed of the
individual''s speech. Individuals with this type of

## Question 18 of 90

- **A.** Expressive dysphasia
- **B.** Nystagmus
- **C.** Receptive dysphasia
- **D.** Visual loss
- **E.** Dysarthria

## Question 11 of 81

aphasia have damage to their brain’s temporal lobe.
As a result, those of Wernicke’s aphasia are
sometimes unable to comprehend what others are
saying, but are able to speak in long sentences.
However, their communication doesn''t follow
standard grammar patterns and uses made-up
words. also called receptive dysphasia.
19. An 8-year-old child brought into the ED with a complaint
of severe vomiting. ABGs revealed metabolic alkalosis.
Metabolic alkalosis occurs after vomiting due to?
Metabolic alkalosis: Occurs due to loss of H+ in GI
tract i.e., vomiting, pyloric stenosis or in kidney
(diuretic therapy)
Metabolic alkalosis is associated with
hypoventilation and hypokalemia (Recall).

## Question 19 of 90

- **A.** Decreased pco2
- **B.** Increase H+
- **C.** Increased pco2
- **D.** Decrease H+
- **E.** Decrease HC03
20. An 87-year-old woman from a residential home with a
2-day history of diarrhea. She has had 10 episodes of
watery diarrhea but no vomiting. She complains of colicky
lower abdominal pain. She had a 5-day course of
antibiotics for a chest infection 2 weeks ago. Observations

## Question 20 of 90

## Question 12 of 81

show a respiratory rate 18 bpm, Sp02 95% in air, heart rate
89 bpm,
BP 146/89 mmHg, temp 36.8''C and BM 5.6 Examination
reveals that her abdomen is soft but there is generalized
tenderness especially across her lower abdomen. What is
the most likely causative organism?
Broad spectrum antibiotics disturb the normal gut
flora and cause overgrowth of clostridium difficile
spores and causing Pseudomembranous colitis
- **A.** Clostridium difficile
- **B.** Rotavirus
- **C.** E. coli
- **D.** Norovirus
- **E.** Campylobacter

## Question 13 of 81

Antibiotics causing clostridium difficile colitis: Co-
Amoxiclav, Cephalosporins, Clindamycin and
quinolones
Treatment of choice of clostridium difficile colitis
is Vancomycin (Recall)
21. A 22-year-old woman involved in a road traffic accident
sustains a fractured pelvis. You suspect an injury to sciatic
nerve.
Which joint movements are most likely to be affected?

## Question 21 of 90

## Question 14 of 81

Sciatic nerve Innervates the muscles of the posterior
compartment of thigh (biceps femoris,
semimembranosus and semitendinosus) and the
hamstring portion of the adductor magnus
(remaining portion of which is supplied by the
obturator nerve).
Sciatic nerve extend thigh at hip joint and flex leg at
knee joint.
- **A.** Hip adduction and rotation
- **B.** Hip adduction and extension
- **C.** Hip rotation and knee flexion
- **D.** Extend thigh at hip and knee flexion
- **E.** Hip adduction and flexion
22. A 72-year-old woman with a history of progressively
worsening dysphagia is discovered to have an
oesophageal tumor. The tumor is located on the anterior
aspect of the thoracic oesophagus. Which of the following
is an anterior relation of the thoracic oesophagus?

## Question 22 of 90

- **A.** Azygous veins
- **B.** Subclavian artery
- **C.** Left recurrent laryngeal nerve
- **D.** Right vagus nerve
- **E.** Lesser sac of peritoneum

## Question 15 of 81

·Note: Larynx:  Innervation to the
intrinsic muscles of the larynx is
achieved via the recurrent laryngeal
nerve. Injury of recurrent laryngeal
nerve may result in hoarseness
(Recall), respiratory obstruction and
inability to speak
superior laryngeal nerve provides both motor and
sensory function to different areas of the throat and
mouth that are primarily involved in speech
(Recall) and keeping food and drink out of your
airway.
The superior laryngeal nerve (SLN) provides motor
innervation to the cricothyroid muscle.
23. A 16-year-old young male brought into the ED with
complaint of dizziness, fatigue and edema on his face and
feet. After initial assessment you suspect Nephrotic
syndrome, regarding nephrotic syndrome what is the cause
of edema?

## Question 23 of 90

- **A.** Hyperalbuminemia
- **B.** Hypoalbuminemia
- **C.** Increased intravascular oncotic pressure
- **D.** Decreased extravascular oncotic pressure
- **E.** Increased salt excretion

## Question 16 of 81

Nephrotic syndrome leads to urinary loss of
albumin (Hypoalbuminemia) which reduces
intravascular oncotic pressure and fluid shift to
extracellular compartment.
24. A 22-year-old male presents with palpitations. ECG was
done at triage which shows S.V.T. You are considering
adenosine, in which of the following conditions adenosine
is contraindicated?
Adenosine is treatment of choice in terminating
supraventricular tachycardia
Contraindications of adenosine include:
Asthma and COPD
Decompensated heart failure
Long QT syndrome
Second- and third-degree heart block
Severe hypotension

## Question 24 of 90

- **A.** Diabetes mellitus
- **B.** Blood dyscariasis
- **C.** Myasthenia gravis
- **D.** Asthma
- **E.** Peripheral vascular disease
25. Taste sensation from anterior 2/3 of tongue is carried
by?

## Question 25 of 90

- **A.** Facial nerve

## Question 17 of 81

The chorda tympani branch of the facial nerve
supplies taste sensation to the anterior 2/3 of the
tongue (RECALL).
In the anterior 2/3, general sensation is supplied by
the trigeminal nerve (CNV). Specifically, the lingual
nerve, a branch of the mandibular nerve (CN V3).
(RECALL)
The posterior 1/3 of the tongue both touch and
taste are carried by the glossopharyngeal nerve
(CNIX) (RECALL).
- **B.** Hypoglossal nerve
- **C.** Glossopharyngeal
- **D.** Trigeminal nerve
- **E.** Vagus nerve
26. A 40-Year-old male who is known hypertensive taking
ACE inhibitors presents with dry cough. What is the
mechanism of cough in ACE inhibitor?
ACE inhibitor decreases the breakdown of the
potent vasodilator bradykinin which is the cause of
the persistent dry cough.

## Question 26 of 90

- **A.** Decreased bradykinin breakdown
- **B.** Increased production of prostaglandin
- **C.** Histamine release
- **D.** Increased bradykinin breakdown
- **E.** Stimulation of irritant receptors

## Question 18 of 81

Side effects of ACE inhibitor includes:
Acute kidney injury
Hyperkalemia
Non allergic angioedema (Recall)
Persistent dry cough (Recall).
27. Which of the following shift oxygen hemoglobin
dissociation curve to left?
Leftward shift: Increased affinity for oxygen (Less
willing to give up oxygen)
Increased affinity for oxygen (Less willing to give up
oxygen)
Increased pH
Decreased pCO2
Decreased temperature
Decreased H+(RECALL)
Decreased 2-3DPG
CO (RECALLL)
Methemoglobinemia
Fetal hemoglobin (RECALL)
Rightward shift: Decreased affinity for oxygen
(More willing to give up oxygen)

## Question 27 of 90

- **A.** Increase temperature
- **B.** Increased Pco2
- **C.** CO Poisoning
- **D.** Decreased PH
- **E.** Increased 2-3DPG

## Question 19 of 81

Decreased ph (RECALL)
Increased pCO2
Increased H+
Increased Temperature
Increased 2-3DPG
28. A 40-year-old woman presents to the emergency
department with painful swollen digit, the infection appears
to have spread to the common flexor sheath. Which of the
following digit is most likely to be involved with spread of
infection to this location?
The synovial sheath of the little finger is usually
continued with the common flexor sheath which is
also called ulnar bursa thus infection of ulnar bursa
most likely to involve the little finger.
In a same way infection of thumb may spread to
mid palmer space through the continuous synovial
sheath of the flexor pollicis longus which is also
called radial bursa.

## Question 28 of 90

- **A.** Thumb
- **B.** Little finger
- **C.** Index finger
- **D.** Middle finger
- **E.** Ring finger
30. A 25-year-old man attends the ED with abdominal pain.
He has a history of Crohn''s disease and has had a
previous resection of his terminal ileum.
Which of the following is most likely to be deficient due to
the absence of the terminal ileum?

## Question 30 of 90

## Question 20 of 81

Maximal water reabsorption occurs in Jejunum
(Recall)
Maximal Iron absorption occurs in duodenum
(Recall)
Maximal calcium absorption occurs in duodenum
(Recall)
Maximal vit B12 and vit D absorption occurs in
terminal ileum
- **A.** Vitamin C
- **B.** Vitamin D
- **C.** Dietary carbohydrate
- **D.** Zinc
- **E.** Dietary protein
31. A 55-year-old male known case of COPD came with a
complaint of breathlessness. His observations include
BP=100/70 Pulse=102bpm and Sa02 is 78%. You keep the
patient on 02, what is the targeted 02 saturation prior to
discharge?

## Question 31 of 90

- **A.** 88 – 92%
- **B.** Unless SaO2 becomes 100%
- **C.** Unless SaO2 becomes 98%
- **D.** Unless SaO2 becomes 94%
- **E.** 80-84%

## Question 21 of 81

COPD and conditions associated with chronic
respiratory failure. In the treatment of
exacerbations of chronic obstructive pulmonary
disease (COPD), oxygen should be titrated to
achieve a target oxygen saturation range of 88–
92%.
32. Whilst in your physiology lecture you ask medical
students what is the physiological purpose of AV nodal
delay?
Significance of AV nodal delay
The cardiac impulse does not travel from the atria to
the ventricles too rapidly.
This delay allows time for the atria to empty their
blood into the ventricles before ventricular
contraction begins. This increases the efficiency of
the pumping action of the heart.
It is primarily the AV node and its adjacent fibers
that delay this transmission into the ventricles.

## Question 32 of 90

- **A.** Increase time for ventricular filling
- **B.** Parasympathetic activity decreases AV nodal
delay
- **C.** Increase time for filling of atria
- **D.** Ejection fraction time
- **E.** Sympathetic activity causes increase in AV nodal
delay
33. A 44-year-old woman presents with a two-month history
of nausea, weight loss, and diarrhea. She returned from

## Question 33 of 90

## Question 22 of 81

working in Nigeria five months ago. Do you suspect
tapeworm infestation
What diagnostic method is most likely to confirm acute
Infestation?
Stool: parasites Direct light microscopy
Sputum: TB Ziehl-Nelsen stain
- **A.** Serum antibodies
- **B.** Visualization of eggs in stool on light microscopy
- **C.** Eosinophil count
- **D.** Abdominal CT
- **E.** Colonoscopy
34. A 19-year-old man presents with an open tibial fracture
contaminated with soil. His immunizations are up to date.
With regard to tetanus prophylaxis what is the most
appropriate management?

## Question 34 of 90

- **A.** No further tetanus prophylaxis
- **B.** Administration of tetanus immunoglobulin

## Question 23 of 81

Diphtheria, tetanus, polio vaccine schedule:  2, 3, 4
months, preschool and 14 years
Child''s immunization status is up to date and his
last vaccination schedule was in 14 years. Less than
10 years are passed
- **C.** Administration of tetanus immunoglobulin and
vaccination
- **D.** Administration of tetanus vaccination
- **E.** Administration of tetanus vaccination now and
in one month
35. Repeated stimulation of a skeletal muscle fiber causes
a sustained contraction (tetanus). Accumulation of which
solute in intracellular fluid is responsible for the tetanus?

## Question 35 of 90

- **A.** Sodium
- **B.** Calmodulin

## Question 24 of 81

During repeated stimulation of a muscle fiber,
Calcium is released from the sarcoplasmic
reticulum (SR) more quickly than it can be
reaccumulated; therefore, the intracellular [Ca2+]
does not return to resting levels as it would after a
single twitch. The increased [Ca2+] allows more
cross-bridges to form and, therefore, produces
increased tension (tetanus)
Note: In skeletal muscle, Ca² binds to troponin C
(Recall) initiating the cross-bridge cycle. In
smooth muscle, Ca2+ binds to calmodulin.
High Yield:
Muscle filaments:
Thick filaments: Present in the A band in the
center of the sarcomere
Contains Myosin (Recall)
Thin filaments: Present in the I bands
Anchored at the Z lines
Contains actin, tropomyosin and troponin
- **C.** Calcium
- **D.** Potassium
- **E.** Troponin
36. Antidiuretic hormone (ADH) acts primarily at which of
the following sites in renal nephron?

## Question 36 of 90

- **A.** Thick ascending limb of loop of Henle
- **B.** Thin ascending limb of loop of Henle

## Question 25 of 81

Antidiuretic hormone (ADH), also known as
vasopressin, is a small peptide hormone which
regulates the body’s retention of water. The main
action of ADH in the kidney is to regulate the
volume and osmolarity of the urine. Specifically, it
acts in the distal convoluted tubule (DCT) and
collecting ducts (CD).
ADH synthesized by hypothalamus and secreted
from Posterior pituitary (RECALL)
ADH binds to V2 receptors on renal principal cells
of late distal tubules and collecting ducts
(RECALL)
ADH also binds with V1 receptors on vascular
smooth muscles.
Central diabetes insipidus result from deficiency
ADH secretion (RECALL)
Nephrogenic diabetes insipidus result from
inappropriate renal response to ADH
- **C.** Descending limb of loop of Henle
- **D.** Distal convoluted tubule and collecting ducts
- **E.** Proximal tubule
37. A woman sustained a human bite from someone known
to have hepatitis B two hours ago. She has not had any
previous hepatitis B vaccinations
Regarding prophylaxis against hepatitis B, what is the most
appropriate schedule to follow?

## Question 37 of 90

- **A.** Hepatitis B Immunoglobulin immediately and
Hepatitis B vaccine three doses over three months

## Question 26 of 81

Emergency hepatitis B vaccination
If you have been exposed to the hepatitis B virus
and have not been vaccinated before, you should
get immediate medical advice, as you may benefit
from having the hepatitis B vaccine.
In some situations, you may also need to have an
injection of antibodies, called specific hepatitis B
immunoglobulin (HBIG), along with the hepatitis B
vaccine.
HBIG should ideally be given within 48 hours post
exposure Hepatitis B vaccine three doses over three
months
- **B.** Hepatitis B vaccine three doses over six months
- **C.** Hepatitis B vaccine three doses over three
months
- **D.** Hepatitis B Immunoglobulin immediately and
Hepatitis 8 vaccine three doses over six months
- **E.** Hepatitis B Immunoglobulin immediately
39. A 55-year-old patient presents to the emergency
department with a persistent cough and hemoptysis. on x-
ray you note hilar lymphadenopathy which of the following
lymph nodes are most likely enlarged?

## Question 39 of 90

- **A.** Inferior tracheobronchial lymph node
- **B.** Bronchopulmonary lymph node
- **C.** Anterior mediastinal lymph node

## Question 27 of 81

The Bronchopulmonary lymph node most
frequently involved in pathologies of lung.
- **D.** Cervical lymph node
- **E.** Superior tracheobronchial lymph node
40. Regarding prophylaxis of malaria which one of the
following antibiotics is used?
Doxycycline is used as prophylaxis for malaria who
travel to countries with extensive resistance to
Chloroquine.

## Question 40 of 90

- **A.** Rifampicin
- **B.** Clarithromycin
- **C.** Doxycycline
- **D.** Vancomycin
- **E.** Clindamycin
41. Regarding the power of study which one of the
following statements is correct?

## Question 41 of 90

- **A.** Power increases with sample size
- **B.** Power decreases with sample size
- **C.** Power increases as the variability increases

## Question 28 of 81

The power of a study is the probability of (correctly)
rejecting the null hypothesis when it is false, i.e. the
probability of detecting a statistically significant
difference
power can be increased by increasing the sample
size
Power increases as the variability decrease
Note: Increasing sample size can decrease bias
/error. (Recall)
- **D.** Power decreases as the variability decrease
- **E.** Power does not change with sample size
42. A 26-year-old woman attends complaining of lower
abdominal pain. She has a positive pregnancy test despite
taking the contraceptive pill. She has epilepsy and has
recently had her medication changed. Which antiepileptic is
most likely to have had an effect on her oral contraceptive?

## Question 42 of 90

- **A.** Lamotrigine
- **B.** Carbamazepine
- **C.** Sodium valproate
- **D.** Levetiracetam
- **E.** Clobazam

## Question 29 of 81

Note: In pregnancy on contraceptive pills, enzyme
inducer drugs will increase hepatic clearance of
contraceptive pills and pregnancy can still
happen
Enzyme inhibitors raise plasma theophylline
levels
Enzyme inducers decrease plasma theophylline
level
43. Regarding the sole of foot, which one of the following
muscles is a part of 1st layer of foot?
Muscles of sole of foot. (4 layers)

## Question 43 of 90

- **A.** Flexor hallucis Brevis
- **B.** Lumbricals
- **C.** Interosseous muscles
- **D.** Abductor hallucis
- **E.** Adductor hallucis

## Question 30 of 81

First layer: abductor hallucis, flexor digitorum brevis
& abductor digitorum minimi
Second layer: flexor digitorum accessorius, 4
lumbricals and tendons of flexor hallucis longus and
flexor digitorum longus
Third layer: flexor hallucis brevis, flexor digitorum
minimi brevis & adductor hallucis
Fourth layer: Plantar and dorsal interossei muscles,
Two long tendons of extrinsic muscles - tibialis
posterior and peroneus longus.
44. Regarding respiratory muscles, which one of the
following muscles is a forced muscle of expiration?
Muscles of forced expiration include:
Anterior abdominal muscles (rectus abdominis is
the main muscle)
internal Intercostal muscles
External intercostal muscles are the muscles of
inspiration.

## Question 44 of 90

- **A.** Sternocleidomastoid
- **B.** Scalenus anterior
- **C.** Rectus abdominis
- **D.** External Intercostal
- **E.** Scalenus Medius
45. A 34-year-old man presents to the ED complaining of a
green urethral discharge and dysuria. He reports
unprotected sexual intercourse with a new partner 3 days
ago. What is the most likely causative organism?

## Question 45 of 90

## Question 31 of 81

Neisseria
gonorrhoeae
Gram –Ve diplococci transmitted
through Sexual and peripartum
causing Urethritis, epididymo-
orchitis, PID, septic arthritis,
neonatal conjunctivitis (ophthalmia
neonatorum)
Note: Urethritis in 1st week (3-4
days) post exposure and
unprotected sex while Chlamydia
trachomatis causes urethritis
after 2-3 weeks post exposure
and unprotected sex
- **A.** Neisseria gonorrhoeae
- **B.** Treponema pallidum
- **C.** Gardnerella vaginalis
- **D.** Chlamydia trachomatis
- **E.** Trichomonas vaginalis
47. Regarding central respiratory chemoreceptors, which of
the following statement is correct?

## Question 47 of 90

- **A.** Located in the medulla near exit of cranial nerve
X,XI
- **B.** Respond directly to changes in external PCO2
- **C.** Respond directly to changes in arterial PCO2

## Question 32 of 81

Central chemoreceptors are sensitive to the PH of
CSF, decrease in the pH of the CSF produce
increase in breathing rate(hyperventilation). H+
doesn''t Cross the blood brain barrier as well as co2
does. co2 diffuse from arterial blood into the CSF
because co2 is lipid soluble and readily cross blood
brain barrier. in the CSF, co2 combines with ho2 to
produce H+ and HCO3-. the resulting H+ act directly
on the central chemoreceptors, thus increase in
pco2 and H+ stimulate the breathing and decrease
in pco2 and H+ inhibit the breathing. this resulting
hyperventilation or hypoventilation then returns
the arterial Pco2 toward normal.
Central chemoreceptors are located near the
ventrolateral surface of the medulla.
Peripheral chemoreceptors are located in carotid
and aortic body. The carotid bodies are located at
the bifurcation of common carotid arteries, the
aortic bodies are located above and below the aortic
arch.
Decrease in arterial po2: stimulate the peripheral
chemoreceptor and increase breathing rate. po2
must decrease to low levels (<60mmHg) before
breathing is stimulated. when po2 is less than
60mmHg, breathing rate is exquisitely sensitive to
po2.
increase in arterial Pco2: stimulate the peripheral
chemoreceptors and increase breathing rate
increase in arterial H+: stimulate the carotid body
peripheral chemoreceptors directly, independent of
Changes in pco2.
In metabolic acidosis, breathing rate is increased
(hyperventilation) because arterial H+ is increased
and pH is decreased.
- **D.** Respond to pH of CSF
- **E.** Located in dorsal surface of medulla

## Question 33 of 81

48. A 10 years old child brought into the ED with complaint
of tiredness, fever and joint pain. His mother states that he
had acute sore throat 10 days back. You suspect acute
rheumatic fever secondary to untreated sore throat.
Rheumatic fever is immunological sequalae of which of the
following pathogens?
Streptococcus
Pyogenes
Streptococcus Pyogenes is
gram +Ve Cocci in chains
Beta hemolytic group A
Causes acute sore throat in
children (Recall), skin and soft
tissue infection and
necrotizing fasciitis
Erysipelas: Superficial skin
infection involving upper
dermis and superficial
lymphatics caused by Group
A beta hemolytic
streptococcus pyogenes
(Recall)
Post-infectious immune-
mediated reactions of
Streptococcus Pyogenes

## Question 48 of 90

- **A.** Streptococcus pyogenes
- **B.** Staphylococcus aureus
- **C.** Staph viridians
- **D.** Staph epidermidis
- **E.** Pseudomonas aeruginosa

## Question 34 of 81

include Rheumatic fever,
erythema nodosum, acute
glomerulonephritis
50. Carbonic anhydrase enzyme is present in which one of
the following parts of nephron?
Carbonic anhydrase pre-dominant location is
epithelial cells of the Proximal convoluted tubule
Carbonic anhydrase catalyzes formation of Hco3-
and H+ from H20 and Co2

## Question 50 of 90

- **A.** The descending loop of Henle
- **B.** The ascending loop of Henle
- **C.** The collecting tubule and duct
- **D.** The proximal convoluted tubules
- **E.** The distal convoluted tubules
51. During examination of cardiovascular system you are
discussing heart sounds and cardiac cycle. which of the
following stage of cardiac cycle occurs immediately after
the aortic valve closes?

## Question 51 of 90

- **A.** Atrial systole
- **B.** Isovolumetric contraction

## Question 35 of 81

Isovolumetric Relaxation
When the aortic and pulmonary valves close, the
heart relaxes isovolumetrically because both the
outflow valves and inflow valves are closed, and so
no fluid moves across them. This phase lasts until
the intraventricular pressure falls below the
pressure in the atria, at which time the mitral and
tricuspid valves open again. The isovolumetric
relaxation lasts about 0.08 S. The volume
throughout this phase is the end systolic volume,
approximately 50 ml. The atrioventricular (AV)
valves open at an atrial pressure of about 7 mmHg.
Isovolumetric relaxation:
lasts about 0.08 seconds
Aortic and pulmonary valves closed
Mitral and tricuspid valves closed.
- **C.** Isovolumetric relaxation
- **D.** Ventricular ejection
- **E.** Ventricular filling
52. A 42-year-old male with history of assault presents to
the ED with complaint of incised wound on the neck. Which
one of the following arteries is most likely injured?

## Question 52 of 90

- **A.** Facial artery
- **B.** Vertebral artery
- **C.** Brachial artery
- **D.** Internal carotid artery

## Question 36 of 81

Neck injury may result in the laceration of major
vessels, potentially leading to hemorrhagic shock.
Internal carotid artery is most likely injured.
- **E.** Basillar artery
53. A 55-year-old female with history of fall brought into the
ED with complain of Severe right hip pain. Xray reveals
posterior hip dislocation, which one of the following
ligaments is torn in posterior dislocation of hip?
Intracapsular
The only intracapsular ligament is the ligament of
head of femur. It is a relatively small structure,
which runs from the acetabular fossa to the fovea of
the femur.
Extracapsular ligaments:
Iliofemoral ligament: Strongest of all located
anteriorly (Recall)
Ischiofemoral:  Reinforcing the capsule posteriorly.
Pubofemoral:  Reinforcing the capsule anteriorly
and inferiorly

## Question 53 of 90

- **A.** Ischiofemoral
- **B.** Ligament of head of femur
- **C.** Pubofemoral
- **D.** All the extracapsular ligaments
- **E.** Iliofemoral

## Question 37 of 81

Note: Most common hip dislocation is posterior and
sciatic nerve is most commonly injured (Recall).
55. An eight-year-old girl presents to the ED with impetigo
around her mouth and nose.
What is the most likely method of spread?
Impetigo is highly contagious skin infection caused
by staph aureus
Note: Fusidic acid is  used for staphylococcus skin
infection (impetigo) Recall

## Question 55 of 90

- **A.** Droplet spread
- **B.** Invasion of breached skin
- **C.** Via fecal oral route
- **D.** Hematogenous spread
- **E.** Invasion of intact skin

## Question 38 of 81

Note: Malaria is blood borne pathogen( Recall)
introduced via the bite of a vector
56. A 40-year-old man presents to the emergency
department intoxicated with an abdominal stab wound,
situated just above the umbilicus in the midline. Small
bowel has herniated through the anterior abdominal wall
through the hole created by the knife
The most superficial structure damaged in stabbing?
Camper''s fascia is the most superficial fatty layer
of the anterior abdominal wall.

## Question 56 of 90

- **A.** Aponeurosis of internal oblique
- **B.** Rectus abdominis muscle
- **C.** Transversalis fascia
- **D.** Camper’s fascia
- **E.** Scarpa’s fascia
57. 22 years old young female came into ED with complain
of sudden onset of lower limb weakness. She has history of
Sore throat 10 days ago. On Examination her reflexes are
absent in his lower limbs. What is the most likely causative
organism?

## Question 57 of 90

- **A.** Staphylococcus aureus
- **B.** Clostridium perfringens

## Question 39 of 81

GBS cases seem to occur after a viral or bacterial
infection like those that cause sore throats or
diarrhea characterized by lower limb weakness,
paresthesia and hyporeflexia
- **C.** Campylobacter jejuni
- **D.** Salmonella
- **E.** Clostridium difficile
58. A 33-year-old woman presents with severe headache
and double vision. She has had severe facial pain and
purulent nasal discharge for the past week. CT shows
cavernous sinus thrombosis. Which one of the following
veins is source of infection of cavernous sinus?
Cavernous sinus thrombosis (CST) refers to the
formation of a clot within the cavernous sinus. It is
important to note that the superior ophthalmic
vein forms an anastomosis with the facial vein.
Therefore, the ophthalmic veins represent a
potential route by which infection can spread from
an extracranial to an intracranial site.

## Question 58 of 90

- **A.** Facial vein
- **B.** Middle cerebral vein
- **C.** Azygous vein
- **D.** Ophthalmic vein
- **E.** Central vein of retina

## Question 40 of 81

Note: The abducens nerve (CN VI) is most
commonly affected in cavernous sinus
thrombosis
Structures passing through cavernous sinus
useful mnemonic: O TOM CAT
OTOM (oculomotor nerve, trochlear nerve,
ophthalmic branch, maxillary branch) refers to
the lateral wall contents from superior to inferior
CAT (internal carotid artery, abducens nerve,
trochlear nerve) refers to the horizontal contents,
from medial to lateral.
59. Which factors contribute to the Bohr Effect?
The Bohr effect describes hemoglobin''s affinity for
oxygen as a function of blood pH and carbon
dioxide content. An increase in CO2 concentration
will lower the blood pH, causing the hemoglobin
affinity for oxygen to reduce. High temperature also
causes oxygen to be released from hemoglobin but
it''s not related to Bohr''s effect.

## Question 59 of 90

- **A.** Low pH, high CO2, low temperature
- **B.** High pH, low CO2
- **C.** Low pH, low CO2
- **D.** Low pH, high CO2
- **E.** Low pH, high CO2, high temperature

## Question 41 of 81

60. A 70-year-old man who is a chronic smoker presents
with shortness of breath. An arterial blood sample shows a
raised PCO2. Which finding would best indicate this is a
long-standing increase in arterial PCO2?
Respiratory acidosis: Compensated by Increased
renal bicarbonate formation and resulting
metabolic alkalosis
Metabolic acidosis: Compensated by decreased
Pco2 formation through hyperventilating and
resulting in respiratory alkalosis.

## Question 60 of 90

- **A.** Increased renal bicarbonate formation
- **B.** Decreased plasma potassium concentration
- **C.** Decreased urinary ammonium salts
- **D.** Increased renal potassium excretion
- **E.** Increased urinary bicarbonate excretion
61. Berry aneurysms are the most common type of
intracranial aneurysm arising from which one of the
following arteries?

## Question 61 of 90

- **A.** Posterior communicating artery
- **B.** Anterior Cerebral artery
- **C.** Middle cerebral artery
- **D.** Anterior communicating artery

## Question 42 of 81

Anterior communicating artery is most common
site of berry aneurysm. Second most common site is
posterior communicating.
Aneurysm of anterior communicating artery
compress the optic chiasma and cause bitemporal
hemianopia, aneurysm of posterior
communicating artery may cause 3rd nerve palsy.
(RECALL).
- **E.** Posterior cerebral artery
62. A 25-year-old woman presents with shortness of breath
and right-sided chest pain. You suspect pulmonary
embolism.
Which parameter is most likely to be decreased?
In PE, pulmonary vascular resistance (PVR)
increases due to the mechanical obstruction of the
vascular bed with thrombus and hypoxic
vasoconstriction. Pulmonary artery pressure (PAP)
increases if thromboemboli occludes greater than
30% to 50% of the total cross-sectional area of the
pulmonary arterial bed.
Increased PVR increases the right ventricular
afterload, which impedes right ventricular outflow,

## Question 62 of 90

- **A.** Po2 in pulmonary venous blood
- **B.** Right atrial pressure
- **C.** Left atrial pressure
- **D.** Ventilation to perfusion ratio
- **E.** Pulmonary vascular resistance

## Question 43 of 81

which, in turn, causes right ventricular dilation and
flattening or bowing of the interventricular septum.
The desynchronization of the ventricles may be
increased by the development of the right bundle
branch block. The decreased RV outflow and
concomitant RV dilation reduce left ventricular
filling, thereby compromising cardiac output. As a
result, LV filling is reduced in early diastole, and this
leads to a reduction in the cardiac output (CO) and
cause systemic hypotension and hemodynamic
instability. Low cardiac output leads to increased
extraction of oxygen in the tissues, thereby
decreasing the partial pressure of oxygen in
venous blood below normal level. Right ventricle
(RV) failure due to acute pressure overload is the
primary cause of death in severe PE.
Note: Due to increase after load in right ventricle
right ventricular dilation and right atrial pressure
increases in pulmonary embolism (Recall)
Pulmonary embolism: Increase physiological dead
space (Recall).
63. A 55-year-old lady presents to the Emergency
department with complaint of visual loss in Lower left
quadrant in both visual fields. The lesion would most likely
be in which of the following?

## Question 63 of 90

- **A.** Right temporal lobe
- **B.** Right parietal lobe
- **C.** Left parietal lobe
- **D.** Left temporal lobe
- **E.** Right occipital lobe

## Question 44 of 81

Homonymous denotes a condition which affects
the same portion of the visual field of each eye.
Homonymous inferior quadrantanopia is a loss of
vision in the same lower quadrant of visual field in
both eyes whereas a homonymous superior
quadrantanopia is a loss of vision in the same upper
quadrant of visual field in both eyes.
A lesion affecting one side of the temporal lobe may
cause damage to the inferior optic radiations
(known as the temporal pathway or Meyer''s loop)
which can lead to superior quadrantanopia on the
contralateral side of both eyes (RECALL), if the
superior optic radiations (parietal pathway) are
lesioned, the visual loss occurs on the inferior
contralateral side of the both eyes and is referred to
as an inferior Quadrantanopia (RECALL).
64. A 50-year-old male presents to ER with worsening
breathlessness, on examination you find signs of heart
failure. In heart failure, the frank starling curve is moved
downward due to:
The ability of the heart to change its force of
contraction and therefore stroke volume in
response to changes in venous return is called the
Frank-Starling mechanism.

## Question 64 of 90

- **A.** Decrease in contractility
- **B.** Decrease in Afterload
- **C.** Increase in preload
- **D.** Decrease in preload
- **E.** Increase in Afterload

## Question 45 of 81

The heart will contract with greater force when
preload/EDV is increased. Preload is diastolic filling
volume of left ventricle reflect stretch of cardiac
muscle cells, greater the stretch more forcefully
heart will contract. when there is increased EDV/
preload there is increased is Stroke volume this
intrinsic relationship between EDV and stroke
volume is known as frank starling law of heart…
In HEART FAILURE, the Frank–Starling curve is
moved down and flattened due to reduced
inotropy, so that more venous return and hence
preload is required to increase stroke volume. As
venous return and preload rise, myocyte stretching
occurs that increases sarcomere length.
FACTORS AFFECTING THE FRANK STARLING
CURVE
increase in contractility shift the curve upward and
to the left e.g.: positive inotropic drugs (RECALL)
Decrease in contractility= downward and to the
right
Increase in preload = rightward shift
decrease in preload=leftward shift
Increase in Afterload=Downward and right
decrease in Afterload=upward and left
65. 18 weeks Pregnant lady previously non-immune comes
in contact with a chickenpox patient. Which one of the
following management plans is correct?

## Question 65 of 90

- **A.** Treat with IV antibiotics
- **B.** Immunoglobulin+ iv acyclovir for 7 days
- **C.** Immunoglobulin+ iv acyclovir for 14 days
- **D.** Immunoglobulin and vaccine

## Question 46 of 81

Chickenpox in pregnancy is managed by two
different methods - one is used before the onset of
symptoms and the other after the onset of rash.
One is varicella-zoster immune globulin (VZIG),
which strengthens the immune system for a short
time. If you are not immune to chickenpox you can
be treated with VZIG, usually by injection, up to ten
days after you come into contact with chickenpox.
It is used before any symptoms appear; it does not
work afterwards. The other is Acyclovir, which may
reduce fever and symptoms if it is started within 24
hours of the rash developing and continue for 7
days
Key points:
If you have already had chickenpox, you have
nothing to worry about.
Once you have had chickenpox you cannot catch it
a second time, this is known as being immune.
Nine out of ten UK adults are immune to
chickenpox.
Chickenpox is very rare in pregnant women in the
UK.
It affects very few babies in the womb and
although it can be very serious in pregnancy
especially in 1st trimester in first 12 weeks (Recall)
If you have been in contact with chickenpox and
are not sure if you are immune, contact your GP or
midwife not attend the antenatal clinic.
If you have chickenpox, avoid contact with other
pregnant women and new babies until at least five
- **E.** Vaccine and IV acyclovir

## Question 47 of 81

days after the rash appears, or until all the blisters
have crusted over.
66. A 5-year-old male child brought into the ED with an
infection after circumcision. The lymphatic from the penile
skin and prepuce drains into which of the following group of
lymph nodes?
Penile skin and prepuce = superficial inguinal lymph
nodes
Glans penis and penile urethra=deep inguinal
lymph nodes(recall)
Scrotum=Superficial inguinal lymph nodes
(RECALL)
Testes= lumber or para-aortic lymph nodes
(RECALL)
prostate= internal iliac nodes (recall)
High Yield:
Pre aortic lymph nodes:
1.coeliac group of preaortic lymph nodes drain:
Abdominal oesophagus
Stomach
Pancreas(recall)

## Question 66 of 90

- **A.** Para aortic lymph nodes
- **B.** Deep inguinal lymph nodes
- **C.** Superficial inguinal lymph nodes
- **D.** External iliac lymph nodes
- **E.** Internal iliac lymph nodes

## Question 48 of 81

Liver
Spleen
Gallbladder
Duodenum proximal to major duodenal papilla
2. Superior mesenteric group of preaortic lymph
nodes drain:
distal duodenum
Jejunum
Ileum
Cecum
Appendix
Ascending colon
Proximal two third of transverse colon
3. 3. Inferior mesenteric group of preaortic lymph:
Distal transverse colon
Descending colon
Sigmoid colon
Proximal rectum
Lumbar or Paraaortic lymph nodes:
Kidney (Recall)
Adrenal gland
Testes (recall)
Ovaries (recall)
67. 30 years old male patient brought into ED
Unresponsive after initial assessment you suspect opioid
toxicity, what is the antidote of morphine toxicity?

## Question 67 of 90

- **A.** N–acetyl cysteine
- **B.** Naloxone

## Question 49 of 81

Naloxone is an opioid antagonist rapidly reverse the
adverse effects of opioid toxicity.
- **C.** Atropine sulphate
- **D.** Esmolol
- **E.** Flumazenil
68. A 50-year-old male presents to the emergency
department with complain of visual disturbance in his right
eye on examination you note when you show a light in his
right eye, neither his right or Left pupil constrict but when
you show a light in his left eye both his left and right pupil
constrict. which of the following nerve is most likely
affected?
Loss of afferent pupillary light reflex is seen in
complete palsy of optic nerve. the ipsilateral direct
and contralateral consensual reflexes are lost as the
afferent optic nerve does not sense the light shown
in affected eye but the contralateral direct and
ipsilateral consensual reflexes are intact as the
efferent oculomotor nerve is normal

## Question 68 of 90

- **A.** Oculomotor nerve
- **B.** Trochlear nerve
- **C.** Trigeminal nerve
- **D.** Optic nerve
- **E.** Abducens nerve

## Question 50 of 81

69. A comatose patient has a respiratory rate of 5 breaths
per minute following an overdose of heroin. He receives
naloxone and his respiratory rate rapidly improves to 16
breaths per minute. Which component of arterial blood gas
sampling is most likely to rapid decrease following this
intervention?
Co2 is vasodilator causes increases cerebral blood
flow (Recall)
Hypoventilation increases C02 and increases
cerebral blood flow
Hyperventilation causes decrease Pco2 and
decreases cerebral blood flow

## Question 69 of 90

- **A.** Base excess
- **B.** Hco3
- **C.** pH
- **D.** Pco2
- **E.** Po2
70. Which one of the following nerves supply the skin
above the eye brow extending back to the vertex of the
scalp?

## Question 70 of 90

- **A.** Zygomaticotemporal nerve
- **B.** Greater occipital nerve
- **C.** Zygomaticofacial nerve

## Question 51 of 81

supraorbital nerve innervating the skin of upper eye
lid and conjunctiva, skin of the upper forehead
extending to the vertex of scalp.
- **D.** Supraorbital nerve
- **E.** Supratrochlear nerve
71. A 30-year-old man presents with symmetrical
ascending muscle weakness. He had a diarrheal illness a
few weeks previously
What is the most likely pathogen?
GBS cases seem to occur after a viral or bacterial
infection like those that cause sore throats or
diarrhea characterized by lower limb weakness,
paresthesia and hyporeflexia

## Question 71 of 90

- **A.** Epstein-Barr virus
- **B.** Cytomegalovirus
- **C.** Clostridium difficle
- **D.** Campylobacter jejuni
- **E.** Borrelia burgdorferi
72. A 71-year-old man with a history of heart failure and
type 2 diabetes mellitus presents with an acutely painful,
swollen first metatarsophalangeal joint. A clinical diagnosis
of gout is made. Which treatment would be most
appropriate for the acute management of this Patient?

## Question 72 of 90

## Question 52 of 81

Management of gout
Acute gout: NSAIDS (specially naproxen) Recall
Gout with heart failure: Colchicine
Chronic gout: Allopurinol also reduces further
attacks of gout by reducing uric acid
Note: In gout under polarized light, gout crystals
appear needle-shaped and yellow, a property called
negative birefringence (Recall)
Gout crystals are monosodium urate crystals
In Pseudo gout: Positive birefringence and
pyrophosphate crystals (Recall).
- **A.** Febuxostat
- **B.** Prednisolone
- **C.** Colchicine
- **D.** Allopurinol
- **E.** Diclofenac
73. Epinephrine cause vasoconstriction by acting on which
receptors?

## Question 73 of 90

- **A.** Beta-2
- **B.** Alpha-1
- **C.** Beta-1
- **D.** AChR

## Question 53 of 81

Alpha 1: vasoconstriction
Alpha 2: vasodilation
Beta 1: centrally increases automaticity, heart rate,
myocardial contractility
Beta 1: Peripherally vasodilates against alpha 1
vasoconstriction
Beta 2 - bronchodilation
- **E.** Alpha-2
74. Mifepristone is indicated in the medical termination of
pregnancy. It acts as an antagonist at which one of the
following receptors?
Mifepristone is an antagonist at progesterone and
glucocorticoid receptors. It stimulates uterine
contractility and increases prostaglandins through
inhibition of prostaglandin dehydrogenase. It also
blocks cortisol receptor binding and reduces excess
cortisol effects is cases of Cushing syndrome.

## Question 74 of 90

- **A.** Dopamine receptors
- **B.** Estrogen receptors
- **C.** Adrenergic receptors
- **D.** Progesterone receptors
- **E.** Muscarinic receptors
75. Which of the following is the site of highest air way
resistance?

## Question 75 of 90

## Question 54 of 81

The medium-sized bronchi actually constitute the
site of highest resistance along the bronchial tree,
although small radii of the alveoli might predict that
they would have highest resistance, they don''t
because of parallel arrangement. In fact, early
changes in resistance in small air ways may be silent
and go undetected because of their small overall
contribution to resistance.
- **A.** Medium sized bronchi
- **B.** Alveoli
- **C.** Smallest bronchi
- **D.** Trachea
- **E.** Largest bronchi
76. A 45-year-old woman with a newly diagnosis of type ii
diabetes has significant hyperglycemia.
What is the most likely cause of her elevated blood
glucose?

## Question 76 of 90

- **A.** Production of abnormal insulin
- **B.** Increased cellular resistance to insulin
- **C.** Reduced glucagon secretion
- **D.** Excessive glucocorticoid production
- **E.** Reduced insulin production by pancreatic beta
cells

## Question 55 of 81

Type 2 diabetes mellitus is characterized by
hyperglycemia, insulin resistance, and relative
impairment in insulin secretion.
78. The mean was calculated for study with normal
distribution. The values distribution around the mean are
measured by?
Standard error of the mean = standard deviation /
square root (number of patients)
High Yield:
Mean or average: is the sum of a collection of
numbers divided by the number of numbers in the
collection
The mode is the value that appears most often in a
set of data
The median is the number separating the higher
half of a data sample, a population, or a probability
distribution, from the lower half. The median of a
finite list of numbers can be found by arranging all
the observations from lowest value to highest value
and picking the middle one
For example, a study looks at the number of
attendances brittle asthmatics have at A&E''s across

## Question 78 of 90

- **A.** Interquartal range
- **B.** Standard deviation
- **C.** Variance
- **D.** Mode
- **E.** Median

## Question 56 of 81

the north of England each quarter. Each A&E
submits the number of attendances as below:
1,3,4,5,5,5,6,7,7,9,12,14,17
Mean = 7.5
Mode = 5
Median = 6
79. In the control of breathing, which of the following
statements is CORRECT?
Involuntary respiration
Involuntary respiration is under subconscious
control. The diaphragm and intercostal muscles are
the primary respiratory muscles. They are
stimulated by groups of neurons located in the
pons and medulla. These neurons form the

## Question 79 of 90

- **A.** Afferents from stretch receptors feed into the
pneumotaxic Centre to modulate breathing
- **B.** The pneumotaxic Centre is located in the
thalamus
- **C.** When expiratory neurons fire they inhibit the
activity of inspiratory neurons
- **D.** Voluntary control of breathing is mediated by
cortical motor neurons directly innervating respiratory
group neurons in the medulla, altering their activity
- **E.** The pons contains dorsal and ventral respiratory
groups that receive input from chemoreceptors.

## Question 57 of 81

respiratory control centre. They send impulses to
the primary respiratory muscles, via the phrenic
and intercostal nerves, which stimulate their
contraction. There are three main groups of
neurons involved in respiration:
The ventral respiratory group controls expiration
The dorsal respiratory group controls inspiration
The pontine respiratory group controls the rate and
pattern of breathing.
Note: When expiratory neurons fire they inhibit the
activity of inspiratory neurons and once the
neurons stop firing, the inspiratory muscles relax,
and expiration occurs.
Voluntary respiration
Voluntary respiration is under conscious control. It is
controlled via the motor cortex in the cerebrum,
which receives inputs from the limbic system and
hypothalamus. Signals are thought to be sent to the
spinal cord from the motor cortex, which are then
passed onto the respiratory muscles.
Central control of breathing
(brainstem and cerebral cortex:
High Yield)
1. Medullary respiratory center
(Recall)
- **A.** Dorsal respiratory group is primarily responsible
for inspiration and generates the basic rhythm for
breathing
Input to the dorsal respiratory group comes from
the vagus and glossopharyngeal nerves. The vagus
nerve relays information from peripheral
chemoreceptors in the lung. The glossopharyngeal
nerve relays information from peripheral
chemoreceptors and Output from the dorsal
respiratory group travels, via the phrenic nerve, to
the diaphragm

## Question 58 of 81

- **B.** Ventral respiratory group is primarily
responsible for expiration, is not active during
normal, quiet breathing, when expiration is passive.
Activated during exercise, when expiration becomes
an active process.
2. Apneustic center is located in the lower pons.
Stimulates inspiration, producing a deep and
prolonged inspiratory gasp (apneusis).
3. Pneumotaxic center is located in the upper
pons. inhibits inspiration and, therefore, regulates
inspiratory volume and respiratory rate.
4.Cerebral cortex: Breathing can be under
voluntary control; therefore, a person can
voluntarily hyper ventilate or hypo ventilate.
Note: Hypoventilation (breath-holding) is limited by
the resulting increase in Pco2 and decrease in P02
81. A 40-year-old woman presents with a lump in the lateral
upper right quadrant of her breast. You are suspicious this
is breast cancer. Which lymph node would be most likely to
be affected first?
The lymphatic drainage of the breast is of great
clinical importance due to its role in the metastasis

## Question 81 of 90

- **A.** Axillary
- **B.** Parasternal
- **C.** Supraclavicular
- **D.** Interpectoral
- **E.** Subclavian

## Question 59 of 81

of breast cancer cells.
There are three groups of lymph nodes that receive
lymph from breast tissue
Axillary nodes (75%): Receives lymphatic drainage
from lateral and superior quadrant of breast
parasternal nodes (20%): Receives lymphatic
drainage from medial quadrant
Note: Breast cancer in axillary tail of breast most
commonly involved lymph node is axillary
(Recall).
82. The greatest increase in physiological dead space
would be expected with which of the following conditions?
Dead Space:  Volume of ventilated air that does not
participate in gas exchange.
Two types of Dead Space;
1: Anatomical Dead Space
2: Physiologic Dead Space
1: Anatomical Dead Space Volume of Air that fills
the conducting Zone of respiration made up by the

## Question 82 of 90

- **A.** Atelectasis
- **B.** Pulmonary embolism
- **C.** Obesity
- **D.** Bronchoconstriction
- **E.** Pneumothorax

## Question 60 of 81

Nose, Trachea, and Bronchi. The value of anatomical
Dead Space is 150 ml.
2: Physiologic or Total Dead Space Anatomic Plus
Alveolar Dead Space (Volume of air in the
Respiratory zone that does not take part in gas
exchange).
Respiratory Zone starts from Respiratory
Bronchioles, Alveolar Duct, Alveolar sac, and Alveoli.
In patients with acute PE, total dead space increases
because lung units continue to be ventilated
despite diminished or absent perfusion.
Causes of Increased Dead Space:
Emphysema
Pneumonia
ARDS(RECALL)
Smoking
ETT intubation
Bronchitis
Asthma
Cardiac Failure
Pulmonary Embolism
Neck Extension
Standing
Hypotension
bronchodilation
Causes of decreased Dead Space:
Atelectasis
Tracheostomy
Sleep
Maxillectomy
Hyperventilation
Neck Flexion
Supine Position
Bronchoconstriction

## Question 61 of 81

83. Regarding the bursae of knee joint, which one of the
following statements is correct?
Bursa: synovial fluid filled sac within joints provide
low friction surfaces for the movement of tendons
associated with joint
Suprapatellar bursa located between the
quadriceps femoris and the femur (Recall)
Prepatellar bursa found between the apex of the
patella and the skin. Housemaid knee is due to
inflammation of Prepatellar bursa
Infrapatellar bursa: split into deep and superficial.
The deep bursa lies between the tibia and the
patella ligament. The superficial lies between the
patella ligament and the skin. Clergyman’s Knee is
due to inflammation of infrapatellar bursa.

## Question 83 of 90

- **A.** Suprapatellar bursa located between the
quadriceps femoris and the femur
- **B.** Prepatellar bursa located in the sartorius
- **C.** Suprapatellar bursa located in the sartorius
- **D.** Housemaid knee is due to inflammation of
infrapatellar bursa
- **E.** Prepatellar bursa found between the quadriceps
femoris and the femur
84. A 32-year-old male with history of trauma to the hand
presents with pain in the right hand associated with tingling
and numbness. You suspect median nerve injury. Which

## Question 84 of 90

## Question 62 of 81

one of the following is the most lateral structure forming the
carpal arch?
Carpal tunnel structures
- **A.** Median nerve
- **B.** Trapezium
- **C.** Hook of hamate
- **D.** Ulnar nerve
- **E.** Pisiform
85. A patient complains of headache and visual loss. CT
scan demonstrate a lesion of the temporal lobe what type
of visual defect would u most expect to see in this patient?

## Question 85 of 90

- **A.** Bitemporal hemianopia
- **B.** Contralateral homonymous superior
Quadrantanopia
- **C.** Contralateral homonymous inferior
Quadrantanopia
- **D.** Contralateral homonymous hemianopia

## Question 63 of 81

Homonymous denotes a condition which affects
the same portion of the visual field of each eye.
Homonymous inferior quadrantanopia is a loss of
vision in the same lower quadrant of visual field in
both eyes whereas a homonymous superior
quadrantanopia is a loss of vision in the same upper
quadrant of visual field in both eyes.
A lesion affecting one side of the temporal lobe may
cause damage to the inferior optic radiations
(known as the temporal pathway or Meyer''s loop)
which can lead to superior quadrantanopia on the
contralateral side of both eyes if the superior optic
radiations (parietal pathway) are lesioned, the visual
loss occurs on the inferior contralateral side of both
eyes and is referred to as an inferior
quadrantanopia.
- **E.** Homonymous hemianopia with macular sparing
86. You are teaching group of medical students anatomy of
inguinal region. You ask medical students Deep inguinal
Ring is a defect in which of the following structure?
Deep inguinal ring is formed by transversalis fascia.

## Question 86 of 90

- **A.** Transversalis fascia
- **B.** Rectus abdominis aponeurosis
- **C.** External oblique aponeurosis
- **D.** Internal oblique aponeurosis
- **E.** Transversus abdominis aponeurosis

## Question 64 of 81

Superficial inguinal ring is formed by External
Oblique. (Recall)
87. A 25 years old woman from sub–Saharan Africa
presents to the ED with complaint of fever and chills. Thick
and thin films reveal malarial parasite. which organism
would most likely be seen?

1. falciparum is the deadliest malaria parasite and the
most prevalent on the African continent. P. vivax is
the dominant malaria parasite in most countries
outside of sub-Saharan Africa.
Note: The Giemsa stain (Thick and thin film.
Recall) is used as the gold standard for the
diagnosis of malaria on blood smears.

## Question 87 of 90

- **A.** Plasmodium falciparum
- **B.** Plasmodium knowlesi
- **C.** Plasmodium vivax
- **D.** Plasmodium malariae
- **E.** Plasmodium ovale
88. you are prescribing ipratropium bromide for a patient
who has presented with an exacerbation of her COPD.
what is mechanism of action of ipratropium bromide?

## Question 88 of 90

- **A.** Alpha agonist

## Question 65 of 81

Ipratropium is an acetylcholine antagonist via
blockade of muscarinic cholinergic receptors.
Blocking cholinergic receptors decreases the
production of cyclic guanosine monophosphate
(cGMP). This decrease in the lung airways will lead
to decreased contraction of the smooth muscles.
- **B.** Beta agonist
- **C.** Ca channel blocker
- **D.** Muscarinic antagonist
- **E.** Muscarinic agonist
89. A 25-year-old woman presents with clinical features of
anaphylaxis. You consider administering intramuscular
adrenaline. Which strength of adrenaline is most
appropriate in this situation?
Adrenaline dose in anaphylaxis: 0.5 mg/ 0.5 ml of
1:1000 adrenaline
Adrenaline dose in cardiac arrest during CPR: 1mg
of 1: 10000 concentration (Recall).

## Question 89 of 90

- **A.** 1:100
- **B.** 1:10
- **C.** 1:1000
- **D.** 1:10,000
- **E.** 1:100,000

## Question 66 of 81

1.
17 years old female presented to the ED with complaint of
fever since 3 days lethargy, stiff neck and non-blanching
skin rash that appears on the lower limb.
What is the most likely diagnosis?

## Question 1 of 90

- **A.** Rheumatic fever
- **B.** Autoimmune TTP
- **C.** HSP
- **D.** Endocarditis
- **E.** Meningococcal Septicemia
3. A 45-Year-old male suffered penetrating trauma to the
parotid gland with facial nerve injury presents with
complaint of inability to purse lips. Which of the following
terminal branch of facial nerve is most likely injured?

## Question 3 of 90

- **A.** Greater petrosal nerve
- **B.** Temporal branch
- **C.** Marginal mandibular branch
- **D.** Zygomatic branch
- **E.** Buccal branch

## Question 67 of 81

7. A 72-year-old woman presents to the ED with a 24-hour
history of blistering rash on the left side of her forehead.
You suspect varicella zoster virus infection (shingles). What
is the most appropriate way to make the diagnosis prior to
starting treatment?
Varicella zoster virus causes:
Chicken pox
Shingles usually affects older

## Question 7 of 90

- **A.** Polymerase chain reaction from skin scraping
sample
- **B.** IgG ELISA serology from blood sample
- **C.** Direct fluorescent antibody staining from skin
scraping sample
- **D.** IgM ELISA serology from blood sample
- **E.** Clinical history and examination alone

## Question 68 of 81

Varicella zoster Key Points
The incubation period is 10 - 21 days (Recall) (mean
time is 14 days).
Primary infection typically occurs in 4-10 years
children
Diagnosis is usually clinical
After primary infection virus lies dormant in
posterior root ganglion and reactivates in 20% of
patients causing shingles
School exclusion period: when all lesions are
crusted over (Recall
10. Damage to Broca''s area will most likely result in which
of the following clinical features?
Broca''s aphasia: This is a non-fluent aphasia which
causes individuals to speak slower. It occurs when
the brain’s frontal lobe suffers damage. Individuals
with Broca’s aphasia often feel frustrated due to
being able to comprehend what others are saying,
but unable to express themselves also called
Expressive dysphasia. Individuals affected only can
speak in very short phrases, or have trouble getting
words out.
Wernicke''s aphasia: This is a fluent aphasia as this
type of aphasia does not affect the speed of the

## Question 10 of 90

- **A.** Receptive dysphasia
- **B.** Visual loss
- **C.** Nystagmus
- **D.** Dysarthria
- **E.** Expressive dysphasia

## Question 69 of 81

individual''s speech. Individuals with this type of
aphasia have damage to their brain’s temporal lobe.
As a result, those of Wernicke''s aphasia are
sometimes unable to comprehend what others are
saying, but are able to speak in long sentences.
However, their communication doesn''t follow
standard grammar patterns and uses made-up
words. also called receptive diaphasia.(RECALL)
11. Regarding preventive measures and spread of infection
of thread worm, which one of the following statements is
correct?
Thread worm is the most common helminth in the
UK, commonly infect children
Mebendazole is the drug of choice and you must
treat everyone in your home even if they do not
have symptoms.

## Question 11 of 90

- **A.** Treat everyone in your home if they have
symptoms only
- **B.** Treat only infected persons with mebendazole
- **C.** Treat infected persons with mebendazole who
have symptoms
- **D.** Do not treat other family members
- **E.** Treat everyone in your home even if they do not
have symptoms

## Question 70 of 81

29. You are asked to review a 16-year-old girl who presents
with a right shoulder dislocation. This is her seventh right
shoulder dislocation within a year. You suspect a
hypermobility or ligament pathology. Which one of the
following ligaments is most likely injured in
acromioclavicular fracture?
Acromioclavicular joint
TYPE= Plane type synovial joint
The acromioclavicular joint consists of an
articulation between the lateral end of the clavicle
and the acromion of the scapula
LIGAMENTS OF THE JOINT
There are three main ligaments that support the
acromioclavicular joint
Acromioclavicular ligament
Conoid ligament
Trapezoid ligament
Collectively, the conoid and trapezoid ligaments are
known as the coracoclavicular ligament. It is the
strongest ligament and suspends weight of the
upper limb

## Question 29 of 90

- **A.** Glenohumeral ligaments
- **B.** Coracoacromial ligament
- **C.** Transverse humeral ligament
- **D.** Coracohumeral ligament
- **E.** Coracoclavicular ligament

## Question 71 of 81

High yield:
The shoulder joint
Type: synovial ball and socket joint
Shoulder joint is formed by the articulation of the
head of the humerus with the glenoid cavity of the
scapula
Ligaments of the shoulder joint:
In the shoulder joint, the ligaments play a key role
in stabilizing the bony structures.
Glenohumeral ligaments (superior, middle and
inferior) They act to stabilize the anterior aspect of
the joint. They are the main source of stability for
the shoulder (Recall), holding it in place and
preventing it from dislocating anteriorly.
Coracohumeral ligament: It supports the superior
part of the joint capsule.
Transverse humeral ligament: This ligament spans
the distance between the two tubercles of the
humerus. It holds the tendon of the long head of
the biceps in the intertubercular groove
Coraco–clavicular ligament: This ligament
composed of the trapezoid and conoid ligaments
and runs from the clavicle to the coracoid process of
the scapula. They work alongside the
acromioclavicular ligament to maintain the
alignment of the clavicle in relation to the scapula.
Coracoacromial ligament. This ligament runs
between the acromion and coracoid process of the
scapula it forms the coraco-acromial arch.  This
structure overlies the shoulder joint, preventing
superior displacement of the humeral head.
Stability of the joint

## Question 72 of 81

Rotator cuff muscles [SITS MUSCLES] Recall
Glenoid labrum: A fibrocartilaginous ridge
surrounding the glenoid cavity
Ligaments: Extra Capsular ligaments form the
coraco-acromial arch.
Biceps tendon – it acts as a minor humeral head
depressor, thereby contributing to stability.
Movements of the shoulder joint: Shoulder joint is
highly mobile ball and socket joint allows various
movements like flexion, extension, adduction,
abduction, medial rotation, lateral rotation and
circumduction

> [!TIP]
> **CLINICAL PEARL:**
> Shoulder joint dislocations
> Anterior shoulder dislocation: Most common
> injury results from forceful abduction, extension
> and external rotation
> Clinical features:
> Arm usually abducted and externally rotated

## Question 73 of 81

Humeral head often palpated anteriorly
Patient cannot touch contralateral shoulder with
hand of affected extremity.
Complications of anterior shoulder dislocation:
Injury to axillary nerve (Recall)
Injury to axillary artery
Injury to rotator cuff
Posterior Shoulder dislocation:  occurs
occasionally results from direct blow to the arm
that produces forceful internal rotation and
adduction.
Clinical features:
Arm usually adducted and internally rotated
Patient unable to perform external rotation
Complications of posterior shoulder dislocation [
less common neurovascular injury]
Fracture of posterior glenoid labrum
Fracture of humeral shaft or lesser tuberosity
Note: Light bulb sign on the X-ray is the diagnostic
feature of posterior shoulder dislocation
38. Bilirubin is a byproduct of heme catabolism and is
excreted in the bile and stool. Bilirubin is likely derived
from?

## Question 38 of 90

- **A.** Enterocytes
- **B.** Mesangial cells

## Question 74 of 81

Heme is an important functional group of
hemoglobin. Bilirubin, which is a byproduct of
heme breakdown, comes from red blood cells. The
liver receives unconjugated bilirubin from the blood
and conjugates it via phase II metabolism to make
it more soluble for excretion via the bile and stool.
Fat cells (adipocytes), skin cells (epithelial cells), and
small intestine absorptive cells (enterocytes) do not
contain heme to be processed into bilirubin.
- **C.** Epithelial cells
- **D.** Adipocytes
- **E.** Red blood cells
46. A 54-year-old man presents with hematemesis. He has
recent diagnosed with a pulmonary embolus and started on
lmwh. What is the most appropriate treatment to prevent
adverse effects of heparin?
Common drugs and their antidote:
Heparin=protamine sulphate
Acetaminophen/paracetamol = Acetylcysteine
Organophosphates =Atropine

## Question 46 of 90

- **A.** Prothrombin complex
- **B.** Heparan sulfate
- **C.** Fresh frozen plasma
- **D.** Dextran sulfate
- **E.** Protamine sulfate

## Question 75 of 81

Digoxin=Digoxin immune fab
Benzodiazepine= flumazenil
Opioid= naloxone
Iron=Deferoxamine
Warfarin=Vitamin K, Fresh frozen plasma,
Prothrombin complex concentrate
Tricyclic antidepressants=Sodium bicarbonate
Calcium channel blocker=Calcium chloride
Theophylline poisoning=beta blocker
Methotrexate=Leucovorin
Aspirin=Sodium bicarbonate
Beta blockers= glucagon
Insulin = glucose
Isoniazid= vitamin B6
49. A 24-year-old female presents with severe headache,
photophobia, and stiffness of her back. Physical
examination reveals positive signs for meningitis. The
attending physician decides to perform a lumbar puncture
to determine if a pathogen is in the CSF. What is the last
structure the needle will penetrate before reaching the
CSF?
Lumber puncture needle Peirce in order:
Skin
Subcutaneous tissue
Supraspinous ligament

## Question 49 of 90

- **A.** Posterior longitudinal ligament
- **B.** Dura mater
- **C.** Ligamentum flavum
- **D.** Pia mater
- **E.** Arachnoid mater

## Question 76 of 81

Inter spinous ligament
ligamentum flavum
Epidural space
Dura
Arachnoid
Sub arachnoid space (contain CSF)
Note: The subarachnoid space is filled with CSF
which is produced by the choroid plexus within the
ventricles of the brain.
54. Fetal hemoglobin shifts the o2 saturation curve to left
due to?
Fetal hemoglobin has a higher affinity for oxygen
than adult hemoglobin. Maternal and Fetal blood
never mix during pregnancy, but they come close
to each other in the placenta.  Oxygen diffuses
easily to fetal hemoglobin here.
The reason fetal hemoglobin has a higher affinity
for 02. It is composed of two alpha and two gamma
subunits, while adult hemoglobin is composed of
two alpha and two beta subunits.
2,3DPG present in RBCs enhance the ability of RBCs
to release o2 near tissue and 2,3DPG only binds
with beta globulin chains, fetal hemoglobin (HbF)

## Question 54 of 90

- **A.** Increased P50
- **B.** Decrease in pH
- **C.** Strongly bind with 2,3DPG
- **D.** Decreased affinity for O2
- **E.** Increased affinity for O2

## Question 77 of 81

lack of beta globulin chains that’s why fetal
hemoglobin has higher affinity for O2(RECALL).
77. A 48-year-old man is found to have a right lower limb
weakness and sensory loss. He also has apraxia. You
suspect a stroke.
Occlusion of which artery is most likely to cause these
symptoms?
High Yield: Clinical effects of occlusion of cerebral
arteries

## Question 77 of 90

- **A.** Basilar artery
- **B.** Posterior communicating artery
- **C.** Internal carotid artery
- **D.** Middle cerebral artery
- **E.** Anterior cerebral artery

## Question 78 of 81

Note: Pontine infarct /Stroke: Results in ipsilateral
facial and contralateral limb weakness (Recall).
80. A study was performed in two group of people one with
heart disease and associated risk factor is compared to
another group with heart but no associated risk factor what
type of study is it?

## Question 80 of 90

- **A.** Cross Sectional
- **B.** Case control
- **C.** Randomised control trials
- **D.** Interventional
- **E.** Cohort

## Question 79 of 81

Case control study:
Retrospective longitudinal observational
study Disease vs non-Disease
Subject to recall bias
Related to ODD Ratio
case-control studies are usually less expensive and
also shorter in duration.
Cohort Study:
Forward Study or Prospective longitudinal
observational study
Group with Risk Factors and Group without Risk
Factors
Related to Relative Risk
Cause to Effect
Compared to case control study, cohort study takes
more time
Cross-sectional:
Cross-sectional observational study
Disease and Risk Factors
Subject to recall bias
90. A 40-year-old patient, known to be an IV drug user,
presents to ED with 15 days history of fever, night sweats
and malaise, and is noted to have a systolic murmur on
examination. You suspect acute infective endocarditis,
which of the following pathogens is the most likely cause?

## Question 90 of 90

- **A.** Staph epidermidis
- **B.** Pseudomonas aeruginosa
- **C.** Staph viridans
- **D.** Streptococcus pyogenes

## Question 80 of 81

0% Complete
Mark as Complete
Previous Next
High Yield:
Most common cause generally: Staph Aureus
(Recall)
Most common cause in IV drug abuser: Staph
Aureus
Most common cause of infective endocarditis in
prosthetic heart valves: Staph epidermidis
Most common cause of infective endocarditis after
tooth extraction surgery: Staph viridians
- **E.** Staphylococcus aureus

## Question 81 of 81',
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
    "updated_at" = now();

  -- Lesson: Mock Iii Paper I
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'mock-iii-paper-i',
    'Mock Iii Paper I',
    'article',
    '# Mock Iii Paper I

> [!NOTE]
> **Instructions:** Single best answer scenario. Read carefully before reviewing the detailed rationale.

Mrcem Primary Complete Course ,High Yield Stuff and Questions Bank ( For
Diet ii Late 2026)
Overview  Comments
Share your score colleagues

LinkedIn  Facebook  Twitter

## Question 13 of 90

1.  A patient was brought into the ED with septic shock.
What is the preferred resuscitation fluid for patients with
Sepsis and Septic Shock?

## Question 1 of 90

- **A.** Normal Saline 0.9%
- **B.** Gelatins
- **C.** Ringer''s lactate
- **D.** Dextran
- **E.** Albumin

## Question 1 of 121

Fluid resuscitation is a critical component to the
emergency department (ED) management of
patients with sepsis and septic shock. Fluids are
administered to patients with sepsis in order to
augment cardiac output and improve tissue
perfusion and oxygenation. Recent evidence has
suggested that the composition of fluids used in
sepsis resuscitation may affect patient-centered
outcomes.
Crystalloid solutions remain the resuscitative fluid of
choice for patients with sepsis and septic shock.
Balanced crystalloid solutions may improve patient-
centered outcomes and should be considered as an
alternative to 0.9% normal saline (when available) in
patients with sepsis. The use of albumin does not
improve mortality in patients with sepsis of any
severity. Hydroxyethyl starch solutions are
associated with increased mortality and should not
be used to resuscitate patients with severe sepsis or
septic shock.
High Yield:
Fluids have traditionally been separated into
crystalloid and colloid solutions. Crystalloid
solutions can be further divided into balanced and
unbalanced solutions. The term balanced solution
is commonly used to refer to solutions that contain
different electrolyte concentrations that more
closely resemble the composition of plasma and
minimally affect acid-base equilibrium. Examples
of balanced solutions include Ringer’s lactate,
Ringer’s acetate, Hartmann’s solution, and
Plasma-Lyte. In contrast, unbalanced solutions do
not have physiologic concentrations of electrolytes
and can adversely affect acid-base equilibrium. The
most common unbalanced fluid solution is 0.9%
normal saline (NS). Colloid solutions primarily
include albumin, hydroxyethylstarch (HES)
solutions, dextrans, and gelatins

## Question 2 of 121

2. A 35-year-old man down a flight of stairs and suffers a
skull fracture. The fracture causes damage to the
mandibular nerve (V3) and has loss of sensation in
preauricular area and outer tympanic membrane. Which
one of the following nerves is likely affected?
Skin around the air, external auditory meatus and
tympanic membrane innervated by
auriculotemporal branch of mandibular division.

## Question 2 of 90

- **A.** Auriculotemporal nerve
- **B.** Lingual nerve
- **C.** Long ciliary nerve
- **D.** Buccal nerve
- **E.** Inferior alveolar nerve

## Question 3 of 121

3. Fever in inflammation is mediated by which one of the
following cytokines?
Interleukin functions:
Mnemonic: Fever Tablet Means Effective
Antipyretics Action
IL-1: Fever

## Question 3 of 90

- **A.** Interleukin-6 (IL-6)
- **B.** Interleukin-1 (IL-1)
- **C.** Tumor Necrosis Factor-alpha (TNF- α )
- **D.** Interleukin-10 (IL-10)
- **E.** Interferon-gamma (IFN- γ )

## Question 4 of 121

IL-2: T cell stimulator
IL-3: Marrow stimulator
IL-4: IgE stimulator
IL-5: Class switching to IgA
IL-6: Stimulates Acute Phase Protein Production
4. Keloids, an abnormal overgrowth of scar tissue, are most
commonly located on which part of the body?
Keloids can occur on any part of the body, but they
are more commonly found on the chest, shoulders,
chin, neck, lower legs and ear lobes.
Keloids are raised, firm, frequently pruritic and
painful, and generally do not spontaneously regress.
A keloid is a growth of dense fibrous tissue that
extends beyond the boundaries of the original
wound. This is different from a hypertrophic scar,
which is typically confined to the original wound
borders and tends to flatten with time.

## Question 4 of 90

- **A.** Foot
- **B.** Face and forehead
- **C.** Abdomen and lower back
- **D.** Chest and shoulders
- **E.** Thigh and Hip

## Question 5 of 121

5. A 65-year-old man with high blood pressure and high
cholesterol was brought into the ED with complaint of motor
and sensory weakness in his right lower limb. Along with
that he had trouble speaking and apraxia. Which one of the
cerebral arteries is likely occluded?
Left ACA is occluded which will result in right
(Contralateral lower limb motor and sensory
weakness) along with dysarthria, dysphasia, apraxia
and urinary incontinence.
High Yield: Clinical effects of occlusion of cerebral
arteries

## Question 5 of 90

- **A.** Anterior cerebral artery
- **B.** Medial cerebral artery
- **C.** Anterior spinal artery
- **D.** Posterior cerebral artery
- **E.** Posterior spinal artery

## Question 6 of 121

6. A 35-year-old male was brought into the ED with
dysphasia, contralateral sensory loss in the face and upper
limb, and contralateral homonymous hemianopia. Which
cerebral artery is most likely affected?
MCA infarct leads to contralateral motor and sensory
deficits usually face/Arm greater than leg

## Question 6 of 90

- **A.** Anterior Cerebral Artery (ACA)
- **B.** Posterior Cerebral Artery (PCA)
- **C.** Anterior choroidal artery
- **D.** Middle Cerebral Artery (MCA)
- **E.** Vertebral Artery

## Question 7 of 121

7. A 44-year-old woman presents to the with ED
complaining of palpitations. She has recently  been started
on Amitriptyline by her GP. What is the mechanism of
tachycardia in Amitriptyline overdose?
Amitriptyline is in the tricyclic antidepressant (TCA)
drug, block the reuptake of norepinephrine and
serotonin from the synaptic cleft, thereby

## Question 7 of 90

- **A.** Histamine receptor blockade
- **B.** Sodium channel blockade
- **C.** α -Receptor blockade
- **D.** Muscarinic receptor blockade
- **E.** Potassium channel blockade

## Question 8 of 121

potentiating the effects of serotonin and
norepinephrine on the postsynaptic receptors. The
TCAs have also been shown to inhibit muscarinic,
histamine, and α -adrenergic receptors, thereby
leading to a host of undesirable side effects.
Anticholinergic effects/parasympathetic blocking
actions are due to muscarinic receptor blockade
(leads to Tachycardia, urinary retention, blurred
vision, acute angle closure glaucoma, confusion,
constipation, and dry
mouth
Note:
Sedation (due to histamine receptor
blockade)
Postural hypotension (due to α  adrenergic receptor
blockade)
cardiac arrhythmias (due to sodium channel
blocker)
9. A 45-year-old woman who has recently undergone
surgery to remove a tumor located near her parotid gland.
The surgery was successful, but she has been
experiencing post-operative discomfort and numbness in
the area around her ear, particularly in her ear lobule and
along her jawline. Which one of the following nerves is
likely affected?

## Question 9 of 90

- **A.** Auriculotemporal nerve
- **B.** Marginal mandibular nerve
- **C.** Greater auricular nerve

## Question 9 of 121

Greater auricular nerve cutaneous branch of the
cervical plexus provides sensory innervation to ear
lobule, skin over the parotid gland and mastoid
process of the temporal bone. Pain of parotitis and
during ear piercing is due to innervation of greater
auricular nerve.
- **D.** Lesser occipital nerve
- **E.** Greater petrosal nerve
10. A 25-year-old male patient exhibits a loss of sensation
and pain at lateral thigh. Which one of the following nerves
is responsible for this?

## Question 10 of 90

- **A.** Anterior cutaneous branches

## Question 10 of 121

High Yield to Remeber:
Anterior division of the femoral nerve
Anterior cutaneous branches
Branch to sartorius
Branch to pectineus
2: Posterior division of the femoral nerve
Saphenous nerve
Branches to quadriceps femoris (Which include
Rectus femoris, Vastus lateralis, Vastus medialis
and Vastus intermedius)
Femoral nerve Sensory innervation of lateral and
posterior thigh: (Important to remember)

> [!TIP]
> **Clinical pearls: Damage to the posterior division of**
> femoral nerve causing impaired flexion at hip and
> impaired extension of the leg resulting from
> paralysis of the quadriceps femoris (Which include
> Rectus femoris, Vastus lateralis, Vastus medialis
> and Vastus intermedius.

Sensory loss: Loss of sensation over anteromedial
thigh, anteromedial knee, medial leg and medial
foot.
- **B.** Lateral cutaneous nerve of thigh
- **C.** Saphenous nerve
- **D.** Posterior cutaneous nerve of thigh
- **E.** Obturator nerve

## Question 11 of 121

11. Which one of the following cells organelles is involved
in protein synthesis?
Cell organelles quick revision:
1: Lysosomes contains hydrolases responsible for
digestion and breakdown of defective proteins
Uterus and breast after pregnancy regress by
lysosomes
2: Mitochondria: Powerhouse responsible for
production of chemical energy in the form of ATP
Unique feature in mitochondria is of own DNA.
3: Endoplasmic reticulum:
Rough endoplasmic reticulum most likely
synthesizes proteins.
Detoxification of drug occurs in smooth
endoplasmic reticulum.
The smooth endoplasmic reticulum serves as a
store for intracellular Ca2+ and is the major site of
lipid production.
4: Golgi body: Secretory vesicles found
The Golgi apparatus packages proteins for delivery
to specific intracellular destinations or into vesicles
which can then be secreted from the cell for
extracellular action.
5: Nucleus contains genetic material and nucleolus
responsible for ribosomes production.

## Question 11 of 90

- **A.** Smooth endoplasmic reticulum
- **B.** Lysosome
- **C.** Rough endoplasmic reticulum
- **D.** Golgi bodies
- **E.** Peroxisomes

## Question 12 of 121

6: Ribosomes: Ribosomes are the cellular structures
where protein synthesis takes place. They can be
found in the cytoplasm (free ribosomes) or attached
to the endoplasmic reticulum (bound ribosomes).
12. Regarding the anatomy of pituitary gland, pituitary
fossa lies inferior to which one of the following structures?
The pituitary gland is a pea-sized structure,
suspended from the underside of the brain by the
pituitary stalk known as the infundibulum. It sits
within a small depression in the sphenoid bone,
known as the Sella turcica or the hypophyseal
fossa or pituitary fossa
The diaphragma sellae is a sheet of dura mater that
forms the superior surface of the pituitary or
hypophyseal fossa.
Note: while the tuberculum sellae is a bony
prominence on the superior surface of the Sella
turcica. If they ask you, bony prominence on the
superior surface of Sella turcica or pituitary fossa
choose tuberculum sellae.

## Question 12 of 90

- **A.** Dorsum sellae
- **B.** Posterior clinoid process
- **C.** Pituitary stalk
- **D.** Diaphragm sellae
- **E.** tuberculum sellae

## Question 13 of 121

13. According to Uk immunization protocol Hep-B vaccine
is given prophylactically in which one of the following
patients?

## Question 13 of 90

- **A.** Sickle cell disease
- **B.** CKD Stage 1
- **C.** Haemophilia
- **D.** Diabetes
- **E.** Splenectomy patient

## Question 14 of 121

Additional vaccines for
individuals with underlying
medical conditions
High Yield
Although the risk of hepatitis B is low in the UK,
children and adults in high-risk groups are also
offered the vaccine.
People who are at risk of getting hepatitis B or
developing serious complications from it should
consider being vaccinated.
These groups include:
people who inject drugs or have a partner who
injects drugs
people who change their sexual partners frequently
men who have sex with men
babies born to infected mothers
close family or sexual partners of someone with
hepatitis B
people who have regular blood transfusions or
blood products, and their carers
people with any form of chronic liver disease or
chronic kidney disease

## Question 15 of 121

people travelling to high-risk countries (Asia,
Africa). Recall
male and female sex workers
people whose work puts them at risk of contact
with blood or body fluids, such as nurses, prison
staff, doctors, dentists and laboratory staff
prisoners
families adopting or fostering children from high-
risk countries
some foster carers
people who live in accommodation for people with
learning disabilities
people who work with people with a severe learning
disability
14. A 60-year-old individual experiences a sudden and
severe injury to their neck while participating in a sporting
event. Shortly after the incident, they find they are unable
to move their legs and have lost the ability to feel pain or
temperature sensation below their waist. However, he
retains some sensation for light touch and proprioception
and can still move their arms and hands. Based on these
symptoms, which one of the following arteries is likely
infarcted?
Anterior cord syndrome results from occlusion of
anterior spinal artery characteristically resulting in
motor paralysis below the level of the lesion as well

## Question 14 of 90

- **A.** Medial cerebral artery
- **B.** Posterior cerebral artery
- **C.** Posterior spinal artery
- **D.** Anterior spinal artery
- **E.** Anterior cerebral artery

## Question 16 of 121

as the loss of pain and temperature at and below
the level of the lesion. There is preservation of
dorsal column function (fine touch, vibration sense,
and proprioception).
Spinal cord syndrome (High
Yield)
15. Why is albumin not freely filtered from the glomerular
basement membrane during the process of glomerular
filtration?

## Question 15 of 90

- **A.** Albumin is positively charged and is repelled by
the negatively charged glomerular basement
membrane.
- **B.** Albumin is too small in size
- **C.** Albumin is negatively charged and is repelled by
the negatively charged glomerular basement

## Question 17 of 121

Glomerular basement membrane: Made up of
matrix of extracellular negatively charged proteins
and other compounds, help restrict the movement
of negatively charged molecules across the
basement membrane. e.g., Albumin
Main site of ultrafiltrate
The basement membrane consists of 3 layers: These
layers help to limit the filtration of intermediate and
large sized solutes e.g., Albumin.
High Yield:
Glomerular filtration barrier
A membrane that selectively allows the passage of
molecules based on size and charge. Plasma is
selectively filtered through glomerular capillary wall
into the bowman’s capsule (Ultrafiltrate = fluid
filtered into bowman’ space)
This barrier has three major components.
1: Glomerular capillary endothelium: It has
fenestrations which allows plasma components
with a molecular weight of <7000 Da to pass freely.
These fenestrations actually do not restrict the
movement of water and proteins or large molecules
but instead prevent the filtration of blood cells (e.g.
RBCs).
Fenestrated endothelium has magnitude greater
than proteins; in addition, the wall is covered with
negatively charged compounds.
membrane
- **D.** Albumin is broken down into smaller molecules
before entering the glomerular filtration barrier.
- **E.** Albumin is selectively reabsorbed in the
proximal convoluted tubules.

## Question 18 of 121

2: Glomerular basement membrane: Made up of
matrix of extracellular negatively charged proteins
and other compounds, help restrict the movement
of negatively charged molecules across the
basement membrane. e.g., Albumin
Main site of ultrafiltrate
The basement membrane consists of 3 layers: These
layers help to limit the filtration of intermediate and
large sized solutes e.g., Albumin.
3: Epithelial cell layer of podocytes: Next to the
bowman’s space; the podocytes have foot processes
directly contacting the basement membrane.
Regular gaps between foot processes (pedicles) are
called filtration slits, across these slits a protein
network forms slit pores in the epithelial lining
which prevent the passage of larger molecules
through this final layer.
Podocytes also exhibit phagocytic and contractile
activity like that of mesangial cells.
16. A 35-year-old male presents to ED with sudden-onset
hypertension, severe headache, and palpitations. The
patient is diaphoretic, and a computed tomography (CT)
scan reveals an adrenal mass consistent with
Pheochromocytoma. The primary mechanism responsible
for the symptoms in this patient involves the activation of?

## Question 16 of 90

- **A.** GABA receptors
- **B.** Dopamine receptors
- **C.** Beta-2 adrenergic receptors
- **D.** Alpha-1 adrenergic receptors
- **E.** Serotonin receptors

## Question 19 of 121

Pheochromocytoma is a rare adrenal gland tumor
that can produce excessive amounts of
catecholamines, including adrenaline and
noradrenaline. The symptoms of
Pheochromocytoma are mainly attributed to the
effects of elevated catecholamines. Activation of
alpha-1 adrenergic receptors plays a key role in the
manifestation of symptoms such as hypertension,
headache, and diaphoresis. Therefore, the primary
mechanism responsible for pheochromocytoma
symptoms is the stimulation of alpha-1 receptors by
increased catecholamines.
Treatment of Pheochromocytoma  (High Yield):
Definitive treatment is by surgical resection of the
tumor.
Prior to surgery, acute crises are treated medically to
control the effects of excess catecholamines.
Medical therapy consists of:
Alpha blocker (phenoxybenzamine), followed by
Beta blocker (propranolol). Beta adrenoceptor
blockade can be instituted to control tachycardia.
Beta blockers must never be given before alpha-
blocker as this may cause a paradoxical rise in blood
pressure due to unopposed a-mediated
vasoconstriction.
17. A 23-year-old man is involved in a fight outside a
nightclub. He is cut across the face with the edge of a
broken glass. Upon examination he has a lesion in the
facial nerve, and he is unable to close his eyes. Which one
of the following muscles is likely affected?

## Question 17 of 90

- **A.** Levator palpebrae superior
- **B.** Procerus

## Question 20 of 121

Orbicularis oculi
Orbicularis oculi (Closes the eyelids): The
orbicularis oculi muscle is innervated by the
branches of facial nerve and closes the eyelids. Loss
of function of the orbicularis oculi causes an inability
to close the eyelids tightly and a drooping of the
lower eyelid (ectropion) resulting in spillage of tears.
This leads to drying of the cornea. The orbicularis
oculi muscle has three distinct parts: palpebral,
lacrimal and orbital part.
Actions:
Palpebral part: gently closes the eyelids.
Lacrimal part: involved in the drainage of tears.
Orbital part: tightly closes the eyelids.
Other muscles: (High Yield)
The levator palpebrae superioris muscle:
innervated by the oculomotor nerve and acts to
raise the upper eyelid. Loss of function of the levator
palpebrae superioris muscle results in a complete
ptosis.
The superior tarsal muscle is innervated by
postganglionic sympathetic fibres from the superior
cervical ganglion, which helps to maintain upper
eyelid opening. Loss of function of the superior
tarsal muscle results in a partial ptosis.
Tarsal plate: The tarsal plates are located deep to
the orbicularis oculi muscle. There are two plates;
the superior tarsus (upper eyelid) and inferior tarsus
(lower eyelid).
The tarsal plate in the eyelid provides structural
support, serves as an attachment site for muscles,
houses meibomian glands, and helps distribute
tears, distributed tear film can help flush away
- **C.** Corrugator supercilli
- **D.** Orbicularis oculi
- **E.** Superior tarsal muscle

## Question 21 of 121

foreign particles and potential pathogens, reducing
the risk of infection.
In the tarsal plates lie the Meibomian glands (also
known as tarsal glands). These are a specialised type
of sebaceous gland that secretes an oily substance
onto the eye to slow the evaporation of the eye’s
tear film. The oily substance also prevents the
eyelids from sticking together when closed.

> [!TIP]
> **Clinical pearls: Dysfunction in these glands, often**
> due to blockages or inflammation, can lead to
> reduced tear stability and dry eye.

Facial nerve terminal branches in
parotid gland:(High Yield)
The cervical branch: innervating the platysma
muscle.
The temporal branch: innervating muscles in the
temple, forehead muscles (frontalis) and
supraorbital areas (upper half of orbicularis oculi
muscle)
The zygomatic branch: innervating muscles in the
infraorbital area (Lower half of orbicularis oculi
muscle), the lateral nasal area and the upper lip
The buccal branch: innervating muscles in the
cheek and upper lip
The marginal mandibular branch: innervating
muscles of the lower lip and chin
High yield:
The chorda tympani branch of the facial nerve
supplies taste sensation to the anterior 2/3 of the
tongue.
In the anterior 2/3, general sensation is supplied by
the trigeminal nerve (CNV). Specifically, the lingual
nerve, a branch of the mandibular nerve (CN V3).
The posterior 1/3 of the tongue both touch and taste
are carried by the glossopharyngeal nerve (CNIX)
19. A 50-year-old farmer was presented to the emergency
department after sustaining an injury to his thigh while

## Question 19 of 90

## Question 22 of 121

working in his farm''s field. He had accidentally stepped on
a rusty piece of metal. The wound was deep and dirty, but
he initially did not seek immediate medical attention. Over
the course of the next 48 hours, he experienced increasing
pain, swelling, development of foul-smelling and crepitus
noted in his thigh with rapid spread. Which one of the
following organisms most likely caused this condition?
Gas Gangrene: Caused by Clostridium perfringens.
Clinical features
pain
Oedema or swelling
skin discoloration
crepitus (gas gangrene)
diminished pedal pulses and ankle-brachial index
(ischaemic gangrene)
low-grade fever and chills (infectious gangrene)
High Yield:
Clostridium Species
All the Clostridium species are Gram +Ve spore
forming obligate anaerobes.
- **A.** Clostridium tetani
- **B.** Staph Aureus
- **C.** Clostridium difficile
- **D.** Clostridium perfringens
- **E.** Clostridium botulinum

## Question 23 of 121

20. A 45-year-old patient is scheduled to undergo elective
knee arthroscopy due to persistent joint pain. The
anesthesiologist decides to administer Bupivacaine, a local
anesthetic, to manage perioperative pain effectively. The
primary mechanism of action of Bupivacaine is?
The local anesthetics (Bupivacaine) work by
blocking voltage-gated Na+channels in nerve cell
membranes, thus inhibiting the influx of sodium
ions and preventing the initiation and conduction
of nerve impulses.
Local anesthetic drugs: (High
Yield)

## Question 20 of 90

- **A.** Blockade the GABA-gated chloride channels
- **B.** Blockade of voltage-gated sodium channels
- **C.** blockage of Magnesium channels
- **D.** Stimulation of voltage-gated N-type calcium
channels
- **E.** Activation of ligand-gated potassium channels

## Question 24 of 121

21. A patient presents to the emergency department with a
penetrating injury just inside the bowel wall. The next layer
involved is the?
In this scenario, the injury has penetrated just
inside the bowel wall, indicating that it has
breached the serosa layer. The next layer, which is
affected by the injury, is the muscularis propria.
The layers of the GI tract, from outermost to
innermost
Serosa or adventitia lined with visceral peritoneum.
Muscularis propria
Submucosa
Mucosa

## Question 21 of 90

- **A.** Muscularis propria
- **B.** Mucosa
- **C.** Subserosa
- **D.** Submucosa
- **E.** Serosa

## Question 25 of 121

High yield:
Anterolateral abdominal wall layers:
Skin
Subcutaneous tissues (further divided into the
superficial Camper’s fascia and the deeper Scarpa’s
fascia)
External oblique muscle
Internal oblique muscle
Transversus abdominis muscle
Transversalis fascia
Parietal peritoneum
Note: The mucosa is the innermost layer
responsible for absorption and secretion in the
digestive process. If they ask you in simple inner
most layer choose mucosa or outer most bowel wall
layer choose serosa.
22. A 78-year-old man requires treatment with an antibiotic.
He takes warfarin for atrial fibrillation. What antibiotic is the
safest choice for this patient?

## Question 22 of 90

- **A.** Co-trimoxazole

## Question 26 of 121

Antibiotics considered to be high-risk for interaction
with warfarin include Co-trimoxazole, ciprofloxacin,
levofloxacin, metronidazole, fluconazole,
azithromycin, and clarithromycin.
Low-risk antibiotics include clindamycin and
cephalexin.
High Yield:
Monitoring: Both PT and aPTT are prolonged after
warfarin administration but PT is more
prolonged. Warfarin therapy is typically monitored
using the prothrombin time (PT) test along with
the International Normalized Ratio (INR), rather
than the activated partial thromboplastin time
(aPTT)  test.
Patient on warfarin therapy
Managing the patients with increased INR
and bleeding
If INR> 8 and no bleeding = Phytomenadione orally
If INR> 8 and minor bleeding = Phytomenadione Iv
If INR> 8 and major bleeding = Phytomenadione Iv
and dried prothrombin complex (Recall)
If INR 5-8 and no bleeding = Withhold warfarin
If INR 5-8 and minor bleeding = Phytomenadione Iv
- **B.** Cefalexin
- **C.** Clarithromycin
- **D.** Doxycycline
- **E.** Ciprofloxacin
23. A 30-year-old man is involved in a road traffic accident
and suffers a serious injury to his right thigh. As a
consequence of his injury, he damages the obturator canal.

## Question 23 of 90

## Question 27 of 121

Which one of the following clinical manifestations is
possible?
The obturator canal transmits the obturator nerve and vessels,
which primarily supply the muscles of the medial thigh.
Damage to the obturator canal could result in motor and
sensory deficits in medial thigh
Obturator nerve
Nerve roots: L2-L4
Motor functions: Innervates the medial thigh
muscles.
Sensory functions: Upper medial thigh via
cutaneous branches
Anatomical course: Arises from the lumbar plexus
formed within psoas major muscle and enters the
thigh through obturator canal. (a small opening in
the superior aspect of the obturator foramen)
Note: The obturator nerve innervates all of the
muscles of the medial compartment of the thigh
(except for the hamstring part of the adductor
magnus innervated by the tibial portion of the
sciatic nerve).
Clinical: Damage to the obturator nerve causes
weakness of adduction, resulting in a lateral
swinging of the limb during walking
Sensory Loss: Loss of sensation over upper medial
thigh
- **A.** Medial thigh motor loss
- **B.** Lateral thigh motor loss
- **C.** Anterior thigh Sensory loss
- **D.** Anterior thigh motor loss
- **E.** Posterior compartment motor and sensory loss

## Question 28 of 121

24. A 40 year old lady patient arrives in the ED complaining
of severe right hypochondrium pain. The diagnosis points
towards acute cholecystitis. What hormone plays a pivotal
role in triggering gallbladder contractions, contributing to
the pain in this condition?
Right hypochondrium pain due to Cholecystitis is
primarily caused by increased levels of
Cholecystokinin (CCK). This hormone is released in
response to the presence of fatty foods, stimulating
the contraction of the gallbladder and leading to
heightened pressure, contributing to the pain in
the upper right abdomen.

## Question 24 of 90

- **A.** Gastrin
- **B.** Somatostatin
- **C.** Cholecystokinin (CCK)
- **D.** Insulin
- **E.** Glucagon
25.  A 12-year-old boy presents with clinical complaints of
dark urine, facial swelling, and elevated blood pressure
following a recent streptococcal throat infection. Further
evaluation suggests acute glomerulonephritis. What type of
immune complex is commonly associated with kidney
damage in this post-streptococcal glomerulonephritis?

## Question 25 of 90

- **A.** igD
- **B.** igA

## Question 29 of 121

Post-streptococcal glomerulonephritis is a specific
type of Acute glomerulonephritis that occurs 1-2
weeks after infection, typically associated with the
deposition of IgG immune complexes in the
glomeruli, leading to inflammation and kidney
damage. An infection by a nephritogenic strain of
group A beta-hemolytic streptococcus bacteria
initiates a type III hypersensitivity reaction, where
immune complexes are formed composed of
antigens and antibodies, most often igG but in 50%
cases igM also.
Compliment levels C3 are high
Note: (High Yield)
igA nephropathy also known as berger disease
most common cause of nephritic syndrome occurs
1-2 days after infection (Gastrointestinal, respiratory
or UTI) typically associated with Henoch Schönlein
purpura, Celiac disease and liver disease.
Compliment levels C3 are low.
Goodpasture''s Syndrome is a type-II
hypersensitivity disease caused by anti-basement
membrane antibodies against collagen in
glomerular and pulmonary capillaries. It begins with
hemoptysis and ends with renal failure.
Clinical features: Hemoptysis, dyspnea and possible
respiratory failure.
- **C.** igE
- **D.** igG
- **E.** T cells
26. Which one of the following selective vaccines is given
to health care professionals annually?

## Question 26 of 90

- **A.** Hepatitis B

## Question 30 of 121

Selected vaccines
BCG vaccine is recommended for healthcare
workers who may have close contact with infectious
patients. It is particularly important to test and
immunize staff working in maternity and paediatric
departments and departments in which the
patients are likely to be immunocompromised, e.g.
transplant, oncology and HIV units.
Hepatitis B vaccination is recommended for
healthcare workers who may have direct contact
with patients’ blood or blood-stained body fluids.
Influenza immunisation helps to prevent influenza
in staff and may also reduce the transmission of
influenza to vulnerable patients. Influenza
vaccination is therefore, recommended for
healthcare workers directly involved in patient care,
who should be offered influenza immunisation on
an annual basis.
Varicella vaccine is recommended for susceptible
healthcare workers who have direct patient contact.
Those with a definite history of chickenpox or
herpes zoster can be considered protected.
Healthcare workers with a negative or uncertain
history of chickenpox or herpes zoster should be
serologically tested and vaccine only offered to
those without the varicella zoster antibody.
- **B.** Influenza
- **C.** BCG Vaccine
- **D.** Varicella vaccine
- **E.** Rota virus
27. A 30-year-old man presents to the ED with sports injury.
Which one of the following ligaments is torn in fracture of

## Question 27 of 90

## Question 31 of 121

coronoid process of ulna?
The ulnar collateral ligament referred as Medial
collateral ligament (MCL) of the elbow originates
from the medial epicondyle and attaches to the
coronoid process and olecranon of the ulna.
Ligaments of the elbow joint: (High
Yield)
The radial collateral ligament is found on the lateral
side of the joint, extending from the lateral
epicondyle and blending with the annular
ligament.
The ulnar collateral ligament referred as Medial
collateral ligament (MCL) of the elbow originates
from the medial epicondyle and attaches to the
coronoid process and olecranon of the ulna.
Annular ligament: Annular ligament stabilizes the
elbow joint and is a strong band of fibers that
encircles the head of the radius and holds it in
contact with the radial notch of the ulna

> [!TIP]
> **Clinical pearl:**
> Elbow dislocation: Mostly posterior occurs due to
> fall on hand with the elbow flexed
> Complications: The ulnar collateral ligament is
> usually torn and there can also be ulnar nerve
> involvement.

- **A.** Annular ligament
- **B.** Radial collateral ligament
- **C.** Coracoacromial ligament
- **D.** Medial collateral ligament
- **E.** Coracohumeral ligament

## Question 32 of 121

28. A mother is positive for hepatitis B surface antigen
gives birth recently. Which of the following is the most
appropriate next step for the baby?
Administration of both hepatitis B vaccine and
immunoglobulin- Transmission of hepatitis B
infection to babies of infected mothers is reduced
by 95% if both vaccine and immunoglobulin are
given early.
Selective immunization schedule:
Babies born to hep-B infected mother: Vaccine at
birth, 4 weeks and 12 months.
Usual site of Hep-B Vaccine is thigh.
Selective immunisation
programmes

## Question 28 of 90

- **A.** Treatment only if the baby tested positive for
hepatitis B surface antigen
- **B.** Administration of hepatitis B immunoglobulin
- **C.** Administration of both hepatitis B vaccine and
immunoglobulin
- **D.** Administration of hepatitis B vaccine
- **E.** No treatment required

## Question 33 of 121

29. The anaesthetic team are called to the resus area of
your ED to intubate a trauma patient. His age is 25.
Following successfully intubating the patient they set up the
ventilator and prepared to transfer him to ICU. What is the
approximate tidal volume in an average sized, healthy
young male?
The tidal volume is the volume of air displaced
between normal inhalation and normal exhalation.
In a healthy, young adult male tidal volume is
approximately 500 ml per inspiration or 7 ml/kg.
Lung volume and
capacities (High Yield)
Tidal Volume (TV): The volume of air that is inhaled
and then exhaled with each normal breath.
Normal tidal volume is 500ml or 7ml/kg.
Inspiratory Reserve Volume (IRV): The maximum
volume of air that can be inhaled following and
above a normal tidal inspiration.
Normal Inspiratory reserve volume (IRV) is 3300ml.
Expiratory Reserve Volume (ERV): The maximum
volume of air that can be exhaled from the resting

## Question 29 of 90

- **A.** 7 ml/kg
- **B.** 4 ml/kg
- **C.** 15 ml/kg
- **D.** 17 ml/kg
- **E.** 20 ml/kg

## Question 34 of 121

expiration of tidal volume.
Normal Expiratory reserve volume (ERV) is 1700ml.
Residual Volume (RV): The volume of air that
remains in the lung following a maximum
expiration.
Residual Volume cannot be measured using
spirometry.
Normal residual volume is 1800ml.
Capacities
Inspiratory Capacity (IC): is the maximum volume
of air that can be inhaled at the end of resting
expiration.
Inspiratory capacity is sum of IC= TV+ IRV
Functional Residual Capacity (FRC): the volume of
air remaining in the lungs at the resting end-
expiratory level or Volume remaining in the lungs
after tidal volume is expired in air.
FRC is sum of: FRC= ERV+ RV
FRC include Residual volume so FRC cannot be
measured using spirometry.
Normal FRC is 3500ml.
Factors affecting FRC.
Factors increasing FRC: Emphysema, Air trapping
in asthma, Ageing (due to loss of elastic properties)
and Increasing height of patient.
Factors decreasing FRC: Restrictive ventilatory
defects e.g., pulmonary fibrosis, Posture - lying
supine, Increased intra-abdominal pressure (e.g.,
obesity, pregnancy, ascites) and Reduced muscle
tone of diaphragm e.g., muscle relaxants in
anesthesia, neuromuscular disease.
Vital Capacity (VC) is the maximum volume of air that may be
exhaled following a maximum inspiration OR inhaled
following a maximum expiration.
VC= IRV+TV+ ERV OR VC= IC+ERV

## Question 35 of 121

Normal VC in young adult (70kg) is 5500ml.
Total Lung Capacity (TLC) is the volume of air
contained within the lungs following a maximum
inspiration.
TLC include Residual volume so it cannot be
measured using spirometry.
TLC= IRV + TV+ ERV + RV OR TLC= IC + FRC Or TLC =
VC+ RV
Normal TLC in young adult (70kg) is 7300ml.
Forced expiratory volume (FEV1)
FEV1 is the volume of air that can be expired in the
first second of a forced maximal expiration.
FEV1 is normally 80% of the forced vital capacity,
which is expressed as
FEV1/ FVC = 0.8
In obstructive lung disease such as asthma and
chronic obstructive pulmonary disease (COPD), both
FEV1 and FVC are reduced, but FEV1 is reduced
more than FVC. FEV1/FVC ratio is less than 0.7.
In restrictive lung disease such as fibrosis, both
FEV1 and FVC are reduced, but FEV1 is reduced less
than FVC is thus, Fev1 /FVC increased.
Lung volume measurements
and Peak Expiratory flow rate:
Lung volume can be measured with Spirometry.
Residual volume cannot be measured using
spirometry.
Residual volume and thus (FRC and TLC) can be
measured using helium dilution.
Peak Expiratory flow rate:
The easiest and quickest measurement is the peak
expiratory flow rate (PEFR)
Airway resistance and lung compliance can be
assessed indirectly by measuring the forced
expiratory flows and volumes.
Lung volumes can be measured with spirometry.

## Question 36 of 121

PEFR is reduced if airway resistance is increased in
obstructive disease and is commonly used to
monitor asthma.
30. A 26-year-old man has suffered a fracture of mid shaft
of humerus. On examination he has extensor weakness of
the wrist and metacarpophalangeal joints, which has
resulted in wrist drop and inability to grip with his right
hand. Extension of the elbow is preserved. Where would
you see sensory loss in this injury?
Mid Shaft humerus fracture and wrist drop goes
with radial nerve injury.
Radial nerve Superficial branch (sensory):
contributes to the cutaneous innervation of the skin
of dorsal hand and lateral three and half fingers.
radial nerve injury

## Question 30 of 90

- **A.** Medial dorsal hand
- **B.** Dorsum of hand 1st web space
- **C.** Lateral palm of hand
- **D.** Palmar surface of lateral three fingers
- **E.** Dorsum of hand little finger

## Question 37 of 121

Radial Nerve: (High Yield)
The radial nerve is the terminal continuation of the
posterior cord of the brachial plexus.
Radial nerve arises from the posterior cord and
the largest branch of the brachial plexus.
The nerve arises in the axilla region, where it is
situated posteriorly to the axillary artery, descends
posteriorly between the long and medial heads of
the triceps, after which it passes inferolaterally with
the profunda brachii artery in the spiral (radial)
groove on the posterior surface of the humerus
between the medial and lateral heads of the
triceps. Pierces the lateral intermuscular septum to
enter the anterior compartment and descends
anterior to the lateral epicondyle between the
brachialis and brachioradialis muscles to enter the
cubital fossa, where it divides into superficial and
deep branches.
Deep branch (motor): innervates the muscles in the
posterior compartment of the forearm and
continues as posterior interosseous nerve
Superficial branch (sensory): contributes to the
cutaneous innervation of the skin of dorsal hand
and lateral three and half fingers.
Other branches which give cutaneous innervation
to skin of upper limb.
Lower lateral cutaneous nerve of arm: Innervates
the lateral aspect of the arm, inferior to the insertion
of the deltoid muscle.
Posterior cutaneous nerve of arm: Innervates the
posterior surface of the arm.

## Question 38 of 121

Posterior cutaneous nerve of forearm: Innervates a
strip of skin down the middle of the posterior
forearm.
Wrist Drop:
Injury to the radial nerve is commonly caused by a
fracture of the midshaft of the humerus. It results
in loss of function in the extensors of the forearm,
hand, metacarpals, and phalanges. It also results in
the loss of wrist extension, leading to wrist drop,
and produces weakness of abduction and
adduction of the hand.
Note: When the radial nerve is injured in proximal
humerus fracture triceps brachii muscle will be
affected and patient presents with unable to
extend at the forearm. While midshaft of humerus
fracture triceps brachii will remain spared
32. A patient was brought into the ED with signs and
symptoms of meningococcal disease, what advice will you
give to staff members regarding post exposure
prophylaxis?

## Question 32 of 90

- **A.** No indication
- **B.** Perform blood and LP
- **C.** Antibiotics

## Question 39 of 121

Chemoprophylaxis (Antibiotics) is administered as
soon as possible after exposure, ideally less than 24
hours after identification of an index patient.
Rifampin, ciprofloxacin, and ceftriaxone are
90%-95% effective in reducing nasopharyngeal
carriage of N. meningitidis and are all acceptable
antimicrobial agents for chemoprophylaxis.
The indications for chemoprophylaxis
implementation are as follows.
Close contact with a patient within 7 days before
the disease onset, regardless of vaccination status.
"Close contact" applies to:
Household members living with a sick person
People who are in intimate contact with the patient
People sleeping in the same bedroom with the
patient (students, soldiers, officers)
People who have been in direct contact with
secretions from the patient''s respiratory tract during
medical procedures, including mouth-to-mouth
resuscitation, suctioning, and endotracheal
intubation, before or less than 24 hours after
antimicrobial therapy was initiated
People traveling with the patient in the same plane,
ship, bus, or car for longer than 8 hours
Note: You will advise all to avoid close contact and if
close contact has occurred chemoprophylaxis
indicated in less than 24 hours.
- **D.** Wash hand with soap
- **E.** Indication of vaccine
33. A 12-year-old boy presents with evidenced by dark
stools (melena). He has had no other gastrointestinal
symptoms and is otherwise healthy. Considering his age
and the symptom pattern, Meckel''s diverticulum is
suspected. Which one of the following is the most common
mode of presentation in this child?

## Question 33 of 90

## Question 40 of 121

Meckel''s Diverticulum:
True diverticula of all 3 layers of the small intestines
Caused by incomplete obliteration of the vitelline
duct.
Rule of 2s: 2 years old, 2 ft from ileocecal valve, 2 in
long, 2% of population
Usually, asymptomatic
Painless bleeding due to an ulcer caused by
heterotopic gastric tissue most common
presentation in children
Obstruction is caused by intussusception, volvulus,
and hernia, the most common presentation in
adults.
- **A.** Persistent fever and diarrhea
- **B.** Bleeding
- **C.** Obstruction
- **D.** Diverticulitis
- **E.** Hernia
34. Which of the following errors is considered if the
researcher states that there is no difference when one
exists?

## Question 34 of 90

- **A.** Type III error
- **B.** Type 1 error
- **C.** Type II error
- **D.** Type-4 error

## Question 41 of 121

Examples of Type 1 and Type 2 errors: (In simple
type 1 is false positive and type 2 is false negative.
Researcher states that there is no difference when
one exists that means there is actual difference, and
researcher made a mistake is type 2 error.
Researcher states that there is difference when it
does not exist that means there is no difference, and
researcher made a mistake is type 1 error.
Example of fire alarm: False firearm leading to
inconvenience. (Creates trouble but actually the
alarm is false is type 1 error.
Missed fire alarm leading to disaster is type-2 error.
Type I error (false positive): the test result says you
have coronavirus, but you actually don’t.
Type II error (false negative): the test result says you
don’t have coronavirus, but you actually do.
- **E.** No-Error
35. A new blood test to screen patients for heart failure is
trialled on 500 patients. The test was positive in 40 of the
50 patients shown to have heart failure by
echocardiography. It was also positive in 20 patients who
were shown not to have heart failure. What is the positive
predictive value of the test?

## Question 35 of 90

- **A.** 0.66
- **B.** 0.1
- **C.** 0.33
- **D.** Cannot be calculated
- **E.** 0.8

## Question 42 of 121

Positive predictive value can be calculated as: TP /
(TP + FP) = 40 / (40 + 20) = 0.66
Heart failure: (Disease present)
Test positive or True positive (TP)= 40
Test negative or False negative (FN) 10
No heart failure (Disease absent)
Test positive or False positive (FP)= 20
Test negative or True negative (TN)= 430
High Yield:
36. A 60-year-old patient was involved in a road traffic
accident and subsequently complained of unable to
perform extension of thigh at hip and flexion at knee joint.
Which one of the following nerves is likely affected?

## Question 36 of 90

- **A.** Obturator nerve

## Question 43 of 121

All the muscles of the posterior compartment of
thigh are extensors of thigh at hip and flexors at
knee joint. While Biceps femoris is also lateral
rotator of thigh at hip joint and Semitendinosus and
Semimembranosus also medial rotators of thigh at
hip joint

> [!TIP]
> **Clinical pearls: All the muscles of the posterior**
> thigh originate from the ischial tuberosity of the
> pelvis. In some cases, mostly in young athletes,
> sudden and forceful contraction of the hamstring
> muscles can result in an avulsion fracture of the
> ischial tuberosity. It can also be associated with
> sciatic nerve damage.

- **B.** Common peroneal nerve
- **C.** Saphenous nerve
- **D.** Sciatic nerve
- **E.** Femoral nerve
37. A 50-year-old male presents to the ED with complaint of
pain and numbness in his lower limb. On further
examination he has loss of sensation in lower leg near the
medial malleolus. Which one of the following dermatomes
is likely affected?

## Question 37 of 90

- **A.** L5
- **B.** L4
- **C.** L3

## Question 44 of 121

High Yield:
Dermatomes of Lower extremity: Important to
remeber all the landmarks of dermatomes
L1: The inguinal region and the very top of the
medial thigh, Upper anterior thigh
L2: The middle and lateral aspect of the anterior
thigh.
L3: Medial knee (Medial femoral condyle)
L4: Medial malleolus, Medial surface of big toe
L5: Toes 2-3,4, lateral surface of big toe and Dorsal
and plantar aspects of foot
S1: Toe 5 (Little finger), lateral malleolus
S2: At the midpoint of the popliteal fossa.
S3: At the horizontal gluteal crease (fold of the
Buttocks), Ischial tuberosity
S4/5: The perianal area.
- **D.** L1
- **E.** L2
38. When the Renin-angiotensin-aldosterone system is
activated, it plays a crucial role in regulating renal blood
flow and filtration in response to various physiological
signals. Angiotensin-II, a key component of this system,
increases Glomerular Filtration Rate (GFR) by which
mechanism?

## Question 38 of 90

- **A.** Constriction of efferent arterioles
- **B.** Inhibition of tubular reabsorption
- **C.** Relaxation of Glomerular capsule
- **D.** Dilatation of efferent arterioles

## Question 45 of 121

Angiotensin-II (AT-II) preferentially constricts renal
efferent arterioles, resulting in increased
glomerular filtration rate (GFR) and decreased renal
plasma flow (RPF). Thus,
Angiotensin II production (High Yield)
Angiotensinogen is a precursor protein produced in
the liver and cleaved by renin to form angiotensin I.
Angiotensin I is then converted to angiotensin II
by angiotensin converting enzyme (ACE). This
conversion occurs mainly in the lungs where ACE is
produced by vascular endothelial cells, although
ACE is also generated in smaller quantities within
the renal endothelium.
Functions of angiotensin II
Angiotensin 2 acts on AT1 receptors found in the
endothelium of arterioles throughout the
circulation to achieve vasoconstriction. The net
effect of this is an increase in total peripheral
resistance and consequently, blood pressure.
Angiotensin II acts at the hypothalamus to stimulate
the sensation of thirst, resulting in an increase in
fluid consumption. This helps to raise the circulating
volume and in turn, blood pressure.
It also increases the secretion of ADH from
the posterior pituitary gland – resulting in the
production of more concentrated urine to reduce
the loss of fluid from urination.
Angiotensin II acts on the adrenal cortex to
stimulate the release of aldosterone from zona
glomerulosa of the adrenal cortex. Which in turn
causes increased Na reabsorption and K loss. It also
stimulates the sympathetic nervous system to
increase the release of noradrenaline (NA). which in
turn increases cardiac output, release of renin,
vasoconstriction of arterioles.
- **E.** Dilatation of afferent arterioles

## Question 46 of 121

Causes vasoconstriction of renal arterioles
predominantly efferent arterioles thereby
maintaining or increasing the GFR
Activation of Na-H pump thereby increasing the
reabsorption of Na from proximal tubule.
Inhibits the renin production from granular cells of
JG apparatus (negative feedback)
producing a net increase in filtration fraction
(Filtration Fraction = GFR/RPF).
40. A 35-year-old male patient brought into the ED with
femoral fracture Requiring general anesthesia for surgery.
Which one of the following glands inhibited is most
responsible for saliva production during GA?
During General Anesthesia, the parotid gland is
the major salivary gland most responsible for
saliva production, and it is more likely to be
affected by the anesthesia-induced inhibition of
salivation compared to the sublingual gland.
Parotid Gland: The parotid gland is primarily
responsible for producing serous saliva. During GA,
the parasympathetic nervous system is suppressed,
which can lead to a significant reduction in saliva
production from the parotid gland.

## Question 40 of 90

- **A.** Parotid gland
- **B.** Sub mandibular
- **C.** Sublingual
- **D.** Thyroid gland
- **E.** Adrenal gland

## Question 47 of 121

Sublingual Gland: The sublingual gland primarily
produces mucous saliva. While it is also influenced
by the autonomic nervous system, the effect of GA
on the sublingual gland may not be as pronounced
as on the parotid gland. The reduction in saliva from
the sublingual gland is typically less significant
during GA.
42. Which one of the following is midbrain structure?
Brainstem:
Consists of midbrain, pons and medulla.
Mid brain:
Smallest of the three regions lies predominantly in
the posterior cranial fossa.
It can be divided into two main parts:
Tectum: located posterior to the cerebral aqueduct
The tectum houses four rounded prominences
named colliculi (collectively the corpora
quadrigemina) which sit directly inferior to the
pineal gland. The colliculi are separated by the
cruciform sulcus; there are two superior and two
inferior colliculi.

## Question 42 of 90

- **A.** Carpus callosum
- **B.** Medulla
- **C.** Colliculi
- **D.** Cerebral aqueduct
- **E.** Pons

## Question 48 of 121

Paired cerebral peduncles: located anteriorly and
laterally extend from the cerebral hemispheres to
converge as they meet the pons. They are separated
anteriorly in the midline by the interpeduncular
fossa
The oculomotor nerve (CNIII) is seen exiting from
between the peduncles while the optic tract runs
around the superior border of the midbrain.
Note: Dopaminergic neurons are essential for
controlling key functions of the brain, such as
voluntary movement, reward processing, and
working memory. The largest populations of these
neurons sit within the midbrain in substantia nigra.
Vasculature of the mid brain:
The midbrain receives vascular supply from the
basilar artery, and its branches. The major vessels
are:
Posterior cerebral artery and its peduncular branch
Superior cerebellar artery
Posterior choroidal artery
Interpeduncular branches of the basilar artery
43. A patient presents with difficulty breathing and
diminished breath sounds on auscultation. The chest X-ray
reveals lung collapse and further evaluation it was found

## Question 43 of 90

## Question 49 of 121

lung surfactant is reduced. Which one of the following lung
volumes affected?
lung collapse, atelectasis and restrictive pattern frc
decreases.
Factors affecting FRC.
Factors increasing FRC: Emphysema, Air trapping
in asthma, Ageing (due to loss of elastic properties)
and Increasing height of patient.
Factors decreasing FRC: Restrictive ventilatory
defects e.g., pulmonary fibrosis, Posture - lying
supine, Increased intra-abdominal pressure (e.g.,
obesity, pregnancy, ascites) and Reduced muscle
tone of diaphragm e.g., muscle relaxants in
anesthesia, neuromuscular disease, Lung collapse
and atelectasis.
High Yield:
- **A.** High FVC
- **B.** FRC reduced
- **C.** Normal FVC
- **D.** FEV1/FVC Low
- **E.** Low FEV1

## Question 50 of 121

44. A Patient has a history of a rare genetic disorder
affecting energy production. This disorder is maternally
inherited and primarily involves a malfunction in which
organelle?"
Mitochondria, as many mitochondrial disorders are
maternally inherited due to the presence of
mitochondrial DNA (mtDNA) in the egg cell.

## Question 44 of 90

- **A.** Golgi apparatus
- **B.** Mitochondria
- **C.** Endoplasmic reticulum
- **D.** Lysosome
- **E.** Nucleus
45. Which one of the following vaccines is given in
pregnancy considering selective immunization program in

## Question 45 of 90

## Question 51 of 121

UK?
Selective immunisation
programmes
- **A.** Rota virus
- **B.** Inactivated influenza
- **C.** BCG
- **D.** DPT Vaccine
- **E.** Hepatitis B
46. You examine a patient in the Emergency Department
and find that there is visual loss on the left side of the
vertical midline in both eyes. Occlusion of what type of
blood vessel is most likely to be the cause of this clinical
finding?

## Question 46 of 90

- **A.** Posterior inferior cerebellar artery
- **B.** Anterior communicating artery
- **C.** Posterior cerebral artery
- **D.** Middle cerebral artery

## Question 52 of 121

Visual loss on the left side of the vertical midline in
both eyes" refers to a specific type of visual field
defect known as homonymous hemianopia
Visual deficits, including homonymous hemianopia,
are more commonly associated with infarction or
ischemia involving the Posterior Cerebral Artery
(PCA) territory.
High Yield:
Clinical effects of occlusion of cerebral arteries
- **E.** Anterior cerebral artery
47. A 34-year-old woman is rushed to the emergency
department with severe abdominal pain radiating to her
back. She describes the pain as sudden and excruciating,
and it is accompanied by nausea and vomiting. Her past
medical history includes heavy alcohol consumption. Which

## Question 47 of 90

## Question 53 of 121

one of the following enzymes is secreted in an active status
in pancreatic juice, causing this condition?
Acute pancreatitis:
Inflammation of the pancreas occurs in when
digestive enzymes secreted in pancreatic juice start
digesting its own tissues.
Pathophysiology:
Trypsin is an enzyme that is involved in the
digestion of proteins. Normally, trypsinogen (the
inactive precursor of trypsin) is activated to trypsin
in the small intestine, where it aids in protein
digestion. However, in cases of pancreatitis, trypsin
can become prematurely activated within the
pancreas itself due to factors like alcohol
consumption or other triggers. This activation of
trypsin within the pancreas can lead to the
autodigestion of pancreatic tissue, causing
inflammation.
Chymotrypsinogen is the inactive precursor of
chymotrypsin. Activation of chymotrypsinogen to
its active form, chymotrypsin, occurs through the
action of trypsin. Once trypsin is produced through
the activation of trypsinogen, it can then activate
chymotrypsinogen by cleaving it to chymotrypsin.
Chymotrypsin further breaks down protein
molecules into smaller peptides and amino acids
that can be absorbed by the body.
- **A.** Pepsinogen
- **B.** Trypsin
- **C.** Trypsinogen
- **D.** elastase
- **E.** Chymotrypsinogen

## Question 54 of 121

Note: Both Pancreatic lipase and amylase can be
elevated in cases of pancreatitis, but lipase is often
considered a more reliable marker due to its
higher specificity and longer elevation period.
Clinically, lipase levels are preferred for diagnosing
and assessing the severity of pancreatitis.
Note: In the context of pancreatitis, an
intraluminal fluid collection occurs within the
lumina of the pancreatic ducts (Recall).  When
there is an intraluminal fluid collection in
pancreatitis, it may contribute to the progression of
the disease, exacerbate inflammation, and cause
further damage to the pancreas. This condition can
lead to complications such as pseudocysts, acute
necrotic collections, or walled-off necrosis, which
may require medical or surgical intervention to
manage and resolve.
48. A 22-year-old college student received a severe blow
on the inferolateral side of the left knee joint while playing
football. Radiographic examination reveals a fracture of the
head of fibula. Which one of the following nerves is
damaged?
Common fibular (Peroneal
nerve)

## Question 48 of 90

- **A.** Sciatic nerve
- **B.** Common peroneal nerve
- **C.** Tibial nerve
- **D.** Deep peroneal nerve
- **E.** Saphenous nerve

## Question 55 of 121

Arises as the smaller terminal portion of the sciatic
nerve at the apex of the popliteal fossa. The
common fibular nerve continues by wrapping
around the neck of the fibula and passing between
the attachments of the fibularis longus muscle to
enter the lateral compartment of the leg where it
divides into its terminal branches, the superficial
and deep fibular nerves.
Note: It is very important to remember direct
innervation of common fibular nerve.
Deep fibular nerve root: L4-L5
Superficial fibular nerve root: L4-S1.

> [!TIP]
> **Clinical pearls:**
> 1: Common fibular nerve injury: Damage to the
> common fibular (peroneal) nerve may occur as a
> result of fracture of the head or neck of the fibula
> because it passes behind the head of the fibula and
> then winds laterally around the neck. The nerve
> damage results in foot drop (loss of dorsiflexion)
> and loss of sensation on the dorsum of the foot and
> lateral aspect of the leg and causes paralysis of all
> muscles in the anterior and lateral compartments
> of the leg (dorsiflexors and evertors muscles of the
> foot).

2: Superficial fibular nerve: May be damaged by
fracture of the fibula. As the muscles that the
superficial fibular nerve innervates are evertors,
injury to the nerve may result in a loss of eversion

## Question 56 of 121

and loss of sensation over the lower anterolateral
leg and dorsum of foot.
3: Deep fibular nerve:
Motor Loss: Loss of dorsiflexion of ankle resulting in
foot drop. In foot drop foot will appear permanently
plantarflexed, foot drop with high-stepping gait,
weakness of foot inversion.
Sensory Loss: Loss of sensation over webspace
between 1st and 2nd toes.
Note: Footdrop is due to Common fibular or
common peroneal nerve or also due to deep
fibular nerve injury.
50. A 50-year-old man is brought to the emergency room
after a head injury caused by a fall. He is disoriented and
experiencing severe nausea. Initial tests reveal low sodium
levels (126 mEq/L) and concentrated urine, suggesting
SIADH. Which hormone is elevated in this patient due to
the head injury, leading to the development of SIADH
symptoms?
The Syndrome of inappropriate antidiuretic
hormone secretion (SIADH) is characterized by a
physiologically inappropriate release of Antidiuretic

## Question 50 of 90

- **A.** Insulin
- **B.** Vasopressin
- **C.** Aldosterone
- **D.** Thyroxine
- **E.** Cortisol

## Question 57 of 121

hormone(vasopressin) either from the posterior
pituitary gland, or an abnormal non-pituitary
source.
In most patients with head Injury, hyponatremia is a
feature of the syndrome of inappropriate
antidiuretic hormone (SIADH) secretion due to
pituitary dysfunction after head injury.
51. A 26-year-old man presents to the ED with a cut wound
on his cubital fossa. Which muscles action will be
preserved?
Deep laceration or cut wound can damage the
contents of cubital fossa. Ulnar nerve will be
preserved and its most likely injured in cubital
tunnel.
Cubital fossa and its contents:

## Question 51 of 90

- **A.** Flexion of metacarpophalangeal joints
- **B.** Forearm pronation
- **C.** Opposition of thumb
- **D.** Flexion of small and ring fingers
- **E.** Flexion of thumb

## Question 58 of 121

Note: (Clinical pearls)
Supracondylar fracture is the most common distal
humerus fracture in children. In Supracondylar
fracture anterior interosseous nerve (branch of the
median nerve), ulnar nerve or radial nerve can be
damaged. The anterior interosseous nerve can be
tested by asking the patient to make an ‘OK’ sign,
testing for weakness of flexor pollicis longus.
(Recall)

## Question 59 of 121

Ulnar nerve descends behind medial epicondyle in
a cubital tunnel where it is most commonly
palpated and damaged.
52. Which one of the following dermatomes is likely
affected in medial knee side?
High Yield:
Dermatomes of Lower extremity: Important to
remeber all the landmarks of dermatomes
L1: The inguinal region and the very top of the
medial thigh, Upper anterior thigh

## Question 52 of 90

- **A.** L1
- **B.** L3
- **C.** L5
- **D.** L2
- **E.** L4

## Question 60 of 121

L2: The middle and lateral aspect of the anterior
thigh.
L3: Medial knee (Medial femoral condyle)
L4: Medial malleolus, Medial surface of big toe
L5: Toes 2-3,4, lateral surface of big toe and Dorsal
and plantar aspects of foot
S1: Toe 5 (Little finger), lateral malleolus
S2: At the midpoint of the popliteal fossa.
S3: At the horizontal gluteal crease (fold of the
Buttocks), Ischial tuberosity
S4/5: The perianal area.
53. A 30-year-old man sustains a pelvic injury in a road
traffic accident that causes damage to the L1 Spinal nerves
of lumbar plexus. Which one of the following muscles is
likely affected?
Lumbar plexus: (High Yield)
Formed by the union of the ventral rami of the first
three lumbar nerves and a part of the fourth lumbar
nerve.
Lies anterior to the transverse processes of the
lumbar vertebrae within the substance of psoas
major muscle.

## Question 53 of 90

- **A.** Iliopsoas and pectineus
- **B.** Sartorius
- **C.** Adductor longus and brevis
- **D.** Internal oblique and transversus abdominus
- **E.** External oblique and transversus abdominus

## Question 61 of 121

Note: Sub-costal nerve: (T12) Largest thoracic
spinal nerve originates from anterior ramus of
spinal nerve T12, Innervates external oblique,
internal oblique, transversus abdominus, rectus
abdominus and pyramidalis muscle
54. A 10-year-old child presents with a rash and fever that
have been present for the past 3 days. The rash started
behind his ears and then spread to his face and body. He
also has coryzal symptoms, a dry cough and conjunctivitis.
You diagnose measles, what advice will you give to his
mother regarding the most common complications of
measles?
Pneumonia is the most common complication of
measles can lead to severe respiratory infection
Sub-acute pan encephalitis is rare but if in question
stem asking serious complication involving CNS

## Question 54 of 90

- **A.** Pneumonia
- **B.** Myocarditis
- **C.** Death
- **D.** Sub-acute sclerosing panencephalitis
- **E.** Osteoarthritis

## Question 62 of 121

choose Sub-acute pan encephalitis.
Measles: (High Yield)
Acute viral illness transmitted by respiratory
droplets characterized by 3C Cough, coryza,
conjunctivitis and fever.
Measles rash: Maculopapular rash appearing first
behind the ears and spreading to whole body.
Incubation period: 9-12 days
Infectious period: Patients are considered
infectious for 3 days before the rash emerges and
four days from onset of the rash.
Patients are advised to stay away from school.
Treatment: Supportive
Complications: Pneumonia, bronchitis, otitis media,
encephalitis, subacute sclerosing panencephalitis
55. A 45-year-old patient presents with symptoms such as
fatigue, weight loss, low blood pressure, and increased
pigmentation of the skin. Laboratory tests reveal deficient
adrenal hormone levels. What is the reason for skin
darkening in this patient due to Addison''s disease?

## Question 55 of 90

## Question 63 of 121

In Addison disease the adrenal glands don’t make
enough cortisol and aldosterone, a steroid hormone
that regulates salt and water balance. The low level
of cortisol triggers the release of another hormone
called adrenocorticotropic hormone (ACTH). High
ACTH leads to high levels of melanin, the chemical
that gives skin its color and causes skin
discoloration known as
hyperpigmentation/bronzing.
- **A.** Excessive melanin production stimulated by
increased ACTH levels.
- **B.** Skin darkening is unrelated to Addison''s disease
and might be due to other factors.
- **C.** : Excessive melanin production stimulated by
decrease in aldosterone
- **D.** Skin darkening is a result of high cortisol levels
suppressing melanin production.
- **E.** Decreased melanin production caused by
adrenal hormone deficiency.
56. A 45-year-old homeless was brought into the ED with
complaint of cough, fever, night sweats and weight loss. CT
brain shows frontal lobe caseating lesion. Which one of the
following organisms is likely causing this condition?

## Question 56 of 90

- **A.** Klebsiella pneumoniae
- **B.** Mycobacterium tuberculosis

## Question 64 of 121

The Ghon focus is a primary lesion caused by
tuberculosis that develops in the lung of previously
unaffected individuals. It represents a calcified
caseating granuloma. It typically appears in the
middle-third of the lung (the lower part of the
upper lobe or upper part of the lower lobe).
TB can affect various organs in the body, including
the lungs, lymph nodes, and even the central
nervous system. In cases of central nervous system
TB, the frontal lobe of the brain can be affected,
leading to the formation of caseating lesions and
potentially causing neurological symptoms.
High Yield:
Mycobacterium Tuberculosis
Acid fast bacilli Causes tuberculosis transmitted via
respiratory aerosol and characterized by chronic
granulomatous inflammation.
Clinical Features:
Fever, Night sweats and weight loss
Persistent cough for more than 3 weeks
Hemoptysis
Hilar lymphadenopathy
Pathophysiology:
The Ghon focus is a primary lesion caused by
tuberculosis that develops in the lung of
previously unaffected individuals. It represents a
calcified caseating granuloma. It typically appears
in the middle-third of the lung (the lower part of
the upper lobe or upper part of the lower lobe).
- **C.** Mycoplasma pneumoniae
- **D.** Measles virus
- **E.** Streptococcus pneumoniae

## Question 65 of 121

Diagnosis:
sputum samples Microscopy with Z-N (Ziehl-Nelsen
stain) shows acid fast bacilli.
In the case of active pulmonary TB, a patient can
have crepitations, and bronchial breath sounds, and
specially over upper lobes x-ray cavitations or
consolidations.
The Mantoux test is a widely used test for latent
TB: It involves injecting a small amount of a
substance called PPD tuberculin into the skin of
your forearm. It''s also called the tuberculin skin test
(TST).
58. A 30-year-old female was brought into the ED after she
had been trapped in burning house. She is cyanotic, Pulse
oximetry reveals 100% Sa02. Which one of the following is
common reason of pulse oximeter defect in clinical setup?
CoHb (Carboxyhaemoglobin): Gives falsely high
reading
MetHb(Methemoglobinemia): Gives falsely low
reading.
Dark Skin: No effect

## Question 58 of 90

- **A.** COPD
- **B.** Asthma
- **C.** Dark skin
- **D.** Carboxyhaemoglobin
- **E.** Methhaemoglobinemia
59. A 35-year-old construction worker reports pain and
swelling in the anatomical snuff box of his right hand after

## Question 59 of 90

## Question 66 of 121

falling off a ladder and landing on his outstretched hand.
You suspect injury of anatomical snuff box. Which one of
the following carpal bones is most likely fractured?
An injury to the snuff box can potentially lead to a
scaphoid fracture. Scaphoid fractures are relatively
common in cases of wrist trauma, such as a fall
onto an outstretched hand.
Anatomical snuffbox (High
Yield)
is a triangular depression found on the lateral
aspect of the dorsum of the hand. It is best seen
when the thumb is extended.
- **A.** Scaphoid
- **B.** Pisiform
- **C.** Trapezium
- **D.** Navicular
- **E.** Lunate

## Question 67 of 121

> [!TIP]
> **Clinical Pearl:**
> Fracture of scaphoid bone: Falling on outstretched
> hand. The scaphoid bone of the hand is the most
> commonly fractured carpal bone.

Clinical feature: Pain and tenderness in the
anatomical snuffbox.
60. When comparing normally distributed data to negative
skewed data on a graph. Which of the following statements
are true?

## Question 60 of 90

- **A.** The median is farther out in the long tail than is
the mean
- **B.** Moving away from the peak and toward the tail,
the order is always from: mean to mode to median
- **C.** Moving away from the peak and toward the tail,
the order is always from: mode to median to Mean
- **D.** In right skew the mean moves left relative to the
median
- **E.** In left skew the median moves left relative to the
mean

## Question 68 of 121

When comparing normally distributed data to
skewed data the following are true:
Moving away from the peak and toward the tail, the
order is always from mode to median to mean.
Skewness is of two types:
In right skew (Positive skew) the mean moves right
relative to the median and the tail is longer on the
right side. For a positive skewness mean > median
> mode.
In left skew (Negative skew) the mean moves left
relative to the median and the tail is longer on left
side. For a negative skewness mean < median <
mode (Recall)
62. A 45-year-old male presents to the ED after a recent
cerebrovascular accident (CVA), the patient presents with
dysphagia, struggling to swallow both solids and liquids.
Upon examination, it is determined that the dysfunction has
likely involved one of the cranial nerves, which one of the
following nerves is most likely affected?

## Question 62 of 90

- **A.** Hypoglossal nerve (XII)
- **B.** Abducent nerve (VI)

## Question 69 of 121

Vagus nerve
originates in the medulla oblongata of the brain
and leaves skull through jugular foramen together
with CN IX and CN XI respectively.
High yield:
Branches of vagus nerve:
Superior laryngeal nerve: innervate cricothyroid
muscle and gives sensory innervation to
laryngopharynx and superior part of the larynx
Right Recurrent laryngeal nerve: Hooks
underneath right subclavian artery and ascends
towards larynx and innervate muscles of larynx
Left Recurrent laryngeal nerve: Hooks underneath
the arch of aorta, and ascends towards larynx and
innervate muscles of larynx

> [!TIP]
> **Clinical pearls:**
> Vasovagal syncope:  Causes heart rate and blood
> pressure to drop suddenly during a period of
> emotional stress caused by initial increase in
> sympathetic outflow followed by a rebound
- **C.** Vagus nerve (X)
- **D.** Vestibulocochlear nerve
- **E.** Facial nerve (VII)

## Question 70 of 121

reduction in sympathetic activity leaving
unopposed parasympathetic activity causing
vasodilatation, bradycardia, and hypotension
Orthostatic syncope: Defined as an orthostatic
drop of >20 mm systolic blood pressure or >10 mm
diastolic blood pressure. This may be due to
absolute volume depletion from dehydration or
haemorrhage or to venodilatation caused by
medications or autonomic insufficiency (eg as
occurs in Parkinsons disease).
Causes of syncope:

## Question 71 of 121

63. A 45-year-old woman presents to the ED with complaint
of difficulty swallowing and occasional regurgitation of
undigested food. You suspect achalasia cardia. if your
suspected diagnosis is correct pathology lies in?
Achalasia cardia:
Primary esophageal motility disorder characterized
by the impaired relaxation of the lower esophageal
sphincter (LES) and absence of peristalsis in the
esophagus. This condition is primarily attributed to
dysfunction in the myenteric plexus, which is a
network of nerve fibers and ganglion cells located
between the circular and longitudinal muscle layers
of the esophagus.
Meissner and Myenteric plexus :

## Question 63 of 90

- **A.** Atrophy of the lower esophageal sphincter
- **B.** Dysfunction of the Meissner plexus
- **C.** Dysfunction of the myenteric plexus ganglion
cells
- **D.** Fibrosis of the esophageal submucosa
- **E.** Inflammation of the esophageal mucosa

## Question 72 of 121

64. A 20-year-old male presents to the ED with a deep
contaminated wound in his hand waiting for debridement
tomorrow. He tells you that he had a full course of
vaccinations as a child. What would you advise him
regarding tetanus prophylaxis?
Tetanus prone wound:
Clean wounds are defined as:
wounds less than 6 hours old, non-penetrating with
negligible tissue damage
Tetanus-prone wounds include:
puncture-type injuries acquired in a contaminated
environment and likely therefore to contain tetanus
spores e.g. gardening injuries
compound fractures
wounds or burns with systemic sepsis.
certain animal bites and scratches
High risk tetanus-prone wound:
heavy contamination with material likely to contain
tetanus spores e.g. soil, manure

## Question 64 of 90

- **A.** There is no need for tetanus toxoid and vaccine
as he is fully vaccinated
- **B.** He should have a tetanus booster and human
tetanus immunoglobulin in the same site in his left arm
- **C.** He should have his tetanus antibodies checked
before deciding on a booster
- **D.** He should have a tetanus booster in his left arm
and human tetanus immunoglobulin in his right arm
- **E.** He should have a tetanus booster

## Question 73 of 121

wounds or burns that show extensive devitalised
tissue.
wounds or burns that require surgical intervention
that is delayed for more than six hours are high risk
even if the contamination was not initially heavy
Tetanus immunization
schedule:
More easy to remeber:
Clostridium Species (High Yield)
All the Clostridium species are Gram +Ve spore
forming obligate anaerobes.

## Question 74 of 121

65. A 12-year-old boy presents with albuminuria and
complains of dark urine, facial swelling, and elevated blood
pressure following a recent streptococcal throat infection.
Further evaluation suggests acute glomerulonephritis.
Which kidney structure is most likely responsible for this
condition?
In acute glomerulonephritis, the damage occurs
primarily in the glomerulus, which is responsible for
filtering blood and maintaining a selective filtration
barrier. Damage to the glomerulus can lead to
increased permeability, allowing albumin to pass
through and appear in the urine, resulting in
albuminuria.

## Question 65 of 90

- **A.** Damage to Proximal convoluted tubule
- **B.** Damage to glomerulus
- **C.** Damage to Collecting duct
- **D.** Damage to bowman''s capsule
- **E.** Ascending limb of loop of Henle
66. Stimulation of muscarinic receptors by pilocarpine is
competitively inhibited by which of the following
medications?

## Question 66 of 90

## Question 75 of 121

Atropine
Atropine antagonises the action of the
parasympathetic neurotransmitter acetylcholine at
muscarinic receptors. It therefore blocks the
effects of the vagus nerve on both the SA node and
the AV node, increasing sinus automaticity and
facilitating AV node conduction.
Side effects: (Anti-muscarinic effects)
•Dry mouth
• Nausea and vomiting
• Blurred vision
• Urinary retention
• Tachyarrhythmias
Note: Anti-muscarinic should be avoided in
Myasthenia gravis, paralytic ileus, GI obstruction,
Urinary retention and prostatic enlargement
- **A.** Pralidoxime
- **B.** Atropine
- **C.** Physostigmine
- **D.** Edrophonium
- **E.** Naloxone
67. Which one of the following vaccines is contraindicated
in pregnancy?

## Question 67 of 90

- **A.** Rabies vaccine
- **B.** Split virion

## Question 76 of 121

Live attenuated vaccines are contraindicated in
immunosuppression, pregnant woman and
anaphylactic reaction to vaccine. While we give
inactivated influenza and pertussis vaccine as
normal selected immunisation in pregnant woman.
Refer to Uk immunisation schedule chart.
Live attenuated vaccines used in the UK schedule:
(High Yield)
Rotavirus vaccine
MMR vaccine
Nasal flu vaccine (LAIV)
Shingles vaccine
Chickenpox vaccine (Varicella vaccine)
BCG vaccine against TB
Live travel vaccines used in the UK:
Yellow fever vaccine
Oral typhoid vaccine (not the injected vaccine)
Whole killed’ vaccines used in the UK schedule:
Inactivated polio vaccine or IPV
Pertussis vaccine in pregnancy
Some inactivated flu vaccines which are described
as ‘split virion’
Hepatitis A vaccine (special groups only)
Examples of ‘whole killed’ travel vaccines used in
the UK:
Rabies vaccine
Japanese encephalitis vaccine
- **C.** Injectable Polio vaccine
- **D.** LAIV
- **E.** Pertussis vaccine

## Question 77 of 121

Note: Vaccines indicated before travelling to India:
Hepatitis A, Hep-B, typhoid, Cholera, Japanese
encephalitis and yellow fever vaccine.
69. A 25-year-old woman falls down a flight of stairs and
suffers a skull fracture. The fracture causes damage to
Opthalmic (V1) nerve and loss of sensation to center of
forehead and conjunctiva. Which one of the following
nerves is likely affected?
The Skin of central part of the forehead, Skin of
lower part of forehead and conjunctiva is
innervated by the supratrochlear nerve, which is a
sensory branch of the ophthalmic division (V1) of
the trigeminal nerve (cranial nerve V).  While Skin of
upper forehead, Upper eyelid and conjunctiva
innervated by7 supraorbital nerve.

## Question 69 of 90

- **A.** Supratrochlear nerve
- **B.** Inferior alveolar nerve
- **C.** Zygomaticotemporal nerve
- **D.** Supraorbital nerve
- **E.** Infraorbital nerve

## Question 78 of 121

Trigeminal nerve: (High Yield)
Mixed motor and sensory nerve. It is also the largest
cranial nerve. Arises from several nuclei in the
brainstem, exits brainstem from pons It has three
main divisions:
1: Opthalmic V1
2: Maxillary V2
3: Mandibular V3

## Question 79 of 121

70. A patient was prescribed an antacid by his GP presents
with a complaint of constipation. Which of the following
antacids is more likely to be associated with constipation as
a side effect?

## Question 70 of 90

- **A.** Aluminum hydroxide
- **B.** Carbonate
- **C.** Magnesium hydroxide
- **D.** Calcium carbonate
- **E.** Sodium bicarbonate

## Question 80 of 121

Antacid Side Effects:
Antacids are relatively harmless, but they can cause
rare side effects.
Aluminum compounds can cause constipation by
reducing bowel motility.
Magnesium Compounds may cause diarrhea.
Carbonates may generate carbon dioxide leading to
bloating and flatulence
71. A 30-year-old man presents to the ED with sports injury.
Further evaluation reveals fracture of bicipital groove of
humerus and associated bicep tendon damage. Which one
of the following ligaments is likely to be disrupted?
The tendon of the long head of the biceps runs in
front of the humeral head. The tendon passes
within the bicipital groove of the humerus and is
held in place by the transverse humeral ligament.

## Question 71 of 90

- **A.** Coraco–clavicular ligament
- **B.** Transverse humeral ligament
- **C.** Glenohumeral ligament
- **D.** Coracoacromial ligament
- **E.** Coracohumeral ligament

## Question 81 of 121

The shoulder Joint (High Yield)
Type: synovial ball and socket joint
Shoulder joint is formed by the articulation of the
head of the humerus with the glenoid cavity of the
scapula
Ligaments of the shoulder joint:
In the shoulder joint, the ligaments play a key role
in stabilizing the bony structures.
Glenohumeral ligaments (superior, middle and
inferior) They act to stabilize the anterior aspect of
the joint. They are the main source of stability for
the shoulder, holding it in place and preventing it
from dislocating anteriorly.
Coracohumeral ligament: It supports the superior
part of the joint capsule.
Transverse humeral ligament: This ligament spans
the distance between the two tubercles of the
humerus. It holds the tendon of the long head of
the biceps in the intertubercular groove or bicipital
groove.
Coraco–clavicular ligament:  This ligament
composed of the trapezoid and conoid ligaments
and runs from the clavicle to the coracoid process of
the scapula. They work alongside the

## Question 82 of 121

acromioclavicular ligament to maintain the
alignment of the clavicle in relation to the scapula.
Coracoacromial ligament. This ligament runs
between the acromion and coracoid process of the
scapula it forms the coraco-acromial arch.  This
structure overlies the shoulder joint, preventing
superior displacement of the humeral head.
72. Which of the following statements about case-control
studies is correct?
case-control study is a type of observational study in
which two groups of patients, one with the disease
and one without, are compared on the basis of a
proposed causative factor that occurred in the past.
They are therefore retrospective in nature and are
useful in hypothesis generation.
They are suitable to be used when investigating a
rare disease or as a preliminary study in cases where
Little is known about the disease and the proposed
aetiological factor. They can look at multiple risk-

## Question 72 of 90

- **A.** They are a type of experimental study
- **B.** They provide more evidence for causal inference
than a randomised controlled trial
- **C.** They are usually shorter in duration than
prospective cohort studies
- **D.** They are usually more expensive to run than a
randomised controlled trial
- **E.** They are usually longer in duration than
prospective cohort studies

## Question 83 of 121

factors (exposures) but can only look at a single
outcome.
Compared with randomised controlled trials, case-
control studies are generally relatively inexpensive
to run but provide less evidence for causal
inference.
Compared with prospective cohort studies, case-
control studies are usually less expensive and also
shorter in duration.
73. A 23-year-old man is involved in a fight outside a
nightclub. He is cut across the face with the edge of a
broken glass. Upon examination he has a lesion in the
facial nerve and sensory loss in upper lip. Which one of the
following facial nerve branches is affected?
Facial nerve terminal branches in parotid gland:
The cervical branch: innervating the platysma
muscle.
The temporal branch: innervating muscles in the
temple, forehead muscles (frontalis) and
supraorbital areas (upper half of orbicularis oculi
muscle)
The zygomatic branch: innervating muscles in the
infraorbital area (Lower half of orbicularis oculi
muscle), the lateral nasal area and the upper lip

## Question 73 of 90

- **A.** Marginal mandibular branch
- **B.** Zygomatic branch
- **C.** Temporal branch
- **D.** Infraorbital nerve
- **E.** Buccal branch

## Question 84 of 121

The buccal branch: innervating muscles in the
cheek and upper lip
The marginal mandibular branch: innervating
muscles of the lower lip and chin
Facial nerve:  (High Yield)
The facial nerve exits the cranial cavity through the
internal acoustic meatus and enters the facial canal
of the temporal bone. The nerve then exits the skull
through the Stylomastoid foramen (lies between
the styloid and mastoid processes of the temporal
bone) to enter the parotid gland, ultimately
branching into five terminal branches to supply the
face.
Cause of injury: Bell’s palsy, Ramsay-Hunt
syndrome, Guillain-Barre syndrome, mumps,
parotid tumor, and injury to the middle ear.
Clinical effects of injury:  impaired sense of taste to
anterior two-thirds of tongue, loss of efferent

## Question 85 of 121

corneal reflex, impaired lacrimal fluid production,
hyperacusis, and impaired salivation
Facial nerve branches in the temporal bone:
The nerve to the stapedius: Innervate stapedius
muscle.
The greater petrosal nerve: parasympathetic
innervation to the lacrimal gland and the mucous
glands of the oral cavity, nose and pharynx
The chorda tympani: supply taste to the anterior
two-thirds of the tongue
Facial nerve branches between the stylomastoid
foramen and parotid gland:3 motor branches
Posterior auricular nerve innervates the intrinsic
and extrinsic muscles of the outer ear.
Nerve to the posterior belly of the digastric
muscle: Innervates the posterior belly of the
digastric muscle one of the suprahyoid muscles of
neck responsible for raising the hyoid bone.
Nerve to the stylohyoid muscle: Innervates the
stylohyoid muscle, one of the suprahyoid muscles of
neck responsible for raising the hyoid bone.
Note: Greater auricular nerve cutaneous branch of
the cervical plexus provides sensory innervation to
ear lobule, skin over the parotid gland and mastoid
process of the temporal bone. Pain of parotitis and
during ear piercing is due to innervation of greater
auricular nerve.
Facial nerve terminal branches in parotid gland:
The cervical branch: innervating the platysma
muscle.
The temporal branch: innervating muscles in the
temple, forehead muscles (frontalis) and
supraorbital areas (upper half of orbicularis oculi
muscle)
The zygomatic branch: innervating muscles in the
infraorbital area (Lower half of orbicularis oculi

## Question 86 of 121

muscle), the lateral nasal area and the upper lip
The buccal branch: innervating muscles in the
cheek and upper lip
The marginal mandibular branch: innervating
muscles of the lower lip and chin
High yield:
The chorda tympani branch of the facial nerve
supplies taste sensation to the anterior 2/3 of the
tongue.
In the anterior 2/3, general sensation is supplied by
the trigeminal nerve (CNV). Specifically, the lingual
nerve, a branch of the mandibular nerve (CN V3).
The posterior 1/3 of the tongue both touch and taste
are carried by the glossopharyngeal nerve (CNIX)
74. A patient with a history of heart failure is prescribed
digoxin. Which one of the following ecg changes
demonstrating the digoxin effect?
Digoxin effect refers to the presence on the ECG of:
Down sloping ST depression with a characteristic
“reverse tick” appearance
Flattened, inverted, or biphasic T waves.
Shortened QT interval.
PR Prolongation

## Question 74 of 90

- **A.** QT interval prolongation
- **B.** ST segment elevation
- **C.** Peaked T waves
- **D.** PR Prolongation
- **E.** Shortening of PR interval

## Question 87 of 121

High Yield:
Monitoring: Digoxin has narrow therapeutic index.
Narrow therapeutic index means difference
between the effective therapeutic dose and the
potentially toxic dose is relatively small. This narrow
window makes proper dosing and monitoring
critically important to ensure the medication''s
safety, effectiveness and to prevent toxicity. The
therapeutic plasma levels of digoxin are usually
between 1.0-1.5 nmol/l. The likelihood of toxicity
rises dramatically at levels above 2 nmol/l.
Dose adjustments in renal failure and liver failure:
Renal failure: Digoxin is excreted renally, and
impaired renal function can cause increased
digoxin levels and leads to digoxin toxicity. In this
case the patient should have their digoxin dose
reduced and their digoxin level and electrolytes
should be carefully monitored.
Liver failure: Liver failure has little influence on
digoxin metabolism or clearance; therefore, no
dose adjustment is necessary.
Digoxin toxicity: Precipitated by hypokalemia or
drugs causing hypokalemia, hypercalcemia,
acidosis and renal failure.
The features of digoxin toxicity include:
Hyperkaliemia
Nausea, vomiting and diarrhea .
Abdominal pain
Confusion, dizziness and psychosis
Tachyarrhythmias or bradyarrhythmia''s
Xanthopsia (yellow-green vision)
Treatment: Digoxin immune fab is the reversal
agent (Antidote) of digoxin toxicity.

## Question 88 of 121

75. A 40-year-old patient brought to the ED following a road
traffic accident. CT scan reveals retroperitoneal bleeding.
Which of the following anatomical structure is involved?
A useful mnemonic to remember which organs are
retroperitoneal is SAD PUCKER
S = Suprarenal (adrenal) Glands
A = Aorta and inferior vena cava
D =Duodenum (2nd and 3rd part)
P = Pancreas (except the tail)
U = Ureters
C = Colon (ascending and descending parts)
K = Kidneys
E = Esophagus
R = Rectum

## Question 75 of 90

- **A.** Sigmoid colon
- **B.** Spleen
- **C.** 3rd part of duodenum
- **D.** Appendix
- **E.** Tail of pancreas
76. Relatively higher dose of aminophylline is required to
attain therapeutic plasma concentration in which one of the
following patients?

## Question 76 of 90

- **A.** Congestive heart failure patients
- **B.** Infection

## Question 89 of 121

In smokers increased clearance and the decreased
half- life of theophylline, and in order to prevent the
nighttime life-threatening attacks, it is necessary to
recommend maximal doses of theophylline.
Theophylline/aminophylline is metabolized in the
liver, and has a narrow therapeutic index. The
plasma theophylline concentration is decreased in
smokers, and by alcohol
consumption.
Note: The plasma theophylline concentration is
increased in heart failure, hepatic impairment,
infections, fever and in the elderly, reduction in
dosage may be necessary to avoid toxic
accumulation.
Bronchodilator therapy:
Remember theophylline mechanism of action as
well as indications and adverse effects.
- **C.** Smokers
- **D.** Hepatic impairment
- **E.** Those receiving cimetidine

## Question 90 of 121

79. A 26-year-old patient presents to the Emergency
Department with headache, dizziness and tachycardia. He
is known asthmatic and is on a salbutamol inhaler and a
theophylline. He had been seen in the Emergency
Department a few days before and prescribed an antibiotic.
Which antibiotic was most likely given which has caused
her symptoms?
Ciprofloxacin is enzyme inhibitor decrease hepatic
clearance of concomitant administrated drugs and
increase their pharmacologic effects typically
results in toxic effects of drugs.
High Yield:
Cytochrome P450 enzyme inducer drugs increase rate of
metabolism and hepatic clearance of concurrently
administrated drugs which typically results in decreased
pharmacologic effects While enzyme inhibitor drugs decrease
hepatic clearance and increase pharmacologic effects.

## Question 79 of 90

- **A.** Trimethoprim
- **B.** Cephalexin
- **C.** Doxycycline
- **D.** Ciprofloxacin
- **E.** Amoxycillin

## Question 91 of 121

80. A 23-year-old man presents with a crush injury to his
wrist and thumb. On further evaluation ulnar nerve injury
was suspected. Which one of the following muscles is likely
affected?
Anatomical Course of Ulnar Nerve:
Arises from the medial cord of the brachial plexus,
runs down the medial aspect of the arm, pierces the
medial intermuscular septum at the middle of the
arm, and descends together with the superior ulnar
collateral branch of the brachial artery. It then

## Question 80 of 90

- **A.** flexor pollicis brevis
- **B.** Flexor pollicis longus
- **C.** Adductor pollicis
- **D.** opponens pollicis
- **E.** Abductor pollicis brevis

## Question 92 of 121

Descends behind the medial epicondyle in a tunnel
(cubital tunnel), where it is readily palpated and
most commonly injured. It may be damaged by a
fracture of the medial epicondyle. When irritated,
it causes funny bone symptoms of pain,
numbness, and tingling in the medial elbow,
forearm, and digits.
It then enters the forearm by passing between the
two heads of the flexor carpi ulnaris and descends
between the flexor carpi ulnaris and gives rise to
following branches in forearm.
Ulnar nerve branches in hand
Enters the hand superficial to the flexor retinaculum
and lateral to the pisiform bone, where it is
vulnerable to damage from cuts or stab wounds and
gives rise to following branches in hand.
81. A 40-year-old male was brought into the ED after he
was found collapsed at home due to heroin overdose. He is
in apnoea. Which one of the following respiratory centre is
likely damaged?

## Question 81 of 90

- **A.** Dorsal respiratory group
- **B.** Apneustic centre
- **C.** Cerebral cortex
- **D.** Pneumotaxic centre

## Question 93 of 121

Pneumotaxic center is located in the upper pons
inhibits inspiration and, therefore, regulates both
the rate (Increases) and pattern of breathing.
Pneumotaxic center normally prevents excessive
deep breathing, damage to pneumotaxic results in
increase in depth of respiration (deep breathing)
and decrease in respiratory rate/Apnoea
The Apneustic center is located in the lower pons.
Stimulates inspiration, producing a deep and
prolonged inspiratory gasp (apneusis). Normally
apneustic center promotes deep breathing,
damage to apneustic center promotes shallow
irregular/ Erratic breathing (Recall)
Note: Focus on the question stem, if they ask you
normal functions of apneustic center or
Pneumotaxic centre then your answer would be
changed according to their normal functions and
damaged clinical significance. For example:
Normally apneusis/ Deep prolonged inspiration is
induced by apneustic center while damage to
apneustic center promotes shallow/irregular or
erratic breathing.
- **E.** Cushing centre
82. A 45-year-old patient was brought into the emergency
department after a penetrating injury involved outermost
layer of the bowel wall, which layer is likely affected?

## Question 82 of 90

- **A.** Mucosa
- **B.** Muscularis propria
- **C.** Serosa
- **D.** Subcutaneous tissue

## Question 94 of 121

The layers of the GI tract, from outermost to
innermost
Serosa or adventitia lined with visceral peritoneum
Muscularis propria
Submucosa
Mucosa
Note: If they ask you penetrating injury just outside
of the bowel wall that refers injury has not
breached serosa (Outer layer) in that case parietal
peritoneum is appropriate
Anterolateral abdominal wall layers: (High Yield)
Skin
Subcutaneous tissues (further divided into the
superficial Camper’s fascia and the deeper Scarpa’s
fascia)
External oblique muscle
Internal oblique muscle
Transversus abdominis muscle
Transversalis fascia
Parietal peritoneum
- **E.** Submucosa
83. A 23-year-old man presents with a crush injury to his
hand. Which one of the following muscles will remain intact
in C8-T1 nerve root injury from high lesions?

## Question 83 of 90

## Question 95 of 121

The anterior interosseous nerve is a terminal motor
branch of the median nerve arising from C5-T1 nerve
roots. It supplies the deep muscles of the anterior
forearm which includes flexor pollicis longus, lateral
half of flexor digitorum profundus and pronator
quadratus.
The recurrent branch of median nerve (C8, T1) is a
small muscular branch of median nerve. In order to
remember the muscles innervated by the recurrent
branch, you can use mnemonic LOAF to recall the
motor innervation of the median nerve. This stands
for:
L: lateral two lumbricals
O: opponens pollicis
- **A.** abductor pollicis brevis
F: flexor pollicis brevis (superficial head)
Ulnar Nerve: (High Yield)
While other muscles mentioned in options are
innervated by ulnar nerve (C8-T1)
The ulnar nerve arises from the brachial plexus
within the axilla region. It is a continuation of the
medial cord and contains fibers from spinal roots C8
and T1.
- **A.** Abductor digiti minimi
- **B.** Flexor digiti minimi brevis
- **C.** Flexor carpi ulnaris
- **D.** Flexor pollicis longus
- **E.** Flexor pollicis brevis

## Question 96 of 121

Anatomical Course of Ulnar Nerve:
Arises from the medial cord of the brachial plexus,
runs down the medial aspect of the arm, pierces the
medial intermuscular septum at the middle of the
arm, and descends together with the superior ulnar
collateral branch of the brachial artery. It then
Descends behind the medial epicondyle in a tunnel
(cubital tunnel), where it is readily palpated and
most commonly injured. It may be damaged by a
fracture of the medial epicondyle. When irritated,
it causes funny bone symptoms of pain,
numbness, and tingling in the medial elbow,
forearm, and digits.
It then enters the forearm by passing between the
two heads of the flexor carpi ulnaris and descends
between the flexor carpi ulnaris and gives rise to
following branches in forearm.
Ulnar nerve branches in hand
Enters the hand superficial to the flexor retinaculum
and lateral to the pisiform bone, where it is
vulnerable to damage from cuts or stab wounds and
gives rise to following branches in hand.

> [!TIP]
> **Clinical Pearls:**

## Question 97 of 121

Froment''s sign: Froment’s sign is a test for ulnar
nerve palsy specifically paralysis of the adductor
pollicis:
Patient is asked to hold a piece of paper between
thumb and index finger as paper is pulled away,
patient will flex thumb at inter-phalangeal joint to
maintain hold, this sign tests the function of
adductor pollicis muscle which is supplied by the
ulnar nerve.
A positive test is when the patient is unable to
adduct the thumb.
Claw hand:
Injury to the ulnar nerve is commonly caused by a
fracture of the medial epicondyle and results in a
claw hand, in which the ring and little fingers are
hyperextended at the metacarpophalangeal joints
and flexed at the interphalangeal joints.
Partial claw hand deformity is due to an isolated
ulnar nerve injury.
Complete claw hand deformity: Involves all digits
and results from combined ulnar and median nerve
injury.
84. A 30-year-old male presents to the ED with history of
previous anaphylactic reaction to vaccines. Which one of
the following vaccines is contraindicated and if given will
likely precipitate acute immune reactions?

## Question 84 of 90

- **A.** Hepatitis A
- **B.** IPV
- **C.** Hepatitis B
- **D.** Varicella Vaccine

## Question 98 of 121

live vaccines are contraindicated in anyone who has
had a severe allergic reaction to a previous dose of
the same vaccine or from a different vaccine
containing a component of the live vaccine, such as
albumin.
Other contraindications of live vaccine include:
Pregnancy
People who are immunocompromised include
those who:
Are receiving high-dose immunosuppressive
therapy, including biologic or targeted synthetic
disease-modifying anti-rheumatic drugs (bDMARDs
or tsDMARDs) or oral corticosteroids ( ≥ 20 mg per
day of prednisolone equivalent dose)
Are receiving chemotherapy or radiation.
have malignancies related to the immune system
such as lymphoma, leukaemia or Hodgkin disease,
even if they are not receiving active treatment
Have AIDS or symptomatic HIV
Have similar immunocompromising conditions due
to a disease or treatment.
Note: Anaphylaxis after vaccination is rare in all age
groups and Anaphylactic reaction can occur with
both live and killed vaccine, but reportedly yellow
fever vaccine and covid-19 vaccine has some greater
risk than others.
- **E.** Rabies vaccine
85. A 24-year-old male presents to the ED with complaint of
pain in umbilical region radiating towards right lower
abdomen. You suspect appendicitis and perform psoas
muscle inflammation in appendicitis. When you perform

## Question 85 of 90

## Question 99 of 121

psoas sign pain is aggravated by which one of the following
movements?
Psoas sign: Pain on extension
Obturator sign: Pain on internal or medial rotation
High yield:
Rovsing''s sign: Pain in the right lower quadrant is
complained of when palpation pressure is exerted in
the left lower quadrant. It is also called referred
rebound tenderness and when present is quite
helpful in supporting the diagnosis.
Psoas sign: This test is performed by having the
patient lie on his left side. The examiner then slowly
extends the patient’s right thigh, thus stretching the
iliopsoas muscle. This will produce pain to make the
sign positive. This indicates presence of irritative
inflamed appendix in close proximity to the psoas
muscle. This is possible in retrocaecal appendicitis.
Obturator test: Passive internal rotation of flexed
right thigh with the patient in supine position will
elicit pain. This positive obturator sign is diagnostic
of pelvic appendicitis.
- **A.** Medial rotation
- **B.** Abduction
- **C.** Extension
- **D.** Lateral rotation
- **E.** Adduction
87. Which of the following is the first line therapy for
gastroparesis in patients with diabetes?

## Question 87 of 90

## Question 100 of 121

Metoclopramide is used to treat the symptoms of
slow stomach emptying (gastroparesis)
Metoclopramide relieves symptoms such as nausea,
vomiting, heartburn, a feeling of fullness after
meals, and loss of appetite.
Note: In anesthesia practice, medications that can
be used to increase gastric emptying before
general anesthesia include prokinetic agents. One
commonly used prokinetic agent for this purpose
is metoclopramide. (Recall)
- **A.** Cyclizine
- **B.** Omeprazole
- **C.** Cimetidine
- **D.** Metoclopramide
- **E.** Ondansetron
89. A 40-year-old patient with history of tooth extraction
presents to ED with 15 days history of fever, night sweats
and malaise, and is noted to have a systolic murmur on
examination. You suspect acute infective endocarditis,
which of the following pathogens is the most likely cause?

## Question 89 of 90

- **A.** Staph Aureus
- **B.** Staph epidermidis
- **C.** Staph Viridans
- **D.** Streptococcus pyogenes

## Question 101 of 121

High Yield:
Most common cause generally: Staph Aureus
(Recall)
Most common cause in IV drug abuser: Staph
Aureus
Most common cause of infective endocarditis in
prosthetic heart valves: Staph epidermidis
Most common cause of infective endocarditis after
tooth extraction surgery: Staph viridians
- **E.** Pseudomonas aeruginosa
90. A 45-year-old male patient with a history of chronic
alcohol abuse is admitted to the emergency department
exhibiting symptoms of severe alcohol withdrawal, the
medical team decides to administer Prochlorperazine.
What is the main mechanism of action of
Prochlorperazine?
Prochlorperazine are dopamine-D2 receptor
antagonist and act centrally by blocking the
chemoreceptor trigger zone.
Anti-psychotics (High Yield)

## Question 90 of 90

- **A.** Histamine-H1 antagonist
- **B.** Dopamine-D2 agonist
- **C.** Dopamine-D2 antagonist
- **D.** Histamine-H2 antagonist
- **E.** Serotonin-5HT3 antagonist

## Question 102 of 121

Anti-psychotics acts by blocking dopamine D2
receptors in the brain .
Side effects:
Extrapyramidal side effects occur most commonly
associated with antiemetic (metoclopramide,
prochlorperazine) and anti-psychotics
(haloperidol). Haloperidol is the most
common causative antipsychotic drug.
Dystonia (abnormal face and body movements)
most commonly occur in young female and children
treated with Procyclidine or benztropine .
Tardive dyskinesia (rhythmic, involuntary movements
of tongue, face and jaw)
Other side effects:
Parkinsonian symptoms (Tremor, Rigidity,
bradykinesia and postural instability)
Hyperprolactinemia (Dopamine inhibits release
of prolactin)
QT-interval prolongation
8. A child with a forearm fracture requires a general
anaesthetic for open reduction and internal fixation. The
anesthetist asks when he ate his last meal and considers
various factors that can affect gastric emptying as part of
his assessment. Which of the following factors promotes
gastric emptying?

## Question 8 of 90

- **A.** Cholecystokinin
- **B.** Sympathetic innervation
- **C.** Pregnancy
- **D.** Secretin
- **E.** Gastrin

## Question 103 of 121

The following factors promote gastric emptying:
Increased food volume in the stomach
Gastrin
Motilin
Parasympathetic innervation (via the vagus nerve)
Prokinetics such as metoclopramide and
erythromycin
The following factors inhibit gastric emptying:
Duodenal distension by vagal inhibition
Cholecystokinin
Secretin
Somatostatin
Vasoactive intestinal peptide (VIP)
Gastric inhibitory peptide (GIP)
Sympathetic innervation (via the coeliac plexus)
Pregnancy (via increased progesterone levels)
Anti muscarinic e.g. Atropine
Duodenal chyme high in H+, fat and osmolality
(Recall)
18. A 40-year-old male presents to the ED with infected
surgical wound not healing and suture line separated.
Which one of the following is the most likely reason for
delayed wound healing?

## Question 18 of 90

- **A.** Decreased oxidative stress
- **B.** Fibrin degradation
- **C.** Increased angiogenesis
- **D.** Extra cellular matrix shortage
- **E.** Ongoing inflammation

## Question 104 of 121

Persistent inflammation, as a hallmark of chronic
wounds, is connected to the dysregulation of the
immune response during wound healing by various
factors and leads to excessive levels of pro-
inflammatory signals, reactive oxygen species
(ROS), changes in the proteolytic balance, and an
increased amount of matrix metalloproteinases
(MMPs) that eventually cause damage to the
extracellular matrix (ECM) and impaired
epithelialization and proliferation of keratinocytes.
Wound healing (High Yield)
Healing is the process of replacing dead and
damaging tissue with healthy tissue; this may occur
through regeneration or repair.
The regenerative capacity of cells can be
categorized in three main ways:
Labile cells are constantly dividing and have a good
capacity for regeneration, this allows the
replacement of ageing tissue such as the surface
epithelia of the skin, gastrointestinal tract and
uterus; blood cells are derived from labile cells of the
bone marrow.
Stable cells slowly replicate e.g., cells of liver, renal
tubular epithelium, endocrine glands.
Permanent tissues: incapable of division and
cannot be regenerated e.g., brain cells, myocardial
cells, skeletal muscle cells.
Healing by primary intention:
Healing of a clean, uninfected surgical incision
approximated by surgical sutures.
Day-1: Neutrophilic infiltration + fibrin clot
Day-2: Epithelial cells from both edges have begun
to migrate and proliferate along the dermis, yielding
a thin but continuous epithelial layer.
Day-3: Macrophages replace neutrophils
Appearance of granulation tissue. Type III collagen
deposition begins but do not bridge the incision.

## Question 105 of 121

Day 5: Abundant granulation tissue Collagen fibrils
bridge the incision.
Neovascularization is maximum.
Week-2: Dense scar tissue produced from
granulation tissue contains type III collagen (weak
collagen) that must be remodeled. Remodeling
increases the tensile strength of scar tissue.
1 month: Replacement of collagen type III with
collagen type I (has greater tensile strength) due to
action of collagenase enzyme.
The predominant collagen in adult skin is type I,
whereas in early granulation tissue, it is type III.
Healing by secondary intention
Occurs in large wounds abscess formation and
ulceration.
Main features:
A larger clot or scab
Inflammation: more intense Granulation tissue:
much larger amount
Scar tissue: greater mass
Wound contraction: by myofibroblast e.g. Within 6
weeks, large skin defects may be reduced to 5% to
10% of their original size, largely by contraction.
Healing by tertiary intention
Contaminated wound is initially treated with
debridement and antibiotics followed by surgical
wound closure (suture, skin graft replacement, flap)
Note: Regarding the neat surgical scar after 2
months of surgery fibroblasts have predominant
role
Most important for delayed wound healing is due
to infection.
Factors affecting wound healing:
Local factors affecting wound healing
Mechanical injury
Infection

## Question 106 of 121

Edema
Ischemia/necrotic tissue
Topical agents
lionizing radiation
Low oxygen tension
Foreign bodies
Systemic factors affecting wound healing
Diabetes mellitus
Anaemia
Malnutrition
Immunodeficiency
Immunosuppressive medications
Age
Obesity
Smoking
Vit A, C and Zinc deficiency
Complications of Healing
Hypertrophic scar
Keloid formation
Failure to heal (abscess or empyema formation)
Failure to unite (skin, muscle or fascia wound
breakdown)
Fracture complications
Remember the cells involved in different stages
of wound healing.

## Question 107 of 121

31. You have been asked to administer an intramuscular
injection to a patient in the Emergency Department. Which
of the following anatomical points is the safest location in
the gluteal region?

> [!TIP]
> **Clinical pearls:**
> Intramuscular injections in the gluteal region: The
> anatomical course of the sciatic nerve must be
> considered when administering intramuscular
> injections into the gluteal region. The region can be
> divided into quadrants using 2 lines.

One line descends vertically from the highest point
on the iliac crest.
Other lines pass through vertical line halfway
between the highest point.
Note: Sciatic nerve lies in the lower medial
quadrant. To avoid injury of sciatic nerve IM
injections in the gluteal region only be given in
upper lateral or upper outer quadrant.

## Question 31 of 90

- **A.** Lower lateral
- **B.** Upper medial
- **C.** Lower medial
- **D.** Centrally within gluteal region
- **E.** Upper outer
39. A 25-year-old patient presents with a stab injury to the
groin area. He has damaged a structure that lies

## Question 39 of 90

## Question 108 of 121

immediately medially to the femoral nerve in femoral
triangle. Which one of the following is correct?
High Yield:
Contents of Femoral Triangle:
From lateral to medial: Useful mnemonic (NAVEL)
Femoral nerve
Femoral artery
Femoral vein
Empty space (consists of femoral canal)
Lymph nodes
Note: Femoral nerve lies lateral to femoral artery
and vein

> [!TIP]
> **Clinical pearls: In Femoral hernia part of the bowel**
> pushes into the femoral canal underneath the
> femoral triangle
> Important to remember here :
> Femoral Canal:
> The Femoral canal lies most medial of the femoral
> sheath.

Borders of the femoral canal: (Useful mnemonic
LAMP: FILP)
Lateral border: Femoral vein (Immediately
lateral)
- **A.** Femoral canal
- **B.** Femoral vein
- **C.** Iliacus muscle
- **D.** Sartorius
- **E.** Femoral artery

## Question 109 of 121

Anterior border: Inguinal ligament
Medial border: Lacunar ligament
Posterior ligament: Pectineal ligament, Pectineus
muscle and superior ramus of pubic bone.
Contents: Deep inguinal lymph nodes, lymphatic
vessels, empty space and loose connective tissue.
41. Which of the following is most important in eliciting a
hyperventilatory response to changes in acidotic PH in
CSF?
Central chemoreceptor in medulla is responsible for
about 80% of the ventilatory response to changes in
Pco2 (Increased Pco2) and decrease in PH (Acidosis).
Peripheral chemoreceptors in carotid body/ Aortic
arch respond to decrease in 02 and increase in
arterial Pco2 and H+.
Control of ventilation is
mediated via central and
Peripheral chemoreceptors.
Chemoreceptor overview: (High
Yield)

## Question 41 of 90

- **A.** Peripheral chemoreceptors in the carotid body
- **B.** Apneustic centre
- **C.** Stretch receptors
- **D.** Peripheral chemoreceptors in the aortic arch
- **E.** Central chemoreceptor

## Question 110 of 121

Central chemoreceptor Vs
Peripheral chemoreceptor
49. A 72-year-old woman who takes Bendroflumethiazide
for hypertension is admitted to the Emergency Department.
Admission bloods show the following:
Na 131 mmol/l
K: 2.2 mmol/l
Urea 3.1 mmol/l
Creatinine56 μmol/l
Glucose:4.3 mmol/l
Which one of the following ECG features is most likely to
be seen?

## Question 49 of 90

- **A.** J waves

## Question 111 of 121

ECG features of hypokalemia
U waves
small or absent T waves (occasionally inversion)
prolong PR interval.
ST depression
long QT (QT prolongation)
Note: J waves are seen in hypothermia whilst
delta waves are associated with Wolff Parkinson
White syndrome.
- **B.** Short PR interval
- **C.** Short QT interval
- **D.** Flattened P waves
- **E.** U waves
57. A 60-year-old male patient presented with worsening
pneumonia associated with the production of large
quantities of red-currant jelly sputum. Chest X-ray shows a
cavity in the right upper lobe with a fluid level. What is the
most likely infective organism?

## Question 57 of 90

- **A.** Chlamydia Pneumonia
- **B.** Heamophilus influenza
- **C.** Legionella Pneumonia
- **D.** Streptococcus Pneumonia
- **E.** Klebsiella Pneumonia

## Question 112 of 121

Klebsiella spp:
Escherichia Coli: (High Yield)
Note: E. coli serotype O157 causes bloody diarrhoea
associated with hemolytic uremic syndrome in
children, characterized by hemolytic anemia,
thrombocytopenia and acute renal failure.
Salmonella enterica
is a gram-negative rod that causes enterocolitis
(Food poisoning), Enteric fever (Typhoid),
Septicemia, and osteomyelitis
Primarily transmitted through fecal-oral route
usually from ingestion of contaminated poultry,
eggs, and uncooked meat
Treatment:
Salmonella enterocolitis: Usually supportive
management in resistant cases ciprofloxacin
Enteric fever: First line ciprofloxacin if organism
sensitive, and in resistant cases cefotaxime or
azithromycin
High yield:
Regarding osteomyelitis
Most common cause generally: Staph Aureus
(Recall)

## Question 113 of 121

The most common cause in IV drug abuser: Staph
Aureus
The most common cause in sickle cell disease:
Salmonella
Most common cause after hip replacement surgery:
Staph epidermidis
61. A 40-year-old male was brought into to the ED after he
falls approximately 20 feet whilst tiling a roof. He suffers a
femoral shaft fracture that damages a branch of the
posterior division of the femoral nerve. Which of the
following muscles is supplied by a branch of the posterior
division of the femoral nerve?
High Yield:

## Question 61 of 90

- **A.** Psoas major
- **B.** Sartorius
- **C.** Iliacus
- **D.** Pectineus
- **E.** Vastus medialis

## Question 114 of 121

68. A 55-year-old man, experiences constant thirst, fatigue,
and sudden weight loss. Medical tests reveal inhibited
insulin secretion due to a genetic predisposition of type 2
diabetes. Which of the following is an inhibitor of insulin
synthesis and secretion?
Factors that stimulate insulin release include:
Amino acids (arginine and leucine)
Parasympathetic stimulation (via acetylcholine)
Gastrin
Secretin
Cholecystokinin
Glucagon
Growth hormone
Cortisol
Glucagon-like peptide 1 (GLP-1)
Gastric inhibitory polypeptide (GIP)
Factors that inhibit insulin release include:
Reduced blood glucose
Fasting
Sympathetic stimulation
Somatostatin

## Question 68 of 90

- **A.** Secretin
- **B.** Parasympathetic stimulation
- **C.** Glycogen
- **D.** Growth hormone
- **E.** Sympathetic stimulation

## Question 115 of 121

77. A 55-year-old male brought into the ED with advanced
liver failure. Which one of the following drugs does not
need dose adjustments in this patient?
Liver failure: Liver failure has little influence on
digoxin metabolism or clearance; therefore, no
dose adjustment is necessary.
Renal failure: Digoxin is excreted renally, and
impaired renal function can cause increased digoxin
levels and digoxin toxicity. In this case the patient
should have their digoxin dose reduced and their
digoxin level and electrolytes should be carefully
monitored.

## Question 77 of 90

- **A.** Bisoprolol
- **B.** Diazepam
- **C.** Furosemide
- **D.** Morphine
- **E.** Digoxin
78. A 21-year-old girl presents with double vision. She is
holding her head tilted to the right-hand side. On
examination of her eye movements, you note that both
eyes can look normally to the left but on looking to the right,
her right eye cannot turn outwards past the midline. The left
eye is unaffected when looking to the right. Which one of
the following nerves is likely affected?

## Question 78 of 90

- **A.** Right oculomotor nerve

## Question 116 of 121

Paralysis of right lateral rectus muscle (LR-6)
resulted due to palsy of 6th cranial nerve. Patient
will be unable to abduct the eye and will result in
the affected eye being unable to turn outwards.
High Yield:
Movements of the eyeball (Extra
ocular muscles)
All the extraocular muscles are innervated by
oculomotor nerve except LR-6 and S0-4
- **B.** Right trochlear nerve
- **C.** Left abducent nerve
- **D.** Right optic nerve
- **E.** Right abducent nerve
86. A 64-year-old woman presents to the hospital with an
acutely painful, red, hot, swollen big toe. He has a past
medical history of gout, diabetes mellitus, and severe heart
failure.  Gout is Diagnosed, you plan on commencing her

## Question 86 of 90

## Question 117 of 121

on Colchicine . Which of the following is most common side
effect of Colchicine?
Gastrointestinal disorders are the most common
adverse reactions with colchicine, these include
nausea, vomiting, abdominal pain, and particularly
diarrhea.
Colchicine acts to induce microtubular
depolymerization by Binding tubulin, thereby
leading to decreased activation, Migration, and
degranulation of neutrophils to the affected site.
(RECALL)
In patients with CVD or HF who present with an
acute gout flare, colchicine is considered safe and
potentially reduces the risk of myocardial infarction
(RECALL)
- **A.** Anemia
- **B.** Muscle paralysis
- **C.** Bleeding
- **D.** Ulcer
- **E.** Gastrointestinal disturbance
88. A Patient presents to ED with uncontrolled high blood
pressure and electrolyte imbalances. Nephrologists
suspect dysregulation in the juxtaglomerular cells
secretions. Extensive tests reveal overactive JG cells.
Which of the following is secreted by JG cells?

## Question 88 of 90

- **A.** Aldosterone
- **B.** ADH

## Question 118 of 121

Renin is produced and stored in granular
juxtaglomerular (JG) cells, which are modified
aortic smooth muscle cells found in the media of
afferent arterioles mainly.
Renin angiotensin
aldosterone system (High
Yield)
The Renin-Angiotensin-Aldosterone System (RAAS)
is a hormone system within the body that is
essential for the regulation of blood pressure and
fluid balance. The system is mainly comprised of the
three hormones renin, angiotensin
II and aldosterone.
A fall in CPV (reflecting blood volume) is detected by
atrial and other cardiopulmonary stretch receptors.
Fall in blood volume sufficient to reduce the blood
pressure activates the baroreceptor reflex which in
turn causes increased sympathetic stimulation
resulting in Renal vasoconstriction decreasing the
GFR.
ADH release causing H2O reabsorption.
Renin release from granular cells of JG apparatus
Peripheral vasoconstriction resulting in increased
total peripheral vasoconstriction.
Renin Release
The first stage of the RAAS is the release of the
enzyme renin. Renin released from granular cells of
the renal juxtaglomerular apparatus (JGA) in
response to one of three factors:
- **C.** ACTH
- **D.** Cortisol
- **E.** Renin

## Question 119 of 121

Reduced sodium delivery to the distal convoluted
tubule detected by macula densa cells.
Reduced perfusion pressure in the kidney detected
by baroreceptors in the afferent arteriole.
Sympathetic stimulation of the JGA via
β 1 adrenoreceptors.
Decreased GFR
Decreased ECF volume, arterial blood pressure or
CVP.
Note: The release of renin is inhibited by atrial
natriuretic peptide (ANP), which is released by
stretched atria in response to increases in blood
pressure.
Angiotensin II production
Angiotensinogen is a precursor protein produced in
the liver and cleaved by renin to form angiotensin I.
Angiotensin I is then converted to angiotensin II
by angiotensin converting enzyme (ACE). This
conversion occurs mainly in the lungs where ACE is
produced by vascular endothelial cells, although
ACE is also generated in smaller quantities within
the renal endothelium.
Functions of angiotensin II
Angiotensin 2 acts on AT1 receptors found in the
endothelium of arterioles throughout the
circulation to achieve vasoconstriction. The net
effect of this is an increase in total peripheral
resistance and consequently, blood pressure.
Angiotensin II acts at the hypothalamus to stimulate
the sensation of thirst, resulting in an increase in
fluid consumption. This helps to raise the circulating
volume and in turn, blood pressure.
It also increases the secretion of ADH from
the posterior pituitary gland – resulting in the
production of more concentrated urine to reduce
the loss of fluid from urination.

## Question 120 of 121

0% Complete
Mark as Complete
Previous Next
Angiotensin II acts on the adrenal cortex to
stimulate the release of aldosterone from zona
glomerulosa of the adrenal cortex. Which in turn
causes increased Na reabsorption and K loss. It also
stimulates the sympathetic nervous system to
increase the release of noradrenaline (NA). which in
turn increases cardiac output, release of renin,
vasoconstriction of arterioles.
Causes vasoconstriction of renal arterioles
predominantly efferent arterioles thereby
maintaining or increasing the GFR
Activation of Na-H pump thereby increasing the
reabsorption of Na from proximal tubule.
Inhibits the renin production from granular cells of
JG apparatus (negative feedback)

## Question 121 of 121',
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
    "updated_at" = now();

  -- Lesson: Mock Iii Paper Ii
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'mock-iii-paper-ii',
    'Mock Iii Paper Ii',
    'article',
    '# Mock Iii Paper Ii

> [!NOTE]
> **Instructions:** Single best answer scenario. Read carefully before reviewing the detailed rationale.

Mrcem Primary Complete Course ,High Yield Stuff and Questions Bank ( For Diet ii Late 2026)
Overview  Comments
Share your score colleagues

LinkedIn  Facebook  Twitter

## Question 17 of 90

1. A 45 Years old male suffered penetrating trauma to the
parotid gland with facial nerve injury. Orbicularis oculi
muscle is affected and frontalis muscle is spared. Which of
the following terminal branch of the facial nerve is most
likely injured?
Note: Skin of upper forehead, eye lid and
conjunctiva are innervated by supraorbital nerve
(RECALL) branch of Opthalmic division of
trigeminal nerve

## Question 1 of 90

- **A.** Temporal branch
- **B.** Zygomatic branch
- **C.** Marginal mandibular branch
- **D.** Greater petrosal nerve
- **E.** Buccal branch

## Question 1 of 58

Supratrochlear nerve:  Innervate skin of lower
central forehead and conjunctiva.
2. A 20 Years old girl presents to the ED with complaint of
headache, Palpitations and diaphoresis. After initial
assessment you suspect pheochromocytoma. This clinical
condition occurs due to excess of which of the following
hormones?
Pheochromocytoma is catecholamine secreting
tumor arises from chromaffin cells of adrenal
medulla
Catecholamines include adrenaline, nor adrenaline
and dopamine.
Adrenaline is predominant Harmone in
pheochromocytoma

## Question 2 of 90

- **A.** Oxytocin
- **B.** ADH
- **C.** Catecholamines
- **D.** PTH
- **E.** ACTH
4. A 52 years old chronic smoker presented to the ED with
complaint of sudden severe headache. After initial
assessment and imaging revealed a ruptured berry
aneurysm. Which of the following blood vessel is most
likely location of the aneurysm?
Berry (saccular) aneurysms are the most common
type of intracranial aneurysm, representing 90% of
cerebral aneurysms. The most frequent location is
the anterior communicating artery (35%), followed
by the internal carotid artery
High Yield: Clinical effects of occlusion of cerebral
arteries

## Question 4 of 90

- **A.** Anterior communicating artery
- **B.** Middle cerebral artery
- **C.** Internal carotid artery
- **D.** Posterior cerebellar artery
- **E.** Anterior cerebellar artery

## Question 2 of 58

6. A 40 years old male presents to the ED with chest pain
and the following ECG is taken. Which artery is most likely
be occluded? ￼
ECG demonstrates Acute Inferior Myocardial
Infarction due to occlusion of RCA
St-elevation in inferior leads (II, III,aVF) with
reciprocal ST-depression in I, aVL
Note: Both inferior wall MI and posterior wall MI
occurs due to occlusion of Right coronary artery.

## Question 6 of 90

- **A.** Obtuse marginal artery
- **B.** Right coronary artery
- **C.** left main coronary artery
- **D.** Left circumflex
- **E.** Left anterior descending
7. The probability of rejecting the null hypothesis when it is
true;
In statistical hypothesis testing, a type1 error is the
mistaken rejection of an actually true null

## Question 7 of 90

- **A.** Type 1 error
- **B.** Power of statistical test
- **C.** Type 2 error
- **D.** Level of significance
- **E.** Type 3 error

## Question 3 of 58

hypothesis (also known as false positive” finding or
conclusion; example: innocent person is convicted”).
While type 2 error is the failure to reject the null
hypothesis that is actually false (also known as false
negative. Finding or conclusion example: guilty
person is not convicted) much of statistical theory
revolves around the minimization of one or both of
these errors, though the complete elimination of
either is a statistical impossibility if the outcome is
not determined by a known, observable casual
process. By selecting low threshold (cut-off) value
and modifying the alpha level, the quality of
hypothesis test can be increased. The knowledge of
type 1 error and type 2 error is widely used in
medical science, biometrics and computer science.
8. A 12-year-old girl develops facial swelling and an
erythematous itchy rash shortly after being administered
the first dose of the HPV vaccine. On arrival the
paramedics note a bilateral expiratory wheeze and blood
pressure of 80/50 mmHg of the Gell and Coombs
classification of hypersensitivity reactions this is an
example of a:

## Question 8 of 90

- **A.** Type II reaction
- **B.** Type V reaction
- **C.** Type I reaction
- **D.** Type III reaction
- **E.** Type IV reaction
9. you are prescribing ipratropium bromide for a patient
who has presented with an exacerbation of her COPD.
what is mechanism of action of ipratropium bromide?

## Question 9 of 90

- **A.** Muscarinic agonist

## Question 4 of 58

Ipratropium is an acetylcholine antagonist via
blockade of muscarinic cholinergic receptors.
Blocking cholinergic receptors decreases the
production of cyclic guanosine monophosphate
(cGMP). This decrease in the lung airways will lead
to decreased contraction of the smooth muscles.
- **B.** Muscarinic antagonist
- **C.** Alpha agonist
- **D.** Ca channel blocker
- **E.** Beta agonist
10. A 40-year-old man presents to the emergency
department intoxicated with an abdominal stab wound,
situated just above the umbilicus in the midline. Small
bowel has herniated through the anterior abdominal wall
through the hole created by the knife
The most superficial structure damaged in stabbing?
Camper''s fascia is the most superficial fatty layer
of the anterior abdominal wall.

## Question 10 of 90

- **A.** Camper’s fascia
- **B.** Scarpa’s fascia
- **C.** Aponeurosis of internal oblique
- **D.** Rectus abdominis muscle
- **E.** Transversalis fascia
11. A 25 Years old male presents to the ED with complaints
of fever, photophobia, and neck stiffness. You suspect
meningitis. Which of the following is the feature of
Neisseria meningitis?

## Question 11 of 90

- **A.** Gram +Ve diplococci
- **B.** Gram +Ve rod
- **C.** Gram –Ve rod
- **D.** Gram –Ve diplococci
- **E.** Gram +Ve Cocco bacilli

## Question 5 of 58

Neisseria meningitis is gram negative encapsulated
diplococci causing Neisseria meningitis and
meningococcal sepsis
12. A 5-year-old male child brought into the ED with an
infection after circumcision. The lymphatic from the penile
skin and prepuce drains into which of the following group of
lymph nodes?
Penile skin and prepuce = superficial inguinal lymph
nodes
Glans penis and penile urethra=deep inguinal
lymph nodes(recall)
Scrotum=Superficial inguinal lymph nodes
(RECALL)
Testes= lumber or para-aortic lymph nodes
(RECALL)
prostate= internal iliac nodes (recall)
High Yield:
Pre aortic lymph nodes:
1.coeliac group of preaortic lymph nodes drain:
Abdominal oesophagus
Stomach
Pancreas(recall)
Liver
Spleen
Gallbladder
Duodenum proximal to major duodenal papilla
2. Superior mesenteric group of preaortic lymph
nodes drain:
distal duodenum
Jejunum
Ileum
Cecum
Appendix
Ascending colon
Proximal two third of transverse colon
3. 3. Inferior mesenteric group of preaortic lymph:

## Question 12 of 90

- **A.** Deep inguinal lymph nodes
- **B.** Superficial inguinal lymph nodes
- **C.** Para aortic lymph nodes
- **D.** Internal iliac lymph nodes
- **E.** External iliac lymph nodes

## Question 6 of 58

Distal transverse colon
Descending colon
Sigmoid colon
Proximal rectum
Lumbar or Paraaortic lymph nodes:
Kidney (Recall)
Adrenal gland
Testes (recall)
Ovaries (recall)
14. Which vitamin is also known as anti-sterility vitamin?
vitamin e act as antioxidant prevents the cells from
damage caused by free radicals. Sperm DNA
damage is an emerging cause of male infertility
that is likely to be more common among men with
increased reactive oxygen species in the ejaculate.
Vitamin E can protect the sperm membrane from
oxidative damage and increased levels are
associated with low levels of reactive oxygen
species.

## Question 14 of 90

- **A.** Vitamin E
- **B.** Vitamin A
- **C.** Vitamin D
- **D.** Vitamin C
- **E.** Vitamin K
15. A 60-year-old male with a history of hypertension and
smoking presents to the emergency department with chest
pain. An ECG shows ST-segment elevation in the inferior
leads, and a diagnosis of acute myocardial infarction (MI) is
made. The infarcted tissue in the heart is likely to undergo
which type of necrosis?
Cell death:

## Question 15 of 90

- **A.** Liquefactive necrosis
- **B.** Caseous necrosis
- **C.** Coagulative necrosis
- **D.** Fat necrosis
- **E.** Fibrinoid necrosis

## Question 7 of 58

High yield: Be familiar with all types and examples.
17. A woman sustained a human bite from someone known
to have hepatitis B two hours ago. She has not had any
previous hepatitis B vaccinations
Regarding prophylaxis against hepatitis B, what is the most
appropriate schedule to follow?
Emergency hepatitis B vaccination
If you have been exposed to the hepatitis B virus
and have not been vaccinated before, you should
get immediate medical advice, as you may benefit
from having the hepatitis B vaccine.
In some situations, you may also need to have an
injection of antibodies, called specific hepatitis B
immunoglobulin (HBIG), along with the hepatitis B
vaccine.
HBIG should ideally be given within 48 hours post
exposure Hepatitis B vaccine three doses over three
months

## Question 17 of 90

- **A.** Hepatitis B vaccine three doses over three
months
- **B.** Hepatitis B Immunoglobulin immediately
- **C.** Hepatitis B vaccine three doses over six months
- **D.** Hepatitis B Immunoglobulin immediately and
Hepatitis B vaccine three doses over three months
- **E.** Hepatitis B Immunoglobulin immediately and
Hepatitis 8 vaccine three doses over six months
18. A 10 years old child brought into the ED with complaint
of tiredness, fever and joint pain. His mother states that he

## Question 18 of 90

## Question 8 of 58

had acute sore throat 10 days back. You suspect acute
rheumatic fever secondary to untreated sore throat.
Rheumatic fever is immunological sequalae of which of the
following pathogens?
Streptococcus
Pyogenes
Streptococcus Pyogenes is
gram +Ve Cocci in chains
Beta hemolytic group A
Causes acute sore throat in
children (Recall), skin and soft
tissue infection and
necrotizing fasciitis
Erysipelas: Superficial skin
infection involving upper
dermis and superficial
lymphatics caused by Group
A beta hemolytic
streptococcus pyogenes
(Recall)
Post-infectious immune-
mediated reactions of
Streptococcus Pyogenes
include Rheumatic fever,
erythema nodosum, acute
glomerulonephritis
- **A.** Staph viridians
- **B.** Streptococcus pyogenes
- **C.** Pseudomonas aeruginosa
- **D.** Staphylococcus aureus
- **E.** Staph epidermidis
19. A 54-year-old man presents with visual impairment.
When testing the pupillary light reaction, the right pupil
dilates when the light source moves from the right pupil to
the left.
Which nerve is likely to be abnormal?

## Question 19 of 90

- **A.** Right oculomotor nerve
- **B.** Ophthalmic division of the left trigeminal nerve
- **C.** Left oculomotor nerve
- **D.** Left optic nerve

## Question 9 of 58

In this question examiner is more focused on left
eye that means when light source is tested in left
eye, left eye do not constrict that means loss of
ipsilateral direct pupillary reflex and right pupil
dilation refers to loss of contralateral consensual
pupillary light reflex.
In Complete transection of optic nerve:
loss of ipsilateral direct pupillary reflex
loss of contralateral consensual pupillary light reflex
Optic nerve: (High yield)
Transmit special sensory information from the
retina of the eye to the primary visual cortex of the
brain.
Enters skull via optic canal of the sphenoid bone
Note: Relative afferent pupillary defect (RAPD):
Seen in optic nerve disease or asymmetrical disease
of the retina in which pupils respond differently to
light stimuli shone in one eye at a time
swinging light test if there is no RAPD the pupils of
both eyes constrict equally regardless of which eye
is stimulated by the light.
In an abnormal swinging-light test if there is a
RAPD there is less pupil constriction in the eye with
the retinal or optic nerve disease

> [!TIP]
> **Clinical pearls:**
> Pituitary adenoma: Pituitary gland lies in close
> proximity to optic chiasm,tumor of pituitary gland
> compresses optic nerve at chiasm produces visual
> defect called bitemporal hemianopia
- **E.** Right optic nerve
> 21. A 26-year-old male brought into the ED by paramedics
> with lacerated wound on left upper quadrant. You suspect
> splenic injury. Which rib fracture is likely to be associated
> with spleen injury?

## Question 21 of 90

- **A.** Rib 1

## Question 10 of 58

Spleen injury most Likely associated with fracture
of rib 10.
- **B.** Rib 10
- **C.** Rib 8
- **D.** Rib 4
- **E.** Rib 6
22. A 30 years old man is brought into the Ed by
paramedics with a lacerated wound on his abdomen. which
of the following Structures is most likely affected by a tear
of the superior mesenteric artery?
The superior mesenteric artery supplies the midgut
structures from the second part of duodenum
including the caecum, appendix, ascending colon,
and proximal two-thirds of the transverse colon.
Inferior mesenteric artery supplies the descending
colon and sigmoid colon.

## Question 22 of 90

- **A.** Ascending and transverse colon
- **B.** Transverse and descending colon
- **C.** Transverse colon only
- **D.** Only ascending colon
- **E.** Sigmoid colon
23. Whilst in your cardiology rotation you are asked to
perform cardiovascular examination. One of your senior
registrars asks, what is the best site to auscultate mitral
valve?

## Question 23 of 90

- **A.** Second left intercostal space
- **B.** Right 5th ICS in midclavicular line
- **C.** Apex of heart
- **D.** 5th intercostal space to the lower left sternal
border

## Question 11 of 58

Areas of auscultation of heart:
Note: Aortic valve: Second right intercostal space
(Recall)
Heart sounds, Mechanical event and
correspondence with ECG (High Yield)
- **E.** Second right intercostal space
24. Which of the following statements regarding
experimental studies is true?
Experimental studies are characterised by the fact
that the study subjects are allocated by the
investigator to the different study groups through
the use of randomisation. This randomisation
serves to remove any potential bias.
Clinical trials are experimental studies and may be
Double-blind: where neither the patient nor the
investigator for the treating clinician) are aware of or
which treatment the patient has been randomised
to receive.
Single-blind: where either the patient or the
researcher (or the treating clinician) is not aware
which treatment the patient has been randomised
to, in these studies it is usually the patient that is
not aware of the treatment type.

## Question 24 of 90

- **A.** Examples include cohort studies
- **B.** Randomisation serves to remove potential bias
- **C.** Examples include case-control studies
- **D.** They must be blinded
- **E.** Patients can only receive treatment or placebo

## Question 12 of 58

Unblinded: these are also known as open studies.
Both the patient and the researcher (or treating
clinician) are aware of the treatment type.
Case-control and cohort studies are examples of
observational studies.
25. Carbonic anhydrase enzyme is present in which one of
the following parts of nephron?
Carbonic anhydrase pre-dominant location is
epithelial cells of the Proximal convoluted tubule
Carbonic anhydrase catalyzes formation of Hco3-
and H+ from H20 and Co2

## Question 25 of 90

- **A.** The collecting tubule and duct
- **B.** The descending loop of Henle
- **C.** The proximal convoluted tubules
- **D.** The distal convoluted tubules
- **E.** The ascending loop of Henle
27. A 40-year-old male with a history of chronic back pain
underwent a prolonged course of steroid injections to
manage his symptoms. Which one of the following
hormones will increase in secondary adrenal insufficiency
due to prolong steroid injection?
Long-term steroid therapy can result in secondary
adrenal insufficiency due to suppression of the
hypothalamic-pituitary-adrenal axis. The aetiology
of adrenal insufficiency can be differentiated by
checking serum ACTH which is high in Addison''s
disease and suppressed in secondary adrenal
failure due to hypothalamic or pituitary causes.
In this condition, the hypothalamus may continue
to release corticotropin-releasing hormone (CRH) in
an attempt to stimulate the pituitary gland to
produce more ACTH. However, the lack of ACTH
production by the pituitary gland means that
cortisol levels will not increase, despite high levels of
CRH. Therefore, CRH levels may be high or normal,

## Question 27 of 90

- **A.** Insulin
- **B.** ACTH
- **C.** CRH
- **D.** Cortisol
- **E.** Aldosterone

## Question 13 of 58

while ACTH levels are low in secondary adrenal
insufficiency.
Note: If in question stem not mentioned secondary
adrenal insufficiency then Cortisol would be correct
because exogenous cushing syndrome is the most
likely due to prolong steroid injection while
secondary adrenal insufficiency is rare.
Primary v/s Secondary Adrenal insufficiency:
In contrast to Addison''s disease (primary adrenal
insufficiency), secondary adrenal insufficiency is
characterized by:
Decreased pituitary secretion.
No skin hyperpigmentation (because there is
deficiency of ACTH)
no hyperkalemia or metabolic acidosis (because
aldosterone levels are normal)
28. Which of the following statements about cohort studies
is true? Select ONE answer only.
A cohort study is a form of longitudinal,
observational study that follows a group of patients
(the cohort) forward in time to monitor the effects
of a proposed aetiological factor upon them
They follow a cohort of patients without a disease
and evaluate the absolute and relative risk of
contracting the disease state after exposure to the
aetiological agent. An example of a cohort would be
a group of patients that have been exposed to a
particular drug. This group could then be followed
longitudinally to see if they develop a particular side
effect or disease as consequence of this drug
exposure. The comparison group can be the general
population from which the cohort was drawn, or
alternatively another subgroup of the cohort itself
They are therefore good at investigating rare
exposures as the study design sets the exposure. A
rare outcome is unlikely to appear during the study
time and they are therefore poor at detecting rare
Cohort studies are the best way to determine the
incidence of a disease: Cross-sectional studies are

## Question 28 of 90

- **A.** They are the best way to determine the
prevalence of a disease
- **B.** They are a type of experimental study
- **C.** They are longudinal in nature
- **D.** They are usually shorter in duration than case-
control studies
- **E.** They look at groups of patients with the disease
being studied

## Question 14 of 58

the best way to determine the prevalence of a
disease.
Cohort studies are often compared to case-control
studies. They are generally more expensive and
longer in duration than case-control studies but
usually provide more useful and reliable
information
Subject-selection and loss to follow-up are no
major potential sources of bias with cohort
studies and confounding variables are the main
problem with analysis of the results.
29. A 26-Year-old girl presents to the ED with trauma to the
internal auditory meatus. Which of the following nerves are
most likely injured:
The internal auditory meatus also referred to as the
internal acoustic meatus lies in the temporal bone
and exists between the inner ear and posterior
cranial fossa. It includes the vestibulocochlear nerve
(CN VIII), facial nerve (CN VII), the labyrinthine
artery, and the vestibular ganglion.

## Question 29 of 90

- **A.** Facial nerve and glossopharyngeal nerve
- **B.** Vestibulocochlear nerve and accessory nerve
- **C.** Vestibulocochlear nerve and facial nerve
- **D.** Facial nerve and abducens nerve
- **E.** Trochlear nerve and abducens nerve
30. A 35-year-old woman presents to the emergency
department with sudden onset of severe lower back pain
and numbness in both legs. She reports difficulty with
walking and standing up from a seated position. Upon
further evaluation, the healthcare provider notes decreased
sensation in the saddle area and decreased anal tone,
suggestive of possible cauda equina syndrome. Regarding
anatomy of cauda equina lies at which vertebral level?
The spinal cord is housed in the vertebral canal. It is
continuation of medulla oblongata and terminates

## Question 30 of 90

- **A.** T12-L1
- **B.** T12-S2
- **C.** C3-C5
- **D.** S3-S5
- **E.** C5-C6

## Question 15 of 58

as the conus medullaris at the second lumbar
vertebrae of adults.
At birth, the conus medullaris lies at L3. By the age
of 21, it sits at L1/L2, thus the spinal cord only
occupies about 2/3s of the space available to it in
the vertebral canal.
Below the conus medullaris is cauda equina which
lies below L1 from L2 to sacrum
Note: The cauda equina contains a bundle of nerves
which project distally within the enclosed cavity of
the lumbar cistern from the spinal cord and conus
medullaris toward the coccyx. Each nerve exits at its
respective vertebral level toward targets which are
supplied by the L2-S5 spinal cord level.
31. The mean was calculated for study with normal
distribution. The values distribution around the mean are
measured by?
Standard error of the mean = standard deviation /
square root (number of patients)
High Yield:
Mean or average: is the sum of a collection of
numbers divided by the number of numbers in the
collection
The mode is the value that appears most often in a
set of data
The median is the number separating the higher
half of a data sample, a population, or a probability
distribution, from the lower half. The median of a
finite list of numbers can be found by arranging all
the observations from lowest value to highest value
and picking the middle one
For example, a study looks at the number of
attendances brittle asthmatics have at A&E''s across
the north of England each quarter. Each A&E
submits the number of attendances as below:
1,3,4,5,5,5,6,7,7,9,12,14,17
Mean = 7.5
Mode = 5

## Question 31 of 90

- **A.** Interquartal range
- **B.** Median
- **C.** Variance
- **D.** Standard deviation
- **E.** Mode

## Question 16 of 58

Median = 6
32. A 30 years old male patient presents with right eye
abduction deficit. Which nerve is likely affected?
Right eye abduction deficit leads to adduction of
right eye and unable to abduct right eye.
The right abducens nerve innervates the right
lateral rectus muscle, which is responsible for
abduction (movement away from the midline) of
the right eye
High yield:
Movements of the eyeball (Extra ocular muscles)
All the extraocular muscles are innervated by
oculomotor nerve except LR-6 and S0-4
Remember the lesions of visual pathway (High
yield)

## Question 32 of 90

- **A.** Right trochlear nerve
- **B.** Left oculomotor nerve
- **C.** Right oculomotor nerve
- **D.** Right abducens nerve
- **E.** Left oculomotor nerve

## Question 17 of 58

33. A 23-year-old male presents to the ED with a lacerated
wound on his wrist. You ask junior fellows wrist joint is an
example of ?
Wrist joint: Synovial condyloid joint
Sternoclavicular joint: Synovial saddle-shaped
joint
Acromioclavicular joint: Synovial plane joint
Shoulder joint: Synovial ball and socket joint
Elbow joint: Synovial hinge joint
Radioulnar joints: Synovial pivot joint
The joint between atlas and axis is Pivot joint

## Question 33 of 90

- **A.** Synovial hinge joint
- **B.** Synovial plane joint
- **C.** Synovial pivot joint
- **D.** Synovial condyloid joint
- **E.** Synovial ball and socket joint
34. Damage to Wernicke''s area will most likely result in
which of the following clinical features?
Broca''s aphasia: This is a non-fluent aphasia which
causes individuals to speak slower. It occurs when
the brain’s frontal lobe suffers damage. Individuals
with Broca’s Aphasia often feel frustrated due to
being able to comprehend what others are saying,
but unable to express themselves. also called
Expressive dysphasia. Individuals affected only can
speak in very short phrases, or have trouble getting
words out. (RECALL)
Wernicke’s aphasia: This is a fluent aphasia as this
type of aphasia does not affect the speed of the
individual''s speech. Individuals with this type of
aphasia have damage to their brain’s temporal lobe.
As a result, those of Wernicke’s aphasia are
sometimes unable to comprehend what others are
saying, but are able to speak in long sentences.
However, their communication doesn''t follow

## Question 34 of 90

- **A.** Dysarthria
- **B.** Expressive dysphasia
- **C.** Nystagmus
- **D.** Receptive dysphasia
- **E.** Visual loss

## Question 18 of 58

standard grammar patterns and uses made-up
words. also called receptive dysphasia.
36. A 52-year-old man is unwell with crushing central chest
pain. An ECG shows significant ST segment changes.
Angiography shows occlusion of the circumflex branch of
the left coronary artery.
This condition most commonly results in ischemia in which
area of the heart?
LCA divides into the anterior interventricular branch
and the circumflex branch. The circumflex branch
follows the coronary sulcus to the left border and
onto the posterior surface of the heart and supply
left atrium and left ventricle

## Question 36 of 90

- **A.** Anterior part of the left ventricle
- **B.** Anterior part of the right ventricle
- **C.** Posterior part of the left ventricle
- **D.** Inferior part of the left ventricle
- **E.** Inferior part of the right ventricle
37. A 42-year-old male with history of assault presents to
the ED with complaint of incised wound on the neck. Which
one of the following arteries is most likely injured?
Neck injury may result in the laceration of major
vessels, potentially leading to hemorrhagic shock.
Internal carotid artery is most likely injured.

## Question 37 of 90

- **A.** Internal carotid artery
- **B.** Basillar artery
- **C.** Facial artery
- **D.** Vertebral artery
- **E.** Brachial artery
38. A 15-year-old girl is found to be hyperglycemic. Urine
testing reveals glucose. This urinalysis result is most likely
to be due to what process in the carrier protein of proximal
tubule?

## Question 38 of 90

## Question 19 of 58

The renal tubule plays a significant role in glucose
reabsorption. If the plasma glucose rises, renal
tubular reabsorption of glucose will increase
linearly until it reaches its maximum tubular
resorptive capacity. The capacity of the proximal
tubule to reabsorb glucose to prevent its passing to
the urine is known as the renal threshold. At
threshold, the system becomes saturated and the
maximal reabsorption rate, the glucose transport
maximum is reached and no more glucose can be
absorbed. Due to increase in plasma glucose, the
filtered glucose exceeds the capacity of the tubular
system and the kidneys begin excreting it in the
urine, the beginning of glycosuria
- **A.** Inhibition
- **B.** . Inborn error of metabolism
- **C.** Saturation
- **D.** . Activation
- **E.** Destruction
39. A well established, commonly used, anti-hypertensive
medication has been suggested as a potential cause of
type II diabetes mellitus. Which of the following study
designs would be most appropriate to safely determine
whether an association exists?

In this particular case a meta-analysis would be the
most appropriate study design for the following
reasons:
The medication is already established and
commonly used
Clinical trials are likely to have already been
performed in order for its use in clinical practice to
be licensed
The data needed should be able to be obtained
rapidly and inexpensively

## Question 39 of 90

- **A.** double-blind randomised controlled trial
- **B.** cohort study
- **C.** A crossover study
- **D.** meta-analysis
- **E.** case-control study

## Question 20 of 58

Note: Funnel plots are a visual tool for
investigating publication and other bias in meta-
analysis (Recall)
A double-blind randomised controlled trial seems
unreasonable in this case as the investigators would
be exposing a large number of new patients to a
potential side effect (type I diabetes mellitus).
The crossover design is a modification of the
randomised controlled trial (a type of experimental
study), in which each patient receives treatment
and placebo in a random order. This again seems
unreasonable in this case.
A cohort study is a type of observational,
longitudinal study that looks at a group of people
that share a common characteristic or experience
and follows them over a set time period to analyze
their risk of developing a certain disease. The time
period and expense involved in this type of study
would make it a less suitable option than a meta-
analysis in this case.
A case-control study is another type of
observational study in which two groups of patients,
one with the disease and one without, are
compared on the basis of proposed causative
factors that occurred in the past. This is again,
unsuitable in this case.
41. A 25-year-old male presents to the ED with complaint of
left upper quadrant pain, which structure prevent diffuse
peritonitis across abdomen?
Omentum
Peritoneal fold extending from the stomach to
adjacent neurovascular structures divided into the
greater and lesser omentum
The greater omentum is a fatty apron that hangs
down from the greater curvature of the stomach,
and it plays a role in the immune response to
infections and inflammation in the abdomen. The
greater omentum is known to have a protective
function in the peritoneal cavity, where it can limit
the spread of infection or inflammation to other
parts of the abdomen and help isolate the affected
area.

## Question 41 of 90

- **A.** Greater omentum
- **B.** Cecum
- **C.** Sigmoid colon
- **D.** Small intestinal mesentery
- **E.** Hepatogastric ligament

## Question 21 of 58

Therefore, if diffuse peritonitis is suspected due to a
perforation in the LUQ, the greater omentum may
play a role in containing the spread of the infection
or inflammation and preventing it from becoming
more widespread in the peritoneal cavity.
42. You are teaching group of medical students'' full
neurological examination while assessing dermatomal
supply of trunk you ask medical students, what is the
dermatome of nipple?
Dermatomal supply of trunk:
High yield:

## Question 42 of 90

- **A.** T3
- **B.** T4
- **C.** T6
- **D.** T8
- **E.** T2

## Question 22 of 58

43.  Randomisation such as that used in randomised
control trials are particularly effective in eliminating which of
the following?
Randomisation in RCTs if done correctly, should
eliminate bias in treatment assignment,
specifically selection bias and confounding.
Bias in Randomised controlled trials:
Performance bias occurs when participants know if
they are in the control group and seek other forms
of medical care.
Observer bias occurs where observers interpret a
person''s behavior incorrectly and do not notice
other behaviours, and attribute results according to
the group the participant is allocated. Double
blinding reduces performance and observer bias.
Measurement bias is sometimes also referred to as
systemic error.
Attrition bias results from systematic differences
between treatment groups as a result of differential
withdrawals or exclusions of participants
High yield: Bias and its types
1: Selection bias is a distortion in the estimate of
association between risk factor and disease that
results from how the subjects are selected for the
study.
2: Information bias is due to systematic
measurement error or misclassification of subjects
on one or more variables, either risk factor or
disease status. There are several types of
information bias, including:
Interviewer Bias: An interviewer''s knowledge may
influence the structure of questions and the
manner of presentation, which may influence
responses.
Recall Bias: Those with a particular outcome or
exposure may remember events more clearly or
amplify their recollections

## Question 43 of 90

- **A.** Selection bias
- **B.** Measurement bias
- **C.** Attrition bias
- **D.** Loss to follow up
- **E.** Observer bias

## Question 23 of 58

Observer Bias: Observers may have preconceived
expectations of what they should find in an
examination
Loss to follow-up: those that are lost to follow-up or
who withdraw from the study may be different from
those who are followed for the entire study
Reporting bias: occurs when a case emphasizes the
importance of exposures that he or she believes to
be important.
3: Confounding: Results when the risk factor being
studied is so mixed up with other possible risk
factors that its single effect is very difficult to
distinguish.
44. A 47-year-old gardener has accidentally stabbed his
right foot with a garden fork while working in sandals. He
tells you that he had a full course of vaccinations as a child.
wound is contaminated with manure. What would you
advise him regarding tetanus prophylaxis?
Wound contaminated with soil, manure is high risk
wound. This patient is up to date with
immunisation and more than 10 years are passed
following last dose. He requires immediate
reinforcing of both tetanus immunoglobulin and
vaccine at different sites. Tetanus priming dose are
given at 2,3,4, preschool booster (4 years and 3
months) and then booster dose after every 10 years.
Tetanus prone wound
Clean wounds are defined as: wounds less than 6
hours old, non-penetrating with negligible tissue
damage.
Tetanus-prone wounds include puncture-type
injuries acquired in a contaminated environment
and likely therefore to contain tetanus spores e.g.,
gardening injuries, compound fractures, wounds or
burns with systemic sepsis and certain animal bites
and scratches.

## Question 44 of 90

- **A.** There is no need for any treatment as he is fully
vaccinated
- **B.** He should have his tetanus antibodies checked
before deciding on a booster
- **C.** He should have a tetanus booster
- **D.** He should have a tetanus booster in his left arm
and human tetanus immunoglobulin in his right arm
- **E.** He should have a tetanus booster and human
tetanus immunoglobulin in the same site

## Question 24 of 58

High risk tetanus-prone wound: Heavy
contamination with material likely to contain
tetanus spores e.g., soil, manure, wounds or burns
that show extensive devitalised tissue and wounds
or burns that require surgical intervention that is
delayed for more than six hours are high risk even if
the contamination was not initially heavy.
46. A 55-year-old lady presents to the Emergency
department with complaint of visual loss in Lower left
quadrant in both visual fields. The lesion would most likely
be in which of the following?
Homonymous denotes a condition which affects
the same portion of the visual field of each eye.
Homonymous inferior quadrantanopia is a loss of
vision in the same lower quadrant of visual field in
both eyes whereas a homonymous superior
quadrantanopia is a loss of vision in the same upper
quadrant of visual field in both eyes.
A lesion affecting one side of the temporal lobe may
cause damage to the inferior optic radiations
(known as the temporal pathway or Meyer''s loop)
which can lead to superior quadrantanopia on the
contralateral side of both eyes (RECALL), if the
superior optic radiations (parietal pathway) are

## Question 46 of 90

- **A.** Left parietal lobe
- **B.** Left temporal lobe
- **C.** Right parietal lobe
- **D.** Right temporal lobe
- **E.** Right occipital lobe

## Question 25 of 58

lesioned, the visual loss occurs on the inferior
contralateral side of the both eyes and is referred to
as an inferior Quadrantanopia (RECALL).
47. ADH acts primarily at which of the following sites in
renal nephron?
ADH binds to V2 receptors (Recall) and increases
the number of aquaporin-2 at the apical plasma
membrane of Distal convoluted tubule and
collecting duct and increases water permeability
allowing greater water reabsorption.
Diabetes insipidus
Central DI: Low ADH (Recall) less water absorbed
Nephrogenic DI: ADH resistance, Lithium is the
most common acquired cause of nephrogenic DI.
(Recall)
Biochemical values include high plasma osmolality
>295 mOsm/kg, low urine osmolality <300
mOsm/kg (Recall) and hypernatremia > 145.
Note:
Syndrome of inappropriate ADH secretion:
increased ADH activity (Recall) (Euvolemic hypo
osmolar hyponatremia) Recall
Biochemical values include low plasma osmolality <
275 mOsm/kg, increased urine osmolality > 100
mOsm/kg and increased urine sodium or decreased
plasma sodium (Recall)
Drugs causing S.I.A.D.H= S.S.R.I (Fluoxetine Recall),
antipsychotics, anticonvulsants and T.C.A

## Question 47 of 90

- **A.** Proximal convoluted tubule
- **B.** Thick ascending limb of loop of Henle
- **C.** Thin ascending limb of loop of Henle
- **D.** Distal convoluted tubule
- **E.** Descending limb of loop of Henle
48. A 45 years old male presents to the ED with history of
severe vomiting for the last 4 days.. The patient is irritable,
weak, and reporting muscle cramping and weakness. On
assessment, the patient is experiencing bradypnea with a
respiratory rate of 10. The patient has the following ABGs
result: HCO3 36, pH 7.52, PaCO2 48. Which condition
below is presenting?

## Question 48 of 90

- **A.** Respiratory alkalosis fully compensated
- **B.** Metabolic acidosis partially compensated

## Question 26 of 58

If the primary acid-base disorder is from a
respiratory cause, the kidneys will compensate
(renal compensation).
If the primary disorder is from a metabolic cause,
the lungs will compensate (respiratory
compensation).
Metabolic acidosis= Respiratory compensation
(decrease in PaCO2)
Metabolic alkalosis= Respiratory compensation
(increase in PaCO2)
Respiratory acidosis= Renal compensation (increase
in HCO3-)
Respiratory alkalosis= Renal compensation
(decrease in HCO3-)
- **C.** Metabolic acidosis not compensated
- **D.** Metabolic alkalosis partially compensated
- **E.** Metabolic alkalosis fully compensated
49. Fetal hemoglobin shifts the o2 saturation curve to left
due to?
Fetal hemoglobin has a higher affinity for oxygen
than adult hemoglobin. Maternal and Fetal blood
never mix during pregnancy, but they come close
to each other in the placenta.  Oxygen diffuses
easily to fetal hemoglobin here.
The reason fetal hemoglobin has a higher affinity
for 02. It is composed of two alpha and two gamma
subunits, while adult hemoglobin is composed of
two alpha and two beta subunits.
2,3DPG present in RBCs enhance the ability of RBCs
to release o2 near tissue and 2,3DPG only binds
with beta globulin chains, fetal hemoglobin (HbF)
lack of beta globulin chains that’s why fetal
hemoglobin has higher affinity for O2(RECALL).

## Question 49 of 90

- **A.** Decrease in pH
- **B.** Increased affinity for O2
- **C.** Increased P50
- **D.** Strongly bind with 2,3DPG
- **E.** Decreased affinity for O2
50. A 29 years old male presents to the ED with complaint
of foot drop and loss of sensation on the dorsum of the

## Question 50 of 90

## Question 27 of 58

foot. Which of the following nerve is most likely damaged?
Common fibular nerve wraps around the neck of
fibula and enter lateral compartment of leg where it
gives rise terminal branches:
Superficial fibular nerve: Runs around lateral
compartment of leg and skin over lower
anterolateral leg, and dorsum of foot (except skin
over webspace of 1st and 2nd toe)
Deep fibular nerve: Anterior compartment of leg
and skin over webspace between 1st and 2nd toes
(RECALL)

> [!TIP]
> **Clinical pearls:**
> 1: Common fibular nerve injury: Damage to the
> common fibular (peroneal) nerve may occur as a
> result of fracture of the head or neck of the fibula
> because it passes behind the head of the fibula and
> then winds laterally around the neck. The nerve
> damage results in foot drop (loss of dorsiflexion)
> and loss of sensation on the dorsum of the foot and
> lateral aspect of the leg and causes paralysis of all
> muscles in the anterior and lateral compartments
> of the leg (dorsiflexors and evertors muscles of the
> foot).

2: Superficial fibular nerve: May be damaged by
fracture of the fibula. As the muscles that the
superficial fibular nerve innervates are evertors,
injury to the nerve may result in a loss of eversion
and loss of sensation over the lower anterolateral
leg and dorsum of foot.
3: Deep fibular nerve:
Motor Loss: Loss of dorsiflexion of ankle resulting in
foot drop. In foot drop foot will appear permanently
plantarflexed, foot drop with high-stepping gait,
weakness of foot inversion.
Sensory Loss: Loss of sensation over webspace
between 1st and 2nd toes.
Note: Footdrop is due to Common fibular or
common peroneal nerve or also due to deep
fibular nerve injury.
Note: It is very important to remember direct
innervation of common fibular nerve.
Deep fibular nerve root: L4-L5
Superficial fibular nerve root: L4-S1.
- **A.** Sciatic nerve
- **B.** Tibial nerve
- **C.** Posterior tibial nerve
- **D.** Common peroneal nerve
- **E.** Sural nerve

## Question 28 of 58

Muscles of lateral compartment of leg: (High
Yield)
51. A 20 years old young boy after assault in the college
presents to the ED with superficial lacerated wound on his
anterior triangle of neck. Which of the following muscle is
most likely injured?
Neck fascia is divided into superficial and deep
fascia
Superficial fascia includes: Superficial veins (External
jugular), superficial lymph nodes, fat and platysma
muscle
Deep fascia includes: Trapezius,
sternocleidomastoid, Visceras of neck and
vasculature includes common carotid artery,
internal jugular vein and vagus nerve in the carotid
sheath.

## Question 51 of 90

- **A.** Scalene muscle
- **B.** Trapezius muscle
- **C.** Platysma
- **D.** Sternocleidomastoid
- **E.** Suprahyoid
52. Antidiuretic hormone (ADH) acts primarily at which of
the following sites in renal nephron?
Antidiuretic hormone (ADH), also known as
vasopressin, is a small peptide hormone which
regulates the body’s retention of water. The main
action of ADH in the kidney is to regulate the

## Question 52 of 90

- **A.** Thick ascending limb of loop of Henle
- **B.** Distal convoluted tubule and collecting ducts
- **C.** Proximal tubule
- **D.** Descending limb of loop of Henle
- **E.** Thin ascending limb of loop of Henle

## Question 29 of 58

volume and osmolarity of the urine. Specifically, it
acts in the distal convoluted tubule (DCT) and
collecting ducts (CD).
ADH synthesized by hypothalamus and secreted
from Posterior pituitary (RECALL)
ADH binds to V2 receptors on renal principal cells
of late distal tubules and collecting ducts
(RECALL)
ADH also binds with V1 receptors on vascular
smooth muscles.
Central diabetes insipidus result from deficiency
ADH secretion (RECALL)
Nephrogenic diabetes insipidus result from
inappropriate renal response to ADH
54. A 25 years old male patient with a history of trauma
presents into the ED with complaint of pain in epigastrium
radiating to the back. Which of the following is the
segmental innervation of the pancreas?
Innervations:
The segmental level of innervation of pancreas= T6-
T10
Gallbladder=phrenic(C3-C5)
Ascending and transverse colon= fibers travel
through lesser splanchnic nerve to =T10-T11 spinal
cord segment
Descending and sigmoid colon=pain fibers travel
through lumber splanchnic nerve to= L1 and L2
spinal segments
Ureter=Sympathetic supply from inferior
hypogastric plexus
parasympathetic supply from pelvic splanchnic
nerve(S2-S4)
Visceral afferent fibers follow sympathetic fibers to
enter in spinal cord via =T10-L1 nerve fibers
Bladder= Efferent parasympathetic fibers from
pelvic splanchnic nerve=S2 to S4
ovary=sympathetic fibers of ovarian and lumber
splanchnic nerve to cell bodies in the = T10-T12 and
L1 spinal sensory ganglion
Testes= visceral afferent fibers follow the
sympathetic fibers to=T10-L1
Rectum= visceral afferent fibers follow
parasympathetic supply to =S2-S4 sensory ganglia.

## Question 54 of 90

- **A.** T6 –T10
- **B.** L1-L2
- **C.** T4-T8
- **D.** T4 –T10
- **E.** L2-L4

## Question 30 of 58

55. Which of the following best describes the course of the
great saphenous vein:
The great saphenous vein passes anterior to the
medial malleolus, travels up the medial side of the
leg, and thigh to pass through the saphenous
opening in the deep fascia of thigh, and joins with
femoral vein.
Small saphenous vein passes posterior to lateral
malleolus

## Question 55 of 90

- **A.** Posterior to lateral malleolus
- **B.** Anterior to medial malleolus
- **C.** Posterior to medial malleolus
- **D.** Anterior to lateral malleolus
- **E.** Passes behind posterior malleolus
56. An 87-year-old woman from a residential home with a
2-day history of diarrhea. She has had 10 episodes of
watery diarrhea but no vomiting. She complains of colicky
lower abdominal pain. She had a 5-day course of
antibiotics for a chest infection 2 weeks ago. Observations
show a respiratory rate 18 bpm, Sp02 95% in air, heart rate
89 bpm,
BP 146/89 mmHg, temp 36.8''C and BM 5.6 Examination
reveals that her abdomen is soft but there is generalized
tenderness especially across her lower abdomen. What is
the most likely causative organism?
Broad spectrum antibiotics disturb the normal gut
flora and cause overgrowth of clostridium difficile
spores and causing Pseudomembranous colitis

## Question 56 of 90

- **A.** Norovirus
- **B.** Rotavirus
- **C.** Clostridium difficile
- **D.** E. coli
- **E.** Campylobacter

## Question 31 of 58

Antibiotics causing clostridium difficile colitis: Co-
Amoxiclav, Cephalosporins, Clindamycin and
quinolones
Treatment of choice of clostridium difficile colitis
is Vancomycin (Recall)
57. Which of the following statistical statements is
incorrect?
The prevalence of a disease is the proportion of the
population affected by that disease at a specific
time.

## Question 57 of 90

- **A.** The prevalence of a disease is the rate at which
new cases occur in a population during a specified
period
- **B.** The specificity is the proportion of true
negatives correctly identified by the test
- **C.** The number needed to treat (NNT) can be
calculated by 1 divided by the absolute risk reduction
- **D.** The relative risk measures the strength of
association between a factor and an outcome
- **E.** In a normal distribution the median is the
middle point of the observations

## Question 32 of 58

The incidence of a disease is the rate at which new
cases occur in a population during a specified
period.
Relative risk, or risk ratio, (RR) is used to compare
the risk in the two different groups. It is the ratio of
the absolute risks of the disease in the treatment
group (ART) to the absolute risk of the disease in the
control group (ARC). It measures the strength of
association between a factor and an outcome.
In a normal distribution the median is the middle
point of the observations.
The number needed to treat (NNT) is defined as the
inverse of the absolute risk reduction (ARR) and can
therefore be calculated by: NNT = 1 / ARR
The specificity is the proportion of true negatives
correctly identified by the test
58. Regarding the blood supply of abdomen, superior
mesenteric artery supply which one of the following
structures?
1. coeliac trunk supply the
Abdominal oesophagus
stomach
pancreas
liver
spleen
gallbladder
duodenum proximal to major duodenal papilla
2. Superior mesenteric artery supply the:
Distal duodenum
Jejunum
Ileum
cecum
Appendix
Ascending colon (RECALL)
Proximal two third of transverse colon
3.Inferior mesenteric artery supply the:
Distal transverse colon
Descending colon (RECALL)
Sigmoid colon
Proximal rectum

## Question 58 of 90

- **A.** Kidneys
- **B.** Oesophagus
- **C.** Sigmoid colon
- **D.** Ascending colon
- **E.** Descending colon

## Question 33 of 58

59. A 24 years old female who is 3 months pregnant came
into the ED with complaint of lower abdominal pain. You
suspect ectopic pregnancy. Ectopic pregnancy occurs most
commonly in which part of uterine tube?
Ectopic pregnancies most commonly occur in
ampulla.

## Question 59 of 90

- **A.** Fimbriae
- **B.** Infundibulum
- **C.** Ampulla
- **D.** Isthmus
- **E.** Cervix
60. 30 years old man is brought into the Ed by paramedics
with a gunshot wound on his abdomen. On laparotomy
retroperitoneal hemorrhage found. Which of the following
structures is the most likely source of bleeding?
SADPUCKER useful mnemonic to remember
retroperitoneal organs
S: Suprarenal (adrenal) gland
- **A.** aorta/IVC
- **D.** duodenum (Second and third part)
P: pancreas (except tail)
U: ureters
- **C.** colon (ascending and descending)
K: kidneys
- **E.** (o)esophagus
R: rectum

## Question 60 of 90

- **A.** Liver
- **B.** First part of duodenum
- **C.** Spleen
- **D.** Suprarenal glands
- **E.** Sigmoid colon
62. Which one of the following vessels is compressed in
thoracic outlet syndrome?

## Question 62 of 90

- **A.** Subclavian artery and vein

## Question 34 of 58

Thoracic outlet syndrome (TOS) refers to the clinical
features that arise from compression of the
neurovascular bundle within the thoracic outlet.
Compression of brachial plexus
Compression of subclavian artery
Compression of subclavian vein
Structures that pass through the thoracic inlet
include: (High Yield)
Trachea and oesophagus
Thoracic duct and apices of the lung
phrenic nerve
vagus nerve
Recurrent laryngeal nerves
Sympathetic trunks
Left and right common carotid arteries.
left subclavian arteries.
Internal jugular veins
Brachiocephalic veins
Subclavian veins
lymph nodes and lymphatic vessels
- **B.** Vertebral artery
- **C.** Common carotid artery
- **D.** Brachiocephalic trunk
- **E.** Internal carotid artery
63. Which of the following is a cause of metabolic
alkalosis?
Metabolic alkalosis
Loss of fixed H+ or gain of base produces an
increase in arterial [HCO3-]. This increase is the
primary disturbance in metabolic alkalosis.
In vomiting H is lost from stomach, HCO3 remains
behind in the blood, and the [HCO3] increases,
increased [HCO3] causes an increase in blood PH
(Alkalemia). Alkalemia causes hypoventilation which
is the respiratory compensation for metabolic
alkalosis. It has features of hypocalcemia (decreased
unbound plasma Ca) and hypokalemia (because of
IC shift of K) e.g., tetany, paresthesia, muscle
cramps.

## Question 63 of 90

- **A.** Treatment with acetazolamide
- **B.** Chronic renal failure
- **C.** Hyperaldosteronism
- **D.** Ethylene glycol ingestion
- **E.** Diarrhea

## Question 35 of 58

Correction of metabolic alkalosis consists of
increased excretion of HCO3 because the filtered
load of HCO3 exceeds the ability of renal tubule to
reabsorb
it.
If metabolic alkalosis is accompanied by ECF
volume contraction (vomiting), the reabsorption of
HCO3 increases (secondary to ECF volume
contraction and activation of the renin angiotensin
II aldosterone system), worsening the metabolic
alkalosis (contraction alkalosis).
Causes:
Gastrointestinal losses
Vomiting, nasogastric drainage, pyloric stenosis
Some villous adenomas
Renal losses
Chloruretic drugs (e.g., thiazides, furosemide)
Mineralocorticoid excess syndromes
Primary Hyperaldosteronism
Other causes:
Alkali intake or administration
Milk alkali syndrome
severe potassium depletion (serum potassium <2
mmol/L)
65. Which one of the following pathogens causes
ophthalmia neonatorum occurring in the 1  28 days of life?
Ophthalmia neonatorum is conjunctivitis occurring
within the first 4 weeks of life.
The most serious cause is infection with Neisseria
gonorrhea in first week most likely in 3-4 days of
life, but in the UK, it is caused more commonly by
Chlamydia in first 28 days of life.

## Question 65 of 90

st
- **A.** Gardnerella vaginalis
- **B.** Treponema pallidum
- **C.** Trichomonas vaginalis
- **D.** Chlamydia trachomatis
- **E.** Neisseria gonorrhoeae
66. A 40-year-old woman presents to the emergency
department with painful swollen digit, the infection appears
to have spread to the common flexor sheath. Which of the

## Question 66 of 90

## Question 36 of 58

following digit is most likely to be involved with spread of
infection to this location?
The synovial sheath of the little finger is usually
continued with the common flexor sheath which is
also called ulnar bursa thus infection of ulnar bursa
most likely to involve the little finger.
In a same way infection of thumb may spread to
mid palmer space through the continuous synovial
sheath of the flexor pollicis longus which is also
called radial bursa.
- **A.** Index finger
- **B.** Little finger
- **C.** Ring finger
- **D.** Middle finger
- **E.** Thumb
67. First part of duodenum lies at which level of vertebral
level?
First part of the duodenum extends from the
pyloric sphincter of the stomach wraps around
head of pancreas in C-shaped and ends at
duodenojejunal flexure (Recall)
First part lies at vertebral level L1.
2nd part L2-L3
3rd part longest section crossing inferior vena cava
and Aorta at level L3
4th part: pass upward on left of abdominal Aorta at
L2

> [!TIP]
> **Clinical pearls: (High Yield)**
> Duodenal ulcer: erosion of the mucosa in the
> duodenum
> most likely to occur in the superior portion of the
> duodenum.

The most common causes of duodenal ulcers are
Helicobacter pylori infection and chronic NSAID
therapy.

## Question 67 of 90

- **A.** T8
- **B.** L2
- **C.** T12
- **D.** L1
- **E.** T6

## Question 37 of 58

Duodenal ulcer most likely erosion of the
gastroduodenal artery
69. Type of bias in which knowledge, beliefs, or
expectations may influence the participant''s responses and
interviewr is not blinded?
The type of bias in which interviewer are not
blinded is known as interviewer bias. This occurs
when the interviewer''s knowledge, beliefs, or
expectations influence the participant''s responses.
For example, if an interviewer believes that a
particular treatment is effective, they may
unintentionally give cues or ask leading questions
that encourage participants to report positive
outcomes, even if they did not experience them.
Similarly, if an interviewer is aware of a participant''s
demographic or clinical characteristics, they may
unintentionally treat them differently or interpret
their responses in a biased way. To minimize
interviewer bias, researchers can use standardized
interview protocols, train interviewers to be neutral
and non-directive, and blind interviewers to the
study hypotheses or participant characteristics.
High yield: Bias and its types
1: Selection bias is a distortion in the estimate of
association between risk factor and disease that
results from how the subjects are selected for the
study.
2: Information bias is due to systematic
measurement error or misclassification of subjects
on one or more variables, either risk factor or
disease status. There are several types of
information bias, including:
Interviewer Bias: An interviewer''s knowledge may
influence the structure of questions and the
manner of presentation, which may influence
responses.
Recall Bias: Those with a particular outcome or
exposure may remember events more clearly or
amplify their recollections.
Observer Bias: Observers may have preconceived
expectations of what they should find in an
examination.

## Question 69 of 90

- **A.** Recall bias
- **B.** Observer bias
- **C.** Confounding bias
- **D.** Interviewer bias
- **E.** Selection bias

## Question 38 of 58

Loss to follow-up: those that are lost to follow-up or
who withdraw from the study may be different from
those who are followed for the entire study.
Reporting bias: occurs when a case emphasizes the
importance of exposures that he or she believes to
be important.
3: Confounding: Results when the risk factor being
studied is so mixed up with other possible risk
factors that its single effect is very difficult to
distinguish.
71. A 30-year-old man presents to the ED with an anterior
shoulder dislocation while playing, now he is unable to
initiate abduction of the arm following reduction of a
dislocated shoulder. Which one of the following muscles is
most likely injured?
Supraspinatus is part of the rotator cuff group of
muscles which initiate the abduction of shoulder
from 0 to 15 degrees and then assists the deltoid
with continued abduction. Supraspinatus muscle
supplied by suprascapular nerve, "empty can test"
use to examine this muscle.
Teres minor muscle assessment test=Hornblower’s
test) RECALL)
Subscapularis muscle assessment test (lift-off Test)
RECALL
Most commonly torn tendon of rotator cuff is
supraspinatus muscle (RECALL)
Teres minor and deltoid muscle innervated by
Axillary nerve (RECALL)
Supraspinatus Is innervated by suprascapular nerve
Subscapular is innervated by subscapular nerve

## Question 71 of 90

- **A.** Teres minor
- **B.** Teres major
- **C.** Supraspinatus
- **D.** Infraspinatus
- **E.** Subscapularis
72. Which of the following diet is a rich source of calcium?

## Question 72 of 90

- **A.** Soyabean
- **B.** Broccoli
- **C.** Sun flower
- **D.** Broccoli

## Question 39 of 58

Rcem key:  soyabean is a rich source of calcium
Note: Dairy products which include cheese, leafy
vegetables, and Soybean is rich in calcium.
Almond is also rich in calcium but if both almond
and cheese are in option choose dairy product
cheese because cheese has more calcium than
almond per 100gm.
- **E.** Tomato
73. You are going to attempt lumbar puncture in a patient
with suspected meningitis. What is the recommended
vertebral level to perform LP?
A lumbar puncture (LP) is a procedure in which a
needle is inserted into the spinal canal. It is most
commonly used to collect a sample of
cerebrospinal fluid (CSF) for diagnostic testing (e.g.,
for suspected meningitis and subarachnoid
hemorrhage)
Lumbar puncture is preferentially performed at
L3/L4 or L4/L5 (cauda equina level), to avoid the
spinal cord which ends at L1/L2.
The layers penetrated by the spinal needle in an LP
are as follows:
Skin
subcutaneous tissue
supraspinous ligament (RECALL)
Interspinous ligament
ligamentum flavum
Epidural space or extradural
dura mater
arachnoid mater
subarachnoid space (contains CSF)

## Question 73 of 90

- **A.** L4/L5
- **B.** L1/L2
- **C.** L2/L3
- **D.** T11/T12
- **E.** T12/L1
74. 70 years old male presents to the ED with complain of
expressive Broca''s dysphasia. The brocas speech area is
located in which of the following regions?

## Question 74 of 90

- **A.** Temporal lobe

## Question 40 of 58

Broca’s speech area is located in frontal lobe
Broca’s aphasia or expressive aphasia is when
people find it very difficult to find and say the right
words. People with Broca''s aphasia may only be
able to say single words or very short sentences,
although it’s usually possible for other people to
understand what they mean
Wernicke''s aphasia (fluent aphasia) in the
temporal lobe.
Wernicke’s aphasia or receptive aphasia is when
someone is able to speak well and use long
sentences, but what they say does not make any
sense.
- **B.** Parietal lobe
- **C.** Midbrain
- **D.** Frontal lobe
- **E.** Occipital lobe
75. During a cholecystectomy procedure, the surgeon
accidentally lacerates the artery. Which one of the following
arteries supplies gall bladdar?
Gall bladder blood supply: cystic artery branch of
right hepatic artery. Right hepatic artery is itself
branch of common hepatic artery one of branch of
coeliac trunk.

## Question 75 of 90

- **A.** Superior mesenteric artery
- **B.** Right hepatic artery
- **C.** Cystic artery
- **D.** Inferior mesenteric artery
- **E.** Splenic artery
76. A 40 years old male presents to the ED with complaint
of lacerated wound on medial compartment of thigh, on
examination he is unable to perform extension and medial
rotation. Which one of the following muscles is most likely
injured?

## Question 76 of 90

- **A.** Adductor brevis
- **B.** Adductor magnus

## Question 41 of 58

EXP: All the muscles of medial compartment of
thigh are innervated by obturator nerve except
hamstring portion of adductor magnus.
Adductor
magnus
Adduction and
medial rotation at
hip
Hamstring part:
Adduction and
extension of thigh
at hip
Adductor part:
Obturator nerve
Hamstring part:
Sciatic nerve
(tibial division)
Recall
- **C.** Adductor longus
- **D.** Gracilis
- **E.** Obturator externus
78. A 30-year-old woman presents to the ED with
weakness and fatigue. On examination, she has yellow
tinge skin, jaundice, and mild splenomegaly. CBC shows
her Hb 7g/dl. The patient only takes one medication. Which
of the following medications is most likely to cause
hemolytic anemia?
Among NSAIDs, Mefenamic acid causes hemolytic
anemia.
Co-amoxiclav causes Cholestatic jaundice
(RECALL)
Summary Of Drugs And Their
Side Effects (High Yield)

## Question 78 of 90

- **A.** Ibuprofen
- **B.** Lithium
- **C.** Mefenamic acid
- **D.** Propranolol
- **E.** TCA

## Question 42 of 58

80. You are asked to perform ascitic tap on a CLD patient
and teach a group of medical students. You ask medical
students what is the site to perform ascitic tap.
Ascites or hemoperitoneum accumulates in
Morrisons pouch or Hepatorenal recess or Right
perihepatic space which is lowest space in
peritoneal cavity in Supine position
Subphrenic or right subphrenic (pus from
appendicitis or ruptured duodenal ulcer accumulate
here

## Question 80 of 90

- **A.** Left perihepatic space
- **B.** Right subphrenic space
- **C.** Left lower quadrant
- **D.** Right perihepatic space
- **E.** Left subphrenic space
82. You are required to perform resuscitative thoracotomy
in a patient with massive hemothorax. Which one of the
following muscles are divided during anterolateral
thoracotomy?

## Question 82 of 90

- **A.** Trapezius
- **B.** Anterior scalene
- **C.** Latissimus dorsi
- **D.** Serratus anterior

## Question 43 of 58

Antero lateral thoracotomy muscle divided serratus
anterior and pectoralis major
Antero lateral thoracotomy: Nerve injury long
thoracic nerve (Recall)
Post: lateral thoracotomy muscle divided latissimus
dorsi
Post: lateral thoracotomy nerve injury:
Thoracodorsal nerve injury
Internal mammary artery (RECALL) and Aorta are
likely to be damaged also
- **E.** Pectoralis minor
83. A 30 years old male presents to the ED with lacerated
wound on his posterolateral back. Which of the following
muscle is most likely affected?
Latissimus dorsi is the superficial muscle of the
posterolateral back innervated by Thoracodorsal
Nerve (RECALL)
Ask the patient to shrug his/her shoulder if patient
unable to do this indicates spinal accessory nerve
injury and paralysis of trapezius muscle (RECALL)
Winging of scapula is due to paralysis of serratus
anterior muscle innervated by Long thoracic nerve
(RECALL)

## Question 83 of 90

- **A.** Rhomboid minor
- **B.** Sternocleidomastoid
- **C.** Trapezius
- **D.** Latissimus dorsi
- **E.** Levator Scapulae
84. Bilirubin is a byproduct of heme catabolism and is
excreted in the bile and stool. Bilirubin is likely derived
from?

## Question 84 of 90

## Question 44 of 58

Heme is an important functional group of
hemoglobin. Bilirubin, which is a byproduct of
heme breakdown, comes from red blood cells. The
liver receives unconjugated bilirubin from the blood
and conjugates it via phase II metabolism to make
it more soluble for excretion via the bile and stool.
Fat cells (adipocytes), skin cells (epithelial cells), and
small intestine absorptive cells (enterocytes) do not
contain heme to be processed into bilirubin.
- **A.** Epithelial cells
- **B.** Enterocytes
- **C.** Red blood cells
- **D.** Mesangial cells
- **E.** Adipocytes
85. Regarding culture medium for bacterial growth,
neisseria spp grow on which one of the following culture
media?
Culture Medium For Bacterial Growth

## Question 85 of 90

- **A.** Choclate agar
- **B.** Solid media
- **C.** MacConkey medium
- **D.** Loeffler''s medium
- **E.** Blood agar
86. A 26-year-old female came into ED with complain of
diplopia on upward gaze in her right eye. She gives history
trauma to the face while dancing during the festival and
sustaining orbital blow out fracture. Entrapment of which
one of the following muscles leads to this?

## Question 86 of 90

- **A.** Superior oblique muscle
- **B.** Superior rectus muscle
- **C.** Inferior rectus muscle

## Question 45 of 58

Orbital blow out fracture
MOI: Direct blow to the globe of the eye (commonly
from a squash ball or a shuttlecock), resulting in a
fracture of the orbital floor and prolapse of contents
into the maxillary sinus.
Clinical features: Pt may have diplopia and can’t
look up and medially due to inferior rectus
entrapment.
Test infra-orbital nerve function as infra-orbital
nerve commonly damage in this injury.
- **D.** Lateral rectus muscle
- **E.** Medial rectus muscle
87. 22 years old young female came into ED with complain
of sudden onset of lower limb weakness. She has history of
Sore throat 10 days ago. On Examination her reflexes are
absent in his lower limbs. What is the most likely causative
organism?
GBS cases seem to occur after a viral or bacterial
infection like those that cause sore throats or
diarrhea characterized by lower limb weakness,
paresthesia and hyporeflexia

## Question 87 of 90

- **A.** Salmonella
- **B.** Campylobacter jejuni
- **C.** Clostridium difficile
- **D.** Staphylococcus aureus
- **E.** Clostridium perfringens
88. A 32-year-old male with a history of RTA presented to
ED with Complain of pain in his Right shoulder. X-ray was
done which shows anterior shoulder dislocation. Which of
the following nerve is most likely damaged?

## Question 88 of 90

- **A.** Axillary nerve
- **B.** Suprascapular nerve
- **C.** Median nerve
- **D.** Lower subscapular nerve
- **E.** Ulnar nerve

## Question 46 of 58

Intrinsic muscles of the shoulder: Connecting the
scapula to the humerus
There are six muscles in this group the deltoid, teres
major, and the four rotator cuff muscles
(supraspinatus, infraspinatus, subscapularis, and
teres minor).
Anatomical course: (High Yield)
Axillary nerve arises in the axilla passes medially to
the surgical neck of the humerus, where it divides
into three terminal branches:
Anterior terminal branch:  winds around the
surgical neck of the humerus and provides motor
innervation to the anterior aspect of the deltoid
muscle.
Posterior terminal branch:  Gives motor innervation
to the posterior aspect of the deltoid muscle and
teres minor. It also innervates the skin over the
inferior part of the deltoid as the upper lateral
cutaneous nerve of the arm.
Articular branch: supplies the glenohumeral joint

> [!TIP]
> **Clinical Pearls:**
> Axillary nerve injury is commonly caused by
> fracture of surgical neck of humerus or inferior
> dislocation of humerus.

Causes weak lateral rotation and abduction of the
arm. (Supraspinatus can abduct the arm but not to
a horizontal level).
Loss of sensation over the inferior portion of the
deltoid (the ‘regimental badge area’).
Quadrangular space: Axillary nerve and posterior
circumflex humeral artery and vein pass through it
and can be compressed as a result of trauma,
muscle hypertrophy resulting in weakness of deltoid
and teres minor.
Note: Axillary nerve injury also results in
weakness of deltoid (RECALL) and teres minor
and resulting in weakness of abduction and
lateral rotation.
89. You are teaching group of medical students anatomy of
inguinal region. You ask medical students Deep inguinal
Ring is a defect in which of the following structure?

## Question 89 of 90

- **A.** Rectus abdominis aponeurosis

## Question 47 of 58

Deep inguinal ring is formed by transversalis fascia.
Superficial inguinal ring is formed by External
Oblique. (Recall)
- **B.** Internal oblique aponeurosis
- **C.** External oblique aponeurosis
- **D.** Transversalis fascia
- **E.** Transversus abdominis aponeurosis
90. Epinephrine cause vasoconstriction by acting on which
receptors?
Alpha 1: vasoconstriction
Alpha 2: vasodilation
Beta 1: centrally increases automaticity, heart rate,
myocardial contractility
Beta 1: Peripherally vasodilates against alpha 1
vasoconstriction
Beta 2 - bronchodilation

## Question 90 of 90

- **A.** Alpha-2
- **B.** Beta-1
- **C.** AChR
- **D.** Alpha-1
- **E.** Beta-2
3. A 40 years old male presents to the ED with complain of
ptosis with left-sided droopy eye and dry left face. You
suspect Horner''s syndrome. Which of the following nerve is
most likely affected?
Sympathetic fibers if unilaterally damaged may
produce ipsilateral Horner''s syndrome. Horner''s
syndrome characterized by triad of:

## Question 3 of 90

- **A.** Long Ciliary nerve
- **B.** Facial nerve
- **C.** Vagus nerve
- **D.** Infratrochlear nerve
- **E.** Cervical Sympathetic chain

## Question 48 of 58

Ptosis
Miosis
Anhidrosis
5. A 50-year-old male presents to the emergency
department with complain of visual disturbance in his right
eye on examination you note when you show a light in his
right eye, neither his right or Left pupil constrict but when
you show a light in his left eye both his left and right pupil
constrict. which of the following nerve is most likely
affected?
Loss of afferent pupillary light reflex is seen in
complete palsy of optic nerve. the ipsilateral direct
and contralateral consensual reflexes are lost as the
afferent optic nerve does not sense the light shown
in affected eye but the contralateral direct and
ipsilateral consensual reflexes are intact as the
efferent oculomotor nerve is normal

## Question 5 of 90

- **A.** Abducens nerve
- **B.** Trigeminal nerve
- **C.** Oculomotor nerve
- **D.** Trochlear nerve
- **E.** Optic nerve
13. Which of the following shift oxygen hemoglobin
dissociation curve to left?
Leftward shift: Increased affinity for oxygen (Less
willing to give up oxygen)
Increased affinity for oxygen (Less willing to give up
oxygen)
Increased pH
Decreased pCO2
Decreased temperature
Decreased H+(RECALL)
Decreased 2-3DPG
CO (RECALLL)
Methemoglobinemia

## Question 13 of 90

- **A.** Increased Pco2
- **B.** Decreased PH
- **C.** Increased 2-3DPG
- **D.** Increase temperature
- **E.** CO Poisoning

## Question 49 of 58

Fetal hemoglobin (RECALL)
Rightward shift: Decreased affinity for oxygen
(More willing to give up oxygen)
Decreased ph (RECALL)
Increased pCO2
Increased H+
Increased Temperature
Increased 2-3DPG
16. A 30 years old male was brought into the ED following a
fall from a height. His examination reveals bilateral
weakness in both arm power of 3/5 and his lower limb
power is 4/5, he also has variable sensory impairment
What is the most likely diagnosis?
-Spinal cord injuries spinal
tracts and their normal
function
Spinal cord syndrome
Anterior cord syndrome
(Recall)

## Question 16 of 90

- **A.** Brown Sequard Syndrome
- **B.** Posterior Cord Syndrome
- **C.** Complete Cord Transection
- **D.** Anterior Cord Syndrome
- **E.** Central Cord Syndrome

## Question 50 of 58

20. Which of the following NSAIDs has the least
gastrointestinal side effects?
NSAIDS-induced GI side effects:
Lowest risk=ibuprofen
Highest risk=piroxicam, ketorolac
NSAIDs cause GERD by inhibiting the COX 1
enzymes (cox 1 stimulation produce prostaglandins
that help to maintain the gastric mucosal integrity)
NSAIDs can cause ulcers by interfering with the
stomach''s ability to protect itself from gastric acid
(by inhibiting the function of prostaglandins)
RECALL
NSAID causes hemolytic anemia=Mefenamic acid
(RECALL).

## Question 20 of 90

- **A.** Indomethacin
- **B.** Naproxen
- **C.** Piroxicam
- **D.** Diclofenac
- **E.** Ibuprofen
26. You are teaching group of medical students'' venous
drainage of lower limb, Regarding the course of great
saphenous vein, which one of the following is correct?
The great saphenous vein: originate from medial
side of the dorsal venous arch in the foot, passes

## Question 26 of 90

- **A.** Begins as the upward continuation of the lateral
marginal vein of the foot
- **B.** Travels with saphenous nerve along its course
- **C.** Runs behind the medial malleolus
- **D.** Join the femoral vein above the inguinal
ligament
- **E.** Enters the femoral vein on its anteromedial side

## Question 51 of 58

anterior to the medial malleolus (not posterior),
travels up the medial side of leg, knee and thigh to
pass in to saphenous opening in deep fascia
covering the femoral triangle and join with the
femoral vein below the inguinal ligament.
The small saphenous vein: originate from lateral
side of dorsal venous arch in the foot, passes
posterior to lateral malleolus and up the back of leg
to pierce the deep fascia and join the popliteal vein
in popliteal fossa posterior to knee...
Note: Cutaneous innervation to medial side of foot
by=saphenous nerve (Recall).
35. A 20-year-old man fell from the parallel bar during the
Olympic trial. A neurologic ex- amination reveals that he
has a lesion of the lateral cord of the brachial plexus.
Which of the following muscles is most likely weakened by
this injury?
The pectoralis major is innervated by the lateral and
medial pectoral nerves originating from the lateral
and medial cords of the brachial plexus,
respectively. The subscapularis, teres major,
latissimus dorsi, and teres minor muscles are
innervated by nerves originating from the posterior
cord of the brachial plexus
High yield:
BRANCHES OF LATERAL CORD   "LML"
Lateral pectoral nerve
Musculocutaneous nerve
Lateral root of median nerve
BRANCHES OF MEDIAL CORD     "M4U"
Medial pectoral nerve
Medial cutaneous nerve of arm
Medial cutaneous nerve of forearm
Medial root of median nerve
Ulnar nerve
BRANCHES OF POSTERIOR CORD   "ULTRA"
Upper subscapular nerve
Lower subscapular nerve

## Question 35 of 90

- **A.** Teres major
- **B.** Latissimus dorsi
- **C.** Teres minor
- **D.** Subscapularis
- **E.** Pectoralis major

## Question 52 of 58

40. An 8-year-old child brought into the ED with a complaint
of severe vomiting. ABGs revealed metabolic alkalosis.
Metabolic alkalosis occurs after vomiting due to?
Metabolic alkalosis: Occurs due to loss of H+ in GI
tract i.e., vomiting, pyloric stenosis or in kidney
(diuretic therapy)
Metabolic alkalosis is associated with
hypoventilation and hypokalemia (Recall).

## Question 40 of 90

- **A.** Increased pco2
- **B.** Decrease HC03
- **C.** Increase H+
- **D.** Decreased pco2
- **E.** Decrease H+
45. What is the main mechanism of action of diltiazem?
Diltiazem and verapamil are non-dipyridamole
calcium channel blocker
FDA-approved Indications of diltiazem
Atrial arrhythmia, including atrial fibrillation with
the rapid ventricular rate (RVR)
Hypertension
Paroxysmal supraventricular tachycardia
Chronic stable angina
Angina Due to Coronary Artery Spasm( Prinzmetal''s
angina)
Dihydropyridine calcium channel blockers include
amlodipine, felodipine and nifedipine

## Question 45 of 90

- **A.** Close the K+ channels
- **B.** Opens the Ca+ channels
- **C.** Opens the Na+channel
- **D.** Blocks the Na+ channel
- **E.** Blocks Ca+ channels
53. During a routine physical examination, you perform
auscultation of the heart to listen to the sounds produced

## Question 53 of 90

## Question 53 of 58

by the valves. What is the area of auscultation of aortic
valve?
High yield:
Areas of auscultation of heart. Remember on
fingertips.
- **A.** Right 5th intercostal space
- **B.** Left 5th intercostal space
- **C.** Second left intercostal space
- **D.** Apex of heart
- **E.** Second right intercostal space
61. Regarding central respiratory chemoreceptors, which of
the following statement is correct?
Central chemoreceptors are sensitive to the PH of
CSF, decrease in the pH of the CSF produce
increase in breathing rate(hyperventilation). H+
doesn''t Cross the blood brain barrier as well as co2
does. co2 diffuse from arterial blood into the CSF
because co2 is lipid soluble and readily cross blood
brain barrier. in the CSF, co2 combines with ho2 to
produce H+ and HCO3-. the resulting H+ act directly
on the central chemoreceptors, thus increase in
pco2 and H+ stimulate the breathing and decrease
in pco2 and H+ inhibit the breathing. this resulting
hyperventilation or hypoventilation then returns
the arterial Pco2 toward normal.
Central chemoreceptors are located near the
ventrolateral surface of the medulla.

## Question 61 of 90

- **A.** Located in dorsal surface of medulla
- **B.** Located in the medulla near exit of cranial nerve
X,XI
- **C.** Respond directly to changes in arterial PCO2
- **D.** Respond directly to changes in external PCO2
- **E.** Respond to pH of CSF

## Question 54 of 58

Peripheral chemoreceptors are located in carotid
and aortic body. The carotid bodies are located at
the bifurcation of common carotid arteries, the
aortic bodies are located above and below the aortic
arch.
Decrease in arterial po2: stimulate the peripheral
chemoreceptor and increase breathing rate. po2
must decrease to low levels (<60mmHg) before
breathing is stimulated. when po2 is less than
60mmHg, breathing rate is exquisitely sensitive to
po2.
increase in arterial Pco2: stimulate the peripheral
chemoreceptors and increase breathing rate
increase in arterial H+: stimulate the carotid body
peripheral chemoreceptors directly, independent of
Changes in pco2.
In metabolic acidosis, breathing rate is increased
(hyperventilation) because arterial H+ is increased
and pH is decreased.
64. At which of the following site maximal absorption of
vitamin B12 occur?
Maximal water reabsorption occurs in Jejunum
(Recall)
Maximal Iron absorption occurs in duodenum
(Recall)
Maximal calcium absorption occurs in duodenum
(Recall)
Maximal vit B12 absorption occurs in terminal ileum
Note: Sub acute cord syndrome: Due to vitamin B12
deficiency also known as subacute combined
degeneration of spinal cord (Recall) there is
mainly degeneration pf posterior and lateral cord
Drugs causing Vit B12 Deficiency: Ethanol,
chloramphenicol, H2 receptor blockers, PPI
(Omeprazole) Recall

## Question 64 of 90

- **A.** Jejunum
- **B.** Proximal ileum
- **C.** Stomach
- **D.** Duodenum
- **E.** Terminal ileum
68. 27 years old male presents to the ED with complain of
dysphagia. Which of the following nerve is responsible for
contracting the esophageal phase of swallowing?

## Question 68 of 90

## Question 55 of 58

Pharyngeal phase of swallowing: glossopharyngeal
nerve and vagus nerve
Esophageal phase of swallowing: Vagus nerve
- **A.** Hypoglossal nerve
- **B.** Facial nerve
- **C.** Auriculotemporal nerve
- **D.** Glossopharyngeal nerve
- **E.** Vagus nerve
70. Regarding the validity of a study, which of the following
is correct statement?
Selection bias is a form of systematic error.
Random error is always present in a measurement.
They are caused by unpredictable fluctuations in
the readings of a measurement apparatus or in the
experimenters'' interpretation of the instrumental
reading
Random error will reduce with increasing sample
size. (Recall)
Randomisation will reduce confounding.
A confounding factor is a background variable that
is not of direct interest to the study.

## Question 70 of 90

- **A.** Randomization will increase confounding
- **B.** Selection bias is a form of random error
- **C.** A confounding factor is a variable that is of
direct interest to the study
- **D.** Random error increases with increasing sample
size
- **E.** Random error is always present in a
measurement
77. During examination of cardiovascular system you are
discussing heart sounds and cardiac cycle. which of the
following stage of cardiac cycle occurs immediately after
the aortic valve closes?

## Question 77 of 90

- **A.** Ventricular filling
- **B.** Atrial systole
- **C.** Isovolumetric contraction

## Question 56 of 58

Isovolumetric Relaxation
When the aortic and pulmonary valves close, the
heart relaxes isovolumetrically because both the
outflow valves and inflow valves are closed, and so
no fluid moves across them. This phase lasts until
the intraventricular pressure falls below the
pressure in the atria, at which time the mitral and
tricuspid valves open again. The isovolumetric
relaxation lasts about 0.08 S. The volume
throughout this phase is the end systolic volume,
approximately 50 ml. The atrioventricular (AV)
valves open at an atrial pressure of about 7 mmHg.
Isovolumetric relaxation:
lasts about 0.08 seconds
Aortic and pulmonary valves closed
Mitral and tricuspid valves closed.
- **D.** Ventricular ejection
- **E.** Isovolumetric relaxation
79. A 62-year-old patient with pericardial effusion comes to
a local hospital for aspiration of pericardial fluid by
pericardiocentesis. The needle is inserted into the
pericardial cavity through which of the following intercostal
spaces adjacent to the sternum?
Pericardiocentesis is a procedure performed to
remove pericardial fluid from the pericardial sac
that surrounds the myocardium
The needle insertion site is 1-2 cm lateral to the apex
beat within the fifth intercostal space. Advance the
needle over the superior border of the rib to avoid
intercostal nerves and vessels.
High yield:
Sites for Abdominal Paracentesis:
Midline Approach =2 cm below Umbilicus in midline
Lateral Approach = 3 to 5 cm Superior and Medial to
Anterior Superior Iliac Spine.
Needle Thoracocentesis in Pneumothorax =2nd
Intercostal Space Midclavicular line. (RECALL)

## Question 79 of 90

- **A.** Left fourth intercostal space
- **B.** Right fifth intercostal space
- **C.** Right fourth intercostal space
- **D.** Right sixth intercostal space
- **E.** Left fifth intercostal space

## Question 57 of 58

0% Complete
Mark as Complete
Previous Next
Chest Tube Intubation, Pleural tap = Midaxillary Line
5th Intercostal Space.
81.
17 years old female presented to the ED with complaint of
fever since 3 days lethargy, stiff neck and non-blanching
skin rash that appears on the lower limb.
What is the most likely diagnosis?

## Question 81 of 90

- **A.** HSP
- **B.** Rheumatic fever
- **C.** Endocarditis
- **D.** Autoimmune TTP
- **E.** Meningococcal Septicemia

## Question 58 of 58',
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

  RAISE NOTICE 'Successfully seeded MRCEM SBA with 47 lessons across 5 modules.';
END $$;