-- ==========================================================================
-- COURSE SEED: MRCEM Primary: Clinical Anatomy Masterclass
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

  -- 2. Upsert Course: mrcem-anatomy
  SELECT id INTO v_course_id FROM "courses" WHERE "slug" = 'mrcem-anatomy' LIMIT 1;
  IF v_course_id IS NULL THEN
    INSERT INTO "courses" (
      "id", "exam_id", "slug", "title", "summary", "description", "is_free", "position", "status", "created_at", "updated_at"
    ) VALUES (
      gen_random_uuid(),
      v_exam_id,
      'mrcem-anatomy',
      'MRCEM Primary: Clinical Anatomy Masterclass',
      'Comprehensive clinical anatomy covering upper & lower limbs, thorax, abdomen, head & neck, CNS, and cranial nerves.',
      'Master the essential clinical anatomy required for the Royal College of Emergency Medicine (RCEM) Primary exam. Features high-yield mnemonics, dissection landmarks, and high-resolution anatomical illustrations organized into 7 focused clinical modules.',
      false,
      2,
      'published',
      now(),
      now()
    ) RETURNING "id" INTO v_course_id;
  ELSE
    UPDATE "courses" SET
      "title" = 'MRCEM Primary: Clinical Anatomy Masterclass',
      "exam_id" = COALESCE(v_exam_id, "exam_id"),
      "summary" = 'Comprehensive clinical anatomy covering upper & lower limbs, thorax, abdomen, head & neck, CNS, and cranial nerves.',
      "description" = 'Master the essential clinical anatomy required for the Royal College of Emergency Medicine (RCEM) Primary exam. Features high-yield mnemonics, dissection landmarks, and high-resolution anatomical illustrations organized into 7 focused clinical modules.',
      "position" = 2,
      "status" = 'published',
      "deleted_at" = NULL,
      "updated_at" = now()
    WHERE "id" = v_course_id;
  END IF;

  -- ==========================================================================
  -- Module 1: Upper Limb Anatomy (8 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Upper Limb Anatomy' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Upper Limb Anatomy', 0, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 0, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Arterial Supply of Upper Limb (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'arterial-supply-of-upper-limb',
    'Arterial Supply of Upper Limb',
    'article',
    '# Arterial Supply of Upper Limb

Axillary Artery:
Is considered to be the central structure of the axilla. Extends
from the outer border of the first rib to the inferior border of
the teres major muscle, where it becomes the brachial artery.
The axillary artery runs with and is lateral to the axillary vein.
Is divided into three parts by the pectoralis minor muscle.
First part: Superior thoracic artery
Second part: Thoracoacromial artery and Lateral thoracic
artery
Third Part: Subscapular artery, Anterior and posterior
circumflex arteries
Note: The anterior and posterior circumflex humeral arteries
form an anastomotic network around the surgical neck of
the humerus and can be damaged in cases of fracture.
Brachial Artery:
The brachial artery is a continuation of the axillary artery past
the lower border of the teres major. It is the main supply of
blood for the arm.
Anatomical course:
It descends through the anterior compartment of the arm on
the brachialis muscle enters the cubital fossa, and then ends
at the level of the neck of the radius by dividing into the
radial and the ulnar arteries.
Branches of Brachial artery:

### 1: Muscular branches

### 2: Nutrient artery: to the humerus

### 3: Profunda brachii artery: Immediately distal to the teres

major, the brachial artery gives rise to the profunda brachii
(deep artery), which travels with the radial nerve in the radial
groove of the humerus and supplies structures in the
posterior aspect of the upper arm (e.g., triceps brachii).

Overview  Comments

### 4: Superior ulnar collateral artery, which follows the ulnar

nerve

### 5: Inferior ulnar collateral artery, which takes part in

anastomosis around the elbow joint.
Radial artery:
Smaller of two terminal branches of brachial artery. Passing
along the lateral aspect of the forearm lying deep to
brachioradialis muscle, distally being covered by only skin
and fascia. The radial pulse can be palpated in the distal
forearm, immediately lateral to the prominent tendon of
the flexor carpi radialis muscle. The radial artery enters the
hand by curving around the lateral side of the wrist, passing
over the floor of the anatomical snuffbox and penetrating the
dorsolateral aspect of the hand between the bases of the first
and second metacarpal bones.
Ulnar artery:
Largest of the two terminal branches, courses along the ulnar
aspect of the forearm deep to the flexor digitorum
superficialis, pronator teres and flexor carpi radialis muscles.
It enters the hand with the ulnar nerve and vein by passing
through the Guyon canal (ulnar canal) located between the
pisiform and the hook of hamate.

> [!TIP]
> **Clinical pearls:**
> Brachial artery is palpated in antecubital fossa, immediately
> medial to the tendon of biceps brachii.

The radial pulse can be palpated in the distal forearm,
immediately lateral to the prominent tendon of the flexor
carpi radialis muscle.
Volkman ischemic contracture:
Complete occlusion of brachial artery can cause necrosis of
forearm muscles and are replaced by scar tissue and shorten
considerably this can cause a characteristic flexion deformity,
called Volkmann''s ischemic contracture.
Guyon''s or Ulnar canal: The ulnar (Guyon''s) canal is a fibro-
osseous tunnel located at the level of the palm. The ulnar canal

conveys the ulnar neurovascular bundle into the hand.
Contents: Ulnar nerve, ulnar artery and Venae comitantes of
ulnar artery
Ulnar canal syndrome refers to compression of the ulnar nerve
within the ulnar canal. The most common causes are ganglion
cyst, lipoma and trauma.
Superficial and Deep palmar arches:
The hand has a rich arterial supply with many anastomoses
between vessels

### 1: The superficial palmar arch lies just beneath the palmar

aponeurosis on the long flexor tendons. It is a continuation of
the ulnar artery, and it is often completed on the lateral side by
the superficial palmar branch of the radial artery.
Palmar aponeurosis: is a thickened area of palmar fascia.
Palmar aponeurosis protects the underlying soft tissues and
long flexor tendons
Blood supply: The superficial palmar arch It gives rise to the
digital arteries, which supply the four fingers.

### 2: The deep palmar arch is deeply placed in the palm, and it

extends from the proximal end of the space between the first
and second metacarpal bones to the base of the fifth
metacarpal bone. It is formed as a continuation of the radial
artery, and it terminates by anastomosing with the deep
branch of the ulnar artery.
Blood supply: Blood supply to digits and wrist joint.
Previous Next',
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

  -- Lesson: Innervation of Upper Limb (13 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'innervation-of-upper-limb',
    'Innervation of Upper Limb',
    'article',
    '# Innervation of Upper Limb

Brachial Plexus:
The brachial plexus is a network of nerve fibers that supply the
skin and muscles of upper extremity. The plexus is formed by
the anterior rami (divisions) of cervical spinal nerves C5, C6, C7,
and C8, and the first thoracic spinal nerve, T1.
The brachial plexus is divided into five parts
Roots
Trunks
Divisions
Cords
branches

### 1: Root:

Formed by the union of anterior rami (divisions) of cervical
spinal nerves C5, C6, C7, and C8, and the first thoracic spinal
nerve, T1.

### 2: Trunk:

At the base of the neck, the roots of the brachial plexus
converge to form three trunks.
Superior trunk: Combination of C5 and C6 roots.
Middle trunk: Continuation of C7.
Inferior trunk: Combination of C8 and T1 roots

### 3: Division:

Trunks are divided into anterior and posterior division within
posterior triangle of neck.

### 4: Cords:

Once the anterior and posterior divisions have entered the
axilla, they combine together to form three cords
Lateral cord: Anterior division of superior and middle trunk
Medial cord: Anterior division of inferior trunk
Posterior cord: Posterior union of all three trunks

### 5: Branches:

Overview  Comments

## Branches Of Lateral Cord   "Lml"

Lateral pectoral nerve
Musculocutaneous nerve
Lateral root of median nerve

## Branches Of Medial Cord     "M4U"

Medial pectoral nerve
Medial cutaneous nerve of arm
Medial cutaneous nerve of forearm
Medial root of median nerve
Ulnar nerve

## Branches Of Posterior Cord   "Ultra"

Upper subscapular nerve
Lower subscapular nerve

> [!TIP]
> **Clinical Pearls:**
> Brachial plexus injury:
> Axillary Nerve:
> Axillary Nerve is a direct continuation of the posterior cord from
> the brachial plexus.

Spinal roots: C5 and C6.
Plexus cord: Posterior
Motor functions: Innervates the teres minor and deltoid
muscles.
Sensory functions: Gives rise to the upper lateral cutaneous
nerve of the arm, which innervates the skin over the lower
deltoid (''regimental badge area'').
Note: Lateral supraclavicular nerve arising from the cervical
plexus (C3, C4 ) gives sensory innervation to upper half of
deltoid.
Anatomical course:

![Innervation of Upper Limb - Clinical Figure 1](/lessons/images/upper-limb-anatomy/innervation-of-upper-limb/figure_01_p2.png)
*Innervation of Upper Limb — Clinical Figure 1 (Page 2 Reference)*

Axillary nerve arises in the axilla passes medially to the surgical
neck of the humerus, where it divides into three terminal
branches:
Anterior terminal branch:  winds around the surgical neck of
the humerus and provides motor innervation to the anterior
aspect of the deltoid muscle.
Posterior terminal branch:  Gives motor innervation to the
posterior aspect of the deltoid muscle and teres minor. It also
innervates the skin over the inferior part of the deltoid as
the upper lateral cutaneous nerve of the arm.
Articular branch: supplies the glenohumeral joint

> [!TIP]
> **Clinical Pearls:**
> Axillary nerve injury is commonly caused by fracture of
> surgical neck of humerus or inferior dislocation of humerus.

Causes weak lateral rotation and abduction of the arm.
(Supraspinatus can abduct the arm but not to a horizontal
level).
Loss of sensation over the inferior portion of the deltoid (the
''regimental badge area'').
Quadrangular space: Axillary nerve and posterior circumflex
humeral artery and vein pass through it and can be
compressed as a result of trauma, muscle hypertrophy
resulting in weakness of deltoid and teres minor.
Median Nerve:
After originating from the brachial plexus in the axilla the
median nerve descends down the arm, initially lateral to the
brachial artery. Halfway down the arm, the nerve crosses over
the brachial artery, and becomes situated medially. The median
nerve enters the anterior compartment of the forearm via the
cubital fossa
Branches of Median Nerve in the Forearm

![Innervation of Upper Limb - Clinical Figure 2](/lessons/images/upper-limb-anatomy/innervation-of-upper-limb/figure_02_p3.png)
*Innervation of Upper Limb — Clinical Figure 2 (Page 3 Reference)*

Branches of Median Nerve in the Hand
After giving off the anterior interosseous and palmar cutaneous
branches, the median nerve enters the hand via the carpal
tunnel where it terminates by dividing into two branches

> [!TIP]
> **Clinical Pearls:**
> Carpal tunnel syndrome: Compression of the median nerve
> within the carpal tunnel can cause carpal tunnel syndrome

## (Cts).

Clinical features: include numbness, tingling, and pain in the
distribution of the median nerve.
Note: In carpal tunnel syndrome Importantly, the palm is
usually spared  as the palmar cutaneous branch does not travel
through the carpal tunnel.
Note: Flexion of the ring and little fingers at MCPJ and DIPJ are
preserved as these are functions of medial half of flexor
digitorum profundus and medial two lumbricals innervated by
ulnar nerve.
Radial Nerve:
The radial nerve is the terminal continuation of the posterior
cord of the brachial plexus

![Innervation of Upper Limb - Clinical Figure 3](/lessons/images/upper-limb-anatomy/innervation-of-upper-limb/figure_03_p4.png)
*Innervation of Upper Limb — Clinical Figure 3 (Page 4 Reference)*

![Innervation of Upper Limb - Clinical Figure 4](/lessons/images/upper-limb-anatomy/innervation-of-upper-limb/figure_04_p4.png)
*Innervation of Upper Limb — Clinical Figure 4 (Page 4 Reference)*

![Innervation of Upper Limb - Clinical Figure 5](/lessons/images/upper-limb-anatomy/innervation-of-upper-limb/figure_05_p4.png)
*Innervation of Upper Limb — Clinical Figure 5 (Page 4 Reference)*

Radial nerve arises from the posterior cord and the largest
branch of the brachial plexus.
The nerve arises in the axilla region, where it is situated
posteriorly to the axillary artery, descends posteriorly between
the long and medial heads of the triceps, after which it passes
inferolaterally with the profunda brachii artery in the spiral
(radial) groove on the posterior surface of the humerus
between the medial and lateral heads of the triceps. Pierces
the lateral intermuscular septum to enter the anterior
compartment and descends anterior to the lateral epicondyle
between the brachialis and brachioradialis muscles to enter the
cubital fossa, where it divides into superficial and deep
branches.
Deep branch (motor): innervates the muscles in the posterior
compartment of the forearm and continues as posterior
interosseous nerve
Superficial branch (sensory): contributes to the cutaneous
innervation of the skin of dorsal hand and lateral three and
half fingers.
Other branches which give cutaneous innervation to skin of
upper limb.
Lower lateral cutaneous nerve of arm: Innervates the lateral
aspect of the arm, inferior to the insertion of the deltoid
muscle.
Posterior cutaneous nerve of arm: Innervates the posterior
surface of the arm.
Posterior cutaneous nerve of forearm: Innervates a strip of
skin down the middle of the posterior forearm.

> [!TIP]
> **Clinical Pearls:**
> Radial nerve injury:
> Wrist Drop:

![Innervation of Upper Limb - Clinical Figure 6](/lessons/images/upper-limb-anatomy/innervation-of-upper-limb/figure_06_p5.png)
*Innervation of Upper Limb — Clinical Figure 6 (Page 5 Reference)*

Injury to the radial nerve is commonly caused by a fracture of
the midshaft of the humerus. Radial nerve injury results in loss
of function in the extensors of the forearm, hand, metacarpals,
and phalanges. It also results in the loss of wrist extension,
leading to wrist drop, and produces weakness of abduction and
adduction of the hand.
Note: When the radial nerve is injured in proximal humerus
fracture triceps brachii muscle will be affected and patient
presents with unable to extend at the forearm. While midshaft
of humerus fracture triceps brachii will remain spared
Ulnar Nerve:
The ulnar nerve arises from the brachial plexus within the axilla
region. It is a continuation of the medial cord and contains
fibers from spinal roots C8 and T1.
Anatomical Course of Ulnar Nerve:
Arises from the medial cord of the brachial plexus, runs down
the medial aspect of the arm, pierces the medial
intermuscular septum at the middle of the arm, and
descends together with the superior ulnar collateral branch
of the brachial artery. It then Descends behind the medial
epicondyle in a tunnel (cubital tunnel), where it is readily

![Innervation of Upper Limb - Clinical Figure 7](/lessons/images/upper-limb-anatomy/innervation-of-upper-limb/figure_07_p6.png)
*Innervation of Upper Limb — Clinical Figure 7 (Page 6 Reference)*

![Innervation of Upper Limb - Clinical Figure 8](/lessons/images/upper-limb-anatomy/innervation-of-upper-limb/figure_08_p6.png)
*Innervation of Upper Limb — Clinical Figure 8 (Page 6 Reference)*

palpated and most commonly injured. It may be damaged
by a fracture of the medial epicondyle. When irritated, it
causes funny bone symptoms of pain, numbness, and
tingling in the medial elbow, forearm, and digits.
It then enters the forearm by passing between the two heads
of the flexor carpi ulnaris and descends between the flexor
carpi ulnaris and gives rise to following branches in forearm.
Ulnar nerve branches in hand
Enters the hand superficial to the flexor retinaculum and
lateral to the pisiform bone, where it is vulnerable to damage
from cuts or stab wounds and gives rise to following
branches in hand.

> [!TIP]
> **Clinical Pearls:**
> Froment''s sign: Froment''s sign is a test for ulnar nerve palsy
> specifically paralysis of the adductor pollicis:
> Patient is asked to hold a piece of paper between thumb and
> index finger as paper is pulled away, patient will flex thumb
> at inter-phalangeal joint to maintain hold, this sign tests the
> function of adductor pollicis muscle which is supplied by the
> ulnar nerve.

A positive test is when the patient is unable to adduct the
thumb.
Claw hand:
Injury to the ulnar nerve is commonly caused by a fracture of
the medial epicondyle and results in a claw hand, in which the
ring and little fingers are hyperextended at the
metacarpophalangeal joints and flexed at the interphalangeal
joints.
Partial claw hand deformity is due to an isolated ulnar nerve
injury.

![Innervation of Upper Limb - Clinical Figure 9](/lessons/images/upper-limb-anatomy/innervation-of-upper-limb/figure_09_p7.png)
*Innervation of Upper Limb — Clinical Figure 9 (Page 7 Reference)*

![Innervation of Upper Limb - Clinical Figure 10](/lessons/images/upper-limb-anatomy/innervation-of-upper-limb/figure_10_p7.png)
*Innervation of Upper Limb — Clinical Figure 10 (Page 7 Reference)*

Complete claw hand deformity: Involves all digits and results
from combined ulnar and median nerve injury.
Ulnar nerve injury at elbow and wrist:
Sensory innervation of Median, Radial and
ulnar (High Yield):
Musculocutaneous Nerve:
The musculocutaneous nerve is the terminal branch of the
lateral cord of the brachial plexus.

![Innervation of Upper Limb - Clinical Figure 11](/lessons/images/upper-limb-anatomy/innervation-of-upper-limb/figure_11_p8.png)
*Innervation of Upper Limb — Clinical Figure 11 (Page 8 Reference)*

![Innervation of Upper Limb - Clinical Figure 12](/lessons/images/upper-limb-anatomy/innervation-of-upper-limb/figure_12_p8.png)
*Innervation of Upper Limb — Clinical Figure 12 (Page 8 Reference)*

Anatomical Course:
Musculocutaneous nerve (C5-C7) Pierces the coracobrachialis
muscle and descends between the biceps and brachialis
muscles. Innervates all of the flexor muscles in the anterior
compartment of the arm, such as the coraco- brachialis, biceps,
and brachialis muscles. Continues into the forearm as the
lateral cutaneous nerve of forearm.

> [!TIP]
> **Clinical Pearls:**
> Injury to the musculocutaneous nerve results in weakness of
> supination (biceps) but can still be performed by the
> brachioradialis (Innervated by Radial nerve)
> Weakness of flexion at the shoulder and elbow but can still
> be performed by the pectoralis major and brachioradialis
> respectively and loss of sensation on lateral side of the
> forearm.

Previous Next

![Innervation of Upper Limb - Clinical Figure 13](/lessons/images/upper-limb-anatomy/innervation-of-upper-limb/figure_13_p9.png)
*Innervation of Upper Limb — Clinical Figure 13 (Page 9 Reference)*',
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

  -- Lesson: Joints of the Upper Limb (3 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'joints-of-the-upper-limb',
    'Joints of the Upper Limb',
    'article',
    '# Joints of the Upper Limb

Acromioclavicular Joint:
TYPE= Plane type synovial joint
The acromioclavicular joint consists of an articulation between
the lateral end of the clavicle and the acromion of the scapula
Ligaments of the joint:
Ligaments
There are three main ligaments that support the
acromioclavicular joint
Acromioclavicular ligament
Conoid ligament
Trapezoid ligament
Collectively, the conoid and trapezoid ligaments are known as
the coracoclavicular ligament. It is the strongest ligament
and suspends weight of the upper limb

Overview  Comments

Acromioclavicular joint dislocation
A severe blow on the point of the shoulder, as is incurred
during blocking or tackling in football or any severe fall,
can result in the acromion being thrust beneath the lateral
end of the clavicle, tearing the coracoclavicular ligament. This
condition is known as shoulder separation. The displaced
outer end of the clavicle is easily palpable.
Note: If the coracoclavicular ligament is torn weight of the
upper limb is not supported
Sternoclavicular Joint
Type: Synovial typed Saddle joint
Sternoclavicular joint is formed between the clavicle,
manubrium of the sternum and the first costal cartilage.

![Joints of the Upper Limb - Clinical Figure 1](/lessons/images/upper-limb-anatomy/joints-of-the-upper-limb/figure_01_p2.png)
*Joints of the Upper Limb — Clinical Figure 1 (Page 2 Reference)*

Ligaments of Sternoclavicular Joint
Sternoclavicular ligaments (anterior and posterior)
strengthen the joint anteriorly and posteriorly.
Interclavicular ligament strengthen the joint capsule
superiorly.
Costoclavicular ligament strong ligament and stabilizes the
joint capsule.
The sternoclavicular joint has a high degree of mobility and is
required to accommodate the movements of the upper limb

> [!TIP]
> **Clinical pearl: Violent forces directed along the long axis of the**
> clavicle usually result in fracture of that bone, but dislocation of
> the sternoclavicular joint takes place rarely.

Elbow joint
Type: Synovial hinge joint assists in flexion and extension of
elbow
Formed by articulations between
Trochlear notch of the ulna and the trochlea of the humerus
Head of the radius and the capitulum of the humerus
Ligaments of the elbow joint:
The radial collateral ligament is found on the lateral side of
the joint, extending from the lateral epicondyle and
blending with the annular ligament.
The ulnar collateral ligament referred as Medial collateral
ligament (MCL) of the elbow originates from the
medial epicondyle and attaches to the coronoid process and
olecranon of the ulna.
Annular ligament: Annular ligament stabilizes the elbow
joint and is a strong band of fibers that encircles the head of
the radius and holds it in contact with the radial notch of the
ulna

> [!TIP]
> **Clinical pearl:**
> Elbow dislocation: Mostly posterior occurs due to fall on
> hand with the elbow flexed
> Complications: The ulnar collateral ligament is usually torn
> and there can also be ulnar nerve involvement.

Radioulnar joints (Pronator and
supinator of the forearm)
Type: Pivot typed synovial joint
Proximal Radioulnar joint: Formed by articulation between the
head of the radius and the radial notch of the ulna
Annular ligament stabilizes the elbow joint and is a strong
band of fibers that encircles the head of the radius and holds
it in contact with the radial notch of the ulna
Distal Radioulnar joint: formed by articulation between the
ulnar notch of the radius and the head of the ulna.
Interosseous Membrane
The interosseous membrane is a sheet of connective tissue
that joins the radius and ulna together between the
radioulnar joints along with acts as a site of attachment for
muscles in the anterior and posterior compartments of
forearm.
The collateral ligament is usually torn and there can also be
ulnar nerve involvement The ulnar collateral ligament is
usually torn and there can also be ulnar nerve involvement
The ulnar collateral ligament is usually torn and there can
also be ulnar nerve involvement.

Wrist joint
Type: Synovial condyloid joint
Formed between the distal end of the radius and the articular
disc above and the scaphoid, lunate and triquetral bones
below
Note: The ulna is not part of the wrist joint it articulates with
the radius, just proximal to the wrist joint.
Ligaments of the joint:
Palmar radiocarpal:  Found on anterior side of the hand. It
passes from the radius to both rows of carpal bones. Its
function, apart from increasing stability, is to ensure that the
hand follows the forearm during supination.
Dorsal radiocarpal: Found on the posterior side of the hand.
It contributes to the stability of the wrist, but also ensures
that the hand follows the forearm during pronation.
Ulnar collateral: Runs from the ulnar styloid process to the
triquetrum and pisiform. It acts to prevent excessive radial
(lateral) deviation of the hand.
Radial collateral: Runs from the radial styloid process to the
scaphoid and trapezium. It acts to prevent excessive ulnar
(medial) deviation of the hand.

![Joints of the Upper Limb - Clinical Figure 2](/lessons/images/upper-limb-anatomy/joints-of-the-upper-limb/figure_02_p5.png)
*Joints of the Upper Limb — Clinical Figure 2 (Page 5 Reference)*

Movements of the wrist joint: Wrist joint allow for movement
along two axes. This means that flexion, extension, adduction
and abduction can all occur at the wrist joint

> [!TIP]
> **Clinical pearl: Falling on outstretched hand most commonly**
> fractured carpal bone in wrist joint is Scaphoid. While most
> common fracture of the wrist joint is Colles'' fracture.

The shoulder Joint
Type: synovial ball and socket joint
Shoulder joint is formed by the articulation of the head of the
humerus with the glenoid cavity of the scapula
Ligaments of the shoulder joint:
In the shoulder joint, the ligaments play a key role in stabilizing
the bony structures.
Glenohumeral ligaments (superior, middle and inferior) They
act to stabilize the anterior aspect of the joint. They are the
main source of stability for the shoulder, holding it in place
and preventing it from dislocating anteriorly.
Coracohumeral ligament: It supports the superior part of the
joint capsule.
Transverse humeral ligament: This ligament spans the
distance between the two tubercles of the humerus. It holds
the tendon of the long head of the biceps in the
intertubercular groove or bicipital groove
Coraco-clavicular ligament:  This ligament composed of the
trapezoid and conoid ligaments and runs from the clavicle to
the coracoid process of the scapula. They work alongside the
acromioclavicular ligament to maintain the alignment of the
clavicle in relation to the scapula.
Coracoacromial ligament. This ligament runs between the
acromion and coracoid process of the scapula it forms the
coraco-acromial arch.  This structure overlies the shoulder
joint, preventing superior displacement of the humeral
head.
Stability of the shoulder joint:
Rotator cuff muscles [SITS MUSCLES]

Glenoid labrum: A fibrocartilaginous ridge surrounding the
glenoid cavity.
Ligaments: Extra Capsular ligaments form the
coracoacromial arch.
Biceps tendon - it acts as a minor humeral head depressor,
thereby contributing to stability.
Movements of the shoulder joint: Shoulder joint is highly
mobile ball and socket joint allows various movements like
flexion, extension, adduction, abduction, medial rotation, lateral
rotation and circumduction.
NOTE: All the movements of the shoulder joint by different
muscles and the innervation is discussed in muscles of upper
arm

> [!TIP]
> **Clinical pearls:**
> Shoulder joint dislocation
> Anterior shoulder dislocation: Most common injury results
> from forceful abduction, extension and external rotation
> Clinical features:
> Arm usually abducted and externally rotated.

Humeral head often palpated anteriorly.

![Joints of the Upper Limb - Clinical Figure 3](/lessons/images/upper-limb-anatomy/joints-of-the-upper-limb/figure_03_p7.png)
*Joints of the Upper Limb — Clinical Figure 3 (Page 7 Reference)*

Patient cannot touch contralateral shoulder with hand of
affected extremity.
Complications of anterior shoulder dislocation:
Injury to axillary nerve
Injury to axillary artery
Injury to rotator cuff
Posterior Shoulder dislocation: occurs occasionally results
from direct blow to the arm that produces forceful internal
rotation and adduction.
Clinical features:
Arm usually adducted and internally rotated.
Patient unable to perform external rotation.
Complications of posterior shoulder dislocation: less
common neurovascular injury
Fracture of posterior glenoid labrum
Fracture of humeral shaft or lesser tuberosity
Note: Light bulb sign on the X-ray is the diagnostic feature of
posterior shoulder dislocation
Previous Next',
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

  -- Lesson: Lymphatic Drainage of Upper Limb (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'lymphatic-drainage-of-upper-limb',
    'Lymphatic Drainage of Upper Limb',
    'article',
    '# Lymphatic Drainage of Upper Limb

Lymphatic drainage of the Upper
Limb:
The superficial lymph vessels ascend the limb in the superficial
fascia and accompany the superficial veins. The deep lymph
vessels lie deep to the deep fascia and follow the deep arteries
and veins. All lymph vessels of the limb ultimately drain into
lymph nodes in axilla.

### 1: Axillary lymph nodes: The axillary lymph nodes drain lymph

vessels from the entire upper limb. In addition, they drain
lymph vessels from the lateral part of the breast

### 2: Infraclavicular nodes: They lie in the interval between the

deltoid and the pectoralis major muscles. They receive lymph
from the superficial vessels of the radial side of hand, the
forearm, and the arm.

### 3: Supratrochlear lymph nodes: The supratrochlear lymph

node lies in the superficial fascia in the cubital fossa close to
the trochlea of the humerus. It receives lymph from the medial
fingers, the medial part of the hand, and the medial side of the
forearm.
Lymphatic drainage of the Breast:
The lymphatic drainage of the breast is of great clinical
importance due to its role in the metastasis of breast cancer
cells.
There are three groups of lymph nodes that receive lymph
from breast tissue.
Axillary nodes (75%): Receives lymphatic drainage from lateral
and superior quadrant of breast.

Overview  Comments

parasternal nodes (20%): Receives lymphatic drainage from
medial quadrant.
Note: Breast cancer in axillary tail of breast most commonly
involved lymph node is axillary

> [!TIP]
> **Clinical Pearl:**
> Removal and analysis of the axillary lymph nodes is often a vital
> tool for the staging of breast cancers. During this procedure
> there is also a risk of damage to either of the long thoracic
> nerve or the thoracodorsal nerve causing winged scapula.

Previous Next',
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

  -- Lesson: Muscles of the Upper Limb (15 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'muscles-of-the-upper-limb',
    'Muscles of the Upper Limb',
    'article',
    '# Muscles of the Upper Limb

Forearm muscles
Anterior forearm muscles superficial
compartment
Anterior Forearm muscles intermediate
compartment:
Anterior Forearm muscles deep compartment:
Key Point: All the muscles of anterior forearm are innervated
by median nerve except flexor carpi ulnaris and medial half of

Overview  Comments

![Muscles of the Upper Limb - Clinical Figure 1](/lessons/images/upper-limb-anatomy/muscles-of-the-upper-limb/figure_01_p1.png)
*Muscles of the Upper Limb — Clinical Figure 1 (Page 1 Reference)*

![Muscles of the Upper Limb - Clinical Figure 2](/lessons/images/upper-limb-anatomy/muscles-of-the-upper-limb/figure_02_p1.png)
*Muscles of the Upper Limb — Clinical Figure 2 (Page 1 Reference)*

![Muscles of the Upper Limb - Clinical Figure 3](/lessons/images/upper-limb-anatomy/muscles-of-the-upper-limb/figure_03_p1.png)
*Muscles of the Upper Limb — Clinical Figure 3 (Page 1 Reference)*

flexor digitorum profundus innervated by ulnar nerve.
Digital attachment of flexor muscles
of forearm:
All the anterior forearm muscles originate from the medial
humeral epicondyle.
Muscles of Anterior Arm:
Muscles of posterior Arm:
Triceps brachii:
Triceps brachii is a large thick muscle in the posterior arm and
appears as a horseshoe-shaped muscle
Function:  Extension of forearm at elbow and extension of arm
at shoulder joint.
Innervation: Radial nerve
Muscles of posterior forearm

![Muscles of the Upper Limb - Clinical Figure 4](/lessons/images/upper-limb-anatomy/muscles-of-the-upper-limb/figure_04_p2.png)
*Muscles of the Upper Limb — Clinical Figure 4 (Page 2 Reference)*

![Muscles of the Upper Limb - Clinical Figure 5](/lessons/images/upper-limb-anatomy/muscles-of-the-upper-limb/figure_05_p2.png)
*Muscles of the Upper Limb — Clinical Figure 5 (Page 2 Reference)*

The muscles in the posterior compartment of the forearm are
commonly known as the extensor muscles.
Extensor muscles are divided into superficial and deep
compartment.
Superficial compartment:
Deep Compartment:

> [!TIP]
> **Clinical pearl:**

### 1: Tennis elbow (lateral epicondylitis): is caused by a chronic

inflammation or irritation of the origin of the extensor muscles
of the forearm from the lateral epicondyle of the humerus as a
result of repetitive strain. It is a painful condition and common
in tennis players.

### 2: Golfer''s elbow (medial epicondylitis):  is a painful condition

caused by a tear or chronic inflammation in the origin of flexor
muscles of the forearm

### 3: Nursemaid''s elbow or pulled elbow is a radial head

subluxation and occurs in toddlers when the child is lifted by
the wrist. The annular ligament (and other elbow ligaments) is
not fully developed in terms of strength, and thus, the radial
head can slip out of position.
Muscles of the hand:

![Muscles of the Upper Limb - Clinical Figure 6](/lessons/images/upper-limb-anatomy/muscles-of-the-upper-limb/figure_06_p3.png)
*Muscles of the Upper Limb — Clinical Figure 6 (Page 3 Reference)*

![Muscles of the Upper Limb - Clinical Figure 7](/lessons/images/upper-limb-anatomy/muscles-of-the-upper-limb/figure_07_p3.png)
*Muscles of the Upper Limb — Clinical Figure 7 (Page 3 Reference)*

Thenar muscles:
Three short muscles located in the base of the thumb. All are
innervated by median nerve.
Hypothenar muscles:
Hypothenar muscle located at base of middle finger and form
hypothenar eminence. All are innervated by ulnar nerve
Lumbrical Muscles:
There are four lumbrical muscles. Each one of these originates
from a tendon of the flexor digitorum profundus. They pass
dorsally and laterally around each finger, and inserts into the
extensor hood.
Innervation:
Medial two lumbricals: Ulnar nerve
Lateral two lumbricals: Median nerve
Function:
Flexion at the MCP joint and extension at the interphalangeal
(IP) joints of each digit.

> [!TIP]
> **Clinical pearls:**
> Denervation of these muscles is the basis of claw hand and

![Muscles of the Upper Limb - Clinical Figure 8](/lessons/images/upper-limb-anatomy/muscles-of-the-upper-limb/figure_08_p4.png)
*Muscles of the Upper Limb — Clinical Figure 8 (Page 4 Reference)*

![Muscles of the Upper Limb - Clinical Figure 9](/lessons/images/upper-limb-anatomy/muscles-of-the-upper-limb/figure_09_p4.png)
*Muscles of the Upper Limb — Clinical Figure 9 (Page 4 Reference)*

hand of benediction.
Interossei muscles: Located between the metacarpals of the
hand. Divided into Dorsal and palmar Interossei
All the interossei muscles are innervated by ulnar nerve.
Dorsal Interossei:
Abduction of the digits. Assists in flexion at the
metacarpophalangeal joints and extension at the
interphalangeal joints.
Palmar Interossei:
Adduction of the digits. Assists in flexion at the
metacarpophalangeal joints and extension at the
interphalangeal joints.
Muscles of the Shoulder region:
Extrinsic muscles, Intrinsic Muscles
Extrinsic muscles: Connecting the Upper Limb to the Vertebral
Column and divided into superficial and deep group.
Superficial: Trapezius and Latissimus dorsi
Deep: Levator Scapulae, Rhomboid minor and Rhomboid
major

![Muscles of the Upper Limb - Clinical Figure 10](/lessons/images/upper-limb-anatomy/muscles-of-the-upper-limb/figure_10_p5.png)
*Muscles of the Upper Limb — Clinical Figure 10 (Page 5 Reference)*

> [!TIP]
> **Clinical pearl: Ask the patient to shrug his/her shoulder if**
> patient unable to do this indicates spinal accessory nerve injury
> and paralysis of trapezius muscle.

Intrinsic muscles of the shoulder: Connecting the scapula to
the humerus
There are six muscles in this group the deltoid, teres major, and
the four rotator cuff muscles (supraspinatus, infraspinatus,
subscapularis and teres minor).
Note: All the rotator cuff muscles (SITS) are lateral rotators of

![Muscles of the Upper Limb - Clinical Figure 11](/lessons/images/upper-limb-anatomy/muscles-of-the-upper-limb/figure_11_p6.png)
*Muscles of the Upper Limb — Clinical Figure 11 (Page 6 Reference)*

![Muscles of the Upper Limb - Clinical Figure 12](/lessons/images/upper-limb-anatomy/muscles-of-the-upper-limb/figure_12_p6.png)
*Muscles of the Upper Limb — Clinical Figure 12 (Page 6 Reference)*

arm except "S" Subscapularis

> [!TIP]
> **Clinical pearl:**
> Assessment of rotator cuff muscles:
> Rotator cuff tendonitis:
> Refers to inflammation of tendons of rotator cuff muscles.

Supraspinatus is the most commonly injured rotator
cuff muscle.
Muscles of pectoral region:

![Muscles of the Upper Limb - Clinical Figure 13](/lessons/images/upper-limb-anatomy/muscles-of-the-upper-limb/figure_13_p7.png)
*Muscles of the Upper Limb — Clinical Figure 13 (Page 7 Reference)*

![Muscles of the Upper Limb - Clinical Figure 14](/lessons/images/upper-limb-anatomy/muscles-of-the-upper-limb/figure_14_p7.png)
*Muscles of the Upper Limb — Clinical Figure 14 (Page 7 Reference)*

Pectoralis Major: large fan shaped and most superficial muscle
of the pectoral region.
Origin:
Clavicular head: Medial clavicle
Sternocostal head originates from the anterior surface of the
sternum, the superior six costal cartilages and the
aponeurosis of the external oblique muscle.
Insertion: intertubercular sulcus of the humerus
Function: Adduction and medial rotation of the upper limb
and draws the scapula Antero inferiorly.
Innervation: Lateral and medial pectoral nerves
Pectoralis minor: small muscle lies underneath the pectoralis
major.
Origin: Originates from the 3rd-5th ribs
Insertion: coracoid process of the scapula
Function: stabilization, depression, abduction or protraction,
internal rotation and downward rotation of the scapula.
Innervation: Medial pectoral nerve
Serratus anterior: Located more laterally in the chest wall
Origin: Consists of several muscular strips originate from lateral
surface of ribs 1-8
Insertion: Attach to the costal surface of medial border of
scapula
Function: holds the scapula against the ribcage and assist in
protraction and rotation of scapula
Innervation: Long thoracic nerve

> [!TIP]
> **Clinical pearl:**
> winging of scapula: Scapula no longer held against the rib
> cage and protrudes out of the back due to paralysis of serratus
> anterior and injury to Long thoracic nerve.

Subclavius: Small muscle located underneath the clavicle
Origin: First rib and its costal cartilage
Insertion: Inferior surface of middle third of clavicle
Function: Anchors and depresses clavicle
Innervation: Nerve to subclavius.
Previous Next

![Muscles of the Upper Limb - Clinical Figure 15](/lessons/images/upper-limb-anatomy/muscles-of-the-upper-limb/figure_15_p9.png)
*Muscles of the Upper Limb — Clinical Figure 15 (Page 9 Reference)*',
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

  -- Lesson: Upper Limb Dermatomes, Myotomes and Reflexes (3 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'upper-limb-dermatomes-myotomes-and-reflexes',
    'Upper Limb Dermatomes, Myotomes and Reflexes',
    'article',
    '# Upper Limb Dermatomes, Myotomes and Reflexes

Dermatomes of Upper Limb:
Dermatome: A dermatome is defined as ''a strip of skin that is
innervated by a single spinal nerve and clinically very
important and help in diagnosis of spinal cord injury
Myotomes and associated
movements:
Myotome: Group of muscles innervated by a single spinal
nerve
Reflexes of upper Limb:

Overview  Comments

![Upper Limb Dermatomes, Myotomes and Reflexes - Clinical Figure 1](/lessons/images/upper-limb-anatomy/upper-limb-dermatomes-myotomes-and-reflexes/figure_01_p1.png)
*Upper Limb Dermatomes, Myotomes and Reflexes — Clinical Figure 1 (Page 1 Reference)*

![Upper Limb Dermatomes, Myotomes and Reflexes - Clinical Figure 2](/lessons/images/upper-limb-anatomy/upper-limb-dermatomes-myotomes-and-reflexes/figure_02_p1.png)
*Upper Limb Dermatomes, Myotomes and Reflexes — Clinical Figure 2 (Page 1 Reference)*

Previous Next

![Upper Limb Dermatomes, Myotomes and Reflexes - Clinical Figure 3](/lessons/images/upper-limb-anatomy/upper-limb-dermatomes-myotomes-and-reflexes/figure_03_p2.png)
*Upper Limb Dermatomes, Myotomes and Reflexes — Clinical Figure 3 (Page 2 Reference)*',
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

  -- Lesson: Upper Limb Other Important Structures (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'upper-limb-other-important-structures',
    'Upper Limb Other Important Structures',
    'article',
    '# Upper Limb Other Important Structures

Carpal Tunnel:
The carpel tunnel is the space that lies between the flexor
retinaculum.
Contents of the carpal tunnel
Note:
The ulnar nerve, ulnar artery and tendon of Palmaris longus
runs superficial to flexor retinaculum and thus are not within
carpel tunnel.
Flexor pollicis longus enter the carpel tunnel before reaching
its insertion on the distal phalanx of the thumb.
Pronator quadratus is confined to the distal forearm and does
not reach the carpel tunnel.
Anatomical snuffbox
is a triangular depression found on the lateral aspect of the
dorsum of the hand. It is best seen when the thumb is
extended.

Overview  Comments

![Upper Limb Other Important Structures - Clinical Figure 1](/lessons/images/upper-limb-anatomy/upper-limb-other-important-structures/figure_01_p1.png)
*Upper Limb Other Important Structures — Clinical Figure 1 (Page 1 Reference)*

![Upper Limb Other Important Structures - Clinical Figure 2](/lessons/images/upper-limb-anatomy/upper-limb-other-important-structures/figure_02_p1.png)
*Upper Limb Other Important Structures — Clinical Figure 2 (Page 1 Reference)*

> [!TIP]
> **Clinical Pearl:**
> Fracture of scaphoid bone: Falling on outstretched hand. The
> scaphoid bone of the hand is the most commonly fractured
> carpal bone
> Clinical feature: Pain and tenderness in the anatomical
> snuffbox.

Ulnar canal (Guyon''s canal)
Transmits ulnar neurovascular bundle from forearm into the
hand.
Borders:
Medial (ulnar): pisiform, flexor carpi ulnaris tendon
Lateral (radial): hook of hamate.
Roof: palmar carpal ligament.
Floor: flexor retinaculum
Contents: Ulnar nerve and artery

> [!TIP]
> **Clinical Pearl:**
> Ulnar canal syndrome refers to compression of the ulnar
> nerve within the ulnar canal.

Flexor Retinaculum:
The flexor retinaculum is a thickened band of fibrous
connective tissue on the volar aspect of the hand which forms
the roof of the carpal tunnel. The flexor retinaculum holds the
flexor tendons in place at the wrist and prevents them from
bowstringing.
Relations of flexor retinaculum:
The ulnar artery, ulnar nerve, tendon of the palmaris longus
and palmar cutaneous branch of the median nerve pass
into the hand anterior to the flexor retinaculum, and
therefore do not pass through the carpal tunnel.
The flexor carpi radialis tendon passes through the lateral
aspect of the flexor retinaculum into the hand.
The four tendons of the flexor digitorum profundus, the four
tendons of the flexor digitorum superficialis, the tendon of
the flexor pollicis longus and the median nerve pass into the
hand posterior to the flexor retinaculum, within the carpal
tunnel.

Extensor Retinaculum:
The extensor retinaculum lies obliquely across the extensor
surface of the wrist joint, thickened part of the antecubital
fossa and that holds the extensor tendons in place during
movement of the wrist.
Attachments:
Laterally: Lower part of the anterior border of the radius
Medially: Styloid process of the ulna, Triquetral, and Pisiform
Contents
The extensor tendons pass through the extensor tunnel, deep
to the extensor retinaculum, in six compartments lined by
synovial sheaths:
The tendons of the extensor carpi ulnaris and extensor digiti
minimi have separate sheaths on the medial side of the
wrist.
The tendons of the extensor digitorum and extensor indicis
share a synovial sheath on the posterior surface of the wrist.
The tendons of the abductor pollicis longus and extensor
pollicis brevis, the extensor carpi radialis longus and extensor
carpi radialis brevis, and the extensor pollicis longus have
three separate sheaths on the lateral side of the wrist.
Other Clinical High Yield Stuff:

### 1: Dupuytren contracture: is a progressive thickening,

shortening, and fibrosis of the palmar fascia. producing a fixed
flexion contracture of the hand, in which the fingers bend
toward the palm and cannot be fully extended (commonly
fourth and fifth fingers).

### 2: Volkmann contracture: is an ischemic contracture (flexion

deformity) resulting from necrosis of the forearm flexor
muscles.

### 3: Tenosynovitis:  is commonly caused by an infection of the

synovial sheath and tendon (the long flexor tendon), causing
pain, swelling, and difficulty moving a joint. Rupture of the
tendon sheath (puncture injury of the palm) may cause the
spread of infection to the mid-palmar space and to the carpal

tunnel. Likewise, tenosynovitis in the thumb may spread to the
radial bursa and in the little finger to the ulnar bursa.
Note: Infection in the middle three fingers is usually contained
as they have separate synovial sheaths.
The synovial sheath of the little finger is usually continuous
with the common flexor sheath (the ulnar bursa) and thus
infection may spread to this sheath and from here to the
mid-palmar space.
Infections in the thumb may spread to the mid-palmar space
via the continuous synovial sheath of the flexor pollicis
longus (the radial bursa).

### 4: Trigger finger: occurs when the long flexor tendon develops

a nodule or swelling that interferes with its gliding through the
pulley, causing pain at the joint and an audible clicking or
snapping. The condition is caused by rheumatoid arthritis,
repetitive trauma, and wear and tear of aging of the tendon.

### 5: Mallet finger (hammer finger or baseball finger) is a finger

with permanent flexion of the distal phalanx as a result of an
avulsion of the lateral bands of the extensor tendon to the
distal phalanx.

### 6:  Boutonniere deformity is a finger with abnormal flexion of

the middle phalanx and hyperextension of the distal phalanx as
a result of a rupture of the central band of the extensor tendon

### 7:  Pancoast tumor in the apex of the lung can result in lower

trunk injury and, occasionally, Horner syndrome because of
sympathetic ganglion compression (ptosis, anhidrosis, and
pupillary constriction). It can also cause thoracic outlet
syndrome.
Previous Next',
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

  -- Lesson: Venous Drainage of Upper Limb (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'venous-drainage-of-upper-limb',
    'Venous Drainage of Upper Limb',
    'article',
    '# Venous Drainage of Upper Limb

Venous Drainage of the Upper Limb
Deep and superficial venous arches: Are formed by a pair of
venae comitantes, which accompany each of the deep and
superficial palmar arterial arches.
The superficial veins of the upper limb lie in the superficial
fascia and of great clinical importance.
Dorsal venous network lies on the dorsum of hand. It is
drained on the lateral side by cephalic vein and on the
medial side by the basilic vein.
Note:

### 1. The median cubital vein connects the cephalic vein to the

basilic vein. It lies superficial to bicipital aponeurosis, which
separates it from the brachial artery. The median cubital vein
is a common site of venipuncture.

### 2. Deep veins of the arm and forearm: Follow the course of the

arteries, accompanying them as their venae comitantes.

### 3. The brachial veins are the vena comitantes of the brachial

artery and are joined by the basilic vein to form the axillary
vein.
Axillary Vein:
Is formed at the lower border of the teres major muscle by
the union of the brachial veins (vena comitantes of the brachial
artery) and the basilic vein and ascends along the medial side
of the axillary artery. Continues as the subclavian vein at the
inferior margin of the first rib.
Previous Next

Overview  Comments',
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
  -- Module 2: Lower Limb Anatomy (9 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Lower Limb Anatomy' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Lower Limb Anatomy', 1, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 1, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Arterial Supply of Lower Limb (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'arterial-supply-of-lower-limb',
    'Arterial Supply of Lower Limb',
    'article',
    '# Arterial Supply of Lower Limb

### 1: Femoral Artery:

The femoral artery is a continuation of the external iliac artery.
It begins behind the inguinal ligament, where it lies midway
between the anterior superior iliac spine and the symphysis
pubis (the site for taking a femoral pulse). The artery
descends through the femoral triangle and the adductor canal,
and it leaves the front of the thigh by passing through the
opening in the adductor magnus and then entering the
popliteal space as the popliteal artery.
Note: In the femoral triangle, the artery is related laterally to
the femoral nerve and medially, in the upper part of its
course, to the femoral vein
Branches of femoral artery:
Superficial circumflex iliac artery, which arises just below the
inguinal ligament and runs laterally toward the anterior
superior iliac spine.
Superficial epigastric artery, which arises just below the
inguinal ligament and runs upward to the abdominal wall.
Deep external pudendal artery and the superficial external
pudendal artery arise just below the inguinal ligament and
run medially to supply the skin of the scrotum (or labium
majus).
Profunda femoris artery, which is a large branch that arises
from the femoral artery approximately 4 cm below the
inguinal ligament. It supplies structures in the anterior,
medial, and posterior fascial compartments of the thigh.

### 2: Popliteal artery:

Popliteal artery is a continuation of femoral artery. It extends
from the opening in the adductor magnus to the lower border

Overview  Comments

of popliteus muscle, where it divides into anterior and posterior
tibial arteries.
Anterior Tibial Artery:
The anterior tibial artery arises at the bifurcation of the
popliteal artery in the popliteal fossa. It passes forward
between the tibia and the fibula through the upper part of
the interosseus membrane and enters the anterior
compartment of the leg. It then descends with the deep
peroneal nerve to the front of the ankle joint, where it
becomes the dorsalis pedis artery
Posterior Tibial Artery
The posterior tibial artery arises at the bifurcation of the
popliteal artery in the popliteal fossa. It descends in the
posterior compartment of the leg and is accompanied by the
tibial nerve. The artery terminates behind the medial malleolus
by dividing into the medial and the lateral plantar arteries.
Medial Plantar Artery
The medial plantar artery is the smaller of the terminal
branches of the posterior tibial artery. It runs forward along the
medial border of the foot with the medial plantar nerve, and it
gives off many muscular and cutaneous branches.
Lateral Plantar Artery
The lateral plantar artery is the larger of the terminal
branches of the posterior tibial artery. It runs for- ward deep
to the abductor hallucis and the flexor digitorum brevis
muscles with the lateral plantar nerve, and it ends by curving
medially to form the plantar arch through anastomosis with
the dorsalis pedis artery. The plantar arch gives off
perforating and metatarsal arteries; the metatarsal arteries
give rise to digital arteries.
Clinical high yield:
Medical personal should know the precise position of the main
arteries within the lower limb.
Femoral artery: This enters the thigh behind the inguinal
ligament at a point midway between the anterior superior
iliac spine and the symphysis pubis.

Popliteal artery: This artery can be felt by gentle palpation in
the depths of the popliteal space, provided that the deep
fascia is fully relaxed by passively flexing the knee joint.
Dorsalis pedis artery: This artery lies between the tendons of
the extensor hallucis longus and the extensor digitorum
longus, midway between the medial and lateral malleoli on
the front of the ankle.
Posterior tibial artery: This artery passes behind the medial
malleolus, beneath the flexor retinaculum, and lies between
the tendons of flexor digitorum longus and the flexor hallucis
longus. The pulsations of the artery can be felt midway
between the medial malleolus and the heel.
Previous Next',
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

  -- Lesson: Bones of the Lower Limb (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'bones-of-the-lower-limb',
    'Bones of the Lower Limb',
    'article',
    '# Bones of the Lower Limb

Hip Bone:
The bones of the pelvis consist of the right and left hip bones,
the sacrum and the coccyx.
The hip bones articulate posteriorly with the sacrum at the
sacroiliac joints and with each other anteriorly at the pubic
symphysis.
Hip bone has a large articular socket on the lateral surface,
the acetabulum, which together with the head of the femur,
forms the hip joint.
Each of the hip bones is formed by
Ilium (superiorly)
Pubis (anteroinferiorly)
Ischium (posteroinferiorly).
Joints of the pelvis:
Lumbosacral joint: It is the joint between vertebra L5 and the
base of the sacrum, joined by an intervertebral disk and
supported by the illolumbar ligaments.
Sacroiliac joint: is a synovial joint of an irregular plane type
between the articular surfaces of the sacrum and illum Is
covered by cartilage and is supported by the anterior, posterior,
and interosseous sacroiliac ligaments. Transmits the weight of
the body to the hip bone.
Sacrococcygeal joint Is a cartilaginous joint between the
sacrum and coccyx, reinforced by the anterior, posterior, and
lateral sacrococcygeal ligaments.
Pubic symphysis Is a cartilaginous or fibrocartilaginous joint
between the pubic bones in the median plane.
Sacrotuberous and sacrospinous ligaments:

Overview  Comments

Patella:
Patella is largest sesamoid bone lies within the tendon of
quadriceps femoris muscle.
The patellar ligament is an inferior continuation of the
quadriceps tendon that inserts at the tibial tuberosity.
Factors stabilizing patella
There are several structures that work together to keep the
patella aligned and stabilized on the femur to prevent
excessive lateral movement of the patella
Vastus medialis muscle on the medial thigh acts to draw
the patella in a medial direction., the patella is much more
susceptible to dislocation if there is weak vastus medialis
muscle.
The medial patellofemoral ligament, extending from the
medial aspect of the patella to the medial femoral condyle,
provides a significant force against lateral displacement.
The lateral femoral condyle on the lateral aspect of the
trochlear groove is normally slightly higher than the medial
aspect, providing a buttress to the patella on the lateral side.

![Bones of the Lower Limb - Clinical Figure 1](/lessons/images/lower-limb-anatomy/bones-of-the-lower-limb/figure_01_p2.png)
*Bones of the Lower Limb — Clinical Figure 1 (Page 2 Reference)*

Patellar dislocation: Most common dislocations of the occur
laterally and are caused by high force impact on the patella.
Bones of the foot:
There are three groups of bones in the foot

### 1: Seven-tarsal bone

### 2: Five metatarsal bones

### 3: Fourteen phalanges.

The tarsal bones are organized into three rows:
Proximal group: Talus and Calcaneus
Intermediate: Navicular
Distal group: Cuboid and Cuneiforms

Previous Next

![Bones of the Lower Limb - Clinical Figure 2](/lessons/images/lower-limb-anatomy/bones-of-the-lower-limb/figure_02_p4.png)
*Bones of the Lower Limb — Clinical Figure 2 (Page 4 Reference)*',
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

  -- Lesson: Dermatomes, Myotomes and Reflexes of Lower Limb (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'dermatomes-myotomes-and-reflexes-of-lower-limb',
    'Dermatomes, Myotomes and Reflexes of Lower Limb',
    'article',
    '# Dermatomes, Myotomes and Reflexes of Lower Limb

Dermatomes and Myotomes of Lower
Limb:
Lower Limb Reflexes:
Previous Next

Overview  Comments

![Dermatomes, Myotomes and Reflexes of Lower Limb - Clinical Figure 1](/lessons/images/lower-limb-anatomy/dermatomes-myotomes-and-reflexes-of-lower-limb/figure_01_p1.png)
*Dermatomes, Myotomes and Reflexes of Lower Limb — Clinical Figure 1 (Page 1 Reference)*

![Dermatomes, Myotomes and Reflexes of Lower Limb - Clinical Figure 2](/lessons/images/lower-limb-anatomy/dermatomes-myotomes-and-reflexes-of-lower-limb/figure_02_p1.png)
*Dermatomes, Myotomes and Reflexes of Lower Limb — Clinical Figure 2 (Page 1 Reference)*',
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

  -- Lesson: Joints of the Lower Limb (4 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'joints-of-the-lower-limb',
    'Joints of the Lower Limb',
    'article',
    '# Joints of the Lower Limb

Joints of the lower limb:

### 1: Ligaments of the hip joint:

Intracapsular
The only intracapsular ligament is the ligament of head of
femur (Ligamentum teres). It is a relatively small structure,
which runs from the acetabular fossa to the fovea of the femur.
Extracapsular ligaments:
Iliofemoral ligament: Strongest of all located anteriorly,
prevents hyperextension of the hip joint.
Ischiofemoral:  Reinforcing the capsule posteriorly. Preventing
hyperextension and medial rotation of the femur at hip joint

Overview  Comments

![Joints of the Lower Limb - Clinical Figure 1](/lessons/images/lower-limb-anatomy/joints-of-the-lower-limb/figure_01_p1.png)
*Joints of the Lower Limb — Clinical Figure 1 (Page 1 Reference)*

Pubofemoral:  Reinforcing the capsule anteriorly and inferiorly
preventing excessive abduction and extension.
Note: Most common hip dislocation is posterior and sciatic
nerve is most commonly injured

### 2: Ligaments of knee joint:

The major ligaments in the knee joint are:
Patellar ligament: continuation of the quadriceps femoris
tendon distal to the patella. It attaches to the tibial
tuberosity.
Collateral ligaments: Prevent excessive medial or lateral
movement.
Tibial (medial) collateral ligament: wide and flat ligament,
found on the medial side of the joint, act to stabilize the joint
medially.
Fibular (lateral) collateral ligament: Attached distally to the
lateral fibula act to stabilize the knee joint laterally.
Valgus deformity: Also known as Knock-Kneed.
More stress on lateral compartment
Ligament damaged is Medial collateral.
Varus deformity: Also known as bow legged.
More stress on medial compartment
Ligament damaged is lateral collateral.
Note: lateral collateral ligament inserts on the head of fibula
where it joins with bicep femoris tendon to form conjoint
tendon.
Cruciate Ligaments
Anterior cruciate ligament: Attaches at the anterior
intercondylar region of the tibia where it blends with the
medial meniscus. It ascends posteriorly to attach to the femur
in the intercondylar fossa. It prevents anterior dislocation of

the tibia onto the femur. ACL relax during flexion and taut
during extension torn in hyperextension injury.
Posterior cruciate ligament: Attaches at the posterior
intercondylar region of the tibia and ascends anteriorly to
attach to the anteromedial femoral condyle. It prevents
posterior dislocation of the tibia onto the femur. PCL relax
during extension and taut during flexion, torn in hyperflexion
injury
Note:
Unhappy triad:  common in Rugby players. lateral blow to the
extended knee with a twisting fall to the same side
Refers to injury of Medial collateral, medial meniscus and
anterior cruciate ligament
Bursae of the knee joint:
Bursa: synovial fluid filled sac within joints provide low friction
surfaces for the movement of tendons associated with joint.
Suprapatellar bursa located between the quadriceps
femoris and the femur (Recall)
Prepatellar bursa found between the apex of the patella and
the skin. Housemaid knee (Swelling on the anterior side of
knee) is due to inflammation of Prepatellar bursa
Infrapatellar bursa: split into deep and superficial. The deep
bursa lies between the tibia and the patella ligament. The
superficial lies between the patella ligament and the skin.
Clergyman''s Knee is due to inflammation of infrapatellar
bursa caused by clergymen kneeling on hard surfaces during
prayer
Menisci of knee joint:
The medial and lateral menisci are fibrocartilage structures in
the knee that serve two functions:

Deepen the articular surface of the tibia, thus increasing
stability of the joint.
Acting as a shock absorber by increasing surface area to
further dissipate forces
Medial menisci also fixed to tibial collateral ligament,
Damage to the tibial collateral ligament also results in a
medial meniscal tear.
Note: Locking- Unlocking mechanism of knee joint
Locking of Knee: During fully extended knee, the knee
passively locks because of medial rotation of the femoral
condyles on the tibial plateau (the "screw-ho mechanism"). Full
medial rotation and extension tightens all the ligaments.
Unlocking of Knee: Locking is reversed by contraction of
popliteus muscle by initiating lateral movement of femur on
tibia
Ankle ligaments
Eversion injury = medial ligament or medial deltoid ligament
injury associated with tear of medial malleolus most
commonly
inversion injury= Lateral collateral ligament injured (subdivided
into 3 ligaments) most frequent ligament injury during ankle
sprain or inversion injury commonly affected ligament is
Anterior talofibular ligament followed by calcaneofibular
ligament (both are ligaments of lateral collateral ligament)
associated with tear of lateral malleolus most commonly
Least injured during inversion injury post talofibular
ligament
The spring ligament (plantar calcaneonavicular ligament) is a
broad thick ligament that extends from the calcaneus to the
navicular bone. It supports the head of the talus, maintaining
the stability of the talocalcaneonavicular joint and resists
depression of the medial arch of the foot. The spring ligament
takes the weight of the body from the talus and transmits it to
the forefoot.

Tibiofibular joint
Sub talar joint:
Talocalcaneonavicular joint:

![Joints of the Lower Limb - Clinical Figure 2](/lessons/images/lower-limb-anatomy/joints-of-the-lower-limb/figure_02_p5.png)
*Joints of the Lower Limb — Clinical Figure 2 (Page 5 Reference)*

![Joints of the Lower Limb - Clinical Figure 3](/lessons/images/lower-limb-anatomy/joints-of-the-lower-limb/figure_03_p5.png)
*Joints of the Lower Limb — Clinical Figure 3 (Page 5 Reference)*

![Joints of the Lower Limb - Clinical Figure 4](/lessons/images/lower-limb-anatomy/joints-of-the-lower-limb/figure_04_p5.png)
*Joints of the Lower Limb — Clinical Figure 4 (Page 5 Reference)*

Previous Next',
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

  -- Lesson: Lower Limb Other Significant Structures (3 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'lower-limb-other-significant-structures',
    'Lower Limb Other Significant Structures',
    'article',
    '# Lower Limb Other Significant Structures

Femoral Triangle:
The wedge-shaped area is located within the superomedial
aspect of the anterior thigh.

> [!TIP]
> **High Yield:**
> Contents of Femoral Triangle:
> From lateral to medial: Useful mnemonic (NAVEL)
> Femoral nerve
> Femoral artery
> Femoral vein
> Empty space (consists of femoral canal)
> Lymph nodes
> Note: Femoral nerve lies lateral to femoral artery and vein

> [!TIP]
> **Clinical pearls: In Femoral hernia part of the bowel pushes**
> into the femoral canal underneath the femoral triangle.

Femoral Sheath:
The femoral sheath originates as a prolongation of
extraperitoneal fascia and encloses the femoral artery, femoral
vein and femoral canal.
Note: The femoral nerve does not lie within the femoral sheath,
but instead lies lateral to it.

Overview  Comments

![Lower Limb Other Significant Structures - Clinical Figure 1](/lessons/images/lower-limb-anatomy/lower-limb-other-significant-structures/figure_01_p1.png)
*Lower Limb Other Significant Structures — Clinical Figure 1 (Page 1 Reference)*

Femoral Canal:
The Femoral canal lies most medial of the femoral sheath.
Borders of the femoral canal: (Useful mnemonic LAMP: FILP)
Lateral border: Femoral vein (Immediately lateral)
Anterior border: Inguinal ligament
Medial border: Lacunar ligament
Posterior ligament: Pectineal ligament, Pectineus muscle
and superior ramus of pubic bone.
Contents: Deep inguinal lymph nodes, lymphatic vessels,
empty space and loose connective tissue.

> [!TIP]
> **Clinical pearls: In Femoral hernia part of the bowel pushes**
> into the femoral canal underneath the femoral triangle.

The Arches of Foot:
Foot has three arches, one transverse arch and two
longitudinal (medial and lateral) arches. Shape of arches allows
them to act in the same way as a spring, bearing the weight of
the body and absorbing the shock produced during
locomotion.
Formed by tarsal, metatarsal bones and supported by
ligaments.
Popliteal Fossa:
Diamond shaped area located on the posterior aspect of the
knee, and is the pathway to pass by which vessels and nerves
pass between the thigh and the leg.

![Lower Limb Other Significant Structures - Clinical Figure 2](/lessons/images/lower-limb-anatomy/lower-limb-other-significant-structures/figure_02_p2.png)
*Lower Limb Other Significant Structures — Clinical Figure 2 (Page 2 Reference)*

Boundaries and Contents of Popliteal
Fossa:
Contents (From medial to lateral): Popliteal artery, popliteal
vein, tibial nerve and common fibular nerve.
Note: Tibial and common fibular nerve are the most superficial
contents of the popliteal fossa. Both are the branches of sciatic
nerve
The common fibular nerve follows the biceps femoris
tendon, travelling along the lateral margin of the popliteal
Tibial nerve lies more medial to common fibular nerve.
Previous Next

![Lower Limb Other Significant Structures - Clinical Figure 3](/lessons/images/lower-limb-anatomy/lower-limb-other-significant-structures/figure_03_p3.png)
*Lower Limb Other Significant Structures — Clinical Figure 3 (Page 3 Reference)*',
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

  -- Lesson: Lymphatic Drainage of Lower Limb (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'lymphatic-drainage-of-lower-limb',
    'Lymphatic Drainage of Lower Limb',
    'article',
    '# Lymphatic Drainage of Lower Limb

Inguinal lymph Nodes:
The inguinal lymph nodes are found in the upper aspect of the
femoral triangle.
Superficial Inguinal Nodes:
The superficial inguinal lymph nodes are located in the
superficial fascia, forming a line below the inguinal ligament,
and medially extending inferiorly along the terminal part of the
great saphenous vein. They receive lymph from the gluteal
region, lower abdominal wall, perineum, and superficial regions
of the lower limb.
Superficial inguinal lymph nodes drain into deep inguinal
nodes.
Deep Inguinal Nodes:
Lie along the medial side of femoral vein within the femoral
canal. They receive all lymph from superficial inguinal lymph
nodes, deep lymphatics associated with the femoral vessels
and from the glans penis or clitoris in the perineum.
The inguinal lymph nodes drain to the external iliac lymph
nodes associated with the external iliac artery in the
abdomen.

> [!TIP]
> **High Yield to remember:**
> Penile skin and prepuce = superficial inguinal lymph nodes
> Glans penis and penile urethra=deep inguinal lymph nodes
> Scrotum=Superficial inguinal lymph nodes
> Testes= lumber or para-aortic lymph nodes
> prostate= internal iliac nodes

> Overview  Comments

Previous Next',
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

  -- Lesson: Muscles of the Lower Limb (9 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'muscles-of-the-lower-limb',
    'Muscles of the Lower Limb',
    'article',
    '# Muscles of the Lower Limb

Muscles of Gluteal Region:
Muscles of the gluteal region are divided into two groups.

### 1: Superficial gluteal muscles

Note: Greater trochanter of femur is site of insertion of gluteus
Medius, minimums and piriformis.

### 2: Deep gluteal muscles:

Note: The piriformis muscle is an important landmark in the
gluteal region. The superior gluteal nerve and vessels emerge
into the gluteal region superiorly to the piriformis. Sciatic nerve
enters the gluteal region directly inferior to the piriformis
muscle.

> [!TIP]
> **Clinical pearls:**

> Overview  Comments

![Muscles of the Lower Limb - Clinical Figure 1](/lessons/images/lower-limb-anatomy/muscles-of-the-lower-limb/figure_01_p1.png)
*Muscles of the Lower Limb — Clinical Figure 1 (Page 1 Reference)*

![Muscles of the Lower Limb - Clinical Figure 2](/lessons/images/lower-limb-anatomy/muscles-of-the-lower-limb/figure_02_p1.png)
*Muscles of the Lower Limb — Clinical Figure 2 (Page 1 Reference)*

Trendelenburg Sign: Trendelenburg gait or waddling gait
occurs when your hip abductor muscles are weakened. This
muscle group includes the gluteus Medius and minimus
innervated by superior gluteal nerve. The weakness of these
muscles causes drooping of the pelvis to the contralateral
side while walking.
The Trendelenburg sign is produced when the patient is asked
to stand without support on each leg. In a positive sign, pelvic
drop will occur on the unsupported leg. For example, if the
right gluteal muscles are weak, the left side of the pelvis will
drop.
Anterior compartment of thigh
muscles:
Note: All the muscles of anterior compartment of thigh are
flexors of thigh at hip joint, while quadriceps femoris is
extensor of thigh at knee joint and Sartorius also flexes thigh at
knee.
Note:    Sartorius originates from anterior superior iliac spine
Rectus femoris originates from anterior inferior iliac spine.
Medial Compartment of thigh
muscles:
Medial compartment consists of five Indvidual muscles.
All the muscles of medial compartment of thigh causes
adduction of thigh at hip joint except obturator externus which

![Muscles of the Lower Limb - Clinical Figure 3](/lessons/images/lower-limb-anatomy/muscles-of-the-lower-limb/figure_03_p2.png)
*Muscles of the Lower Limb — Clinical Figure 3 (Page 2 Reference)*

causes lateral rotation of thigh at hip joint.
Gracilis along with adduction at hip joint also assist in flexion at
knee joint.
Posterior thigh muscles: Also known as hamstrings, consists
of three individual muscles.
Note: All the muscles of posterior compartment of thigh are
extensors of thigh at hip and flexors at knee joint. While Biceps
femoris is also lateral rotator of thigh at hip joint and
Semitendinosus and Semimembranosus also medial rotators of
thigh at hip joint

![Muscles of the Lower Limb - Clinical Figure 4](/lessons/images/lower-limb-anatomy/muscles-of-the-lower-limb/figure_04_p3.png)
*Muscles of the Lower Limb — Clinical Figure 4 (Page 3 Reference)*

![Muscles of the Lower Limb - Clinical Figure 5](/lessons/images/lower-limb-anatomy/muscles-of-the-lower-limb/figure_05_p3.png)
*Muscles of the Lower Limb — Clinical Figure 5 (Page 3 Reference)*

> [!TIP]
> **Clinical pearls: All the muscles of the posterior thigh originate**
> from the ischial tuberosity of the pelvis. In some cases, mostly
> in young athletes, sudden and forceful contraction of the
> hamstring muscles can result in an avulsion fracture of the
> ischial tuberosity. It can also be associated with sciatic nerve
> damage.

Muscles in the anterior compartment
of leg:
Anterior leg consists of four muscles

> [!TIP]
> **Clinical pearls: Foot Drop (Discussed in nerves of the lower**
> limb)
> Muscles in the Posterior compartment of leg: Consists of
> seven muscles divided into superficial and deep groups. All are
> innervated by tibial nerve
> Superficial group: Mnemonic (GPS)

![Muscles of the Lower Limb - Clinical Figure 6](/lessons/images/lower-limb-anatomy/muscles-of-the-lower-limb/figure_06_p4.png)
*Muscles of the Lower Limb — Clinical Figure 6 (Page 4 Reference)*

Deep muscles in the posterior leg:

> [!TIP]
> **Clinical pearls:**
> Ruptured calcaneal tendon: Tear of calcaneal tendon occurs
> during forceful plantarflexion of the foot. Patients will be
> unable to plantarflex the foot and affected foot will be
> permanently dorsiflexed.

Muscles in the lateral compartment
of leg:
Consists of two muscles, fibularis longus and brevis also
called peroneus longus and peroneus brevis.

![Muscles of the Lower Limb - Clinical Figure 7](/lessons/images/lower-limb-anatomy/muscles-of-the-lower-limb/figure_07_p5.png)
*Muscles of the Lower Limb — Clinical Figure 7 (Page 5 Reference)*

![Muscles of the Lower Limb - Clinical Figure 8](/lessons/images/lower-limb-anatomy/muscles-of-the-lower-limb/figure_08_p5.png)
*Muscles of the Lower Limb — Clinical Figure 8 (Page 5 Reference)*

Muscles of the Sole of foot:
Muscles of sole of foot. (4 layers) = Must remember
highlighted one
First layer: Abductor hallucis, flexor digitorum brevis &
abductor digitorum minimi
Second layer: flexor digitorum accessorius, 4 lumbricals and
tendons of flexor hallucis longus and flexor digitorum
longus
Third layer: flexor hallucis brevis, flexor digitorum minimi
brevis & adductor hallucis
Fourth layer: Plantar and dorsal interossei muscles, Two long
tendons of extrinsic muscles - tibialis posterior and fibularis
longus.
Note: Plantar arteries and nerves lie within the first and
second layer of the sole of foot.
Previous Next

![Muscles of the Lower Limb - Clinical Figure 9](/lessons/images/lower-limb-anatomy/muscles-of-the-lower-limb/figure_09_p6.png)
*Muscles of the Lower Limb — Clinical Figure 9 (Page 6 Reference)*',
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

  -- Lesson: Nerves of the Lower Limb (4 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'nerves-of-the-lower-limb',
    'Nerves of the Lower Limb',
    'article',
    '# Nerves of the Lower Limb

Femoral nerve
Nerve roots: L2-L4
Motor functions: Innervates the anterior thigh muscles.
Sensory functions:
Anatomical course:
The femoral nerve is the largest branch of the lumbar plexus.
It is derived from the anterior rami of nerve roots L2, L3 and
L4
After arising from the lumbar plexus, the femoral nerve
travels inferiorly through the psoas major muscle of the
posterior abdominal wall. It supplies branches to the iliacus
and pectineus muscles in the abdomen prior to entering the
thigh.
Passing underneath the inguinal ligament to enter the
femoral triangle, in this triangle femoral nerve is located
lateral to femoral vessels (Femoral artery and Vein). Useful

> [!NOTE]
> **Mnemonic from lateral to medial (NAVEL). Below the inguinal**
ligament femoral nerve divides into anterior and posterior
divisions

### 1: Anterior division of the femoral nerve

Anterior cutaneous branches
Branch to sartorius
Branch to pectineus

### 2: Posterior division of the femoral nerve

Saphenous nerve
Branches to quadriceps femoris

Overview  Comments

![Nerves of the Lower Limb - Clinical Figure 1](/lessons/images/lower-limb-anatomy/nerves-of-the-lower-limb/figure_01_p1.png)
*Nerves of the Lower Limb — Clinical Figure 1 (Page 1 Reference)*

Note: In posterior abdominal wall. Femoral nerve supplies
branches to the iliacus and pectineus muscles prior to entering
the thigh.
Femoral nerve Sensory innervation of lateral and posterior
thigh: (Important to remember)

> [!TIP]
> **Clinical pearls: Damage to the femoral nerve causing impaired**
> flexion at hip and impaired extension of the leg resulting from
> paralysis of the quadriceps femoris (Which include Rectus
> femoris, Vastus lateralis, Vastus medialis and Vastus
> intermedius.

Sensory loss: Loss of sensation over anteromedial thigh,
anteromedial knee, medial leg and medial foot.
Obturator nerve
Nerve roots: L2-L4
Motor functions: Innervates the medial thigh muscles.
Sensory functions: Upper medial thigh via cutaneous
branches
Anatomical course: Arises from the lumbar plexus and enters
the thigh through obturator foramen.
Note: The obturator nerve innervates all of the muscles of the
medial compartment of the thigh (except for the hamstring
part of the adductor magnus innervated by the tibial portion
of the sciatic nerve).
Clinical: Damage to the obturator nerve causes weakness of
adduction, resulting in a lateral swinging of the limb during
walking

![Nerves of the Lower Limb - Clinical Figure 2](/lessons/images/lower-limb-anatomy/nerves-of-the-lower-limb/figure_02_p2.png)
*Nerves of the Lower Limb — Clinical Figure 2 (Page 2 Reference)*

Sensory Loss: Loss of sensation over upper medial thigh
Sciatic nerve
Is the largest nerve in the body. Derived from the
lumbosacral plexus and receives fibers from L4-S3.
Function:

### 1: Motor functions: Innervates the muscles of the posterior

thigh (biceps femoris, semimembranosus and semitendinosus)
and the hamstring portion of the adductor magnus (remaining
portion of which is supplied by the obturator nerve).
Indirectly innervates (via its terminal branches) all the
muscles of the leg and foot.

### 2: Sensory functions: No direct sensory functions. Indirectly

innervates (via its terminal branches) the skin of the lateral leg,
heel, and both the dorsal and plantar surfaces of the foot.
Anatomical course: Sciatic nerve leaves the pelvis and enters
the gluteal region via greater sciatic foramen. It emerges
inferiorly to the piriformis muscle and descends in an
inferolateral direction and entering the posterior compartment
of the thigh. In the posterior compartment of the thigh, the
sciatic nerve lies on the adductor magnus muscle and is
crossed by the long head of the biceps femoris muscle. Within
the posterior thigh, the sciatic nerve gives rise to branches to
the hamstring muscles and adductor magus. When the
sciatic nerve reaches the apex of the popliteal fossa, it
terminates by bifurcating into the tibial and common fibular
nerves.

> [!TIP]
> **Clinical pearls:**
> Intramuscular injections in the gluteal region: The anatomical
> course of the sciatic nerve must be considered when
> administering intramuscular injections into the gluteal region.

The region can be divided into quadrants using 2 lines.

One line descends vertically from the highest point on the
iliac crest.
Other line passes through vertical line halfway between the
highest point.
Note: Sciatic nerve lies in the lower medial quadrant. To avoid
injury of sciatic nerve IM injections in the gluteal region only
be given in upper lateral quadrant.
Tibial nerve
Branch of sciatic nerve. Arises at apex of popliteal fossa
receiving nerve fibers from L4-S3.
Functions:
Motor: Innervates all the muscles in posterior compartment of
the leg and the majority of the intrinsic foot muscles.
Sensory: In the popliteal fossa, the tibial nerve gives off
cutaneous branches. These combine with branches from the
common fibular nerve to form the sural nerve. This sensory
nerve innervates the skin of the posterolateral side of the leg
and the lateral side of the foot and heel.
Sensory branches of tibial nerve:

> [!TIP]
> **Clinical pearls: Damage to the tibial nerve causes loss of**
> plantar flexion of the foot and impaired inversion. This
> presents with difficulty in getting the heel off the ground and a

![Nerves of the Lower Limb - Clinical Figure 3](/lessons/images/lower-limb-anatomy/nerves-of-the-lower-limb/figure_03_p4.png)
*Nerves of the Lower Limb — Clinical Figure 3 (Page 4 Reference)*

shuffling gait, resulting in characteristic clawing of the toes and
sensory loss on the sole of the foot, affecting posture and
locomotion.
Common fibular (Peroneal
nerve)
Arises as the smaller terminal portion of the sciatic nerve at the
apex of the popliteal fossa. The common fibular nerve
continues by wrapping around the neck of the fibula and
passing between the attachments of the fibularis longus
muscle to enter the lateral compartment of the leg where it
divides into its terminal branches, the superficial and deep
fibular nerves.
Note: It is very important to remember direct innervation of
common fibular nerve.
Deep fibular nerve root: L4-L5
Superficial fibular nerve root: L4-S1.

> [!TIP]
> **Clinical pearls:**

### 1: Common fibular nerve injury: Damage to the common

fibular (peroneal) nerve may occur as a result of fracture of the

![Nerves of the Lower Limb - Clinical Figure 4](/lessons/images/lower-limb-anatomy/nerves-of-the-lower-limb/figure_04_p5.png)
*Nerves of the Lower Limb — Clinical Figure 4 (Page 5 Reference)*

head or neck of the fibula because it passes behind the head of
the fibula and then winds laterally around the neck. The nerve
damage results in foot drop (loss of dorsiflexion) and loss of
sensation on the dorsum of the foot and lateral aspect of the
leg and causes paralysis of all muscles in the anterior and
lateral compartments of the leg (dorsiflexors and evertors
muscles of the foot).

### 2: Superficial fibular nerve: May be damaged by fracture of the

fibula. As the muscles that the superficial fibular nerve
innervates are evertors, injury to the nerve may result in a loss
of eversion and loss of sensation over the lower anterolateral
leg and dorsum of foot

### 3: Deep fibular nerve:

Motor Loss: Loss of dorsiflexion of ankle resulting in foot drop.
In foot drop foot will appear permanently plantarflexed, foot
drop with high-stepping gait, weakness of foot inversion.
Sensory Loss: Loss of sensation over webspace between 1st and
2nd toes.
Note: Footdrop is due to Common fibular or common
peroneal nerve or also due to deep fibular nerve injury.
Previous Next',
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

  -- Lesson: Venous Drainage of Lower Limb (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'venous-drainage-of-lower-limb',
    'Venous Drainage of Lower Limb',
    'article',
    '# Venous Drainage of Lower Limb

Superficial Veins of the Lower Limb
The great saphenous vein: originate from medial side of the
dorsal venous arch in the foot, passes anterior to the medial
malleolus (not posterior), travels up the medial side of leg,
knee and thigh to pass into saphenous opening in deep
fascia covering the femoral triangle and join with the femoral
vein below the inguinal ligament.
The small saphenous vein: originate from lateral side of
dorsal venous arch in the foot, passes posterior to lateral
malleolus and up the back of leg to pierce the deep fascia
and join the popliteal vein in popliteal fossa posterior to
knee.

> [!TIP]
> **Clinical Pearls:**
> Varicose veins: Develop in superficial veins of the lower limb
> because of reduced elasticity and incompetent valves in the
> veins causing them to become dilated and tortuous.

Previous Next

Overview  Comments',
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

  -- ==========================================================================
  -- Module 3: Thorax Anatomy & Mediastinum (11 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Thorax Anatomy & Mediastinum' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Thorax Anatomy & Mediastinum', 2, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 2, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Bones of Thorax (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'bones-of-thorax',
    'Bones of Thorax',
    'article',
    '# Bones of Thorax

Ribs:
Consist of 12 pairs of bones that form the main part of the bony
thoracic wall, extending from the vertebrae posteriorly to or
toward the sternum anteriorly. Increase the anteroposterior
and transverse diameters of the thorax by their movements.

### 1. Structure

Typical ribs are ribs 3 through 9, each of which has a head,
neck, tubercle, and body (shaft). The head articulates with the
corresponding vertebral bodies and intervertebral disks and
supra-adjacent vertebral bodies.
The body (shaft) is thin and flat and turns sharply anteriorly at
the angle; it has a costal groove that follows the inferior and
internal surface of the rib and shields the Intercostal vessels
and nerves from injury.
The tubercle articulates with the transverse processes of the
corresponding vertebrae, except ribs 11 and 12.

### 2. Classification

True ribs are the first seven ribs (ribs 1-7), which are attached
to the sternum by their costal cartilages.
False ribs are the lower five ribs (ribs 8-12); ribs 8 to 10 are
connected to the costal cartilages immediately above, and
thus, the 7th to 10th costal cartilages form the anterior costal
arch or costal margin.
Floating ribs are the last two ribs (ribs 11 and 12), which are
connected only to the vertebrae.
Intercostal space:
The intercostal space lies between adjacent ribs and mostly
contains intercostal muscles. Since there are 12 ribs on each
side, there are 11 intercostal spaces, each numbered for the rib
superior to it. Intercostal nerves, arteries and veins lie in the

Overview  Comments

costal groove along the inferior margin of the rib, lying in a
plane between the internal and innermost intercostal muscles.

> [!TIP]
> **Clinical pearls:**
> vein is the most superior structure in each intercostal space
> and is therefore highest in the costal groove. The artery is
> inferior to the vein and the nerve inferior to the artery and
> often not protected by the groove, (Useful mnemonic VAN).

Therefore, the nerve is the most vulnerable structure in a
penetrating injury to the upper aspect of the intercostal space.
Any needle or tube inserted in the intercostal space should be
placed immediately above the superior margin of a rib to avoid
injury to the intercostal neurovascular bundle.
Previous Next',
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

  -- Lesson: Dermatomes of Trunk (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'dermatomes-of-trunk',
    'Dermatomes of Trunk',
    'article',
    '# Dermatomes of Trunk

Dermatomal supply of trunk:

> [!TIP]
> **High yield:**
> Previous Next

> Overview  Comments

![Dermatomes of Trunk - Clinical Figure 1](/lessons/images/thorax-anatomy-mediastinum/dermatomes-of-trunk/figure_01_p1.png)
*Dermatomes of Trunk — Clinical Figure 1 (Page 1 Reference)*

![Dermatomes of Trunk - Clinical Figure 2](/lessons/images/thorax-anatomy-mediastinum/dermatomes-of-trunk/figure_02_p1.png)
*Dermatomes of Trunk — Clinical Figure 2 (Page 1 Reference)*',
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

  -- Lesson: Muscles of Thorax (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'muscles-of-thorax',
    'Muscles of Thorax',
    'article',
    '# Muscles of Thorax

Muscles of the thoracic cage:
These are five muscles that make the thoracic cage
External intercostals
Internal intercostals
Innermost intercostals
Subcostals, and transversus thoracis
Note: All these muscles are supplied by the corresponding
intercostal nerves
Diaphragm:
Musculotendinous structure separates thoracic cavity from
abdominal cavity. located at the inferior-most aspect of the
ribcage, filling the inferior thoracic aperture. It acts as the floor
of the thoracic cavity and the roof of the abdominal cavity.
Diaphragm has two attachments peripheral and central.

### 1: Peripheral attachments: Three peripheral attachments

Overview  Comments

![Muscles of Thorax - Clinical Figure 1](/lessons/images/thorax-anatomy-mediastinum/muscles-of-thorax/figure_01_p1.png)
*Muscles of Thorax — Clinical Figure 1 (Page 1 Reference)*

Xiphoid process of sternum
Costal cartilages ribs 7 - 10, ends of ribs 11 and 12
Arcuate ligaments and lumbar vertebrae

### 2: Central attachment: Muscles fibers of the diaphragm forms

central tendon which fuses with fibrous pericardium superiorly
Note: Diaphragm separates thoracic cavity from abdominal
cavity. Thus, any structure that pass between the two cavities
will pierce the diaphragm.
There are three openings which conduct the structures
Function: The diaphragm is the primary muscle of respiration. ,
contracts and flattens during inspiration increasing the vertical
diameter of the thoracic cavity. This produces lung expansion,
and air is drawn in.
The diaphragm During expiration passively relaxes and returns
to its original dome shape. This reduces the volume of the
thoracic cavity.
Innervation:
Phrenic nerve: The phrenic nerve originates from cervical
spinal roots C3, C4 and C5
provide motor innervation to the diaphragm.
provide sensory innervation the central part of the
diaphragm, the pericardium and the mediastinal part of
the parietal pleura.

> [!TIP]
> **Clinical pearls:**
> Congenital Diaphragmatic Hernia

![Muscles of Thorax - Clinical Figure 2](/lessons/images/thorax-anatomy-mediastinum/muscles-of-thorax/figure_02_p2.png)
*Muscles of Thorax — Clinical Figure 2 (Page 2 Reference)*

Congenital diaphragmatic hernia is a diaphragmatic defect,
and are frequently diagnosed prenatally with US, which
expedites proper initial newborn resuscitation.
Most commonly left sided.
The diaphragmatic defect allows intra-abdominal contents,
including stomach, bowel, and, occasionally, liver, to enter
the chest during the second trimester of gestation, leading to
pulmonary hypoplasia

> [!TIP]
> **Clinical pearls:**
> The clinical hallmark is persistent respiratory distress at birth,
> often with a characteristic "seesaw" side-to-side respiratory
> pattern due to the severely hypoplastic ipsilateral lung
> Acquired diaphragmatic hernia: include traumatic
> diaphragmatic rupture, hiatus hernia and iatrogenic
> diaphragmatic hernias. Depending on the location and size of
> the defect.

Note: In hiatus hernia, the stomach herniates through the
oesophageal opening of the diaphragm, typically resulting in
symptoms of acid reflux.

> [!TIP]
> **High yield:**
> Diaphragm: Normal quiet inspiration
> Normal expiration: Passive recoil of lungs
> Inspiration: External intercostal muscle
> Expiration: Internal intercostal muscle
> Accessory muscle of inspiration: Sternocleidomastoid
> Accessory muscle of expiration: Transversus abdominal
> muscles
> Forced expiration: Internal intercostal muscle and rectus
> abdominus
> Previous Next',
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

  -- Lesson: Structures of the Thorax - Mediastinum (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'structures-of-the-thorax-mediastinum',
    'Structures of the Thorax - Mediastinum',
    'article',
    '# Structures of the Thorax - Mediastinum

Mediastinum:
The mediastinum is an interpleural space and consists of the
superior mediastinum and inferior mediastinum. The inferior
mediastinum further divides into the anterior, middle, and
posterior mediastina.
The middle mediastinum contains the heart.
The posterior mediastinum contains the esophagus, thoracic
aorta, azygos and hemiazygos veins, thoracic duct, vagus
nerves, and sympathetic splanchnic nerves
Previous Next

Overview  Comments',
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

  -- Lesson: Structures of the Thorax - Tracheobronchial Tree (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'structures-of-the-thorax-tracheobronchial-tree',
    'Structures of the Thorax - Tracheobronchial Tree',
    'article',
    '# Structures of the Thorax - Tracheobronchial Tree

Tracheobronchial Tree
Trachea:
The trachea marks the beginning of the tracheobronchial tree,
arises at the lower border of cricoid cartilage in the neck (C6),
as a continuation of the larynx. It then travels inferiorly into the
superior mediastinum, bifurcating at the level of the sternal
angle (T4-T5) (forming the right and left main bronchi).
Note: As trachea descends, it is located anteriorly to the
oesophagus, and inclines slightly to the right.
The trachea is held open by cartilage in C-shaped rings
supported by the trachealis muscle.
The trachea and bronchi are lined by ciliated pseudostratified
columnar epithelium, interspersed by goblet cells, which
produce mucus.
The combination of sweeping movements by the cilia and
mucus from the goblet cells function as mucociliary
escalator.
Neurovascular Supply
Sensory innervation: Recurrent Laryngeal Nerve.
Arterial supply: Tracheal branches of the inferior thyroid
artery
Venous drainage: via the brachiocephalic, azygos and
accessory hemiazygos veins.
Bronchi
At the level of the vertebrae T4-T5, the trachea bifurcates into
the right and left main bronchi. They undergo further
branching to produce the secondary bronchi.
Structure

Overview  Comments

Right main bronchus: Wider, shorter, and descends more
vertically than left bronchus.
Clinically, this results in a higher incidence of foreign body
inhalation.
Note: Within the lungs, the main (primary) bronchi branch into
lobar (secondary) bronchi.
Each secondary bronchi supplies a lobe of the lung, thus
there are 3 right lobar bronchi and 2 left.
The lobar bronchi then bifurcate into several segmental
(tertiary) bronchi each of which supplies a
bronchopulmonary segment.
Bronchopulmonary segments are subdivisions of the lung
lobes, and act as the functional unit of the lungs.
Within each bronchopulmonary segment, the segmental
bronchi give rise to multiple generations of divisions and
ultimately to bronchioles (conducting bronchioles, terminal
bronchioles, respiratory bronchioles)
The respiratory bronchioles continue as alveolar ducts and
sacs, the walls of which form alveoli.
Previous Next',
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

  -- Lesson: Structures of the Thorax - Heart and Pericardium (3 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'structures-of-the-thorax-heart-and-pericardium',
    'Structures of the Thorax - Heart and Pericardium',
    'article',
    '# Structures of the Thorax - Heart and Pericardium

Heart and pericardium
Pericardium
Fibro-serous, fluid-filled sack that surrounds the muscular
body of the heart and the roots of the great vessels. Great
vessels include: The aorta, pulmonary artery, pulmonary veins,
and the superior and inferior vena cavae.
Pericardium is made up of two main layers fibrous and serous
pericardium.
Fibrous Pericardium: Surrounds the heart and forms a
protective covering for the cardiac Chambers. It also acts as an
anchor for the heart that keeps it restricted in the chest cavity
by binding itself to the adjoining regions. It also prevents the
overexpansion of the heart when there is a rise in the volume of
blood inside the body.
Serous Pericardium: It is closed sac within fibrous pericardium
having Visceral & Parietal layer, separated by the fluid-filled
pericardial cavity
The visceral layer of serous pericardium (epicardium):
covers the surface of the heart. It also reflects onto the great
vessels This transparent membrane surrounds and protects
the heart. It also contains a thin film of serous fluid that
allows the heart to move and provides it with a frictionless
environment to expand as well as contract.
The parietal layer lines the internal surface of the fibrous
pericardium.
Innervation of the pericardium
The visceral pericardium: Receives autonomic innervation
from the cardiac plexus.

Overview  Comments

The parietal and fibrous pericardium are innervated mainly by
the phrenic nerve, for this reason that pain related to a
pericardial problem may be referred to the supraclavicular
region of the shoulder or the lateral neck area.

> [!TIP]
> **Clinical pearls:**
> Pericardiocentesis:  surgical puncture of the pericardial cavity
> for the aspiration of fluid, which is necessary to relieve the
> pressure of accumulated fluid in the heart. A needle is inserted
> into the pericardial cavity 1 - 2 cm inferior to the left of the
> xiphochondral junction (between the xiphisternum and the
> left costal margin)
> Complications:
> Pneumothorax secondary to lung puncture
> Aspiration of ventricular blood instead of pericardial blood
> Laceration of ventricular epicardium or myocardium
> Laceration of coronary artery or vein
> Ventricular fibrillation
> Puncture of great vessels with worsening pericardial
> tamponade
> Heart:
> The heart is a myocardial muscular pump consisting of four
> chambers, two auricles, four valves, and a muscular septum all
> enclosed within a fluid filled sac, the pericardium
> The heart wall is composed of three distinct layers:

### 1: The epicardium (outermost layer)

### 2: The myocardium (middle layer, comprised of muscular

fibers)

### 3: The endocardium (innermost layer), lines the cavities and

valves of the heart
Borders

The heart has four borders:
The right border: right atrium and is in line with the superior
and inferior vena cavae.
The left border: the left ventricle and very slightly by the left
auricle.
The superior border: is where the great vessels enter and
leave the heart. It is formed by both atria
The inferior border: The right ventricle, and slightly by the left
ventricle near the apex.
The heart has been described as "a pyramid which has fallen
over". The apex of this pyramid pointing in an anterior-inferior
direction.
In its typical anatomical orientation, the heart has 5 surfaces,
formed by different internal divisions of the heart:
Anterior (or sternocostal): Right ventricle.
Posterior (or base): Left atrium.
Inferior (or diaphragmatic): Left and right ventricles.
Right pulmonary: Right atrium.
Left pulmonary: Left ventricle.
NOTE: Esophagus lies immediately posterior to the base (left
atrium). The term cardiac dysphagia referred as impairment of
swallowing due to esophageal compression from a dilated left
atrium
Cardiac Conduction system: collection of specialized
conduction cells and nodes that initiate and co-ordinate
contraction of the heart muscle. It consists of:
Sinoatrial node
Atrioventricular node
Atrioventricular bundle (bundle of His)
Purkinje fibres
The sinoatrial node, the cardiac pacemaker, is located at the
superior end of the crista terminalis at the junction of the
superior vena cava and the right atrium. Impulses generated
by the sinoatrial node are propagated by the atrial

myocardium to the atrioventricular node, Here the impulse is
briefly delayed before being spread to the ventricles.
The atrioventricular bundle (bundle of His) is a direct
continuation of the atrioventricular node and continues along
the lower margin of the membranous part of the
interventricular septum before dividing into the right and left
bundles which continue themselves as Purkinje fibres, the final
component of the conducting system.

> [!TIP]
> **High yield:**
> The sinoatrial node (SAN) is the primary pacemaker. The SAN
> will normally discharge at a rate of 60-100 bpm. if the
> impulse generated in the Sa node is blocked, a group of cells
> further down the heart will become its pacemaker.

The atrioventricular node (AVN) is the secondary pacemaker
and will normally discharge at about 40-60 beats per minute.
AV nodal abnormality is responsible for prolonged PR
interval (1st degree heart block)
Great Vessels of the heart: Mnemonic

## (Sippa)

Superior vena cava
Inferior vena cava
Pulmonary arteries
Pulmonary veins
Aorta

### 1. Superior vena cava: Receives deoxygenated blood from the

upper body excluding the lungs and heart superior to the
diaphragm, delivering it to the right atrium

### 2. Inferior vena cava: receives deoxygenated blood from the

lower body inferior to the diaphragm, delivering it back to the
heart

### 3. Pulmonary arteries: Receive deoxygenated blood from the

right ventricle and deliver it to the lungs for gas exchange to
take place through pulmonary valve

### 4. Pulmonary veins: Receive oxygenated blood from the lungs,

delivering it to the left side of the heart to be pumped back
around the body.

### 5. Aorta: Largest artery carry oxygenated blood pumped by left

side of the heart to all body. The aorta arises from the aortic
orifice at the base of the left ventricle, with inflow via the
aortic valve. First segment is known as the ascending aorta,
which lies within the pericardium. The second continuous
segment is the arch of the aorta, from which branch the
major arteries to the head, neck and upper limbs. These are:
Brachiocephalic trunk
Left common carotid artery
Left subclavian artery
After the arch of the aorta, the aorta then becomes the
descending aorta which continues down through the
diaphragm into the abdomen

> [!TIP]
> **High yield:**
> Areas of auscultation of heart:
> Cardiac blood supply:

### 1: The Right coronary artery supplies:

The right atrium and most of right ventricle
The sinoatrial and atrioventricular node
Posterior interventricular artery, also known as the posterior
descending artery (PDA), is a branch of the right coronary
artery supply posterior  of interventricular septum and
posterior aspect of right and left ventricle. Most common
artery infracted in posterior wall MI
Note: Occlusion of right coronary artery can result into
ischemia of SA and AV node and subsequently bradycardia
or heart block

### 2: The left coronary artery supplies via main branches below:

Anterior interventricular branch (LAD)

![Structures of the Thorax - Heart and Pericardium - Clinical Figure 1](/lessons/images/thorax-anatomy-mediastinum/structures-of-the-thorax-heart-and-pericardium/figure_01_p5.png)
*Structures of the Thorax - Heart and Pericardium — Clinical Figure 1 (Page 5 Reference)*

LCX

> [!TIP]
> **High yield:**
> Localization of lesion in ST elevation MI and occluded coronary
> artery. Only remember myocardial area and occluded coronary
> artery.

Easy to remember:
Septal and Anterior wall MI: LAD (Anterior interventricular
branch) occluded.
Lateral wall MI: LCX occluded.
Previous Next

![Structures of the Thorax - Heart and Pericardium - Clinical Figure 2](/lessons/images/thorax-anatomy-mediastinum/structures-of-the-thorax-heart-and-pericardium/figure_02_p6.png)
*Structures of the Thorax - Heart and Pericardium — Clinical Figure 2 (Page 6 Reference)*

![Structures of the Thorax - Heart and Pericardium - Clinical Figure 3](/lessons/images/thorax-anatomy-mediastinum/structures-of-the-thorax-heart-and-pericardium/figure_03_p6.png)
*Structures of the Thorax - Heart and Pericardium — Clinical Figure 3 (Page 6 Reference)*',
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

  -- Lesson: Structures of the Thorax - Lungs and Pleurae (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'structures-of-the-thorax-lungs-and-pleurae',
    'Structures of the Thorax - Lungs and Pleurae',
    'article',
    '# Structures of the Thorax - Lungs and Pleurae

## Lung:

Lungs lie either side of the mediastinum, within the thoracic
cavity. Each lung is surrounded by pleural cavity, which is
formed by the visceral and parietal pleura. Lungs are
suspended from the mediastinum by the lung root a collection
of structures entering and leaving the lungs.
Each root contains a bronchus, pulmonary artery, two
pulmonary veins, bronchial vessels, pulmonary plexus of nerves
and lymphatic vessels. All these structures enter or leave the
lung via the hilum. The hila are located at the level of the 3rd -
4th costal cartilage anteriorly, and the T5 - T7 vertebrae
posteriorly. In the mediastinum, the vagus nerves pass
immediately posteriorly to the lung roots, while the phrenic
nerves pass immediately anterior to them.
Note: The right lung is normally a little larger than the left lung
because the middle mediastinum, containing the heart,
bulges more to the left than to the right.
Relations:
Lymphatic vessels of the lung: Drain the bronchial tree,
pulmonary vessels, and connective tissue septa. Run along
bronchioles and bronchi toward the hilum, where they drain to
the pulmonary (intrapulmonary) and then bronchopulmonary
nodes, which in turn drain to the inferior and superior

Overview  Comments

![Structures of the Thorax - Lungs and Pleurae - Clinical Figure 1](/lessons/images/thorax-anatomy-mediastinum/structures-of-the-thorax-lungs-and-pleurae/figure_01_p1.png)
*Structures of the Thorax - Lungs and Pleurae — Clinical Figure 1 (Page 1 Reference)*

tracheobronchial nodes, the tracheal (paratracheal) nodes,
broncho mediastinal nodes and trunks, and eventually to the
thoracic duct on the left and right lymphatic duct on the right.
Are not present in the walls of the pulmonary alveoli.

### 1. Thoracic duct: Begins in the abdomen at the cisterna chyli,

which is the dilated junction of the intestinal, lumbar, and
descending intercostal trunks. Drains the lower limbs,
pelvis, abdomen, left thorax, left upper limb, and left side
of the head and neck. Passes through the aortic opening of
the diaphragm and ascends through the posterior
mediastinum between the aorta and the azygos vein, Arches
laterally over the apex of the left pleura and between the left
carotid sheath in front and the vertebral artery behind, runs
behind the left internal jugular vein, and then usually
empties into the junction of the left internal jugular and
subclavian veins.

### 2. Right lymphatic duct: Drains the right sides of the thorax,

upper limb, head, and neck. Much of the left lower lung lobe
drains to the right lymphatic duct. Empties into the junction
of the right internal jugular and subclavian veins.
Vasculature of lung:
The pulmonary artery conveys the venous blood to the
lungs.
The pulmonary veins commence in the pulmonary
capillaries, open into the left atrium of the heart, conveying
oxygenated blood to be distributed to all parts of the body by
the aorta.
The bronchial arteries supply blood for the nutrition of the
lung.
The bronchial vein is formed at the root of the lung, receiving
superficial and deep veins corresponding to branches of the
bronchial artery
Innervation of lung: The nerve supply to the lungs is from the
anterior and posterior pulmonary plexus (networks of nerves

derived from the sympathetic trunk and vagus nerve).
Lobes of the lung: The left lung is divided into two lobes, an
upper and a lower, by an interlobular fissure, which extends
from the costal to the mediastinal surface of the lung both
above and below the hilus.The superior lobe lies above and in
front of this fissure, and includes the apex, the anterior
border, and a considerable part of the costal surface and the
greater part of the mediastinal surface of the lung.
The inferior lobe, the larger of the two, is situated below and
behind the fissure, and comprises almost the whole of the
base, a large portion of the costal surface, and the greater part
of the posterior border.
The right lung is divided into three lobes, superior, middle, and
inferior, by two interlobular fissures. the oblique fissure
separates the inferior lobe from the superior and middle lobe
whilst the horizontal fissure separates the superior lobe from
the middle lobe.

> [!TIP]
> **Clinical pearls:**
> Lung auscultation: to make it summarize remember, sounds
> heard anteriorly think upper lobes, sounds heard posteriorly
> think lower lobes and middle lobe will be heard to the right,
> near the midaxillary line
> The superior lobe of the right lung is best auscultated above
> the 4th rib anteriorly.

The middle lobe of the right lung is best auscultated
between the 4th and the 6th rib anteriorly.
The superior lobe of the left lung is best auscultated above
the 6th rib anteriorly.
The inferior lobes of the left and right lungs are best
auscultated in the back between T3 & T10.
Pancoast tumor (superior pulmonary sulcus tumor) is a
malignant neoplasm of the lung aper may cause a lower trunk
brachial plexopathy and a lesion of cervical sympathetic chain

ganglion and Horner syndrome (ptosis, enophthalmos,
miosis, anhidrosis, and vasodilation).
Thoracotomy: surgical procedure to gain access into the
pleural space of the chest
Antero lateral thoracotomy muscle divided serratus anterior
and pectoralis major
Antero lateral thoracotomy: Nerve injury long thoracic
nerve
Post: lateral thoracotomy muscle divided latissimus dorsi
Post: lateral thoracotomy nerve injury: Thoracodorsal nerve
injury
Internal mammary artery and Aorta are likely to be
damaged also
Pleurae:
Each lung is surrounded by a pleura. The pleura consists of two
parts.
The parietal pleura covers internal surface of the thoracic
cavity. Parietal pleura includes mediastinal pleura, costal
pleura and diaphragmatic pleura
The visceral pleura lines the lungs.
The two parts of the pleura are continuous with each other
at the hilum of each lung. The potential space between these
two parts of the pleura is called the pleural cavity.
Pleural Recesses: Pleural cavity is not completely filled by the
lungs, anteriorly and posteroinferiorly, this gives rise to
recesses where the opposing surfaces of the parietal pleura
touch.
There are two recesses present in each pleural cavity, recesses
are of clinical importance, as they provide a location where
fluid can collect i.e., in a pleural effusion
Costo diaphragmatic: located between the costal pleurae
and the diaphragmatic pleura.

Costo mediastinal: located between the costal pleurae and
the mediastinal pleurae, behind the sternum.
Surface markings of pleura:
Superiorly the pleural cavity projects as much as 3-4 cm
above the first costal cartilage but does not extend above the
neck of rib 1.
Inferiorly the pleura reflects onto the diaphragm above the
costal margin. The inferior margin of the pleural cavity is a
line that runs between rib 8 in the midclavicular line, rib 10 in
the midaxillary line and T12 vertebra posteriorly.
Innervation of pleura
The parietal pleura is innervated by somatic afferent fibres.
Parietal pleura includes mediastinal pleura, costal pleura and
diaphragmatic pleura.
The costal pleura (pleura related to the ribs and intercostal
spaces) is innervated by branches of the intercostal nerves,
and pain is felt in relation to the thoracic wall.
The diaphragmatic pleura and the mediastinal pleura are
innervated mainly by the phrenic nerves (C3 - C5), and pain is
referred the C3 - C5 dermatomes include lateral neck and
supraclavicular region of shoulder.
The visceral pleura is innervated by visceral afferent fibres,
not sensitive to pain or temperature.

> [!TIP]
> **Clinical pearls:**
> Thoracentesis (or pleural tap): is surgical entry through the
> thoracic wall into the pleural cavity for aspiration of fluid. An
> accumulation of fluid in the pleural cavity is known by clinical
> names, such as a hydrothorax (water), a hemothorax (blood), a
> chylothorax (lymph), and a pyothorax (pus).

Site: Pleural tap is performed at or posterior to the midaxillary
line, one or two intercostal spaces below the fluid level ideal
site is the sixth, seventh, eighth, or ninth intercostal space but
not below the ninth intercostal space
Note: A needle should be inserted immediately above the
superior margin of a rib to avoid injury to the intercostal

neurovascular bundle, which travels in a notch below each rib
Previous Next',
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

  -- Lesson: Structures of the Thorax - Oesophagus (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'structures-of-the-thorax-oesophagus',
    'Structures of the Thorax - Oesophagus',
    'article',
    '# Structures of the Thorax - Oesophagus

Oesophagus:
Fibromuscular tube that transports food from pharynx to
stomach, divided into three parts:
Cervical: continuous with the oropharynx, commences at the
lower border of cricoid cartilage (at level of C5/6) or
cricopharyngeus muscle
Thoracic: From thoracic aperture (T1) to the oesophageal hiatus

## (T11)

Abdominal: From oesophageal hiatus and is continuous with
the cardia of the stomach at the gastro-oesophageal junction
Oesophageal constrictions
The anatomical relations of the oesophagus give rise to four
constrictions, where food/foreign objects are most likely to
become impacted.
Oesophageal constrictions should not be confused with
pathological constrictions.
Cervical constriction: due to cricoid cartilage at the level of

## C5/6

Thoracic constriction: due to aortic arch at the level of T4/5
Abdominal constriction: at oesophageal hiatus at T10/11
vertebral
Relations of the oesophagus

Overview  Comments

![Structures of the Thorax - Oesophagus - Clinical Figure 1](/lessons/images/thorax-anatomy-mediastinum/structures-of-the-thorax-oesophagus/figure_01_p1.png)
*Structures of the Thorax - Oesophagus — Clinical Figure 1 (Page 1 Reference)*

Innervation of the oesophagus:
sympathetic trunk (sympathetic fibres)
vagal plexus (parasympathetic fibres)
Previous Next',
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

  -- Lesson: Structures of the Thorax - Thymus (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'structures-of-the-thorax-thymus',
    'Structures of the Thorax - Thymus',
    'article',
    '# Structures of the Thorax - Thymus

The thymus
lobulated lymphoid organ, located in the thoracic cavity and
neck. In the adolescent, it is involved the development of the
immune system
Is a lobulated specialized primary lymphoid organ of the
immune system, within which T-lymphocytes mature in the
adolescent
After puberty, it decreases in size and is slowly replaced by
fat.
It is mainly located within the superior mediastinum,
posterior to the manubrium sterni.
A certain degree of anatomical variation exists, and in some
individuals, it can extend superiorly into the neck or inferiorly
into the anterior mediastinum.
The thymus has an asymmetrical, flat shape with a lobular
structure.
The lobules are comprised of a series of follicles, which
consist of a medullary and a cortical portion.
The cortex: Is located peripherally within each follicle and is
mainly composed of lymphocytes, supported by a network of
finely branched epithelial reticular cells.
The medulla: Is located centrally within each follicle and
lymphoid cells are fewer than cortical portion. There are also
a number of concentric arrangements of epithelial cells
known as Hassall''s corpuscles.
Vasculature of the thymus:
The arterial supply to the thymus gland is via the anterior
intercostal arteries and small branches from the internal
thoracic arteries. Venous blood drains into the left
brachiocephalic and internal thoracic veins
Innervation of the thymus:

Overview  Comments

The thymus gland is innervated by sympathetic nerves
arising from the cervical sympathetic ganglia. These
sympathetic nerves regulate blood flow to the thymus and
play a role in its function. In addition, parasympathetic
fibers from the vagus nerve may also contribute to the
innervation of the thymus gland nevertheless an autonomic
nervous system of both sympathetic and parasympathetic
components plays a role in regulating function of thymus
gland.
Previous Next',
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

  -- Lesson: Thoracic Wall Movements (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'thoracic-wall-movements',
    'Thoracic Wall Movements',
    'article',
    '# Thoracic Wall Movements

Thoracic wall movements:
In general, the ribs move around two axes, Movement of the
ribs at the costovertebral joints in respiration results in the
''pump handle'' and ''bucket handle'' movements:

### 1: Pump handle movement:

Pump-handle is a movement of the ribs that results in a
change in the anteroposterior diameter of the thorax
Movement at costovertebral joints from ribs (2 to 6) about a
side-to-side axis results in raising and lowering the sternal
end of the rib, the "pumphandle"movement.
The downward slope of the rib ensures that, in elevation, the
sternum moves upward and forward, increasing the
anteroposterior diameter of the thorax.

### 2: Bucket handle movement:

Bucket handle is a movement of the ribs that results in a
change in the transverse diameter of the thorax
Movement at costovertebral joints from ribs (7 to 10) about an
anteroposterior axis result in raising and lowering the middle
of the rib, the "buckethandle" movement. In elevation, this
increases the transverse diameter of the thorax.

Overview  Comments

> [!TIP]
> **Clinical pearls:**
> Flail chest: loss of stability of the thoracic cage that occurs
> when a segment of the anterior or lateral thoracic wall moves
> freely because of multiple rib fractures, allowing the loose
> segment to move inward on inspiration and outward on
> expiration. Flail chest is an extremely painful injury and impairs
> ventilation, thereby affecting blood oxygen levels and causing
> respiratory failure.

Rib fractures:
Fracture of the first rib may injure the brachial plexus and
subclavian vessels.
The middle ribs are most commonly fractured and usually
result from direct blows or crush injuries. The broken ends of
ribs may cause pneumothorax and lung or spleen injury.
Lower rib fractures may tear the diaphragm, resulting in a
diaphragmatic hernia.
Previous Next

![Thoracic Wall Movements - Clinical Figure 1](/lessons/images/thorax-anatomy-mediastinum/thoracic-wall-movements/figure_01_p2.png)
*Thoracic Wall Movements — Clinical Figure 1 (Page 2 Reference)*',
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

  -- Lesson: Transverse Thoracic Plane - Thoracic Inlet and Outlet (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'transverse-thoracic-plane-thoracic-inlet-and-outlet',
    'Transverse Thoracic Plane - Thoracic Inlet and Outlet',
    'article',
    '# Transverse Thoracic Plane - Thoracic Inlet and Outlet

Transverse thoracic plane
lies at the level of 2nd intercostal space and intervertebral disc
between T4 & T5
CLAPTRAP is a useful mnemonic to remember structures
transected by the transverse thoracic plane.
C: cardiac plexus
L: ligamentum arteriosum
A: aortic arch (inner concavity) RECALL
P: pulmonary trunk bifurcation
T: tracheal bifurcation (carina) RECALL
R: right-to-left movement of the thoracic duct (posterior to
the esophagus)
A: azygos vein drains into superior vena cava
P: pre-vertebral fascia and pre-tracheal fascia end
Thoracic inlet: Superior thoracic aperture also known as
thoracic outlet or inlet refers to opening at top of thoracic
cavity
The thoracic inlet is bordered anteriorly by the manubrium of
the sternum and the first costal cartilages.
Posteriorly by the body of vertebra T1.
laterally by the first rib
Structures that pass through the thoracic inlet
include:
Trachea and oesophagus
Thoracic duct and apices of the lung
phrenic nerve
vagus nerve
Recurrent laryngeal nerves
Sympathetic trunks
Left and right common carotid arteries.
left subclavian arteries.

Overview  Comments

Internal jugular veins
Brachiocephalic veins
Subclavian veins
lymph nodes and lymphatic vessels

> [!TIP]
> **Clinical pearls:**
> Thoracic outlet syndrome (TOS) refers to the clinical features
> that arise from compression of the neurovascular bundle
> within the thoracic outlet
> Compression of brachial plexus
> Compression of subclavian artery
> Compression of subclavian vein
> Previous Next',
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
  -- Module 4: Abdomen & Peritoneum (9 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Abdomen & Peritoneum' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Abdomen & Peritoneum', 3, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 3, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Abdominal Wall Muscles (3 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'abdominal-wall-muscles',
    'Abdominal Wall Muscles',
    'article',
    '# Abdominal Wall Muscles

Layers of the Abdominal Wall
(external to internal)
Skin
Superficial fascia (Camper''s fascia: Superficial fatty
layer Scarpa''s fascia: deep fibrous layer )
Muscles
Transversalis fascia
Parietal peritoneum
Anterior abdominal wall muscles
The muscles of the anterolateral abdominal wall can be
divided into two main groups that lie deep in the superficial
fascia.
Three flat muscles: (External oblique, internal oblique and
transversus abdominus), located laterally, each flat muscle
forms an aponeurosis (a broad, flat tendon) in the
anteromedial aspect of the abdominal wall which covers the
vertical rectus abdominis muscle. The aponeuroses of all the
flat muscles become entwined in the midline, forming
the Linea alba.
Two vertical muscles: Rectus abdominus and pyramidalis
situated near midline of body
Innervation: The anterior abdominal wall muscles are
innervated by the anterior rami of T7-T12 and L1.

Overview  Comments

Other contents
Rectus sheath: The rectus sheath is formed by the
aponeuroses of the three flat muscles and encloses the
rectus abdominis and pyramidalis muscles. It has an anterior
and posterior wall for most of its length.
Anterior wall: Formed by the aponeuroses of the external
oblique, and of half of the internal oblique.
Posterior wall:  Half of the aponeuroses of the internal
oblique and of the transversus abdominis.
Approximately midway between the umbilicus and the pubic
symphysis, all the aponeuroses move to the anterior wall of
the rectus sheath. At this point, there is no posterior wall to
the sheath; the rectus abdominis is in direct contact with the
transversalis fascia. Point, where the posterior layer of the
rectus sheath ends, is the arcuate line.

![Abdominal Wall Muscles - Clinical Figure 1](/lessons/images/abdomen-peritoneum/abdominal-wall-muscles/figure_01_p2.png)
*Abdominal Wall Muscles — Clinical Figure 1 (Page 2 Reference)*

Contents of the rectus sheath
Rectus abdominus and the pyramidalis muscle
The superior and inferior epigastric vessels
The termination of intercostal nerves T7-T11
The 12th thoracic nerve and the accompanying vessels
Posterior abdominal wall muscle
Important posterior abdominal wall muscles are the psoas
major, minor, the iliacus and the quadratus lumborum which
each possess a strong fascial covering.
Iliacus and Psoas major origin and insertion
Iliacus: Originates from surface of the iliac fossa and anterior
inferior iliac spine. Its fibres combine with the tendon of the
psoas major, inserting into the lesser trochanter of
the femur.
Psoas major: Originates from the transverse processes and
vertebral bodies of T12 - L5. It then moves inferiorly and
laterally, running deep to the inguinal ligament, and
inserting to the lesser trochanter of the femur.

> [!TIP]
> **Clinical pearls**
> Psoas sign: Irritation of iliopsoas muscle, psoas sign positive
> when thigh is flexed pain is felt in lower abdominal wall,
> indication of appendicitis.

![Abdominal Wall Muscles - Clinical Figure 2](/lessons/images/abdomen-peritoneum/abdominal-wall-muscles/figure_01_p3.png)
*Abdominal Wall Muscles — Clinical Figure 2 (Page 3 Reference)*

![Abdominal Wall Muscles - Clinical Figure 3](/lessons/images/abdomen-peritoneum/abdominal-wall-muscles/figure_02_p3.png)
*Abdominal Wall Muscles — Clinical Figure 3 (Page 3 Reference)*

Previous Next',
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

  -- Lesson: Accessory Organs of the Abdomen (8 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'accessory-organs-of-the-abdomen',
    'Accessory Organs of the Abdomen',
    'article',
    '# Accessory Organs of the Abdomen

The Liver:
largest visceral organ and the largest gland in the human body.
Plays an important role in production and secretion of bile
used in emulsification of fats and detoxification by filtering the
blood to remove bacteria and foreign particles that have
gained entrance from the intestine.
Storage of carbohydrate as glycogen and to be broken down
later to glucose
Production and storage of lipids as triglycerides; plasma
protein synthesis albumin and globulin
Production of blood coagulants (fibrinogen and
prothrombin), anticoagulants (heparin), and bile pigments
(bilirubin and biliverdin) from the breakdown of hemoglobin
Reservoir for blood and platelets; and storage of certain
vitamins, iron, and copper.
In the fetus, the liver is important in the manufacture of Rbcs
Contains internal portal triads contains the portal vein,
hepatic artery, and bile ducts.
Anatomical relations of the liver
Anatomical surfaces of liver
The liver has a diaphragmatic surface in the anterior,
superior, and posterior directions and a visceral surface in the
inferior direction.
The diaphragmatic surface of the liver is related anteriorly to
the anterior abdominal wall and rib cage and superiorly to
the diaphragm.

Overview  Comments

![Accessory Organs of the Abdomen - Clinical Figure 1](/lessons/images/abdomen-peritoneum/accessory-organs-of-the-abdomen/figure_01_p1.png)
*Accessory Organs of the Abdomen — Clinical Figure 1 (Page 1 Reference)*

The visceral surface of the liver is related to the oesophagus,
right anterior part of the stomach, superior part of the
duodenum, lesser omentum, gallbladder, right colic flexure,
right transverse colon, right kidney and right adrenal gland.
Ligaments of the Liver
Hepatic Recesses: They are of clinical importance, as infected
fluids can collect in these areas, forming an abscess.
Structure of the Liver
The entire liver is covered by a fibrous layer, known as Glisson''s
capsule. The ligaments and surface depressions of the liver
divide it into four lobes.

### 1: Right lobe and left lobe by the attachment of the falciform

ligament.

### 2: There are two further ''accessory'' lobes that arise from the

right lobe, and are located on the visceral surface of liver:
The caudate lobe is located on the upper aspect of the
visceral surface. It lies between the inferior vena cava and a
fossa produced by the ligamentum venosum.
The quadrate lobe is located on the lower aspect of the
visceral surface. It lies between the gallbladder and a fossa

![Accessory Organs of the Abdomen - Clinical Figure 2](/lessons/images/abdomen-peritoneum/accessory-organs-of-the-abdomen/figure_02_p2.png)
*Accessory Organs of the Abdomen — Clinical Figure 2 (Page 2 Reference)*

![Accessory Organs of the Abdomen - Clinical Figure 3](/lessons/images/abdomen-peritoneum/accessory-organs-of-the-abdomen/figure_03_p2.png)
*Accessory Organs of the Abdomen — Clinical Figure 3 (Page 2 Reference)*

produced by the ligamentum trees.
Between the caudate and quadrate lobes is a deep fissure,
known as the porta hepatis. It transmits all the vessels,
nerves and ducts entering or leaving the liver.
Arterial Supply and Venous Drainage
The liver has a unique dual blood supply:
Hepatic artery proper 25% Supplies the liver with arterial
blood.
Hepatic portal vein 75% Supplies the liver with deoxygenated
blood, carrying nutrients absorbed from the small intestine.
The portal vein is the final common pathway for the transport
of venous blood from the spleen, pancreas, gallbladder and
abdominal part of the gastrointestinal tract.
Portal vein is formed from the union of the superior
mesenteric and splenic vein posterior to the neck of the
pancreas at the level of vertebra L2.
Venous drainage of the liver is achieved through three hepatic
veins, which drain into the inferior vena cava.
Innervation of liver
The parenchyma of the liver is innervated by the hepatic
plexus, which contains sympathetic fibers from the coeliac
plexus and parasympathetic fibers from vagus nerve
These fibers enter the liver at the porta hepatis and follow
the course of branches of the hepatic artery and portal vein

![Accessory Organs of the Abdomen - Clinical Figure 4](/lessons/images/abdomen-peritoneum/accessory-organs-of-the-abdomen/figure_04_p3.png)
*Accessory Organs of the Abdomen — Clinical Figure 4 (Page 3 Reference)*

> [!TIP]
> **Clinical pearls:**
> Liver cirrhosis and portal hypertension:
> Liver cirrhosis is a condition in which liver cells are
> progressively destroyed and replaced by fatty and fibrous
> tissue that surrounds the intrahepatic blood vessels and biliary
> radicals, impeding the circulation of blood through the liver. It
> is caused by chronic alcohol abuse (alcoholism), viral hepatitis,
> and ingestion of poisons.

Liver cirrhosis causes portal hypertension and portosystemic
anastomosis occur at specific points.
The gastroesophageal junction around the cardia of the
stomach where the left gastric vein and its tributaries form a
portosystemic anastomosis with tributaries to the azygos
system of veins of the caval system.
The anus where the superior rectal vein of the portal system
anastomoses with the middle and inferior rectal veins of the
systemic venous system.
The anterior abdominal wall around the umbilicus where the
portal paraumbilical veins anastomose with systemic veins
on the anterior abdominal wall.
Clinical features:
Esophageal varices dilated veins in the lower part of the
esophagus
Hemorrhoids: dilated veins around the anal canal
Caput medusa: dilated veins around the umbilicus
Spider nevi or spider angioma (small, red, spiderlike arterioles
in the cheeks, neck, and shoulder)
Ascites: accumulation of fluid in the peritoneal cavity
edema in the legs: lower albumin levels facilitate
water retention.
Splenomegaly: enlarged spleen resulting from venous
congestion causing sequestered blood cells that lead to
thrombocytopenia and easy bruising
Hepatomegaly due to fatty changes
Gall bladdar:

Is a pear-shaped sac located in a fossa between the right and
quadrate lobe of liver
The gallbladder has:
The fundus rounded blind end which may project from the
inferior border of the liver.
The body: Major part which may lie against the transverse
colon and the superior part of the duodenum.
The neck: Narrow part which tapers to become continuous
with the cystic duct.
Note: The neck contains a mucosal fold, known as Hartmann''s
pouch, which is a common site for gallstones to become
lodged.
Gall bladder blood supply: cystic artery branch of right hepatic
artery. Right hepatic artery is itself branch of common hepatic
artery one of branch of coeliac trunk.
Innervation of gall bladder:The gallbladder receives both
sympathetic and vagal supply:
sympathetic: via the coeliac plexus
vagal: via the hepatic branches of anterior vagal trunk
Note: Inflammation of the gallbladder may present with pain
in the right upper quadrant and also in the right shoulder due
to irritation of the diaphragmatic peritoneum supplied by the
phrenic nerve
Billiary tree:
1.Right and left hepatic ducts: Are formed by union of the
intrahepatic ductules from each lobe of the liver and drain bile
from their corresponding halves of the liver
2.Common hepatic duct Is formed by union of the right and
left hepatic ducts.
Common hepatic duct is accompanied by the proper hepatic
artery and the portal vein.

3.Cystic duct Has spiral folds (valves) to keep it constantly
open, and thus bile can pass upward into the gallbladder when
the common bile duct is closed.
Cystic duct Joins the common hepatic duct to form the
common bile duct.
Cystic duct is a common site of gallstone impaction.

### 4: Common bile duct: Formed by the union of the common

hepatic duct and the cystic duct The common bile duct can be
divided into three main regions, based on its relation to the
duodenum:
Supraduodenal region: located lateral to the proper hepatic
artery and anterior to the portal vein in the free margin of the
lesser omentum.
Second retroduodenal region: Descends behind the first
part of the duodenum and runs through the head of the
pancreas. Joins the main pancreatic duct to form the
hepatopancreatic duct which enters the second part of the
duodenum at major duodenal papillae. The gastroduodenal
artery lies on its left aspect and the portal vein on its
posterior aspect
The third infraduodenal region is the lower one-third which
lies in a groove on the posterior surface of the head of the
pancreas, to the left of the second part of the duodenum and
anterior to the right renal vein and inferior vena cava.
Pancreas:
The pancreas lies mostly posterior to the stomach. It extends
across the posterior abdominal wall from the duodenum on
the right, to the spleen on the left. It lies in the epigastric
region and left hypochondrium.
The pancreas is a retroperitoneal organ (except for a small part
of its tail) and consists of a head, uncinate process, neck, body
and tail.
Head: lies within the C-shaped concavity of the duodenum.
The uncinate process is a projection of the inferior part of
the head that extends medially behind the superior
mesenteric vessels.

The neck connects the head and body of the pancreas and
lies anterior to the Junction of the superior mesenteric and
splenic veins, forming the hepatic portal vein.
The body extends from the neck to the tail and the longest
part of the pancreas lies behind the stomach and to the left
of the superior mesenteric vessels.
The intraperitoneal tail passes between layers of the
splenorenal ligament. It is related to the left kidney
posteriorly, the hilum of the spleen laterally, the left colic
flexure inferiorly and the stomach anteriorly.
Ducts of pancreas:  Main pancreatic duct: Begins in the tail
and runs to the right along the entire pancreas
Joins the bile duct to form the hepatopancreatic ampulla
(ampulla of Vater) enters second part of duodenum at
duodenal papilla
Accessory pancreatic duct: Begins in the inferior portion of
the head and drains a small portion of the head and the
body, empties at the minor duodenal papilla 2cm above the
major papilla
Blood supply:Receives blood from branches of the splenic
artery
The head is additionally supplied by the superior and inferior
pancreaticoduodenal arteries which are branches of the
gastroduodenal from (coeliac trunk) and superior mesenteric
arteries respectively.
Innervation: Visceral afferent fibres travel in the greater and
lesser splanchnic nerves.
The segmental level of innervation is T6 -T10.
Pain typically radiates to the middle of the back due to
irritation of the parietal peritoneum covering the pancreas.

> [!TIP]
> **Clinical pearls:**
> Pancreatitis: Inflammation of pancreas causes pain in upper
> abdomen typically epigastrium radiating to back
> Spleen:

is a large vascular lymphatic organ lying against the
diaphragm and ribs 9 to 11 in the hypochondriac region,
covered by peritoneum except at the hilum, and supported by
the  splenogastric and splenorenal ligaments
Relations:The spleen lies posterior to the stomach, superior to
the left colic flexure and lateral to the left kidney and tail of the
pancreas.
Functional overview: Composed of white pulp and red pulp.
White pulp: which consists of primarily lymphatic tissue
around the central arteries and is the primary site of immune
and phagocytic action, participates in the immune response
(protection against infection); and produces mature
lymphocytes, macrophages and antibodies in white pulp
Red pulp: which consists of venous sinusoids and splenic
cords and is the primary site of filtration. Filters blood
(macrophages remove damaged and worn-out erythrocytes
and platelets) blood reservoir, storing blood and platelets in
the red pulp.
Spleen Is hematopoietic in early life and later destroys aged
(i.e., worn-out) red blood cells in the red pulp and releases
hemoglobin from the spent RBCs.
Important to remember here hematopoiesis at different
stages of life.

> [!TIP]
> **Clinical pearls: Spleen injury most Likely associated with**
> fracture of rib 10

![Accessory Organs of the Abdomen - Clinical Figure 5](/lessons/images/abdomen-peritoneum/accessory-organs-of-the-abdomen/figure_05_p8.png)
*Accessory Organs of the Abdomen — Clinical Figure 5 (Page 8 Reference)*

Adrenal glands:
Paired endocrine glands located over medial aspect of upper
poles of each kidney.
Perinephric(or renal) fascia encloses the adrenal glands and
the kidneys.
The adrenal glands sit in close proximity to many other
structures in the abdomen.
Innervation:
The adrenal glands are innervated by the coeliac plexus and
greater splanchnic nerves.

![Accessory Organs of the Abdomen - Clinical Figure 6](/lessons/images/abdomen-peritoneum/accessory-organs-of-the-abdomen/figure_06_p9.png)
*Accessory Organs of the Abdomen — Clinical Figure 6 (Page 9 Reference)*

![Accessory Organs of the Abdomen - Clinical Figure 7](/lessons/images/abdomen-peritoneum/accessory-organs-of-the-abdomen/figure_07_p9.png)
*Accessory Organs of the Abdomen — Clinical Figure 7 (Page 9 Reference)*

![Accessory Organs of the Abdomen - Clinical Figure 8](/lessons/images/abdomen-peritoneum/accessory-organs-of-the-abdomen/figure_08_p9.png)
*Accessory Organs of the Abdomen — Clinical Figure 8 (Page 9 Reference)*

Previous Next',
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

  -- Lesson: Areas of Abdomen (6 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'areas-of-abdomen',
    'Areas of Abdomen',
    'article',
    '# Areas of Abdomen

Areas of the abdomen
Inguinal canal: pathway by which structures can pass from
the abdominal wall to the external genitalia.
Inguinal canal boundaries
Inguinal ring: Two openings to the inguinal canal are
known as rings
Note:
Mid-inguinal point: Halfway between the pubic symphysis
and the anterior superior iliac spine. The femoral pulse can
be palpated here.
Midpoint of the inguinal ligament: Halfway between the
pubic tubercle and the anterior superior iliac spine. The
opening to the inguinal canal is located just above this point.

Overview  Comments

![Areas of Abdomen - Clinical Figure 1](/lessons/images/abdomen-peritoneum/areas-of-abdomen/figure_01_p1.png)
*Areas of Abdomen — Clinical Figure 1 (Page 1 Reference)*

![Areas of Abdomen - Clinical Figure 2](/lessons/images/abdomen-peritoneum/areas-of-abdomen/figure_02_p1.png)
*Areas of Abdomen — Clinical Figure 2 (Page 1 Reference)*

> [!TIP]
> **High yield clinical**
> Direct inguinal hernia lies medial to inferior epigastric vessels
> while indirect inguinal hernia lies lateral to inferior epigastric
> vessels. (RECALL)
> Most common type of inguinal hernia=indirect inguinal
> hernia (Recall)
> Most common side of inguinal hernia=Right side (RECALL)
> The floor of the inguinal canal is the inguinal ligament,
> otherwise known as the Poupart ligament, which is formed
> by the external oblique aponeurosis (RECALL)
> Type of hernia that enters the deep inguinal ring=indirect
> inguinal hernia (RECALL)
> Type of hernia that protrudes through Hesselbach''s
> triangle=Direct inguinal hernia (RECALL).

Hesselbach triangle - Region in anterior abdominal wall
located within the inferomedial aspect of the abdominal wall
Borders:
Medial: Lateral border of the rectus abdominis muscle.
Lateral: inferior epigastric vessels.
Inferior: inguinal ligament
Clinical significance:  Direct inguinal hernia protrudes
through Hesselbach''s triangle.
The Peritoneum

![Areas of Abdomen - Clinical Figure 3](/lessons/images/abdomen-peritoneum/areas-of-abdomen/figure_03_p2.png)
*Areas of Abdomen — Clinical Figure 3 (Page 2 Reference)*

Continuous double-layered membrane which lines the
abdominal cavity and covers the abdominal viscera.
Consists of parietal and visceral peritoneum
Parietal peritoneum: Lines the abdominal and pelvic walls
and the inferior surface of the diaphragm.
Parietal peritoneum Is innervated by somatic nerves, such as
the phrenic, lower intercostal, subcostal, iliohypogastric, and
ilioinguinal nerves.
visceral peritoneum: Covers the viscera, is innervated by
visceral nerves and is insensitive to pain
Peritoneal cavity: This is a potential space between the
parietal and visceral layers of peritoneum and contains fluid
that lubricates the surface of the peritoneum and facilitates
free movements
Abdominal viscera are either suspended in the peritoneal
cavity by folds of peritoneum called mesenteries and are
termed as intraperitoneal viscera
Visceras outside the peritoneal cavity bound to the posterior
abdominal wall termed as retroperitoneal viscera.
Retroperitoneal organs are only covered in peritoneum on
their anterior surface.
SADPUCKER useful mnemonic to remember
retroperitoneal organs.
S: Suprarenal (adrenal) gland
A: aorta/IVC
D: duodenum (Second and third part)
P: pancreas (except tail)
U: ureters
C: colon (ascending and descending)
K: kidneys
E: (o)esophagus
R: rectum
Greater and lesser sac
The peritoneal cavity is divided into greater and lesser sacs

Note:
Supracolic compartment: Contains stomach, liver and
spleen, lies under cover of costal limits of thoracic cage.
Infracolic compartment: Divided into left and right parts by
oblique attachment of mesentery, contains small intestine
and ascending/descending colon, continuous with pelvic
cavity
Peritoneal reflections: Support the viscera and provide
pathway for associated neurovascular structure.
Omentum: Peritoneal fold extending from the stomach to
adjacent neurovascular structures divided into the greater and
lesser omentum
Mesenteries: Peritoneal fold that attaches Visceras to the
posterior abdominal wall

![Areas of Abdomen - Clinical Figure 4](/lessons/images/abdomen-peritoneum/areas-of-abdomen/figure_04_p4.png)
*Areas of Abdomen — Clinical Figure 4 (Page 4 Reference)*

![Areas of Abdomen - Clinical Figure 5](/lessons/images/abdomen-peritoneum/areas-of-abdomen/figure_05_p4.png)
*Areas of Abdomen — Clinical Figure 5 (Page 4 Reference)*

Previous Next

![Areas of Abdomen - Clinical Figure 6](/lessons/images/abdomen-peritoneum/areas-of-abdomen/figure_06_p5.png)
*Areas of Abdomen — Clinical Figure 6 (Page 5 Reference)*',
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

  -- Lesson: Dermatomes of Trunk (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'dermatomes-of-trunk',
    'Dermatomes of Trunk',
    'article',
    '# Dermatomes of Trunk

Dermatomal supply of trunk

> [!TIP]
> **High yield:**
> Previous Next

> Overview  Comments

![Dermatomes of Trunk - Clinical Figure 1](/lessons/images/abdomen-peritoneum/dermatomes-of-trunk/figure_01_p1.png)
*Dermatomes of Trunk — Clinical Figure 1 (Page 1 Reference)*

![Dermatomes of Trunk - Clinical Figure 2](/lessons/images/abdomen-peritoneum/dermatomes-of-trunk/figure_02_p1.png)
*Dermatomes of Trunk — Clinical Figure 2 (Page 1 Reference)*',
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

  -- Lesson: Gastrointestinal Tract (4 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'gastrointestinal-tract',
    'Gastrointestinal Tract',
    'article',
    '# Gastrointestinal Tract

Stomach:
Intraperitoneal organ located between oesophagus and
duodenum, lie in epigastrium, umblical and left
hypochondrium.
Stomach is divided into four regions
The cardia which surrounds opening of the oesophagus into
stomach
The fundus
The body
The Pylorus: Connects the stomach to the duodenum. It is
divided into the pyloric antrum, pyloric canal and pyloric
sphincter
The pyloric sphincter lies between the pylorus and the first
part of the duodenum. It controls of the exit of chyme.
Anatomical relation of stomach
The stomach lies anterior to the stomach bed
stomach bed formed by:
Useful mnemonic "Dr. S3 kills patients mercilessly."
Diaphragm
Splenic flexure
Suprarenal gland (Left)
Splenic artery
Kidney (Left)
Pancreas
Mesocolon (Transverse)
Blood supply:
The arterial supply to the stomach is derived from all three
branches (left gastric, splenic, and common hepatic branches)

Overview  Comments

![Gastrointestinal Tract - Clinical Figure 1](/lessons/images/abdomen-peritoneum/gastrointestinal-tract/figure_01_p1.png)
*Gastrointestinal Tract — Clinical Figure 1 (Page 1 Reference)*

of the coeliac trunk.
Innervation:
Parasympathetic from anterior and posterior vagal trunk
derived from vagus nerve
Sympathetic nerve supply: From the T6 through T9 segments
of the spinal cord passes to celiac plexus through the Greater
splanchnic nerve mediates epigastric and visceral referred
pain from gastric ulcer.
Small intestine:
longest part of the gastrointestinal tract and extends from the
pyloric orifice of the stomach to the ileocaecal fold, comprising
the duodenum, jejunum and ileum.
Duodenum:
C shaped structure lying Infront of, and to the right of inferior
vena cava and aorta
Duodenum is retroperitoneal organ except for its proximal
part
Parts of duodenum:
First part: The superior (first) part extends from the pyloric
orifice of the stomach to the neck of the gallbladder, lies just to
the right of the body of vertebra L1, and passes anterior to the
inferior vena cava and superior to the head of the pancreas
Second part: The Descending (2nd) Part of the duodenum
It lies to the right of the bodies of L1 to L3 vertebrae. Runs
inferiorly, curving around the head of the pancreas. It extends
from the superior duodenal flexure to the inferior duodenal
flexure.
During its descent, it passes right of and parallel with the
inferior vena cava.
The common bile duct and main pancreatic duct (these
ducts usually unite to form the hepatopancreatic ampulla of
Vater) enter the posteromedial wall of this part of the
duodenum, about  of the way along its length.
The lesser duodenal papilla lies about 6-8 cm distal to the
pylorus and has at its summit the opening of the accessory

pancreatic duct.
Third part: The inferior or horizontal part of the duodenum
Runs transversely to the left, passing over the IVC, aorta, and L3
vertebra.
It is crossed by the superior mesenteric artery and vein and
the root of the mesentery.
Superior to it is the head of the pancreas and its uncinate
process.
Fourth part: The Ascending (4th) Part of the Duodenum
This ascends on the left side of the aorta anterior to the left
renal vessels to the level of L2 vertebra.
Here it meets the jejunum at the duodenojejunal flexure. The
duodenojejunal flexure is supported by a fibromuscular band
called the suspensory muscle (ligament) of the duodenum
(ligament of Treitz).
Blood supply: Branches of coeliac trunk and superior
mesenteric artery
Proximal to the major duodenal papilla: supplied by the
gastroduodenal artery (branch of the common hepatic artery
from the coeliac trunk).
Distal to the major duodenal papilla: supplied by the inferior
pancreaticoduodenal artery (branch of superior mesenteric
artery).

> [!TIP]
> **Clinical pearls:**
> Duodenal ulcer: erosion of the mucosa in the duodenum
> most likely to occur in the superior portion of the
> duodenum.

The most common causes of duodenal ulcers are
Helicobacter pylori infection and chronic NSAID therapy.
Duodenal ulcer most likely erosion of the gastroduodenal
artery
Small intestine jejunum and ileum:

![Gastrointestinal Tract - Clinical Figure 2](/lessons/images/abdomen-peritoneum/gastrointestinal-tract/figure_02_p3.png)
*Gastrointestinal Tract — Clinical Figure 2 (Page 3 Reference)*

Blood supply: Superior mesenteric artery

> [!TIP]
> **Clinical pearls:**
> Meckel''s Diverticulum:
> True diverticula of all 3 layers of the small intestines
> Caused by incomplete obliteration of the vitelline duct.

Rule of 2s: 2 years old, 2 ft from ileocecal valve, 2 in long, 2% of
population
Usually, asymptomatic
Painless bleeding due to an ulcer caused by heterotopic
gastric tissue most common presentation in children
Obstruction is caused by intussusception, volvulus, and
hernia most common presentation in adults.
Rich blood supply to Meckle''s diverticulum is from Superior
mesenteric artery.
Proximal to the major duodenal papilla: supplied by the
gastroduodenal artery (branch of the common hepatic
artery from the coeliac trunk
Distal to the major duodenal papilla: supplied by the
inferior pancreaticoduodenal artery (branch of a superior
mesenteric artery)
Large intestine
Extends from the ileocecal junction to the anus and is
approximately 1.5 m (5 ft) long. Consists of the cecum,
appendix, colon, rectum, and anal canal.
Cecum: First part of the large intestine, blind end pouch of
the large intestine
It lies in the right iliac fossa.
Surrounded by peritoneum.

Colon
Has ascending and descending colons that are
retroperitoneal and transverse and sigmoid colons that are
surrounded by peritoneum (intraperitoneal).
Ascending Colon:The colon begins as the ascending colon.
Is a retroperitoneal structure which ascends superiorly from
the cecum.
When it meets the right lobe of the liver, it turns 90 degrees
to move horizontally. This turn is known as the right colic
flexure (or hepatic flexure) and marks the start of the
transverse colon.
Transverse Colon
The transverse colon extends from the right colic flexure to
the spleen, where it turns another 90 degrees to point

![Gastrointestinal Tract - Clinical Figure 3](/lessons/images/abdomen-peritoneum/gastrointestinal-tract/figure_03_p5.png)
*Gastrointestinal Tract — Clinical Figure 3 (Page 5 Reference)*

inferiorly. This turn is known as the left colic flexure (or
splenic flexure)
Blood supply of colon:
Cecum, Appendix, the ascending colon, hepatic flexure and
proximal  of the transverse colon are supplied by the
superior mesenteric artery.
Distal  of transverse colon, Splenic flexure and the
descending and sigmoid colons are supplied by the inferior
mesenteric artery.
Lymphatic nodes:
The ascending and transverse colons: superior mesenteric
nodes
The descending and sigmoid colons: Inferior mesenteric
nodes
Note: Most of the lymph from the superior and inferior
mesenteric nodes passes into the intestinal lymph trunks,
and on to the cisterna chyli, where it ultimately empties into
the thoracic duct.
Innervation:
Ascending colon and proximal  of the transverse colon:
receive their sympathetic, parasympathetic and sensory
supply via nerves from the superior mesenteric plexus.
Distal  of the transverse colon, descending colon and
sigmoid colon: receive their sympathetic, parasympathetic
and sensory supply via nerves from the inferior mesenteric
plexus:
Parasympathetic innervation via the pelvic splanchnic
nerves
Sympathetic innervation via the lumbar splanchnic nerves.
Large intestine-Appendix: Is a narrow, hollow, muscular tube
with large aggregations of lymphoid tissue in its wall.
suspended from the terminal ileum by a small mesentery,
the mesoappendix, which contains the appendicular vessels.
Causes spasm and distention when inflamed, resulting in
pain that is referred to the periumbilical region and moves
down and to the right.

Has a base that lies deep to McBurney point, which occurs at
the junction of the lateral one-third of an imaginary line
between the right anterior superior iliac spine and the
umbilicus. This is the site of maximum tenderness in acute
appendicitis.
Position of appendix: Most common appendix position is
retrocaecal followed by pelvic.
It may be:
Posterior to the caecum (retrocaecal)
suspended over the pelvic brim in a pelvic or descending
position.
Below the caecum in a subcaecal position
Blood supply: Branch of superior mesenteric artery
Note: sympathetic afferent fibres of the appendix arise from
T10 of the spinal cord, thus explaining why the visceral pain
of early appendicitis is felt centrally within the abdomen in
periumbilical region.

> [!TIP]
> **Clinical pearls:**
> Rovsing''s sign: Pain in the right lower quadrant is
> complained of when palpation pressure is exerted in the left
> lower quadrant. It is also called referred rebound tenderness
> and when present is quite helpful in supporting the
> diagnosis.

Psoas sign: This test is performed by having the patient lie
on his left side. The examiner then slowly extends the
patient''s right thigh, thus stretching the iliopsoas muscle.
This will produce pain to make the sign positive. This
indicates presence of irritative inflamed appendix in close
proximity to the psoas muscle. This is possible in retrocaecal
appendicitis.
Obturator test: Passive internal rotation of flexed right thigh
with the patient in supine position will elicit pain. This
positive obturator sign is diagnostic of pelvic appendicitis.
Rectum and anal canal:
Rectum is a part of the large intestine that extends from the
sigmoid colon to the anal canal and follows the curvature of
sacrum and coccyx.
Rectum is retroperitoneal structure.

In men the rectum lies posterior to the bladder, prostate and
seminal vesicle.
In woman lies posterior to uterus, vagina and cervix.
Peritoneal Coverings: In the superior third of the rectum, the
anterior surface and lateral sides are covered by peritoneum.
The middle third only has an anterior peritoneal covering
Lower  has no peritoneum associated with it.
In males, the reflection of peritoneum from the rectum to the
posterior bladder wall forms the rectovesical pouch.
In females, the peritoneum reflects to the posterior vagina
and cervix, forming the rectouterine pouch (pouch of
Douglas
Blood supply:
Superior rectal artery: terminal continuation of the inferior
mesenteric artery.
Middle rectal artery: branch of the internal iliac artery.
Inferior rectal artery: branch of the internal pudendal artery.
Innervation of Rectum:
Sympathetic nervous supply to the rectum is from the
lumbar splanchnic nerves and superior and inferior
hypogastric plexuses.
Parasympathetic supply is from S2-4 via the pelvic
splanchnic nerves and inferior hypogastric plexuses.
Lymphatic drainage: Pararectal lymph nodes

> [!TIP]
> **Clinical pearls:**
> Digital rectal examination: Performed by inserting a gloved
> lubricated finger into the rectum
> The anterior wall of the rectum has a number of close
> anatomical structures, and these structures can therefore be
> palpated digitally via the rectum.

Most significant are the prostate and seminal vesicles in
males, and cervix in females.
Bony structures, such as the sacrum and coccyx, may also be
palpated in both sexes.
Anal canal:

Lies below the pelvic diaphragm and ends at the anus
Anal sphincter:
Internal anal sphincter: Consists of involuntary smooth
muscle that surrounds the upper  of the anal canal.
External anal sphincter: voluntary muscle that surrounds
the lower  of the anal canal (and so overlaps with the
internal sphincter). It blends superiorly with the puborectalis
muscle of the pelvic floor.
Iin the anal canal, the mucosa is organized into longitudinal
folds, known as anal columns. These are joined at their
inferior ends by anal valves. The anal valves collectively form
an irregular circle known as the pectinate line (or dentate
line). This line divides the anal canal into upper and lower
parts.
Defecation: Is initiated by distention of the rectum, filled
from the sigmoid colon, and afferent impulses are
transmitted to the spinal cord by pelvic splanchnic nerves.
The pelvic splanchnic nerves increase peristalsis (contracts
smooth muscles in the rectum). In contrast, sympathetic
nerves cause a decrease in peristalsis, maintain tone in the
internal sphincter, and contain vasomotor and sensory (pain)
fibers. Involves the following:
The intra-abdominal pressure is increased by holding the
breath and contracting the diaphragm, the abdominal
muscles, and the levator ani, thus facilitating the expulsion of
feces.
The puborectalis relaxes, which decreases the angle between
the ampulla of the rectum and the upper portion of the anal
canal, thus facilitating defecation.
The smooth muscle in the wall of the rectum contracts, the
internal anal sphincter relaxes, and the external anal
sphincter relaxes to pass the feces.
After evacuation, the contraction of the puborectalis and the
anal sphincters closes the anal canal.
Neurovascular supply and lymphatic drainage of anal
canal:

> [!TIP]
> **Clinical pearls:**
> Hemorrhoids are dilated internal and external venous
> plexuses around the rectum and anal canal.

Internal hemorrhoids occur above the pectinate line, are
covered by a mucous membrane, and their pain fibers are
carried by Visceral afferent fibers of the sympathetic nerves.
External hemorrhoids are situated below the pectinate line,
are covered by skin, and are more painful than internal
hemorrhoids because their pain fibers are carried by Somatic
fibers of the inferior rectal nerves.
Previous Next

![Gastrointestinal Tract - Clinical Figure 4](/lessons/images/abdomen-peritoneum/gastrointestinal-tract/figure_04_p10.png)
*Gastrointestinal Tract — Clinical Figure 4 (Page 10 Reference)*',
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

  -- Lesson: Lumbar Spine and Plexus (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'lumbar-spine-and-plexus',
    'Lumbar Spine and Plexus',
    'article',
    '# Lumbar Spine and Plexus

Lumbar spine:
located between the thoracic and sacral vertebral segments.
Ligaments of the lumbar spine
Note: In the cervical spine, the interspinous and supraspinous
ligaments thicken and combine to form the ligamentum
nuchae which Supports head, resists flexion of neck and helps
return head to anatomical position
Lumbar plexus:
Formed by the union of the ventral rami of the first three
lumbar nerves and a part of the fourth lumbar nerve.
Lies anterior to the transverse processes of the lumbar
vertebrae within the substance of psoas major muscle.

Overview  Comments

![Lumbar Spine and Plexus - Clinical Figure 1](/lessons/images/abdomen-peritoneum/lumbar-spine-and-plexus/figure_01_p1.png)
*Lumbar Spine and Plexus — Clinical Figure 1 (Page 1 Reference)*

Note:Sub-costal nerve: (T12)Largest thoracic spinal nerve
originates from anterior ramus of spinal nerve T12, Innervates
external oblique, internal oblique, transversus abdominus,
rectus abdominus and pyramidalis muscle
Previous Next

![Lumbar Spine and Plexus - Clinical Figure 2](/lessons/images/abdomen-peritoneum/lumbar-spine-and-plexus/figure_02_p2.png)
*Lumbar Spine and Plexus — Clinical Figure 2 (Page 2 Reference)*',
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

  -- Lesson: Male and Female Reproductive System (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'male-and-female-reproductive-system',
    'Male and Female Reproductive System',
    'article',
    '# Male and Female Reproductive System

Male Genital organs:
Testis and Epididymis:
Paired structure located within the scrotum
Testis and Epididymis are Suspended in the scrotum by the
spermatic cord.
Testes are site of sperm production
Epididymis stores the sperm
Anatomic structure:
Testis is covered by tunica albuginea which lies beneath the
visceral layer of the tunica veginalis
Each testis is composed of seminiferous tubules which
produce spermatozoa and interstitial cells (of Leydig)
secrete testosterone
Innervation of testis and epididymis: testicular plexus - a
network of nerves derived from the renal and aortic plexus
Lymphatic drainage:(Important to remember)
Testes lumbar (para-aortic) nodes in the abdomen
scrotum drains to the superficial inguinal nodes.
Blood supply: Paired testicular arteries arise from abdominal
aorta

> [!TIP]
> **Clinical pearls:**
> Testicular torsion is the twisting of a testis and the spermatic
> cord, obstructing blood vessels to the testis and causing
> sudden urgent pain and swelling of the scrotum.

Caused by trauma or spasm of cremasteric muscle.
Ductus deferens:
Is continuous with the tail of the epididymis and serves to
transport sperm to the ejaculatory ducts prior to ejaculation.

Overview  Comments

Is a thick-walled tube that ascends within the spermatic cord
to enter the pelvis at the deep inguinal ring lateral to the
inferior epigastric artery.

> [!TIP]
> **Clinical pearls: Vasectomy is the surgical excision of a portion**
> of the vas deferens (ductus deferens) through the scrotum. It
> stops the passage of spermatozoa.

Spermatic cord and contents:
Must remember important spermatic cord covering and
contents with rule of "3"
Three arteries, three nerves and three other structures

> [!TIP]
> **High yield:**
> Penis:
> The penis consists of a root (two crura and the bulb of the
> penis) and the body, which is formed by the single corpus
> spongiosum which contains the spongy urethra and paired
> corpora cavernosa.  Its head is called the glans penis which is
> the terminal part of the corpus spongiosum.

Innervation: The penis is supplied by S2-S4 spinal cord
segments and spinal ganglia.
Sensory and sympathetic innervation to the skin and glans
penis is supplied by the dorsal nerve of the penis, a branch of

![Male and Female Reproductive System - Clinical Figure 1](/lessons/images/abdomen-peritoneum/male-and-female-reproductive-system/figure_01_p2.png)
*Male and Female Reproductive System — Clinical Figure 1 (Page 2 Reference)*

the pudendal nerve.
Parasympathetic innervation is carried by cavernous nerves
from the peri-prostatic nerve plexus and is responsible for
the vascular changes which cause erection.
Blood supply: Dorsal arteries of the penis, Deep arteries of the
penis and Bulbourethral artery branches of the internal
pudendal artery.
Lymphatic drainage: (Important to remember)
Penile Skin and prepuce: Drain into Superficial inguinal
nodes.
Glans penis and penile urethra drain into deep inguinal
nodes.
Prostate gland:
largest accessory structure of male reproductive system lies
immediately inferior to the bladder and the internal urethral
sphincter
Anterior to the rectum
superior to the external urethral sphincter
Functional anatomy: Secretes a fluid that produces the
characteristic odor of semen. This fluid, the secretion from the
seminal vesicles and the bulbourethral glands, and the
spermatozoa constitute the semen or seminal fluid.
Prostate has four zones:
Anterior zone: which lies in front of the urethra.
Transitional zone: encompasses the urethra proximal to the
ejaculatory ducts and is prone to benign hypertrophy
obstructing the internal urethral orifice
Central zone: encompasses the ejaculatory ducts up to the
urethra.
Peripheral zone: situated posteroinferior and lateral to the
transitional and central zones, forming the main mass of the
gland and is thus the most prone to carcinomatous
transformation.

> [!TIP]
> **Clinical pearls: Hypertrophy of the prostate is a benign**
> enlargement of the prostate that affects older men and occurs

most often in the transitional zone, obstructing the internal
urethral orifice and thus leading to nocturia (excessive
urination at night), dysuria (difficulty or pain in urination), and
urgency (sudden desire to urinate).
Prostate cancer is a slow-growing cancer that occurs
particularly in the peripheral zone.
Blood supply: Prostatic arteries derived from internal iliac
arteries.
Innervation : The prostate receives sympathetic,
parasympathetic and sensory innervation from the inferior
hypogastric plexus
Female genital organs:
Ovary:
Female gonads: Sites of egg production
Ovaries Lie on the posterior aspect of the broad ligament on
the side wall of the pelvis minor and are bounded by the
external and internal iliac vessels.
Not covered by the peritoneum, and thus, the ovum or
oocyte is expelled into the peritoneal cavity and then into the
uterine tube.
Are not enclosed in the broad ligament, but their anterior
surface is attached to the posterior layer of the broad
ligament by the mesovarium
Ligaments of the ovary:
Ovarian ligament (Round ligament of ovary) Attaches the
ovaries to the lateral wall of uterus
Suspensory ligament of ovary: fold of peritoneum extending
from the mesovarium to the pelvic wall. Contains neurovascular
structures
Blood supply: Are supplied primarily by the ovarian arteries,
which are contained in the suspensory ligament and
anastomose with branches of the uterine artery.

Venous drainage:
Are drained by the ovarian veins; the right ovarian vein joins the
inferior vena cava, and the left ovarian vein joins the left renal
vein
Innervation: Autonomic: via the ovarian plexus
Visceral afferents: accompany the sympathetic fibers to T10 -
T12 level of the spinal cord sensory ganglia
Pain is thus referred to the periumbilical region, suprapubic
region and groin.
Uterine tube:
The uterine tube extends from the uterus to the ovary and
consists of the isthmus, ampulla, and infundibulum. The
fimbriated distal end creates currents, drawing an ovulated
oocyte into the uterine tube.
Note: Ectopic pregnancy most commonly occurs in the
ampulla (70% of cases).
Uterus:

![Male and Female Reproductive System - Clinical Figure 2](/lessons/images/abdomen-peritoneum/male-and-female-reproductive-system/figure_02_p5.png)
*Male and Female Reproductive System — Clinical Figure 2 (Page 5 Reference)*

Contains a fundus, body, isthmus and cervix and is supported
by ligaments.
Relations:
Anteriorly: vesicouterine pouch and the urinary bladder
Posteriorly: the rectouterine pouch and the anterior surface
of rectum
Laterally: the broad ligament
Suspensory ligaments:
The uterosacral ligament
The round ligaments
The cardinal ligaments
Arterial supply:
Uterine arteries: branch of internal iliac artery
Ovarian arteries: branch of the abdominal aorta at the level of
L1.
Venous drainage:
Uterine veins: they are formed from the plexus and drain into
internal iliac veins
Innervation: Autonomic
Hypogastric plexus (sympathetic)
S3-S4 (parasympathetic)
Visceral afferents: T11-T12
Vagina:
Relations:
Anteriorly: urethral orifice
Posteriorly: The rectum
Arterial supply: Uterine arteries supply the superior
portion: branch of the internal iliac artery
Vaginal artery and internal pudendal arteries supply the middle
and inferior parts: branches of the internal iliac artery.

Venous drainage: Uterovaginal plexus: drains into internal iliac
veins
Innervation
Autonomic: inferior hypogastric plexus, pelvic splanchnic,
pudendal nerve (all provide parasympathetic Innervation
from S2-S4)
Visceral afferents: accompany parasympathetic fibers of
inferior hypogastric and pelvic splanchnic nerves to S2-S4.
Somatic afferents: accompany pudendal nerve to S2-S4.

> [!TIP]
> **Clinical pearls:**
> Digital vaginal examination:
> Digital vaginal examination allows palpation of the:
> urethra and bladder through the anterior fornix of the vagina
> the perineal body, rectum, coccyx and sacrum through the
> posterior fornix
> ovaries, uterine tubes, ureters and ischial spines through the
> lateral fornices
> Previous Next',
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

  -- Lesson: Pelvic Diaphragm and Supporting Structures (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'pelvic-diaphragm-and-supporting-structures',
    'Pelvic Diaphragm and Supporting Structures',
    'article',
    '# Pelvic Diaphragm and Supporting Structures

Pelvic diaphragm and supporting
structures:
Pelvic Diaphragm:
Forms the pelvic floor and supports all of the pelvic viscera.
Is formed by the levator ani and coccygeus muscles and their
fascial coverings
Lies posterior and deep to the urogenital diaphragm and
medial and deep to the ischiorectal fossa
On contraction, raises the entire pelvic floor.
Flexes the anorectal canal during defecation and helps the
voluntary control of micturition.
Helps direct the fetal head toward the birth canal at
parturition.
Supporting structures:
Broad ligament of the uterus:
Consists of two layers of the peritoneum, extends from the
lateral margin of the uterus to the lateral pelvic wall, and
serves to hold the uterus in position.
Contains the uterine tube, uterine vessels, round ligament of
the uterus, ovarian ligament, ureter (lower part), uterovaginal
nerve plexus, and lymphatic vessels.
Does not contain the ovary but gives attachment to the ovary
through the mesovarium
Round ligament of the uterus: Is attached to the uterus in
front of and below the attachment of the uterine tube.
Runs within the layers of the broad ligament, contains
smooth muscle fibers, and holds the fundus of the uterus
forward, keeping the uterus anteverted and anteflexed.
Enters the inguinal canal at the deep inguinal ring, emerges
from the superficial ring and becomes lost in the
subcutaneous tissue of the labium majora.

Overview  Comments

Ovarian ligament: Is a fibromuscular cord that extends from
the ovary to the uterus below the uterine tube, running within
the layers of the broad ligament.
Suspensory ligament of the ovary Is a band of peritoneum
that extends upward from the ovary over the posterior pelvic
brim and transmits the ovarian vessels, nerves, and lymphatics.
Rectouterine pouch and Rectovesical pouch:
Rectouterine pouch: Is a sac or recess formed by a fold of the
peritoneum dipping down between the rectum and the
uterus. Lies behind the posterior fornix of the vagina and
contains peritoneal fluid and some of the small intestine.
Rectovesical pouch: Is a peritoneal recess between the bladder
and the rectum in males, and the vesicouterine pouch is a
peritoneal sac between the bladder and the uterus in females
Previous Next',
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

  -- Lesson: Urinary Tract (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'urinary-tract',
    'Urinary Tract',
    'article',
    '# Urinary Tract

Kidney
The kidneys are two bean-shaped organs, located on either
side of the spine, in the retroperitoneal space, extend
between vertebrae T12 - L3.
The left kidney is situated a little higher than the right one,
because of the liver on the right side of the abdominal cavity,
above the right kidney. The kidneys have a medial dimple
called the renal hilum, which is the entry and exit point for
structures that supply or drain the kidneys such as the
nerves, ureters, vessels, and lymphatics.
Each kidney covered by fibrous capsule and surrounded by
renal fascia,
Anatomical Relations
Arterial supply: Renal arteries arising from the abdominal aorta
immediately distal to the origin of the superior mesenteric
artery
Innervation: The kidneys receive autonomic nerve fibers via
the renal plexus which contains parasympathetic fibers from
the vagus nerve and sympathetic fibers from the thoracic
splanchnic nerves.

Overview  Comments

![Urinary Tract - Clinical Figure 1](/lessons/images/abdomen-peritoneum/urinary-tract/figure_01_p1.png)
*Urinary Tract — Clinical Figure 1 (Page 1 Reference)*

Lymphatic drainage: (Important to remember): Lumbar (Para-
aortic lymph nodes) located at origin of renal arteries.
Ureter:
Muscular tube that transmits urine by peristaltic waves
Arises in the abdomen as continuation of renal pelvis.
After arising from the ureteropelvic junction, the ureters
descend through the abdomen, along the anterior surface of
the psoas major. Here the ureter lies anteriorly and slightly
medial to the tips of L2-L5 vertebrae.
At the area of the sacroiliac joints, the ureters cross the
pelvic brim, thus entering the pelvic cavity. At this point,
they also cross the bifurcation of the common iliac
arteries.
Once within the pelvic cavity, the ureters travel down the
lateral pelvic walls. At the level of the ischial spines, they turn
anteromedially, moving in a transverse plane towards the
bladder.
Upon reaching the bladder wall, the ureters pierce its lateral
aspect in an oblique manner. This creates a one-way valve,
where high intramural pressure collapses the ureters,
preventing the backflow of urine.

Innervation: Sensory fibres from the ureters enter the spinal
cord at T11-L2, with ureteric pain referred to those dermatomal
areas.

> [!TIP]
> **Clinical pearls:**
> In females ureters are in close proximity to the ovaries. Care
> must be taken not the damage the ureters during an
> oophorectomy, especially during the ligation of the ovarian
> arteries.

Damage may occur during hysterectomy or surgical repair of
a prolapsed uterus because it runs under the uterine artery.
The Ureter is inadvertently clamped, ligated during
hysterectomy when uterine artery is being ligated to control
uterine bleeding.
In men, instead of the uterine arteries, the vas deferens cross
the ureters anteriorly and lies Infront of seminal vesicles

![Urinary Tract - Clinical Figure 2](/lessons/images/abdomen-peritoneum/urinary-tract/figure_02_p3.png)
*Urinary Tract — Clinical Figure 2 (Page 3 Reference)*

before entering the posterolateral aspect of the bladder.
Ureteric calculus:
There are three locations where the ureters are at their
narrowest, this is where a stone is more likely to become stuck.
Uretopelvic junction (Usually Coincides with L2)
Pelvic brim
Where the ureter enters the bladder
Urethra
It serves as a passage for urine from the urinary bladder to
the exterior, but in men, it also serves as a passage for
semen.
Male urethra: Male urethra is approximately 20 cm long and
consists of: prostatic, membranous, bulbous and spongy
urethra.
Anterior urethra:
Penile (spongy) urethra (16 cm long): encased by corpus
spongiosum of the penis (the longest portion).
Bulbar (bulbous) urethra traverses the root of the penis, it
receives the ducts from the bulbourethral glands and the
glands of Littre
.
Posterior urethra
Membranous urethra (1 cm long): passes through the
urogenital diaphragm, surrounded by sphincter urethrae. The
shortest and narrowest portion. The lowest part of the
membranous urethra is susceptible to rupture or to
penetration by a catheter.
Prostatic Urethra (3 cm long), surrounded by the prostate
gland; on its posterior wall. It receives the ejaculatory ducts
and numerous small prostatic ducts.
Female urethra
is approximately 4 cm long, and its external urethral orifice is
situated between the labia minora, anterior to the vaginal

opening, and posterior to the glans clitoris.
Blood supply:
Penile (spongy) urethra and Membranous urethra: Supplied
by branch of internal pudendal artery
Prostatic Urethra: Branch of internal iliac artery
Innervation: prostatic plexus, which contains a mixture of
sympathetic, parasympathetic and visceral afferent fibres.
Urinary bladder:
Function as temporary storage of urine as well as expulsion
There are also two muscular sphincters located in the urethra
Internal urethral sphincter:
Male: consists of circular smooth fibres, which are under
autonomic control. It is thought to prevent seminal
regurgitation during ejaculation.
External urethral sphincter
has the same structure in both sexes. It is a skeletal muscle,
and under voluntary control.
Micturition (urination):
Is initiated by stimulating stretch receptors in the detrusor
muscle in the bladder wall as the urine volume increases
(approximately 400 ml for adults). Can be assisted by
contraction of the abdominal muscles, which increases the
intra-abdominal and pelvic pressures.
Involves the following processes:

### 1. Sympathetic (visceral efferent [VE)) fibers constrict the

internal sphincter, inhibiting emptying of the bladder (They
also activate during ejaculation to constrict the internal
sphincter in order to prevent seminal reflux into the bladder

### 2. Parasympathetic preganglionic (VE) fibers in the pelvic

splanchnic nerves pass through the pelvic (inferior hypogastric)

plexus to synapse within the bladder wall; postganglionic fibers
to the bladder musculature induce a reflex contraction of the
detrusor muscle and relaxation of the internal urethral
sphincter in concert with reduced stimulation by sympathetic
fibers.

### 3. Somatic efferent fibers in the pudendal nerve (S2-S4)

innervates the external urethral sphincter to cause voluntary
relaxation of the external urethral sphincter, and the bladder
begins to void.

> [!TIP]
> **Clinical pearls:**
> Reflex Bladder: Spinal Cord Transection Above T12
> In this case, the afferent signals from the bladder wall are
> unable to reach the brain, and the patient will have no
> awareness of bladder filling.

There is also no descending control over the external urethral
sphincter, and it is constantly relaxed. There is a functioning
spinal reflex, where parasympathetic system initiates
detrusor contraction in response to bladder wall stretch.
Thus, the bladder automatically empties as it fills - known as
the reflex bladder.
Flaccid Bladder: Spinal Cord Transection Below T12
A spinal cord transection at this level will have damaged the
parasympathetic outflow to the bladder. The detrusor muscle
will be paralyzed, unable to contract.
The spinal reflex does not function. In this scenario, the
bladder will fill uncontrollably, becoming abnormally
distended until overflow incontinence occurs.
Previous Next',
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

  -- ==========================================================================
  -- Module 5: Head & Neck Anatomy (5 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Head & Neck Anatomy' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Head & Neck Anatomy', 4, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 4, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Anterior and Posterior Triangle of Neck (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'anterior-and-posterior-triangle-of-neck',
    'Anterior and Posterior Triangle of Neck',
    'article',
    '# Anterior and Posterior Triangle of Neck

Posterior triangle
Borders:
Posterior border of the sternocleidomastoid muscle
Anterior border of the trapezius muscle
Superior border of the clavicle.
Roof:
Platysma and the investing (superficial) layer of the deep
cervical fascia.
Contents of posterior triangle of neck
Muscles: Inferior belly of omohyoid, The scalenus, splenius and
levator scapulae.
Veins: Terminal part of external jugular vein.
Arteries: Third part of subclavian artery, Transverse cervical and
suprascapular arteries.
Nerves: Accessory nerve (CN XI), Phrenic nerve, Branches of
cervical plexus and Root and trunks of brachial plexus,
Anterior triangle
Borders:
Anterior border of the sternocleidomastoid
Anterior midline of the neck
Inferior border of the mandible.
Roof:
Platysma and the investing layer of the deep cervical fascia.
Anterior triangle is further divided by the omohyoid anterior
belly and the anterior and posterior bellies of digastric into 4
Triangles:
Digastric (submandibular): submandibular gland.

Overview  Comments

Submental (suprahyoid): Submental Lymph Nodes.
Carotid: 3C (CNXII, Ansa cervicalis & carotid sheath)
Muscular (inferior carotid): Thyroid and Parathyroid Glands.
The contents of the anterior triangle of the neck include:
Muscles: Digastric, stylohyoid, mylohyoid, Geniohyoid,
sternohyoid, omohyoid, Thyrohyoid, sternothyroid and
platysma
Veins: Internal jugular vein, anterior jugular and external
jugular veins, Facial and retromandibular veins
Arteries: Carotid sheath and branches of external carotid
artery
Nerves: Nerve to Mylohyoid, CN XII & Ansa Cervicalis
Previous Next

![Anterior and Posterior Triangle of Neck - Clinical Figure 1](/lessons/images/head-neck-anatomy/anterior-and-posterior-triangle-of-neck/figure_01_p2.jpg)
*Anterior and Posterior Triangle of Neck — Clinical Figure 1 (Page 2 Reference)*',
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

  -- Lesson: Muscles of the Neck (5 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'muscles-of-the-neck',
    'Muscles of the Neck',
    'article',
    '# Muscles of the Neck

Platysma
Superficial muscle of the neck, covers most of the anterior and
lateral aspect of the neck
Sternocleidomastoid muscle
One of the largest superficial muscles of the neck. Divides the
neck into anterior and posterior triangle
Suprahyoid and infrahyoid
muscles
Suprahyoid muscles

Overview  Comments

![Muscles of the Neck - Clinical Figure 1](/lessons/images/head-neck-anatomy/muscles-of-the-neck/figure_01_p1.png)
*Muscles of the Neck — Clinical Figure 1 (Page 1 Reference)*

![Muscles of the Neck - Clinical Figure 2](/lessons/images/head-neck-anatomy/muscles-of-the-neck/figure_02_p1.png)
*Muscles of the Neck — Clinical Figure 2 (Page 1 Reference)*

Infrahyoid muscles
Musculature of tongue
Previous Next

![Muscles of the Neck - Clinical Figure 3](/lessons/images/head-neck-anatomy/muscles-of-the-neck/figure_03_p2.png)
*Muscles of the Neck — Clinical Figure 3 (Page 2 Reference)*

![Muscles of the Neck - Clinical Figure 4](/lessons/images/head-neck-anatomy/muscles-of-the-neck/figure_04_p2.png)
*Muscles of the Neck — Clinical Figure 4 (Page 2 Reference)*

![Muscles of the Neck - Clinical Figure 5](/lessons/images/head-neck-anatomy/muscles-of-the-neck/figure_05_p2.jpg)
*Muscles of the Neck — Clinical Figure 5 (Page 2 Reference)*',
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

  -- Lesson: Structure of the Eyeball and Eyelid (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'structure-of-the-eyeball-and-eyelid',
    'Structure of the Eyeball and Eyelid',
    'article',
    '# Structure of the Eyeball and Eyelid

Structure of the Eyeball
The eyeball consists of 3 coats:

### 1. External protective fibrous coat: Made up of anterior

transparent part the cornea and a posterior opaque part the
sclera

### 2. middle: vascular pigmented coat consists from behind

forward.
Choroid
Ciliary body (connects the choroid to iris)
Iris: Circular pigmented diaphragm, its aperture known as
the pupil, lies Infront of the lens, divides space between
cornea and lens into anterior and posterior chambers

### 3. Internal nervous coat: Called the Retina

Optic Disc: Where the optic nerve leaves the retina. Optic
disc is pierced by the central artery of the retina.
Contents of the Eyeball: Consists of aqueous humour, lens
and vitreous body
Aqueous Humour: Fills anterior and posterior chambers of eye
Lens: Transparent and Bi-Convex
Vitreous body: Fills the eyeball behind the lens.
Supports posterior surface of lens.
Blood Supply: Opthalmic artery
Central retinal artery is a branch of ophthalmic artery, and
Opthalmic artery is a first major branch of internal carotid
artery
Venous drainage: Into Cavernous sinus
Movements of the eyeball (Extra
ocular muscles)
All the extraocular muscles are innervated by oculomotor
nerve except LR-6 and S0-4

Overview  Comments

Eye Lid:
The eyelids are thin, soft tissue structures that cover the
eyeball anteriorly. They offer protection from excessive light
or injury and maintain lubrication by distributing tears over
the surface of the eyeball. The eyelids split into upper and
lower portions, which meet at the medial and lateral canthi
of the eye. The opening between the two eyelids is called the
palpebral aperture.
The eyelid consists of five main layers (superficial to deep):
Skin and subcutaneous tissue (Most superficial structure)
Orbicularis oculi
Tarsal plates
Levator apparatus
Conjunctiva
Orbicularis oculi (Closes the eyelids): The orbicularis oculi
muscle is innervated by the branches of facial nerve and
closes the eyelids. Loss of function of the orbicularis oculi
causes an inability to close the eyelids tightly and a drooping
of the lower eyelid (ectropion) resulting in spillage of tears.
This leads to drying of the cornea. The orbicularis oculi
muscle has three distinct parts: palpebral, lacrimal and
orbital part.
Actions:
Palpebral part: gently closes the eyelids.
Lacrimal part: involved in the drainage of tears.

![Structure of the Eyeball and Eyelid - Clinical Figure 1](/lessons/images/head-neck-anatomy/structure-of-the-eyeball-and-eyelid/figure_01_p2.png)
*Structure of the Eyeball and Eyelid — Clinical Figure 1 (Page 2 Reference)*

Orbital part: tightly closes the eyelids.
Other muscles: (High Yield)
The levator palpebrae superioris muscle: innervated by the
oculomotor nerve and acts to raise the upper eyelid. Loss of
function of the levator palpebrae superioris muscle results in
a complete ptosis.
The superior tarsal muscle is innervated by postganglionic
sympathetic fibres from the superior cervical ganglion, which
helps to maintain upper eyelid opening. Loss of function of
the superior tarsal muscle results in a partial ptosis.
Tarsal plate: The tarsal plates are located deep to the
orbicularis oculi muscle. There are two plates; the superior
tarsus (upper eyelid) and inferior tarsus (lower eyelid).
The tarsal plate in the eyelid provides structural support,
serves as an attachment site for muscles, houses meibomian
glands, and helps distribute tears, distributed tear film can
help flush away foreign particles and potential pathogens,
reducing the risk of infection.
In the tarsal plates lie the Meibomian glands (also known as
tarsal glands). These are a specialised type of sebaceous
gland that secretes an oily substance onto the eye to slow
the evaporation of the eye''s tear film. The oily substance also
prevents the eyelids from sticking together when closed.

> [!TIP]
> **Clinical pearls: Dysfunction in these glands, often due to**
> blockages or inflammation, can lead to reduced tear stability
> and dry eye.

Previous Next',
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

  -- Lesson: Thyroid Gland (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'thyroid-gland',
    'Thyroid Gland',
    'article',
    '# Thyroid Gland

Thyroid Gland
The thyroid gland is an endocrine organ which regulates basal
metabolic rate & stimulates growth
Parts
2 lobes: Right & Left lobes
Isthmus: which connects the lobes
Position: The gland lies at the level of C5, C6, C7
each lobe extends from middle of thyroid cartilage to 4th or
5th tracheal ring.
isthmus extends from 2nd to 3rd tracheal ring.

Overview  Comments

![Thyroid Gland - Clinical Figure 1](/lessons/images/head-neck-anatomy/thyroid-gland/figure_01_p1.jpg)
*Thyroid Gland — Clinical Figure 1 (Page 1 Reference)*

Relations of the lobe
Anterolateral:
sternothyroid
sternohyoid
superior belly of omohyoid
anterior border of sternocleidomastoid
Posterolateral
carotid sheath & its contents: CCA, IJV and Vagus nerve
Medially
larynx
Trachea
esophagus
external laryngeal nerve and Recurrent laryngeal nerve
Arterial Supply
superior thyroid artery from External carotid artery
inferior thyroid artery from thyrocervical trunk
Thyroid Ima artery from brachiocephalic artery
Venous Drainage
superior thyroid vein: drain into internal jugular vein.
middle thyroid vein: drain into internal jugular vein.
inferior thyroid vein: anastomose with Left brachiocephalic
vein.
Lymphatic Drainage: deep cervical Lymph nodes

> [!TIP]
> **Clinical pearls:**
> Structure vulnerable to damage in thyroid surgery include.

Recurrent laryngeal nerve
Thyroid Ima artery
Inferior thyroid vein
Anterior jugular vein
Parathyroid gland
Oesophagus
Previous Next',
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

  -- Lesson: Visual Pathway (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'visual-pathway',
    'Visual Pathway',
    'article',
    '# Visual Pathway

Visual pathway
The visual pathway consists of the retina, optic nerves, optic
chiasm, optic tracts, lateral geniculate bodies, optic radiations,
and visual cortex.
At the visual cortex brain processes sensory information and
responds appropriately
Optic nerve
Optic chiasm: Within the middle cranial fossa, optic nerves
from each eye unite to form optic chiasm.
Optic tract: At the optic chiasm fibers from the medial (Nasal)
half of each retina crossover forming the left and right optic
tract.
Lateral geniculate nucleus: Each optic tract travels to its
corresponding cerebral hemisphere to reach the lateral
geniculate nucleus (LGN), a relay system located in the
thalamus; the fibers synapse here.
Optic radiation: Axons from the LGN then carry visual
information via a pathway known as optic radiation. The
pathway itself can be divided into:
Upper optic radiation carries fibres from the superior retinal
quadrants (corresponding to the inferior visual field
quadrants). It travels through the parietal lobe to reach the
visual cortex.
Lower optic radiation carries fibres from the inferior retinal
quadrants (corresponding to the superior visual field
quadrants). It travels through the temporal lobe, via a
pathway known as Meyers'' loop, to reach the visual cortex.

> [!NOTE]
> **Remember the lesions of visual pathway (High yield)**

Overview  Comments

Previous Next

![Visual Pathway - Clinical Figure 1](/lessons/images/head-neck-anatomy/visual-pathway/figure_01_p2.jpg)
*Visual Pathway — Clinical Figure 1 (Page 2 Reference)*',
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
  -- Module 6: Central Nervous System & Spine (11 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Central Nervous System & Spine' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Central Nervous System & Spine', 5, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 5, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Brainstem, Pons (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'brainstem-pons',
    'Brainstem, Pons',
    'article',
    '# Brainstem, Pons

Brainstem:
Consists of midbrain, pons and medulla.
Mid brain:
Smallest of the three regions lies predominantly in the
posterior cranial fossa.
It can be divided into two main parts:
Tectum: located posterior to the cerebral aqueduct The
tectum houses four rounded prominences named colliculi
(collectively the corpora quadrigemina) which sit directly
inferior to the pineal gland. The colliculi are separated by the
cruciform sulcus; there are two superior and two inferior
colliculi.
Paired cerebral peduncles: located anteriorly and laterally
extend from the cerebral hemispheres to converge as they
meet the pons. They are separated anteriorly in the midline
by the interpeduncular fossa
The oculomotor nerve (CNIII) is seen exiting from between
the peduncles while the optic tract runs around the superior
border of the midbrain.
Note: Dopaminergic neurons are essential for controlling key
functions of the brain, such as voluntary movement, reward
processing, and working memory. The largest populations of
these neurons sit within the midbrain in substantia nigra.

Overview  Comments

Vasculature of the mid brain:
The midbrain receives vascular supply from the basilar artery,
and its branches. The major vessels are:
Posterior cerebral artery and its peduncular branch
Superior cerebellar artery
Posterior choroidal artery
Interpeduncular branches of the basilar artery
Pons:
largest part of the brainstem, located above the medulla and
below the midbrain. The pons houses nuclei of the several
cranial nerves which include trigeminal nerve(v), the abducens
nerve (VI), the facial nerve (VII) and the vestibulocochlear nerve

## (Viii).

Trigeminal nuclei (paralysis of muscles of mastication, jaw
deviation, loss of facial sensation)
Abducens nucleus (lateral rectus paralysis)
Facial nucleus (facial nerve paralysis and loss of taste
sensation from anterior tongue)
Vestibular nuclei (nystagmus, nausea, vomiting, vertigo)
Cochlear nuclei (central nerve deafness

> [!TIP]
> **Clinical pearls:**
> Cerebellopontine Angle Syndrome: Cerebellopontine Angle is
> clinically important because of its closeness to cranial nerves
> Clinical features:

![Brainstem, Pons - Clinical Figure 1](/lessons/images/central-nervous-system-spine/brainstem-pons/figure_01_p2.png)
*Brainstem, Pons — Clinical Figure 1 (Page 2 Reference)*

Unilateral hearing loss (85%), speech impediments,
disequilibrium, tremors or other loss of motor control.
Facial paralysis (compression of CN VII), Reduced corneal
reflex (involvement of both CN V and CN VII), Trigeminal palsy
(compression of CN V) and Ipsilateral cerebellar signs in large
tumors noted
Previous Next',
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

  -- Lesson: Basal Ganglia (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'basal-ganglia',
    'Basal Ganglia',
    'article',
    '# Basal Ganglia

Basal Ganglia:
The cluster of sub-cortical nuclei located deep to cerebral
hemispheres. Basal ganglia''s largest component is corpus
striatum which contains the caudate and lenticular nuclei
(the putamen, globus pallidus externus, and internus), the
subthalamic nucleus (STN), and the substantia nigra (SN).
Function: Basal ganglia provide a feedback mechanism to
cortex modulating movements; preventing unwanted
movements
Caudate Nucleus: Forms the lateral wall of lateral ventricle.
caudate nucleus is separated from the putamen by
descending white matter fibres, which at this level are known
as internal capsule.
Lenticular Nuclei:
1:Putamen: Forms lateral aspect of lenticular nuclei
2:Globus pallidus: On inner surface of putamen lies globus
pallidus; externus, and internus.
Substantia Nigra: located in the midbrain but considered
functionally as a part of the basal ganglia

> [!TIP]
> **Clinical pearls:**
> Basal ganglia are particularly associated with movement
> disorders.  tremors; involuntary muscle movements;
> abnormal increase in tone, difficulty initiating movements,
> and abnormal posture
> Parkinson''s is the most important and notorious disease of
> the basal ganglia. Classic clinical symptoms include
> bradykinesia, resting tremor, postural instability, and
> shuffling gait
> Previous Next

> Overview  Comments',
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

  -- Lesson: Central Nervous System - Overview (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'central-nervous-system-overview',
    'Central Nervous System - Overview',
    'article',
    '# Central Nervous System - Overview

Central Nervous system overview
The central nervous system consists of the brain and the spinal
cord. The peripheral nervous system consists of the extensions
of neural structures beyond the central nervous system and
includes somatic and autonomic divisions.
The brain is composed of 3 main structural divisions:
The cerebrum (Cerebral hemispheres and diencephalon)
The brainstem
The cerebellum
NOTE:  At the base of the brain is the brainstem, which extends
from the upper cervical spinal cord to the diencephalon of the
cerebrum. The brainstem is divided into the medulla, pons, and
midbrain. Posterior to the brainstem lies the cerebellum.
Spinal cord:
The spinal cord is housed in the vertebral canal. It is
continuation of medulla oblongata and terminates as the
conus medullaris at the second lumbar vertebrae of adults.
At birth, the conus medullaris lies at L3. By the age of 21, it
sits at L1/L2, thus the spinal cord only occupies about 2/3s of
the space available to it in the vertebral canal.
Below the conus medullaris is cauda equina which lies
below L1 from L2 to sacrum
Internal anatomy:
A transverse section of the spinal cord reveals a distinct
"butterfly" pattern of dark, inner grey" matter surrounded by
the light white matter.
The white matter contains the ascending and descending
pathways connecting the brain and spinal cord.
The grey matter is rich in nerve cell bodies which are divided
into four main columns.

Overview  Comments

Anterior horn (Ventral horn): largely contains motor neurons
that exit the spinal cord to innervate skeletal muscle.
Posterior division (Dorsal horn): Receive somatosensory
information from the body, which is then transmitted via the
ascending pathways, to the brain.
Intermediate horn: Innervate visceral and pelvic organs.
Lateral horn: Innervate visceral and pelvic organs.
Spinal nerve roots:
The spinal nerves are formed by the union of posterior and
anterior roots.
Spinal rootlets emerge from the spinal cord in the
subarachnoid space and amalgamate shortly afterwards into
roots.
Anterior roots: Containing motor nerve fibres
posterior roots: containing the processes of sensory neurons
then emerge from their individual intervertebral foramina.
After invaginating the dura, the roots combine into mixed
spinal nerves which divide into a posterior ramus innervating
intrinsic back muscles and an associated strip of skin on the
back.
Anterior ramus (innervating the remaining muscles and skin
of the trunk and limbs and the visceral organs).
Vasculature of spinal cord:
The spinal cord is supplied primarily by branches of the
vertebral artery:
The single anterior spinal artery is formed from the left and
right vertebral arteries: Supplies the anterior two-thirds of the
spinal cord, including the anterior and lateral horns and the
anterior and lateral columns.
The paired posterior spinal arteries arise from either the
posterior inferior cerebellar artery or directly from the
vertebral artery and supply the posterior third of the spinal
cord including the posterior horns and columns.
Previous Next',
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

  -- Lesson: Cerebellum (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cerebellum',
    'Cerebellum',
    'article',
    '# Cerebellum

Cerebellum:
The cerebellum is located at the back of the brain, immediately
inferior to the occipital and temporal lobes. It is separated from
these lobes by the tentorium cerebelli
Function: The cerebellum has three primary functions:
Maintenance of posture and balance
Maintenance of muscle tone
Coordination of voluntary motor activity
Vasculature of Cerebellum: The cerebellum receives its blood
supply from three paired arteries:
Superior cerebellar artery (SCA)
Anterior inferior cerebellar artery (AICA)
Posterior inferior cerebellar artery (PICA)

> [!TIP]
> **Clinical pearls:**
> In Cerebellar dysfunction wide variety of manifestations are
> possible. These can be remembered using the acronym

## ''Danish''

Dysdiadochokinesia (difficulty in carrying out rapid,
alternating movements)
Ataxia
Nystagmus (coarse)
Intention tremor
Scanning speech
Hypotonia
Cerebellar vascular lesion:

Overview  Comments

Note: Dysphagia is the differentiating symptom between AICA
and PICA. Way to remember PICA can''t chew.
Previous Next

![Cerebellum - Clinical Figure 1](/lessons/images/central-nervous-system-spine/cerebellum/figure_01_p2.png)
*Cerebellum — Clinical Figure 1 (Page 2 Reference)*',
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

  -- Lesson: Cerebrum (3 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cerebrum',
    'Cerebrum',
    'article',
    '# Cerebrum

Cerebrum:
The cerebrum is the largest part of the brain, located
superiorly and anteriorly in relation to the brainstem.
It consists of two cerebral hemispheres (left and right),
separated by the falx cerebri of the dura mater.
External structure:
The cerebral hemispheres are covered in a thin layer of grey
matter called the cerebral cortex which is folded into gyri
(elevations) and separated by sulci (depressions). The left and
right hemispheres are partially separated by a deep
longitudinal fissure (a major sulcus that runs in the median
sagittal plane)
The two cerebral hemispheres are connected by a white
matter structure, called the corpus callosum which is
composed primarily of commissural fibers.
Internal structure: The cerebrum is comprised of two different
types of tissue:
Grey matter forms the surface of each cerebral hemisphere
(known as the cerebral cortex) and is associated with
processing and cognition.
White matter forms the bulk of the deeper parts of the brain.
It consists of glial cells and myelinated axons that connect
the various grey matter areas.
Lobes of cerebrum:
The cerebral hemispheres fill the area of the skull above the
tentorium cerebelli and are subdivided into lobes based on
their position relative to the major sulci:

Overview  Comments

Note:

### 1: The Broca speech area (in the dominant hemisphere only) is

the ''expressive'' Centre for the production of speech. Broca''s
area is connected to the Wernicke speech area by the arcuate
fasciculus.

### 2: The blood supply to the occipital lobe is from the posterior

cerebral artery, but the occipital poles, serving macular vision,
have an additional supply from a branch of the middle cerebral
artery

> [!TIP]
> **High Yield: Clinical effects of occlusion of cerebral arteries**

![Cerebrum - Clinical Figure 1](/lessons/images/central-nervous-system-spine/cerebrum/figure_01_p2.png)
*Cerebrum — Clinical Figure 1 (Page 2 Reference)*

Previous Next

![Cerebrum - Clinical Figure 2](/lessons/images/central-nervous-system-spine/cerebrum/figure_01_p3.png)
*Cerebrum — Clinical Figure 2 (Page 3 Reference)*

![Cerebrum - Clinical Figure 3](/lessons/images/central-nervous-system-spine/cerebrum/figure_02_p3.png)
*Cerebrum — Clinical Figure 3 (Page 3 Reference)*',
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

  -- Lesson: Medulla (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'medulla',
    'Medulla',
    'article',
    '# Medulla

Medulla:
The most inferior of the three and is continuous above with the
pons and below with the spinal cord

> [!TIP]
> **Clinical pearls:**
> Previous Next

> Overview  Comments

![Medulla - Clinical Figure 1](/lessons/images/central-nervous-system-spine/medulla/figure_01_p1.png)
*Medulla — Clinical Figure 1 (Page 1 Reference)*',
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

  -- Lesson: Spinal Cord Syndrome (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'spinal-cord-syndrome',
    'Spinal Cord Syndrome',
    'article',
    '# Spinal Cord Syndrome

Spinal cord syndrome:

> [!TIP]
> **High yield:**
> Previous Next

> Overview  Comments

![Spinal Cord Syndrome - Clinical Figure 1](/lessons/images/central-nervous-system-spine/spinal-cord-syndrome/figure_01_p1.png)
*Spinal Cord Syndrome — Clinical Figure 1 (Page 1 Reference)*

![Spinal Cord Syndrome - Clinical Figure 2](/lessons/images/central-nervous-system-spine/spinal-cord-syndrome/figure_02_p1.png)
*Spinal Cord Syndrome — Clinical Figure 2 (Page 1 Reference)*',
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

  -- Lesson: Spinal Cord Tracts (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'spinal-cord-tracts',
    'Spinal Cord Tracts',
    'article',
    '# Spinal Cord Tracts

Tracts of Spinal Cord:
The spinal cord consists of various groups of nerve fibers
carrying sensory information toward the brain and receiving
motor information from the brain.
Ascending and descending tracts of the spinal cord are
responsible for carrying motor and sensory stimuli to and
from the periphery to higher levels
Ascending tracts of the spinal cord:
Descending Tracts of the Spinal Cord:
Previous Next

Overview  Comments

![Spinal Cord Tracts - Clinical Figure 1](/lessons/images/central-nervous-system-spine/spinal-cord-tracts/figure_01_p1.png)
*Spinal Cord Tracts — Clinical Figure 1 (Page 1 Reference)*

![Spinal Cord Tracts - Clinical Figure 2](/lessons/images/central-nervous-system-spine/spinal-cord-tracts/figure_02_p1.png)
*Spinal Cord Tracts — Clinical Figure 2 (Page 1 Reference)*',
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

  -- Lesson: Thalamus (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'thalamus',
    'Thalamus',
    'article',
    '# Thalamus

Thalamus:
Paired grey matter structure located around the third ventricle
made up of at least 50 thalamic nuclei
Thalamus function:
Sensory integration and relay station for all the sensory
pathways except Olfactory
Recognition of crude pain, temperature & touch
Influences voluntary movements by receiving impulses from
basal ganglia & cerebellum & relaying them to motor cortex,
influence LMN
Participates in maintenance of state of wakefulness &
alertness through RAS
Role in emotions & recent memory
Previous Next

Overview  Comments',
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

  -- Lesson: The Ventricles (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'the-ventricles',
    'The Ventricles',
    'article',
    '# The Ventricles

The Ventricles:
The ventricles are a set of communicating cavities within the
brain that are responsible for the production, transport and
removal of cerebrospinal fluid (CSF), which bathes the central
nervous system. There are four ventricles; right and left lateral
ventricles, the third ventricle and the fourth ventricle.
Lateral Ventricles:The lateral ventricles are C-shaped cavities
located within their respective hemispheres of the
cerebrum.  The lateral ventricles are connected to the third
ventricle by the interventricular foramen of Monro.
Third Ventricle: The third ventricle is a slit-like space in the
sagittal plane, situated between the right and left thalamus
and superior to the hypothalamus. The third ventricle is
connected to the fourth ventricle by the cerebral
aqueduct.
Fourth Ventricle: The fourth ventricle lies within the
brainstem, at the junction between the pons and the
medulla oblongata.
Cerebrospinal fluid:
CSF is secreted by the ependymal cells of the ventricular
choroid plexus. The majority of CSF arises from the plexuses of
the lateral ventricles.
CSF Flow:
From the lateral ventricles, CSF passes through the
interventricular foramina to the third ventricle
From 3rd ventricle CSF passes through the cerebral aqueduct
to the fourth ventricle.
From fourth ventricle, the CSF drains via foramina into the
central spinal canal (bathing the spinal cord) and the
subarachnoid cisterns in the subarachnoid space located
between the arachnoid mater and pia mater (bathing the
brain).

Overview  Comments

CSF Reabsorption:
From the subarachnoid cisterns, CSF is reabsorbed by
arachnoid granulations, which protrude into the dura mater,
into the Dural venous sinuses and from here back into the
circulation.
Previous Next',
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

  -- Lesson: Vasculature of the CNS (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'vasculature-of-the-cns',
    'Vasculature of the CNS',
    'article',
    '# Vasculature of the CNS

Vasculature of the central nervous
system:
Vasculature of brain:
Two paired arteries are responsible for the blood supply to
the brain; the vertebral arteries, and the internal carotid
arteries. These arteries arise in the neck and ascend to the
cranium.
Within the cranial vault, the terminal branches of these
arteries form an anastomotic circle, called the Circle of Willis.
From this circle, branches arise which supply the majority of
the cerebrum.
Branches of internal carotid artery:
The two internal carotid arteries arise from the common
carotid arteries at the level of vertebra C4 and enter the cranial
cavity through the carotid canal in the temporal bone. Entering
the cranial cavity, each internal carotid artery gives off the
following paired branches:
The ophthalmic artery (supplying structures in the orbit and
giving rise to the central retinal artery supplying the retina)
The posterior communicating artery: acts as an anastomotic
''connecting vessel'' in the Circle of Willis
The anterior choroidal artery (supplying parts of the optic
pathway, the internal capsule, the midbrain and the choroid
plexus)
The anterior cerebral artery (supplying the medial cerebral
hemisphere)
The anterior communicating artery (joining the two anterior
cerebral arteries)
The middle cerebral artery (supplying the lateral cerebral
hemispheres)
Branches of vertebral arteries

Overview  Comments

The two vertebral arteries (left and right), branches of the
subclavian arteries, ascend through the transverse foramina of
the upper six cervical vertebrae before entering the cranial
cavity through the foramen magnum.
The vertebral arteries give rise to the following branches:
The single anterior spinal artery (supplying the anterior
portion of the spinal cord)
The posterior inferior cerebellar arteries (supplying the
cerebellum)
The posterior spinal arteries (supplying the posterior portion
of the spinal cord), either a direct branch of the vertebral
artery or of the posterior inferior cerebellar artery
The basilar artery is formed by the joining of the two
terminal vertebral arteries inferior to the pons.
Arterial circle of Willis: Terminal branches of the vertebral and
internal carotid arteries all anastomose to form a circular blood
vessel, called the Circle of Willis.
Anterior cerebral arteries: branches of the internal carotid
arteries.
Anterior communicating artery: connects the two anterior
cerebral arteries.
Internal carotid arteries: located immediately proximal to
the origin of the middle cerebral arteries.
Posterior cerebral arteries: Terminal branches of the basilar
artery from vertebral artery
Posterior communicating artery: Branch of the internal
carotid, this artery connects the ICA to the posterior cerebral
artery.

> [!TIP]
> **Clinical pearls:**
> Anterior communicating artery is most common site of
> berry aneurysm. Second most common site is posterior
> communicating.

Aneurysm of anterior communicating artery compress the
optic chiasma and cause bitemporal hemianopia, aneurysm
of posterior communicating artery may cause 3rd nerve
palsy.

Rupture of berry aneurysm is a common cause of
spontaneous subarachnoid hemorrhage.
Vasculature of spinal cord:
The spinal cord is supplied primarily by branches of the
vertebral artery.
The single anterior spinal artery is formed from the left and
right vertebral arteries: Supplies the anterior two-thirds of the
spinal cord, including the anterior and lateral horns and the
anterior and lateral columns.
The paired posterior spinal arteries arise from either the
posterior inferior cerebellar artery or directly from the
vertebral artery and supply the posterior third of the spinal
cord including the posterior horns and columns.
Previous Next',
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
  -- Module 7: Cranial Nerves In-Depth (12 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Cranial Nerves In-Depth' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Cranial Nerves In-Depth', 6, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 6, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Cranial Nerve 1 - Olfactory Nerve (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cranial-nerve-1-olfactory-nerve',
    'Cranial Nerve 1 - Olfactory Nerve',
    'article',
    '# Cranial Nerve 1 - Olfactory Nerve

Olfactory nerve:
First and shortest cranial nerve transmits sensory information
from the nasal epithelium via the cribriform plate of the
ethmoid bone to the primary olfactory cortex
Previous Next

Overview  Comments

![Cranial Nerve 1 - Olfactory Nerve - Clinical Figure 1](/lessons/images/cranial-nerves-in-depth/cranial-nerve-1-olfactory-nerve/figure_01_p1.png)
*Cranial Nerve 1 - Olfactory Nerve — Clinical Figure 1 (Page 1 Reference)*',
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

  -- Lesson: Cranial Nerve Iii_ Oculomotor Nerve (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cranial-nerve-iii-oculomotor-nerve',
    'Cranial Nerve Iii_ Oculomotor Nerve',
    'article',
    '# Cranial Nerve Iii_ Oculomotor Nerve

Oculomotor Nerve (CN III):
Motor nerve arises from midbrain, passes through the lateral
aspect of cavernous sinus and exits skull through the superior
orbital fissure
Previous Next

Overview  Comments

![Cranial Nerve Iii_ Oculomotor Nerve - Clinical Figure 1](/lessons/images/cranial-nerves-in-depth/cranial-nerve-iii-oculomotor-nerve/figure_01_p1.png)
*Cranial Nerve Iii_ Oculomotor Nerve — Clinical Figure 1 (Page 1 Reference)*',
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

  -- Lesson: Cranial Nerve Ii_ Optic Nerve (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cranial-nerve-ii-optic-nerve',
    'Cranial Nerve Ii_ Optic Nerve',
    'article',
    '# Cranial Nerve Ii_ Optic Nerve

Optic nerve:
Transmit special sensory information from the retina of the eye
to the primary visual cortex of the brain.
Enters skull via optic canal of the sphenoid bone
Note:Relative afferent pupillary defect (RAPD): Seen in optic
nerve disease or asymmetrical disease of the retina in which
pupils respond differently to light stimuli shone in one eye at a
time
swinging light test if there is no RAPD the pupils of both eyes
constrict equally regardless of which eye is stimulated by the
light.
In an abnormal swinging-light test if there is a RAPD there is
less pupil constriction in the eye with the retinal or optic
nerve disease

> [!TIP]
> **Clinical pearls:**
> Pituitary adenoma: Pituitary gland lies in close proximity to
> optic chiasm,tumor of pituitary gland compresses optic nerve
> at chiasm produces visual defect called bitemporal hemianopia

> Overview  Comments

![Cranial Nerve Ii_ Optic Nerve - Clinical Figure 1](/lessons/images/cranial-nerves-in-depth/cranial-nerve-ii-optic-nerve/figure_01_p1.png)
*Cranial Nerve Ii_ Optic Nerve — Clinical Figure 1 (Page 1 Reference)*

Previous Next',
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

  -- Lesson: Cranial Nerve Iv_ Trochlear Nerve (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cranial-nerve-iv-trochlear-nerve',
    'Cranial Nerve Iv_ Trochlear Nerve',
    'article',
    '# Cranial Nerve Iv_ Trochlear Nerve

Trochlear Nerve:
smallest cranial nerve (by number of axons) yet has the longest
intracranial course. Emerges from posterior aspect of midbrain,
travels through lateral aspect of cavernous sinus, exits skull
through superior orbital fissure.
Previous Next

Overview  Comments

![Cranial Nerve Iv_ Trochlear Nerve - Clinical Figure 1](/lessons/images/cranial-nerves-in-depth/cranial-nerve-iv-trochlear-nerve/figure_01_p1.png)
*Cranial Nerve Iv_ Trochlear Nerve — Clinical Figure 1 (Page 1 Reference)*',
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

  -- Lesson: Cranial Nerve Ix_ Glassopharyngeal Nerve (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cranial-nerve-ix-glassopharyngeal-nerve',
    'Cranial Nerve Ix_ Glassopharyngeal Nerve',
    'article',
    '# Cranial Nerve Ix_ Glassopharyngeal Nerve

Glossopharyngeal Nerve (CN IX):
originates in the medulla oblongata of the brain, moves
laterally in the posterior cranial fossa, and leaves the skull
through jugular foramen.
Note: Facial nerve in parotid gland splits into five terminal
branches but parotid gland is innervated by
glossopharyngeal nerve
Previous Next

Overview  Comments

![Cranial Nerve Ix_ Glassopharyngeal Nerve - Clinical Figure 1](/lessons/images/cranial-nerves-in-depth/cranial-nerve-ix-glassopharyngeal-nerve/figure_01_p1.png)
*Cranial Nerve Ix_ Glassopharyngeal Nerve — Clinical Figure 1 (Page 1 Reference)*',
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

  -- Lesson: Cranial Nerve Viii_ Vestibulocochlear Nerve (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cranial-nerve-viii-vestibulocochlear-nerve',
    'Cranial Nerve Viii_ Vestibulocochlear Nerve',
    'article',
    '# Cranial Nerve Viii_ Vestibulocochlear Nerve

Vestibulocochlear Nerve (CN VIII):
Comprised of two vestibular and cochlear portions, emerges
from the brainstem at the cerebellopontine angle, enters
internal acoustic meatus of temporal bone.
Previous Next

Overview  Comments

![Cranial Nerve Viii_ Vestibulocochlear Nerve - Clinical Figure 1](/lessons/images/cranial-nerves-in-depth/cranial-nerve-viii-vestibulocochlear-nerve/figure_01_p1.png)
*Cranial Nerve Viii_ Vestibulocochlear Nerve — Clinical Figure 1 (Page 1 Reference)*',
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

  -- Lesson: Cranial Nerve Vii_ Facial Nerve (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cranial-nerve-vii-facial-nerve',
    'Cranial Nerve Vii_ Facial Nerve',
    'article',
    '# Cranial Nerve Vii_ Facial Nerve

Facial nerve:
The facial nerve exits the cranial cavity through the internal
acoustic meatus and enters the facial canal of the temporal
bone. The nerve then exits the skull through the Stylomastoid
foramen (lies between the styloid and mastoid processes of the
temporal bone) to enter the parotid gland, ultimately
branching into five terminal branches to supply the face.
Cause of injury: Bell''s palsy, Ramsay-Hunt syndrome, Guillain-
Barre syndrome, mumps, parotid tumor, and injury to the
middle ear.
Clinical effects of injury:  impaired sense of taste to anterior
two-thirds of tongue, loss of efferent corneal reflex, impaired
lacrimal fluid production, hyperacusis, and impaired salivation
Facial nerve branches in the temporal bone:
The nerve to the stapedius: Innervate stapedius muscle.
The greater petrosal nerve: parasympathetic innervation to
the lacrimal gland and the mucous glands of the oral cavity,
nose and pharynx
The chorda tympani: supply taste to the anterior two-thirds
of the tongue
Facial nerve branches between the stylomastoid foramen
and parotid gland:3 motor branches
Posterior auricular nerve innervates the intrinsic and
extrinsic muscles of the outer ear.
Nerve to the posterior belly of the digastric muscle:
Innervates the posterior belly of the digastric muscle one of
the suprahyoid muscles of neck responsible for raising the
hyoid bone.
Nerve to the stylohyoid muscle: Innervates the stylohyoid
muscle, one of the suprahyoid muscles of neck responsible
for raising the hyoid bone.

Overview  Comments

Note: Greater auricular nerve cutaneous branch of the cervical
plexus provides sensory innervation to ear lobule, skin over the
parotid gland and mastoid process of the temporal bone. Pain
of parotitis and during ear piercing is due to innervation of
greater auricular nerve.
Facial nerve terminal branches in parotid gland:
The cervical branch: innervating the platysma muscle.
The temporal branch: innervating muscles in the temple,
forehead muscles (frontalis) and supraorbital areas (upper
half of orbicularis oculi muscle)
The zygomatic branch: innervating muscles in the
infraorbital area (Lower half of orbicularis oculi muscle), the
lateral nasal area and the upper lip
The buccal branch: innervating muscles in the cheek and
upper lip
The marginal mandibular branch: innervating muscles of
the lower lip and chin

> [!TIP]
> **High yield:**
> The chorda tympani branch of the facial nerve supplies taste
> sensation to the anterior  of the tongue.

In the anterior , general sensation is supplied by the
trigeminal nerve (CNV). Specifically, the lingual nerve, a
branch of the mandibular nerve (CN V3).
The posterior  of the tongue both touch and taste are
carried by the glossopharyngeal nerve (CNIX)
Previous Next',
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

  -- Lesson: Cranial Nerve Vi_ Abducent Nerve (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cranial-nerve-vi-abducent-nerve',
    'Cranial Nerve Vi_ Abducent Nerve',
    'article',
    '# Cranial Nerve Vi_ Abducent Nerve

Abducent nerve:
Purely motor nerve supplying lateral rectus muscle, arises from
pons of the midbrain, travels through cavernous sinus, exits
skull through superior orbital fissure.
Previous Next

Overview  Comments

![Cranial Nerve Vi_ Abducent Nerve - Clinical Figure 1](/lessons/images/cranial-nerves-in-depth/cranial-nerve-vi-abducent-nerve/figure_01_p1.png)
*Cranial Nerve Vi_ Abducent Nerve — Clinical Figure 1 (Page 1 Reference)*',
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

  -- Lesson: Cranial Nerve V_ Trigeminal Nerve (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cranial-nerve-v-trigeminal-nerve',
    'Cranial Nerve V_ Trigeminal Nerve',
    'article',
    '# Cranial Nerve V_ Trigeminal Nerve

Trigeminal nerve:
Mixed motor and sensory nerve. It is also the largest cranial
nerve. Arises from several nuclei in the brainstem, exits
brainstem from pons It has three main divisions:

### 1: Opthalmic V1

### 2: Maxillary V2

### 3: Mandibular V3

Overview  Comments

Previous Next

![Cranial Nerve V_ Trigeminal Nerve - Clinical Figure 1](/lessons/images/cranial-nerves-in-depth/cranial-nerve-v-trigeminal-nerve/figure_01_p2.png)
*Cranial Nerve V_ Trigeminal Nerve — Clinical Figure 1 (Page 2 Reference)*',
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

  -- Lesson: Cranial Nerve Xii_ Hypoglossal Nerve (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cranial-nerve-xii-hypoglossal-nerve',
    'Cranial Nerve Xii_ Hypoglossal Nerve',
    'article',
    '# Cranial Nerve Xii_ Hypoglossal Nerve

Hypoglossal Nerve:
Pure motor nerve arises from medulla oblongata passes
laterally across the posterior cranial fossa, within the
subarachnoid space, exits the cranium via the hypoglossal
canal of the occipital bone.
Previous Next

Overview  Comments

![Cranial Nerve Xii_ Hypoglossal Nerve - Clinical Figure 1](/lessons/images/cranial-nerves-in-depth/cranial-nerve-xii-hypoglossal-nerve/figure_01_p1.png)
*Cranial Nerve Xii_ Hypoglossal Nerve — Clinical Figure 1 (Page 1 Reference)*',
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

  -- Lesson: Cranial Nerve Xi_ Spinal Accessory Nerve (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cranial-nerve-xi-spinal-accessory-nerve',
    'Cranial Nerve Xi_ Spinal Accessory Nerve',
    'article',
    '# Cranial Nerve Xi_ Spinal Accessory Nerve

Spinal Accessory Nerve (CN XI):
Arises from cervical segments C1 - C5/C6, enters cranial cavity
through foramen magnum, travels through posterior cranial
fossa and exits skull through jugular foramen.
Outside the cranium, it descends along the internal carotid
artery and innervate sternocleidomastoid muscle.
Previous Next

Overview  Comments

![Cranial Nerve Xi_ Spinal Accessory Nerve - Clinical Figure 1](/lessons/images/cranial-nerves-in-depth/cranial-nerve-xi-spinal-accessory-nerve/figure_01_p1.png)
*Cranial Nerve Xi_ Spinal Accessory Nerve — Clinical Figure 1 (Page 1 Reference)*',
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

  -- Lesson: Cranial Nerve X_ Vagus Nerve (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cranial-nerve-x-vagus-nerve',
    'Cranial Nerve X_ Vagus Nerve',
    'article',
    '# Cranial Nerve X_ Vagus Nerve

Vagus nerve
originates in the medulla oblongata of the brain and leaves
skull through jugular foramen together with CN IX and CN XI
respectively.

> [!TIP]
> **High yield:**
> Branches of vagus nerve:
> Superior laryngeal nerve: innervate cricothyroid muscle and
> gives sensory innervation to laryngopharynx and superior part
> of the larynx
> Right Recurrent laryngeal nerve: Hooks underneath right
> subclavian artery and ascends towards larynx and innervate
> muscles of larynx
> Left Recurrent laryngeal nerve: Hooks underneath the arch of
> aorta, and ascends towards larynx and innervate muscles of
> larynx

> [!TIP]
> **Clinical pearls:**
> Vasovagal syncope:  Causes heart rate and blood pressure to
> drop suddenly during a period of emotional stress caused by
> initial increase in sympathetic outflow followed by a rebound
> reduction in sympathetic activity leaving unopposed

> Overview  Comments

![Cranial Nerve X_ Vagus Nerve - Clinical Figure 1](/lessons/images/cranial-nerves-in-depth/cranial-nerve-x-vagus-nerve/figure_01_p1.png)
*Cranial Nerve X_ Vagus Nerve — Clinical Figure 1 (Page 1 Reference)*

parasympathetic activity causing vasodilatation, bradycardia,
and hypotension
Orthostatic syncope: Defined as an orthostatic drop of >20
mm systolic blood pressure or >10 mm diastolic blood pressure.
This may be due to absolute volume depletion from
dehydration or haemorrhage or to venodilatation caused by
medications or autonomic insufficiency (eg as occurs in
Parkinsons disease).
Causes of syncope:
Previous Next

![Cranial Nerve X_ Vagus Nerve - Clinical Figure 2](/lessons/images/cranial-nerves-in-depth/cranial-nerve-x-vagus-nerve/figure_02_p2.png)
*Cranial Nerve X_ Vagus Nerve — Clinical Figure 2 (Page 2 Reference)*',
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

  RAISE NOTICE 'Successfully seeded MRCEM Primary: Clinical Anatomy Masterclass (65 lessons, 130 images)';
END $$;
