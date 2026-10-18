-- ==========================================================================
-- COURSE SEED: MRCEM Primary: Complete Flagship Masterclass
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

  -- 2. Upsert Course: mrcem-primary
  SELECT id INTO v_course_id FROM "courses" WHERE "slug" = 'mrcem-primary' LIMIT 1;
  IF v_course_id IS NULL THEN
    INSERT INTO "courses" (
      "id", "exam_id", "slug", "title", "summary", "description", "is_free", "position", "status", "created_at", "updated_at"
    ) VALUES (
      gen_random_uuid(),
      v_exam_id,
      'mrcem-primary',
      'MRCEM Primary: Complete Flagship Masterclass',
      'Comprehensive basic sciences curriculum covering clinical anatomy, applied physiology, emergency pharmacology, pathology, and microbiology.',
      'The complete flagship preparation course for the Royal College of Emergency Medicine (RCEM) Primary examination. Includes all 21 core curriculum modules, 221 detailed lecture notes, 269 embedded anatomical and clinical figures, and interactive topic knowledge checks.',
      false,
      1,
      'published',
      now(),
      now()
    ) RETURNING "id" INTO v_course_id;
  ELSE
    UPDATE "courses" SET
      "title" = 'MRCEM Primary: Complete Flagship Masterclass',
      "exam_id" = COALESCE(v_exam_id, "exam_id"),
      "summary" = 'Comprehensive basic sciences curriculum covering clinical anatomy, applied physiology, emergency pharmacology, pathology, and microbiology.',
      "description" = 'The complete flagship preparation course for the Royal College of Emergency Medicine (RCEM) Primary examination. Includes all 21 core curriculum modules, 221 detailed lecture notes, 269 embedded anatomical and clinical figures, and interactive topic knowledge checks.',
      "position" = 1,
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
    'Axillary Artery:
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

#### Branches of Brachial artery

### 1: Muscular branches

### 2: Nutrient artery: to the humerus

### 3: Profunda brachii artery: Immediately distal to the teres

major, the brachial artery gives rise to the profunda brachii
(deep artery), which travels with the radial nerve in the radial
groove of the humerus and supplies structures in the
posterior aspect of the upper arm (e.g., triceps brachii).

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
Guyon''s or Ulnar canal: The ulnar (Guyon''s) canal is a fibro-
osseous tunnel located at the level of the palm. The ulnar canal conveys the ulnar neurovascular bundle into the hand.
Contents: Ulnar nerve, ulnar artery and Venae comitantes of
ulnar artery
Ulnar canal syndrome refers to compression of the ulnar nerve
within the ulnar canal. The most common causes are ganglion
cyst, lipoma and trauma.

#### Superficial and Deep palmar arches

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
Blood supply: Blood supply to digits and wrist joint.',
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
    'Brachial Plexus:
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

#### BRANCHES OF LATERAL CORD   "LML"

#### Lateral pectoral nerve

Musculocutaneous nerve

#### Lateral root of median nerve

#### BRANCHES OF MEDIAL CORD     "M4U"

#### Medial pectoral nerve

#### Medial cutaneous nerve of arm

#### Medial cutaneous nerve of forearm

#### Medial root of median nerve

Ulnar nerve

#### BRANCHES OF POSTERIOR CORD   "ULTRA"

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
Anterior terminal branch:  winds around the surgical neck of
the humerus and provides motor innervation to the anterior
aspect of the deltoid muscle.
Posterior terminal branch:  Gives motor innervation to the
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

#### Branches of Median Nerve in the Forearm

![Innervation of Upper Limb - Clinical Figure 2](/lessons/images/upper-limb-anatomy/innervation-of-upper-limb/figure_02_p3.png)
*Innervation of Upper Limb — Clinical Figure 2 (Page 3 Reference)*

#### Branches of Median Nerve in the Hand

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
usually spared  as the palmar cutaneous branch does not travel
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
    'Acromioclavicular Joint:
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

Acromioclavicular joint dislocation
A severe blow on the point of the shoulder, as is incurred
during blocking or tackling in football or any severe fall,
can result in the acromion being thrust beneath the lateral
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
medial epicondyle and attaches to the coronoid process and
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
ulnar nerve involvement The ulnar collateral ligament is
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
Palmar radiocarpal:  Found on anterior side of the hand. It
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
Coraco-clavicular ligament:  This ligament composed of the
trapezoid and conoid ligaments and runs from the clavicle to
the coracoid process of the scapula. They work alongside the
acromioclavicular ligament to maintain the alignment of the
clavicle in relation to the scapula.
Coracoacromial ligament. This ligament runs between the
acromion and coracoid process of the scapula it forms the
coraco-acromial arch.  This structure overlies the shoulder
joint, preventing superior displacement of the humeral
head.
Stability of the shoulder joint:
Rotator cuff muscles [SITS MUSCLES]

Glenoid labrum: A fibrocartilaginous ridge surrounding the
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
posterior shoulder dislocation',
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
    'Lymphatic drainage of the Upper
Limb:
The superficial lymph vessels ascend the limb in the superficial
fascia and accompany the superficial veins. The deep lymph
vessels lie deep to the deep fascia and follow the deep arteries
and veins. All lymph vessels of the limb ultimately drain into
lymph nodes in axilla.

### 1: Axillary lymph nodes: The axillary lymph nodes drain lymph

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

parasternal nodes (20%): Receives lymphatic drainage from
medial quadrant.
Note: Breast cancer in axillary tail of breast most commonly
involved lymph node is axillary

> [!TIP]
> **Clinical Pearl:**
> Removal and analysis of the axillary lymph nodes is often a vital
> tool for the staging of breast cancers. During this procedure
> there is also a risk of damage to either of the long thoracic
> nerve or the thoracodorsal nerve causing winged scapula.',
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
    'Forearm muscles

#### Anterior forearm muscles superficial

compartment

#### Anterior Forearm muscles intermediate

compartment:

#### Anterior Forearm muscles deep compartment

> [!TIP]
> **Key Point: All the muscles of anterior forearm are innervated**
> by median nerve except flexor carpi ulnaris and medial half of

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
Function:  Extension of forearm at elbow and extension of arm
at shoulder joint.
Innervation: Radial nerve
Muscles of posterior forearm

![Muscles of the Upper Limb - Clinical Figure 4](/lessons/images/upper-limb-anatomy/muscles-of-the-upper-limb/figure_04_p2.png)
*Muscles of the Upper Limb — Clinical Figure 4 (Page 2 Reference)*

![Muscles of the Upper Limb - Clinical Figure 5](/lessons/images/upper-limb-anatomy/muscles-of-the-upper-limb/figure_05_p2.png)
*Muscles of the Upper Limb — Clinical Figure 5 (Page 2 Reference)*

The muscles in the posterior compartment of the forearm are
commonly known as the extensor muscles.
Extensor muscles are divided into superficial and deep
compartment.

#### Superficial compartment

#### Deep Compartment

> [!TIP]
> **Clinical pearl:**

### 1: Tennis elbow (lateral epicondylitis): is caused by a chronic

inflammation or irritation of the origin of the extensor muscles
of the forearm from the lateral epicondyle of the humerus as a
result of repetitive strain. It is a painful condition and common
in tennis players.

### 2: Golfer''s elbow (medial epicondylitis):  is a painful condition

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
Extrinsic muscles, Intrinsic Muscles
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
> and paralysis of trapezius muscle.

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
cuff muscle.
Muscles of pectoral region:

![Muscles of the Upper Limb - Clinical Figure 13](/lessons/images/upper-limb-anatomy/muscles-of-the-upper-limb/figure_13_p7.png)
*Muscles of the Upper Limb — Clinical Figure 13 (Page 7 Reference)*

![Muscles of the Upper Limb - Clinical Figure 14](/lessons/images/upper-limb-anatomy/muscles-of-the-upper-limb/figure_14_p7.png)
*Muscles of the Upper Limb — Clinical Figure 14 (Page 7 Reference)*

Pectoralis Major: large fan shaped and most superficial muscle
of the pectoral region.
Origin:
Clavicular head: Medial clavicle
Sternocostal head originates from the anterior surface of the
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
    'Dermatomes of Upper Limb:
Dermatome: A dermatome is defined as ''a strip of skin that is
innervated by a single spinal nerve and clinically very
important and help in diagnosis of spinal cord injury
Myotomes and associated
movements:
Myotome: Group of muscles innervated by a single spinal
nerve
Reflexes of upper Limb:

![Upper Limb Dermatomes, Myotomes and Reflexes - Clinical Figure 1](/lessons/images/upper-limb-anatomy/upper-limb-dermatomes-myotomes-and-reflexes/figure_01_p1.png)
*Upper Limb Dermatomes, Myotomes and Reflexes — Clinical Figure 1 (Page 1 Reference)*

![Upper Limb Dermatomes, Myotomes and Reflexes - Clinical Figure 2](/lessons/images/upper-limb-anatomy/upper-limb-dermatomes-myotomes-and-reflexes/figure_02_p1.png)
*Upper Limb Dermatomes, Myotomes and Reflexes — Clinical Figure 2 (Page 1 Reference)*

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
    'Carpal Tunnel:
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
Anatomical snuffbox
is a triangular depression found on the lateral aspect of the
dorsum of the hand. It is best seen when the thumb is
extended.

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

### 3: Tenosynovitis:  is commonly caused by an infection of the

synovial sheath and tendon (the long flexor tendon), causing
pain, swelling, and difficulty moving a joint. Rupture of the
tendon sheath (puncture injury of the palm) may cause the
spread of infection to the mid-palmar space and to the carpal tunnel. Likewise, tenosynovitis in the thumb may spread to the
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

### 6:  Boutonniere deformity is a finger with abnormal flexion of

the middle phalanx and hyperextension of the distal phalanx as
a result of a rupture of the central band of the extensor tendon

### 7:  Pancoast tumor in the apex of the lung can result in lower

trunk injury and, occasionally, Horner syndrome because of
sympathetic ganglion compression (ptosis, anhidrosis, and
pupillary constriction). It can also cause thoracic outlet
syndrome.',
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
    'Venous Drainage of the Upper Limb
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
inferior margin of the first rib.',
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
    '### 1: Femoral Artery:

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

#### Branches of femoral artery

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
from the opening in the adductor magnus to the lower border of popliteus muscle, where it divides into anterior and posterior
tibial arteries.

#### Anterior Tibial Artery

The anterior tibial artery arises at the bifurcation of the
popliteal artery in the popliteal fossa. It passes forward
between the tibia and the fibula through the upper part of
the interosseus membrane and enters the anterior
compartment of the leg. It then descends with the deep
peroneal nerve to the front of the ankle joint, where it
becomes the dorsalis pedis artery

#### Posterior Tibial Artery

The posterior tibial artery arises at the bifurcation of the
popliteal artery in the popliteal fossa. It descends in the
posterior compartment of the leg and is accompanied by the
tibial nerve. The artery terminates behind the medial malleolus
by dividing into the medial and the lateral plantar arteries.

#### Medial Plantar Artery

The medial plantar artery is the smaller of the terminal
branches of the posterior tibial artery. It runs forward along the
medial border of the foot with the medial plantar nerve, and it
gives off many muscular and cutaneous branches.

#### Lateral Plantar Artery

The lateral plantar artery is the larger of the terminal
branches of the posterior tibial artery. It runs forward deep
to the abductor hallucis and the flexor digitorum brevis
muscles with the lateral plantar nerve, and it ends by curving
medially to form the plantar arch through anastomosis with
the dorsalis pedis artery. The plantar arch gives off
perforating and metatarsal arteries; the metatarsal arteries
give rise to digital arteries.

> [!TIP]
> **Clinical high yield:**
> Medical personal should know the precise position of the main
> arteries within the lower limb.

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
between the medial malleolus and the heel.',
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
    'Hip Bone:
The bones of the pelvis consist of the right and left hip bones,
the sacrum and the coccyx.
The hip bones articulate posteriorly with the sacrum at the
sacroiliac joints and with each other anteriorly at the pubic
symphysis.
Hip bone has a large articular socket on the lateral surface,
the acetabulum, which together with the head of the femur,
forms the hip joint.
Each of the hip bones is formed by
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
    'Dermatomes and Myotomes of Lower
Limb:
Lower Limb Reflexes:

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
    'Joints of the lower limb:

### 1: Ligaments of the hip joint:

Intracapsular
The only intracapsular ligament is the ligament of head of
femur (Ligamentum teres). It is a relatively small structure,
which runs from the acetabular fossa to the fovea of the femur.
Extracapsular ligaments:
Iliofemoral ligament: Strongest of all located anteriorly,
prevents hyperextension of the hip joint.
Ischiofemoral:  Reinforcing the capsule posteriorly. Preventing
hyperextension and medial rotation of the femur at hip joint

![Joints of the Lower Limb - Clinical Figure 1](/lessons/images/lower-limb-anatomy/joints-of-the-lower-limb/figure_01_p1.png)
*Joints of the Lower Limb — Clinical Figure 1 (Page 1 Reference)*

Pubofemoral:  Reinforcing the capsule anteriorly and inferiorly
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
in the intercondylar fossa. It prevents anterior dislocation of the tibia onto the femur. ACL relax during flexion and taut
during extension torn in hyperextension injury.
Posterior cruciate ligament: Attaches at the posterior
intercondylar region of the tibia and ascends anteriorly to
attach to the anteromedial femoral condyle. It prevents
posterior dislocation of the tibia onto the femur. PCL relax
during extension and taut during flexion, torn in hyperflexion
injury
Note:
Unhappy triad:  common in Rugby players. lateral blow to the
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
*Joints of the Lower Limb — Clinical Figure 4 (Page 5 Reference)*',
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
    'Femoral Triangle:
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
    'Inguinal lymph Nodes:
The inguinal lymph nodes are found in the upper aspect of the
femoral triangle.

#### Superficial Inguinal Nodes

The superficial inguinal lymph nodes are located in the
superficial fascia, forming a line below the inguinal ligament,
and medially extending inferiorly along the terminal part of the
great saphenous vein. They receive lymph from the gluteal
region, lower abdominal wall, perineum, and superficial regions
of the lower limb.
Superficial inguinal lymph nodes drain into deep inguinal
nodes.

#### Deep Inguinal Nodes

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
> prostate= internal iliac nodes',
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
    'Muscles of Gluteal Region:
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

![Muscles of the Lower Limb - Clinical Figure 1](/lessons/images/lower-limb-anatomy/muscles-of-the-lower-limb/figure_01_p1.png)
*Muscles of the Lower Limb — Clinical Figure 1 (Page 1 Reference)*

![Muscles of the Lower Limb - Clinical Figure 2](/lessons/images/lower-limb-anatomy/muscles-of-the-lower-limb/figure_02_p1.png)
*Muscles of the Lower Limb — Clinical Figure 2 (Page 1 Reference)*

Trendelenburg Sign: Trendelenburg gait or waddling gait
occurs when your hip abductor muscles are weakened. This
muscle group includes the gluteus Medius and minimus
innervated by superior gluteal nerve. The weakness of these
muscles causes drooping of the pelvis to the contralateral
side while walking.
The Trendelenburg sign is produced when the patient is asked
to stand without support on each leg. In a positive sign, pelvic
drop will occur on the unsupported leg. For example, if the
right gluteal muscles are weak, the left side of the pelvis will
drop.

#### Anterior compartment of thigh

muscles:
Note: All the muscles of anterior compartment of thigh are
flexors of thigh at hip joint, while quadriceps femoris is
extensor of thigh at knee joint and Sartorius also flexes thigh at
knee.
Note:    Sartorius originates from anterior superior iliac spine
Rectus femoris originates from anterior inferior iliac spine.

#### Medial Compartment of thigh

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

#### Anterior leg consists of four muscles

> [!TIP]
> **Clinical pearls: Foot Drop (Discussed in nerves of the lower**
> limb)
> Muscles in the Posterior compartment of leg: Consists of
> seven muscles divided into superficial and deep groups. All are
> innervated by tibial nerve
> Superficial group: Mnemonic (GPS)

![Muscles of the Lower Limb - Clinical Figure 6](/lessons/images/lower-limb-anatomy/muscles-of-the-lower-limb/figure_06_p4.png)
*Muscles of the Lower Limb — Clinical Figure 6 (Page 4 Reference)*

#### Deep muscles in the posterior leg

> [!TIP]
> **Clinical pearls:**
> Ruptured calcaneal tendon: Tear of calcaneal tendon occurs
> during forceful plantarflexion of the foot. Patients will be
> unable to plantarflex the foot and affected foot will be
> permanently dorsiflexed.

Muscles in the lateral compartment
of leg:
Consists of two muscles, fibularis longus and brevis also
called peroneus longus and peroneus brevis.

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
    'Femoral nerve
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

#### Anterior cutaneous branches

Branch to sartorius
Branch to pectineus

### 2: Posterior division of the femoral nerve

Saphenous nerve
Branches to quadriceps femoris

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
peroneal nerve or also due to deep fibular nerve injury.',
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
    '#### Superficial Veins of the Lower Limb

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
> veins causing them to become dilated and tortuous.',
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
    'Ribs:
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
superior to it. Intercostal nerves, arteries and veins lie in the costal groove along the inferior margin of the rib, lying in a
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
injury to the intercostal neurovascular bundle.',
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
    'Dermatomal supply of trunk:

> [!TIP]
> **High yield:**

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
    'Muscles of the thoracic cage:
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

![Muscles of Thorax - Clinical Figure 1](/lessons/images/thorax-anatomy-mediastinum/muscles-of-thorax/figure_01_p1.png)
*Muscles of Thorax — Clinical Figure 1 (Page 1 Reference)*

Xiphoid process of sternum
Costal cartilages ribs 7 - 10, ends of ribs 11 and 12
Arcuate ligaments and lumbar vertebrae

### 2: Central attachment: Muscles fibers of the diaphragm forms

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
> abdominus',
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
    'Mediastinum:
The mediastinum is an interpleural space and consists of the
superior mediastinum and inferior mediastinum. The inferior
mediastinum further divides into the anterior, middle, and
posterior mediastina.
The middle mediastinum contains the heart.
The posterior mediastinum contains the esophagus, thoracic
aorta, azygos and hemiazygos veins, thoracic duct, vagus
nerves, and sympathetic splanchnic nerves',
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
    'Tracheobronchial Tree
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
sacs, the walls of which form alveoli.',
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
    'Heart and pericardium
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

The parietal and fibrous pericardium are innervated mainly by
the phrenic nerve, for this reason that pain related to a
pericardial problem may be referred to the supraclavicular
region of the shoulder or the lateral neck area.

> [!TIP]
> **Clinical pearls:**
> Pericardiocentesis:  surgical puncture of the pericardial cavity
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
by the sinoatrial node are propagated by the atrial myocardium to the atrioventricular node, Here the impulse is
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

#### Superior vena cava

#### Inferior vena cava

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
    '## Lung:

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
anterior and posterior pulmonary plexus (networks of nerves derived from the sympathetic trunk and vagus nerve).
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
brachial plexopathy and a lesion of cervical sympathetic chain ganglion and Horner syndrome (ptosis, enophthalmos,
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
superior margin of a rib to avoid injury to the intercostal neurovascular bundle, which travels in a notch below each rib',
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
    'Oesophagus:
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

![Structures of the Thorax - Oesophagus - Clinical Figure 1](/lessons/images/thorax-anatomy-mediastinum/structures-of-the-thorax-oesophagus/figure_01_p1.png)
*Structures of the Thorax - Oesophagus — Clinical Figure 1 (Page 1 Reference)*

Innervation of the oesophagus:
sympathetic trunk (sympathetic fibres)
vagal plexus (parasympathetic fibres)',
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
    'The thymus
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

The thymus gland is innervated by sympathetic nerves
arising from the cervical sympathetic ganglia. These
sympathetic nerves regulate blood flow to the thymus and
play a role in its function. In addition, parasympathetic
fibers from the vagus nerve may also contribute to the
innervation of the thymus gland nevertheless an autonomic
nervous system of both sympathetic and parasympathetic
components plays a role in regulating function of thymus
gland.',
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
    'Thoracic wall movements:
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
    'Transverse thoracic plane
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
> Compression of subclavian vein',
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
    'Layers of the Abdominal Wall
(external to internal)
Skin
Superficial fascia (Camper''s fascia: Superficial fatty
layer Scarpa''s fascia: deep fibrous layer )
Muscles
Transversalis fascia
Parietal peritoneum

#### Anterior abdominal wall muscles

The muscles of the anterolateral abdominal wall can be
divided into two main groups that lie deep in the superficial
fascia.
Three flat muscles: (External oblique, internal oblique and
transversus abdominus), located laterally, each flat muscle
forms an aponeurosis (a broad, flat tendon) in the
anteromedial aspect of the abdominal wall which covers the
vertical rectus abdominis muscle. The aponeuroses of all the
flat muscles become entwined in the midline, forming
the Linea alba.
Two vertical muscles: Rectus abdominus and pyramidalis
situated near midline of body
Innervation: The anterior abdominal wall muscles are
innervated by the anterior rami of T7-T12 and L1.

Other contents
Rectus sheath: The rectus sheath is formed by the
aponeuroses of the three flat muscles and encloses the
rectus abdominis and pyramidalis muscles. It has an anterior
and posterior wall for most of its length.
Anterior wall: Formed by the aponeuroses of the external
oblique, and of half of the internal oblique.
Posterior wall:  Half of the aponeuroses of the internal
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

#### Posterior abdominal wall muscle

Important posterior abdominal wall muscles are the psoas
major, minor, the iliacus and the quadratus lumborum which
each possess a strong fascial covering.
Iliacus and Psoas major origin and insertion
Iliacus: Originates from surface of the iliac fossa and anterior
inferior iliac spine. Its fibres combine with the tendon of the
psoas major, inserting into the lesser trochanter of
the femur.
Psoas major: Originates from the transverse processes and
vertebral bodies of T12 - L5. It then moves inferiorly and
laterally, running deep to the inguinal ligament, and
inserting to the lesser trochanter of the femur.

> [!TIP]
> **Clinical pearls**
> Psoas sign: Irritation of iliopsoas muscle, psoas sign positive
> when thigh is flexed pain is felt in lower abdominal wall,
> indication of appendicitis.

![Abdominal Wall Muscles - Clinical Figure 2](/lessons/images/abdomen-peritoneum/abdominal-wall-muscles/figure_01_p3.png)
*Abdominal Wall Muscles — Clinical Figure 2 (Page 3 Reference)*

![Abdominal Wall Muscles - Clinical Figure 3](/lessons/images/abdomen-peritoneum/abdominal-wall-muscles/figure_02_p3.png)
*Abdominal Wall Muscles — Clinical Figure 3 (Page 3 Reference)*',
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
    'The Liver:
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
water retention.
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
Gall bladder blood supply: cystic artery branch of right hepatic
artery. Right hepatic artery is itself branch of common hepatic
artery one of branch of coeliac trunk.
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
Ducts of pancreas:  Main pancreatic duct: Begins in the tail
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
the  splenogastric and splenorenal ligaments
Relations:The spleen lies posterior to the stomach, superior to
the left colic flexure and lateral to the left kidney and tail of the
pancreas.
Functional overview: Composed of white pulp and red pulp.
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
stages of life.

> [!TIP]
> **Clinical pearls: Spleen injury most Likely associated with**
> fracture of rib 10

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
*Accessory Organs of the Abdomen — Clinical Figure 8 (Page 9 Reference)*',
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
    'Areas of the abdomen
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
Clinical significance:  Direct inguinal hernia protrudes
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
    'Dermatomal supply of trunk

> [!TIP]
> **High yield:**

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
    'Stomach:
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
part of the duodenum. It controls of the exit of chyme.
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
pylorus and has at its summit the opening of the accessory pancreatic duct.
Third part: The inferior or horizontal part of the duodenum
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
Proximal to the major duodenal papilla: supplied by the
gastroduodenal artery (branch of the common hepatic artery
from the coeliac trunk).
Distal to the major duodenal papilla: supplied by the inferior
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
> Meckel''s Diverticulum:
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
and on to the cisterna chyli, where it ultimately empties into
the thoracic duct.
Innervation:
Ascending colon and proximal  of the transverse colon:
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
Superior rectal artery: terminal continuation of the inferior
mesenteric artery.
Middle rectal artery: branch of the internal iliac artery.
Inferior rectal artery: branch of the internal pudendal artery.
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
> anatomical structures, and these structures can therefore be
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
    'Lumbar spine:
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

![Lumbar Spine and Plexus - Clinical Figure 1](/lessons/images/abdomen-peritoneum/lumbar-spine-and-plexus/figure_01_p1.png)
*Lumbar Spine and Plexus — Clinical Figure 1 (Page 1 Reference)*

Note:Sub-costal nerve: (T12)Largest thoracic spinal nerve
originates from anterior ramus of spinal nerve T12, Innervates
external oblique, internal oblique, transversus abdominus,
rectus abdominus and pyramidalis muscle

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
    'Male Genital organs:
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
produce spermatozoa and interstitial cells (of Leydig)
secrete testosterone
Innervation of testis and epididymis: testicular plexus - a
network of nerves derived from the renal and aortic plexus
Lymphatic drainage:(Important to remember)
Testes lumbar (para-aortic) nodes in the abdomen
scrotum drains to the superficial inguinal nodes.
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
> corpora cavernosa.  Its head is called the glans penis which is
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
penis and Bulbourethral artery branches of the internal
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

#### Anterior to the rectum

superior to the external urethral sphincter
Functional anatomy: Secretes a fluid that produces the
characteristic odor of semen. This fluid, the secretion from the
seminal vesicles and the bulbourethral glands, and the
spermatozoa constitute the semen or seminal fluid.
Prostate has four zones:
Anterior zone: which lies in front of the urethra.
Transitional zone: encompasses the urethra proximal to the
ejaculatory ducts and is prone to benign hypertrophy
obstructing the internal urethral orifice
Central zone: encompasses the ejaculatory ducts up to the
urethra.
Peripheral zone: situated posteroinferior and lateral to the
transitional and central zones, forming the main mass of the
gland and is thus the most prone to carcinomatous
transformation.

> [!TIP]
> **Clinical pearls: Hypertrophy of the prostate is a benign**
> enlargement of the prostate that affects older men and occurs most often in the transitional zone, obstructing the internal
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
Innervation: Autonomic: via the ovarian plexus
Visceral afferents: accompany the sympathetic fibers to T10 -
T12 level of the spinal cord sensory ganglia
Pain is thus referred to the periumbilical region, suprapubic
region and groin.
Uterine tube:
The uterine tube extends from the uterus to the ovary and
consists of the isthmus, ampulla, and infundibulum. The
fimbriated distal end creates currents, drawing an ovulated
oocyte into the uterine tube.
Note: Ectopic pregnancy most commonly occurs in the
ampulla (70% of cases).
Uterus:

![Male and Female Reproductive System - Clinical Figure 2](/lessons/images/abdomen-peritoneum/male-and-female-reproductive-system/figure_02_p5.png)
*Male and Female Reproductive System — Clinical Figure 2 (Page 5 Reference)*

Contains a fundus, body, isthmus and cervix and is supported
by ligaments.
Relations:
Anteriorly: vesicouterine pouch and the urinary bladder
Posteriorly: the rectouterine pouch and the anterior surface
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
Uterine veins: they are formed from the plexus and drain into
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
portion: branch of the internal iliac artery
Vaginal artery and internal pudendal arteries supply the middle
and inferior parts: branches of the internal iliac artery.

Venous drainage: Uterovaginal plexus: drains into internal iliac
veins
Innervation
Autonomic: inferior hypogastric plexus, pelvic splanchnic,
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
> lateral fornices',
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
    'Pelvic diaphragm and supporting
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

Ovarian ligament: Is a fibromuscular cord that extends from
the ovary to the uterus below the uterine tube, running within
the layers of the broad ligament.
Suspensory ligament of the ovary Is a band of peritoneum
that extends upward from the ovary over the posterior pelvic
brim and transmits the ovarian vessels, nerves, and lymphatics.
Rectouterine pouch and Rectovesical pouch:
Rectouterine pouch: Is a sac or recess formed by a fold of the
peritoneum dipping down between the rectum and the
uterus. Lies behind the posterior fornix of the vagina and
contains peritoneal fluid and some of the small intestine.
Rectovesical pouch: Is a peritoneal recess between the bladder
and the rectum in males, and the vesicouterine pouch is a
peritoneal sac between the bladder and the uterus in females',
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
    'Kidney
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
cord at T11-L2, with ureteric pain referred to those dermatomal
areas.

> [!TIP]
> **Clinical pearls:**
> In females ureters are in close proximity to the ovaries. Care
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
Male urethra: Male urethra is approximately 20 cm long and
consists of: prostatic, membranous, bulbous and spongy
urethra.

#### Anterior urethra

Penile (spongy) urethra (16 cm long): encased by corpus
spongiosum of the penis (the longest portion).
Bulbar (bulbous) urethra traverses the root of the penis, it
receives the ducts from the bulbourethral glands and the
glands of Littre
.

#### Posterior urethra

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
situated between the labia minora, anterior to the vaginal opening, and posterior to the glans clitoris.
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
distended until overflow incontinence occurs.',
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
    '#### Posterior triangle

Borders:
Posterior border of the sternocleidomastoid muscle

#### Anterior border of the trapezius muscle

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

#### Anterior triangle

Borders:

#### Anterior border of the sternocleidomastoid

#### Anterior midline of the neck

Inferior border of the mandible.
Roof:
Platysma and the investing layer of the deep cervical fascia.
Anterior triangle is further divided by the omohyoid anterior
belly and the anterior and posterior bellies of digastric into 4
Triangles:
Digastric (submandibular): submandibular gland.

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
    'Platysma
Superficial muscle of the neck, covers most of the anterior and
lateral aspect of the neck
Sternocleidomastoid muscle
One of the largest superficial muscles of the neck. Divides the
neck into anterior and posterior triangle
Suprahyoid and infrahyoid
muscles
Suprahyoid muscles

![Muscles of the Neck - Clinical Figure 1](/lessons/images/head-neck-anatomy/muscles-of-the-neck/figure_01_p1.png)
*Muscles of the Neck — Clinical Figure 1 (Page 1 Reference)*

![Muscles of the Neck - Clinical Figure 2](/lessons/images/head-neck-anatomy/muscles-of-the-neck/figure_02_p1.png)
*Muscles of the Neck — Clinical Figure 2 (Page 1 Reference)*

Infrahyoid muscles
Musculature of tongue

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
    'Structure of the Eyeball
The eyeball consists of 3 coats:

### 1. External protective fibrous coat: Made up of anterior

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
> **Clinical pearls: Dysfunction in these glands, often due to**
> blockages or inflammation, can lead to reduced tear stability
> and dry eye.',
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
    'Thyroid Gland
The thyroid gland is an endocrine organ which regulates basal
metabolic rate & stimulates growth
Parts
2 lobes: Right & Left lobes
Isthmus: which connects the lobes
Position: The gland lies at the level of C5, C6, C7
each lobe extends from middle of thyroid cartilage to 4th or
5th tracheal ring.
isthmus extends from 2nd to 3rd tracheal ring.

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

#### Inferior thyroid vein

#### Anterior jugular vein

Parathyroid gland
Oesophagus',
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
    'Visual pathway
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
    'Brainstem:
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

Vasculature of the mid brain:
The midbrain receives vascular supply from the basilar artery,
and its branches. The major vessels are:
Posterior cerebral artery and its peduncular branch

#### Superior cerebellar artery

#### Posterior choroidal artery

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
tumors noted',
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
    'Basal Ganglia:
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
pallidus; externus, and internus.
Substantia Nigra: located in the midbrain but considered
functionally as a part of the basal ganglia

> [!TIP]
> **Clinical pearls:**
> Basal ganglia are particularly associated with movement
> disorders.  tremors; involuntary muscle movements;
> abnormal increase in tone, difficulty initiating movements,
> and abnormal posture
> Parkinson''s is the most important and notorious disease of
> the basal ganglia. Classic clinical symptoms include
> bradykinesia, resting tremor, postural instability, and
> shuffling gait',
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
    'Central Nervous system overview
The central nervous system consists of the brain and the spinal
cord. The peripheral nervous system consists of the extensions
of neural structures beyond the central nervous system and
includes somatic and autonomic divisions.
The brain is composed of 3 main structural divisions:
The cerebrum (Cerebral hemispheres and diencephalon)
The brainstem
The cerebellum
NOTE:  At the base of the brain is the brainstem, which extends
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
cord including the posterior horns and columns.',
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
    'Cerebellum:
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
> possible. These can be remembered using the acronym

## ''Danish''

Dysdiadochokinesia (difficulty in carrying out rapid,
alternating movements)
Ataxia
Nystagmus (coarse)
Intention tremor
Scanning speech
Hypotonia
Cerebellar vascular lesion:

Note: Dysphagia is the differentiating symptom between AICA
and PICA. Way to remember PICA can''t chew.

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
    'Cerebrum:
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
Internal structure: The cerebrum is comprised of two different
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
    'Medulla:
The most inferior of the three and is continuous above with the
pons and below with the spinal cord

> [!TIP]
> **Clinical pearls:**

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
    'Spinal cord syndrome:

> [!TIP]
> **High yield:**

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
    'Tracts of Spinal Cord:
The spinal cord consists of various groups of nerve fibers
carrying sensory information toward the brain and receiving
motor information from the brain.
Ascending and descending tracts of the spinal cord are
responsible for carrying motor and sensory stimuli to and
from the periphery to higher levels
Ascending tracts of the spinal cord:
Descending Tracts of the Spinal Cord:

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
    'Thalamus:
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
Role in emotions & recent memory',
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
    'The Ventricles:
The ventricles are a set of communicating cavities within the
brain that are responsible for the production, transport and
removal of cerebrospinal fluid (CSF), which bathes the central
nervous system. There are four ventricles; right and left lateral
ventricles, the third ventricle and the fourth ventricle.
Lateral Ventricles:The lateral ventricles are C-shaped cavities
located within their respective hemispheres of the
cerebrum.  The lateral ventricles are connected to the third
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

CSF Reabsorption:
From the subarachnoid cisterns, CSF is reabsorbed by
arachnoid granulations, which protrude into the dura mater,
into the Dural venous sinuses and from here back into the
circulation.',
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
    'Vasculature of the central nervous
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

#### Branches of internal carotid artery

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

#### Branches of vertebral arteries

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
cord including the posterior horns and columns.',
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
    'Olfactory nerve:
First and shortest cranial nerve transmits sensory information
from the nasal epithelium via the cribriform plate of the
ethmoid bone to the primary olfactory cortex

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
    'Oculomotor Nerve (CN III):
Motor nerve arises from midbrain, passes through the lateral
aspect of cavernous sinus and exits skull through the superior
orbital fissure

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
    'Optic nerve:
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

![Cranial Nerve Ii_ Optic Nerve - Clinical Figure 1](/lessons/images/cranial-nerves-in-depth/cranial-nerve-ii-optic-nerve/figure_01_p1.png)
*Cranial Nerve Ii_ Optic Nerve — Clinical Figure 1 (Page 1 Reference)*',
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
    'Trochlear Nerve:
smallest cranial nerve (by number of axons) yet has the longest
intracranial course. Emerges from posterior aspect of midbrain,
travels through lateral aspect of cavernous sinus, exits skull
through superior orbital fissure.

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
    'Glossopharyngeal Nerve (CN IX):
originates in the medulla oblongata of the brain, moves
laterally in the posterior cranial fossa, and leaves the skull
through jugular foramen.
Note: Facial nerve in parotid gland splits into five terminal
branches but parotid gland is innervated by
glossopharyngeal nerve

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
    'Vestibulocochlear Nerve (CN VIII):
Comprised of two vestibular and cochlear portions, emerges
from the brainstem at the cerebellopontine angle, enters
internal acoustic meatus of temporal bone.

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
    'Facial nerve:
The facial nerve exits the cranial cavity through the internal
acoustic meatus and enters the facial canal of the temporal
bone. The nerve then exits the skull through the Stylomastoid
foramen (lies between the styloid and mastoid processes of the
temporal bone) to enter the parotid gland, ultimately
branching into five terminal branches to supply the face.
Cause of injury: Bell''s palsy, Ramsay-Hunt syndrome, Guillain-
Barre syndrome, mumps, parotid tumor, and injury to the
middle ear.
Clinical effects of injury:  impaired sense of taste to anterior
two-thirds of tongue, loss of efferent corneal reflex, impaired
lacrimal fluid production, hyperacusis, and impaired salivation
Facial nerve branches in the temporal bone:
The nerve to the stapedius: Innervate stapedius muscle.
The greater petrosal nerve: parasympathetic innervation to
the lacrimal gland and the mucous glands of the oral cavity,
nose and pharynx
The chorda tympani: supply taste to the anterior two-thirds
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

Note: Greater auricular nerve cutaneous branch of the cervical
plexus provides sensory innervation to ear lobule, skin over the
parotid gland and mastoid process of the temporal bone. Pain
of parotitis and during ear piercing is due to innervation of
greater auricular nerve.
Facial nerve terminal branches in parotid gland:
The cervical branch: innervating the platysma muscle.
The temporal branch: innervating muscles in the temple,
forehead muscles (frontalis) and supraorbital areas (upper
half of orbicularis oculi muscle)
The zygomatic branch: innervating muscles in the
infraorbital area (Lower half of orbicularis oculi muscle), the
lateral nasal area and the upper lip
The buccal branch: innervating muscles in the cheek and
upper lip
The marginal mandibular branch: innervating muscles of
the lower lip and chin

> [!TIP]
> **High yield:**
> The chorda tympani branch of the facial nerve supplies taste
> sensation to the anterior  of the tongue.

In the anterior , general sensation is supplied by the
trigeminal nerve (CNV). Specifically, the lingual nerve, a
branch of the mandibular nerve (CN V3).
The posterior  of the tongue both touch and taste are
carried by the glossopharyngeal nerve (CNIX)',
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
    'Abducent nerve:
Purely motor nerve supplying lateral rectus muscle, arises from
pons of the midbrain, travels through cavernous sinus, exits
skull through superior orbital fissure.

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
    'Trigeminal nerve:
Mixed motor and sensory nerve. It is also the largest cranial
nerve. Arises from several nuclei in the brainstem, exits
brainstem from pons It has three main divisions:

### 1: Opthalmic V1

### 2: Maxillary V2

### 3: Mandibular V3

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
    'Hypoglossal Nerve:
Pure motor nerve arises from medulla oblongata passes
laterally across the posterior cranial fossa, within the
subarachnoid space, exits the cranium via the hypoglossal
canal of the occipital bone.

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
    'Spinal Accessory Nerve (CN XI):
Arises from cervical segments C1 - C5/C6, enters cranial cavity
through foramen magnum, travels through posterior cranial
fossa and exits skull through jugular foramen.
Outside the cranium, it descends along the internal carotid
artery and innervate sternocleidomastoid muscle.

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
    'Vagus nerve
originates in the medulla oblongata of the brain and leaves
skull through jugular foramen together with CN IX and CN XI
respectively.

> [!TIP]
> **High yield:**

#### Branches of vagus nerve

Superior laryngeal nerve: innervate cricothyroid muscle and
gives sensory innervation to laryngopharynx and superior part
of the larynx
Right Recurrent laryngeal nerve: Hooks underneath right
subclavian artery and ascends towards larynx and innervate
muscles of larynx
Left Recurrent laryngeal nerve: Hooks underneath the arch of
aorta, and ascends towards larynx and innervate muscles of
larynx

> [!TIP]
> **Clinical pearls:**
> Vasovagal syncope:  Causes heart rate and blood pressure to
> drop suddenly during a period of emotional stress caused by
> initial increase in sympathetic outflow followed by a rebound
> reduction in sympathetic activity leaving unopposed

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

  -- ==========================================================================
  -- Module 8: Cell Physiology & Membrane Transport (10 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Cell Physiology & Membrane Transport' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Cell Physiology & Membrane Transport', 7, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 7, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Action Potential (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'action-potential',
    'Action Potential',
    'article',
    'Generation of Action potential
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
an action potential can travel only in one direction.',
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

  -- Lesson: Cell Membrane Transport (4 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cell-membrane-transport',
    'Cell Membrane Transport',
    'article',
    'Cell membrane transport
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

![Cell Membrane Transport - Clinical Figure 1](/lessons/images/cell-physiology-membrane-transport/cell-membrane-transport/figure_01_p1.png)
*Cell Membrane Transport — Clinical Figure 1 (Page 1 Reference)*

Filtration, osmosis and tonicity:
Note:
Example of hypotonic fluid: Pure water we drink is
hypotonic to body fluids.
Example of Isotonic fluid: NS 0.9% , Ringer''s lactate
Example of hypertonic fluid: 3% Hypertonic saline

![Cell Membrane Transport - Clinical Figure 2](/lessons/images/cell-physiology-membrane-transport/cell-membrane-transport/figure_02_p2.png)
*Cell Membrane Transport — Clinical Figure 2 (Page 2 Reference)*

![Cell Membrane Transport - Clinical Figure 3](/lessons/images/cell-physiology-membrane-transport/cell-membrane-transport/figure_03_p2.png)
*Cell Membrane Transport — Clinical Figure 3 (Page 2 Reference)*

![Cell Membrane Transport - Clinical Figure 4](/lessons/images/cell-physiology-membrane-transport/cell-membrane-transport/figure_04_p2.png)
*Cell Membrane Transport — Clinical Figure 4 (Page 2 Reference)*',
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

  -- Lesson: Homeostasis (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'homeostasis',
    'Homeostasis',
    'article',
    'Homeostasis
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
Around  is ICF
Total body water= 0.6 x bodyweight
ECF 0.2X Body weight
ICF 0.4X Body weight
Electrolytes distribution in ECF and
ICF

![Homeostasis - Clinical Figure 1](/lessons/images/cell-physiology-membrane-transport/homeostasis/figure_01_p1.png)
*Homeostasis — Clinical Figure 1 (Page 1 Reference)*

Operating mechanism for
homeostasis:

### 1: Negative feedback:

Components: Regulated variable, Sensor, Controller, and
Effector.
A regulated variable is sensed, information is fed back to the
controller, and the effector acts to oppose change (hence the
term negative) Control most systems of body."
Examples:  Osmoregulation, regulation of blood, pressure,
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

![Homeostasis - Clinical Figure 2](/lessons/images/cell-physiology-membrane-transport/homeostasis/figure_02_p2.png)
*Homeostasis — Clinical Figure 2 (Page 2 Reference)*',
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

  -- Lesson: Nerve Muscle (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'nerve-muscle',
    'Nerve Muscle',
    'article',
    'Nerve muscle
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
Contains actin, tropomyosin and troponin.
There are three types of muscle:
Skeletal
Cardiac
Smooth
Comparison between them:

![Nerve Muscle - Clinical Figure 1](/lessons/images/cell-physiology-membrane-transport/nerve-muscle/figure_01_p2.png)
*Nerve Muscle — Clinical Figure 1 (Page 2 Reference)*',
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

  -- Lesson: Neuromuscular Junction (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'neuromuscular-junction',
    'Neuromuscular Junction',
    'article',
    'Neuromuscular junction
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
in basal lamina; this prevents re-excitation.',
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

  -- Lesson: Organisation of Cell (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'organisation-of-cell',
    'Organisation of Cell',
    'article',
    'Organization of cell
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

The Golgi apparatus packages proteins for delivery to specific
intracellular destinations or into vesicles which can then be
secreted from the cell for extracellular action.

### 5: Nucleus contains genetic material and nucleolus

responsible for ribosomes production.

### 6: Ribosomes: Ribosomes are the cellular structures where

protein synthesis takes place. They can be found in the
cytoplasm (free ribosomes) or attached to the endoplasmic
reticulum (bound ribosomes).',
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

  -- Lesson: Osmolality and Osmolal Gap (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'osmolality-and-osmolal-gap',
    'Osmolality and Osmolal Gap',
    'article',
    'Osmolality and osmolal gap

![Osmolality and Osmolal Gap - Clinical Figure 1](/lessons/images/cell-physiology-membrane-transport/osmolality-and-osmolal-gap/figure_01_p1.png)
*Osmolality and Osmolal Gap — Clinical Figure 1 (Page 1 Reference)*',
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

  -- Lesson: Skeletal Muscle Excitation Contraction Coupling (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'skeletal-muscle-excitation-contraction-coupling',
    'Skeletal Muscle Excitation Contraction Coupling',
    'article',
    'Skeletal excitation contraction
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
filament theory.
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
occurs.',
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

  -- Lesson: Teatnus and Rigor Mortis (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'teatnus-and-rigor-mortis',
    'Teatnus and Rigor Mortis',
    'article',
    'Tetanus and Rigor mortis
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
detoriates.',
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

  -- Lesson: Vessel Fluid Dynamics (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'vessel-fluid-dynamics',
    'Vessel Fluid Dynamics',
    'article',
    'Vessel fluid dynamics
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
T = Wall Tension w = Wall Thickness
r = Radius
Laplace''s Law also means that a large, dilated heart (e.g., heart
failure) has to develop more wall tension (contractile force) in
order to obtain the same ventricular pressure, making it less
efficient.',
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

  -- ==========================================================================
  -- Module 9: Cardiovascular Physiology & Hemodynamics (14 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Cardiovascular Physiology & Hemodynamics' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Cardiovascular Physiology & Hemodynamics', 8, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 8, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Cardiac Cycle (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cardiac-cycle',
    'Cardiac Cycle',
    'article',
    'Heart as pump
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
of a second occurs in the A-V node and bundle, which
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

### 2.  Period of Rapid Filling of Ventricles (First ): During this,

atrial pressure becomes greater than    intra-ventricular pressure (just after systole is over), AV valves (tricuspid and
mitral) open, and blood flows rapidly into respective ventricles.

### 3. Diastasis (Middle ): During this, blood continues to empty

into atria from veins and passes on thru atria directly into
ventricles
4.Atrial Systole (Late ): During this, atria contracts and
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
Period of Rapid Ejection: During first , 70% emptying
occurs.
Period of Slow Ejection During last , 30% emptying occur.
Relationship of the
Electrocardiogram to the Cardiac
Cycle
The P wave is caused by the spread of depolarization across
the atria, which causes atrial contraction. Atrial pressure
increases just after the P wave.
The QRS waves appear as a result of ventricular
depolarization about 0.16 second after the onset of the P wave, and this initiates ventricular contraction; then the
ventricular pressure begins to increase.
The ventricular T wave is caused by repolarization of the
ventricle.
Functions of Heart Valves
AV (tricuspid and mitral valves) prevent backflow of blood
from ventricles to atria during systole.
Semilunar (aortic and pulmonary) valves prevent backflow
of blood from aorta and pulmonary trunk into ventricles
during diastole.',
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

  -- Lesson: Cardiac Excitation Contraction Coupling (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cardiac-excitation-contraction-coupling',
    'Cardiac Excitation Contraction Coupling',
    'article',
    'Cardiac excitation contraction
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
during the AP plateau ⟶  more Ca2+ is stored in the SR ⟶
more Ca2+ is released from the SR and thus more Ca2+ is left
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
an energy source.',
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

  -- Lesson: Cardiac Myocyte (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cardiac-myocyte',
    'Cardiac Myocyte',
    'article',
    'Cardiac myocyte
Cardiac myocyte and comparison with other
cells

![Cardiac Myocyte - Clinical Figure 1](/lessons/images/cardiovascular-physiology-hemodynamics/cardiac-myocyte/figure_01_p1.png)
*Cardiac Myocyte — Clinical Figure 1 (Page 1 Reference)*',
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

  -- Lesson: Components of the Vasculature (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'components-of-the-vasculature',
    'Components of the Vasculature',
    'article',
    'Components of the vasculature

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
CNS, are the most selective with low permeability, as junctions between the endothelial cells are very tight,
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

### 4:  Venules

are formed from merged capillaries.

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
Vena cava, 4 mm Hg',
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

  -- Lesson: Conducting System of Heart (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'conducting-system-of-heart',
    'Conducting System of Heart',
    'article',
    'Conducting system of heart
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
interval (1st degree heart block)',
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

  -- Lesson: Electrocardiography (ecg) (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'electrocardiography-ecg',
    'Electrocardiography (ecg)',
    'article',
    'ECG
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

![Electrocardiography (ecg) - Clinical Figure 1](/lessons/images/cardiovascular-physiology-hemodynamics/electrocardiography-ecg/figure_01_p1.png)
*Electrocardiography (ecg) — Clinical Figure 1 (Page 1 Reference)*',
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

  -- Lesson: Harmonal Control of Blood Flow (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'harmonal-control-of-blood-flow',
    'Harmonal Control of Blood Flow',
    'article',
    'Hormonal Control of Blood Flow
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
Thromboxane A2 is a vasoconstrictor.
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

During systole, mechanical compression of the coronary
vessels reduces blood flow. After        the period of occlusion,
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
the arteries and decrease blood flow. During the post occlusion period, reactive hyperemia increases blood flow to
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

![Harmonal Control of Blood Flow - Clinical Figure 1](/lessons/images/cardiovascular-physiology-hemodynamics/harmonal-control-of-blood-flow/figure_01_p3.png)
*Harmonal Control of Blood Flow — Clinical Figure 1 (Page 3 Reference)*',
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

  -- Lesson: Heart Sounds, Mechanical Events and Correspondance with ECG (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'heart-sounds-mechanical-events-and-correspondance-with-ecg',
    'Heart Sounds, Mechanical Events and Correspondance with ECG',
    'article',
    'Heart sounds, Mechanical event and correspondence with
ECG

![Heart Sounds, Mechanical Events and Correspondance with ECG - Clinical Figure 1](/lessons/images/cardiovascular-physiology-hemodynamics/heart-sounds-mechanical-events-and-correspondance-with-ecg/figure_01_p1.png)
*Heart Sounds, Mechanical Events and Correspondance with ECG — Clinical Figure 1 (Page 1 Reference)*',
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

  -- Lesson: Heart Volumes (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'heart-volumes',
    'Heart Volumes',
    'article',
    'Heart volume
The total blood volume in the circulatory system of a healthy
adult is about 5 L.
Stroke Volume Output: The volume of blood that is ejected
by each ventricle during systole is called stroke volume
output (Value:70 ml/beat)
Heart rate= 70bpm
Cardiac output (CO) = Stroke volume x Heart rate = 70
mL/beat x 70 beats/min = 4900 mL/min
Mean arterial pressure: Average arterial pressure during
single cardiac cycle. MAP can be calculated by:  Diastolic
pressure +  of pulse pressure (SBP-DBP) OR 80+  (120-
80) = 93mmhg where BP
End-Diastolic Volume: The volume of blood in each ventricle
at the end of the diastole is called end-diastolic volume.
(Value:120-130ml)
End-Systolic Volume: The volume of blood in each ventricle
at end of systole is called end-systolic volume. (Value: 50-
60ml)
Ejection Fraction: Fraction of end-diastolic volume that is
ejected during systole, is called ejection fraction. (Value: 60%)',
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

  -- Lesson: Microcirculation and Lymph (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'microcirculation-and-lymph',
    'Microcirculation and Lymph',
    'article',
    'Microcirculation and Lymph
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
capillaries. The excess filtered fluid is returned to the circulation via the lymph also returns any filtered protein to the
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
the production of NO in vascular smooth muscle.',
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

  -- Lesson: Reflex Control of Heart (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'reflex-control-of-heart',
    'Reflex Control of Heart',
    'article',
    'Reflex control of heart by
autonomic nervous system
Sympathetic stimulation increases heart rate and strength,
thereby increasing cardiac pumping. Sympathetic
stimulation causes vasoconstriction and vasoconstriction
increases blood pressure by increasing total peripheral
resistance (TPR). If resistance increases, then more pressure is
needed to keep blood moving.
Parasympathetic stimulation decreases heart rate and
strength, thereby decreasing cardiac pumping.',
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

  -- Lesson: Regulation of Blood Pressure (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'regulation-of-blood-pressure',
    'Regulation of Blood Pressure',
    'article',
    'Regulation of Blood pressure
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

![Regulation of Blood Pressure - Clinical Figure 1](/lessons/images/cardiovascular-physiology-hemodynamics/regulation-of-blood-pressure/figure_01_p1.png)
*Regulation of Blood Pressure — Clinical Figure 1 (Page 1 Reference)*

blood flow to the brain. Mean arterial pressure can increase to
life-threatening levels.
The Cushing reaction is an example of the response to cerebral
ischemia. Increases in intracranial pressure cause compression
of the cerebral blood vessels, leading to cerebral ischemia and
increased cerebral Pco ₂ . The vasomotor center directs an
increase in sympathetic outflow to the heart and blood vessels,
which causes a profound increase in arterial pressure.',
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

  -- Lesson: Regulation of Cardiac Pumping (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'regulation-of-cardiac-pumping',
    'Regulation of Cardiac Pumping',
    'article',
    'Regulation of Cardiac Pumping
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

Afterload is the pressure that the chambers of the heart
must generate in order to eject blood out of the heart occurs
in systole.
Note: In heart failure, the Frank-Starling curve is moved down
and flattened due to reduced inotropy, so that more venous
return and hence preload is required to increase stroke volume.
As venous return and preload rise, myocyte stretching occurs
that increases sarcomere length.
Factors affecting frank starling curve.
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

![Regulation of Cardiac Pumping - Clinical Figure 1](/lessons/images/cardiovascular-physiology-hemodynamics/regulation-of-cardiac-pumping/figure_01_p2.png)
*Regulation of Cardiac Pumping — Clinical Figure 1 (Page 2 Reference)*

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
Digoxin is positive inotrope and negative chronotrope.',
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

  -- Lesson: Ventricular Myocyte Vs Pacemaker Action Potential (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'ventricular-myocyte-vs-pacemaker-action-potential',
    'Ventricular Myocyte Vs Pacemaker Action Potential',
    'article',
    'Ventricular myocyte action
potential
RMP of Ventricular myocyte is -90mv depolarization initiates
when RMP reaches threshold of -65mv
Fast Na channels activate and a rapid Na+ influx
depolarizes membrane potential.
Pacemaker action potential:
Action potential of SA node differs from ventricular muscle.
RMP of SA node is -60mv depolarization initiates when RMP
reaches threshold of -40mv.
Slow calcium channels activation and calcium influx
initiates depolarization unlike of other ventricular muscle Na
influx initiates depolarization

![Ventricular Myocyte Vs Pacemaker Action Potential - Clinical Figure 1](/lessons/images/cardiovascular-physiology-hemodynamics/ventricular-myocyte-vs-pacemaker-action-potential/figure_01_p1.png)
*Ventricular Myocyte Vs Pacemaker Action Potential — Clinical Figure 1 (Page 1 Reference)*

![Ventricular Myocyte Vs Pacemaker Action Potential - Clinical Figure 2](/lessons/images/cardiovascular-physiology-hemodynamics/ventricular-myocyte-vs-pacemaker-action-potential/figure_02_p2.png)
*Ventricular Myocyte Vs Pacemaker Action Potential — Clinical Figure 2 (Page 2 Reference)*',
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

  -- ==========================================================================
  -- Module 10: Respiratory Physiology & Ventilation (15 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Respiratory Physiology & Ventilation' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Respiratory Physiology & Ventilation', 9, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 9, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Alveolar Arterial Gradient (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'alveolar-arterial-gradient',
    'Alveolar Arterial Gradient',
    'article',
    'A-a gradient
Difference between alveolar Po2 and arterial Po2
A-a gradient: PA02-Pao2 (where PA02 alveolar po2 and Pao2
is arterial po2)
The A-a gradient is used to determine whether O2 has
equilibrated between alveolar gas and arterial blood.
The normal A-a gradient is between 0- and 10mm Hg. Since
O2 normally equilibrates between alveolar gas and arterial
blood, PAo2 is approximately equal to Pao2. e.g.,
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
shunt',
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

  -- Lesson: Breathing Cycle - Description of Pressure and Airflow (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'breathing-cycle-description-of-pressure-and-airflow',
    'Breathing Cycle - Description of Pressure and Airflow',
    'article',
    'Breathing cycle (description of
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

Alveolar pressure becomes greater than atmospheric
pressure. "The alveolar pressure becomes greater (i.e. becomes
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
Lung volume returns to FRC.',
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

  -- Lesson: Central Control of Breathing (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'central-control-of-breathing',
    'Central Control of Breathing',
    'article',
    'Involuntary respiration
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

A: Dorsal respiratory group is primarily responsible for
inspiration and generates the basic rhythm for breathing
Input to the dorsal respiratory group comes from the vagus
and glossopharyngeal nerves. The vagus nerve relays
information from peripheral chemoreceptors in the lung. The
glossopharyngeal nerve relays information from peripheral chemoreceptors and Output from the dorsal respiratory
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
4.Cerebral cortex: Breathing can be under voluntary control;
therefore, a person can voluntarily hyper ventilate or hypo
ventilate.
Note: Hypoventilation (breath-holding) is limited by the
resulting increase in Pco2 and decrease in P02',
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

  -- Lesson: Control of Ventilation (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'control-of-ventilation',
    'Control of Ventilation',
    'article',
    'Control of ventilation is mediated via
central and Peripheral
chemoreceptors.
Chemoreceptor overview:
Central chemoreceptor Vs Peripheral
chemoreceptor

![Control of Ventilation - Clinical Figure 1](/lessons/images/respiratory-physiology-ventilation/control-of-ventilation/figure_01_p1.png)
*Control of Ventilation — Clinical Figure 1 (Page 1 Reference)*

![Control of Ventilation - Clinical Figure 2](/lessons/images/respiratory-physiology-ventilation/control-of-ventilation/figure_02_p1.png)
*Control of Ventilation — Clinical Figure 2 (Page 1 Reference)*',
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

  -- Lesson: Dead Space (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'dead-space',
    'Dead Space',
    'article',
    'Dead Space
Anatomic dead space
Refers to volume of conducting airways.
Normally approximately 150 ml
Alveolar dead space:
Refers to alveoli incapable of gas exchange, in normal healthy
individual it is negligible, but it may become significant in
V/Q mismatch i.e., in pulmonary embolism when alveoli do
not take part in gas exchange.
Physiologic dead space: sum of anatomical and alveolar dead
space.
Defined as the volume of the lungs that does not participate
in gas exchange. is approximately equal to the anatomic
dead space in normal lungs may be greater than the
anatomic dead space in lung diseases in which the
ventilation/perfusion (V/Q) defects.',
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

  -- Lesson: Diffusion and Diffusion Capacity (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'diffusion-and-diffusion-capacity',
    'Diffusion and Diffusion Capacity',
    'article',
    'Diffusion of gases such as 02
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

DLCO increases during exercise because there are more
open capillaries and thus more surface area for diffusion.
DLCO decreases in emphysema (because of decreased
surface area) and in fibrosis and pulmonary edema (because
of increased diffusion distance).
High DLCO and Low DLCO

![Diffusion and Diffusion Capacity - Clinical Figure 1](/lessons/images/respiratory-physiology-ventilation/diffusion-and-diffusion-capacity/figure_01_p2.png)
*Diffusion and Diffusion Capacity — Clinical Figure 1 (Page 2 Reference)*',
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

  -- Lesson: Gas Exchange (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'gas-exchange',
    'Gas Exchange',
    'article',
    '## Gas Exchange

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
their bodies to absorb more gases than are absorbed at lower pressures. Absorbed gases can cause decompression
sickness as well as toxic effects.
Henry law is applicable in Scuva diving or deep-sea diver.
The following calculation uses O2 in arterial blood as an
example: Dissolved [O2] =Po2 × Solubility of O2 in blood 100
mm Hg x 0.003 mL  mL/mm Hg =0.3 mL  mL
blood
where:
[02] =02concentration in blood
Po2partial pressure of O2 in blood
0.003 mL O2/100 mL/mm Hg= solubility of O2 in blood
Partial pressure of O2 and Co2 (mm Hg)

![Gas Exchange - Clinical Figure 1](/lessons/images/respiratory-physiology-ventilation/gas-exchange/figure_01_p2.png)
*Gas Exchange — Clinical Figure 1 (Page 2 Reference)*',
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

  -- Lesson: Lung Elastance and Compliance (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'lung-elastance-and-compliance',
    'Lung Elastance and Compliance',
    'article',
    'Lung elastance and Lung
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
forces can be balanced again.',
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

  -- Lesson: Lung Receptors (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'lung-receptors',
    'Lung Receptors',
    'article',
    'Lung receptors:
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
expiration produced by marked deflation of lung.',
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

  -- Lesson: Lung Volumes and Capacities (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'lung-volumes-and-capacities',
    'Lung Volumes and Capacities',
    'article',
    'Lung volume and capacities
Tidal Volume (TV): The volume of air that is inhaled and then
exhaled with each normal breath.
Normal tidal volume is 500ml or 7ml/kg.
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
using spirometry.
Normal FRC is 3500ml.
Factors affecting FRC.

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
ratio is less than 0.7.
In restrictive lung disease such as fibrosis, both FEV1 and
FVC are reduced, but FEV1 is reduced less than FVC is thus,
Fev1 /FVC increased.
Lung volume measurements and
Peak Expiratory flow rate:
Lung volume can be measured with Spirometry.
Residual volume cannot be measured using spirometry.
Residual volume and thus (FRC and TLC) can be measured
using helium dilution.
Peak Expiratory flow rate:

The easiest and quickest measurement is the peak expiratory
flow rate (PEFR)
Airway resistance and lung compliance can be assessed
indirectly by measuring the forced expiratory flows and
volumes.
Lung volumes can be measured with spirometry.
PEFR is reduced if airway resistance is increased in
obstructive disease and is commonly used to monitor
asthma.',
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

  -- Lesson: Oxygen Haemoglobin Dissociation Curve (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'oxygen-haemoglobin-dissociation-curve',
    'Oxygen Haemoglobin Dissociation Curve',
    'article',
    'Oxygen-Haemoglobin
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

Methemoglobinemia
Fetal hemoglobin
Note:
Fetal hemoglobin has a higher affinity for oxygen than adult
hemoglobin. Maternal and Fetal blood never mix during
pregnancy, but they come close to each other in the
placenta.  Oxygen diffuses easily to fetal hemoglobin here.
The reason fetal hemoglobin has a higher affinity for 02. It is
composed of two alpha and two gamma subunits, while
adult hemoglobin is composed of two alpha and two beta
subunits.
2,3DPG present in RBCs enhances the ability of RBCs to
release o2 near tissue and 2,3DPG only binds with beta
globulin chains, fetal hemoglobin (HbF) lack of beta
globulin chains that''s why fetal hemoglobin has higher
affinity for O2',
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

  -- Lesson: Resistance of the Airways (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'resistance-of-the-airways',
    'Resistance of the Airways',
    'article',
    'Resistance of the airways
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
smooth muscle:  changes airway resistance
by altering the radius of the airways.
Parasympathetic stimulation, irritants, and the slow-reacting
substance of anaphylaxis (asthma) constrict the airways,
decrease the radius, and increase the resistance to airflow.
Sympathetic stimulation and sympathetic agonists
(isoproterenol) dilate the airway via beta2 receptors, increase
the radius, and decrease the resistance to airflow.',
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

  -- Lesson: Surface Tention and Surfactant (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'surface-tention-and-surfactant',
    'Surface Tention and Surfactant',
    'article',
    'Surface tension and surfactant
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
premature infants because of the lack of surfactant. The infant exhibits atelectasis (lungs collapse), difficulty reinflating the
lungs (as a result of decreased compliance), decreased V/Q and
right-to-left shunt, and hypoxemia (as a result of decreased V/Q
and right-to-left shunt).',
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

  -- Lesson: Transport of Gases in Circulation (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'transport-of-gases-in-circulation',
    'Transport of Gases in Circulation',
    'article',
    'Transport of Gases in Circulation:
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
contains a maximum of 187 mL/L',
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

  -- Lesson: Ventilation Perfusion Mismatch (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'ventilation-perfusion-mismatch',
    'Ventilation Perfusion Mismatch',
    'article',
    'Ventilation- Perfusion mismatch
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
atelectasis due to hydrothorax or pneumothorax.
V/Q ratio <1: Low ventilation relative to its perfusion such as
in partial obstruction of airways. Causes: Low compliance
e.g., pulmonary fibrosis, High airway resistance e.g., COPD,
asthma

### 2: Perfusion defect (Ventilation normal but perfusion

decreased)
If blood flow to a lung is completely blocked (e.g., by an
embolism occluding a pulmonary artery), then blood flow to that lung is zero. If ventilation is normal, then V/Q is infinite,
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
that of mixed venous blood. Changes in PCO2 and
PO2 stimulate the chemoreceptors and increase ventilation,
so that arterial PCO2 returns to normal.
However, increased ventilation cannot increase blood
O2 content, as the haemoglobin of the blood passing
through the lungs is already close to saturation. Thus, right to
left shunts commonly result in a low arterial PO2 but a
normal or low PCO2.

![Ventilation Perfusion Mismatch - Clinical Figure 1](/lessons/images/respiratory-physiology-ventilation/ventilation-perfusion-mismatch/figure_01_p2.png)
*Ventilation Perfusion Mismatch — Clinical Figure 1 (Page 2 Reference)*',
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

  -- ==========================================================================
  -- Module 11: Renal Physiology & Acid-Base Balance (13 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Renal Physiology & Acid-Base Balance' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Renal Physiology & Acid-Base Balance', 10, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 10, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Acid Base Balance (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'acid-base-balance',
    'Acid Base Balance',
    'article',
    'Acid base balance
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
hyperkalemia and thus also causes type 4 RTA. Conversely, hypokalemia stimulates NH3 synthesis, which produces an
increase in H excretion.',
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

  -- Lesson: Acid Base Disorder (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'acid-base-disorder',
    'Acid Base Disorder',
    'article',
    'Acid base disorders
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
is hypoalbuminemia

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
results in over-breathing/breathlessness).',
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

  -- Lesson: Aldosterone, ADH and ANP (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'aldosterone-adh-and-anp',
    'Aldosterone, ADH and ANP',
    'article',
    'Aldosterone
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
ADH release is stimulated by.
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
ENaC in principal cells.',
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

  -- Lesson: Autoregulation (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'autoregulation',
    'Autoregulation',
    'article',
    'Autoregulation
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
providing restoration of filtration and autoregulation of RBF.',
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

  -- Lesson: Concentration and Dilution of Urine (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'concentration-and-dilution-of-urine',
    'Concentration and Dilution of Urine',
    'article',
    'Concentration and dilution of
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
Late distal tubule - high ADH
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
corticopapillary osmotic gradient, osmotic equilibration does not occur.
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
Urine that is hypoosmotic to plasma (low ADH) CH2O is
positive.
Produced with high water intake (in which ADH released
from the posterior pituitary is suppressed), central diabetes
insipidus or nephrogenic diabetes insipidus.
Urine that is hyperosmotic to plasma (high ADH)
CH2O is negative.
It is produced in water deprivation or SIADH.',
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

  -- Lesson: Creatinine Clearance (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'creatinine-clearance',
    'Creatinine Clearance',
    'article',
    'Creatinine Clearance
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
(excretion rises as plasma concentration increases',
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

  -- Lesson: Functional Anatomy of Kidney (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'functional-anatomy-of-kidney',
    'Functional Anatomy of Kidney',
    'article',
    'Anatomy of Kidney
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

space; the podocytes have foot processes directly contacting the basement membrane.
Regular gaps between foot processes (pedicles) are called
filtration slits, across these slits a protein network forms slit
pores in the epithelial lining which prevent the passage of
larger molecules through this final layer.
Podocytes also exhibit phagocytic and contractile activity like
that of mesangial cells.',
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

  -- Lesson: Glomerular Filtration Rate (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'glomerular-filtration-rate',
    'Glomerular Filtration Rate',
    'article',
    'Glomerular Filtration rate
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
increases GFR.',
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

  -- Lesson: Hyperkalemia and Hypokalemia (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'hyperkalemia-and-hypokalemia',
    'Hyperkalemia and Hypokalemia',
    'article',
    'Hyperkalemia
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
Pseudo hyperkalemia:  occurs in
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

Treatment of hyperkalemia
If there are ECG changes: Stabilize the cardiac membrane
first, e.g., with IV calcium gluconate (10 ml of 10% solution IV
over 2 minutes).   Followed by or treatment of hyperkalemia
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

![Hyperkalemia and Hypokalemia - Clinical Figure 1](/lessons/images/renal-physiology-acid-base-balance/hyperkalemia-and-hypokalemia/figure_01_p2.png)
*Hyperkalemia and Hypokalemia — Clinical Figure 1 (Page 2 Reference)*

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
Note  :
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
K sparing diuretics',
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

  -- Lesson: NACL Regulation (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'nacl-regulation',
    'NACL Regulation',
    'article',
    'NaCl Regulation
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
phosphate and lactate. These cotransport processes account for the reabsorption of all the filtered glucose and amino
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
Late DCT: Have two cell types.
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
Reabsorbs K+ by an H-K-ATPase',
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

  -- Lesson: Potassium Regulation (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'potassium-regulation',
    'Potassium Regulation',
    'article',
    'K+ Regulation
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
increasing the driving force for K+ secretion.',
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

  -- Lesson: Renal Regulation of Urea, Phosphate, Calcium and Magnessium (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'renal-regulation-of-urea-phosphate-calcium-and-magnessium',
    'Renal Regulation of Urea, Phosphate, Calcium and Magnessium',
    'article',
    'Renal regulation of urea,
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
inhibiting Ca reabsorption)',
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

  -- Lesson: Renin Angiotensin Aldosterone System (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'renin-angiotensin-aldosterone-system',
    'Renin Angiotensin Aldosterone System',
    'article',
    'Renin angiotensin aldosterone
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
Note: The release of renin is inhibited by atrial natriuretic
peptide (ANP), which is released by stretched atria in response
to increases in blood pressure.
Angiotensin II production

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
apparatus (negative feedback)',
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

  -- ==========================================================================
  -- Module 12: Gastrointestinal (GIT) Physiology (20 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Gastrointestinal (GIT) Physiology' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Gastrointestinal (GIT) Physiology', 11, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 11, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Absorption of Vitamins in Small Intestine (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'absorption-of-vitamins-in-small-intestine',
    'Absorption of Vitamins in Small Intestine',
    'article',
    'Vitamins absorption
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
vitamin B12',
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

  -- Lesson: Bile and Bile Salts (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'bile-and-bile-salts',
    'Bile and Bile Salts',
    'article',
    'Bile
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
after meals. Therefore, the gallbladder concentrates and stores bile, by removing the water and ions.
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

Emulsification of lipids to increase the surface area available
for digestion by pancreatic lipase.
Micelles formation to facilitate lipid transport and absorption.
Stimulate the bile production by osmotically attracting water
and electrolytes into the bile canaliculi.
Regulation of bile acid synthesis via negative feedback
mechanism',
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

  -- Lesson: Calcium Absorption (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'calcium-absorption',
    'Calcium Absorption',
    'article',
    'Calcium absorption
Absorption of calcium in small intestine depends on
presence of adequate amounts of the active form of vitamin
D, 1 ,25-dihydroxycholecalciferol, which is produced in the
kidney. 1 ,25-dihydroxycholecalciferol induces the synthesis of
an intestinal Ca+2 -binding protein, calbindin D-28K
Vitamin D deficiency or chronic renal failure results in
inadequate intestinal Ca+ absorption, causing rickets in
children and osteomalacia in adults.',
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

  -- Lesson: Defecation (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'defecation',
    'Defecation',
    'article',
    'Defecation
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
reflexes that anal distension initiates.',
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

  -- Lesson: Digestion and Absorption of Carbohydrates (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'digestion-and-absorption-of-carbohydrates',
    'Digestion and Absorption of Carbohydrates',
    'article',
    'Carbohydrate
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

![Digestion and Absorption of Carbohydrates - Clinical Figure 1](/lessons/images/gastrointestinal-git-physiology/digestion-and-absorption-of-carbohydrates/figure_01_p2.png)
*Digestion and Absorption of Carbohydrates — Clinical Figure 1 (Page 2 Reference)*',
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

  -- Lesson: Digestion and Absorption of Lipids (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'digestion-and-absorption-of-lipids',
    'Digestion and Absorption of Lipids',
    'article',
    'Lipid
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
digestion to form structures called micelles, which help the fats get close enough to the microvilli of intestinal cells so
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
apolipoproteins) and cholesterol.  Lack of apoprotein B
results in the inability to transport chylomicrons out of the
intestinal cells and causes abetalipoproteinemia.
Chylomicrons are transported out of the intestinal cells by
exocytosis. Because chylomicrons are too large to enter the
capillaries, they are transferred to lymph vessels (lacteals) and
are added to the bloodstream via the thoracic duct.

![Digestion and Absorption of Lipids - Clinical Figure 1](/lessons/images/gastrointestinal-git-physiology/digestion-and-absorption-of-lipids/figure_01_p2.png)
*Digestion and Absorption of Lipids — Clinical Figure 1 (Page 2 Reference)*

![Digestion and Absorption of Lipids - Clinical Figure 2](/lessons/images/gastrointestinal-git-physiology/digestion-and-absorption-of-lipids/figure_02_p3.png)
*Digestion and Absorption of Lipids — Clinical Figure 2 (Page 3 Reference)*',
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

  -- Lesson: Digestion and Absorption of Proteins (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'digestion-and-absorption-of-proteins',
    'Digestion and Absorption of Proteins',
    'article',
    'Protein
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
and carboxypeptidase B acts on basic AA. The process of digestion of protein is completed in the small intestine with
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

![Digestion and Absorption of Proteins - Clinical Figure 1](/lessons/images/gastrointestinal-git-physiology/digestion-and-absorption-of-proteins/figure_01_p2.png)
*Digestion and Absorption of Proteins — Clinical Figure 1 (Page 2 Reference)*',
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

  -- Lesson: Exocrine Pancreas (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'exocrine-pancreas',
    'Exocrine Pancreas',
    'article',
    'Exocrine pancreas
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

![Exocrine Pancreas - Clinical Figure 1](/lessons/images/gastrointestinal-git-physiology/exocrine-pancreas/figure_01_p1.png)
*Exocrine Pancreas — Clinical Figure 1 (Page 1 Reference)*

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
enzyme and aqueous components.
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
> intestine, where it aids in protein digestion. However, in cases of pancreatitis, trypsin can become prematurely activated
within the pancreas itself due to factors like alcohol
consumption or other triggers. This activation of trypsin within
the pancreas can lead to the autodigestion of pancreatic tissue,
causing inflammation.
Chymotrypsinogen is the inactive precursor of chymotrypsin.
Activation of chymotrypsinogen to its active form,
chymotrypsin, occurs through the action of trypsin. Once
trypsin is produced through the activation of trypsinogen, it
can then activate chymotrypsinogen by cleaving it to
chymotrypsin. Chymotrypsin further breaks down protein
molecules into smaller peptides and amino acids that can be
absorbed by the body.',
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

  -- Lesson: Gastrointestinal Hormones (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'gastrointestinal-hormones',
    'Gastrointestinal Hormones',
    'article',
    'Gastrointestinal hormones
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

![Gastrointestinal Hormones - Clinical Figure 1](/lessons/images/gastrointestinal-git-physiology/gastrointestinal-hormones/figure_01_p3.png)
*Gastrointestinal Hormones — Clinical Figure 1 (Page 3 Reference)*

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
Decrease blood glucose concentration.',
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

  -- Lesson: Gastrointestinal Tract (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'gastrointestinal-tract',
    'Gastrointestinal Tract',
    'article',
    'Gastrointestinal tract
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

Structures of GI tract:
All segments of the GI tract are divided into four layers (from
innermost to outer most) are:
1.The innermost mucosa composed of:
the epithelial layer (specialized in different parts of the GI
tract for secretion and absorption
the lamina propria (consisting of loose tissue, blood
vessels and lymph tissue)
the muscularis mucosa (contraction causes a change in
the surface area for secretion or absorption)

### 2. The submucosa (containing a second layer of connective

tissue, large blood vessels and lymphatic vessels and
submucosal plexus

![Gastrointestinal Tract - Clinical Figure 1](/lessons/images/gastrointestinal-git-physiology/gastrointestinal-tract/figure_01_p2.png)
*Gastrointestinal Tract — Clinical Figure 1 (Page 2 Reference)*

3.The muscularis externa composed of:
The inner circular muscle layer (contraction causes a
decrease in diameter of the lumen of the GI tract)
The outer longitudinal muscle layer (contraction causes
shortening of a segment of the GI tract)
The myenteric plexus which lies between these two layers
of muscle

### 4. The outer most serosa (another connective tissue layer

covered with squamous mesothelial cells)',
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

  -- Lesson: Innervation of Gi Tract (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'innervation-of-gi-tract',
    'Innervation of Gi Tract',
    'article',
    'Innervation of Gastrointestinal tract
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

![Innervation of Gi Tract - Clinical Figure 1](/lessons/images/gastrointestinal-git-physiology/innervation-of-gi-tract/figure_01_p1.png)
*Innervation of Gi Tract — Clinical Figure 1 (Page 1 Reference)*

![Innervation of Gi Tract - Clinical Figure 2](/lessons/images/gastrointestinal-git-physiology/innervation-of-gi-tract/figure_02_p1.png)
*Innervation of Gi Tract — Clinical Figure 2 (Page 1 Reference)*

Primary esophageal motility disorder characterized by the
impaired relaxation of the lower esophageal sphincter (LES)
and absence of peristalsis in the esophagus. This condition is
primarily attributed to dysfunction in the myenteric plexus,
which is a network of nerve fibers and ganglion cells located
between the circular and longitudinal muscle layers of the
esophagus.',
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

  -- Lesson: Iron Handling (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'iron-handling',
    'Iron Handling',
    'article',
    'Iron
Iron is a vital trace element for humans, as it plays a crucial role
in oxygen transport, oxidative metabolism, cellular proliferation,
and many catalytic reactions.
Dietary iron, Heme iron: from meat, non-heme iron: from
plants
Ferrous iron (Fe 2+): in hemoglobin
Ferric iron (Fe3+): in methemoglobin
Free iron: Fe2+ can lead to reactive oxygen species via the
Fenton reaction.
H2O2 + Fe2+ →  OH- + Fe3+ + OH (hydroxyl radical) →  oxidative
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

![Iron Handling - Clinical Figure 1](/lessons/images/gastrointestinal-git-physiology/iron-handling/figure_01_p2.png)
*Iron Handling — Clinical Figure 1 (Page 2 Reference)*

Any source of bleeding (e.g., menstruation, occult GI bleed)
increases iron loss.',
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

  -- Lesson: Large Intestine (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'large-intestine',
    'Large Intestine',
    'article',
    'Large intestine
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
secreted depending on the concentration in the lumen and the electrochemical gradient created by the active
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

![Large Intestine - Clinical Figure 1](/lessons/images/gastrointestinal-git-physiology/large-intestine/figure_01_p2.png)
*Large Intestine — Clinical Figure 1 (Page 2 Reference)*',
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

  -- Lesson: Liver (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'liver',
    'Liver',
    'article',
    'Liver
Largest gland in the body
Weight: 1.2-1.5 kg in adults (2.6-3.3 pounds)
Wedge-shaped
Consists of four lobes: Right (largest), Left, Quadrate and
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
cells, are found in high numbers in the liver.',
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

  -- Lesson: Mastication and Swallowing (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'mastication-and-swallowing',
    'Mastication and Swallowing',
    'article',
    'Mouth
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
Bolus in the mouth →  reflex inhibition of mastication muscles
→  lower jaw drops →  Strech reflex of jaw muscles →  rebound
contraction of jaw muscles →  closure of teeth- compression of
bolus again against mouth lining →  again reflex inhibition of
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
contracts to prevent reflux and respiration begins again.',
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

  -- Lesson: Saliva (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'saliva',
    'Saliva',
    'article',
    'Saliva
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

![Saliva - Clinical Figure 1](/lessons/images/gastrointestinal-git-physiology/saliva/figure_01_p3.png)
*Saliva — Clinical Figure 1 (Page 3 Reference)*',
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

  -- Lesson: Small Intestine (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'small-intestine',
    'Small Intestine',
    'article',
    'Small intestine
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
well as Na+ ions can then diffuse into the capillaries.',
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

  -- Lesson: Stomach (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'stomach',
    'Stomach',
    'article',
    'Stomach
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

![Stomach - Clinical Figure 1](/lessons/images/gastrointestinal-git-physiology/stomach/figure_01_p1.png)
*Stomach — Clinical Figure 1 (Page 1 Reference)*

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

![Stomach - Clinical Figure 2](/lessons/images/gastrointestinal-git-physiology/stomach/figure_02_p2.png)
*Stomach — Clinical Figure 2 (Page 2 Reference)*

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
parietal cell.
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

Fat/protein breakdown products in duodenum: fat is the
most potent inhibitor of gastric emptying (acting via
CCK); Entry of fats in duodenum -> release of CCK from "I"
cells -> CCK decreases gastric motility and thus prevents or
retards gastric emptying, so that the ingested fats enter
slowly and in small amounts into duodenum.)
Hormones CCK, secretin, gastric inhibitory peptide (GIP) all
cause constriction of pyloric sphincter, hence slow gastric
emptying.',
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

  -- Lesson: Summary of Harmones and Secretion of GIT (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'summary-of-harmones-and-secretion-of-git',
    'Summary of Harmones and Secretion of GIT',
    'article',
    'Summary of hormones and
secretion of git
Gastric secretory and Regulatory
products
Small intestine regulatory products:

![Summary of Harmones and Secretion of GIT - Clinical Figure 1](/lessons/images/gastrointestinal-git-physiology/summary-of-harmones-and-secretion-of-git/figure_01_p2.png)
*Summary of Harmones and Secretion of GIT — Clinical Figure 1 (Page 2 Reference)*

![Summary of Harmones and Secretion of GIT - Clinical Figure 2](/lessons/images/gastrointestinal-git-physiology/summary-of-harmones-and-secretion-of-git/figure_02_p2.png)
*Summary of Harmones and Secretion of GIT — Clinical Figure 2 (Page 2 Reference)*',
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

  -- Lesson: Vitamins Overview (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'vitamins-overview',
    'Vitamins Overview',
    'article',
    'Vitamins

![Vitamins Overview - Clinical Figure 1](/lessons/images/gastrointestinal-git-physiology/vitamins-overview/figure_01_p1.png)
*Vitamins Overview — Clinical Figure 1 (Page 1 Reference)*',
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

  -- ==========================================================================
  -- Module 13: Endocrine Physiology & Metabolism (19 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Endocrine Physiology & Metabolism' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Endocrine Physiology & Metabolism', 12, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 12, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Adrenal Gland (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'adrenal-gland',
    'Adrenal Gland',
    'article',
    'Adrenal gland
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
Zona fasciculata = middle zone; synthesizes glucocorticoid
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
regulated by the renin-angiotensin system and by potassium.',
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

  -- Lesson: Adrenal Insufficiency (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'adrenal-insufficiency',
    'Adrenal Insufficiency',
    'article',
    'Adrenal Insufficiency
Adrenal insufficiency is a failure of the adrenal glands to
produce adequate amounts of adrenocortical hormone. It
can be primary, secondary or tertiary.
Primary adrenal insufficiency (Addison disease): refers to
chronic, primary adrenocortical insufficiency (Adrenal cortex)
which leads to
↓ Glucocorticoids, androgen and ↓ mineralocorticoid
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
Electrolyte abnormalities:   (High Yield)
Hyperkalemia
Hyponatremia
Metabolic acidosis
Hypoglycemia (caused by cortisol deficiency)
Diagnosis:
Short ACTH-stimulation Test:  It involves administration of 250
µg ACTH by IM injection at any time of day.
Normal = cortisol increase> 500 nmol/1 (> 18 µg/dL)

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

![Adrenal Insufficiency - Clinical Figure 1](/lessons/images/endocrine-physiology-metabolism/adrenal-insufficiency/figure_01_p3.png)
*Adrenal Insufficiency — Clinical Figure 1 (Page 3 Reference)*',
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

  -- Lesson: Adrenal Medulla and Pheochromocytoma (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'adrenal-medulla-and-pheochromocytoma',
    'Adrenal Medulla and Pheochromocytoma',
    'article',
    'Adrenal medulla
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

![Adrenal Medulla and Pheochromocytoma - Clinical Figure 1](/lessons/images/endocrine-physiology-metabolism/adrenal-medulla-and-pheochromocytoma/figure_01_p1.png)
*Adrenal Medulla and Pheochromocytoma — Clinical Figure 1 (Page 1 Reference)*

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
unopposed a-mediated vasoconstriction.',
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

  -- Lesson: Aldosterone (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'aldosterone',
    'Aldosterone',
    'article',
    'Aldosterone
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

Ultimately, these effects →  ↑ blood pressure, hypokalemia
and ↑ pH level',
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

  -- Lesson: Antidiuretic Harmone (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'antidiuretic-harmone',
    'Antidiuretic Harmone',
    'article',
    'Antidiuretic hormone (ADH)
Antidiuretic hormone (ADH), also known as vasopressin, is a
small peptide hormone which regulates the body''s retention
of water. The synthesis of ADH occurs in the supraoptic and
paraventricular nuclei in the hypothalamus. It is then
transported to the posterior pituitary gland via the
neurohypophysial capillaries.
ADH regulates the blood pressure (v1 receptors) and serum
osmolality (v2 receptor). The primary function is serum
osmolality regulation (ADH decreases serum osmolality and
increases urine osmolality) via regulation of aquaporin
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

Clinical relevance
Elevated in SIADH despite plasma hypoosmolality.
ADH deficiency or resistance can lead to diabetes insipidus.
Alcohol inhibits ADH release and causes diuresis.

![Antidiuretic Harmone - Clinical Figure 1](/lessons/images/endocrine-physiology-metabolism/antidiuretic-harmone/figure_01_p2.png)
*Antidiuretic Harmone — Clinical Figure 1 (Page 2 Reference)*',
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

  -- Lesson: Calcitonin (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'calcitonin',
    'Calcitonin',
    'article',
    'Calcitonin:
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
hormone that acts to increase serum calcium concentration.',
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

  -- Lesson: Calcium Homeostasis (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'calcium-homeostasis',
    'Calcium Homeostasis',
    'article',
    'Calcium homeostasis
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

Ionized calcium: the calcium fraction that is not bound to
any proteins but is physiologically active 45% of the total
serum calcium.
Functions as the main regulator of PTH secretion
Excess causes true hypercalcemia whereas deficiency
causes true hypocalcemia.',
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

  -- Lesson: Cartisol (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cartisol',
    'Cartisol',
    'article',
    'Cortisol
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
cortisol production in adrenal zona fasciculata. Excess cortisol
↓ CRH, ACTH, and cortisol secretion by negative feedback
mechanism',
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

  -- Lesson: Cushing Syndrome (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'cushing-syndrome',
    'Cushing Syndrome',
    'article',
    'Cushing syndrome
It is a disorder caused by any condition that produces
excessive glucocorticoids (cortisol). While the term "Cushing
syndrome" can be applied to any cause of hypercortisolism,
"Cushing disease" refers specifically to secondary
hypercortisolism that results from excessive production of
ACTH by pituitary adenomas.
causes
Iatrogenic Cushing''s syndrome (most common cause)
caused by exogenous administration of glucocorticoids.
Endogenous: Cushing''s disease (i.e., Cushing''s syndrome
secondary to pituitary tumor): Pituitary adenoma ACTH
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

♂ : Decreased libido
♀ : Decreased libido, virilization, and/or irregular menstrual
cycles (e.g., amenorrhea)
Growth delay (in children)
Note: In Cushing disease: often hyperpigmentation (darkening
of the skin due to an overproduction of melanin), especially in
areas that are not normally exposed to the sun (e.g., palm
creases, oral cavity) Overproduction of melanin Caused by
excessive ACTH production because melanocyte-stimulating
hormone (MSH) is cleaved from the same precursor as ACTH
called proopiomelanocortin (POMC)
Treatment
First-line treatment: tumor resection (Life-long
glucocorticoid + mineralocorticoid replacement after
surgery)
Second-line or adjunctive therapy: pharmacological
treatment

![Cushing Syndrome - Clinical Figure 1](/lessons/images/endocrine-physiology-metabolism/cushing-syndrome/figure_01_p3.png)
*Cushing Syndrome — Clinical Figure 1 (Page 3 Reference)*',
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

  -- Lesson: Diabetes Insipidus and Siadh (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'diabetes-insipidus-and-siadh',
    'Diabetes Insipidus and Siadh',
    'article',
    'Diabetes insipidus (DI):
It is a condition characterized by inability to produce
concentrated urine due to ADH dysfunction, It is of two types:
Central Diabetes Insipidus (CDI)
Nephrogenic Diabetes Insipidus (NDI)
Central Diabetes insipidus
It is due to deficiency of ADH. It may be caused by:
Head trauma
Tumors of hypothalamus
Inflammation of hypothalamus
Craniopharyngioma
Nephrogenic Diabetes insipidus It is due to
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
nephrogenic DI, as nephrogenic DI shows an inability to concentrate urine even after administration of synthetic

## Adh.

Treatment
Central DI = Desmopressin (ADH analogue)
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
Demeclocycline: ADH receptor antagonist.',
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

  -- Lesson: Endocrine Glands and Their Harmones (4 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'endocrine-glands-and-their-harmones',
    'Endocrine Glands and Their Harmones',
    'article',
    'Endocrine System
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

Endocrinology hormones overview:
Harmons secreted by adrenal gland:

![Endocrine Glands and Their Harmones - Clinical Figure 1](/lessons/images/endocrine-physiology-metabolism/endocrine-glands-and-their-harmones/figure_01_p2.png)
*Endocrine Glands and Their Harmones — Clinical Figure 1 (Page 2 Reference)*

Hormone secreted by Gonads.
Hormone secreted by other organs.

![Endocrine Glands and Their Harmones - Clinical Figure 2](/lessons/images/endocrine-physiology-metabolism/endocrine-glands-and-their-harmones/figure_02_p3.png)
*Endocrine Glands and Their Harmones — Clinical Figure 2 (Page 3 Reference)*

![Endocrine Glands and Their Harmones - Clinical Figure 3](/lessons/images/endocrine-physiology-metabolism/endocrine-glands-and-their-harmones/figure_03_p3.png)
*Endocrine Glands and Their Harmones — Clinical Figure 3 (Page 3 Reference)*

![Endocrine Glands and Their Harmones - Clinical Figure 4](/lessons/images/endocrine-physiology-metabolism/endocrine-glands-and-their-harmones/figure_04_p4.png)
*Endocrine Glands and Their Harmones — Clinical Figure 4 (Page 4 Reference)*',
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

  -- Lesson: Hyperaldosteronism and Renal Insufficiency (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'hyperaldosteronism-and-renal-insufficiency',
    'Hyperaldosteronism and Renal Insufficiency',
    'article',
    'Hyperaldosteronism
It is a small group of disorders characterized by excessive
secretion of aldosterone (mineralocorticoid).
It is classified into primary and secondary
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
Spironolactone:  It is an aldosterone antagonist used to
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

Lab Findings:
Elevated aldosterone
Elevated plasma renin
Treatment:
Spironolactone',
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

  -- Lesson: Hypothyroidism and Hyperthyroidism (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'hypothyroidism-and-hyperthyroidism',
    'Hypothyroidism and Hyperthyroidism',
    'article',
    'Hypothyroidism and
Hyperthyroidism:

![Hypothyroidism and Hyperthyroidism - Clinical Figure 1](/lessons/images/endocrine-physiology-metabolism/hypothyroidism-and-hyperthyroidism/figure_01_p2.png)
*Hypothyroidism and Hyperthyroidism — Clinical Figure 1 (Page 2 Reference)*

Note: Propranolol is the preferred agent in hyperthyroidism
and thyroid storm due to its additional effect of blocking the
peripheral conversion of inactive T4 to active form T3. They are
highly effective for symptomatic relief (tachycardia, tremors)',
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

  -- Lesson: Insulin and Glucagon (3 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'insulin-and-glucagon',
    'Insulin and Glucagon',
    'article',
    'Insulin
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

![Insulin and Glucagon - Clinical Figure 1](/lessons/images/endocrine-physiology-metabolism/insulin-and-glucagon/figure_01_p2.png)
*Insulin and Glucagon — Clinical Figure 1 (Page 2 Reference)*

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

![Insulin and Glucagon - Clinical Figure 2](/lessons/images/endocrine-physiology-metabolism/insulin-and-glucagon/figure_02_p3.png)
*Insulin and Glucagon — Clinical Figure 2 (Page 3 Reference)*

![Insulin and Glucagon - Clinical Figure 3](/lessons/images/endocrine-physiology-metabolism/insulin-and-glucagon/figure_03_p4.png)
*Insulin and Glucagon — Clinical Figure 3 (Page 4 Reference)*',
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

  -- Lesson: Pancreas (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'pancreas',
    'Pancreas',
    'article',
    'Pancreas
The pancreas is a retroperitoneal, abdominal organ found
posterior and inferior to the stomach The pancreas has two
essential and very important functions in the body:
endocrine (production of hormones that regulate blood
sugar levels and glandular secretion) and exocrine (the
function of the digestive gland).
Endocrine activity is performed by the Langerhans islets and
involves the production of hormones. The Islets of
Langerhans contain the following cell types, each of which
produce different endocrine hormone.

![Pancreas - Clinical Figure 1](/lessons/images/endocrine-physiology-metabolism/pancreas/figure_01_p1.png)
*Pancreas — Clinical Figure 1 (Page 1 Reference)*',
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

  -- Lesson: Parathyroid Harmone (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'parathyroid-harmone',
    'Parathyroid Harmone',
    'article',
    'Parathyroid hormone (PTH)
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
is cAMP.
Bone: PTH increases bone resorption, which brings both Ca²+
and phosphate from bone mineral into the ECF (Stimulate
the osteoclast cells)
kidney
Increases Ca2+ reabsorption in the distal tubule.
Decreases phosphate reabsorption in the proximal
convoluted tubules.
Increases active vitamin D (calcitriol) production via
stimulation of 1-alpha-hydroxylase synthesis in the kidneys.
GIT

PTH increases intestinal Ca+ and phosphate absorption,
indirectly by stimulating the production of 1,25-
dihydroxycholecalciferol in the kidney.',
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

  -- Lesson: Pituitary Gland (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'pituitary-gland',
    'Pituitary Gland',
    'article',
    'Pituitary gland
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

#### Anterior lobe of pituitary

gland
The anterior pituitary is derived from oral ectoderm (Rathke''s
pouch). The anterior lobe of pituitary gland is linked to
hypothalamus by the hypothalamic-pituitary hypophysial portal system. Thus, blood from hypothalamus that contain
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

#### Anterior pituitary hormone

Posterior pituitary gland (neurohypophysis)
The posterior lobe of pituitary gland arises from an evagination
of neuroectoderm from diencephalon. It stores and releases
vasopressin (antidiuretic hormone or ADH) and oxytocin,
both made in hypothalamus (supra optic nuclei and
paraventricular nuclei) and transported to posterior pituitary
via neurophysins (carrier protein)

![Pituitary Gland - Clinical Figure 1](/lessons/images/endocrine-physiology-metabolism/pituitary-gland/figure_01_p2.png)
*Pituitary Gland — Clinical Figure 1 (Page 2 Reference)*

Hormones of posterior pituitary gland

![Pituitary Gland - Clinical Figure 2](/lessons/images/endocrine-physiology-metabolism/pituitary-gland/figure_02_p3.png)
*Pituitary Gland — Clinical Figure 2 (Page 3 Reference)*',
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

  -- Lesson: Thyroid Gland (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'thyroid-gland',
    'Thyroid Gland',
    'article',
    'Thyroid gland
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

![Thyroid Gland - Clinical Figure 1](/lessons/images/endocrine-physiology-metabolism/thyroid-gland/figure_01_p1.png)
*Thyroid Gland — Clinical Figure 1 (Page 1 Reference)*

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

Brain maturation
Bone growth (synergism with GH)
B-adrenergic effects. ↑ B ₁  receptors in heart→ ↑ CO, HR, SV,
contractility (B-blockers alleviate adrenergic symptoms in
thyrotoxicosis)
Basal metabolic rate ↑ (Via Na/K+-ATPase activity →  ↑    0 ₂
consumption, RR, body temperature
Blood sugar (increase glycogenolysis, gluconeogenesis)
Breakdown of lipids increase lipolysis.
Stimulates surfactant synthesis in babies.',
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

  -- Lesson: Vitamin - D Synthesis (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'vitamin-d-synthesis',
    'Vitamin - D Synthesis',
    'article',
    'Vitamin D synthesis
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

![Vitamin - D Synthesis - Clinical Figure 1](/lessons/images/endocrine-physiology-metabolism/vitamin-d-synthesis/figure_01_p1.png)
*Vitamin - D Synthesis — Clinical Figure 1 (Page 1 Reference)*

dihydroxyvitamin D biosynthesis',
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

  -- ==========================================================================
  -- Module 14: Blood Physiology & Coagulation Pathways (8 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Blood Physiology & Coagulation Pathways' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Blood Physiology & Coagulation Pathways', 13, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 13, "updated_at" = now() WHERE "id" = v_module_id;
  END IF;

  -- Lesson: Acquired Coagulation Disorder of Blood (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'acquired-coagulation-disorder-of-blood',
    'Acquired Coagulation Disorder of Blood',
    'article',
    'Acquired coagulation disorder:

### 1: Vitamin K Deficiency

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
Lab values of Disseminated intravascular.

![Acquired Coagulation Disorder of Blood - Clinical Figure 1](/lessons/images/blood-physiology-coagulation-pathways/acquired-coagulation-disorder-of-blood/figure_01_p1.png)
*Acquired Coagulation Disorder of Blood — Clinical Figure 1 (Page 1 Reference)*

Low platelet count
Low fibrinogen concentration
Prolonged PT
Prolonged PT
Prolonged APTT
High levels of D-Dimers
Features of hemolysis
Coagulation tests:

![Acquired Coagulation Disorder of Blood - Clinical Figure 2](/lessons/images/blood-physiology-coagulation-pathways/acquired-coagulation-disorder-of-blood/figure_02_p2.png)
*Acquired Coagulation Disorder of Blood — Clinical Figure 2 (Page 2 Reference)*',
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

  -- Lesson: Antiplatelet and Anticoagulant Drugs (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'antiplatelet-and-anticoagulant-drugs',
    'Antiplatelet and Anticoagulant Drugs',
    'article',
    'Antiplatelet and anticoagulant
drugs

![Antiplatelet and Anticoagulant Drugs - Clinical Figure 1](/lessons/images/blood-physiology-coagulation-pathways/antiplatelet-and-anticoagulant-drugs/figure_01_p1.png)
*Antiplatelet and Anticoagulant Drugs — Clinical Figure 1 (Page 1 Reference)*',
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

  -- Lesson: Haemoglobin (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'haemoglobin',
    'Haemoglobin',
    'article',
    'Haemoglobin
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

![Haemoglobin - Clinical Figure 1](/lessons/images/blood-physiology-coagulation-pathways/haemoglobin/figure_01_p2.png)
*Haemoglobin — Clinical Figure 1 (Page 2 Reference)*',
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

  -- Lesson: Haemostasis (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'haemostasis',
    'Haemostasis',
    'article',
    'Haemostasis
Prevention of blood loss
Stages of haemostasis: Three stages
Vasoconstriction
Platelet plug formation.
Coagulation of blood

![Haemostasis - Clinical Figure 1](/lessons/images/blood-physiology-coagulation-pathways/haemostasis/figure_01_p1.png)
*Haemostasis — Clinical Figure 1 (Page 1 Reference)*',
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

  -- Lesson: Heriditary Coagulation Disorder of Blood (1 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'heriditary-coagulation-disorder-of-blood',
    'Heriditary Coagulation Disorder of Blood',
    'article',
    'Coagulation disorder
Hereditary coagulation disorder:

![Heriditary Coagulation Disorder of Blood - Clinical Figure 1](/lessons/images/blood-physiology-coagulation-pathways/heriditary-coagulation-disorder-of-blood/figure_01_p1.png)
*Heriditary Coagulation Disorder of Blood — Clinical Figure 1 (Page 1 Reference)*',
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

  -- Lesson: Platelate and Platelate Plug (0 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'platelate-and-platelate-plug',
    'Platelate and Platelate Plug',
    'article',
    'Platelets and platelet plug
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

Plasmin:  It breaks already formed clot.
Released by all the tissues.
Convert the inactive plasminogen to plasmin.',
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

  -- Lesson: Plateletes Bleeding Disorder (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'plateletes-bleeding-disorder',
    'Plateletes Bleeding Disorder',
    'article',
    'Platelets bleeding disorder
Thrombocytopenia or abnormal platelet function is
characterized by spontaneous skin purpura, mucosal
haemorrhage and prolonged bleeding after trauma.
Important to note here difference between
TTP and haemolytic uremic syndrome.
Note: Difference between TTP and haemolytic uremic
syndrome

![Plateletes Bleeding Disorder - Clinical Figure 1](/lessons/images/blood-physiology-coagulation-pathways/plateletes-bleeding-disorder/figure_01_p1.png)
*Plateletes Bleeding Disorder — Clinical Figure 1 (Page 1 Reference)*

![Plateletes Bleeding Disorder - Clinical Figure 2](/lessons/images/blood-physiology-coagulation-pathways/plateletes-bleeding-disorder/figure_02_p1.png)
*Plateletes Bleeding Disorder — Clinical Figure 2 (Page 1 Reference)*',
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

  -- Lesson: Sites of Haemopoiesis (2 images)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'sites-of-haemopoiesis',
    'Sites of Haemopoiesis',
    'article',
    'Haemopoiesis Sites:
Important to remember:
Haemopoietic Stem Cells: All blood cells
develop from Haemopoietic Stem Cells

![Sites of Haemopoiesis - Clinical Figure 1](/lessons/images/blood-physiology-coagulation-pathways/sites-of-haemopoiesis/figure_01_p1.png)
*Sites of Haemopoiesis — Clinical Figure 1 (Page 1 Reference)*

![Sites of Haemopoiesis - Clinical Figure 2](/lessons/images/blood-physiology-coagulation-pathways/sites-of-haemopoiesis/figure_02_p1.png)
*Sites of Haemopoiesis — Clinical Figure 2 (Page 1 Reference)*',
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
  -- Module 15: Respiratory Pharmacology & Asthma Management (5 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Respiratory Pharmacology & Asthma Management' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Respiratory Pharmacology & Asthma Management', 14, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 14, "updated_at" = now() WHERE "id" = v_module_id;
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
    '- Anaphylaxis
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
    'Anti histamine:
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
    'Levels of severity of acute asthma
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
    'Bronchodilator therapy:
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
    'Corticosteroids:
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
  -- Module 16: Cardiovascular Pharmacology & Anticoagulants (8 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Cardiovascular Pharmacology & Anticoagulants' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Cardiovascular Pharmacology & Anticoagulants', 15, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 15, "updated_at" = now() WHERE "id" = v_module_id;
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
    'Anti-platelet, Statins, nitrate and
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
    'Antiplatelet and anticoagulant
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
    'Basic life support and Advanced life
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
    'Beta blockers and calcium channel
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
    'Definition
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
    'Digoxin
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
    'Hypertensive Emergency
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
    'Tachycardias
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
  -- Module 17: CNS Pharmacology & Analgesia (7 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'CNS Pharmacology & Analgesia' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'CNS Pharmacology & Analgesia', 16, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 16, "updated_at" = now() WHERE "id" = v_module_id;
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
    'Analgesics:
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
    'Anti-psychotics
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
    'Antiemetics drug class, Members and
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
    'Anti-epileptic drugs
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
    'Lithium:
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
    'Status epilepticus management

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
    'Tri-cyclic antidepressants:
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
  -- Module 18: Anesthesia & Sedation Drugs (1 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Anesthesia & Sedation Drugs' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Anesthesia & Sedation Drugs', 17, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 17, "updated_at" = now() WHERE "id" = v_module_id;
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
    'Benzodiazepines and Muscle relaxants:
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
  -- Module 19: Emergency Toxicology & Antidotes (3 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Emergency Toxicology & Antidotes' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Emergency Toxicology & Antidotes', 18, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 18, "updated_at" = now() WHERE "id" = v_module_id;
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
    '![Drugs Toxicity and Antidotes - Clinical Figure 1](/lessons/images/emergency-toxicology-antidotes/drugs-toxicity-and-antidotes/figure_01_p1.png)
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
    'Poisoning and overdose
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
    'Summary Of Drugs And Their Side
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

  -- ==========================================================================
  -- Module 20: General Pathology, Inflammation & Anemia (11 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'General Pathology, Inflammation & Anemia' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'General Pathology, Inflammation & Anemia', 19, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 19, "updated_at" = now() WHERE "id" = v_module_id;
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
  -- Module 21: Clinical Microbiology, Bacteria & Antibiotics (22 lessons)
  -- ==========================================================================
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Clinical Microbiology, Bacteria & Antibiotics' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" ("id", "course_id", "title", "position", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_course_id, 'Clinical Microbiology, Bacteria & Antibiotics', 20, now(), now())
    RETURNING "id" INTO v_module_id;
  ELSE
    UPDATE "modules" SET "position" = 20, "updated_at" = now() WHERE "id" = v_module_id;
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

  RAISE NOTICE 'Successfully seeded MRCEM Primary: Complete Flagship Masterclass (221 lessons, 269 images)';
END $$;
