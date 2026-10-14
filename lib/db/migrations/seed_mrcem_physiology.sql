-- ==========================================================================
-- SEED SCRIPT: MRCEM Primary: Applied Emergency Physiology
-- Auto-generated for Emergix Academy
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

  -- 2. Upsert Course: mrcem-physiology
  SELECT id INTO v_course_id FROM "courses" WHERE "slug" = 'mrcem-physiology' LIMIT 1;
  IF v_course_id IS NULL THEN
    INSERT INTO "courses" (
      "id", "exam_id", "slug", "title", "summary", "description", "is_free", "position", "status", "created_at", "updated_at"
    ) VALUES (
      gen_random_uuid(),
      v_exam_id,
      'mrcem-physiology',
      'MRCEM Primary: Applied Emergency Physiology',
      'In-depth physiological principles from cell membrane dynamics to cardiovascular, respiratory, and acid-base disorders.',
      'Clinical and applied emergency physiology covering cellular transport, cardiac cycle, respiratory mechanics, gas exchange, renal autoregulation, endocrinology, and hematology tailored for MRCEM Primary.',
      false,
      2,
      'published',
      now(),
      now()
    ) RETURNING "id" INTO v_course_id;
  ELSE
    UPDATE "courses" SET
      "title" = 'MRCEM Primary: Applied Emergency Physiology',
      "exam_id" = COALESCE(v_exam_id, "exam_id"),
      "summary" = 'In-depth physiological principles from cell membrane dynamics to cardiovascular, respiratory, and acid-base disorders.',
      "description" = 'Clinical and applied emergency physiology covering cellular transport, cardiac cycle, respiratory mechanics, gas exchange, renal autoregulation, endocrinology, and hematology tailored for MRCEM Primary.',
      "position" = 2,
      "status" = 'published',
      "updated_at" = now()
    WHERE "id" = v_course_id;
  END IF;

  -- ==========================================
  -- Module 1: Cell Physiology & Membrane Transport
  -- ==========================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Cell Physiology & Membrane Transport' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Cell Physiology & Membrane Transport', 0, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 0, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Action Potential
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'action-potential',
    'Action Potential',
    'article',
    '# Action Potential

Generation of Action potential
Once triggered an action potential will travel over the entire
surface of an excitable cell and will always have the same
amplitude. An action potential is an all or nothing response;
because the size of the action potential is constant, the
intensity of the stimulus is coded by the frequency of firing of
a neuron.
Threshold Potential
Action potentials are initiated in nerves by activation of
ligand-gated Na+ channels by neurotransmitters. Opening of
these Na+ channels results in a small influx of sodium and
depolarization of the negative resting membrane potential
(-70 mV).
If the stimulus is sufficiently strong, the resting membrane
depolarises enough to reach threshold potential (generally
around -55 mV), at which point an action potential can
occur.
Depolarisation
Voltage-gated Na+ channels open, causing further
depolarisation and activating more voltage-gated Na+
channels and there is a sudden and massive sodium influx,
driving the cell membrane potential to about +40 mV.
Repolarisation
The spike of the action potential is transient because as the
membrane potential becomes positive, the voltage-gated
Na+ channels inactivate preventing further sodium influx.
Voltage-gated K+ channels are also activated, causing the K+
permeability to again be much greater than that for Na+, and
the potassium efflux leads to repolarization.
Delayed closure of these rectifier K+ channels cause a
transient hyperpolarization.
Refractory Period

Diet ii Late 2026)
Overview  Comments

1/2
Following the action potential, Na+ channels remain inactive
for a time in a period known as the absolute refractory period
where they cannot be opened by any amount of
depolarization.
Following this there is a relative refractory period where the
temporary hyperpolarization makes the cell more difficult to
depolarise and an action potential can be generated only in
response to a larger than normal stimulus.
The refractory period limits the frequency at which action
potentials can be generated, and ensures that, once initiated,
an action potential can travel only in one direction.
Previous Next

2/2',
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
    "updated_at" = now();

  -- Lesson: Cell Membrane Transport
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cell-membrane-transport',
    'Cell Membrane Transport',
    'article',
    '# Cell Membrane Transport

Cell membrane transport
Cell membrane transport: Occurs through large pores, career
proteins and ion channels.
Fick''s law of diffusion: (Net rate of
diffusion) J=- DA ∆ C/ X
Where:
J = Net rate of diffusion
D = Diffusion coefficient
A = Area
∆ C = Concentration difference
X = thickness of the membrane Negative sign: direction of
diffusion
Factors increasing diffusion:
Decrease size of solute.
Decrease membrane thickness.
Increase oil/ water partition co- efficient.
Active transport

Diet ii Late 2026)
Overview  Comments

1/3
Filtration, osmosis and tonicity:
Note:
Example of hypotonic fluid: Pure water we drink is
hypotonic to body fluids.
Example of Isotonic fluid: NS 0.9% , Ringer''s lactate
Example of hypertonic fluid: 3% Hypertonic saline
Previous Next

2/3
3/3',
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

  -- Lesson: Homeostasis
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'homeostasis',
    'Homeostasis',
    'article',
    '# Homeostasis

Homeostasis
Maintenance of steady states in body by coordinated
physiologic mechanisms.

### 1: Extracellular fluid: Internal environment in body in which the

cells live and the fluid outside the cell
Divisions of ECF
Plasma: Part of ECF present in blood constitute ¼ OF ECF
Interstitial fluid: Part of ECF present in spaces between cells
constitute ¾ of ECF.

### 2: Intracellular fluid: Fluid inside the cells

Average 70 kg adult has approximately 40 liters of water.
Around 2/3 is ICF
Total body water= 0.6 x bodyweight
ECF 0.2X Body weight
ICF 0.4X Body weight
Electrolytes distribution in ECF and
ICF

Diet ii Late 2026)
Overview  Comments

1/2
Operating mechanism for
homeostasis:

### 1: Negative feedback:

Components: Regulated variable, Sensor, Controller, and
Effector.
A regulated variable is sensed, information is fed back to the
controller, and the effector acts to oppose change (hence the
term negative) Control most systems of body."
Examples:  Osmoregulation, regulation of blood, pressure,
temperature regulation, regulation of CO2 in ECF.

### 2: Positive feedback:

Promotes changes in one direction leading amplified effect.
Cause vicious cycle and death, sometimes it can be useful.
Examples:
Childbirth (During labor): The release of oxytocin from the
posterior gland during childbirth and labor
Blood clotting.
Generation of nerve signals.
Sensation of needing to urinate.
Follicular phase of menstrual cycle
Previous Next

2/2',
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

  -- Lesson: Nerve Muscle
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'nerve-muscle',
    'Nerve Muscle',
    'article',
    '# Nerve Muscle

Nerve muscle
Skeletal muscle structure:
The connective tissue surrounding the whole muscle is called
the epimysium. The connective tissue that extends beyond
the body of the muscle eventually blends into a tendon,
which is attached to bone or cartilage. Skeletal muscle is
composed of numerous parallel, elongated, multinucleated
cells called muscle fibers (or myofibers) each enclosed by
endomysium, which are grouped together to form fascicles.
Each fascicle is surrounded by perimysium.
The sarcomere is the functional unit of the muscle.
Each muscle fiber is divided at regular intervals along its
length into sarcomeres separated by Z-lines.
Muscle filaments:
Thick filaments: Present in the A band in the center of the
sarcomere
Contains Myosin (Recall)
Thin filaments: Present in the I band.
Anchored at the Z lines.
Contains actin, tropomyosin and troponin.
There are three types of muscle:
Skeletal
Cardiac
Smooth
Comparison between them:

Diet ii Late 2026)
Overview  Comments

1/2
Previous Next

2/2',
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

  -- Lesson: Neuromuscular Junction
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'neuromuscular-junction',
    'Neuromuscular Junction',
    'article',
    '# Neuromuscular Junction

Neuromuscular junction
Junction between a nerve ending and muscle membrane.
Synapse: Junction between excitable cells that allows
transmission of a signal from first cell to next is called synapse
Acetylcholine is a neurotransmitter synthesized in cytosol of
axon terminal and is stored in small vesicles formed by Golgi
apparatus in cell body of motor neuron of spinal cord, that have
been transported from cell body to axon terminal.
Secretion: Action potential reach axon terminal →  Ca++ enter
cytosol →  Cause Ach vesicle to fuse with membrane →  Ach is
secreted by rupturing of vesicle.
Function: Ach binds with receptor of Ach-gated channels on
muscle membrane and open them to cause tremendous Na+
influx giving rise to muscle action potential.
Destruction: Released Ach is destroyed by acetylcholinesterase
in basal lamina; this prevents re-excitation.
Previous Next

Diet ii Late 2026)
Overview  Comments

1/2

2/2',
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

  -- Lesson: Organisation of Cell
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'organisation-of-cell',
    'Organisation of Cell',
    'article',
    '# Organisation of Cell

Organization of cell
A typical cell is made up of four basic structures, which from
outside to inside are:
Cell membrane
Cytoplasm
Nuclear membrane and nucleus
Cell membrane:
Outer covering of cell that isolate individual cell from its
Neighbours, composed of phospholipid bilayer with embedded
proteins which provide signaling.
The membrane is selectively permeable; lipid-soluble
molecules such as O2 and CO2, and small molecules such as
water and urea can readily pass through the lipid bilayer, but
larger molecules such as glucose, and polar molecules such
as ions cannot, and their transport is mediated by transporter
and ion channel membrane proteins.
Cell membrane consists of thin layer called glycocalyx which
attaches one cell to the adjacent cells.
Cell organelles quick revision:

### 1: Lysosomes contains hydrolases responsible for digestion

and breakdown of defective proteins
Uterus and breast after pregnancy regress by lysosomes

### 2: Mitochondria: Powerhouse responsible for production of

chemical energy in the form of ATP
Unique feature in mitochondria is of own DNA.

### 3: Endoplasmic reticulum:

Rough endoplasmic reticulum most likely synthesizes
proteins.
Detoxification of drug occurs in smooth endoplasmic
reticulum.
The smooth endoplasmic reticulum serves as a store for
intracellular Ca2+ and is the major site of lipid production.

### 4: Golgi body: Secretory vesicles found

Diet ii Late 2026)
Overview  Comments

1/2
The Golgi apparatus packages proteins for delivery to specific
intracellular destinations or into vesicles which can then be
secreted from the cell for extracellular action.

### 5: Nucleus contains genetic material and nucleolus

responsible for ribosomes production.

### 6: Ribosomes: Ribosomes are the cellular structures where

protein synthesis takes place. They can be found in the
cytoplasm (free ribosomes) or attached to the endoplasmic
reticulum (bound ribosomes).
Previous Next

2/2',
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

  -- Lesson: Osmolality and Osmolal Gap
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'osmolality-and-osmolal-gap',
    'Osmolality and Osmolal Gap',
    'article',
    '# Osmolality and Osmolal Gap

Osmolality and osmolal gap
Previous Next

Diet ii Late 2026)
Overview  Comments

1/2

2/2',
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
    "updated_at" = now();

  -- Lesson: Skeletal Muscle Excitation Contraction Coupling
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'skeletal-muscle-excitation-contraction-coupling',
    'Skeletal Muscle Excitation Contraction Coupling',
    'article',
    '# Skeletal Muscle Excitation Contraction Coupling

Skeletal excitation contraction
coupling
Muscle contraction occurs when the concentration of
intracellular Ca2+ rises.
An action potential travels down tube-shaped invaginations
of the sarcolemma called T-tubules which penetrate
throughout the muscle fiber and lie adjacent to the terminal
cisternae of the sarcoplasmic reticulum.
Voltage changes in the T-tubules results in the opening of
sarcoplasmic reticulum Ca2+ channels and the release of
stored Ca2+ into the sarcoplasm.
Molecular Events in Muscle
Contraction and Sliding
filament theory.
Motor neuron axon releases acetylcholine
Acetylcholine diffuses across synaptic cleft.
This stimulates the sarcolemma. The impulse travels over the
muscle fiber surface and down the T-tubules to the
sarcoplasmic reticulum (SR).
Calcium is bound to calsequestrin from SR, Calcium ions
diffuse out of the SR into the sarcoplasm and bind to
troponin.
Tropomyosin moves and exposes sites on actin filaments.
Actin and myosin form linkages.
Actin filaments are pulled inward by myosin cross-bridges
(Sliding filament theory Muscle fibers shorten as contraction
occurs.
Previous Next

Diet ii Late 2026)
Overview  Comments

1/2
2/2',
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
    "updated_at" = now();

  -- Lesson: Teatnus and Rigor Mortis
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'teatnus-and-rigor-mortis',
    'Teatnus and Rigor Mortis',
    'article',
    '# Teatnus and Rigor Mortis

Tetanus and Rigor mortis
Tetanus: During repeated stimulation of a muscle fiber,
Calcium is released from the sarcoplasmic reticulum (SR) more
quickly than it can be reaccumulated; therefore, the
intracellular [Ca2+] does not return to resting levels as it would
after a single twitch. The increased [Ca2+] allows more cross-
bridges to form and, therefore, produces increased tension
(tetanus)
Rigor mortis: The ability of muscles to go in state of
contracture formation after death is called rigor mortis.
This is due to the loss of ATP that is required to separate the
cross bridges from actin during contraction.
It remains until after 15 to 20 hours, when the muse protein
detoriates.
Previous Next

Diet ii Late 2026)
Overview  Comments

1/2

2/2',
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
    "updated_at" = now();

  -- Lesson: Vessel Fluid Dynamics
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'vessel-fluid-dynamics',
    'Vessel Fluid Dynamics',
    'article',
    '# Vessel Fluid Dynamics

Vessel fluid dynamics
Flow rate(Q) = vA (where v is flow velocity and A cross sectional
vector Area
Tube flow:
Flow is directly proportional to radius 4 (r4)
Tubing diameter: An important and frequently cited
relationship is that of the tubing''s radius. Doubling the radius
of a catheter increases the flow rate by 16-fold (r4). The larger
the IV catheter the greater the flow
The larger the flow capacity (cv) the larger the flow
In Coronary circulation if flow capacity(cv) is reduced to 50%
or half flow will be decreased, or radius decreased to half flow
will decrease by 16 times.
Fluids with higher viscosity also have a slower rate of flow.
Plasma has a similar viscosity to water, but blood contains
cells which effectively increase the viscosity by three- to four-
fold. Changes in cell number e.g., polycythemia, therefore,
affect blood flow.
Turbulent vs Laminar Flow
Turbulent blood flow is multidirectional and travels at
different velocities leading to increased resistance and
additional shear stress on the vessel wall.
Laminar flow: Frictional forces at the sides of a vessel cause a
drag force on the fluid touching them, creating a velocity
gradient where the flow is greatest at the centre.
Wall Tention:
Pressure across the wall of a flexible tube (transmural
pressure) tends to extend it and increases wall tension.
This can be described by Laplace''s Law: Pt = (Tw)/r
where,
Pt = Transmural Pressure
T = Wall Tension

Diet ii Late 2026)
Overview  Comments

1/2
w = Wall Thickness
r = Radius
Laplace''s Law also means that a large, dilated heart (e.g., heart
failure) has to develop more wall tension (contractile force) in
order to obtain the same ventricular pressure, making it less
efficient.
Previous Next

2/2',
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
    "updated_at" = now();

  -- ==========================================
  -- Module 2: Cardiovascular Physiology & Hemodynamics
  -- ==========================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Cardiovascular Physiology & Hemodynamics' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Cardiovascular Physiology & Hemodynamics', 1, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 1, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Cardiac Cycle
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cardiac-cycle',
    'Cardiac Cycle',
    'article',
    '# Cardiac Cycle

Heart as pump
The heart is a →  chambered muscular organ that contracts
rhythmically to pump blood into arteries and receive it back
through veins, thereby keeping blood in constant circulation.
Composed of Two separate pumps, right and left, each
consisting of an atrium and a ventricle.
Cardiac Cycle
The events that occur at the beginning of a heartbeat and last
until the beginning of the next heartbeat are called the cardiac
cycle.
Each beat of the heart begins with a spontaneous action
potential that is initiated in the sinus node of the right atrium
near the opening of the superior vena cava.
The action potential travels through both atria and the A-V
node and bundle into the ventricles. A delay of more than
1/10 of a second occurs in the A-V node and bundle, which
allows the atria to contract before the ventricles contract.
Phases of Cardiac Cycle
Two,
Diastole
Period of relaxation or filling is called diastole. Can be divided
into:

### 1. Period of Isovolumic or Isometric Relaxation

During this, ventricles begin to relax (after systole ended),
Intra-ventricular pressure falls aortic and pulmonary valves
close.
But ventricular vol. does not change.

### 2.  Period of Rapid Filling of Ventricles (First 1/3): During this,

atrial pressure becomes greater than    intra-ventricular

Diet ii Late 2026)
Overview  Comments

1/3
pressure (just after systole is over), AV valves (tricuspid and
mitral) open, and blood flows rapidly into respective ventricles.

### 3. Diastasis (Middle 1/3): During this, blood continues to empty

into atria from veins and passes on thru atria directly into
ventricles
4.Atrial Systole (Late 1/3): During this, atria contracts and
pump 20-30% blood into ventricles. Systolic pressure of right
atrium rises to 4-6 mm Hg. and that of left atrium to 7-8 mm
Hg.
Systole:
Period of Contraction can be divided into

### 1. Period of isovolumic or isometric contraction During this,

ventricles begin to contract.
ventricular pressure rise
AV valves are closed.
semilunar (aortic & pulmonary) valves do not open. So, there
is no emptying and no volume change.

### 2. Period of Ejection: During this, left ventricular pressure rises

slightly above 80 mm Hg and right ventricular pressure slightly
above 8 mm Hg. These pressures push aortic and pulmonary
valves open and empty blood into the aorta and pulmonary
trunk. Divided into.
Period of Rapid Ejection: During first 1/3, 70% emptying
occurs.
Period of Slow Ejection During last 2/3, 30% emptying occur.
Relationship of the
Electrocardiogram to the Cardiac
Cycle
The P wave is caused by the spread of depolarization across
the atria, which causes atrial contraction. Atrial pressure
increases just after the P wave.
The QRS waves appear as a result of ventricular
depolarization about 0.16 second after the onset of the P

2/3
wave, and this initiates ventricular contraction; then the
ventricular pressure begins to increase.
The ventricular T wave is caused by repolarization of the
ventricle.
Functions of Heart Valves
AV (tricuspid and mitral valves) prevent backflow of blood
from ventricles to atria during systole.
Semilunar (aortic and pulmonary) valves prevent backflow
of blood from aorta and pulmonary trunk into ventricles
during diastole.
Previous Next

3/3',
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
    "updated_at" = now();

  -- Lesson: Cardiac Excitation Contraction Coupling
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cardiac-excitation-contraction-coupling',
    'Cardiac Excitation Contraction Coupling',
    'article',
    '# Cardiac Excitation Contraction Coupling

Cardiac excitation contraction
coupling:
Calcium entry during action potential is essential for
contraction but it accounts for only 25% of the rise in
intracellular Ca2+. The rest is released from Ca2+ stores in the
sarcoplasmic reticulum (SR).
Calcium enters the cell through voltage-gated L-type calcium
channels.
Calcium activates the ryanodine receptor on the
sarcoplasmic reticulum, which releases more calcium into
the sarcoplasm (Calcium Induced Calcium Release)
Calcium initiates muscle contraction by binding to troponin.
Contraction occurs as it does in skeletal muscle.
Treppe Effect:
More action potentials occur ⟶  More Ca2+ enters the cell
during the AP plateau ⟶  more Ca2+ is stored in the SR ⟶
more Ca2+ is released from the SR and thus more Ca2+ is left
inside the cell and greater tension is produced during
contraction. Increased heart rate increases the force of
contraction.
Relaxation:
In relaxation, about 80% of Ca2+ is rapidly pumped back into
the SR by Ca2+ ATPase pumps.
The Ca2+ that entered the cell during the AP is transported
out of the cell primarily by the Na+/Ca2+ exchanger in the
membrane which pumps one Ca2+ ion out in exchange for
three Na+ ions in, using the Na+ electrochemical gradient as
an energy source.
Previous Next

Diet ii Late 2026)
Overview  Comments

1/2
2/2',
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

  -- Lesson: Cardiac Myocyte
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cardiac-myocyte',
    'Cardiac Myocyte',
    'article',
    '# Cardiac Myocyte

Cardiac myocyte
Cardiac myocyte and comparison with other
cells
Previous Next

Diet ii Late 2026)
Overview  Comments

1/2

2/2',
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

  -- Lesson: Components of the Vasculature
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'components-of-the-vasculature',
    'Components of the Vasculature',
    'article',
    '# Components of the Vasculature

Components of the vasculature

### 1: Arteries:

deliver oxygenated blood to the tissues. are thick walled, with
extensive elastic tissue and smooth muscle.
are under high pressure. The blood volume contained in the
arteries is called the stressed volume.

### 2. Arterioles:

Are the smallest branches of the arteries.
Are the site of highest resistance in the cardiovascular
system. have a smooth muscle wall that is extensively
innervated by autonomic nerve fibers.
The greater the change in resistance at any point in the
vasculature, the greater the loss of pressure at that point.
Arterioles have the most increase in resistance and cause
the largest decrease in blood pressure.
Arteriolar resistance is regulated by the autonomic nervous
system (ANS).
Alpha-1Adrenergic receptors are found on the arterioles of
the skin, splanchnic, and renal circulations.
Beta-2 Adrenergic receptors are found on arterioles of
skeletal muscle.

### 3. Capillaries:

Have the largest total cross-sectional and surface area.
Consist of a single layer of endothelial cells surrounded by
basal lamina.
Are thin walled.
Are the site of exchange of nutrients, water, and gases.
Capillary permeability:
Capillaries throughout the body vary in their permeability
based on the size of their pores. There are three basic types:
Continuous capillaries, found in the skin, lungs, muscles and
CNS, are the most selective with low permeability, as

Diet ii Late 2026)
Overview  Comments

1/3
junctions between the endothelial cells are very tight,
restricting the flow of molecules with MW > 10,000.
Fenestrated capillaries, found in renal glomeruli, endocrine
glands and intestinal villi, are more permeable with less tight
junctions, and the endothelial cells are also punctured by
pores which allow large amounts of fluids or metabolites to
pass.
Discontinuous capillaries, found in the reticuloendothelial
system (bone marrow, liver and spleen), have large gaps
between endothelial cells and are permeable to red blood
cells.

### 4:  Venules

are formed from merged capillaries.

### 5: Veins:

progressively merge to form larger veins. The largest vein, the
vena cava, returns blood to the heart.
Are thin walled.
are under low pressure.
contain the highest proportion of blood in the cardiovascular
system. The blood volume contained in the veins is called the
unstressed volume.
Have alpha 1 adrenergic receptors.
Pressure profile in blood vessels:
As blood flows through the systemic circulation, pressure
decreases progressively because of the resistance to blood
flow.
Thus, pressure is highest in the aorta and large arteries and
lowest in the venae cavae. The largest decrease in pressure
occurs across the arterioles because they are the site of
highest resistance.
Mean pressures in the systemic circulation are as follows:
Aorta, 100 mm Hg
Arterioles, 50 mm Hg
Capillaries, 20 mm Hg
Vena cava, 4 mm Hg

2/3
Previous Next

3/3',
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

  -- Lesson: Conducting System of Heart
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'conducting-system-of-heart',
    'Conducting System of Heart',
    'article',
    '# Conducting System of Heart

Conducting system of heart
Special system of heart that generates rhythmical impulses
and conducts these impulses through heart, is called excitatory
and conductive system of heart. Consists of:
SA node
Internodal pathway
AV node (slowest conducting fiber)
AV bundle (bundle of His)
Right and Left branches of Purkinje
Conductive Pathway of Heart:
SA node initiates the cardiac muscle (pacemaker) →  Internodal
fibers and AV node (delay impulse from the atria to ventricle)
→  AV bundle branches →  Purkinje fibers (from apex to
ventricles).
The sinoatrial node (SAN) is the primary pacemaker located
in Right atrium. The SAN will normally discharge at a rate of
60-100 bpm. If the impulse generated in the Sa node is
blocked, a group of cells further down the heart will become
its pacemaker.
The atrioventricular node (AVN) is the secondary pacemaker
located between right atrium and ventricle near the atrial
septum, and will normally discharge at about 40-60 beats
per minute
Purkinje fibers produce spontaneous action potential at rate
of 20-40 bpm.
Note: AV nodal abnormality is responsible for prolonged PR
interval (1st degree heart block)
Previous Next

Diet ii Late 2026)
Overview  Comments

1/2
2/2',
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

  -- Lesson: Electrocardiography (ecg)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'electrocardiography-ecg',
    'Electrocardiography (ecg)',
    'article',
    '# Electrocardiography (ecg)

ECG
12 Conventional ECG leads record the difference in potential.
Six extremity limb leads and six chest pericardial leads.
Six Extremity leads: Three bipolar leads (I, II, III) and three
unipolar leads aVR, aVL, aVF
Six chest leads:
V1:4TH intercostal space, just to right the sternum
V2:4TH intercostals space, just to left of the sternum.
V3: Midway between V2 and V4
V4: Midclavicular line, fifth intercostal space
V5: Anterior axillary line, same level as V4
V5: Midaxillary line, same level as V4 and V5
The three limb electrodes, I, II and III form a triangle
(Einthoven''s Triangle), at the right arm (RA), left arm (LA) and
left leg (LL).
Previous Next

Diet ii Late 2026)
Overview  Comments

1/2

2/2',
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

  -- Lesson: Harmonal Control of Blood Flow
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'harmonal-control-of-blood-flow',
    'Harmonal Control of Blood Flow',
    'article',
    '# Harmonal Control of Blood Flow

Hormonal Control of Blood Flow
Histamine: causes arteriolar dilation and venous constriction.
The combined effects of arteriolar dilation and venous
constriction cause increased capillary hydrostatic pressure and
increased filtration out of the capillaries resulting in local
edema and is released in response to tissue trauma.
Bradykinin: causes arteriolar dilation and venous constriction.
produces increased filtration out of the capillaries (similar to
histamine) and causes local edema.
Serotonin (5-hydroxytryptamine): causes arteriolar
constriction and is released in response to blood vessel
damage.
Help prevent blood loss. has been implicated in the vascular
spasms of migraine headaches.
Prostaglandins: Prostacyclin is a vasodilator in several vascular
beds.
E-series prostaglandins are vasodilators.
F- Series prostaglandins are vasoconstrictors.
Thromboxane A2 is a vasoconstrictor.
Coronary circulation: is controlled almost entirely by local
metabolic factors.
Exhibits autoregulation. exhibits active and reactive
hyperemia.
The most important local metabolic factors are hypoxia and
adenosine.
For example, increases in myocardial contractility are
accompanied by an increased demand for O2. To meet this
demand, compensatory vasodilation of coronary vessels
occurs and, accordingly, both blood flow and O2 delivery to
the contracting heart muscle increase (active hyperemia).

Diet ii Late 2026)
Overview  Comments

1/3
During systole, mechanical compression of the coronary
vessels reduces blood flow. After        the period of occlusion,
blood flow increases to repay the O2 debt (reactive
hyperemia).
Cerebral Circulation:
Cerebral circulation is controlled almost entirely by local
metabolic factors.
exhibits autoregulation. exhibits active and reactive
hyperemia.
The most important local vasodilator for the cerebral
circulation is CO2 Increases in PCO2 cause vasodilation of the
cerebral arterioles and increased blood flow to the brain.
Decreases in PC02 cause vasoconstriction of cerebral
arterioles and decreased blood flow to the brain,
Skeletal muscle: is controlled by the extrinsic sympathetic
innervation of blood vessels in skeletal muscle and by local
metabolic factors. is the primary regulator of blood flow to the
skeletal muscle at rest.

### 1. Sympathetic innervation: The arterioles of skeletal muscle

are densely innervated by sympathetic fibers. The veins also
are innervated, but less densely. There are both alpha-1 and
beta-2 receptors on the blood vessels of skeletal muscle.
Stimulation of alpha-1 receptors causes vasoconstriction.
Stimulation of ß2 receptors causes vasodilation. The state of
constriction of skeletal muscle arterioles is a major
contributor to the TPR (because of the large mass of skeletal
muscle).

### 2. Local metabolic control: Blood flow in skeletal muscle

exhibits autoregulation and active and reactive hyperemia
Demand for O2 in skeletal muscle varies with metabolic
activity level, and blood flow. is regulated to meet demand.
During exercise, when demand is high, these local metabolic
mechanisms are dominant.
The local vasodilator substances are lactate, adenosine, and
K. Mechanical effects during exercise temporarily compress
the arteries and decrease blood flow. During the post

2/3
occlusion period, reactive hyperemia increases blood flow to
repay the O2 debt.
Skin: Skin has extensive sympathetic innervation. Cutaneous
blood flow is under extrinsic control. Temperature regulation is
the principal function of the cutaneous sympathetic nerves.
Increased temperature leads to cutaneous vasodilation,
allowing dissipation of excess body heat.
Trauma produces the "triple response" in skin-a red line, a red
flare, and a wheal. A wheal is local edema that results from
the local release of histamine, which increases capillary
filtration.
Vasoconstricting and Vasodilating agent:
Previous Next

3/3',
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
    "updated_at" = now();

  -- Lesson: Heart Sounds, Mechanical Events and Correspondance with ECG
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'heart-sounds-mechanical-events-and-correspondance-with-ecg',
    'Heart Sounds, Mechanical Events and Correspondance with ECG',
    'article',
    '# Heart Sounds, Mechanical Events and Correspondance with ECG

Heart sounds, Mechanical event and correspondence with
ECG
Previous Next

Diet ii Late 2026)
Overview  Comments

1/2

2/2',
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
    "updated_at" = now();

  -- Lesson: Heart Volumes
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'heart-volumes',
    'Heart Volumes',
    'article',
    '# Heart Volumes

Heart volume
The total blood volume in the circulatory system of a healthy
adult is about 5 L.
Stroke Volume Output: The volume of blood that is ejected
by each ventricle during systole is called stroke volume
output (Value:70 ml/beat)
Heart rate= 70bpm
Cardiac output (CO) = Stroke volume x Heart rate = 70
mL/beat x 70 beats/min = 4900 mL/min
Mean arterial pressure: Average arterial pressure during
single cardiac cycle. MAP can be calculated by:  Diastolic
pressure + 1/3 of pulse pressure (SBP-DBP) OR 80+ 1/3 (120-
80) = 93mmhg where BP 120/80
End-Diastolic Volume: The volume of blood in each ventricle
at the end of the diastole is called end-diastolic volume.
(Value:120-130ml)
End-Systolic Volume: The volume of blood in each ventricle
at end of systole is called end-systolic volume. (Value: 50-
60ml)
Ejection Fraction: Fraction of end-diastolic volume that is
ejected during systole, is called ejection fraction. (Value: 60%)
Previous Next

Diet ii Late 2026)
Overview  Comments

1/2

2/2',
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
    "updated_at" = now();

  -- Lesson: Microcirculation and Lymph
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'microcirculation-and-lymph',
    'Microcirculation and Lymph',
    'article',
    '# Microcirculation and Lymph

Microcirculation and Lymph
Structure of capillary beds
Metarterioles branch into the capillary beds. At the junction
of the arterioles and capillaries is a smooth muscle band
called the precapillary sphincter.
True capillaries do not have smooth muscle; they consist of a
single layer of endothelial cells surrounded by a basement
membrane.
Clefts (pores) between the endothelial cells allow passage of
water-soluble substances.
Blood flow through the capillaries is regulated by contraction
and relaxation of the arterioles and pre-capillary sphincter.
Passage of substances across the capillary
wall
Lipid-soluble substances across the membranes of the
capillary endothelial cells by simple diffusion, include O2 and
CO2
Small water-soluble substances cross via the water-filled
clefts between the endothelial cells which include water,
glucose, and amino acids.
Generally, protein molecules are too large to pass freely
through the clefts.
In the brain, the clefts between endothelial cells are
exceptionally tight (blood-brain barrier).
In the liver and intestine, the clefts are exceptionally wide
and allow passage of protein. These capillaries are called
sinusoids.
Large water-soluble substances can cross by pinocytosis.
Lymph:
Function of lymph: Normally, filtration of fluid out of the
capillaries is slightly greater than absorption of fluid into the
capillaries. The excess filtered fluid is returned to the circulation

Diet ii Late 2026)
Overview  Comments

1/2
via the lymph also returns any filtered protein to the
circulation.
Unidirectional flow of lymph One-way flap valves permit
interstitial fluid to enter, but not leave the lymph vessels.
Flow through larger lymphatic vessels is also unidirectional
and is aided by one-way valves and skeletal muscle
contraction.
Edema:
occurs when the volume of interstitial fluid exceeds the
capacity of the lymphatics to return it to the circulation.
Can be caused by excess filtration or blocked lymphatics.
Histamine causes both arteriolar dilation and venous
constriction, which together produce a large increase in
capillary hydrostatic pressure and local edema.
In nephrotic syndrome urinary loss of protein result in
hypoalbuminemia and edema is due to increased capillary
hydrostatic pressure and decreased plasma oncotic
pressure
Nitric oxide (NO):
Sodium nitroprusside is broken down into the circulation to
release Nitric Oxide (NO)
is produced in the endothelial cells. causes local relaxation of
vascular smooth muscle.
Mechanism of action involves the activation of guanylate
cyclase and production of cyclic guanosine
monophosphate (cGMP)
NO is one form of endothelial-derived relaxing factor (EDRF).
Circulating Acetylcholine causes vasodilation by stimulating
the production of NO in vascular smooth muscle.
Previous Next

2/2',
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
    "updated_at" = now();

  -- Lesson: Reflex Control of Heart
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'reflex-control-of-heart',
    'Reflex Control of Heart',
    'article',
    '# Reflex Control of Heart

Reflex control of heart by
autonomic nervous system
Sympathetic stimulation increases heart rate and strength,
thereby increasing cardiac pumping. Sympathetic
stimulation causes vasoconstriction and vasoconstriction
increases blood pressure by increasing total peripheral
resistance (TPR). If resistance increases, then more pressure is
needed to keep blood moving.
Parasympathetic stimulation decreases heart rate and
strength, thereby decreasing cardiac pumping.
Previous Next

Diet ii Late 2026)
Overview  Comments

1/2

2/2',
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
    "updated_at" = now();

  -- Lesson: Regulation of Blood Pressure
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'regulation-of-blood-pressure',
    'Regulation of Blood Pressure',
    'article',
    '# Regulation of Blood Pressure

Regulation of Blood pressure
Mechanism of baroreceptor and
chemoreceptor reflex:
Impaired baroreceptor reflex:
Orthostatic hypotension (Postural hypotension): fainting or
light-headedness on standing may occur in individuals whose
baroreceptor reflex mechanism is impaired (e.g., individuals
treated with sympatholytic agents) or who are volume
depleted.
On standing from a prone position, gravity causes blood to pool
into veins in the legs. Central venous pressure (CVP) falls,
causing a fall in stroke volume and cardiac output and thus a
fall in blood pressure.
Other regulation of Arterial blood
pressure:
Cerebral ischemia: When brain is ischemic, the partial pressure
of carbon dioxide (Pco2) in brain tissue increases
Chemoreceptors in the vasomotor center respond by
increasing sympathetic outflow to the heart and blood vessels.
Constriction of arterioles causes intense peripheral
vasoconstriction and increased TPR. Blood flow to other
organs (e.g., kidneys) is significantly reduced to preserve

Diet ii Late 2026)
Overview  Comments

1/2
blood flow to the brain. Mean arterial pressure can increase to
life-threatening levels.
The Cushing reaction is an example of the response to cerebral
ischemia. Increases in intracranial pressure cause compression
of the cerebral blood vessels, leading to cerebral ischemia and
increased cerebral Pco ₂ . The vasomotor center directs an
increase in sympathetic outflow to the heart and blood vessels,
which causes a profound increase in arterial pressure.
Previous Next

2/2',
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
    "updated_at" = now();

  -- Lesson: Regulation of Cardiac Pumping
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'regulation-of-cardiac-pumping',
    'Regulation of Cardiac Pumping',
    'article',
    '# Regulation of Cardiac Pumping

Regulation of Cardiac Pumping
Cardiac pumping (i.e., volume of blood pumped by heart) is
regulated by:
Intrinsic regulation: pumping in response to changes in
volume of blood flowing into heart (obeys Frank starling Law
of heart).
Frank Starling Law:
When venous return of blood increases, the heart muscle
stretches more, which makes it pump with a greater force of
contraction. The Frank- Starling mechanism of the heart can be
stated in another way:
Within physiological limits, the heart pumps all the blood that
comes to it without allowing excess accumulation of blood in
the veins.
Mechanism of Frank Starling Law
States that "Within physiologic limits, the heart pumps all the
blood that returns to it by the way of veins.
Extra volume of blood enters heart chambers.
cardiac muscle over-stretched
cardiac muscle contracts with increased force because the
initial length of fiber increases and pumps extra blood into
arteries.
Concepts of preload and after load:
The heart will contract with greater force when preload/EDV
is increased. Preload is diastolic filling volume of left
ventricle reflect stretch of cardiac muscle cells, greater the
stretch more forcefully heart will contract. when there is
increased EDV/ preload there is increased in Stroke volume
this intrinsic relationship between EDV and stroke volume is
known as frank starling law of heart.

Diet ii Late 2026)
Overview  Comments

1/3
Afterload is the pressure that the chambers of the heart
must generate in order to eject blood out of the heart occurs
in systole.
Note: In heart failure, the Frank-Starling curve is moved down
and flattened due to reduced inotropy, so that more venous
return and hence preload is required to increase stroke volume.
As venous return and preload rise, myocyte stretching occurs
that increases sarcomere length.
Factors affecting frank starling curve.
increase in contractility shift the curve upward and to the
left e.g.: positive inotropic drugs (RECALL)
Decrease in contractility= downward and to the right
Increase in preload = rightward shift
decrease in preload=leftward shift
Increase in Afterload=Downward and right
Decrease in Afterload=upward and left
Chronotropic and ionotropic effects
Factors that affect intracellular [Ca2+] concentration and
hence cardiac contractility are called inotropes.
Chromotropes increase sinus nodal discharge increase heart
rate.
Sympathetic stimulation increases cardiac muscle
contractility because it causes the release of noradrenaline.
Noradrenaline is a positive inotrope; it binds to β 1-
adrenoceptors on the membrane and causes increased Ca2+
entry via L-type channels during the AP and thus increases
Ca2+ release from the SR. Noradrenaline also increases Ca2+
sequestration into the SR and thus more Ca2+ is available for
the next contraction.
Adrenaline is a non-selective adrenergic agonist with potent
β 1 and moderate α 1 and β 2-receptor activity. Increase
myocardial force of contraction (positive inotrope) and heart
rate (positive chronotrope) occur as a result of β 1 receptor
stimulation. Systemic vascular resistance is increased
overall because the stimulation of α 1 receptors results in

2/3
peripheral vasoconstriction, which counters the vasodilation
due to β 2 receptor activation.
Digoxin slows the removal of Ca2+ from the cell by inhibiting
the membrane Na+ pump which generates the Na+ gradient
required for driving the export of Ca2+; consequently, the
removal of Ca2+ from the myocyte is slowed and more Ca2+
is available inside the myocyte for the next contraction.
Examples:
Adrenaline is positive inotrope as well as positive
chronotropic agent, increases both heart rate and
contractility.
Dopamine is positive inotropic drug increases contractility.
Digoxin is positive inotrope and negative chronotrope.
Previous Next

3/3',
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
    "updated_at" = now();

  -- Lesson: Ventricular Myocyte Vs Pacemaker Action Potential
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'ventricular-myocyte-vs-pacemaker-action-potential',
    'Ventricular Myocyte Vs Pacemaker Action Potential',
    'article',
    '# Ventricular Myocyte Vs Pacemaker Action Potential

Ventricular myocyte action
potential
RMP of Ventricular myocyte is -90mv depolarization initiates
when RMP reaches threshold of -65mv
Fast Na channels activate and a rapid Na+ influx
depolarizes membrane potential.
Pacemaker action potential:
Action potential of SA node differs from ventricular muscle.
RMP of SA node is -60mv depolarization initiates when RMP
reaches threshold of -40mv.
Slow calcium channels activation and calcium influx
initiates depolarization unlike of other ventricular muscle Na
influx initiates depolarization

Diet ii Late 2026)
Overview  Comments

1/2
Previous Next

2/2',
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
    "updated_at" = now();

  -- ==========================================
  -- Module 3: Respiratory Physiology & Ventilation
  -- ==========================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Respiratory Physiology & Ventilation' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Respiratory Physiology & Ventilation', 2, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 2, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Alveolar Arterial Gradient
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'alveolar-arterial-gradient',
    'Alveolar Arterial Gradient',
    'article',
    '# Alveolar Arterial Gradient

A-a gradient
Difference between alveolar Po2 and arterial Po2
A-a gradient: PA02-Pao2 (where PA02 alveolar po2 and Pao2
is arterial po2)
The A-a gradient is used to determine whether O2 has
equilibrated between alveolar gas and arterial blood.
The normal A-a gradient is between 0- and 10mm Hg. Since
O2 normally equilibrates between alveolar gas and arterial
blood, PAo2 is approximately equal to Pao2. e.g.,
Hypoventilation: CNS depression, Neuromuscular disease
(including myasthenia gravis and kyphoscoliosis), Obesity
and Low inspired fio2 on high altitude
The A-a gradient is increased (>10 mm Hg) if O2 does not
equilibrate between alveolar gas and arterial blood (e.g.,
diffusion defect, V/Q defect, and right-to-left shunt) and
PAo2 is greater than Pao ₂
Hypoxia and Hypoxemia
Hypoxia: decreased o2 delivery to the tissues caused by
decreased blood flow, hypoxemia, decreased haemoglobin
concentration, Co poisoning and Cyanide poisoning
Note: Erythropoietin (EPO) is growth factor that is synthesized
in the kidneys in response to hypoxia
Hypoxemia: Decrease in arterial pao2 caused by decreased
Alveolar PAo2, diffusion defect, V/Q defects and right to left
shunt
Previous Next

Diet ii Late 2026)
Overview  Comments

1/2
2/2',
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
    "updated_at" = now();

  -- Lesson: Breathing Cycle - Description of Pressure and Airflow
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'breathing-cycle-description-of-pressure-and-airflow',
    'Breathing Cycle - Description of Pressure and Airflow',
    'article',
    '# Breathing Cycle - Description of Pressure and Airflow

Breathing cycle (description of
pressures and airflow)
At rest (before inspiration begins):
Alveolar pressure equals atmospheric pressure, because lung
pressures are expressed relative to atmospheric pressure,
alveolar pressure is said to be zero.
Intrapleural pressure is negative.
At FRC, the opposing forces of the lungs trying to collapse
and the chest wall trying to expand create a negative
pressure in the intrapleural space between them. Intrapleural
pressure can be measured by a balloon catheter in the
esophagus.
Lung volume is the Functional residual capacity.
During inspiration:
The inspiratory muscles contract and cause the volume of the
thorax to increase. As lung volume increases, alveolar pressure
decreases to less than atmospheric pressure (i.e. becomes
negative).
The pressure gradient between the atmosphere and the
alveoli now causes air to flow into the lungs; airflow will
continue until the pressure gradient dissipates.
Intrapleural pressure becomes more negative.
Because lung volume increases during inspiration, the elastic
recoil strength of the lungs also increases. As a result,
intrapleural pressure becomes even more negative than it
was at rest. Changes in intrapleural pressure during
inspiration are used to measure the dynamic compliance of
the lungs.
At the peak of inspiration, lung volume is the FRC plus one
Tidal volume.
During expiration:

Diet ii Late 2026)
Overview  Comments

1/2
Alveolar pressure becomes greater than atmospheric
pressure. "The alveolar pressure becomes greater (i.e. becomes
positive) because alveolar gas is compressed by the elastic
forces of the lung.
Thus, alveolar pressure is now higher than atmospheric
pressure, the pressure gradient is reversed, and air flows out
of the lungs.
Intrapleural pressure returns to its resting value during a
normal (passive) expiration. However, during a forced
expiration, intrapleural pressure actually becomes
positive.This positive intrapleural pressure compresses the
airways and makes expiration more difficult.
In COPD, in which airway resistance is increased, patients
learn to expire slowly with "pursed lips." By creating a
resistance at the mouth, airway pressure is increased and
prevents the airway collapse that may occur with a forced
expiration.
Lung volume returns to FRC.
Previous Next

2/2',
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

  -- Lesson: Central Control of Breathing
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'central-control-of-breathing',
    'Central Control of Breathing',
    'article',
    '# Central Control of Breathing

Involuntary respiration
Involuntary respiration is under subconscious control. The
diaphragm and intercostal muscles are the primary respiratory
muscles. They are stimulated by groups of neurons located in
the pons and medulla. These neurons form the respiratory
control centre. They send impulses to the primary respiratory
muscles, via the phrenic and intercostal nerves, which
stimulate their contraction. There are three main groups of
neurons involved in respiration:
The ventral respiratory group controls expiration
The dorsal respiratory group controls inspiration
The pontine respiratory group controls the rate and pattern
of breathing.
Note: When expiratory neurons fire they inhibit the activity of
inspiratory neurons and once the neurons stop firing, the
inspiratory muscles relax, and expiration occurs.
Voluntary respiration
Voluntary respiration is under conscious control. It is
controlled via the motor cortex in the cerebrum, which
receives inputs from the limbic system and hypothalamus.
Signals are thought to be sent to the spinal cord from the
motor cortex, which are then passed onto the respiratory
muscles.
Central control of breathing
(brainstem and cerebral cortex)

### 1. Medullary respiratory center (Recall)

A: Dorsal respiratory group is primarily responsible for
inspiration and generates the basic rhythm for breathing
Input to the dorsal respiratory group comes from the vagus
and glossopharyngeal nerves. The vagus nerve relays
information from peripheral chemoreceptors in the lung. The
glossopharyngeal nerve relays information from peripheral

Diet ii Late 2026)
Overview  Comments

1/2
chemoreceptors and Output from the dorsal respiratory
group travels, via the phrenic nerve, to the diaphragm
B: Ventral respiratory group is primarily responsible for
expiration, is not active during normal, quiet breathing, when
expiration is passive.
Activated during exercise, when expiration becomes an
active process.

### 2. Apneustic center is located in the lower pons. Stimulates

inspiration, producing a deep and prolonged inspiratory gasp
(apneusis). Normally apneustic center promotes deep
breathing, damage to apneustic center promotes shallow
irregular/ Erratic breathing.

### 3. Pneumotaxic center is located in the upper pons inhibits

inspiration and, therefore, regulates both the rate and pattern
of breathing. Pneumotaxic center normally prevents
excessive deep breathing, damage to pneumotaxic results in
increase in depth of respiration (deep breathing) and
decrease in respiratory rate.
4.Cerebral cortex: Breathing can be under voluntary control;
therefore, a person can voluntarily hyper ventilate or hypo
ventilate.
Note: Hypoventilation (breath-holding) is limited by the
resulting increase in Pco2 and decrease in P02
Previous Next

2/2',
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

  -- Lesson: Control of Ventilation
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'control-of-ventilation',
    'Control of Ventilation',
    'article',
    '# Control of Ventilation

Control of ventilation is mediated via
central and Peripheral
chemoreceptors.
Chemoreceptor overview:
Central chemoreceptor Vs Peripheral
chemoreceptor
Previous Next

Diet ii Late 2026)
Overview  Comments

1/2
2/2',
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

  -- Lesson: Dead Space
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'dead-space',
    'Dead Space',
    'article',
    '# Dead Space

Dead Space
Anatomic dead space
Refers to volume of conducting airways.
Normally approximately 150 ml
Alveolar dead space:
Refers to alveoli incapable of gas exchange, in normal healthy
individual it is negligible, but it may become significant in
V/Q mismatch i.e., in pulmonary embolism when alveoli do
not take part in gas exchange.
Physiologic dead space: sum of anatomical and alveolar dead
space.
Defined as the volume of the lungs that does not participate
in gas exchange. is approximately equal to the anatomic
dead space in normal lungs may be greater than the
anatomic dead space in lung diseases in which the
ventilation/perfusion (V/Q) defects.
Previous Next

Diet ii Late 2026)
Overview  Comments

1/2

2/2',
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

  -- Lesson: Diffusion and Diffusion Capacity
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'diffusion-and-diffusion-capacity',
    'Diffusion and Diffusion Capacity',
    'article',
    '# Diffusion and Diffusion Capacity

Diffusion of gases such as 02
and CO ₂
The diffusion rates of O2 and CO2 depend on the partial
pressure differences across the membrane and the area
available for diffusion.
For example, the diffusion of O2 from alveolar air into the
pulmonary capillary depends on the partial pressure
difference for O2 between alveolar air and pulmonary
capillary blood.
Normally, capillary blood with alveolar gas; when the partial
pressures of 02 become equal there is no more net diffusion
of O2.
Gas diffusion across the alveolar-pulmonary capillary barrier
occurs according to Ficks law.
Fick''s law
shows the relationship between the variables that affect
diffusion: Rate of diffusion directly proportional to surface
area x concentration difference and inversely proportional to
thickness of membrane.
Fick''s law tells us that the rate of diffusion of a gas increases:
the larger the surface area involved in gas exchange.
the greater the partial pressure gradient across the
membrane
the thinner the membrane
the more soluble the gas in the membrane
the lower the molecular weight of the gas
Diffusion Capacity (DLCO)
Lung diffusing capacity is the equivalent of permeability of the
alveolar-pulmonary capillary barrier and is proportional to
diffusion coefficient of the gas and surface area and inversely
proportional to thickness of the barrier. DLCO is measured with
carbon monoxide (i.e., DLCO).

Diet ii Late 2026)
Overview  Comments

1/2
DLCO increases during exercise because there are more
open capillaries and thus more surface area for diffusion.
DLCO decreases in emphysema (because of decreased
surface area) and in fibrosis and pulmonary edema (because
of increased diffusion distance).
High DLCO and Low DLCO
Previous Next

2/2',
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

  -- Lesson: Gas Exchange
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'gas-exchange',
    'Gas Exchange',
    'article',
    '# Gas Exchange

## Gas Exchange

Dalton law of partial pressures
Daltons law of partial pressure can be expressed by the
following equation:
Partial pressure = Total pressure x Fractional gas
concentration
In dry inspired air, the partial pressure of O2 can be
calculated as follows. Assume that total pressure is
atmospheric (760) and the fractional concentration of O2 is
0.21.
Po2 760 mm Hg 0.21 =160 mm Hg
In humidified tracheal air at 37°C, the calculation is modified
to correct for the partial pressure of H ₂ O, which is 47 mm Hg.
P.total=760 mm Hg-47 mm Hg =713 mm Hg
Po2= 713 mm Hg x 0.21 =150 mm Hg
Partial pressure of 02 and CO2 in
inspired air, alveolar air and blood
Approximately 2% of the systemic cardiac output bypasses
the pulmonary circulation ("physiologic shunt"). The resulting
admixture of mixed venous blood with oxygen arterial blood
makes the Po2 of arterial blood slightly lower than that of
alveolar air.
Dissolved gases
Henry law: states that the amount of dissolved gas in a liquid
(such as blood) is proportional to its partial pressure above the
liquid.
So, breathing gas at higher-than-normal pressures will cause
their bodies to absorb more gases than are absorbed at lower

Diet ii Late 2026)
Overview  Comments

1/2
pressures. Absorbed gases can cause decompression
sickness as well as toxic effects.
Henry law is applicable in Scuva diving or deep-sea diver.
The following calculation uses O2 in arterial blood as an
example: Dissolved [O2] =Po2 × Solubility of O2 in blood 100
mm Hg x 0.003 mL 02/100 mL/mm Hg =0.3 mL 0/100 mL
blood
where:
[02] =02concentration in blood
Po2partial pressure of O2 in blood
0.003 mL O2/100 mL/mm Hg= solubility of O2 in blood
Partial pressure of O2 and Co2 (mm Hg)
Previous Next

2/2',
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
    "updated_at" = now();

  -- Lesson: Lung Elastance and Compliance
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'lung-elastance-and-compliance',
    'Lung Elastance and Compliance',
    'article',
    '# Lung Elastance and Compliance

Lung elastance and Lung
Compliance:
Lung elastance: Tendency of lungs to collapse.
Compliance: The ease with which the lungs can expand
known as compliance
Compliance increases in Obstructive lung disease.
Compliance decreases in Restrictive Lung disease.
Changes in lung compliance
In a patient with emphysema, lung compliance is increased,
elastic recoil is decreased and the tendency of the lungs to
collapse is decreased. Therefore, at the original FRC the
tendency of the lungs to collapse is less than the tendency of
the chest wall to expand. The lung-chest wall system will
seek a new, higher FRC so that the two opposing forces can
be balanced again; the patient''s chest becomes barrel-
shaped, reflecting this higher volume.
In a patient with fibrosis, lung compliance is decreased,
elastic recoil is increased. and the tendency of the lungs to
collapse is increased, Therefore, at the original FRC the
tendency of the lungs to collapse is greater than the
tendency of the chest wall to expand. The lung-chest wall
system will seek a new, lower FRC so that the two opposing
forces can be balanced again.
Previous Next

Diet ii Late 2026)
Overview  Comments

1/2

2/2',
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
    "updated_at" = now();

  -- Lesson: Lung Receptors
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'lung-receptors',
    'Lung Receptors',
    'article',
    '# Lung Receptors

Lung receptors:
Irritant Receptors in the Airways: The epithelium of the
trachea, bronchi, and bronchioles is supplied with sensory
nerve endings called pulmonary irritant receptors that are
stimulated by many incidents. These receptors initiate
coughing and sneezing and cause bronchial constriction in
people with such diseases as asthma and emphysema. They
are rapidly adapting.
J-receptors: respond to events such as pulmonary edema,
pulmonary emboli pneumonia, and barotrauma, which cause a
decrease in oxygenation and thus lead to an increase in
ventilation/respiration.
J receptors are activated in pulmonary edema in a patient
with congestive heart failure and causes reflex increase in
breathing rate (Rapid shallow breathing) also thought to be
involve in sensation of dyspnea
Lung stretch receptors (Hering-Breuer reflex): Self-regulatory
negative feedback reflex.
Lie within the smooth muscle of large and small airways.
Afferent is carried via vagus nerve.
Stimulus for receptor:
Distension of the lungs, when TV is more than 1 L
Hering-Breuer inflation reflex: inflation of the lungs tended to
inhibit further inspiratory muscle activity (dorsal neuron).
Increase in duration of expiration.
Hering-Breuer Deflation reflex: Decrease in duration of
expiration produced by marked deflation of lung.

Diet ii Late 2026)
Overview  Comments

1/2
Previous Next

2/2',
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
    "updated_at" = now();

  -- Lesson: Lung Volumes and Capacities
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'lung-volumes-and-capacities',
    'Lung Volumes and Capacities',
    'article',
    '# Lung Volumes and Capacities

Lung volume and capacities
Tidal Volume (TV): The volume of air that is inhaled and then
exhaled with each normal breath.
Normal tidal volume is 500ml or 7ml/kg.
Inspiratory Reserve Volume (IRV): The maximum volume of air
that can be inhaled following and above a normal tidal
inspiration.
Normal Inspiratory reserve volume (IRV) is 3300ml.
Expiratory Reserve Volume (ERV): The maximum volume of air
that can be exhaled from the resting expiration of tidal
volume.
Normal Expiratory reserve volume (ERV) is 1700ml.
Residual Volume (RV): The volume of air that remains in the
lung following a maximum expiration.
Residual Volume cannot be measured using spirometry.
Normal residual volume is 1800ml.
Capacities
Inspiratory Capacity (IC): is the maximum volume of air that
can be inhaled at the end of resting expiration.
Inspiratory capacity is sum of IC= TV+ IRV
Functional Residual Capacity (FRC): the volume of air
remaining in the lungs at the resting end-expiratory level or
Volume remaining in the lungs after tidal volume is expired in
air.
FRC is sum of: FRC= ERV+ RV
FRC include Residual volume so FRC cannot be measured
using spirometry.
Normal FRC is 3500ml.
Factors affecting FRC.

Diet ii Late 2026)
Overview  Comments

1/3
Factors increasing FRC: Emphysema, Air trapping in asthma,
Ageing (due to loss of elastic properties) and Increasing
height of patient.
Factors decreasing FRC: Restrictive ventilatory defects e.g.,
pulmonary fibrosis, Posture - lying supine, Increased intra-
abdominal pressure (e.g., obesity, pregnancy, ascites) and
Reduced muscle tone of diaphragm e.g., muscle relaxants in
anesthesia, neuromuscular disease.
Vital Capacity (VC) is the maximum volume of air that may be exhaled
following a maximum inspiration OR inhaled following a maximum
expiration.

## Vc= Irv+Tv+ Erv Or Vc= Ic+Erv

Normal VC in young adult (70kg) is 5500ml.
Total Lung Capacity (TLC) is the volume of air contained within
the lungs following a maximum inspiration.
TLC include Residual volume so it cannot be measured
using spirometry.
TLC= IRV + TV+ ERV + RV OR TLC= IC + FRC Or TLC = VC+ RV
Normal TLC in young adult (70kg) is 7300ml.
Forced expiratory volume (FEV1)
FEV1 is the volume of air that can be expired in the first
second of a forced maximal expiration.
FEV1 is normally 80% of the forced vital capacity, which is
expressed as

## Fev1/ Fvc = 0.8

In obstructive lung disease such as asthma and chronic
obstructive pulmonary disease (COPD), both FEV1 and FVC
are reduced, but FEV1 is reduced more than FVC. FEV1/FVC
ratio is less than 0.7.
In restrictive lung disease such as fibrosis, both FEV1 and
FVC are reduced, but FEV1 is reduced less than FVC is thus,
Fev1 /FVC increased.
Lung volume measurements and
Peak Expiratory flow rate:
Lung volume can be measured with Spirometry.
Residual volume cannot be measured using spirometry.
Residual volume and thus (FRC and TLC) can be measured
using helium dilution.
Peak Expiratory flow rate:

2/3
The easiest and quickest measurement is the peak expiratory
flow rate (PEFR)
Airway resistance and lung compliance can be assessed
indirectly by measuring the forced expiratory flows and
volumes.
Lung volumes can be measured with spirometry.
PEFR is reduced if airway resistance is increased in
obstructive disease and is commonly used to monitor
asthma.
Previous Next

3/3',
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
    "updated_at" = now();

  -- Lesson: Oxygen Haemoglobin Dissociation Curve
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'oxygen-haemoglobin-dissociation-curve',
    'Oxygen Haemoglobin Dissociation Curve',
    'article',
    '# Oxygen Haemoglobin Dissociation Curve

Oxygen-Haemoglobin
Dissociation Curve
The Haemoglobin oxygen Dissociation Curve is a plot of
percent saturation of haemoglobin as a function of po2.
Changes in the hemoglobin-02
dissociation curve

### 1. Shifts to the right:

occur when the affinity of hemoglobin for O2 is decreased.
The P50 is increased, and unloading of O2 from arterial blood
to the tissues is facilitated.
Causes of Right ward shift
Decreased affinity for oxygen (More willing to give up oxygen)
Decreased pH (Recall)
Increased pCO2
Increased H+
Increased Temperature
Increased 2-3DPG.
Pregnancy (oxygen to the fetus)

### 2. Shifts to the left:

occur when the affinity of hemoglobin for 02 is increased.
The P50 is decreased, and unloading of O2 from arterial
blood into the tissues is more difficult.
Causes of left ward shift
Increased affinity for oxygen (Less willing to give up oxygen)
Increased pH
Decreased pCO2.
Decreased temperature.
Decreased H+
Decreased 2-3DPG.
CO poisoning

Diet ii Late 2026)
Overview  Comments

1/2
Methemoglobinemia
Fetal hemoglobin
Note:
Fetal hemoglobin has a higher affinity for oxygen than adult
hemoglobin. Maternal and Fetal blood never mix during
pregnancy, but they come close to each other in the
placenta.  Oxygen diffuses easily to fetal hemoglobin here.
The reason fetal hemoglobin has a higher affinity for 02. It is
composed of two alpha and two gamma subunits, while
adult hemoglobin is composed of two alpha and two beta
subunits.
2,3DPG present in RBCs enhances the ability of RBCs to
release o2 near tissue and 2,3DPG only binds with beta
globulin chains, fetal hemoglobin (HbF) lack of beta
globulin chains that''s why fetal hemoglobin has higher
affinity for O2
Previous Next

2/2',
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
    "updated_at" = now();

  -- Lesson: Resistance of the Airways
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'resistance-of-the-airways',
    'Resistance of the Airways',
    'article',
    '# Resistance of the Airways

Resistance of the airways
is described by Poiseuille law, as shown in the following
equation: R= 8 n l/ r4 where:
R= resistance
n=viscosity of the inspired gas
l-length of the airway r-radius of the airway
Note the powerful inverse fourth-power relationship
between resistance and the size (radius) of the airway.
For example, if airway radius decreases by a factor of 4, then
resistance will increase by a factor of 256 and airflow will
decrease by a factor of 256.
Factors that change airway resistance
The major site of airway resistance is the medium-sized
bronchi.
The smallest airways would seem to offer the highest
resistance, but they do not because of their parallel
arrangement.
Contraction or relaxation of bronchial
smooth muscle:  changes airway resistance
by altering the radius of the airways.
Parasympathetic stimulation, irritants, and the slow-reacting
substance of anaphylaxis (asthma) constrict the airways,
decrease the radius, and increase the resistance to airflow.
Sympathetic stimulation and sympathetic agonists
(isoproterenol) dilate the airway via beta2 receptors, increase
the radius, and decrease the resistance to airflow.
Previous Next

Diet ii Late 2026)
Overview  Comments

1/2
2/2',
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
    "updated_at" = now();

  -- Lesson: Surface Tention and Surfactant
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'surface-tention-and-surfactant',
    'Surface Tention and Surfactant',
    'article',
    '# Surface Tention and Surfactant

Surface tension and surfactant
Surface tension of the alveoli:
Surface tension of the alveoli results from the attractive forces
between liquid molecules lining the alveoli at the air-liquid
interface.
Creates a collapsing pressure that is directly proportional to
surface tension and inversely proportional to alveolar radius
(Laplace law), as shown in the following equation: P 2T/r
where:
P-collapsing pressure on alveolus (or pressure required to
keep alveolus open) [dynes/cm2)
T-surface tension (dynes/cm)
r-radius of alveolus (cm)
Note:
Large alveoli (large radii) have low collapsing pressures and
are easy to keep open.
Small alveoli (small radii) have high collapsing pressures and
are more difficult to keep open.
In the absence of surfactant, the small alveoli have a
tendency to collapse (atelectasis).
Surfactant
lines the alveoli. reduces surface tension by disrupting the
intermolecular forces between liquid molecules. This
reduction in surface tension prevents small alveoli from
collapsing and increases compliance.
synthesized by type II alveolar cells and consists primarily
of the phospholipid dipalmitoyl phosphatidylcholine (DPPC).
Note: Type 1 alveolar cells comprise the major gas exchange
surface of the alveolus
Neonatal respiratory distress syndrome: can occur in
premature infants because of the lack of surfactant. The infant

Diet ii Late 2026)
Overview  Comments

1/2
exhibits atelectasis (lungs collapse), difficulty reinflating the
lungs (as a result of decreased compliance), decreased V/Q and
right-to-left shunt, and hypoxemia (as a result of decreased V/Q
and right-to-left shunt).
Previous Next

2/2',
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
    "updated_at" = now();

  -- Lesson: Transport of Gases in Circulation
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'transport-of-gases-in-circulation',
    'Transport of Gases in Circulation',
    'article',
    '# Transport of Gases in Circulation

Transport of Gases in Circulation:
Transport of CO2:
Large amount of CO2 is continuously produced in the body.
Under normal resting conditions each 100 ml of deoxygenated
blood contains 4 ml of CO, which is carried in the blood in three
forms:
Bicarbonate ions: 60% of CO2 is transported in bicarbonate
form.
Carbamino compounds: 30% combines with the globin part
of haemoglobin to form carbamino haemoglobin
Dissolved C02: 10% is dissolved in plasma.
Transport of oxygen:
Oxygen is transported from alveoli to tissues by two forms.
Dissolved in plasma by simple diffusion. The amount of oxygen
transport in this way is very negligible. It is only 0.3ml/100ml of
plasma.
In combination with hemoglobin: Combines with HB and is
transported as Oxyhaemoglobin
Each molecule of haemoglobin can bind up to four
molecules of oxygen.
When the oxygen molecule binds, there is a conformational
change in its protein structure and its affinity for oxygen
increases, making it easier to bind the next oxygen molecule.
The actual amount of oxygen bound to haemoglobin
depends on the PO2.
Low PO2 in tissue capillaries promotes oxygen release from
haemoglobin
High PO2 in pulmonary capillaries promotes oxygen binding.
Each gram of haemoglobin binds with up to 1.34 mL oxygen,
so with a haemoglobin concentration of 140 g/L, blood
contains a maximum of 187 mL/L

Diet ii Late 2026)
Overview  Comments

1/2
Previous Next

2/2',
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
    "updated_at" = now();

  -- Lesson: Ventilation Perfusion Mismatch
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'ventilation-perfusion-mismatch',
    'Ventilation Perfusion Mismatch',
    'article',
    '# Ventilation Perfusion Mismatch

Ventilation- Perfusion mismatch
The ratio of alveolar ventilation to pulmonary blood flow is V/Q
ratio.
For the lung at rest, it is about 0.8.
Ventilation-Perfusion at base and apex of lung:
Both ventilation and perfusion are highest towards the lung
base because of gravitational effects and low at the apex of
lung
Gravitational effects are greater on perfusion than ventilation,
so V/Q ratio is high at apex and low at base
Abnormal V/Q:
Ventilation perfusion mismatch (V/Q) most common cause of
Hypoxemia

### 1: Ventilation defect: Alveoli perfused but not ventilated

Produce intrapulmonary shunting. In large ventilation defect,
V/Q is zero, which is called a shunt.
There is no gas exchange, increased A-a gradient.
Partial pressure of pulmonary CO2 increases while that of
oxygen decreases because normal amount of oxygen for
ventilation is not available.
V/Q ratio zero-pulmonary shunt: No ventilation but
perfusion remains normal Causes: ARDS, Compression
atelectasis due to hydrothorax or pneumothorax.
V/Q ratio <1: Low ventilation relative to its perfusion such as
in partial obstruction of airways. Causes: Low compliance
e.g., pulmonary fibrosis, High airway resistance e.g., COPD,
asthma

### 2: Perfusion defect (Ventilation normal but perfusion

decreased)
If blood flow to a lung is completely blocked (e.g., by an
embolism occluding a pulmonary artery), then blood flow to

Diet ii Late 2026)
Overview  Comments

1/2
that lung is zero. If ventilation is normal, then V/Q is infinite,
which is called dead space.
Partial pressure of pulmonary CO2 decreases while that of
oxygen increases.
There is no gas exchange. ↑A-a gradient. As a result, partial
pressure of oxygen and CO2 equal to inspired air.
V/Q ratio of infinity-dead space:
No perfusion but ventilation remains normal.
Causes: Embolism
Anatomic and physiologic
shunt
The shunted blood will not have been oxygenated or been
able to offload CO2 and thus its levels of PO2 and PCO2 are
that of mixed venous blood. Changes in PCO2 and
PO2 stimulate the chemoreceptors and increase ventilation,
so that arterial PCO2 returns to normal.
However, increased ventilation cannot increase blood
O2 content, as the haemoglobin of the blood passing
through the lungs is already close to saturation. Thus, right to
left shunts commonly result in a low arterial PO2 but a
normal or low PCO2.
Previous Next

2/2',
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
    "updated_at" = now();

  -- ==========================================
  -- Module 4: Renal Physiology & Acid-Base Balance
  -- ==========================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Renal Physiology & Acid-Base Balance' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Renal Physiology & Acid-Base Balance', 3, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 3, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Acid Base Balance
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'acid-base-balance',
    'Acid Base Balance',
    'article',
    '# Acid Base Balance

Acid base balance
Acid production
Two types of acids are produced in the body: volatile acid and
non-volatile acids.
Volatile acid
Is CO2
Produced from aerobic metabolism of cells.
CO2 combines with H2O to form weak acid H2CO3, which
dissociates into H and HCO3.
Carbonic anhydrase is present in most cells, catalyzes the
reversible reaction between CO2 and H2O
Non-volatile acids
Are also called fixed acids.
Include sulphuric acid and phosphoric acid.
Are normally produced at a rate of 40-60mmoles/day.
Other fixed acids include ketoacids, lactic acid, and salicylic
acid.
Buffers
Prevent a change in PH when H ions are added to or
removed from a solution.
Extracellular buffers
The major EC buffer is HCO3, which is produced from CO2
and H2O
Phosphate is a minor EC buffer, PO4 is most important as
urinary buffer; excretion of H as H2PO4 is called titratable
acid.
Intracellular buffers
Organic phosphates e.g., AMP, ADP, ATP, 2,3-
disphosphoglycerate (DPG)
Hemoglobin is a major IC buffer.

Diet ii Late 2026)
Overview  Comments

1/4
In the physiologic PH range deoxyhemoglobin is a better
buffer than oxyhemoglobin.
Renal acid base
Reabsorption of HCO3-
Reabsorption of filtered HCO3- occurs primarily in the
proximal tubule.
H+ and HCO3- are produced in the proximal tubular cells
from CO2 and H2O. CO2 and H2O combine to form H2CO3,
catalyzed by IC carbonic anhydrase; H2CO3 dissociates into
H+ and HCO3. H+ is secreted into the lumen via Na-H
exchange mechanism in the luminal membrane. The HCO3 is
reabsorbed.
In the lumen, the secreted H+ combines with filtered HCO3-
to form H2CO3, which dissociates into CO2 and H2O,
catalyzed by brush border carbonic anhydrase. CO2 and H2O
diffuse into the cell to start cycle again.
The process results in net reabsorption of filtered HCO3-.
However, it does not result in net secretion of H+
Regulation of reabsorption of filtered HCO3
Increases in the filtered load of HCO3- result in increased
rates of HCO3- reabsorption. However, if plasma HCO3 conc
becomes very high (metabolic alkalosis), the filtered load will
exceed the re absorptive capacity and HCO3- will be excreted
in urine.
Increase in Pco² results in increased rates of HCO3-
reabsorption because the supply of IC H+ for secretion is
increased. This mechanism is the basis for renal
compensation for respiratory acidosis.
Decrease in Pco² results in decreased rates of HCO3-
reabsorption because the supply of IC H+ for secretion is
decreased. This mechanism is the basis for the renal
compensation for respiratory alkalosis.
ECF volume expansion results in decreased HCO3
reabsorption.
ECF volume contraction results in increased HCO3
reabsorption (contraction alkalosis)
Angiotensin II stimulates Na-H exchange and thus increases
HCO3- reabsorption, contributing to the contraction alkalosis
that occurs secondary to ECF volume contraction.

2/4
Excretion of fixed H
Fixed H+ produced from the catabolism of protein and
phospholipid is excreted by two mechanism, titratable acid
and NH ⁴
The amount of H+ excreted as titratable acid (H2PO4)
depends on amount of urinary buffer present (usually HPO4)
and the pK of buffer.
H+ and HCO3- are produced in the intercalated cells from
CO2 and H2O. The H is secreted into the lumen by an H-
ATPase, and the HCO3- is reabsorbed into the blood (new
HCO3). In the urine secreted H+ combines with filtered HPO4
to form H2PO4, which is excreted as titratable acid, The H-
ATPase is increased by aldosterone.
This process results in net secretion of H+ and net
reabsorption of newly synthesized HCO3-.
As a result of H+ secretion, the PH of urine becomes
progressively lower. The minimum urinary PH is 4.4.
The amount of excreted as titratable acid is determined by
the amount of urinary buffer and pK of buffer.
Excretion of H as NH ⁴
The amount of H excreted as NH ⁴  depends on both amount
of NH3 synthesized by renal cells and urine PH.
NH3 is produced in renal cells from glutamine. It diffuses
down its concentration gradient from the cells into the
lumen.
H and HCO3- are produced from intercalated cells from CO2
and H2O. The H is secreted into lumen via an H- ATPase and
combines with NH3 to form NH4 which is excreted (diffusion
trapping). The HCO3 is reabsorbed into the blood (new

## Hco3).

The lower the PH of tubular fluid, the greater the excretion of
H as NH4; at low urine PH, there is more NH4 relative to NH3
in the urine, thus increasing the gradient for NH3 diffusion.
In acidosis, an adaptive increase in NH3 synthesis occurs and
aids in the excretion of excess H.
Hyperkalemia inhibits NH3 synthesis, which produces a
decrease in H excretion as NH4 (Type 4 renal tubular
acidosis). For example, Hypoaldosteronism causes
hyperkalemia and thus also causes type 4 RTA. Conversely,

3/4
hypokalemia stimulates NH3 synthesis, which produces an
increase in H excretion.
Previous Next

4/4',
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
    "updated_at" = now();

  -- Lesson: Acid Base Disorder
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'acid-base-disorder',
    'Acid Base Disorder',
    'article',
    '# Acid Base Disorder

Acid base disorders
Acid-base disorders are pathologic changes in carbon dioxide
partial pressure (Pco2) or serum bicarbonate (HCO3−) that
typically produce abnormal arterial pH values.
Acidemia is serum pH < 7.35.
Alkalemia is serum pH > 7.45.
Acidosis refers to physiologic processes that cause acid
accumulation or alkali loss.
Alkalosis refers to physiologic processes that cause alkali
accumulation or acid loss.
Ventilation controls the CO2 levels and kidney controls the
HCO3 levels.
Metabolic acidosis
Overproduction or ingestion of fixed acid or loss of base
produces a decrease in arterial [HCO3]. This decrease is the
primary disturbance in metabolic acidosis.
Decreased HCO3 concentration causes a decrease in blood
PH (Acidemia)
Acidemia causes hyperventilation (Kussmaul breathing),
which is respiratory compensation for metabolic acidosis.
Correction of metabolic acidosis consists of increased
excretion of excess fixed H as titratable acid and NH4 and
increased reabsorption of new HCO3, which replenishes the
blood [HCO3]
In chronic metabolic acidosis, an adaptive increase in NH3
synthesis aids in the excretion of excess H.
Serum anion gap = ([Na+] + [K+]) - ([Cl-] + [HCO3-])
Serum anion gap represents the difference between
measured cations and measured anions in plasma. As
plasma is always electrically neutral, the anion gap
determines the presence of unmeasured anions. These
usually include proteins, sulphate, phosphate and organic
acids.

Diet ii Late 2026)
Overview  Comments

1/5
Normal value of serum anion gap is 12meq/L (range 8-
16meq/L)
In metabolic acidosis, serum [HCO3-] decreases. For
electroneutrality, the concentration of another anion must
increase to replace HCO3-. That anion can be Cl-, or it can be
an unmeasured anion.
Serum anion gap is increased if the new acid is added to the
body, this dissociates producing new H+ (which uses up
HCO3-) and anions (which replaces HCO3-)
Serum anion gap is normal if the concentration of Cl- is
increased to replace HCO3+ (hyperchloremic metabolic
acidosis
Normal anion gap metabolic acidosis

## Nagma:

A normal anion gap occurs if there is loss of HCO3. This
causes a compensatory rise in plasma [Cl], so the anion gap is
normal (hyperchloremic acidosis).
Causes: (Mnemonic: USED-CAR)
Ureteroenteric conduit
Small bowel fistula/ Saline administration
Exogenous Acid
Diarrhea
Carbonic anhydrase inhibitor
Adrenal insufficiency
Renal tubular acidosis
Causes of high anion gap metabolic acidosis (HAGMA)

## (Mudpiles)

Methanol, metformin
Uremia
Diabetic ketoacidosis (DKA)
Propylene glycol
Isoniazid, iron overdose, infection
Lactic acidosis
Ethanol, ethylene glycol
Salicylates
Note: The most common cause of low anion gap
is hypoalbuminemia

2/5
Metabolic alkalosis
Loss of fixed H+ or gain of base produces an increase in
arterial [HCO3-]. This increase is the primary disturbance in
metabolic alkalosis.
In vomiting H is lost from stomach, HCO3 remains behind in
the blood, and the [HCO3] increases, increased [HCO3] causes
an increase in blood PH (Alkalemia). Alkalemia causes
hypoventilation which is the respiratory compensation for
metabolic alkalosis. It has features of hypocalcemia
(decreased unbound plasma Ca) and hypokalemia (because
of IC shift of K) e.g., tetany, paresthesia, muscle cramps.
Correction of metabolic alkalosis consists of increased
excretion of HCO3 because the filtered load of HCO3 exceeds
the ability of renal tubule to reabsorb it.
If metabolic alkalosis is accompanied by ECF volume
contraction (vomiting), the reabsorption of HCO3 increases
(secondary to ECF volume contraction and activation of the
renin angiotensin II aldosterone system), worsening the
metabolic alkalosis (contraction alkalosis).
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
severe potassium depletion (serum potassium <2 mmol/L)
Respiratory acidosis

3/5
Respiratory acidosis is carbon dioxide (CO2) accumulation
(hypercapnia) due to a decrease in respiratory rate and/or
respiratory volume (hypoventilation).
It is caused by decreased alveolar ventilation
(Hypoventilation) and retention of CO2.
Increased arteriolar Pco², which is primary disturbance,
causes an increase in [H] and [HCO3] by mass action.
There is no respiratory compensation for respiratory acidosis.
Renal compensation consists of increased excretion of H as
titratable acid and NH4 and increased reabsorption of new
HCO3. This process is aided by increased Pco², which supplies
more H to the renal cells for secretion. The resulting increase
in serum [HCO3] helps to normalize the PH.
In acute respiratory acidosis, renal compensation has not yet
occurred.
In chronic respiratory acidosis, renal compensation has
occurred. Thus, arterial PH is increased towards normal (i.e
compensation)
Causes
Sedatives
Opioid overdose
Airway obstruction, COPD, asthma, pulmonary oedema
Adult RDS
Neuromuscular dysfunction including Myasthenia gravis,
Multiple sclerosis, GBS, polio.
Respiratory alkalosis
It is caused by increased alveolar ventilation
(Hyperventilation) and loss of CO2.
Decreased arterial Pco², which is the primary disturbance,
causes decrease in [H] and [HCO3] by mass action.
There is no respiratory compensation for respiratory.
More common than respiratory acidosis, usually acute and
uncompensated.
Renal compensation consists of decreased excretion of H as
titratable acid and NH4 and decreased reabsorption of new
HCO3, this process is aided by the decreased Pco2 which
causes a deficit of H in the renal cells for secretion. The
resulting decrease in serum [HCO3] helps to normalize the
PH.

4/5
In acute respiratory alkalosis, renal compensation has not
yet occurred.
In chronic respiratory alkalosis, renal compensation
(decreased HCO3 reabsorption has occurred. Thus, arterial PH
is decreased towards normal (i.e., compensation)
Causes
High altitude (Hypoxia induced)
Salicylate intoxication (aspirin overdose)
Sepsis
Stress
Thyrotoxicosis
Pregnancy
Pulmonary disorder
Hyperventilation (Due to heart disorder or other, including
improper mechanical ventilation)
Vocal cord paralysis (compensation for loss of vocal volume
results in over-breathing/breathlessness).
Previous Next

5/5',
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

  -- Lesson: Aldosterone, ADH and ANP
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'aldosterone-adh-and-anp',
    'Aldosterone, ADH and ANP',
    'article',
    '# Aldosterone, ADH and ANP

Aldosterone
Aldosterone release is stimulated by
ACTH (It is less important as regulator, so pituitary failure
does not severely impair the aldosterone secretion.
High serum [K]
Angiotensin II (2° to fall in blood pressure/volume, [Na]
Functions
Na reabsorption and K secretion in DCT
Ultimately causes rise in blood pressure, hypokalemia and
increase PH level.
Antidiuretic hormone
Vasopressin or antidiuretic hormone (ADH) or
arginine vasopressin (AVP) is a non-peptide, Synthesized in the
hypothalamus. Osmoreceptors in the anterior hypothalamus
control the water intake by altering thirst and control the renal
water excretion by altering the ADH release.
Synthesized in the hypothalamus and transported to
posterior pituitary within nerve fibers.
Rapidly removed from plasma decreasing to 50% in
10minutes due to metabolism in liver and kidney.
ADH release is stimulated by.
High plasma osmolarity detected by Osmoreceptors in
anterior hypothalamus.
ECF volume depletion
Angiotensin II
Nausea, stress, exercise, pain
Hypoglycemia
It increases the synthesis of transport mechanism in DCT
including Na pump, Na-H antiporter; and Na, K channels in
principal cells and H- ATPase in intercalated cells. Thereby
enhancing the Na and H2O reabsorption and H, K secretion.

Diet ii Late 2026)
Overview  Comments

1/2
ADH release is inhibited by
Hypoosmolality
Alcohol
Caffeine
Glucocorticoid
Atrial natriuretic peptide
Functions
ADH binds to V2 receptors present on principal cells of late
DCT and collecting duct thereby increasing the reabsorption
of H2O from these segments (which otherwise are
impermeable to H2O when there is no ADH)
ADH binds V1 receptors on vascular smooth muscles causing
vasoconstriction.
Also increases NaCl reabsorption from thick ascending limb
of LOH.
Atrial natriuretic peptide
Released from cardiac atrial muscle cells in response to atrial
stretch resulting from increased intravascular volume.
Also produced in collecting duct cells
Functions
Suppress the production of renin, ADH, aldosterone.
Causes renal vasodilation thereby increasing the GFR.
Inhibits Na reabsorption in distal nephron by inhibiting the
ENaC in principal cells.
Previous Next

2/2',
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

  -- Lesson: Autoregulation
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'autoregulation',
    'Autoregulation',
    'article',
    '# Autoregulation

Autoregulation
Blood flow throughout the kidney: renal artery=arcuate
artery=afferent arteriole=glomerular capillaries=efferent
arterioles=peritubular capillaries=vasa recta=arcuate
veins=renal vein
The kidneys are very effective in auto regulating blood flow.
This is primarily due to changes in the resistance of the
afferent arterioles, for which 2 mechanisms are involved.
Myogenic responses:
MR is a function of smooth muscle to contract in response to
external stretching force. In the case of vascular smooth
muscle, this causes vasoconstriction on a rise in arterial
pressure, thus allowing for autoregulation.
Tubuloglomerular feedback (TGF)
Increased MAP leads to an increase in RBF and GFR
TGF is a regulating mechanism specific to the kidney that
leads to vasoconstriction of the afferent arteriole in response
to an increase in the luminal concentration of NaCl at the
macula densa in the early distal tubule. Because salt
reabsorption from the ascending part of the loop of Henle is
an active and more rate-limited process than the passive
diffusion of water out of the descending loop, the
concentration of NaCl reaching the macula densa is
dependent on the rate of tubular flow with larger flow
resulting in a higher distal tubular concentration. An increase
in arterial pressure will enhance tubular flow due to
enhanced glomerular filtration and reduced proximal tubular
reabsorption. This will raise the NaCl concentration at the
macula densa and cause afferent arteriolar vasoconstriction,
providing restoration of filtration and autoregulation of RBF.
Previous Next

Diet ii Late 2026)
Overview  Comments

1/2
2/2',
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

  -- Lesson: Concentration and Dilution of Urine
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'concentration-and-dilution-of-urine',
    'Concentration and Dilution of Urine',
    'article',
    '# Concentration and Dilution of Urine

Concentration and dilution of
urine
Regulation of plasma osmolarity
It is accomplished by varying the amount of H2O excreted
relative to the amount of solute excreted (i.e by varying urine
osmolarity)
Production of concentrated urine
Also called hyperosmotic urine, in which urine osmolarity >
Blood osmolarity
It is produced when circulating ADH levels are high (e.g.,
water deprivation, volume depletion, SIADH).
Corticopapillary osmotic gradient - high ADH
Is the gradient of osmolarity from the cortex (300mOsm/L) to
the papilla (1200mOsm/L) and is composed primarily of NaCl
and urea.
Is established by countercurrent multiplication and urea
recycling.
Is maintained by countercurrent exchange in the vasa recta.
Countercurrent multiplication in the LOH
Depends upon NaCl reabsorption in the thick ascending limb
and countercurrent flow in the descending and ascending
limbs of LOH.
It is augmented by ADH, which stimulates NaCl reabsorption
in the thick ascending limb. Therefore, the presence of ADH
increases the size of corticopapillary osmotic gradient.
Urea recycling
Urea recycling from inner medullary collecting ducts into the
medullary interstitial fluid is also augmented by ADH (by
stimulating UT1 transporter)
Vasa recta

Diet ii Late 2026)
Overview  Comments

1/5
Are the capillaries that supply the LOH. They maintain the
corticopapillary gradient by serving as osmotic exchanger.
Vasa recta blood equilibrates osmotically with interstitial fluid
of medulla and papilla.
Proximal tubule - high ADH
The osmolarity of glomerular filtrate is identical to that of
plasma (300mOsm/L).
Two third of filtered H2O is reabsorbed isosmotically (with Na,
Cl, H2O, glucose, amino acids and so forth) in the proximal
tubule.
TF/Posm = 1.0 throughout the proximal tubule because water
is reabsorbed isosmotically with solute.
Thick ascending limb of LOH - high ADH
It is called diluting segment.
Reabsorbs NaCl by the NA-K-2Cl cotransporter, reabsorption
of Na+ is further enhanced by ADH.
Impermeable to H2O, therefore H2O is not reabsorbed with
NaCl, and the tubular fluid becomes diluted.
The fluid that leaves the thick ascending limb has an
osmolarity of 100 mOsm/L and TF/Posm < 1.0 as a result of
dilution process.
Early distal tubule - high ADH
It is called cortical diluting segment.
Like the thick ascending limb, early distal tubule reabsorbs
NaCl but is impermeable to water. Consequently, tubular
fluid is further diluted.
Late distal tubule - high ADH
ADH increases the H2O permeability in the principal cells of
late distal tubule.
H2O is reabsorbed from the tubular fluid until the osmolarity
of tubular fluid equals that of surrounding interstitial fluid in
renal cortex (300mOsm/L)
TF/Posm = 1.0 at the end of the distal tubule because osmotic
equilibration occurs in the presence of ADH.
Collecting ducts - high ADH
As in the late distal tubule, ADH increases the H2O
permeability of the principal cells of the collecting ducts.

2/5
As tubular fluid flows through the collecting ducts, it passes
through the corticopapillary gradient (regions of increasingly
higher osmolarity), which was previously established by
countercurrent multiplication and urea recycling.
H2O is reabsorbed from the collecting ducts until the
osmolarity of tubular fluid equals that of the surrounding
fluid.
The osmolarity of the final urine equals that at the bend of
LOH and tip of papilla (1200mOsm/L)
TF/Posm= >1.0 because osmotic equilibration occurs with the
corticopapillary gradient in the presence of ADH.
Production of dilute urine
Is called hypoosmotic urine, in which urine osmolarity <
blood osmolarity.
Produced when circulating levels of ADH are low (e.g., water
intake, central diabetes insipidus) or when ADH is ineffective
(nephrogenic diabetes insipidus)
Corticopapillary osmotic gradient - no ADH
Is smaller than in the presence of ADH because ADH
stimulates both countercurrent multiplication and urea
recycling
Proximal tubule - no ADH
Two third of filtered water is reabsorbed isosmotically.
TF/Posm = 1.0 throughout the proximal tubule
Thick ascending limb of LOH - no ADH
NaCl is reabsorbed without water and tubular fluid becomes
(although not quite as dilute as in the presence of ADH.
TF/Posm = < 1.0
Early distal tubule - no ADH
NaCl is reabsorbed without water and tubular fluid is further
diluted.
TF/Posm = < 1.0
Late distal tubule - no ADH
In the absence of ADH, the cells of late distal tubule and
collecting ducts are impermeable to water.
Thus, even though the tubular fluid flows through the
corticopapillary osmotic gradient, osmotic equilibration does

3/5
not occur.
The osmolarity of final urine will be diluted with an osmolarity
as low as 50mOsm/L.
TF/Posm = < 1.0
Free water clearance (CH2O)
It is used to estimate the ability to concentrate or dilute the
urine.
Free water or solute free water is produced in the diluting
segment of kidney (i.e. thick ascending limb and early distal
tubule), where NaCl is reabsorbed, and free H2O is left behind
in the tubular fluid.
In absence of ADH, this solute free water is excreted and
CH2O is positive.
In presence of ADH, this solute free water is not excreted but
is reabsorbed by the late distal tubule and collecting ducts
and CH2O is negative.
Urine that is isosmotic to plasma
CH2O is zero
Produced during a treatment with a loop diuretic, which
inhibits NaCl reabsorption in the thick ascending limb,
inhibiting both dilution in the thick ascending limb and
production of the corticopapillary osmotic gradient.
Therefore, the urine can''t be diluted during high water intake
or concentrated during water deprivation.
Urine that is hypoosmotic to plasma (low ADH) CH2O is
positive.
Produced with high water intake (in which ADH released
from the posterior pituitary is suppressed), central diabetes
insipidus or nephrogenic diabetes insipidus.
Urine that is hyperosmotic to plasma (high ADH)
CH2O is negative.
It is produced in water deprivation or SIADH.
Previous Next

4/5
5/5',
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

  -- Lesson: Creatinine Clearance
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'creatinine-clearance',
    'Creatinine Clearance',
    'article',
    '# Creatinine Clearance

Creatinine Clearance
Clearance refers to a theoretical volume of plasma from
which a substance is removed over a period of time.
Clearance = Urine conc of substance × Urine flow rate
/plasma concentration of substance
Clearance of substance can provide an accurate estimate of
GFR when the substance is.
Freely filtered.
Not reabsorbed in nephron
Not secreted in nephron
Neither synthesized nor metabolized by kidney
Inulin is such substance but not used in routine clinical
practice due to complicated clearance.
Creatinine which is steadily released from skeletal muscle is
preferred clinical method for determining the relatively
accurate approximation of GFR (except when plasma
creatinine or GFR is abnormally low) because it is
endogenously produced, not necessary to infuse it to get a
clearance measurement as has to be done to measure inulin
clearance and because it is freely filtered not reabsorbed and
only a small amount of it is secreted, creatinine clearance
parallels inulin clearance and is independent of production rate
(excretion rises as plasma concentration increases
Previous Next

Diet ii Late 2026)
Overview  Comments

1/2

2/2',
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

  -- Lesson: Functional Anatomy of Kidney
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'functional-anatomy-of-kidney',
    'Functional Anatomy of Kidney',
    'article',
    '# Functional Anatomy of Kidney

Anatomy of Kidney
The kidneys are two bean-shaped organs, located on either
side of the spine, in the retroperitoneal space. The left kidney is
situated a little higher than the right one, because of the liver
on the right side of the abdominal cavity, above the right
kidney. The kidneys have a medial dimple called the renal
hilum, which is the entry and exit point for structures that
supply or drain the kidneys such as the nerves, ureters, vessels,
and lymphatics.
Parts of the Kidney
The cortex is the outer renal tissue located under the renal
capsule. It appears lighter in colour compared to the other
parts of the kidney. The renal corpuscles, as well as the
proximal and distal convoluted tubules are found here. It
reaches into the inner renal tissue or medulla, splitting it into
triangular parts called renal pyramids.
The renal pyramids contain the loops of Henle of each renal
tubule, as well as the collecting ducts. Each of the renal
pyramids opens at the apex, or renal papilla. Here the urine
formed inside the pyramids is collected through a structure
called the minor calyx. Several of the minor calices join to
form a major calyx. Urine moves through the major calices to
reach the renal pelvis. The pelvis is a funnel-shaped
collecting structure formed by the junction of all the major
calices. It carries urine from the whole kidney to the ureter,
which begins where the pelvis ends, at the pelvi-ureteral
junction.
Nephrons
The nephrons are the functional units of the kidneys, and
number about 1.3 million per kidney.
There are two types of nephrons, cortical nephrons (85% of
nephrons) and juxtamedullary nephrons (15% of nephrons)

Diet ii Late 2026)
Overview  Comments

1/4
A nephron has two main parts - tubules (proximal
convoluted tubule, the loop of Henle and the distal
convoluted tubule, collecting duct) and renal corpuscle
(Bowman''s capsule and glomerulus).
Cortical nephrons have their renal corpuscles in the outer
cortex and relatively short loops of Henle (LOH).
Juxtamedullary nephrons have their corpuscles in the inner
third of cortex near corticomedullary junction with long LOH
extending into renal medulla.
Glomerulus is formed by the invagination of ball of capillaries
into the bowman''s capsule.
Main functions of nephron
Glomerulus - filtration
Proximal tubule - Reabsorption of solutes
Loop of Henle - urine concentration
Distal tubule and collecting duct - Acid base balance and
H2O homeostasis.
Functions of kidney
Excretes waste products: Urea, uric acid, creatinine.
Water and electrolyte balance
Acid/base balance
Metabolism of proteins including PTH and calcitonin
Secretes the hormone erythropoietin and the enzyme, renin
into the circulation, synthesis of prostaglandins
Hydroxylates 25-hydroxy-Vit D to form the active form of
Vitamin D (1,25 dihydroxy-Vit D)
Juxtaglomerular apparatus
The juxtaglomerular apparatus (JGA) is located between the
afferent arteriole and the returning distal convoluted tubule of
the same nephron. It is responsible for regulating both
intrarenal (tubuloglomerular feedback) and extrarenal (renin-
angiotensin-aldosterone) mechanisms necessary to maintain
both renal and entire body volume status.
The three components of the JGA are the following:
The juxtaglomerular cells (granular cells) of the afferent
arteriole, synthesize and store renin, which is secreted in
response to specific stimuli (e.g., low blood flow, decreased

2/4
NaCl delivery). The juxtaglomerular cells could be considered
the "effector arm" of the renin-angiotensin-aldosterone axis.
The macula densa, a region of the distal convoluted tubule
characterized by columnar tubular epithelial cells which are
more densely packed than in other regions of the nephron.
The macula densa can be considered the "sensory arm" of
the renin-angiotensin-aldosterone axis in that these are the
cells which sense and respond to changes in tubular Na Cl
concentration. They are also involved in the mechanism of
tubuloglomerular feedback.
mesangial cells, which form connections via actin and
microtubules which allow for selective
vasoconstriction/vasodilation of the renal afferent and
efferent arterioles with mesangial cell contraction.
Glomerular filtration barrier
A membrane that selectively allows the passage of molecules
based on size and charge. Plasma is selectively filtered through
glomerular capillary wall into the bowman''s capsule
(Ultrafiltrate = fluid filtered into bowman'' space)
This barrier has three major components.

### 1: Glomerular capillary endothelium: It has fenestrations

which allows plasma components with a molecular weight of
<7000 Da to pass freely. These fenestrations actually do not
restrict the movement of water and proteins or large
molecules but instead prevent the filtration of blood cells
(e.g. RBCs).
Fenestrated endothelium has magnitude greater than
proteins; in addition, the wall is covered with negatively
charged compounds.

### 2: Glomerular basement membrane: Made up of matrix of

extracellular negatively charged proteins and other
compounds, help restrict the movement of negatively
charged molecules across the basement membrane. e.g.,
Albumin
Main site of ultrafiltrate
The basement membrane consists of 3 layers: These layers
help to limit the filtration of intermediate and large sized
solutes e.g., Albumin.

### 3: Epithelial cell layer of podocytes: Next to the bowman''s

space; the podocytes have foot processes directly contacting

3/4
the basement membrane.
Regular gaps between foot processes (pedicles) are called
filtration slits, across these slits a protein network forms slit
pores in the epithelial lining which prevent the passage of
larger molecules through this final layer.
Podocytes also exhibit phagocytic and contractile activity like
that of mesangial cells.
Previous Next

4/4',
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
    "updated_at" = now();

  -- Lesson: Glomerular Filtration Rate
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'glomerular-filtration-rate',
    'Glomerular Filtration Rate',
    'article',
    '# Glomerular Filtration Rate

Glomerular Filtration rate
Glomerular filtration rate is the amount of glomerular filtrate
formed in all the of both the kidneys per minute. In a healthy
individual, it is about 125 mL/minute.
GFR is approximately 125ml per min (180 L per day).
The RPF is approximately 600 to 720 ml per minute.
Filtration fraction is = GFR/RPF; therefore, the proportion of
plasma that is filtered each minute is about 20%
Factors determining net filtration pressure.
a) Hydrostatic pressure of glomerular capillaries (PGC)
The only force that promotes filtration.
Main factor that determines the GFR
Normal value 45mmhg
b) Oncotic pressure of the plasma ( π GC)
Varies with the concentration of plasma proteins.
Opposes the filtration.
Increases from the beginning to the end of glomerular.
Normal value = 24mmhg
c) Hydrostatic pressure in Bowman''s space (PBS)
Opposes filtration.
Normally low and constant does not affect filtration.
This pressure increases whenever there is an obstruction
downstream (blocked ureter /urethra) and reduces filtration.
Normal value = 8mmhg
d) oncotic pressure in bowman''s space ( π BS)
Considered zero because of very little or no proteins in
bowman''s space.
Net filtration pressure = PGC- π GC - PBS
= 45 - 24 - 8 = 13mmhg

Diet ii Late 2026)
Overview  Comments

1/2
Filtration at the glomeruli depends
upon starling forces.
Glomerular capillaries have very high hydrostatic pressure;
this is why filtration occurs.
Increasing glomerular hydrostatic pressure increases GFR,
and decreasing it decreases the GFR
Oncotic pressure opposes GFR, increased plasma proteins
increase the oncotic pressure and decrease the GFR and vice
versa.
Main force driving the reabsorption at proximal tubule is the
oncotic pressure in peritubular capillaries. Increased
concentration of proteins is carried into peritubular
capillaries which promotes a greater net force of
reabsorption.
High pressure in the glomerular capillary forces the filtrate
through filtration barrier, this pressure is reduced by afferent
arteriolar constriction and increased by efferent arteriolar
constriction.
Renal disease, circulating and local vasoconstrictors,
sympathetic stimulation all reduce GFR, however angiotensin
II preferentially constricts efferent arterioles therefore
increases GFR.
Previous Next

2/2',
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
    "updated_at" = now();

  -- Lesson: Hyperkalemia and Hypokalemia
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'hyperkalemia-and-hypokalemia',
    'Hyperkalemia and Hypokalemia',
    'article',
    '# Hyperkalemia and Hypokalemia

Hyperkalemia
Normal value of serum K = 3.0- 4.5 mmol/L
Causes
Insulin deficiency
Excessive dietary K
Renal failure
Addison''s disease (Hypoaldosteronism)
K+ sparing diuretics, ACE inhibitors, ARBs, NSAIDs,
trimethoprim and pentamidine therapy, B adrenergic
antagonists
Acidosis
Hyperosmolarity (H2O flows out of cell; K diffuses out with
water)
Na-K pump inhibitors (digitalis) when pump is blocked, K is
not taken up into cells.
Exercise
Cell lysis/ rhabdomyolysis / trauma /burns/ crush syndrome,
chemotherapy
Pseudo hyperkalemia:  occurs in
Test tube hemolysis
Prolonged tourniquet time
Difficulty collecting sample.
Length of storage of specimen
Sample from limb receiving IV fluid containing K
ECG findings of hyperkalemia
Causes rapid reduction in RMP leading to increased cardiac
depolarization and muscle excitability which causes ECG
changes that can progress to ventricular fibrillation of
asystole.
Tall, peaked T wave
Short QT interval
Lengthening of PR interval
Widening of QRS complex
Loss of ST segment
Loss of P wave
Sinus wave appearance

Late 2026)
Overview  Comments

1/4
Treatment of hyperkalemia
If there are ECG changes: Stabilize the cardiac membrane
first, e.g., with IV calcium gluconate (10 ml of 10% solution IV
over 2 minutes).   Followed by or treatment of hyperkalemia
without ECG changes:
shift the K+ into cells:
Iv glucose and insulin
Inhaled beta-2 agonist (e.g., salbutamol)
IV sodium bicarbonate (if acidosis present)
Remove K from Body:
IV furosemide and normal saline (if adequate renal function)
Ion-exchange resin (sodium polystyrene sulfonate)
Dialysis (in renal failure or severe refractory cases)
Hypokalemia
Causes
Renal Losses
Thiazide or loop diuretics
Renal tubular acidosis
Hypomagnesaemia

2/4
Drugs causing increased K+ excretion like penicillin,
aminoglycosides, amphotericin
GI loss
Diarrhea and vomiting
Factors causing increased IC shift of K+
Insulin excess or overdose
Catecholamines in acute stress
B2 agonists
Decreased intake.
Malnutrition, anorexia nervosa, inadequate replacement
while on TPN or NPO
Note  :
Acidosis redistributes K + out of cells=
Hyperkalemia
Alkalosis redistributes K+ into cells= Hypokalemia
EGG findings of Hypokalemia
Increases automaticity and delays cardiac cells depolarization
leading to dysrhythmias e.g ectopic AV block, atrial and
ventricular fibrillation.
Progressive lengthening of PR interval
ST segment depression
Flattening of T wave
Prominent U wave
Prolongation of QT interval
Treatment of hypokalemia
Treat the underlying disorder.
Oral and/or IV potassium replacement
Magnesium replacement, if hypomagnesemia is present.
Causes of increased distal K secretion
High K diet
Hyperaldosteronism
Alkalosis
Thiazide diuretics
Loop diuretics
Luminal anions
Causes of decreased distal K secretion
Low K diet
Hypoaldosteronism
Acidosis
K sparing diuretics

3/4
Previous Next

4/4',
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
    "updated_at" = now();

  -- Lesson: NACL Regulation
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'nacl-regulation',
    'NACL Regulation',
    'article',
    '# NACL Regulation

NaCl Regulation
Tubular fluid (TF) is urine at any point along the nephron.
Plasma (P) is systemic plasma. It is considered to be
constant.
TF/P ratio: Compares the conc of a substance in tubular fluid at
any point along the nephron with the conc in plasma.
If TF/P= 1.0, then either there has been no reabsorption of the
substance or reabsorption of substance has been exactly
proportional to the reabsorption of water.
If TF/P < 1.0, then reabsorption of substance has been greater
than the reabsorption of water and the conc in tubular fluid
is less than that in plasma.
If TF/P>1.0, then either reabsorption of the substance has
been less than the reabsorption of water or there has been
secretion of the substance.
Na reabsorption along the nephron:
Na is freely filtered across the glomerular capillaries; therefore,
the Na in the TF of bowman space equals that in plasma i.e.
TF/PNa = 1.0
Proximal tubule:
Is the site of glomerulotubular balance.
The process is isosmotic. The reabsorption of Na and H2O in
PT is exactly proportional.
Early proximal tubule:
Reabsorbs 2/3rd, or 67% of the filtered Na and H2O more than
any other part of the nephron.
Reabsorbs Na and H2O with HCO3, glucose, amino acids,
phosphate and lactate.
Na is reabsorbed by cotransport with glucose, amino acids,
phosphate and lactate. These cotransport processes account

Diet ii Late 2026)
Overview  Comments

1/3
for the reabsorption of all the filtered glucose and amino
acids.
Na is also reabsorbed by counter transport via Na-H
exchange, which is linked directly to the reabsorption of
filtered HCO3
Carbonic anhydrase inhibitors (acetazolamide) are diuretics
that act in the early pct by inhibiting the reabsorption of
filtered HCO3.
Reabsorbs 67% of the filtered K along with Na and H2O
Reabsorbs 50% of filtered urea.
Reabsorbs 85% of filtered phosphate.
Late proximal tubule:
Filtered glucose, amino acids and HCO3 have already been
completely removed from the tubular fluid by reabsorption in
early pct.
In the late pct, Na is reabsorbed with Cl (Cotransport).
Effects of ECF volume on PT reabsorption:
ECF volume contraction increases PT reabsorption.
ECF volume expansion decreases PT reabsorption.
Thick ascending limb of loop of Henle:
Reabsorbs 25% of the filtered Na
Reabsorbs 20% of filtered K
Contains a Na-K-2Cl cotransporter in the luminal membrane.
Is the site of action of the loop diuretics (furosemide,
ethacrynic acid, bumetanide), which inhibit the Na-K-2Cl
cotransporter.
Is impermeable to H2O. Thus, NaCl is reabsorbed without
water. As a result, tubular fluid [Na] and tubular fluid
osmolarity decreases to less than their conc in plasma. This
segment therefore is called the diluting segment.
It has a lumen positive potential difference. Although the Na-
K-2Cl cotransport appears to be electroneutral, some K
diffuses back into the lumen, making the lumen electrically
positive.
Distal tubule and collecting duct:
Together reabsorb 8% of filtered Na.
Early DCT:
Reabsorbs NaCl by a Na-Cl cotransporter.

2/3
Is the site of action of thiazide diuretics
Is impermeable to water, as thick ascending limb. Thus,
reabsorption of NaCl occurs without water, which further
dilutes the tubular fluid, therefore called cortical diluting
segment.
Thiazide diuretics cause hypocalciuria, in a way that they
block the Na-Cl cotransporter and decrease the Na
reabsorption and also Na-K ATPase on the basolateral
membrane maintains a low intracellular conc: of Na, which
causes the Na from interstitial fluid/peritubular capillary
blood to move into the cell in exchange with Ca through Na-
Ca exchanger/counter transport thereby increasing the
reabsorption of Ca into blood.
PTH increases the activity of Na-Ca exchanger and increases
the reabsorption of Ca.
Late DCT: Have two cell types.
Principal cells Reabsorbs Na and H2O
Secretes K
Aldosterone increases Na reabsorption and increases K
secretion. Like other steroid hormones, the action of
aldosterone takes several hours to develop because new
protein synthesis of Na channels (ENaC) is required. About 2%
of overall Na reabsorption is affected by aldosterone.
ADH increases H2O permeability by directing the insertion of
H2O channels in the luminal membrane. In the absence of
ADH, the principal cells are virtually impermeable to water.
K- sparing diuretics (spironolactone, triamterene, amiloride)
decreases K secretion.
Alpha intercalated cells:
Secretes H+ by an H-adenosine triphosphatase (H-ATPase),
which is stimulated by aldosterone.
Reabsorbs K+ by an H-K-ATPase
Previous Next

3/3',
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
    "updated_at" = now();

  -- Lesson: Potassium Regulation
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'potassium-regulation',
    'Potassium Regulation',
    'article',
    '# Potassium Regulation

K+ Regulation
K is filtered, reabsorbed and secreted by nephron.
K balance is achieved when urinary excretion of K+ exactly
equals intake of K+ in the diet.
K excretion can vary widely from the filtered load, depending
on dietary K intake, aldosterone levels and acid base.
Glomerular capillaries:
Filtration occurs freely across the glomerular capillaries.
Therefore TF/P for K in bowman space is 1.0.
Proximal tubule:
Reabsorbs 67% of the filtered K+ along with Na+ and H2O.
Thick ascending limb of LOH:
Reabsorbs 20% of the filtered K+.
Reabsorption involves Na+-K+-2Cl- cotransporter in the
luminal membrane of cells in the thick ascending limb.
Distal tubule and collecting duct:
Either reabsorbs or secretes K+ depending on dietary K
intake.
Reabsorption of K+ involves an H-K ATPase in the luminal
membrane of the alpha intercalated cells of late DCT, and its
occurs only on a low K+ diet (K+ depletion). Under these
conditions, K+ excretion can be as low as 1% of the filtered
load because the kidney conserves as much K as possible.
Secretion occurs in the principal cells. It is variable and
accounts for the wide range of urinary K+ excretion. It
depends upon factors such as dietary K+, aldosterone levels,
acid base status and urine flow rate.
Mechanism of distal K+ secretion:
At the basolateral membrane, K+ is actively transported into
the cell by the Na-K pump, as in all cells this maintains a high
intracellular K+ conc.

Diet ii Late 2026)
Overview  Comments

1/3
At the luminal membrane, K+ is passively secreted into the
lumen through K+ channels. The magnitude of this passive
secretion 1st determined by the chemical and electrical
driving forces on K+ across the luminal membrane.
Factors that change the distal K secretion:
Distal K+ secretion by the principal cells is increased when
the electrochemical driving force for K+ across the luminal
membrane is increased. Secretion is decreased when the
electrochemical driving force is decreased.
Dietary K
A diet high in K+ increases K+ secretion, and a diet low in K+
decreases K+ secretion.
On a high K+ diet, intracellular K+ increases so that the
driving force for K+ secretion also increases.
On a low K+ diet, intracellular K+ decreases so that the
driving for K+ secretion decreases. Also, the alpha
intercalated cells are stimulated to reabsorb K+ by the H+-K+
ATPase.
Aldosterone
Increases K+ secretion.
Mechanism involves aldosterone increases the no Na+
channels across the luminal membrane and increases Na+
entry into the cell (principal cell of distal tubule), it also
increases the activity of Na-K ATPase pump which in turn
causes increased pumping of Na+ out of the cells.
Stimulation of NA-K pump simultaneously increases K+
uptake into the cells, increasing the IC K conc and increased
driving force for K+ secretion. Aldosterone also increases the
number of luminal membrane K channels thereby enhancing
its secretion.
Hyperaldosteronism: Increases K secretion and causes
hypokalemia.
Hypoaldosteronism: Decreases K secretion and causes
hyperkalemia.
Acid base
Effectively, H and K exchange for each other across the
basolateral cell membrane.

2/3
Acidosis decreases K secretion. The blood contains
excessive H+; therefore, H+ enters the cell across the
basolateral membrane and K+ leaves the cell and moves into
blood through H-K exchanger. As a result, the IC K+ conc
decreases and driving force for K+ secretion decreases.
Alkalosis increases K+ secretion. The blood contains too little
H+; therefore, H+ leaves the cell across the basolateral
membrane and enters the blood in exchange with K+
through the H-K exchange mechanism thereby increasing IC
K+ conc and its secretion.
Thiazide and loop diuretics
Increase K secretion.
Diuretics that increase the flow rate through the distal tubule
and collecting duct e.g., thiazide and loop diuretics cause
dilution of the luminal K conc, increasing the driving force for
K secretion. Also, as a result of increased K secretion, these
diuretics cause hypokalemia.
K sparing diuretics
Decrease K+ secretion. If used alone they cause
hyperkalemia.
Spironolactone is an antagonist of aldosterone; triamterene
and amiloride act directly on the principal cells.
The most important use of K+ sparing diuretics is in
combination with thiazide or loop diuretics to reduce urinary
K losses.
Luminal anions
Excess anions (HCO3-) in the lumen cause an increase in K+
secretion by increasing the negativity of the lumen and
increasing the driving force for K+ secretion.
Previous Next

3/3',
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
    "updated_at" = now();

  -- Lesson: Renal Regulation of Urea, Phosphate, Calcium and Magnessium
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'renal-regulation-of-urea-phosphate-calcium-and-magnessium',
    'Renal Regulation of Urea, Phosphate, Calcium and Magnessium',
    'article',
    '# Renal Regulation of Urea, Phosphate, Calcium and Magnessium

Renal regulation of urea,
phosphate, calcium and
magnesium
Urea
Urea is reabsorbed and secreted in nephron by diffusion,
simple of facilitated, depending on segment of nephron.
50% of filtered urea is reabsorbed in the early PCT by simple
diffusion.
Urea is secreted in thin descending limb of LOH by simple
diffusion (from high conc of urea in medullary interstitial
fluid)
The distal tubule, cortical collecting ducts and outer
medullary collecting ducts are impermeable to urea; thus,
no urea is reabsorbed by these segments.
ADH stimulates a facilitated diffusion transport of urea (UT1)
in medullary collecting ducts. Urea reabsorption from inner
medullary collecting ducts contributes to urea recycling in
the inner medulla and to addition of urea to the
corticopapillary osmotic gradient.
Urea excretion varies with urine flow rate. At high levels of
water (low urine flow rate), there is greater reabsorption and
decreased urea excretion. At low levels of water reabsorption
(high urine flow rate) there is less urea reabsorption and
increased urea excretion.
Phosphate
85% of filtered PO4 is reabsorbed in the early PCT by Na-PO4
cotransport. Because the distal segment of the nephron does
not reabsorb PO4, 15% of filtered load is excreted in urine.
PTH inhibits PO4 reabsorption in the early PCT by inhibiting
Na-PO4 cotransport. Therefore, PTH causes phosphaturia and
increased urinary cAMP.
PO4 is a urinary buffer for H+; excretion of H2PO4 is called
titratable acid.

Diet ii Late 2026)
Overview  Comments

1/2
Calcium
60% of plasma Ca is filtered across the glomerular capillaries.
Together the proximal tubule and thick ascending limb
reabsorb more than 90% of filtered Ca by passive processes
that are coupled to Na reabsorption.
Loop diuretics (furosemide) cause increased urinary calcium
excretion (hypercalciuria). Because Ca reabsorption is linked
to Na reabsorption in LOH, inhibiting Na reabsorption with a
loop diuretic also inhibits Ca reabsorption. If volume is
replaced, loop diuretics can be used in the treatment of
hypercalcemia.
Together, distal tubule and collecting duct reabsorbs 8% of
filtered Ca by an active process.
PTH increases Ca reabsorption by activating adenylate
cyclase in the distal tubule.
Thiazide diuretics increase Ca reabsorption in the early distal
tubule and therefore decrease Ca excretion. For this reason,
thiazides are used in the treatment of idiopathic
hypercalciuria.
Magnesium
It is reabsorbed in the proximal tubule, thick ascending limb
of LOH, distal tubule.
In thick ascending limb, Mg and Ca compete for
reabsorption; therefore, hypercalcemia causes an increase in
Mg excretion (by inhibiting Mg reabsorption). Likewise,
hypermagnesemia causes an increase in Ca excretion (by
inhibiting Ca reabsorption)
Previous Next

2/2',
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
    "updated_at" = now();

  -- Lesson: Renin Angiotensin Aldosterone System
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'renin-angiotensin-aldosterone-system',
    'Renin Angiotensin Aldosterone System',
    'article',
    '# Renin Angiotensin Aldosterone System

Renin angiotensin aldosterone
system
The Renin-Angiotensin-Aldosterone System (RAAS) is a
hormone system within the body that is essential for the
regulation of blood pressure and fluid balance. The system is
mainly comprised of the three hormones renin, angiotensin
II and aldosterone.
A fall in CPV (reflecting blood volume) is detected by atrial
and other cardiopulmonary stretch receptors. Fall in blood
volume sufficient to reduce the blood pressure activates the
baroreceptor reflex which in turn causes increased
sympathetic stimulation resulting in Renal vasoconstriction
decreasing the GFR.
ADH release causing H2O reabsorption.
Renin release from granular cells of JG apparatus
Peripheral vasoconstriction resulting in increased total
peripheral vasoconstriction.
Renin Release
The first stage of the RAAS is the release of the enzyme renin.
Renin released from granular cells of the renal juxtaglomerular
apparatus (JGA) in response to one of three factors:
Reduced sodium delivery to the distal convoluted tubule
detected by macula densa cells.
Reduced perfusion pressure in the kidney detected
by baroreceptors in the afferent arteriole.
Sympathetic stimulation of the JGA via β 1 adrenoreceptors.
Decreased GFR
Decreased ECF volume, arterial blood pressure or CVP.
Note: The release of renin is inhibited by atrial natriuretic
peptide (ANP), which is released by stretched atria in response
to increases in blood pressure.
Angiotensin II production

Diet ii Late 2026)
Overview  Comments

1/3
Angiotensinogen is a precursor protein produced in the liver
and cleaved by renin to form angiotensin I. Angiotensin I is then
converted to angiotensin II by angiotensin converting
enzyme (ACE). This conversion occurs mainly in the lungs where
ACE is produced by vascular endothelial cells, although ACE is
also generated in smaller quantities within the renal
endothelium.
Functions of angiotensin II
Angiotensin 2 acts on AT1 receptors found in the endothelium
of arterioles throughout the circulation to
achieve vasoconstriction. The net effect of this is an increase
in total peripheral resistance and consequently, blood
pressure.
Angiotensin II acts at the hypothalamus to stimulate the
sensation of thirst, resulting in an increase in fluid
consumption. This helps to raise the circulating volume and
in turn, blood pressure.
It also increases the secretion of ADH from the posterior
pituitary gland - resulting in the production of more
concentrated urine to reduce the loss of fluid from urination.
Angiotensin II acts on the adrenal cortex to stimulate the
release of aldosterone from zona glomerulosa of the adrenal
cortex. Which in turn causes increased Na reabsorption and
K loss. It also stimulates the sympathetic nervous system to
increase the release of noradrenaline (NA). which in turn
increases cardiac output, release of renin, vasoconstriction of
arterioles.
Causes vasoconstriction of renal arterioles predominantly
efferent arterioles thereby maintaining or increasing the GFR
Activation of Na-H pump thereby increasing the reabsorption
of Na from proximal tubule.
Inhibits the renin production from granular cells of JG
apparatus (negative feedback)
Previous Next

2/3
3/3',
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
    "updated_at" = now();

  -- ==========================================
  -- Module 5: Gastrointestinal (GIT) Physiology
  -- ==========================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Gastrointestinal (GIT) Physiology' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Gastrointestinal (GIT) Physiology', 4, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 4, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Absorption of Vitamins in Small Intestine
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'absorption-of-vitamins-in-small-intestine',
    'Absorption of Vitamins in Small Intestine',
    'article',
    '# Absorption of Vitamins in Small Intestine

Vitamins absorption
Fat soluble vitamins (A, D, E, and K) are incorporated into
micelles and absorb along with other lipids.
Most water-soluble vitamins are absorbed by Na+ -
dependent cotransport mechanisms.
Vitamin B12 is absorbed in the ileum and requires intrinsic
factors.
The vitamin B12-intrinsic factor complex binds to a receptor
on the ileal cells and is absorbed.
Gastrectomy results in loss of parietal cells, which are source
of intrinsic factor. Injection of vitamin B12 required to prevent
pernicious anemia
Ileectomy results in loss of absorption of vitamin B12-
intrinsic factor complex and thus requires injection of
vitamin B12
Previous Next

Diet ii Late 2026)
Overview  Comments

1/3

2/3

3/3',
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
    "updated_at" = now();

  -- Lesson: Bile and Bile Salts
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'bile-and-bile-salts',
    'Bile and Bile Salts',
    'article',
    '# Bile and Bile Salts

Bile
Bile is an aqueous, alkaline, greenish-yellow liquid whose
main function is to emulsify fats in the small intestine and to
eliminate substances from the liver. The liver produces 0.25-
1L of bile per day.
Bile contains bile salts, phospholipid, cholesterol, and bile
pigments.
Formation of bile
Bile is produced continuously by hepatocytes.
Bile drains into the hepatic ducts and is stored in the
gallbladder for subsequent release.
Choleretic agents increase the formation of bile.
Constituents of Bile
Bile is made up of bile acids, cholesterol, phospholipids,
bile pigments (such as bilirubin and biliverdin), electrolytes
and water.
These are split into two main groups, known as the bile
acid-dependent and bile acid-independent components:
The bile acid-dependent component is produced by
hepatocytes. The hepatocytes secrete bile acids, bile
pigments and cholesterol into canaliculi, which are small
channels that transport the bile acid dependent portion
towards the bile ducts.
The bile acid-independent component is made by the
ductal cells that line the bile ducts. These cells secrete an
alkaline solution - similar to the fluid made by pancreatic
duct cells. The hormone secretin stimulates this secretion.
Both the dependent and independent components of bile
enter the intrahepatic bile ducts which drain into the biliary
tree, a series of ducts which transport bile from the liver to
the gallbladder and duodenum.
Bile is continuously produced, but we only need it during and
after meals. Therefore, the gallbladder concentrates and

Diet ii Late 2026)
Overview  Comments

1/3
stores bile, by removing the water and ions.
After eating, the hormone cholecystokinin is released from
the duodenum (in response to small peptides and fatty acids
in the duodenum). This stimulates gallbladder contraction
and relaxes the sphincter of Oddi, thus allowing bile to flow
into the duodenum.
Recirculation of bile acids to the liver
The terminal ileum contains a Na+ -bile acid cotransporter,
which is a secondary active transporter that recirculates bile
acids to the liver.
Because bile acids are not recirculated until they reach the
terminal ileum, bile acids are present for maximal absorption
of lipids throughout the upper small intestine.
After ileal resection, bile acids do not recirculate to the liver
but are excreted in feces. The bile acid pool is thereby
depleted, and fat absorption is impaired, resulting in
steatorrhea.
Bile salts
Bile salts are amphipathic molecules because they have both
hydrophilic and hydrophobic portions. In aqueous solution, bile
salts orient themselves around the droplet of lipid and keep
the liquid droplets dispersed (emulsification). Aid in intestinal
digestion and absorption of lipids by emulsifying and
solubilizing them in micelles.
Production
Primary bile acids (cholic acid and chenodeoxycholic acid)
are synthesized from Cholesterol by hepatocytes.
In the intestine, bacteria convert a portion of each of the
primary bile acids to secondary bile acids (deoxycholic acid
and lithocholic acid).
Synthesis of new bile acids occur as needed, to replace bile
acids that are excreted in the feces.
The bile acids are conjugated with glycine or taurine to form
their respective bile salts.
Function of bile acids

2/3
Emulsification of lipids to increase the surface area available
for digestion by pancreatic lipase.
Micelles formation to facilitate lipid transport and absorption.
Stimulate the bile production by osmotically attracting water
and electrolytes into the bile canaliculi.
Regulation of bile acid synthesis via negative feedback
mechanism
Previous Next

3/3',
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

  -- Lesson: Calcium Absorption
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'calcium-absorption',
    'Calcium Absorption',
    'article',
    '# Calcium Absorption

Calcium absorption
Absorption of calcium in small intestine depends on
presence of adequate amounts of the active form of vitamin
D, 1 ,25-dihydroxycholecalciferol, which is produced in the
kidney. 1 ,25-dihydroxycholecalciferol induces the synthesis of
an intestinal Ca+2 -binding protein, calbindin D-28K
Vitamin D deficiency or chronic renal failure results in
inadequate intestinal Ca+ absorption, causing rickets in
children and osteomalacia in adults.
Previous Next

Diet ii Late 2026)
Overview  Comments

1/3

2/3

3/3',
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

  -- Lesson: Defecation
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'defecation',
    'Defecation',
    'article',
    '# Defecation

Defecation
There are two main anal sphincters, an internal and external
sphincter. The internal anal sphincter is controlled by
parasympathetic fibers which relax involuntarily. The
external anal sphincter is a skeletal muscle that is controlled
by somatic nerve supply from the Inferior anal branch of the
Pudendal nerve (S2,3,4), which allows conscious control of
defecation.
When the rectum is distended the recto sphincteric reflex is
initiated and relaxes the internal sphincter. If defecation is not
desired, voluntary contraction of the external sphincter can
delay it. If defecation is appropriate, then a series of reflexes
take place that lead to:
Relaxation of the external sphincter.
Contraction of abdominal wall muscles
Relaxation of pelvic wall muscles
Peristaltic waves then facilitate the movement of faeces
through the anal canal. Defecation can also be assisted by
taking a deep breath and attempting to expel the air against a
closed glottis, this is known as the Valsalva maneuver. However,
if a delay in defection is needed then voluntary contraction of
the external sphincter is usually sufficient to override the
reflexes that anal distension initiates.
Previous Next

Diet ii Late 2026)
Overview  Comments

1/3

2/3

3/3',
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

  -- Lesson: Digestion and Absorption of Carbohydrates
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'digestion-and-absorption-of-carbohydrates',
    'Digestion and Absorption of Carbohydrates',
    'article',
    '# Digestion and Absorption of Carbohydrates

Carbohydrate
Carbohydrates in the diet provide the major exogenous source
for glucose, which is the primary energy source for cells. They
provide 17kJ (4kcal) of energy per gram. Most of the dietary
carbohydrates are in the form of polysaccharides, the principal
ingested polysaccharides are starch which is derived from
plant sources and glycogen which is derived from animal
sources, other sources include disaccharides and
monosaccharides.
Digestion and Absorption of
carbohydrate
Carbohydrates are neutral compounds composed of carbon,
hydrogen, and oxygen that serve as the primary sources of
energy in the human body. They can be divided into simple
carbohydrates, which include monosaccharides (e.g., glucose,
fructose, galactose) and disaccharides (e.g., maltose, sucrose,
lactose), and complex carbohydrates, which include starch
polysaccharides (e.g., starch, glycogen and Non starch
polysaccharides (e.g., glucan, cellulose). Monosaccharides are
directly absorbed by enterocytes. Disaccharides and
polysaccharides require degradation into monosaccharides to
be absorbed by hydrolytic enzymes, which are secreted by the
salivary glands in the mouth (salivary amylase), intestinal villi
(maltase, lactase), and pancreas (pancreatic amylase).
Conditions that decrease the secretion of these enzymes result
in malabsorption and maldigestion.
Digestion

Diet ii Late 2026)
Overview  Comments

1/3
Glucose and galactose are absorbed via sodium-glucose linked
transporters (SGLTs) in the intestinal epithelial cells and
translocated into the circulation via glucose transporter 2
(GLUT2). Fructose is absorbed into enterocytes via glucose
transporter 5 (GLUT5) through facilitated diffusion. The uptake
of glucose into other cells is mediated by glucose transporters 1
to 5. Intracellularly, monosaccharides are further metabolized
by a series of enzymatic reactions that release ATP.
Indigestible carbohydrates found in plants food such as
cellulose (humans unable to digest cellulose because lack of
appropriate enzymes cellulase). it does not provide any energy;
fiber adds bulk to the bowel contents and increases the gut
motility.
Previous Next

2/3

3/3',
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

  -- Lesson: Digestion and Absorption of Lipids
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'digestion-and-absorption-of-lipids',
    'Digestion and Absorption of Lipids',
    'article',
    '# Digestion and Absorption of Lipids

Lipid
Fats in the diet are a more concentrated form of energy than
carbohydrates and have an energy yield of 37 kJ (9
kilocalories) per gram. Adipose (fatty) tissue in the fat depots
of the body serves as an energy reserve as well as helping to
insulate the body and cushion the internal organs.
The lipids of nutritional importance are triglycerides (fats and
oils), phospholipids (e.g., lecithin), and sterols (e.g.,
cholesterol). Lipids in the diet transport the four fat-soluble
vitamins (vitamins A, D, E, and K) and assist in their
absorption in the small intestine.
Digestion and absorption of lipid
Digestion
Lingual and gastric lipase begin the hydrolysis of triglycerides
to monoglycerides and fatty acids. However, most of the
ingested lipids are digested in the intestine by pancreatic
lipases.
CCK slows gastric emptying. Thus, delivery of lipids from the
stomach to the duodenum is slowed to allow adequate time
for digestion and absorption in the intestine.
In Small intestine
Bile acids emulsify lipids in the small intestine, increasing the
surface area for Digestion.
pancreatic lipases into the small intestine to enzymatically
digest triglycerides. Triglycerides are broken down to fatty
acids, monoglycerides (glycerol backbone with one fatty acid
still attached), and some free glycerol. Cholesterol and fat-
soluble vitamins do not need to be enzymatically digested
Those products of fat digestion (fatty acids, monoglycerides,
glycerol, cholesterol, and fat-soluble vitamins) need to enter
into the circulation so that they can be used by cells around
the body. Bile salts cluster around the products of fat
digestion to form structures called micelles, which help the

Diet ii Late 2026)
Overview  Comments

1/3
fats get close enough to the microvilli of intestinal cells so
that they can be absorbed.
Absorption of lipids
Micelles bring the products of lipid digestion into contact
with the absorptive surface of the intestinal cells. Then, fatty
acids, monoglycerides, cholesterol and fat-soluble vitamins
diffuse across the luminal membrane into the cells. Once
inside the intestinal cell, short- and medium-chain fatty acids
and glycerol can be directly absorbed into the bloodstream,
but larger lipids such as long-chain fatty acids,
monoglycerides, fat-soluble vitamins, and cholesterol need
help with absorption and transport to the bloodstream.
Long-chain fatty acids and monoglycerides reesterified into
triglycerides within the intestinal cell, and along with
cholesterol and fat-soluble vitamins, are then incorporated
into transport vehicles called chylomicrons. Chylomicrons
are large structures with a core of triglycerides and
cholesterol and an outer membrane made up of
phospholipids, interspersed with proteins (called
apolipoproteins) and cholesterol.  Lack of apoprotein B
results in the inability to transport chylomicrons out of the
intestinal cells and causes abetalipoproteinemia.
Chylomicrons are transported out of the intestinal cells by
exocytosis. Because chylomicrons are too large to enter the
capillaries, they are transferred to lymph vessels (lacteals) and
are added to the bloodstream via the thoracic duct.

2/3
Previous Next

3/3',
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

  -- Lesson: Digestion and Absorption of Proteins
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'digestion-and-absorption-of-proteins',
    'Digestion and Absorption of Proteins',
    'article',
    '# Digestion and Absorption of Proteins

Protein
Proteins are important nutrients that your body uses to build
cellular structures that carry out vital functions.
The building blocks of proteins are amino acids. Amino acids
are divided into two groups- essential and non-essential
amino acids. The essential amino acids cannot be made by
our bodies and instead must be acquired through our diet.
By contrast, the non-essential amino acids can be
synthesized in the human body.
Protein provides the same amount of energy as
carbohydrates (4 calories per gram).
Digestion and absorption of protein
Enzyme responsible for digestion of protein are proteolytic
enzymes.
In the mouth
Digestion of protein doesn''t occur in the mouth since
saliva does not contain any proteolytic enzymes.
In the stomach
Digestion of protein starts in stomach.
Gastric acid causes denaturation.
Cleavage via pepsin into polypeptides
In the small intestine
The intestinal phase is responsible for the bulk of proteolysis
and is mainly due to the actions of the pancreatic and
intestinal proteases. 70% of proteins are converted to
oligopeptides and amino acids in the intestines. There are two
main forms of pancreatic enzymes: endopeptidase cleaves
internal bonds and ectopeptidase cleaves AA at C-terminus.
Endopeptidases include trypsin, chymotrypsin and elastase.
Ectopeptidase includes carboxypeptidase A and
carboxypeptidase B. Carboxypeptidase A acts on neutral AA
and carboxypeptidase B acts on basic AA. The process of

Diet ii Late 2026)
Overview  Comments

1/3
digestion of protein is completed in the small intestine with
brush border and pancreatic enzymes.
Absorption:
Enterocytes contain microvilli, which form the brush border
that enables absorption and transport of nutrients.
Amino acids are absorbed via a Sodium cotransporter, in a
similar mechanism to the monosaccharides. They are then
transported across the basolateral membrane via facilitated
diffusion. Di and tripeptides are absorbed via separate H+
dependent cotransporters and once inside the cell are
hydrolyzed to amino acids.
Previous Next

2/3

3/3',
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
    "updated_at" = now();

  -- Lesson: Exocrine Pancreas
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'exocrine-pancreas',
    'Exocrine Pancreas',
    'article',
    '# Exocrine Pancreas

Exocrine pancreas
The pancreas is an abdominal organ located deep in the
retroperitoneum. It is a gland with mixed functions: both
exocrine and endocrine. the endocrine gland containing the
islets of Langerhans. Most of the pancreas is made up of the
exocrine portion (>90% by mass) and secretes a major
digestive fluid called pancreatic juice (digestive enzymes, water
and bicarbonate to assist in digestion), which is secreted into
the duodenum via the pancreatic duct. When food is present in
the duodenum the sphincter of Oddi relaxes, allowing both bile
and pancreatic secretions to enter the duodenum.
Exocrine secretion
pancreatic juice contains bicarbonate, which neutralizes acid
entering the duodenum from the stomach; and digestive
enzymes, which break down carbohydrates, proteins, and fats
in food entering the duodenum from the stomach)
The exocrine pancreas includes the acinus and its duct
system. These acinar cells are specialized in enzyme
synthesis, storage and secretion. The duct system modifies
the initial pancreatic secretion by secreting HCO3- and
absorbing CL- via CL- -HCO3- exchange mechanism in the
luminal membrane.

Diet ii Late 2026)
Overview  Comments

1/3
Enzymes secreted:
Most of the proteolytic enzymes are secreted in an inactive
form termed zymogens or proenzymes to protect the pancreas
from autodigestion. When released into the duodenum, they
are activated by the enzyme enterokinase present in the lining
of the duodenum.
Proteases
Chymotrypsinogen and Trypsinogen
Digest proteins and peptides to single amino acid
Pancreatic lipase
Digests triglycerides, monoglyceride and free fatty acids
Amylase
Starch and maltose (disaccharides)
Other enzymes include ribonuclease, gelatinase, elastase
etc.
Regulation of pancreatic secretion
Stimulation
Parasympathetic stimulation enhances secretion of both the
enzyme and aqueous components.
Cholecystokinin stimulates secretion of the enzyme rich fluid
from acinar cells.
Secretin stimulates secretion of alkaline rich fluid from ductal
cells.
Inhibition
Sympathetic stimulation inhibits the pancreatic secretion.
Somatostatin inhibits secretion of both acinar and ductal
cells.

> [!TIP]
> **Clinical pearls:**
> Acute pancreatitis:
> Inflammation of the pancreas occurs in when digestive
> enzymes secreted in pancreatic juice start digesting its own
> tissues
> Pathophysiology: Trypsin is an enzyme that is involved in the
> digestion of proteins. Normally, trypsinogen (the inactive
> precursor of trypsin) is activated to trypsin in the small
> intestine, where it aids in protein digestion. However, in cases

> 2/3
> of pancreatitis, trypsin can become prematurely activated
> within the pancreas itself due to factors like alcohol
> consumption or other triggers. This activation of trypsin within
> the pancreas can lead to the autodigestion of pancreatic tissue,
> causing inflammation.

Chymotrypsinogen is the inactive precursor of chymotrypsin.
Activation of chymotrypsinogen to its active form,
chymotrypsin, occurs through the action of trypsin. Once
trypsin is produced through the activation of trypsinogen, it
can then activate chymotrypsinogen by cleaving it to
chymotrypsin. Chymotrypsin further breaks down protein
molecules into smaller peptides and amino acids that can be
absorbed by the body.
Previous Next

3/3',
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
    "updated_at" = now();

  -- Lesson: Gastrointestinal Hormones
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'gastrointestinal-hormones',
    'Gastrointestinal Hormones',
    'article',
    '# Gastrointestinal Hormones

Gastrointestinal hormones
GI Hormone are released from endocrine cells in the GI mucosa
into portal circulation, enter the general circulation, and have
physiologic actions on target cells.
Gastrin
Gastrin hormone is released from G-cells in the lining pyloric
antrum of stomach.
Stimulating factors
Gastrin secretion is stimulated by:
The presence of small peptides and amino acids in chyme
Gastric distension
Vagal stimulation directly via acetylcholine and indirectly via
gastrin releasing peptide (GRP)
Raised gastric PH (H+)
Inhibiting factors
Gastrin secretion is inhibited by.
Low gastric PH by negative feedback mechanism
Somatostatin
Secretin
Gastric inhibitory polypeptide (GIP)
Cholecystokinin
Action of Gastrin
Stimulate the acid secretion from gastric parietal cells (both
by directly and indirectly by stimulating release of histamine
from ECL cells
Stimulate pepsinogen secretion from chief cells.
Stimulate growth of gastric mucosa by stimulating the
synthesis of RNA and new protein

Diet ii Late 2026)
Overview  Comments

1/4
Zollinger-Ellison syndrome (Gastrinoma)
Occurs when gastrin is secreted by non-β-cell tumors of the
pancreas.
Secretin
Secretin is released by S-cells in the duodenum.
Stimulating factors
Secretin secretion is stimulated by:
A low PH (H+) in the duodenum
The presence of products of fat digestion in the duodenum
Inhibitory factors
Secretin release is inhibited by somatostatin.
Action of secretin
Secretin acts to:
Decrease gastric acid secretion by gastric parietal cells
(through inhibition of gastrin release)
Inhibit the gastric emptying.
Stimulate the release of pepsinogen by gastric chief cells.
Stimulate the pancreatic HCO3- secretion.
Potentiate cholecystokinin-induced stimulation of pancreatic
enzyme secretion.
Stimulate HCO3- and H2O secretion by the liver and increase
bile production.
Cholecystokinin (CCK)
CCK is released from I cells of the duodenal and jejunal
mucosa.
Stimulating factors
Cholecystokinin release is stimulated by:
The presence of small peptides and amino acids in the
duodenum
The presence of fatty acids and monoglycerides in the
duodenum
Triglycerides do not stimulate the release of CCK because
they cannot cross intestinal cell membranes.

2/4
Inhibiting factors
The release of cholecystokinin is inhibited by somatostatin.
Action of CCK
Stimulate the pancreatic enzyme secretion.
Stimulate the secretion of pepsinogen from chief cells.
Stimulate the contraction of gall bladder and simultaneously
cause relaxation of the sphincter of Oddi for secretion of bile.
Potentiates secretin-induced stimulation of pancreatic
HCO3- secretion.
Inhibit the Gastric acid production.
Inhibit the gastric emptying, thus meals containing fat
stimulate the secretion of CCK, which slow gastric emptying
to allow more time for intestinal digestion and absorption.
Overview of GIT hormones
Somatostatin
In the gut, somatostatin is secreted from the D-cells in the
gastric and intestinal mucosa. Somatostatin inhibits the
release of all GI Hormones.
In the pancreas, somatostatin is produced by delta cells of
islets of Langerhans.
Somatostatin is secreted by cells throughout the GI tract in
response to H+ in the lumen.
Due to its effect on growth hormone, it is also referred to as
growth hormone inhibiting hormone.
Somatostatin secretion is inhibited by vagal stimulation.

3/4
Somatostatin inhibits the gastric acid secretion both directly
at the parietal cell via a G-protein coupled receptor and
indirectly via inhibition gastrin and histamine secretion.
Action of somatostatin
Inhibit the release of all GI hormone (gastrin, secretin, CCK,
GIP, insulin glucagon)
Decrease gastrin release leading to reduced gastric acid.
Decrease gastric and intestinal secretions.
Decrease bile production and release.
Decrease pancreatic exocrine and endocrine function.
Paracrine inhibition of insulin and glucagon secretion from α
and β -cells of the Islets of Langerhans
Decrease blood glucose concentration.
Previous Next

4/4',
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
    "updated_at" = now();

  -- Lesson: Gastrointestinal Tract
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'gastrointestinal-tract',
    'Gastrointestinal Tract',
    'article',
    '# Gastrointestinal Tract

Gastrointestinal tract
The gastrointestinal tract (GI tract, digestive tract, alimentary
canal) is the tract or passageway of the digestive system that
leads from the mouth to the anus. The GI tract contains all the
major organs of the digestive system, in humans and other
animals, including the esophagus, stomach, and intestines.
Food taken in through the mouth is digested to extract
nutrients and absorb energy, and the waste expelled at the
anus as feces.
The complete human digestive system is made up of the
gastrointestinal tract plus the accessory organs of digestion
(the tongue, salivary glands, pancreas, liver and gallbladder)
Function of GIT
Ingestion of food and water
Mastication
Transport of the food bolus or chyme through the
gastrointestinal tract
Digestion (i.e., breaking food down into nutrients)
Absorption of nutrients and water
Excretion of waste as feces
Immunity

Diet ii Late 2026)
Overview  Comments

1/3
Structures of GI tract:
All segments of the GI tract are divided into four layers (from
innermost to outer most) are:
1.The innermost mucosa composed of:
the epithelial layer (specialized in different parts of the GI
tract for secretion and absorption
the lamina propria (consisting of loose tissue, blood
vessels and lymph tissue)
the muscularis mucosa (contraction causes a change in
the surface area for secretion or absorption)

### 2. The submucosa (containing a second layer of connective

tissue, large blood vessels and lymphatic vessels and
submucosal plexus

2/3
3.The muscularis externa composed of:
The inner circular muscle layer (contraction causes a
decrease in diameter of the lumen of the GI tract)
The outer longitudinal muscle layer (contraction causes
shortening of a segment of the GI tract)
The myenteric plexus which lies between these two layers
of muscle

### 4. The outer most serosa (another connective tissue layer

covered with squamous mesothelial cells)
Previous Next

3/3',
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
    "updated_at" = now();

  -- Lesson: Innervation of Gi Tract
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'innervation-of-gi-tract',
    'Innervation of Gi Tract',
    'article',
    '# Innervation of Gi Tract

Innervation of Gastrointestinal tract
The gastrointestinal tract is innervated by the autonomic
nervous system.
The autonomic system of GI tract comprises both extrinsic
and intrinsic nervous system.
Extrinsic innervation: Parasympathetic and sympathetic
nervous system
Intrinsic innervation: enteric nervous system
Regulated by the autonomic nervous system but can
function independently.
Crucial for gastrointestinal motility and secretion
Meissner and Myenteric plexus

> [!TIP]
> **Clinical pearls:**
> Achalasia cardia:

> Diet ii Late 2026)
> Overview  Comments

> 1/3
> Primary esophageal motility disorder characterized by the
> impaired relaxation of the lower esophageal sphincter (LES)
> and absence of peristalsis in the esophagus. This condition is
> primarily attributed to dysfunction in the myenteric plexus,
> which is a network of nerve fibers and ganglion cells located
> between the circular and longitudinal muscle layers of the
> esophagus.

Previous Next

2/3

3/3',
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
    "updated_at" = now();

  -- Lesson: Iron Handling
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'iron-handling',
    'Iron Handling',
    'article',
    '# Iron Handling

Iron
Iron is a vital trace element for humans, as it plays a crucial role
in oxygen transport, oxidative metabolism, cellular proliferation,
and many catalytic reactions.
Dietary iron, Heme iron: from meat, non-heme iron: from
plants
Ferrous iron (Fe 2+): in hemoglobin
Ferric iron (Fe3+): in methemoglobin
Free iron: Fe2+ can lead to reactive oxygen species via the
Fenton reaction.
H2O2 + Fe2+ →  OH- + Fe3+ + OH (hydroxyl radical) →  oxidative
stress →  DNA damage
Iron absorption in small intestine
Gastric acid leads to low pH and promotes dissolution of iron
in the duodenum.
Absorption occurs in the duodenum and upper jejunum.
The enzyme hepcidin regulates intestinal absorption of iron.
Hepcidin is synthesized in the liver.
It''s the main hormonal regulator of iron homeostasis.
it inhibits the iron release from macrophages in the
reticuloendothelial system and from intestinal epithelial cells
and inhibits intestinal iron absorption.
Hepcidin is decreased by erythropoietin, ineffective
erythropoiesis, pregnancy and hypoxia.
Increased in inflammation and iron overload.
Iron deficiency →  ↓ hepcidin →  ↑ iron absorption
Ferric iron (non-heme iron, Fe3+) is mainly reduced to
ferrous iron (Fe2+) and then absorbed.
Fe2+ is taken across the enterocyte apical membrane by
divalent metal transporter (DMT1)
Vitamin C increases absorption (converts Fe3+ →  Fe2+).
Calcium decreases absorption (due to chelation of iron).
A minority of iron is absorbed as ferric iron (Fe3+).

Diet ii Late 2026)
Overview  Comments

1/3
Heme iron can be directly absorbed into intestinal cells.
Iron transport
Ferroportin (inhibited by hepcidin) transports ferrous iron
(Fe 2+) from the enterocytes to the bloodstream.
The enzyme ferroxidase oxidizes ferrous iron back to ferric
iron (converts Fe2+ →  Fe3+).
Transferrin binds and transports the ferric iron (Fe3+) to the
erythroid precursor cells (in bone marrow) for hemoglobin
synthesis.
Iron storage
Total amount of iron in the body is 3-4 g
Iron is present in the body in two forms:
Functional iron (80%): hemoglobin (largest proportion),
myoglobin, cytochrome enzymes
Storage iron (20%): as Fe3+
Ferritin: hepatocytes, macrophages, enterocyte
Hemosiderin: hepatocytes
Iron recycling
Reticuloendothelial macrophages (in the spleen and liver)
phagocytose senescent RBCs and release iron from
hemoglobin.
Transferrin binds the released iron and transports it to the
bone marrow for erythropoiesis.
Iron loss
Shedding of skin and mucosal epithelial cell →  daily loss of 1-
2 mg of iron

2/3
Any source of bleeding (e.g., menstruation, occult GI bleed)
increases iron loss.
Previous Next

3/3',
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
    "updated_at" = now();

  -- Lesson: Large Intestine
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'large-intestine',
    'Large Intestine',
    'article',
    '# Large Intestine

Large intestine
The large intestine is the terminal portion of the
gastrointestinal tract and is approx. 1.5 m (5 ft) long. The large
intestine is divided into the cecum and appendix, the
ascending colon, transverse colon, descending colon,
sigmoid colon, rectum and anal canal.
The large intestine has 3 primary functions: absorbing water
and electrolytes, producing and absorbing vitamins, and
forming and propelling feces toward the rectum for
elimination. By the time indigestible materials have reached
the colon, most nutrients and up to 90% of the water has
been absorbed by the small intestine.
Motility
The intestinal wall is made up of multiple layers. The 4 layers of
the large intestine from the lumen outward are the mucosa,
submucosa, muscular layer, and serosa. The muscular layer is
made up of 2 layers of smooth muscle, the inner, circular layer,
and the outer, longitudinal layer. These layers contribute to the
motility of the large intestine. There are 2 types of motility
present in the colon, haustral contraction and mass movement.
Haustra are saccules in the colon that give it its segmented
appearance. Haustral contraction is activated by the presence
of chyme and serves to move food slowly to the next haustra,
along with mixing the chyme to help with water absorption.
Mass movements are stronger and serve to move the chyme to
the rectum quickly.
Absorption of water and electrolytes
Absorption of water occurs by osmosis. Water diffuses in
response to an osmotic gradient established by the
absorption of electrolytes. Sodium is actively absorbed in the
colon by sodium channels. Potassium is either absorbed or
secreted depending on the concentration in the lumen and

Diet ii Late 2026)
Overview  Comments

1/3
the electrochemical gradient created by the active
absorption of sodium.
Chloride and bicarbonate - the movement of sodium into the
plasma produces an electrochemical gradient to allow
absorption of chloride. Chloride ions are exchanged for
bicarbonate ions (causing net bicarbonate secretion).
Production/Absorption of Vitamins
The colon houses trillions of bacteria that protect our gut and
produce vitamins. The bacteria in the colon produce
substantial amounts of vitamins by fermentation. Vitamin K
and B vitamins, including biotin, are produced by colonic
bacteria. These vitamins are then absorbed into the blood.
When dietary intake of these vitamins is low in an individual,
the colon plays a significant role in minimizing vitamin
disparity.
Previous Next

2/3

3/3',
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
    "updated_at" = now();

  -- Lesson: Liver
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'liver',
    'Liver',
    'article',
    '# Liver

Liver
Largest gland in the body
Weight: 1.2-1.5 kg in adults (2.6-3.3 pounds)
Wedge-shaped
Consists of four lobes: Right (largest), Left, Quadrate and
Caudate
Typically divided into 8 segments
Surrounded by the hepatic capsule (two layers)
Outer serous layer derived from peritoneum, which covers
the entire liver (except the bare area of the liver)
Fibrous inner layer (the Glisson capsule) that covers the
entire liver (including the bare area of the liver, the hepatic
artery, portal vein, and bile ducts
Porta hepatis structures: Common hepatic duct (leaving),
Hepatic artery proper (entering), Hepatic portal vein
(entering) Hepatic nerve plexus and lymphatic vessels.
Location: Under the diaphragm in the right upper abdomen
Functions of liver
Energy metabolism
Glycolysis
Beta-oxidation
Amino acid degradation
Lipid metabolism
Synthesis
Gluconeogenesis
Production of ketone bodies that provide energy for the
muscles and the brain: fatty acids and amino acids →
acetoacetate + beta-hydroxybutyrate.
Synthesis of plasma proteins (e.g., albumin, globulins,
clotting factors, acute-phase reactants such as ferritin, CRP,
and hepcidin)

Diet ii Late 2026)
Overview  Comments

1/3
Cholesterol biosynthesis
Fatty acid synthesis
Bile acid synthesis
Vitamin D: conversion of vitamin D3 and D2 to 25-OH (which
is subsequently transformed to 1,25-(OH)2, the active form of
vitamin D, in the kidney)
Regulation
Glucose homeostasis
Raise blood glucose via: Glycogenolysis and
Gluconeogenesis
Lower blood glucose via: Glycogen synthesis and Glycolysis
Storage
Glycogen
Lipoproteins
Fat-soluble vitamins (A, K, E, D), folate, and vitamin B12
Iron and copper
Detoxification and clearance/excretion
Urea cycle (amino acid metabolism): Liver produces urea,
which is excreted by the kidneys.
Cytochrome-P450 system involved in detoxification.
Biotransformation: Conversion of lipophilic substances into
water-soluble substances, which can then be eliminated with
the urine or bile.
Breakdown of ethanol
Removal of unconjugated bilirubin (liver conjugates it with
glucuronate and excretes it in bile)
Fetal: Site of erythropoiesis from 6 weeks gestation until
birth
Immunological function: The liver is part of the mononuclear
phagocyte system. Cells involved in immune activity, Kupffer
cells, are found in high numbers in the liver.
Previous Next

2/3

3/3',
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
    "updated_at" = now();

  -- Lesson: Mastication and Swallowing
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'mastication-and-swallowing',
    'Mastication and Swallowing',
    'article',
    '# Mastication and Swallowing

Mouth
The primary function of the mouth is eating, and it has a few
other important functions also.
Functions of mouth include:
Ingestion of food materials
Chewing the food and mixing it with saliva
Appreciation of the taste of the food
Transfer of food (bolus) to the esophagus by swallowing
Role in speech
Social function such as smiling and other expressions
Mastication (chewing)
The process in which food is cut and ground in small pieces
with the help of teeth, is called mastication. It is caused by
chewing reflex.
Chewing reflex
Bolus in the mouth →  reflex inhibition of mastication muscles
→  lower jaw drops →  Strech reflex of jaw muscles →  rebound
contraction of jaw muscles →  closure of teeth- compression of
bolus again against mouth lining →  again reflex inhibition of
mastication muscles →  this cycle repeats again and again.
Importance of chewing
increase the surface area of food particles and thus help their
digestion by enzymes.
grind food to very fine particulate consistency and thus
preventing excoriation of GIT.
increase the ease with which food is emptied from stomach
into small intestine.
Deglutition (swallowing)
Ingested food moves from oral cavity into the stomach by
deglutition.

Diet ii Late 2026)
Overview  Comments

1/3
There are three stages of swallowing: oral, pharyngeal and
esophageal. Oral stage is voluntary the other two are
involuntary.
Oral stage
During this phase, food is chewed and mixed with saliva to
form a food bolus, tongue movements then push this food
bolus upward and backward against the hard palate, forcing
into pharynx.
Pharyngeal stage
Once the bolus has been moved to the pharynx, pressure
receptors are activated in the palate and anterior pharynx.
This signals the swallowing center in the brain stem which
causes:
The base of the tongue retracts, pushing the bolus against
the pharyngeal walls.
Laryngeal muscles contract to close the glottis and elevate
the larynx, closing off the airway.
Inhibition of respiration
The tip of epiglottis covers over tracheal opening, closing off
the airway.
Raises the larynx.
Closes the glottis.
Opens the upper esophageal sphincter.
The soft palate is elevated to close the nasopharynx to allow
passage of food. In addition to this, the true vocal cords close
to prevent aspiration.
After this, the bolus is moved towards the esophagus via
peristalsis of the pharyngeal constrictor muscles. Gravity
makes very little contribution to this process and the main
factors affecting the speed of this are the viscosity and
volume of the bolus.
Esophageal stage
The upper third of the esophagus is voluntary skeletal muscle
and the lower two thirds are involuntary smooth muscle.
At the beginning of this phase, Food bolus is propelled down
the esophagus by peristalsis (a wave of muscular contraction
that pushes the bolus down), the larynx lowers, returning to
its normal position. The cricopharyngeal muscle then
contracts to prevent reflux and respiration begins again.

2/3
Previous Next

3/3',
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
    "updated_at" = now();

  -- Lesson: Saliva
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'saliva',
    'Saliva',
    'article',
    '# Saliva

Saliva
The body produces around 1.5 liters of saliva every day and it
plays a vital role in lubricating food, digestion and protecting
the oral environment.
Function
Saliva has many important roles within the gastrointestinal
system. Not only does it help to lubricate wet food, but it also
begins the digestion of carbohydrates by amylase.
Initial starch digestion by α -amylase (ptyalin) and initial
triglyceride digestion by lingual lipase
Lubrication of ingested food by mucous for bolus formation
and swallowing
Dissolving of chemicals in food allowing them to interact
more efficiently with taste buds.
Protection of the mouth and esophagus by dilution and
buffering of ingested foods
Maintaining an alkaline environment
Secretion of antibacterial enzyme lysozyme
Secretion of IgA to protect against invasion of
microorganisms.
Formation of saliva:
About 1-2 L of saliva is produced per day, and almost all is
swallowed and absorbed.
There are three paired salivary glands that are responsible for
the production of saliva, the submandibular glands, the
sublingual glands and the parotid glands. They are all
ducted, exocrine glands. The structure of each gland is like a
bunch of grapes. The acinus (the blind end of each duct) is
lined with acinar cells and secretes an initial saliva. A
branching duct system is lined with columnar epithelial cells,
which modify the initial saliva. When saliva production is
stimulated, myoepithelial cells, which lines the acinus and
initial ducts, contract and eject saliva into the mouth.

Diet ii Late 2026)
Overview  Comments

1/3
Each of the glands produces a slightly different secretion.
The parotid glands produce serous saliva: a watery secretion
that is rich in enzymes. The secretion from the sub-lingual
glands is known as mucous saliva; a viscous secretion
containing no enzymes and large amounts of mucus. Finally,
the sub-mandibular glands produce a mixed secretion, that
is both serous and mucous.
Composition of saliva
Saliva is hypotonic and alkaline and contains a mixture of both
organic and inorganic constituents. Saliva composition varies
according to rate and site of production, but the main
components are:
Water (99%)
Electrolytes: sodium and chloride ions are usually at a lower
concentration than plasma (hypotonic). Potassium, calcium
and iodide ions are usually at a higher concentration than
plasma (hypertonic)
Bicarbonate: present at a higher concentration than in
plasma to maintain an alkaline environment
Bacteriostats: chemicals that prevent the multiplication of
bacteria. These include lysozymes, lactoferrin,
immunoglobulin A as well as salivary lactoperoxidase.
Mucus- aids to moisten food contents and eases swallowing.
Enzymes: salivary amylase, lingual lipase and kallikrein (helps
to produce bradykinin-> a vasodilator)
Regulation of saliva: The secretion of saliva by each gland is
controlled by two different types of nerves; sympathetic and
parasympathetic nerves.
The parasympathetic outflow is coordinated via centers in the
medulla, and innervation occurs via the facial and
glossopharyngeal nerves. The parasympathetic nerve supply
is most active during the day, whilst eating and creates
waterier, or serous saliva; predominantly produced by the
parotid gland, and partly by the submandibular gland.

2/3
The parasympathetic system turns up the flow of saliva by
releasing a chemical, acetylcholine, which stimulates the
glands to make more saliva. If these glands get diseased,
damaged, or affected by drugs, they may not make enough
saliva, leading to dry mouth.
The sympathetic control of salivary production is via the
superior cervical ganglion. Sympathetic stimulation results in
the release of noradrenaline, which acts upon alpha- and beta-
adrenergic receptors.
The sympathetic nerve supply produces predominantly
thicker mucous saliva mainly by the sublingual and partly the
submandibular glands. This may occur when in certain
situations, fear, stress or anger are aroused. This is also the
case during hard physical exercise.
Saliva production is decrease by inhibition of
parasympathetic nervous system e.g., sleep dehydration
anticholinergic drugs (e.g., atropine)
Previous Next

3/3',
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
    "updated_at" = now();

  -- Lesson: Small Intestine
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'small-intestine',
    'Small Intestine',
    'article',
    '# Small Intestine

Small intestine
The small intestine (small bowel) is a hollow, tubular
structure with an average adult length of 22 feet (7 meters),
making it the longest portion of the gastrointestinal (GI) tract
and where most of the digestion occurs. The small intestine
extends from the stomach pylorus to the ileocecal junction
and is subdivided into three sections: the duodenum,
jejunum, and ileum.
The chyme first enters the duodenum is acidic, hypertonic
and partially digested. There is osmotic movement of water
across the freely permeable wall which leads to the contents
become isotonic, and addition of both bicarbonate from
pancreas and bile from the liver which neutralizes the acidity,
allowing further digestion of chyme performed by addition of
enzymes from the pancreas, liver and intestine itself.
Function of small intestine
Duodenum
Neutralization of acidic chyme
Breakdown of food by digestive pancreatic enzymes and bile
Jejunum and ileum
Absorption of water and nutrients by enterocytes
Glucose and amino acids are co transported with Na+ into
enterocytes.
Water is absorbed along the osmotic gradient created by the
absorption of Na+.
Bile acids emulsify fats to form micelles, which further
breakdown fats into monoglycerides that are then absorbed
by enterocytes.
Most nutrients are absorbed in the jejunum.
Vitamin B12 and bile salts are absorbed in the terminal ileum
(i.e., enterohepatic circulation).
Immunity

Diet ii Late 2026)
Overview  Comments

1/3
Intestinal villi
Finger-like projections of mucosa
Shortest in the duodenum
Tallest in the jejunum
Lined by simple columnar epithelium and the specialized
cells of the small intestine.
Each villus has an arteriole, venule and lymphatic channel at
its core.
Each villus contains a single, blinded ended lymphatic vessel
called a lacteal and also a capillary network, via which
nutrients are absorbed.
Microvilli
Minute projections from the epithelial cells of the villi
Give the small intestinal mucosal surface a "brush border"
appearance.
Have a superficial layer of glycocalyx which contain many
enzymes which are involved in digestion and absorption.
Absorption of water
Most of the water in ingested food and beverages is absorbed
by osmosis.
Approximately 9 L of water is absorbed from GIT tract per
day, most of it from small intestine, especially in the
jejunum, 80% is absorbed by the small intestine, 10% by the
large intestine and the remaining 10% excreted in the feces.
Most absorption of water and electrolytes occurs in the small
intestine, with some water absorbed in the colon as well.
Water absorption is dependent on the absorption of solutes
such as (Na+ and Cl−). Na+ is absorbed from the intestinal
lumen, most use the cotransport with glucose and amino
acids and the Na+/H exchange, which allow Na+ ions to move
from the lumen into the enterocyte. Na+ is rapidly removed
from the enterocyte via the Na+ pumps, allowing water via
osmosis to follow either transcellularly or paracellularly
(between the tight junctions of the enterocytes). Water as
well as Na+ ions can then diffuse into the capillaries.
Previous Next

2/3
3/3',
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
    "updated_at" = now();

  -- Lesson: Stomach
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'stomach',
    'Stomach',
    'article',
    '# Stomach

Stomach
The stomach is a gastrointestinal organ that is responsible for
preliminary digestion and destroying any potential pathogenic
microorganisms that may have been ingested. It is an acidic
environment with a pH that can vary between 1.5-3.5.
The stomach is divided into:
Cardia: the part of the stomach that lies immediately distal to
the gastroesophageal sphincter
Gastric fundus: the dome-shaped region of the stomach just
lateral to the cardia.
Body (stomach): the main portion of the stomach that lies
between the fundus and the pylorus.
Pylorus: the terminal conical narrowing of the stomach that
can be further subdivided into the proximal antrum and the
distal pyloric canal
Function of stomach
Mechanical digestion: peristalsis of the stomach against a
closed pyloric sphincter →  breakdown of food into smaller

Diet ii Late 2026)
Overview  Comments

1/6
particles
Chemical digestion: enzymatic breakdown of food into
chyme (a semifluid mixture of digested food and digestive
enzymes) by gastric acid and enzymes
The stomach act as a reservoir of food (stored food
temporarily) as it is very distensible, when empty it has
volume of 50 ml but it has capacity of up to 3-4 L
Regulate the release of resulting chyme into the small
intestine.
Secrete intrinsic factor which is essential for absorption of
vitamin B12.
Gastric cell types and their secretion
Gastric juice
About 2 L of gastric juice are secreted daily by specialized
secretary in the mucosa it consists of
Gastric acid (HCL)
Mucus
Digestive enzymes
Intrinsic factor
water

### 1. Gastric acid

An acid composed of water, hydrogen, and chloride that is
secreted by parietal cells in the stomach. Its main function is
to:
Maintaining the acidic environment of the stomach.

2/6
Converts pepsinogen to pepsin for chemical digestion (aids
protein digestion).
Provide optimal PH environment for pepsin.
It is a natural defense mechanism against microorganisms.
Stimulate the small intestinal mucosa to release secretin and

## Cck.

Promotes the absorption of Ca+ and Fe+ in small intestine.
Mechanism of gastric acid secretion
Gastric acid is secreted by the parietal cells.
H+/K+-ATPase pump on the apical cell membrane of parietal
cells secretes H+ ions into the lumen.
Carbonic anhydrase in parietal cell cytoplasm converts CO2
into H+ and HCO3-.
Intracellular HCO3- is exchanged for Cl- through the
basolateral membrane.
H+ and Cl- are secreted into the gastric lumen as HCl.
Stimulation of gastric acid secretion
The secretion of HCI is stimulated by:
Vagal stimulation directly through the neurotransmitter
acetylcholine acting at muscarinic (M3) receptors on the
parietal cell.
Indirectly through the neurotransmitter gastrin-releasing
peptide (GRP) stimulating release of gastrin from G cells.
Histamine acting at H2 receptors on the parietal cell
(released from ECL cells in response to vagal activity and
gastrin)
Gastrin released from antral G cells acting at the CCKB
receptor on parietal cells.
Inhibition of gastric acid secretion
The secretion of HCI is inhibited by:
Negative feedback mechanism inhibits the secretion of H+
by parietal cell
Low pH (< 3) in the stomach

3/6
Prostaglandins (inhibit the gastric H+ secretion, maintain the
mucosal barrier and stimulate the HCO3- secretion, thus
protecting the gastric mucosa from damaging effects of H+)
Somatostatin (both directly through inhibition at parietal
cells and indirectly through inhibition of gastrin and
histamine release)
The presence of chyme within the duodenum also stimulates
entero-endocrine cells to release Secretin, Gastric inhibitory
polypeptide (GIP and Cholecystokinin
Vagotomy eliminates both direct and indirect pathways.
Drugs i.e., H2-receptor blockers e.g., cimetidine, Proton pump
inhibitors e.g., omeprazole and Muscarinic receptor
antagonists e.g., atropine
Mucus: Gastric mucus is a gel-mucous barrier secreted by
epithelial cells and glandular cells in the stomach wall. It acts
as part of a barrier that protects the stomach wall from the acid
and digestive enzymes within the stomach lumen. This barrier
is also made up of a bicarbonate secretion and the epithelial
cells themselves, which are tightly joined together. Together,
these components prevent the stomach from effectively
digesting itself.
Digestive enzyme: Pepsin is the main gastric enzyme. It is
produced by the stomach cells called "chief cells" in its inactive
form pepsinogen, which is a zymogen. Pepsinogen is then
activated by the stomach acid into its active form, pepsin.
Pepsin breaks down the protein in the food into smaller
particles, such as peptide fragments and amino acids. Protein
digestion, therefore, primarily starts in the stomach, unlike
carbohydrate and lipids, which start their digestion in the
mouth.
Gastric lipase is an acidic lipase secreted by the gastric chief
cells in the fundic mucosa of the stomach.
Intrinsic factor: The intrinsic factor is produced by parietal cells
and is essential for vitamin B12 absorption.
Motor functions of stomach (storage,
mixing, and slow emptying)

4/6
The mixing of the food with gastric secretions takes place in
the distal body and antrum of the stomach where the
muscularis externa layer is thicker. The stomach has an
additional inner oblique smooth muscle layer (in addition to
the inner circular layer and outer longitudinal layer), allowing
peristaltic contractions and thorough mixing. Gastric
contractions are increased by vagal stimulation and decreased
by sympathetic stimulation.
Factors influencing gastric emptying:
The presence of chyme in the pyloric antrum distends it and
causes antral contractions and opening of the pyloric sphincter.
Gastric emptying varies with different food types:
carbohydrates are emptied more quickly, proteins more slowly
and fatty foods even more so, liquids empty more rapidly than
solid foods.
Factors that promote gastric emptying
Gastrin (increases stomach contractility)
Distension of pyloric antrum
Parasympathetic stimulation
Factors that inhibit gastric emptying
(There are osmoreceptors and chemoreceptors in the
duodenal wall; they respond to physical properties and
chemical composition of the duodenal contents and evoke
enterogastric reflexes which are inhibitory.)
Hypertonic fluids in duodenum: (Osmoreceptors in
duodenum -> sense tonicity of chyme --> evoke
enterogastric reflex --> gastric emptying inhibited, so that
the tonicity of the contents can be normalized before they
can escape into duodenum)
Irritation of duodenal mucosa: (if a poisonous substance
reaches the duodenum, it may be absorbed into blood.to
prevent its absorption, chemoreceptor in duodenum initiate
enterogastric reflex and inhibit the gastric emptying
Acidic chyme (pH < 3.5) in duodenum: (pH sensed by "S" cells
in duodenum --> release secretin --> secretin causes
contraction of pyloric sphincter --> gastric emptying
slowed/inhibited, so that the pH of the contents can be
optimized.

5/6
Fat/protein breakdown products in duodenum: fat is the
most potent inhibitor of gastric emptying (acting via
CCK); Entry of fats in duodenum -> release of CCK from "I"
cells -> CCK decreases gastric motility and thus prevents or
retards gastric emptying, so that the ingested fats enter
slowly and in small amounts into duodenum.)
Hormones CCK, secretin, gastric inhibitory peptide (GIP) all
cause constriction of pyloric sphincter, hence slow gastric
emptying.
Previous Next

6/6',
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
    "updated_at" = now();

  -- Lesson: Summary of Harmones and Secretion of GIT
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'summary-of-harmones-and-secretion-of-git',
    'Summary of Harmones and Secretion of GIT',
    'article',
    '# Summary of Harmones and Secretion of GIT

Diet ii Late 2026)
Overview  Comments

1/3
Summary of hormones and
secretion of git
Gastric secretory and Regulatory
products
Small intestine regulatory products:
Previous Next

2/3
3/3',
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
    "updated_at" = now();

  -- Lesson: Vitamins Overview
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'vitamins-overview',
    'Vitamins Overview',
    'article',
    '# Vitamins Overview

Vitamins
Previous Next

Diet ii Late 2026)
Overview  Comments

1/3

2/3

3/3',
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
    "updated_at" = now();

  -- ==========================================
  -- Module 6: Endocrine Physiology & Metabolism
  -- ==========================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Endocrine Physiology & Metabolism' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Endocrine Physiology & Metabolism', 5, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 5, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Adrenal Gland
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'adrenal-gland',
    'Adrenal Gland',
    'article',
    '# Adrenal Gland

Adrenal gland
Adrenal glands are paired of endocrine glands located on the
superior pole of each kidney. they are composed of an inner
medulla and an outer cortex, which is turn divided in to three
zones.
The adrenal medulla is composed of chromaffin cells, which
synthesize and secrete catecholamines (i.e., epinephrine, nor-
epinephrine).
The adrenal cortex has three zones, responsible for the
synthesis of three different types of steroids.
Zona glomerulosa = outermost zone; synthesizes
mineralocorticoid (Aldosterone)
Zona fasciculata = middle zone; synthesizes glucocorticoid
(cortisol)
Zona reticularis = innermost zone; synthesizes sex steroids
(Estrogens & Androgens)
Hypothalamic-Pituitary-Adrenal Axis:
Corticotropin releasing hormone (CRH) is produced by
hypothalamus.
CRH stimulates anterior pituitary to produce
adrenocorticotropin hormone (ACTH)
ACTH acts on all zones of adrenal cortex increasing steroid
hormone synthesis.
Cortisol inhibits the secretion of CRH from hypothalamus
and secretion of ACTH from anterior pituitary in a negative-
feedback pattern.
Aldosterone is under tonic control by ACTH but is separately
regulated by the renin-angiotensin system and by potassium.
Previous Next

Diet ii Late 2026)
Overview  Comments

1/3
2/3

3/3',
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
    "updated_at" = now();

  -- Lesson: Adrenal Insufficiency
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'adrenal-insufficiency',
    'Adrenal Insufficiency',
    'article',
    '# Adrenal Insufficiency

Adrenal Insufficiency
Adrenal insufficiency is a failure of the adrenal glands to
produce adequate amounts of adrenocortical hormone. It
can be primary, secondary or tertiary.
Primary adrenal insufficiency (Addison disease): refers to
chronic, primary adrenocortical insufficiency (Adrenal cortex)
which leads to
↓ Glucocorticoids, androgen and ↓ mineralocorticoid
↑ ACTH (low cortisol levels stimulate ACTH secretion)
Causes:
Autoimmune: (autoimmune adrenalitis), which has been
identified to be the cause of 80-90% of primary adrenal
insufficiency
Congenital: e.g., congenital adrenal hyperplasia
Infection: e.g., tuberculosis, AIDS, CMV, histoplasmosis
Iatrogenic: bilateral adrenalectomy, Drugs
Vascular: e.g., hemorrhage from sepsis, adrenal vein
thrombosis, hypercoagulable states such as heparin-induced
thrombocytopenia and antiphospholipid syndrome
Neoplasia: e.g., adenoma (tumor) of the adrenal gland
Deposition disease: e.g., hemochromatosis, amyloidosis,
sarcoidosis
Idiopathic
Symptoms
Weakness and fatigability
Orthostatic hypotension
Nausea, vomiting, diarrhea, anorexia, and weight loss
Skin hyperpigmentation (low cortisol levels stimulate ACTH
secretion, ACTH contains the melanocyte stimulating
hormone fragment): Dark skin.
Bluish-black color around the nipples, mouth, rectum,
scrotum, or vagina
Fluid loss (dehydration)
Low blood pressure
In women, irregular or no menstrual periods
Pubic and axillary hair in women (caused by deficiency of
adrenal androgens)
Electrolyte abnormalities:   (High Yield)
Hyperkalemia
Hyponatremia
Metabolic acidosis
Hypoglycemia (caused by cortisol deficiency)
Diagnosis:
Short ACTH-stimulation Test:  It involves administration of 250
µg ACTH by IM injection at any time of day.
Normal = cortisol increase> 500 nmol/1 (> 18 µg/dL)
Overview  Comments

1/3
Adrenal insufficiency = cortisol fails to increase (both primary
& secondary)
Primary adrenal insufficiency will have High ACTH.
Secondary adrenal insufficiency will have Low ACTH.
Treatment:
Primary adrenal insufficiency:
Glucocorticoid = hydrocortisone (cortisol) is the drug of
choice.
Mineralocorticoid = fludrocortisone
Androgen replacement therapy may be recommended for
woman.
The goal of treatment is to stabilize hormone levels and
relieve symptoms.
Complication
Adrenal Crisis:
Addisonian crisis is a life-threatening situation, refers to a
severe episode of Addison''s disease associated with:
Hypotension, Hyponatremia, hyperkalemia,
hypoglycemia Dehydration
pale, cold, clammy skin
sweating
rapid, shallow breathing, dizziness
pigmentation
severe diarrhea and vomiting
abdominal pain, fatigue and severe muscle weakness
headaches
severe drowsiness or loss of consciousness
Often with precipitating infection, trauma, or operation
Treatment: (Needs urgent medical attention)
The 5 S''s of adrenal crisis treatment are Salt (0.9% saline.),
Sugar (50% dextrose) Steroid (100mg hydrocortisone IV once,
then 200mg over 24 hours), Support (normal saline to
hypotension and electrolyte abnormalities), and Search (for the
underlying
disorder)
Secondary adrenal insufficiency
This starts when the pituitary gland doesn''t make enough of
the hormone ACTH (adrenocorticotropin). As a result, the
adrenal glands don''t make enough cortisol. A lack of the
hormone ACTH leads to secondary adrenal insufficiency. That
can happen if a patient must take certain steroids for a long
time due to a health problem. Other causes include:
Pituitary gland tumors
Loss of blood flow to the pituitary (postpartum pituitary
necrosis)
Pituitary gland is removed, or radiation treatment of the
pituitary gland.

2/3
Hypothalamic tumors
Treatment
Only glucocorticoid.
Mineralocorticoid (Aldosterone) is not given as it is not
ACTH-dependent.
Primary v/s Secondary Adrenal insufficiency:
In contrast to Addison''s disease (primary adrenal
insufficiency), secondary adrenal insufficiency is
characterized by:
Decreased pituitary secretion.
No skin hyperpigmentation (because there is deficiency of

## Acth)

no hyperkalemia or metabolic acidosis (because aldosterone
levels are normal)
Previous Next

3/3',
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

  -- Lesson: Adrenal Medulla and Pheochromocytoma
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'adrenal-medulla-and-pheochromocytoma',
    'Adrenal Medulla and Pheochromocytoma',
    'article',
    '# Adrenal Medulla and Pheochromocytoma

Adrenal medulla
The adrenal medulla is composed of chromaffin cells, which
synthesize and secrete catecholamines epinephrine and nor-
epinephrine (adrenaline and noradrenaline) but also has other
secretory functions such as the production of dopamine. Both
adrenaline and noradrenaline are produced from the amino
acid tyrosine, through multiple reactions.
Catecholamine function
Mechanism: Catecholamines bind to various adrenergic
receptors (see table below) located on different organs and
tissues. Binding triggers tissue-specific responses. This leads to
sympathetic activation to prepare the human body for a fight-
or-flight reaction.

Diet ii Late 2026)
Overview  Comments

1/3
Pheochromocytoma
Pheochromocytoma is a type of neuroendocrine tumor that
grows from cells called chromaffin cells. These cells produce
hormones needed for the body and are found in the adrenal
glands. About 80-85% of pheochromocytomas grow in the
inner layer of the adrenal gland, called the adrenal medulla.
Signs and symptoms
characteristic feature of pheochromocytoma is hypertension.
This type of hypertension is known as endocrine or secondary
hypertension.
headache, chest pain
tachycardia, tremors, weight loss, fever
profuse sweating, Pallor, blur vision
Hyperglycemia
nausea, vomiting, constipation
Diagnosis:
Pheochromocytoma is detected by measuring meta-nephrines
and vanillylmandelic acid (breakdown products of epinephrine
and norepinephrine) in urine and catecholamines in plasma.
Treatment:
Definitive treatment is by surgical resection of the tumor.
Prior to surgery, acute crises are treated medically to control
the effects of excess catecholamines.
Medical therapy consists of:
Alpha blocker (phenoxybenzamine), followed by
Beta blocker (propranolol). Beta adrenoceptor blockade can
be instituted to control tachycardia.
Beta blockers must never be given before alpha-blocker as
this may cause a paradoxical rise in blood pressure due to
unopposed a-mediated vasoconstriction.
Previous Next

2/3
3/3',
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

  -- Lesson: Aldosterone
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'aldosterone',
    'Aldosterone',
    'article',
    '# Aldosterone

Aldosterone
Aldosterone is the main mineralocorticoid steroid hormone
produced by the zona glomerulosa of the adrenal cortex in the
adrenal gland. It is essential for sodium conservation in the
kidney. It plays a central role in the homeostatic regulation of
blood pressure, plasma sodium (Na+), and potassium (K+)
levels.
Aldosterone release is stimulated by

## Acth

Angiotensin II
Hyperkalemia
Aldosterone release inhibited by
Hypokalemia
Inhibitors of renin angiotensin system (ACE, ARBs)
Dopamine and ANP
Mechanism of action: aldosterone binds to intracellular
mineralocorticoid receptors in the distal tubule and collecting
duct of the kidney, inducing protein synthesis and following
changes:
↑ Na+/K+-ATPase in the basolateral membrane →
transportation of Na+ out and K+ into the tubule cells
↑ Apical H+-ATPase →  H+ excretion
↑ Na+ channels (ENaC; epithelial sodium channel) →  ↑ Na+
reabsorption
↑ K+ channels (ROMK; renal outer medullary potassium
channel) in the luminal membrane →  ↑ K+ excretion
Effects
This aldosterone induced changes produce a concentration
gradient →  Na+ reabsorption →  water reabsorption and K+
secretion into the urine.

Diet ii Late 2026)
Overview  Comments

1/3
Ultimately, these effects →  ↑ blood pressure, hypokalemia
and ↑ pH level
Previous Next

2/3

3/3',
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

  -- Lesson: Antidiuretic Harmone
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'antidiuretic-harmone',
    'Antidiuretic Harmone',
    'article',
    '# Antidiuretic Harmone

Antidiuretic hormone (ADH)
Antidiuretic hormone (ADH), also known as vasopressin, is a
small peptide hormone which regulates the body''s retention
of water. The synthesis of ADH occurs in the supraoptic and
paraventricular nuclei in the hypothalamus. It is then
transported to the posterior pituitary gland via the
neurohypophysial capillaries.
ADH regulates the blood pressure (v1 receptors) and serum
osmolality (v2 receptor). The primary function is serum
osmolality regulation (ADH decreases serum osmolality and
increases urine osmolality) via regulation of aquaporin
channel insertion in principal cell of renal collecting duct.
Regulation of plasma osmolality
Mediated by V2 receptors.
Insertion of aquaporin channels in the principal cells of the
renal collecting duct and DCT
Results in increased water reabsorption
Regulation of blood pressure
Mediated by V1 receptors.
Vasoconstrictive effects at higher levels
Increase reabsorption of urea in the collecting duct,
increases the corticomedullary gradient and facilitates urine
concentration.
ADH release is inhibited by atrial natriuretic peptide
(ANP), which is released by stretched atria in response to
increases in blood pressure, as well as alcohol and certain
medications.
Regulation of ADH secretion

Diet ii Late 2026)
Overview  Comments

1/3
Clinical relevance
Elevated in SIADH despite plasma hypoosmolality.
ADH deficiency or resistance can lead to diabetes insipidus.
Alcohol inhibits ADH release and causes diuresis.
Previous Next

2/3

3/3',
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

  -- Lesson: Calcitonin
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'calcitonin',
    'Calcitonin',
    'article',
    '# Calcitonin

Calcitonin:
calcitonin is secreted by parafollicular (cells) of thyroid
gland. Calcitonin is secreted in response to high levels of
plasma calcium ions and acts to lower circulating levels of
calcium. Calcitonin acts to decrease serum calcium
concentrations in several ways.
It inhibits the activity of the osteoclasts in bone tissue,
thereby preventing the resorption (breakdown) of bone, and
inhibits the reabsorption of calcium by the cells of the kidney,
resulting in increased calcium excretion in the urine. The
effects of calcitonin counter the effects of parathyroid
hormone that acts to increase serum calcium concentration.
Previous Next

Diet ii Late 2026)
Overview  Comments

1/3

2/3

3/3',
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

  -- Lesson: Calcium Homeostasis
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'calcium-homeostasis',
    'Calcium Homeostasis',
    'article',
    '# Calcium Homeostasis

Calcium homeostasis
The physiological role of
calcium
Ionized Ca2+ is responsible for stabilizing the resting
membrane potential of cells.
↓ Serum Ca2+ →  ↑ membrane excitability
↑ Serum Ca2+ →  ↓ membrane excitability
Acts as a second messenger in signaling pathways.
Cofactor for several enzymes (e.g., phospholipase A, gamma-
glutamyl transferase)
Required for the promotion of coagulation pathways.
Total and ionized calcium concentrations
Total calcium: the total amount of calcium circulating in the
serum, comprising protein-bound, anion-bound, and ionized
calcium.
Approx. 40% of the total serum calcium is bound to
proteins (mostly albumin) and is physiologically inactive.
Hypoproteinemia (due to, e.g., nephrotic syndrome, liver
cirrhosis, severe malnutrition, malabsorption) →  ↓ total Ca2+
level but ionized Ca2+ level is unaffected →  factitious
hypocalcemia.
pH influences the binding of calcium to serum proteins.
↑ pH →  ↓ H+ in serum binding to proteins →  ↑ Ca2+ binding
to proteins →  ↓ ionized Ca2+ concentration compensatory ↑
PTH
↓ pH →  ↑ H+ in serum binding to proteins →  ↓ Ca2+ binding
to proteins →  ↑ ionized Ca2+ concentration compensatory ↓
PTH

Diet ii Late 2026)
Overview  Comments

1/3
Ionized calcium: the calcium fraction that is not bound to
any proteins but is physiologically active 45% of the total
serum calcium.
Functions as the main regulator of PTH secretion
Excess causes true hypercalcemia whereas deficiency
causes true hypocalcemia.
Previous Next

2/3

3/3',
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
    "updated_at" = now();

  -- Lesson: Cartisol
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cartisol',
    'Cartisol',
    'article',
    '# Cartisol

Cortisol
Cortisol is one of the major glucocorticoids synthesized in the
zona fasciculata of the adrenal cortex. Cortisol secretion is
regulated by the hypothalamic hormone CRH, and the pituitary
hormone ACTH, in the hypothalamus-pituitary-adrenal axis.
Cortisol is known as stress hormone involved in the response
to physical and/or emotional stress.
Function
↑ Increase appetite
Increase Blood pressure (. at high concentration, can bind to
mineralocorticoid (aldosterone) receptors.
Increase Insulin resistance (diabetogenic)
Increases Gluconeogenesis, Lipolysis, and Proteolysis
↓ Glucose utilization
↓ Fibroblast activity (poor wound healing,
↓ collagen synthesis
↑ striae
↓ Inflammatory and Immune response
Inhibit WBC adhesion Neutrophilia.
Blocks histamine release from mast cells
Decrease Bone formation.
Decrease osteoblastic activity.
Regulation
CRH (hypothalamus) stimulates ACTH release (pituitary) →
cortisol production in adrenal zona fasciculata. Excess cortisol
↓ CRH, ACTH, and cortisol secretion by negative feedback
mechanism
Previous Next

Diet ii Late 2026)
Overview  Comments

1/3
2/3

3/3',
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
    "updated_at" = now();

  -- Lesson: Cushing Syndrome
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cushing-syndrome',
    'Cushing Syndrome',
    'article',
    '# Cushing Syndrome

Cushing syndrome
It is a disorder caused by any condition that produces
excessive glucocorticoids (cortisol). While the term "Cushing
syndrome" can be applied to any cause of hypercortisolism,
"Cushing disease" refers specifically to secondary
hypercortisolism that results from excessive production of
ACTH by pituitary adenomas.
causes
Iatrogenic Cushing''s syndrome (most common cause)
caused by exogenous administration of glucocorticoids.
Endogenous: Cushing''s disease (i.e., Cushing''s syndrome
secondary to pituitary tumor): Pituitary adenoma ACTH
secretion →  bilateral adrenal gland hyperplasia →  increases
cortisol secretion
Adrenal tumors: adrenal adenoma & adrenal carcinoma
Ectopic ACTH production
Small cell lung cancer
Clinical features
Thin, easily bruisable skin with ecchymoses
Strech marks (purple abdominal striae)
Hirsutism
Acne
Delayed wound healing.
Anxiety, irritability, Lethargy, fatigue, Sleep, disturbance,
Memory deficits, Depression, Psychosis
Osteopenia, osteoporosis, pathological fractures, avascular
necrosis of the femoral head
Endocrine and metabolic effects: Insulin resistance →
hyperglycemia
Dyslipidemia
Weight gain characterized by central obesity, moon facies,
and a dorsocervical fat pad (buffalo hump)

Diet ii Late 2026)
Overview  Comments

1/3
♂ : Decreased libido
♀ : Decreased libido, virilization, and/or irregular menstrual
cycles (e.g., amenorrhea)
Growth delay (in children)
Note: In Cushing disease: often hyperpigmentation (darkening
of the skin due to an overproduction of melanin), especially in
areas that are not normally exposed to the sun (e.g., palm
creases, oral cavity) Overproduction of melanin Caused by
excessive ACTH production because melanocyte-stimulating
hormone (MSH) is cleaved from the same precursor as ACTH
called proopiomelanocortin (POMC)
Treatment
First-line treatment: tumor resection (Life-long
glucocorticoid + mineralocorticoid replacement after
surgery)
Second-line or adjunctive therapy: pharmacological
treatment

2/3
Previous Next

3/3',
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
    "updated_at" = now();

  -- Lesson: Diabetes Insipidus and Siadh
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'diabetes-insipidus-and-siadh',
    'Diabetes Insipidus and Siadh',
    'article',
    '# Diabetes Insipidus and Siadh

Diabetes insipidus (DI):
It is a condition characterized by inability to produce
concentrated urine due to ADH dysfunction, It is of two types:
Central Diabetes Insipidus (CDI)
Nephrogenic Diabetes Insipidus (NDI)
Central Diabetes insipidus
It is due to deficiency of ADH. It may be caused by:
Head trauma
Tumors of hypothalamus
Inflammation of hypothalamus
Craniopharyngioma
Nephrogenic Diabetes insipidus It is due to
unresponsiveness (resistance) of collecting tubules to ADH. It
may be caused by:
Lithium
Demeclocycline
Hypokalemia, hypercalcemia
Nephrocalcinosis
Diagnosis
CDI = ADH level is low
NDI = ADH level is high
Decreased urine osmolality: excretion of large volumes of
dilute urine (<300 m0sm/kg)
Increased serum osmolality (>295 m0sm/kg)
Increased serum sodium (hypernatremia), which results in:
Excessive thirst and polydipsia.
Neurologic features like confusion, disorientation, seizures
An ADH stimulation test can distinguish between cranial and
nephrogenic DI, as nephrogenic DI shows an inability to

Diet ii Late 2026)
Overview  Comments

1/3
concentrate urine even after administration of synthetic

## Adh.

Treatment
Central DI = Desmopressin (ADH analogue)
Nephrogenic DI.
Correct potassium and calcium
Stop offending drugs.
Thiazide diuretics (e.g., Bendroflumethiazide or amiloride)
NSAIDs
Syndrome of Inappropriate ADH Secretion (SIADH)
It is characterized by persistent ADH release independent of
serum osmolality.
It causes reabsorption of excess amounts of free water.
Causes:
small cell carcinoma of lung (most common)
Sarcoidosis
CNS injury
Tuberculosis
Drugs (anti-depressants, anti-psychotics)
Diagnosis:
Increased urine osmolality (> 100 mOsm/kg)
Decreased serum osmolality (< 275 mOsm/kg)
Decreased serum sodium (hyponatremia).
urinary sodium excretion > 40 mmol/L
Hyponatremia presents entirely with CNS symptoms
Lethargy; confusion, disorientation, seizures
Treatment:
Fluid restriction is the cornerstone of SIADH treatment.
Demeclocycline: ADH receptor antagonist.
Previous Next

2/3

3/3',
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
    "updated_at" = now();

  -- Lesson: Endocrine Glands and Their Harmones
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'endocrine-glands-and-their-harmones',
    'Endocrine Glands and Their Harmones',
    'article',
    '# Endocrine Glands and Their Harmones

Endocrine System
Introduction: All the physiological activities of the body are
regulated. by two major systems

### 1. Nervous system

### 2. Endocrine system.

Endocrine glands: Endocrine glands are glands which
synthesize and release classical hormones into the blood.
Endocrine glands are also called ductless glands because the
hormones secreted by them are released directly into blood
without any ducts. Endocrine glands are distinct from exocrine
glands which release their secretions through ducts. Endocrine
glands play an important role in homeostasis and control of
various other activities in the body through their hormones.

Diet ii Late 2026)
Overview  Comments

1/4
Endocrinology hormones overview:
Harmons secreted by adrenal gland:

2/4
Hormone secreted by Gonads.
Hormone secreted by other organs.

3/4
Previous Next

4/4',
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
    "updated_at" = now();

  -- Lesson: Hyperaldosteronism and Renal Insufficiency
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'hyperaldosteronism-and-renal-insufficiency',
    'Hyperaldosteronism and Renal Insufficiency',
    'article',
    '# Hyperaldosteronism and Renal Insufficiency

Hyperaldosteronism
It is a small group of disorders characterized by excessive
secretion of aldosterone (mineralocorticoid).
It is classified into primary and secondary
hyperaldosteronism.
Primary Hyperaldosteronism
It refers to hyperaldosteronism associated with HIGH
aldosterone and LOW renin.
Causes
Aldosterone-secreting adenoma (Conn Syndrome)
Adrenocortical carcinoma
Familial hyperaldosteronism.
Diagnosis:
Hypertension
Headache, muscle weakness
Polyuria, polydipsia; no peripheral edema
Lab Findings:
Hypernatremia (elevated serum sodium)
Hypokalemia
Metabolic alkalosis
Elevated aldosterone and decreased plasma renin.
Plasma aldosterone: renin ratio > 20.
Sodium suppression test = fails to suppress aldosterone after
sodium load.
Treatment
Spironolactone:  It is an aldosterone antagonist used to
normalize whole-body electrolyte balance
Followed by surgical removal (adrenalectomy) which is
definitive treatment.
Secondary Hyperaldosteronism
It refers to hyperaldosteronism associated with HIGH
aldosterone and HIGH renin.
Causes:
Renal artery stenosis
Congestive heart failure
Cirrhosis
Nephritic syndrome
Pregnancy (estrogen increases renin substrate)
Renin-secreting renal
tumor
Overview  Comments

1/2
Lab Findings:
Elevated aldosterone
Elevated plasma renin
Treatment:
Spironolactone
Previous Next

2/2',
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
    "updated_at" = now();

  -- Lesson: Hypothyroidism and Hyperthyroidism
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'hypothyroidism-and-hyperthyroidism',
    'Hypothyroidism and Hyperthyroidism',
    'article',
    '# Hypothyroidism and Hyperthyroidism

Hypothyroidism and
Hyperthyroidism:

Diet ii Late 2026)
Overview  Comments

1/3

2/3
Note: Propranolol is the preferred agent in hyperthyroidism
and thyroid storm due to its additional effect of blocking the
peripheral conversion of inactive T4 to active form T3. They are
highly effective for symptomatic relief (tachycardia, tremors)
Previous Next

3/3',
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
    "updated_at" = now();

  -- Lesson: Insulin and Glucagon
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'insulin-and-glucagon',
    'Insulin and Glucagon',
    'article',
    '# Insulin and Glucagon

Insulin
Insulin is a polypeptide hormone secreted by the β  cells of
the pancreatic islets of Langerhans, containing an A chain
and a B chain joined by disulfide bridges.
Proinsulin is synthesized as a single chain peptide. Within
storage granules, a connecting peptide (c peptide) is
removed by proteases to yield insulin. The c peptide is
packaged and secreted along with insulin, and its
concentration is used to monitor beta cell function in
diabetic patients who are receiving exogenous insulin
Regulation of insulin secretion
Glucose is a major factor that regulates insulin secretion.
Insulin is released from the beta cells primarily in response to
the elevated blood glucose levels and increased
parasympathetic stimulation associated with digestion of a
meal. Increased blood levels of certain amino acids also
stimulate insulin secretion.
Decreased insulin secretion results from decreasing blood
glucose levels and from stimulation of the pancreas by the
sympathetic division of the nervous system, which occurs
during physical activity. Decreased insulin levels allow blood
glucose to be conserved to provide the brain with adequate
glucose and to allow other tissues to metabolize fatty acids
and glycogen stored in the cells.

Diet ii Late 2026)
Overview  Comments

1/4
Function of insulin
Insulin can be considered the "anabolic"or building hormone it
assists processes that build compounds for storage and
decrease processes that break down those storage reserves.
In muscle and liver, insulin increases glycogenesis and
decreases glycogenolysis.
Decreased gluconeogenesis in the liver.
Increased glycolysis in liver and adipose tissue.
Decreased the breakdown of amino acids in the liver.
Increased amino acid uptake and protein synthesis in
muscle, liver, and adipose tissue (decrease blood amino acid
concentration)
Decreased lipolysis (decrease blood fatty acid and ketoacid
concentration)
Increased lipogenesis and esterification of fatty acids in the
liver and adipose tissue.
insulin increase K+ uptake into cells, thereby decreasing
blood K+
Glucagon
Glucagon is produced by α  cells, located peripherally with in
islets of Langerhans, in the endocrine tissue of pancreas.
Regulation of glucagon secretion
The major factor that regulates glucagon secretion is the
blood glucose concentration. Decreased blood glucose
stimulates glucagon secretion.

2/4
Increased blood amino acids stimulate glucagon secretion,
which prevents hypoglycemia caused by unopposed insulin
in response to a high protein meal.
Regulation of glucagon secretion
Function of glucagon
Glucagon acts on the liver and adipose tissue.
The second messenger for glucagon is CAMP.
Effects of Glucagon:
Increased glycogenolysis
Decreased glycogenesis.
Increased gluconeogenesis
Increased ketogenesis
increases lipolysis in adipose tissue.
Difference between Insulin and Glucagon

3/4
Previous Next

4/4',
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
    "updated_at" = now();

  -- Lesson: Pancreas
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'pancreas',
    'Pancreas',
    'article',
    '# Pancreas

Pancreas
The pancreas is a retroperitoneal, abdominal organ found
posterior and inferior to the stomach The pancreas has two
essential and very important functions in the body:
endocrine (production of hormones that regulate blood
sugar levels and glandular secretion) and exocrine (the
function of the digestive gland).
Endocrine activity is performed by the Langerhans islets and
involves the production of hormones. The Islets of
Langerhans contain the following cell types, each of which
produce different endocrine hormone.
Previous Next

Diet ii Late 2026)
Overview  Comments

1/3

2/3

3/3',
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
    "updated_at" = now();

  -- Lesson: Parathyroid Harmone
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'parathyroid-harmone',
    'Parathyroid Harmone',
    'article',
    '# Parathyroid Harmone

Parathyroid hormone (PTH)
Parathyroid hormone is secreted from chief cells of
parathyroid gland which is located immediately behind the
thyroid gland.
It is a major hormone for regulation of serum calcium.
Regulation pf PTH
PTH secretion is stimulated by:
Decrease in serum Ca2+
Hyperphosphatemia
Low calcitriol levels
PTH secretion is inhibited by:
Increase in serum Ca2+
Decrease in serum phosphate.
hypomagnesemia
Action of PTH
Are coordinated to produce an increase serum (Ca+) and
decrease in serum phosphate.
the second messenger for PTH actions on its target tissue
is cAMP.
Bone: PTH increases bone resorption, which brings both Ca²+
and phosphate from bone mineral into the ECF (Stimulate
the osteoclast cells)
kidney
Increases Ca2+ reabsorption in the distal tubule.
Decreases phosphate reabsorption in the proximal
convoluted tubules.
Increases active vitamin D (calcitriol) production via
stimulation of 1-alpha-hydroxylase synthesis in the kidneys.
GIT

Diet ii Late 2026)
Overview  Comments

1/3
PTH increases intestinal Ca+ and phosphate absorption,
indirectly by stimulating the production of 1,25-
dihydroxycholecalciferol in the kidney.
Previous Next

2/3

3/3',
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
    "updated_at" = now();

  -- Lesson: Pituitary Gland
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'pituitary-gland',
    'Pituitary Gland',
    'article',
    '# Pituitary Gland

Pituitary gland
The pituitary endocrine gland, which is located in the bony
Sella turcica, is attached to the base of the brain and has a
unique connection with the hypothalamus. The pituitary gland
consists of two anatomically and functionally distinct regions,
the anterior lobe (adenohypophysis) and the posterior lobe
(neurohypophysis).
The pituitary gland is connected to the hypothalamus through
a stalk of blood vessels and nerves (the pituitary stalk). Through
that stalk, hypothalamus communicates with the anterior
pituitary lobe via hormones and the posterior lobe through
nerve impulses. The hypothalamus also creates oxytocin and
antidiuretic hormone and tells posterior pituitary when to store
and release these hormones. hypothalamus makes the
following hormones to communicate with and stimulate
pituitary gland:
Corticotrophin-releasing hormone (CRH).
Dopamine.
Gonadotrophin-releasing hormone (GnRH).
Growth hormone-releasing hormone (GHRH).
Somatostatin.
Thyrotropin-releasing hormone (TRH).
Since your pituitary gland and hypothalamus work together so
closely, if one of them becomes damaged, it can affect the
hormonal function of the other.
Anterior lobe of pituitary
gland
The anterior pituitary is derived from oral ectoderm (Rathke''s
pouch). The anterior lobe of pituitary gland is linked to
hypothalamus by the hypothalamic-pituitary hypophysial

Diet ii Late 2026)
Overview  Comments

1/3
portal system. Thus, blood from hypothalamus that contain
high concentration of hypothalamic hormone is delivered
directly to the anterior pituitary. Hypothalamic hormone (e.g.,
growth hormone releasing hormone GHRH) then stimulate or
inhibit the anterior pituitary hormone (e.g., growth hormone
GH)
The following hormone secreted from anterior pituitary gland:
Follicle-stimulating hormone (FSH
Luteinizing hormone (LH)
Prolactin
Growth hormone

## (Gh)

Adrenocorticotropin (ACTH)
Thyroid stimulating hormone (TSH)
Anterior pituitary hormone
Posterior pituitary gland (neurohypophysis)
The posterior lobe of pituitary gland arises from an evagination
of neuroectoderm from diencephalon. It stores and releases
vasopressin (antidiuretic hormone or ADH) and oxytocin,
both made in hypothalamus (supra optic nuclei and
paraventricular nuclei) and transported to posterior pituitary
via neurophysins (carrier protein)

2/3
Hormones of posterior pituitary gland
Previous Next

3/3',
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
    "updated_at" = now();

  -- Lesson: Thyroid Gland
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'thyroid-gland',
    'Thyroid Gland',
    'article',
    '# Thyroid Gland

Thyroid gland
The thyroid gland is a ductless alveolar gland found in the
anterior neck, just below the laryngeal prominence (Adam''s
apple). It has two lobes wrapping around the trachea and
connected in the middle by an isthmus. It weighs about 20 t0
40g in adults. Thyroid is larger in females than in males. The
structure and function of thyroid gland change in different
stages of sexual cycle in females. Its function increases slightly
during pregnancy and lactation and decreases during
menopause.
Hormones of thyroid gland
The function of the thyroid gland is to produce and store
thyroid hormones. Thyroid epithelia form follicles filled with
colloid a protein-rich reservoir of the materials needed for
thyroid hormone production.
In the spaces between the follicles, parafollicular cells can be
found. These cells secrete calcitonin, which is involved in the
regulation of calcium metabolism in the body.

Diet ii Late 2026)
Overview  Comments

1/3
Thyroid gland secretes three hormones:
Tetraiodothyronine or T4 (thyroxine)
Triiodothyronine or T3
Calcitonin.
Production and Transport of Thyroid Hormones
Thyroid tissue is made up of colloid which contains iodinated
thyroglobulin. Thyroglobulin is synthesized by the
surrounding follicular cells and is the large molecule from
which thyroid hormones are made.
The thyroid gland produces two thyroid hormones, thyroxine
(T4) and triiodothyronine (T3). More T4 than T3 is synthesized,
however T4 is converted peripherally to the more potent and
shorter-acting T3.
Thyroid hormones are released as part of the hypothalamic-
pituitary-thyroid axis. The Hypothalamus detects a low
plasma concentration of thyroid hormone and releases
Thyrotropin-Releasing Hormone (TRH) into the hypophyseal
portal system.
TRH binds to receptors found on thyrotrophic cells of the
anterior pituitary gland, causing them to release Thyroid
Stimulating Hormone (TSH) into the systemic circulation. TSH
binds to TSH receptors on the basolateral membrane of
thyroid follicular cells and induces the synthesis and release
of thyroid hormone.
Most of the thyroid hormones in the blood are bound tightly
to proteins in the circulation-thyroxine-binding protein (TBG),
transthyretin and albumin and are thus unavailable to their
receptors which are located inside the target cells. Only the
small amounts of free T3 and T4 in plasma can readily cross
the cell membranes to bind to thyroid hormone receptors.
Thyroid receptors are present in almost all tissues, with
particularly high levels in the liver.
Functions of thyroid hormones
Only free hormone is active. T3 is most active (5 times more
potent than T4)
Functions of thyroid hormones (t3, t4)

2/3
Brain maturation
Bone growth (synergism with GH)
B-adrenergic effects. ↑ B ₁  receptors in heart→ ↑ CO, HR, SV,
contractility (B-blockers alleviate adrenergic symptoms in
thyrotoxicosis)
Basal metabolic rate ↑ (Via Na/K+-ATPase activity →  ↑    0 ₂
consumption, RR, body temperature
Blood sugar (increase glycogenolysis, gluconeogenesis)
Breakdown of lipids increase lipolysis.
Stimulates surfactant synthesis in babies.
Previous Next

3/3',
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
    "updated_at" = now();

  -- Lesson: Vitamin - D Synthesis
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'vitamin-d-synthesis',
    'Vitamin - D Synthesis',
    'article',
    '# Vitamin - D Synthesis

Vitamin D synthesis
Vitamin D is a long-term regulator of serum calcium. Its main
function is to increase the intestinal absorption of calcium.
It can be ingested, or synthesized from a cholesterol precursor
as follows:
Liver: cholesterol →  7-dehydrocholesterol (provitamin D3)
Skin Storage of 7-dehydrocholesterol, Cleavage of 7-
dehydrocholesterol via irradiation with UV light →
cholecalciferol (in the stratum Basale)
Liver: hydroxylation of cholecalciferol to 25-hydroxyvitamin D
Kidneys: 25-hydroxyvitamin D → 1,25-dihydroxyvitamin D
which is the active form of vitamin D
Regulation of vitamin D synthesis: via regulation of 1 α -
hydroxylase activity in proximal convoluted tubule
↓ Calcium, ↓ phosphate, and ↑ PTH →  ↑ 1 α -hydroxylase
activity →  ↑ 1,25-dihydroxyvitamin D biosynthesis
↑ Calcium, ↑ phosphate, and ↑ 1,25-dihydroxyvitamin D
(feedback inhibition) →  ↓ 1 α -hydroxylase activity →  ↓ 1,25-

Diet ii Late 2026)
Overview  Comments

1/3
dihydroxyvitamin D biosynthesis
Previous Next

2/3

3/3',
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
    "updated_at" = now();

  -- ==========================================
  -- Module 7: Blood Physiology & Coagulation Pathways
  -- ==========================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Blood Physiology & Coagulation Pathways' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Blood Physiology & Coagulation Pathways', 6, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 6, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Acquired Coagulation Disorder of Blood
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'acquired-coagulation-disorder-of-blood',
    'Acquired Coagulation Disorder of Blood',
    'article',
    '# Acquired Coagulation Disorder of Blood

Acquired coagulation disorder:

### 1: Vitamin K Deficiency

### 2: Liver disease: Factors synthesized in liver V, VII, IX, X, XI and

XII
Absence of these factors contribute to bleeding tendency.
3.Disseminated intravascular Coagulation:
DIC is characterized by a widespread inappropriate
intravascular deposition of fibrin with consumption of
coagulation factors and platelets.
Cause: This may occur as a consequence of many disorders
that release procoagulant material into the circulation or cause
widespread endothelial damage or platelet aggregation.
Lab values of Disseminated intravascular.

Diet ii Late 2026)
Overview  Comments

1/2
Low platelet count
Low fibrinogen concentration
Prolonged PT
Prolonged PT
Prolonged APTT
High levels of D-Dimers
Features of hemolysis
Coagulation tests:
Previous Next

2/2',
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
    "updated_at" = now();

  -- Lesson: Antiplatelet and Anticoagulant Drugs
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'antiplatelet-and-anticoagulant-drugs',
    'Antiplatelet and Anticoagulant Drugs',
    'article',
    '# Antiplatelet and Anticoagulant Drugs

Antiplatelet and anticoagulant
drugs
Previous Next

Diet ii Late 2026)
Overview  Comments

1/2

2/2',
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

  -- Lesson: Haemoglobin
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'haemoglobin',
    'Haemoglobin',
    'article',
    '# Haemoglobin

Haemoglobin
Red blood cells contain the specialised protein haemoglobin
which is responsible for carrying oxygen and carbon dioxide
in the blood.
Haemoglobin is composed of four polypeptide globin chains
each with its own iron containing haem molecule.
Synthesis of Haemoglobin
Haemoglobin synthesis occurs in immature red blood cells.
Haem synthesis occurs largely in the mitochondria by a
series of biochemical reactions commencing with the
condensation of glycine and succinyl coenzyme A under the
action of the key rate-limiting enzyme delta-aminolaevulinic
acid (ALA) synthase; ultimately protoporphyrin combines
with iron in the ferrous (Fe2+) state to form haem.
The globin chains are synthesized by ribosomes in the
cytosol.
Haemoglobin Degradation
Red cells are destroyed by macrophages in the liver and
spleen after 120 days.
The haem group is split from the haemoglobin and
converted to biliverdin and then bilirubin. The iron is
conserved and recycled to plasma via transferrin or stored in
macrophages as ferritin and haemosiderin. An increased rate
of haemoglobin breakdown results in excess bilirubin and
jaundice.
Types of Hemoglobin
There are three types of haemoglobin in normal adult blood:
haemoglobin A, A2 and F.
Fetal HB has high affinity for o2 as compared to adult.

Diet ii Late 2026)
Overview  Comments

1/2
Previous Next

2/2',
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

  -- Lesson: Haemostasis
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'haemostasis',
    'Haemostasis',
    'article',
    '# Haemostasis

Haemostasis
Prevention of blood loss
Stages of haemostasis: Three stages
Vasoconstriction
Platelet plug formation.
Coagulation of blood
Previous Next

Diet ii Late 2026)
Overview  Comments

1/2
2/2',
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

  -- Lesson: Heriditary Coagulation Disorder of Blood
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'heriditary-coagulation-disorder-of-blood',
    'Heriditary Coagulation Disorder of Blood',
    'article',
    '# Heriditary Coagulation Disorder of Blood

Coagulation disorder
Hereditary coagulation disorder:
Previous Next

Diet ii Late 2026)
Overview  Comments

1/2

2/2',
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

  -- Lesson: Platelate and Platelate Plug
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'platelate-and-platelate-plug',
    'Platelate and Platelate Plug',
    'article',
    '# Platelate and Platelate Plug

Platelets and platelet plug
Platelets:
These are minute, round or oval discs formed by fragmentation
of megakaryocytes. The normal half-life of platelets is 10 days.
Platelets contain three types of storage granules.
dense granules containing ADP, ATP, serotonin and calcium.
alpha granules containing clotting factors, von Willebrand
factor (VWF), platelet-derived growth factor (PDGF) and
other proteins.
lysosomes containing hydrolytic enzymes.
Functional characteristics of platelets:
Have no nucleus, so cannot reproduce.
Have actin and myosin molecules and thrombosthenin, so
can contract to cause clot retraction.
Have residual ER and Golgi apparatus to synthesize enzymes
and to store Ca ions.
Have enzyme systems to synthesize ATP from ADP.
Have enzyme Systems to synthesize prostaglandins.
Have fibrin-stabilizing factor that causes polymerization of
fibrin monomers to form fibrin threads.
Have growth factor that promote growth and multiplication
of vascular endothelial cells, vascular smooth muscle cells
and fibroblasts. So, repair damaged vascular wall.
Its surface has a glycoprotein-coat that adheres it to injured
endothelial cells and exposed collagen fibers form deeper
vessel wall.
Its membrane has phospholipids that activates intrinsic
system of blood doting.
Its membrane has Adenyl Cyclase that causes formation of
cyclic AMP that excites other activities of platelets.
Formation of Platelet Plug

Diet ii Late 2026)
Overview  Comments

1/3
Platelets get adhered to the collagen of ruptured blood
vessel and secrete adenosine diphosphate (ADP) and
thromboxane A2. These two substances attract more and
more platelets and activate them. All these platelets
aggregate together and form a loose temporary platelet plug
or temporary hemostatic plug, which closes the ruptured
vessel and prevents further blood loss.
Platelet aggregation is accelerated by platelet activating
factor (PAF)
Importance:
Platelet plug is important to close small rents in vessel wall.
Natural Inhibitors of Platelet
Function
The release reaction is inhibited by substances that increase
the level of platelet cAMP.
Prostacyclin (PGI2), synthesized by endothelial cells, is one
such substance, has the opposing effects of TXA2; it is a
potent inhibitor of platelet adhesion and aggregation on
normal vascular endothelium (and a potent vasodilator).
Nitric oxide is constitutively released from endothelial cells
and also from macrophages and platelets; it inhibits platelet
activation and promotes vasodilation.
Anti-clotting factor:
Surface of the cell: Cell membrane is covered by the glycocalyx
(it makes the cell surface slippery), clotting factor slip the cell
surface and move forward.
Antithrombin III: It prevents to convert the prothrombin to
thrombin.
Inactivates the already made thrombin.
Protein C and Protein S formed by liver
Prevent to convert the prothrombin to thrombin.
Prevent to convert the fibrinogen to fibrin.
Heparin: It increases the activity of antithrombin III by 1000
times

2/3
Plasmin:  It breaks already formed clot.
Released by all the tissues.
Convert the inactive plasminogen to plasmin.
Previous Next

3/3',
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

  -- Lesson: Plateletes Bleeding Disorder
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'plateletes-bleeding-disorder',
    'Plateletes Bleeding Disorder',
    'article',
    '# Plateletes Bleeding Disorder

Platelets bleeding disorder
Thrombocytopenia or abnormal platelet function is
characterized by spontaneous skin purpura, mucosal
haemorrhage and prolonged bleeding after trauma.
Important to note here difference between
TTP and haemolytic uremic syndrome.
Note: Difference between TTP and haemolytic uremic
syndrome

Diet ii Late 2026)
Overview  Comments

1/2
Previous Next

2/2',
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
    "updated_at" = now();

  -- Lesson: Sites of Haemopoiesis
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'sites-of-haemopoiesis',
    'Sites of Haemopoiesis',
    'article',
    '# Sites of Haemopoiesis

Haemopoiesis Sites:
Important to remember:
Haemopoietic Stem Cells: All blood cells
develop from Haemopoietic Stem Cells
Previous Next

Diet ii Late 2026)
Overview  Comments

1/2

2/2',
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

  RAISE NOTICE 'Successfully seeded MRCEM Primary: Applied Emergency Physiology (99 lessons)';
END $$;
