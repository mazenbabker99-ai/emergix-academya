-- ==========================================================================
-- COURSE SEED: MRCEM Primary: Pathology & Clinical Microbiology
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

  -- 2. Upsert Course: mrcem-pathology-micro
  SELECT id INTO v_course_id FROM "courses" WHERE "slug" = 'mrcem-pathology-micro' LIMIT 1;
  IF v_course_id IS NULL THEN
    INSERT INTO "courses" (
      "id", "exam_id", "slug", "title", "summary", "description", "is_free", "position", "status", "created_at", "updated_at"
    ) VALUES (
      gen_random_uuid(),
      v_exam_id,
      'mrcem-pathology-micro',
      'MRCEM Primary: Pathology & Clinical Microbiology',
      'High-frequency pathology and microbiology covering bacterial classification, antibiotic resistance, cellular injury, and inflammation.',
      'Master microbial pathogens, diagnostic methods, antibiotic coverage, immune hypersensitivity reactions, cellular injury, and systemic pathology tested in MRCEM Primary.',
      false,
      5,
      'published',
      now(),
      now()
    ) RETURNING "id" INTO v_course_id;
  ELSE
    UPDATE "courses" SET
      "title" = 'MRCEM Primary: Pathology & Clinical Microbiology',
      "exam_id" = COALESCE(v_exam_id, "exam_id"),
      "summary" = 'High-frequency pathology and microbiology covering bacterial classification, antibiotic resistance, cellular injury, and inflammation.',
      "description" = 'Master microbial pathogens, diagnostic methods, antibiotic coverage, immune hypersensitivity reactions, cellular injury, and systemic pathology tested in MRCEM Primary.',
      "position" = 5,
      "status" = 'published',
      "deleted_at" = NULL,
      "updated_at" = now()
    WHERE "id" = v_course_id;
  END IF;

  -- ==========================================================================
  -- Module 1: General Pathology, Inflammation & Anemia (11 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'General Pathology, Inflammation & Anemia' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'General Pathology, Inflammation & Anemia', 0, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 0, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Anemia (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'anemia',
    'Anemia',
    'article',
    'Anemia
Anemia: Reduction in Hb concentration below the normal
range
Range: Men= Hct < 41% or HB less than 13.5 g/dl
Women: Hct< 36% or HB less than 11.5g/dl
Anemia is classified on the basis of MCV, (Normal 80-100)
Microcytic anemia: MCV< 80%, Macrocytic anemia MCV>
100%
Microcytic anemia:
Macrocytic anemia:
Megaloblastic anemia (Vit. B12 and folate deficiency
Alcoholic liver disease
Hypothyroidism
Myelodysplastic syndrome

![Anemia - Clinical Figure 1](/lessons/images/general-pathology-inflammation-anemia/anemia/figure_01_p1.png)
*Anemia — Clinical Figure 1 (Page 1 Reference)*

Laboratory Features
Megaloblastic anaemia is characterized by:
Macrocytic anaemia with oval macrocytes and hyper
segmented neutrophils
Moderate reduction in leucocyte and platelet counts
Raised serum bilirubin (indirect) and lactate dehydrogenase
(LDH) (due to haemolysis of defective red cells)
Low B12 +/- folate
Hypercellular bone marrow, megaloblastic erythropoiesis and
giant metamyelocytes

![Anemia - Clinical Figure 2](/lessons/images/general-pathology-inflammation-anemia/anemia/figure_02_p2.png)
*Anemia — Clinical Figure 2 (Page 2 Reference)*',
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

  -- Lesson: Antibodies and Hypersensitivity Reactions (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'antibodies-and-hypersensitivity-reactions',
    'Antibodies and Hypersensitivity Reactions',
    'article',
    'Antibodies:
Hypersensitivity reaction:

![Antibodies and Hypersensitivity Reactions - Clinical Figure 1](/lessons/images/general-pathology-inflammation-anemia/antibodies-and-hypersensitivity-reactions/figure_01_p2.png)
*Antibodies and Hypersensitivity Reactions — Clinical Figure 1 (Page 2 Reference)*

![Antibodies and Hypersensitivity Reactions - Clinical Figure 2](/lessons/images/general-pathology-inflammation-anemia/antibodies-and-hypersensitivity-reactions/figure_02_p2.png)
*Antibodies and Hypersensitivity Reactions — Clinical Figure 2 (Page 2 Reference)*',
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

  -- Lesson: Blood Groups (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'blood-groups',
    'Blood Groups',
    'article',
    'Blood group
The ABO blood group phenotypes are O (genotype OO), A
(genotype AA or AO), B (genotype BB or BO) and AB (genotype

## Ab).

Blood group O is the most common in the UK (46 %), followed
by group A (42 %), group B (9 %) and finally group AB (3 %).
Blood group O has no antigens, but both anti-A and anti-B
antibodies and thus is the universal donor.
Blood group AB has both A and B antigens but no antibodies
and thus is the universal recipient.
Blood group A has A antigens and anti-B antibodies, and
blood group B has B antigens and anti-A antibodies.

![Blood Groups - Clinical Figure 1](/lessons/images/general-pathology-inflammation-anemia/blood-groups/figure_01_p1.png)
*Blood Groups — Clinical Figure 1 (Page 1 Reference)*

## Rh-D

The Rh D gene may be either absent or present, giving the RhD
negative or RhD positive phenotype respectively. About 85% of
the UK population is Rh D positive. Anti-D antibodies don''t
occur naturally and are therefore immune antibodies that
result from previous transfusions or pregnancy.
Rhesus Disease:  A condition that occurs during pregnancy if
a woman has Rh-ve blood and her baby has Rh+ve blood.
Mother''s body create Rh antibodies against the baby''s blood
also known as hemolytic disease of newborn
.
Pathogenesis: Rh-ve mother carrying Rh+ve fetus⟶  Entry of
fetus Rh+ve Rbc into maternal circulation⟶  Development of
Rh antibodies by the mother
Prevention and Prophylaxis
anti-D immunoglobulin to all Rh-negative women at 28 and 34
weeks routinely
Or give anti-D immunoglobulin if she has a:
Therapeutic abortion.
Spontaneous abortion/ectopic pregnancy.
Amniocentesis.
Any bleeding in pregnancy/threatened miscarriage.

![Blood Groups - Clinical Figure 2](/lessons/images/general-pathology-inflammation-anemia/blood-groups/figure_02_p2.png)
*Blood Groups — Clinical Figure 2 (Page 2 Reference)*

After delivery at any gestation within 72Hours.',
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

  -- Lesson: Cell Death (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cell-death',
    'Cell Death',
    'article',
    'Cell death

![Cell Death - Clinical Figure 1](/lessons/images/general-pathology-inflammation-anemia/cell-death/figure_01_p1.png)
*Cell Death — Clinical Figure 1 (Page 1 Reference)*',
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

  -- Lesson: Complement Cascade (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'complement-cascade',
    'Complement Cascade',
    'article',
    'Complement cascade:
Collection of twenty proteins many of which are enzyme
precursors. constituting an amplification enzyme system which
is capable of lysis of bacteria or blood cells or opsonization of
bacteria or cells for phagocytosis.
Activation of complement system: Enzyme precursors of
complement system are normally inactive. They can be
activated in two ways classic and alternate pathway.

### 1: Classic pathway: Activated by antigen antibody reaction

When antibody binds with its specific antigen, "specific
reaction site" on constant portion of antibody becomes
uncovered or activated; this bind with complement factor Cl,
giving rise to a cascade of reaction
Multiple reaction products (C3a, C3b, C4a Q C5b6789) are
formed which cause following effects that prevent damage by
invading organisms and toxins (0-PLAN-CIA)
(1) Opsonization (C3b)
(2) Phagocytosis (C3b)
(3) Lysis (C5b6789)
(4) Agglutination
(5) Neutralization
(6) Chemotaxis (C5a)
(7) Inflammatory effects
(8) Activation of mast cells & basophils (C3a, C4a and C5a)
Note: C3 deficiency leads to increased susceptibility of infection
with encapsulated organisms (e.g., S. pneumoniae, H.

influenzae).
C5 - C9 deficiency results in increased susceptibility to
Neisseria infections.

### 2: Alternate pathway: is activated without intermediation of

antibody-antigen reaction. When complement factors B & D
react with some polysaccharide in cell membrane of invading
organism, it activates complement factor C3, giving rise to
same cascade of reactions beyond C3 level. Same reaction
products are formed which cause same effects as in classical
pathway.
Note Since alternate pathway does not involve antigen-
antibody reaction, it is one of first lines of defense against
invading organisms.
Regulation
The complement pathway is regulated by complement
inhibitors e.g., decay accelerating factor or C1 inhibitor.
Deficiency in C1 inhibitor results in hereditary angioedema.
Deficiency in complement decay-accelerating factor results in
paroxysmal nocturnal hemoglobinuria.',
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

  -- Lesson: Inflammation (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'inflammation',
    'Inflammation',
    'article',
    'Inflammation
Note: Chronic nonspecific inflammation: Nonspecific
inflammatory cell infiltration seen in chronic osteomyelitis, lung
abscess
Chronic specific inflammation: Formation of granuloma e.g., in
T.B, Leprosy, syphilis and sarcoidosis
Note: TNF-Alpha and IL-1 are key cytokines in acute
inflammation
Neutrophils and macrophages produce IL-1 which act on the
hypothalamus and induce fever in inflammation.
Blood changes in inflammation include Increased ESR,
Leukocytosis and increased CRP.
Inflammation inducing substances:
Histamine
Serotonin
Bradykinin
Prostaglandin
Interleukin functions:

> [!NOTE]
> **Mnemonic: Fever Tablet Means Effective Antipyretics Action**
IL-1: Fever
IL-2: T cell stimulator
IL-3: Marrow stimulator

![Inflammation - Clinical Figure 1](/lessons/images/general-pathology-inflammation-anemia/inflammation/figure_01_p1.png)
*Inflammation — Clinical Figure 1 (Page 1 Reference)*

IL-4: IgE stimulator
IL-5: Class switching to IgA
IL-6: Stimulates Acute Phase Protein Production',
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

  -- Lesson: Innate Vs Acquired Immunity (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'innate-vs-acquired-immunity',
    'Innate Vs Acquired Immunity',
    'article',
    'Innate vs Acquired immunity.
Immune responses: Capacity of the body to resist pathogenic
agents.

![Innate Vs Acquired Immunity - Clinical Figure 1](/lessons/images/general-pathology-inflammation-anemia/innate-vs-acquired-immunity/figure_01_p1.png)
*Innate Vs Acquired Immunity — Clinical Figure 1 (Page 1 Reference)*',
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

  -- Lesson: Lymphocytes (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'lymphocytes',
    'Lymphocytes',
    'article',
    'Types of lymphocytes

![Lymphocytes - Clinical Figure 1](/lessons/images/general-pathology-inflammation-anemia/lymphocytes/figure_01_p1.png)
*Lymphocytes — Clinical Figure 1 (Page 1 Reference)*',
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

  -- Lesson: Plasma Autoantibodies (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'plasma-autoantibodies',
    'Plasma Autoantibodies',
    'article',
    'Plasma autoantibodies

![Plasma Autoantibodies - Clinical Figure 1](/lessons/images/general-pathology-inflammation-anemia/plasma-autoantibodies/figure_01_p1.png)
*Plasma Autoantibodies — Clinical Figure 1 (Page 1 Reference)*',
    false,
    8,
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

  -- Lesson: Sickle Cell Disease (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'sickle-cell-disease',
    'Sickle Cell Disease',
    'article',
    'Sickle cell disease:
Autosomal recessive disorder
Type of normocytic anemia with high reticulocyte count
Clinical features:
Vaso-occlusive crisis: Most common crisis
Sickling causes blockage of small vessels
Common precipitants are infection, dehydration, acidosis and
deoxygenation
Abdominal pain is caused by infarction affecting abdominal
organs
Bone pain may occur in the back, pelvis, ribs and long bones
Infarction may affect the central nervous system, lungs,
spleen or kidneys
Hand-foot syndrome in children caused by infarction of
metaphyses of small bones is frequently the first
presentation of the disease
Acute sickle chest syndrome is the most common cause of
death in adults and children (dyspnoea, falling arterial PO2,
chest pain, pulmonary infiltrates on CXR)
Visceral sequestration crisis : Sickling with pooling of red
cells in the liver, spleen or lungs
Aplastic crisis :Usually following infection with B19
parvovirus
Temporary arrest of erythropoiesis, rapidly causing severe
anaemia requiring transfusion
Increased susceptibility to infection
Splenic function is reduced because infarction leads to
hyposplenism
Pneumococcal infections may lead to pneumonia and
meningitis.
Infarction of intestinal mucosa predisposes to Salmonella
infection and osteomyelitis.
Lab values:
CBC= Normocytic anemia with raised reticulocyte count

Peripheral film: Sickle cells, Howell- jolly bodies
Diagnosis: HB Electrophoresis most accurate test',
    false,
    9,
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

  -- Lesson: Wound Healing (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'wound-healing',
    'Wound Healing',
    'article',
    'Wound healing
Healing is the process of replacing dead and damaging tissue
with healthy tissue; this may occur through regeneration or
repair.
The regenerative capacity of cells can be categorized in three
main ways:
Labile cells are constantly dividing and have a good capacity
for regeneration, this allows the replacement of ageing tissue
such as the surface epithelia of the skin, gastrointestinal tract
and uterus; blood cells are derived from labile cells of the
bone marrow.
Stable cells slowly replicate e.g., cells of liver, renal tubular
epithelium, endocrine glands.
Permanent tissues: incapable of division and cannot be
regenerated e.g., brain cells, myocardial cells, skeletal muscle
cells.
Healing by primary intention:
Healing of a clean, uninfected surgical incision approximated
by surgical sutures.
Day-1: Neutrophilic infiltration + fibrin clot
Day-2: Epithelial cells from both edges have begun to
migrate and proliferate along the dermis, yielding a thin but
continuous epithelial layer.
Day-3: Macrophages replace neutrophils Appearance of
granulation tissue. Type III collagen deposition begins but do
not bridge the incision.
Day 5: Abundant granulation tissue Collagen fibrils bridge the
incision.
Neovascularization is maximum.
Week-2: Dense scar tissue produced from granulation tissue
contains type III collagen (weak collagen) that must be
remodeled. Remodeling increases the tensile strength of scar
tissue.

1 month: Replacement of collagen type III with collagen type I
(has greater tensile strength) due to action of collagenase
enzyme.
The predominant collagen in adult skin is type I, whereas in
early granulation tissue, it is type III.
Healing by secondary intention
Occurs in large wounds abscess formation and ulceration.
Main features:
A larger clot or scab
Inflammation: more intense Granulation tissue: much larger
amount
Scar tissue: greater mass
Wound contraction: by myofibroblast e.g. Within 6 weeks,
large skin defects may be reduced to 5% to 10% of their
original size, largely by contraction.
Healing by tertiary intention
Contaminated wound is initially treated with debridement
and antibiotics followed by surgical wound closure (suture,
skin graft replacement, flap)
Note: Regarding the neat surgical scar after 2 months of
surgery fibroblasts have predominant role
Most important for delayed wound healing is due
to infection.
Factors affecting wound healing:
Local factors affecting wound healing
Mechanical injury / Frequent trauma
Infection
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
Failure to unite (skin, muscle or fascia wound breakdown)
Fracture complications
Stages of bone/fracture healing:
Hematoma formation (Immediately in Day 1)
Inflammation and proliferation (8 hours to 1-2 weeks)
predominant cells neutrophils and macrophages
Callus formation (2-3 weeks)
Consolidation (2 to 3 months)
Re-modelling (2 months to years) Osteoclasts are
responsible.
Factors that prevent efficient healing:
Malnutrition
Infection
Corticosteroids therapy
Poor blood supply',
    false,
    10,
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
  -- Module 2: Clinical Microbiology, Bacteria & Antibiotics (22 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Clinical Microbiology, Bacteria & Antibiotics' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Clinical Microbiology, Bacteria & Antibiotics', 1, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 1, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Clostridium Spp - Bacteria (3 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'clostridium-spp-bacteria',
    'Clostridium Spp - Bacteria',
    'article',
    'Clostridium Species
All the Clostridium species are Gram +Ve spore forming
obligate anaerobes.
Tetanus prone wound:
Clean wounds are defined as:
wounds less than 6 hours old, non-penetrating with negligible
tissue damage
Tetanus-prone wounds include:
puncture-type injuries acquired in a contaminated
environment and likely therefore to contain tetanus spores
e.g. gardening injuries
compound fractures
wounds or burns with systemic sepsis.
certain animal bites and scratches
High risk tetanus-prone wound:
heavy contamination with material likely to contain tetanus
spores e.g. soil, manure
wounds or burns that show extensive devitalised tissue.
wounds or burns that require surgical intervention that is
delayed for more than six hours are high risk even if the
contamination was not initially heavy
Tetanus immunization schedule:

![Clostridium Spp - Bacteria - Clinical Figure 1](/lessons/images/clinical-microbiology-bacteria-antibiotics/clostridium-spp-bacteria/figure_01_p1.png)
*Clostridium Spp - Bacteria — Clinical Figure 1 (Page 1 Reference)*

More easy to remeber:

![Clostridium Spp - Bacteria - Clinical Figure 2](/lessons/images/clinical-microbiology-bacteria-antibiotics/clostridium-spp-bacteria/figure_02_p2.png)
*Clostridium Spp - Bacteria — Clinical Figure 2 (Page 2 Reference)*

![Clostridium Spp - Bacteria - Clinical Figure 3](/lessons/images/clinical-microbiology-bacteria-antibiotics/clostridium-spp-bacteria/figure_03_p2.png)
*Clostridium Spp - Bacteria — Clinical Figure 3 (Page 2 Reference)*',
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

  -- Lesson: Culture Medium for Bacterial Growth (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'culture-medium-for-bacterial-growth',
    'Culture Medium for Bacterial Growth',
    'article',
    'Culture Medium For Bacterial
Growth

![Culture Medium for Bacterial Growth - Clinical Figure 1](/lessons/images/clinical-microbiology-bacteria-antibiotics/culture-medium-for-bacterial-growth/figure_01_p1.png)
*Culture Medium for Bacterial Growth — Clinical Figure 1 (Page 1 Reference)*',
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

  -- Lesson: Escherichia Coli, Klebsiella, Salmonella - Bacteria (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'escherichia-coli-klebsiella-salmonella-bacteria',
    'Escherichia Coli, Klebsiella, Salmonella - Bacteria',
    'article',
    'Escherichia Coli:
Note: E. coli serotype O157 causes bloody diarrhoea associated
with hemolytic uremic syndrome in children, characterized by
hemolytic anemia, thrombocytopenia and acute renal failure.
Klebsiella spp:
Salmonella enterica
is a gram-negative rod that causes enterocolitis (Food
poisoning), Enteric fever (Typhoid), Septicemia, and
osteomyelitis
Primarily transmitted through fecal-oral route usually from
ingestion of contaminated poultry, eggs, and uncooked
meat
Treatment:

![Escherichia Coli, Klebsiella, Salmonella - Bacteria - Clinical Figure 1](/lessons/images/clinical-microbiology-bacteria-antibiotics/escherichia-coli-klebsiella-salmonella-bacteria/figure_01_p1.png)
*Escherichia Coli, Klebsiella, Salmonella - Bacteria — Clinical Figure 1 (Page 1 Reference)*

![Escherichia Coli, Klebsiella, Salmonella - Bacteria - Clinical Figure 2](/lessons/images/clinical-microbiology-bacteria-antibiotics/escherichia-coli-klebsiella-salmonella-bacteria/figure_02_p1.png)
*Escherichia Coli, Klebsiella, Salmonella - Bacteria — Clinical Figure 2 (Page 1 Reference)*

Salmonella enterocolitis: Usually supportive management in
resistant cases ciprofloxacin
Enteric fever: First line ciprofloxacin if organism sensitive, and
in resistant cases cefotaxime or azithromycin

> [!TIP]
> **High yield:**
> Regarding osteomyelitis
> Most common cause generally: Staph Aureus (Recall)
> The most common cause in IV drug abuser: Staph Aureus
> The most common cause in sickle cell disease: Salmonella
> Most common cause after hip replacement surgery: Staph
> epidermidis',
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

  -- Lesson: Gastrointestinal Virus (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'gastrointestinal-virus',
    'Gastrointestinal Virus',
    'article',
    'Gastrointestinal Virus:

![Gastrointestinal Virus - Clinical Figure 1](/lessons/images/clinical-microbiology-bacteria-antibiotics/gastrointestinal-virus/figure_01_p1.png)
*Gastrointestinal Virus — Clinical Figure 1 (Page 1 Reference)*',
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

  -- Lesson: Hellicobacter Pylori and Compylobacter Jejuni - Bacteria (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'hellicobacter-pylori-and-compylobacter-jejuni-bacteria',
    'Hellicobacter Pylori and Compylobacter Jejuni - Bacteria',
    'article',
    'Helicobacter Pylori
Campylobacter Jejuni
Note:
Reactive arthritis (Reiter''s syndrome) is a triad of urethritis,
arthritis and conjunctivitis.
Organisms causing reactive arthritis: Chlamydia,
Salmonella, Campylobacter jejuni and Shigella

![Hellicobacter Pylori and Compylobacter Jejuni - Bacteria - Clinical Figure 1](/lessons/images/clinical-microbiology-bacteria-antibiotics/hellicobacter-pylori-and-compylobacter-jejuni-bacteria/figure_01_p1.png)
*Hellicobacter Pylori and Compylobacter Jejuni - Bacteria — Clinical Figure 1 (Page 1 Reference)*

![Hellicobacter Pylori and Compylobacter Jejuni - Bacteria - Clinical Figure 2](/lessons/images/clinical-microbiology-bacteria-antibiotics/hellicobacter-pylori-and-compylobacter-jejuni-bacteria/figure_02_p1.png)
*Hellicobacter Pylori and Compylobacter Jejuni - Bacteria — Clinical Figure 2 (Page 1 Reference)*',
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

  -- Lesson: Hepatitis - Virus (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'hepatitis-virus',
    'Hepatitis - Virus',
    'article',
    'Hepatitis:
Note: Emergency hepatitis B vaccination
If you have been exposed to the hepatitis B virus and have
not been vaccinated before, you should get immediate
medical advice, as you may benefit from having the hepatitis
B vaccine.
In some situations, you may also need to have an injection of
antibodies, called specific hepatitis B immunoglobulin
(HBIG), along with the hepatitis B vaccine. HBIG should
ideally be given within 48 hours post exposure Hepatitis B
vaccine in three doses over three months.
Hepatitis-D:
Co-infection with HBV results in fulminant hepatitis
Superinfection with HBV results in fulminant hepatitis or
chronic hepatitis commonly
Hepatitis-E:
Transmitted via fecal oral route causes acute fulminant
hepatitis in pregnant woman.
No progression to chronic hepatitis

![Hepatitis - Virus - Clinical Figure 1](/lessons/images/clinical-microbiology-bacteria-antibiotics/hepatitis-virus/figure_01_p2.png)
*Hepatitis - Virus — Clinical Figure 1 (Page 2 Reference)*',
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

  -- Lesson: Herpes Simplex and Varicella Zooster Virus (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'herpes-simplex-and-varicella-zooster-virus',
    'Herpes Simplex and Varicella Zooster Virus',
    'article',
    'Herpes Virus:
Varicella zoster Key Points
The incubation period is 10 - 21 days (Recall) (mean time is
14 days).
Primary infection typically occurs in 4-10 years children.
Diagnosis is usually clinical.

![Herpes Simplex and Varicella Zooster Virus - Clinical Figure 1](/lessons/images/clinical-microbiology-bacteria-antibiotics/herpes-simplex-and-varicella-zooster-virus/figure_01_p1.png)
*Herpes Simplex and Varicella Zooster Virus — Clinical Figure 1 (Page 1 Reference)*

![Herpes Simplex and Varicella Zooster Virus - Clinical Figure 2](/lessons/images/clinical-microbiology-bacteria-antibiotics/herpes-simplex-and-varicella-zooster-virus/figure_02_p1.png)
*Herpes Simplex and Varicella Zooster Virus — Clinical Figure 2 (Page 1 Reference)*

After primary infection virus lies dormant in posterior root
ganglion and reactivates in 20% of patients causing shingles
School exclusion period: when all lesions are crusted over
(Recall
Chickenpox in pregnancy:
Chickenpox in pregnancy is managed by two different
methods - one is used before the onset of symptoms and the
other after the onset of rash. One is varicella-zoster immune
globulin (VZIG), which strengthens the immune system for a
short time. If you are not immune to chickenpox you can be
treated with VZIG, usually by injection, up to ten days after
you come into contact with chickenpox. It is used before any
symptoms appear; it does not work afterwards. The other is
Acyclovir, which may reduce fever and symptoms if it is
started within 24 hours of the rash developing and continue
for 7 days

> [!TIP]
> **Key points:**
> If you have already had chickenpox, you have nothing to
> worry about.

Once you have had chickenpox you cannot catch it a second
time, this is known as being immune.
Nine out of ten UK adults are immune to chickenpox.
Chickenpox is very rare in pregnant women in the UK.
It affects very few babies in the womb and although it can
be very serious in pregnancy especially in 1st trimester in
first 12 weeks (Recall)
If you have been in contact with chickenpox and are not sure
if you are immune, contact your GP or midwife and do not
attend the antenatal clinic.
If you have chickenpox, avoid contact with other pregnant
women and new babies until at least five days after the rash
appears, or until all the blisters have crusted over.',
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

  -- Lesson: Human Immune Virus (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'human-immune-virus',
    'Human Immune Virus',
    'article',
    'Human Immune virus (HIV)
High-risk source for HIV
MSM (men who have sex with men)
Female sexual contacts of MSM
People reporting current or prior injecting drug use
Sex workers
Trans women
People from a country with high diagnosed seroprevalence
(>1%) * i-e Originally from sub-Saharan Africa.
People reporting sexual contact with anyone from a country
with high diagnosed seroprevalence regardless of where
contact occurs
Note - Anal course is incorrect unless, in the option they
mentioned unprotected anal course with sub-Saharan
people/ high risk source.
Types of Exposure
Non-occupational exposure
Consider patient at potential risk for HIV acquisition if:
The source has HIV and is not receiving antiretroviral therapy
(ART), is at high risk for HIV infection, or is from a group with
high prevalence of detectable HIV viraemia, AND
There has been exposure of vagina, rectum, mouth, or non-
intact skin with blood, semen (Splash exposure to mucous
membranes, most commonly the eye), vaginal secretions,
rectal secretions, breast milk, or anybody fluid that visibly
contains blood.
Occupational exposure
A percutaneous injury (e.g., a needlestick or cut with a sharp
object). Deep injury, visible blood, or injury with a device
that has been used intravascularly, all increase the risk of
HIV transmission.

Contact of mucous membrane or non-intact skin (e.g.,
exposed skin that is chapped, abraded, or afflicted with
dermatitis). If the skin remains intact, there is no risk of HIV
transmission.
A bite if the skin is broken as a result of trauma.
Note - Exposure with urine, nasal secretions, saliva, sweat, or
tears without the presence of blood is considered negligible
risk for acquisition of HIV.
Pathogenesis:
HIV mainly infects CD4+ T helper cells. Viral replication
results in progressive T-cell depletion and impaired cell-
mediated immunity with subsequent secondary
opportunistic infections
HIV-related opportunistic infection:
Note: You must remember CD4 count of important
opportunistic pathogens like Tuberculosis, Pneumocystis
jiroveci pneumonia, Pneumonia, Mycobacterium avium
complex and toxoplasmosis Gondi

Diagnosis: Combined HIV antibody and p24 antigen test
Monitoring: HIV viral load (PCR) and CD4+ count

![Human Immune Virus - Clinical Figure 1](/lessons/images/clinical-microbiology-bacteria-antibiotics/human-immune-virus/figure_01_p3.png)
*Human Immune Virus — Clinical Figure 1 (Page 3 Reference)*',
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

  -- Lesson: Measles, Mumps, Rubella - Virus (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'measles-mumps-rubella-virus',
    'Measles, Mumps, Rubella - Virus',
    'article',
    'Measles:
Acute viral illness transmitted by respiratory droplets
characterized by 3C Cough, coryza, conjunctivitis and fever.
Measles rash: Maculopapular rash appearing first behind the
ears and spreading to whole body.
Incubation period: 9-12 days
Infectious period: Patients are considered infectious for 3
days before the rash emerges and four days from onset of
the rash.
Patients are advised to stay away from school.
Treatment: Supportive
Complications: Pneumonia, bronchitis, otitis media,
encephalitis, subacute sclerosing panencephalitis
Mumps:
Rubella:
Acute viral illness transmitted by respiratory droplets
characterized by fever, malaise, arthralgia and sore throat
Rubella rash: Maculopapular rash appearing first on the face
and spreading downward associated with lymphadenopathy.
Incubation period: 14-21 days
Infectious period: Patients are considered infectious for 4
days from onset of the rash and seven days before the rash

![Measles, Mumps, Rubella - Virus - Clinical Figure 1](/lessons/images/clinical-microbiology-bacteria-antibiotics/measles-mumps-rubella-virus/figure_01_p1.png)
*Measles, Mumps, Rubella - Virus — Clinical Figure 1 (Page 1 Reference)*

appears.
Patients are advised to stay away from school in infectious
period.
Treatment:  Supportive
Complications: Arthritis, Thrombocytopenic purpura,
Encephalitis and congenital rubella syndrome
Rubella in pregnancy: Is very serious if a woman is infected
in the first trimester it can have serious consequences for
the baby''s health for example congenital abnormalities such
as heart defects, cataracts, intrauterine growth restriction,
central nervous system defects and deafness.',
    false,
    8,
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

  -- Lesson: Mycobacterium Tuberculosis - Bacteria (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'mycobacterium-tuberculosis-bacteria',
    'Mycobacterium Tuberculosis - Bacteria',
    'article',
    'Mycobacterium Tuberculosis
Acid fast bacilli Causes tuberculosis transmitted via respiratory
aerosol and characterized by chronic granulomatous
inflammation.
Clinical Features:
Fever, Night sweats and weight loss
Persistent cough for more than 3 weeks
Hemoptysis
Hilar lymphadenopathy
Pathophysiology:
The Ghon focus is a primary lesion caused by tuberculosis that
develops in the lung of previously unaffected individuals. It
represents a calcified caseating granuloma. It typically
appears in the middle-third of the lung (the lower part of the
upper lobe or upper part of the lower lobe).
Diagnosis:
sputum samples Microscopy with Z-N (Ziehl-Nelsen stain)
shows acid fast bacilli.
In the case of active pulmonary TB, a patient can have
crepitations, and bronchial breath sounds, and specially over
upper lobes x-ray cavitations or consolidations.
The Mantoux test is a widely used test for latent TB: It
involves injecting a small amount of a substance called PPD
tuberculin into the skin of your forearm. It''s also called the
tuberculin skin test (TST).',
    false,
    9,
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

  -- Lesson: Neisseria Spp - Bacteria (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'neisseria-spp-bacteria',
    'Neisseria Spp - Bacteria',
    'article',
    'Neisseria species
Neisseria Gonorrhea and Neisseria meningitis
General features:
Neisseria meningitis:
Neisseria meningitis is gram negative encapsulated
diplococci causing Neisseria meningitis and meningococcal
sepsis transmitted via respiratory droplet
Neisseria meningitidis is the most common cause of
bacterial meningitis.
Clinical features
include headache, nausea, vomiting, photophobia, lethargy,
rash, multiple organ failure, shock, and disseminated
intravascular coagulation.
Diagnosis is clinical, confirmed by blood culture and CSF
aspirate.
Bacterial meningitis typically reveals cloud turbid
appearance of CSF, Neutrophil predominant, High protein
and low glucose (<40mg/dl)
The most important to remember here:

![Neisseria Spp - Bacteria - Clinical Figure 1](/lessons/images/clinical-microbiology-bacteria-antibiotics/neisseria-spp-bacteria/figure_01_p1.png)
*Neisseria Spp - Bacteria — Clinical Figure 1 (Page 1 Reference)*

Treatment:
If meningococcal disease is suspected out of hospital,
patients should receive a single dose of parenteral (IM or IV)
benzylpenicillin as soon as possible or initial blind therapy in
hospital
In Hospital when diagnosis is made Ceftriaxone antibiotic of
choice

![Neisseria Spp - Bacteria - Clinical Figure 2](/lessons/images/clinical-microbiology-bacteria-antibiotics/neisseria-spp-bacteria/figure_02_p2.png)
*Neisseria Spp - Bacteria — Clinical Figure 2 (Page 2 Reference)*',
    false,
    10,
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

  -- Lesson: Notifiable Disease (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'notifiable-disease',
    'Notifiable Disease',
    'article',
    'Diseases notifiable to local authority
proper officers under the Health
Protection (Notification) Regulations
2010:
Acute encephalitis
Acute infectious hepatitis
Acute meningitis
Acute poliomyelitis
Anthrax
Botulism
Brucellosis
Cholera

## Covid-19

Diphtheria
Enteric fever (typhoid or paratyphoid fever)
Food poisoning
Haemolytic uremic syndrome (HUS)
Infectious bloody diarrhea
Invasive group A streptococcal disease
Legionnaires'' disease
Leprosy
Malaria
Measles
Meningococcal septicaemia
Monkeypox
Mumps
Plague
Rabies
Rubella
Severe Acute Respiratory Syndrome (SARS)
Scarlet fever
Smallpox
Tetanus
Tuberculosis

Typhus
Viral hemorrhagic fever (VHF)
Whooping cough
Yellow fever',
    false,
    11,
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

  -- Lesson: Pathogens - Fungi (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'pathogens-fungi',
    'Pathogens - Fungi',
    'article',
    'Fungi:
Candida: Form part of the normal flora which includes skin, GI
tract, and female genital tract
Candidiasis and treatment

![Pathogens - Fungi - Clinical Figure 1](/lessons/images/clinical-microbiology-bacteria-antibiotics/pathogens-fungi/figure_01_p1.png)
*Pathogens - Fungi — Clinical Figure 1 (Page 1 Reference)*',
    false,
    12,
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

  -- Lesson: Pathogens - Protozoa (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'pathogens-protozoa',
    'Pathogens - Protozoa',
    'article',
    'Malaria
Caused by protozoan plasmodium.
There are four different Plasmodium species relevant in
humans:
Plasmodium falciparum
Plasmodium vivax
Plasmodium ovale
Plasmodium malariae
Plasmodium falciparum is the deadliest malaria parasite and
the most prevalent on the African continent. P. vivax is the
dominant malaria parasite in most countries outside of sub-
Saharan Africa.
Diagnosis: The Giemsa stain (Thick and thin film) is used as
the gold standard for the diagnosis of malaria on blood smears
Treatment: Non-Falciparum malaria: Chloroquine drug of
choice
Falciparum malaria: Quinine or Artemether with
lumefantrine
Note: vivax and P.ovale have dormant liver stages
("hypnozoites") that can activate and cause relapse of fever and
malaria. Primaquine is drug of choice to kill liver hypnozoites.
Antimalarial drug In Pregnancy:
Quinine is the antimalarial drug of choice in pregnancy;
however, chloroquine should be considered in non-
falciparum malaria while those areas where chloroquine is
resistant especially southern Vietnam Quinine is best given in
pregnancy.',
    false,
    13,
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

  -- Lesson: Pathogens - Worms (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'pathogens-worms',
    'Pathogens - Worms',
    'article',
    'Thread worm
is the most common helminth in the UK, commonly infect
children.
Mebendazole is the drug of choice, and you must treat
everyone in your home even if they do not have symptoms.
Tapeworm
Pork tapeworm and beef tapeworm transmitted via eating
contaminated undercooked meat.
Pork tapeworm (Taenia solium): Infection occurs through
ingestion of food or water contaminated with eggs of solium
Cysticercosis:  infection caused by larval cysts of the
tapeworm Taenia solium, infect brain, muscle, skin and eye
Diagnosis: Direct visualization of characteristic eggs in
stool
Treatment: Nicolsamide
Round worm
Causes: Ascaris lumbricoides
Diagnosis: Direct visualization of characteristic eggs in
stool
Treatment: Mebendazole
Hook worm
Intestinal parasite causes gastrointestinal symptoms and iron
deficiency anemia.
Diagnosis: Direct visualization of characteristic eggs in
stool
Treatment: Mebendazole',
    false,
    14,
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

  -- Lesson: Principles of Investigation (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'principles-of-investigation',
    'Principles of Investigation',
    'article',
    'Principles of Investigations

![Principles of Investigation - Clinical Figure 1](/lessons/images/clinical-microbiology-bacteria-antibiotics/principles-of-investigation/figure_01_p1.png)
*Principles of Investigation — Clinical Figure 1 (Page 1 Reference)*',
    false,
    15,
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

  -- Lesson: Principles of Microbiology (4 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'principles-of-microbiology',
    'Principles of Microbiology',
    'article',
    'Microbiology Principles:

> [!TIP]
> **High yield:**
> Normal bacterial flora: The microorganisms that grow in or on
> the body without producing harmful effects on the host also
> compete with other pathogens for colonisation sites
> Antibiotics suppress normal flora which allows for
> colonisation and infection by opportunistic pathogens such
> as Candida albicans or Clostridium difficile.

Also act as barrier to infection
Note: Skin as barrier to infection but certain organism can
penetrate intact skin e.g., Leptospira and Treponema
If skin integrity is broken e.g., by intravenous cannulation,
blood-borne viruses such as hepatitis B and HIV can be
transmitted.
Pathogen and Types:

![Principles of Microbiology - Clinical Figure 1](/lessons/images/clinical-microbiology-bacteria-antibiotics/principles-of-microbiology/figure_01_p1.png)
*Principles of Microbiology — Clinical Figure 1 (Page 1 Reference)*

Control of infection/ Hospital-acquired infection
Disinfection: Process that inactivates many diseases
producing microbes on inanimate objects with exception
of bacterial spores
Sterlisation; Inactivation of all infectious agents and is mainly
achieved via autoclaving machine
Common Disinfectants:
Iodine is a slow-acting skin anti-bacterial disinfectant.
Chlorhexidine is an anti-staphylococcal agent.
Alcohol gel is not effective against C. difficile spores, so the
use of soap and water is essential.
Microorganism & Mechanism of Attachment
Neisseria gonorrhoeae, E-Coli=Adheres to the genital mucosa
using fimbriae
Influenza Attaches =by its haemagglutinin antigen
Giardia lamblia=Attaches to gut mucosa via a specialized
sucking disc
Mechanism of immune evasion

![Principles of Microbiology - Clinical Figure 2](/lessons/images/clinical-microbiology-bacteria-antibiotics/principles-of-microbiology/figure_02_p2.png)
*Principles of Microbiology — Clinical Figure 2 (Page 2 Reference)*

![Principles of Microbiology - Clinical Figure 3](/lessons/images/clinical-microbiology-bacteria-antibiotics/principles-of-microbiology/figure_03_p2.png)
*Principles of Microbiology — Clinical Figure 3 (Page 2 Reference)*

Spread of infection:
Food supply (issues of hygiene standards, temperature of
food, transport to ward
Legionella pneumophila spread via poorly maintained air-
conditioning cooling towers
Salmonella enterica spread via ingested poultry.
Air supply (via theatre air supply and air conditioning
systems)
Fomites (any inanimate object that may act as a vehicle for
transmission e.g., MRSA on a stethoscope, Pseudomonas spp.
on vases)
water supply: Legionella pneumophila may colonise the
system in redundant areas of lukewarm pipework and be
transmitted to air conditioning system
Route of transmission of microorganisms

![Principles of Microbiology - Clinical Figure 4](/lessons/images/clinical-microbiology-bacteria-antibiotics/principles-of-microbiology/figure_04_p3.png)
*Principles of Microbiology — Clinical Figure 4 (Page 3 Reference)*',
    false,
    16,
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

  -- Lesson: Pseudomonas Aeruginosa, Legionella Pneumophilia and Bortonella Henslae - Bacteria (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'pseudomonas-aeruginosa-legionella-pneumophilia-and-bortonella-henslae-bacteria',
    'Pseudomonas Aeruginosa, Legionella Pneumophilia and Bortonella Henslae - Bacteria',
    'article',
    'Pseudomonas Aeruginosa
Gram-negative rod transmitted via direct/indirect contact
likely in the hospital environment.
Legionella Pneumophilia
Gram-negative coccobacilli are transmitted via respiratory
aerosol.
Legionnaires disease
Diagnosis: Legionella antigen detection in urine
Treatment: Quinolones like levofloxacin or macrolides like
clarithromycin
Bartonella Henselae
Gram negative bacilli or coccobacilli
Cat-scratch disease (CSD) or felinosis is an infectious disease
caused by Bartonella henselae most often results from a
scratch or bite of a cat.

/2026, 10:54 PSEUDOMONAS AERUGINOSA, LEGIONELLA PNEUMOPHILIA AND BORTONELLA HENSLAE-BACTERIA | MRCEM EX…

![Pseudomonas Aeruginosa, Legionella Pneumophilia and Bortonella Henslae - Bacteria - Clinical Figure 1](/lessons/images/clinical-microbiology-bacteria-antibiotics/pseudomonas-aeruginosa-legionella-pneumophilia-and-bortonella-henslae-bacteria/figure_01_p1.png)
*Pseudomonas Aeruginosa, Legionella Pneumophilia and Bortonella Henslae - Bacteria — Clinical Figure 1 (Page 1 Reference)*

/2026, 10:54 PSEUDOMONAS AERUGINOSA, LEGIONELLA PNEUMOPHILIA AND BORTONELLA HENSLAE-BACTERIA | MRCEM EX…

/2026, 10:54 PSEUDOMONAS AERUGINOSA, LEGIONELLA PNEUMOPHILIA AND BORTONELLA HENSLAE-BACTERIA | MRCEM EX…',
    false,
    17,
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

  -- Lesson: Respiratory Viruses (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'respiratory-viruses',
    'Respiratory Viruses',
    'article',
    'Croup:
Croup (laryngotracheobronchitis) is a common respiratory
disease that typically occurs in children aged between 6
months and 3 years.
Causes
Parainfluenza virus types 1 or 3
Diagnosis: Clinical
Clinical features
Sudden onset of a seal-like barking cough, which associated
with:
Hoarseness
Stridor
Respiratory distress.
Fever
Symptoms are typically worse at night and increase with
agitation.
Treatment: Usually supportive in severe cases Dexamethasone
oral IV and nebulized adrenaline
Bronchiolitis:
It is a condition which predominately affects children aged
less than 2 years, with a peak incidence between the ages of
three and six months.
It is caused by viral infections, most commonly respiratory
syncytial virus (RSV)
Clinical features
Suspect bronchiolitis in infants who have experienced a
coryzal prodrome lasting 1-3 days, followed by persistent
cough and:
Either tachypnoea or chest recession (or both) and
Either wheeze or crackles on chest auscultation (or both).
Other common symptoms include:
Fever (usually of less than 39°C).

Poor feeding (typically after 3 to 5 days of illness).
Apnoea without other clinical signs in young infants (in
particular those under 6 weeks of age).
Diagnosis: Usually clinical
Treatment: Supportive
Admit the baby or child if he has the following features:
Apnoea (observed or reported)
persistent oxygen saturation (when breathing air) of less than
90%, for children aged 6 weeks and over or less than 92%, for
babies under 6 weeks or children of any age with underlying
health conditions
inadequate oral fluid intake (50% to 75% of usual volume,
taking account of risk factors and using clinical judgement
Persisting severe respiratory distress, for example grunting,
marked chest recession, or a respiratory rate of over 70
breaths/minute.
Rhino Virus:
Causes Common Cold transmitted via respiratory droplets.
Incubation period usually 24-72 hours
Diagnosis: Clinical
Treatment: Supportive
Influenza Virus:
Causes seasonal epidemics fever, cough, headache and
runny nose
Incubation period usually 24-96 hours
Diagnosis: Clinical
Treatment: Supportive
Important regarding influenza
vaccine:
Recommended annually for certain patients including:
people over 65 years old
healthcare professionals
pregnant women
people with chronic disease e.g., cystic fibrosis, renal disease,
heart disease, asthma
immunocompromised individuals e.g., asplenism, HIV/AIDs
and patients on chemotherapy

Whooping cough:
Whooping cough, also known as pertussis, is a highly
infectious disease caused by the bacterium Bordetella
pertussis.
Bordetella pertussis is gram-negative Cocco-bacilli
transmitted via respiratory droplet.
In young infants, the ''whoop'' may be absent and coughing
spasms may be followed by periods of apnoea and/or
cyanosis.
A protracted cough following pertussis infection may last for
3 months or more and has been referred to as ''the one-
hundred-day cough''.
Clinical features
Whooping cough has 3 phases of symptoms.
The catarrhal phase (lasts between one and two weeks)
Nasal discharge.
Conjunctivitis.
Malaise.
Sore throat.
Low-grade fever.
Dry, unproductive cough.
Making a clinical diagnosis
Whooping cough should be suspected if a person has an
acute cough that has lasted for 14 days or more without
another apparent cause, and has one or more of the
following features:
Paroxysmal cough.
Inspiratory whoop.
Post-tussive vomiting.
Undiagnosed apnoeic attacks in young infants.
Clinical suspicion should be raised if the person is not fully
immunized or has been in contact with a person who is
confirmed or suspected of having whooping cough.
Investigations
culture of a nasopharyngeal aspirate or swab from the
posterior nasopharynx
Collect cultures from the nasopharynx within 2 weeks of
cough onset.
Definitive test for diagnosis, with a specificity of 100%.
Sensitivity is 30% to 60% if the specimen is obtained <2 weeks after symptoms start.
Nucleic acid amplification test (NAAT) of nasopharyngeal
aspirate or posterior nasopharyngeal swab
NAAT, including polymerase chain reaction (PCR), can be
obtained within 4 weeks of cough onset.
NAAT testing has increased sensitivity compared with culture
(94%) and is recommended as adjunct to culture.
Serology
Order between 2 and 12 weeks after cough onset in patients
who have not received a pertussis-containing vaccine in the
preceding 6 months.
A serum anti-pertussis toxin antibody concentration of >100
IU/mL is suggestive of infection.
Oral fluid testing
Detection of anti-pertussis immunoglobulin G (IgG) in oral
fluid is available in the UK for confirmation of pertussis in
children >2 years of age and adolescents.
FBC: An elevated WBC count and lymphocytosis are
suggestive of pertussis and are common in young children.
Management
Arrange admission if the patient is:
Is 6 months of age or younger and acutely unwell.
Has significant breathing difficulties (for example apnoea
episodes, severe paroxysms, or cyanosis).
Has a significant complication (for example seizures or
pneumonia).
If admission is not needed
prescribe an antibiotic if the onset of cough is within the
previous 21 days.
Clarithromycin for infants< 1 month
Azithromycin or clarithromycin for children aged 1 month or
older, and non-pregnant adults.
Erythromycin for pregnant women.
Note:The recommended exclusion period from nursery or
school is 48 hours after start of antibiotics or 21 days from
start of symptoms',
    false,
    18,
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

  -- Lesson: Sexually Transmitted Bacteria (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'sexually-transmitted-bacteria',
    'Sexually Transmitted Bacteria',
    'article',
    'Sexually Transmitted Bacteria:
Chlamydia Trachomatis:
Obligate intracellular bacterium transmitted vis sexual and
peripartum causing Chlamydia, trachoma, ophthalmia
neonatorum, pneumonia.
Ophthalmia neonatorum: is conjunctivitis occurring within the
first 4 weeks of life.
The most serious cause is infection with Neisseria gonorrhea
in first week most likely in 3-4 days of life, but in the UK, it is
caused more commonly by Chlamydia in first 28 days of life.
Note: Conjunctivitis in first week of life is caused by Neisseria
gonorrhea
Other species of chlamydia causing pneumonia in humans
Chlamydophila pneumophila infect humans causes
pneumonia.
Chlamydophila psittaci infects birds. Humans are infected
primarily by inhaling organisms in dry bird faeces.
Neisseria Gonorrhea:
Gram negative diplococci transmitted via sexual and
peripartum.
General features of Neisseria spp. (Neisseria gonorrhea and
Neisseria meningitis)
Comparison Between Neisseria
Gonorrhea and
Chlamydia trachomatis:

![Sexually Transmitted Bacteria - Clinical Figure 1](/lessons/images/clinical-microbiology-bacteria-antibiotics/sexually-transmitted-bacteria/figure_01_p1.png)
*Sexually Transmitted Bacteria — Clinical Figure 1 (Page 1 Reference)*

![Sexually Transmitted Bacteria - Clinical Figure 2](/lessons/images/clinical-microbiology-bacteria-antibiotics/sexually-transmitted-bacteria/figure_02_p2.png)
*Sexually Transmitted Bacteria — Clinical Figure 2 (Page 2 Reference)*',
    false,
    19,
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

  -- Lesson: Streptococcus and Staphylococcus Bactera (4 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'streptococcus-and-staphylococcus-bactera',
    'Streptococcus and Staphylococcus Bactera',
    'article',
    'Streptococcus spp
Common features:
Streptococcus Spp
(Beta hemolytic group A) Is gram +Ve Cocci in chains
Causes acute sore throat in children, skin and soft tissue
infection and necrotizing fasciitis.
Erysipelas: Superficial skin infection involving upper dermis
and superficial lymphatics caused by Group A beta hemolytic
streptococcus pyogenes
Post-infectious immune-mediated reactions of
Streptococcus Pyogenes include Rheumatic fever, erythema
nodosum, acute glomerulonephritis.
Staphylococcus Epidermidis:
Gram positive cocci is an important pathogen involving
prosthetic implants, intravascular lines, ventriculoperitoneal
shunts and cardiac valves.
Staphylococcus epidermidis is part of the normal flora of the
skin and nasopharynx, and infection is usually endogenous.
Streptococcus Viridans

![Streptococcus and Staphylococcus Bactera - Clinical Figure 1](/lessons/images/clinical-microbiology-bacteria-antibiotics/streptococcus-and-staphylococcus-bactera/figure_01_p1.png)
*Streptococcus and Staphylococcus Bactera — Clinical Figure 1 (Page 1 Reference)*

![Streptococcus and Staphylococcus Bactera - Clinical Figure 2](/lessons/images/clinical-microbiology-bacteria-antibiotics/streptococcus-and-staphylococcus-bactera/figure_02_p1.png)
*Streptococcus and Staphylococcus Bactera — Clinical Figure 2 (Page 1 Reference)*

Streptococcus Pneumoniae:
Gram positive Alpha hemolytic encapsulated diplococci
transmitted via respiratory droplets causing pneumonia,
Meningitis, sinusitis and otitis media
Community acquired pneumonia:
Investigation
Blood tests- FBC, CRP U&E
CXR
A definitive diagnosis of CAP requires evidence of
consolidation on chest x-ray.
Pulse oximetry ABGs
Blood & Sputum culture (± Gram stain) - ideally before
antibiotics are given, in all patients with moderate- or high-
severity CAP (as determined by the CURB-65 score) presenting
in hospital.
Severity assessment and management (NICE & BTS
guideline)

![Streptococcus and Staphylococcus Bactera - Clinical Figure 3](/lessons/images/clinical-microbiology-bacteria-antibiotics/streptococcus-and-staphylococcus-bactera/figure_03_p2.png)
*Streptococcus and Staphylococcus Bactera — Clinical Figure 3 (Page 2 Reference)*

Choice of antibiotics
Staphylococcus aureus:
Staphylococcus aureus is a catalase-positive, coagulase-
positive, beta-haemolytic, Gram-positive coccus found in
clusters.
Transmission:
Endogenous spread: Staphylococcus aureus is normal gut
flora of skin and nasopharynx. Endogenous spread causes
infection in immunocompromised individuals
Exogenous spread: via direct skin contact or indirect contact
by clothing or other fomites
Disease: Primary skin infection (e.g., impetigo, abscess and
cellulitis)

![Streptococcus and Staphylococcus Bactera - Clinical Figure 4](/lessons/images/clinical-microbiology-bacteria-antibiotics/streptococcus-and-staphylococcus-bactera/figure_04_p3.png)
*Streptococcus and Staphylococcus Bactera — Clinical Figure 4 (Page 3 Reference)*

Secondary skin infections (e.g., in eczema, surgical wounds,
intravenous devices)
Pneumonia
Infective Endocarditis (most common cause of acute IE in IV
drug users
Osteomyelitis
Septic arthritis
Septic Arthritis:
is an infection of any kind that finds its way into joint space, it
is a most rapid and destructive joint disease, acute onset of
monoarticular arthritis with pain swelling, and warmth, the
knee is the most common site others include the hip, wrist,
shoulder, and ankle.
The most common type of bacteria that causes septic
arthritis is called staphylococcus aureus. others include
streptococcus, gram-negative rods,
Neisseria Gonorrhea causes septic arthritis in sexually
active young adults.
Treatment: Flucloxacillin: Antibiotic of choice
Vancomycin is used to treat methicillin Resistant Staph
Aureus',
    false,
    20,
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

  -- Lesson: Uk - Immunization Schedule (3 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'uk-immunization-schedule',
    'Uk - Immunization Schedule',
    'article',
    'UK Immunization Schedule:
The routine immunization schedule
from February 2022
Note: Trade name is not necessary to remember.

![Uk - Immunization Schedule - Clinical Figure 1](/lessons/images/clinical-microbiology-bacteria-antibiotics/uk-immunization-schedule/figure_01_p1.png)
*Uk - Immunization Schedule — Clinical Figure 1 (Page 1 Reference)*

Selective immunisation programmes
Additional vaccines for individuals
with underlying medical conditions

![Uk - Immunization Schedule - Clinical Figure 2](/lessons/images/clinical-microbiology-bacteria-antibiotics/uk-immunization-schedule/figure_02_p2.png)
*Uk - Immunization Schedule — Clinical Figure 2 (Page 2 Reference)*

![Uk - Immunization Schedule - Clinical Figure 3](/lessons/images/clinical-microbiology-bacteria-antibiotics/uk-immunization-schedule/figure_03_p2.png)
*Uk - Immunization Schedule — Clinical Figure 3 (Page 2 Reference)*',
    false,
    21,
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

  RAISE NOTICE 'Successfully seeded MRCEM Primary: Pathology & Clinical Microbiology (33 lessons, 43 images)';
END $$;
