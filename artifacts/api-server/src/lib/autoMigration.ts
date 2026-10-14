import { pool } from "@workspace/db";
import { logger } from "./logger";

const MEMBERSHIP_TABLES_SQL = `
CREATE TABLE IF NOT EXISTS "plans" (
  "id"                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "exam_id"           uuid REFERENCES "exams"("id") ON DELETE SET NULL,
  "slug"              text NOT NULL,
  "name"              text NOT NULL,
  "description"       text NOT NULL DEFAULT '',
  "features"          jsonb NOT NULL DEFAULT '[]',
  "access_months"     integer NOT NULL,
  "trial_days"        integer NOT NULL DEFAULT 0,
  "is_placeholder"    boolean NOT NULL DEFAULT false,
  "family_key"        text,
  "family_name"       text,
  "is_featured"       boolean NOT NULL DEFAULT false,
  "stripe_product_id" text,
  "position"          integer NOT NULL DEFAULT 0,
  "status"            text NOT NULL DEFAULT 'draft',
  "created_at"        timestamptz NOT NULL DEFAULT now(),
  "updated_at"        timestamptz NOT NULL DEFAULT now(),
  "deleted_at"        timestamptz
);
CREATE UNIQUE INDEX IF NOT EXISTS "plans_slug_uq" ON "plans"("slug");
CREATE INDEX IF NOT EXISTS "plans_exam_status_idx" ON "plans"("exam_id", "status");

CREATE TABLE IF NOT EXISTS "plan_prices" (
  "id"              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "plan_id"         uuid NOT NULL REFERENCES "plans"("id") ON DELETE CASCADE,
  "currency"        text NOT NULL,
  "region"          text NOT NULL DEFAULT 'ALL',
  "amount_minor"    integer NOT NULL,
  "stripe_price_id" text,
  "created_at"      timestamptz NOT NULL DEFAULT now(),
  "updated_at"      timestamptz NOT NULL DEFAULT now()
);
CREATE UNIQUE INDEX IF NOT EXISTS "plan_prices_plan_currency_region_uq" ON "plan_prices"("plan_id","currency","region");
CREATE INDEX IF NOT EXISTS "plan_prices_plan_idx" ON "plan_prices"("plan_id");

CREATE TABLE IF NOT EXISTS "plan_courses" (
  "id"         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "plan_id"    uuid NOT NULL REFERENCES "plans"("id") ON DELETE CASCADE,
  "course_id"  uuid NOT NULL REFERENCES "courses"("id") ON DELETE CASCADE,
  "created_at" timestamptz NOT NULL DEFAULT now(),
  "updated_at" timestamptz NOT NULL DEFAULT now()
);
CREATE UNIQUE INDEX IF NOT EXISTS "plan_courses_plan_course_uq" ON "plan_courses"("plan_id","course_id");
CREATE INDEX IF NOT EXISTS "plan_courses_course_idx" ON "plan_courses"("course_id");

CREATE TABLE IF NOT EXISTS "course_entitlements" (
  "id"         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "user_id"    text NOT NULL REFERENCES "users"("id") ON DELETE CASCADE,
  "course_id"  uuid NOT NULL REFERENCES "courses"("id") ON DELETE CASCADE,
  "plan_id"    uuid REFERENCES "plans"("id") ON DELETE SET NULL,
  "granted_by" text REFERENCES "users"("id") ON DELETE SET NULL,
  "starts_at"  timestamptz NOT NULL DEFAULT now(),
  "ends_at"    timestamptz,
  "revoked_at" timestamptz,
  "created_at" timestamptz NOT NULL DEFAULT now(),
  "updated_at" timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS "course_entitlements_user_course_idx" ON "course_entitlements"("user_id","course_id");
CREATE INDEX IF NOT EXISTS "course_entitlements_course_user_idx" ON "course_entitlements"("course_id","user_id");
`;

const UPPER_LIMB_SEED_SQL = `
DO $$
DECLARE
  v_exam_id uuid;
  v_course_id uuid;
  v_module_id uuid;
  v_primary_plan_id uuid;
  v_all_access_plan_id uuid;
  v_whatsapp_plan_id uuid;
BEGIN
  -- 1. Locate the MRCEM Primary exam
  SELECT id INTO v_exam_id FROM "exams" WHERE "slug" = 'mrcem-primary' LIMIT 1;

  -- 2. Create or update the Course
  SELECT id INTO v_course_id FROM "courses" WHERE "slug" = 'mrcem-upper-limb' LIMIT 1;
  IF v_course_id IS NULL THEN
    INSERT INTO "courses" (
      "id",
      "exam_id",
      "slug",
      "title",
      "summary",
      "description",
      "is_free",
      "position",
      "status",
      "created_at",
      "updated_at"
    ) VALUES (
      gen_random_uuid(),
      v_exam_id,
      'mrcem-upper-limb',
      'MRCEM Primary: Upper Limb Anatomy',
      'High-yield clinical anatomy of the upper limb tailored for MRCEM Primary candidates.',
      'Comprehensive upper limb anatomy covering the brachial plexus, peripheral nerves, muscle compartments, vasculature, lymphatic drainage, joints, dermatomes, and clinical pearls.',
      false,
      1,
      'published',
      now(),
      now()
    ) RETURNING "id" INTO v_course_id;
  ELSE
    UPDATE "courses"
    SET
      "title" = 'MRCEM Primary: Upper Limb Anatomy',
      "exam_id" = COALESCE(v_exam_id, "exam_id"),
      "summary" = 'High-yield clinical anatomy of the upper limb tailored for MRCEM Primary candidates.',
      "description" = 'Comprehensive upper limb anatomy covering the brachial plexus, peripheral nerves, muscle compartments, vasculature, lymphatic drainage, joints, dermatomes, and clinical pearls.',
      "status" = 'published',
      "updated_at" = now()
    WHERE "id" = v_course_id;
  END IF;

  -- 3. Create or find the Module: Upper Limb Anatomy
  SELECT id INTO v_module_id FROM "modules" WHERE "course_id" = v_course_id AND "title" = 'Upper Limb Anatomy' AND "deleted_at" IS NULL LIMIT 1;
  IF v_module_id IS NULL THEN
    INSERT INTO "modules" (
      "id",
      "course_id",
      "title",
      "position",
      "created_at",
      "updated_at"
    ) VALUES (
      gen_random_uuid(),
      v_course_id,
      'Upper Limb Anatomy',
      0,
      now(),
      now()
    ) RETURNING "id" INTO v_module_id;
  END IF;

  -- 4. Upsert Lesson 1: Brachial plexus and nerves of the upper limb (Free preview)
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'brachial-plexus-nerves',
    'Brachial plexus and nerves of the upper limb',
    'article',
    $lesson_body$## Brachial plexus: the building blocks

The plexus is built in five steps: roots, trunks, divisions, cords, branches. Mnemonic: Randy Travis Drinks Cold Beer.

- **Roots:** anterior rami of C5, C6, C7, C8 and T1.
- **Trunks:** upper (C5-C6), middle (C7), lower (C8-T1), formed at the base of the neck.
- **Divisions:** each trunk splits into an anterior and a posterior division behind the clavicle.
- **Cords:** named by their position around the axillary artery. Lateral cord = anterior divisions of upper and middle trunks. Medial cord = anterior division of lower trunk. Posterior cord = posterior divisions of all three trunks.

## Branches by cord

- **Lateral cord (LML):** Lateral pectoral, Musculocutaneous, Lateral root of median.
- **Medial cord (M4U):** Medial pectoral, Medial cutaneous nerve of arm, Medial cutaneous nerve of forearm, Medial root of median, Ulnar.
- **Posterior cord (ULTRA):** Upper subscapular, Lower subscapular, Thoracodorsal, Radial, Axillary.

## Plexus injuries

- **Upper trunk (C5-C6), Erb-Duchenne palsy:** the arm hangs adducted and medially rotated, the forearm is pronated, the wrist is flexed ("waiter's tip"). Typical causes are traction injuries such as shoulder dystocia or a fall on the shoulder.
- **Lower trunk (C8-T1), Klumpke palsy:** weak small muscles of the hand and a claw hand. Horner syndrome can accompany it if T1 sympathetic fibres are involved. Think hyperabduction injury or a Pancoast tumour.

## Axillary nerve (C5-C6, posterior cord)

- Motor: deltoid and teres minor.
- Sensory: skin over the lower deltoid (the "regimental badge" area).
- Course: leaves the axilla through the quadrangular space with the posterior circumflex humeral artery and wraps around the surgical neck of the humerus.
- Injured by: fracture of the surgical neck or anterior shoulder dislocation.
- Findings: weak abduction beyond the first 15 degrees (supraspinatus still starts abduction), flattened shoulder contour, loss of sensation over the badge area.

## Median nerve (C5-T1, medial and lateral cords)

- **Forearm motor:** all flexors and pronators except flexor carpi ulnaris and the medial half of flexor digitorum profundus (both ulnar).
- **Anterior interosseous branch:** flexor pollicis longus, lateral half of FDP, pronator quadratus.
- **Hand motor (LOAF):** Lateral two Lumbricals, Opponens pollicis, Abductor pollicis brevis, Flexor pollicis brevis.
- **Sensory:** palm and palmar surface of the lateral three and a half digits. The palmar cutaneous branch leaves before the carpal tunnel.
- **Carpal tunnel syndrome:** numbness, tingling and pain in the median distribution, thenar wasting later on. The palm is usually spared because the palmar cutaneous branch does not pass through the tunnel.

**Lesion at the elbow** (for example supracondylar fracture): weak pronation and wrist flexion, loss of thumb flexion and of index and middle finger flexion. On trying to make a fist only the ring and little fingers curl: the "hand of benediction". Ring and little finger flexion survives because the medial FDP and medial lumbricals are ulnar.

**Lesion at the wrist** (for example a laceration): paralysis of the thenar muscles and lateral two lumbricals, thenar wasting, weak thumb opposition. Forearm muscles are spared.

## Radial nerve (C5-T1, posterior cord)

- **Motor:** triceps, anconeus, brachioradialis and all extensors of the forearm, plus supinator.
- **Course:** behind the axillary artery, then through the triceps in the radial groove with the profunda brachii artery, pierces the lateral intermuscular septum, passes between brachialis and brachioradialis into the cubital fossa, and divides into a superficial (sensory) and a deep (motor, continues as posterior interosseous nerve) branch.
- **Sensory:** back of the arm and forearm, and the back of the lateral three and a half digits (excluding the fingertips).
- **Wrist drop** is the classic sign of injury.

Where it is injured matters:
- **Axilla or proximal humerus** (crutches, "Saturday night palsy"): triceps is weak as well as wrist drop.
- **Mid-shaft humeral fracture:** triceps is spared, wrist drop and sensory loss over the back of the hand.
- **Posterior interosseous nerve** (radial head fracture or dislocation): finger drop but wrist extension survives because ECRL is spared, and there is no sensory loss.

## Ulnar nerve (C8-T1, medial cord)

- **Forearm motor:** flexor carpi ulnaris and medial half of FDP.
- **Hand motor:** hypothenar muscles, medial two lumbricals, all interossei, adductor pollicis, palmaris brevis.
- **Sensory:** medial one and a half digits, the hypothenar area and the medial back of the hand.
- **Course:** down the medial arm, pierces the medial intermuscular septum, passes behind the medial epicondyle (cubital tunnel, "funny bone"), between the two heads of FCU, then enters the hand superficial to the flexor retinaculum and lateral to the pisiform (Guyon canal).
- **Claw hand:** ring and little fingers hyperextended at the MCP joints and flexed at the IP joints. Paradox: a lesion at the wrist gives a more obvious claw than a lesion at the elbow, because at the elbow the medial FDP is also paralysed.
- **Froment sign:** the patient holds paper between thumb and index finger. When it is pulled away, the thumb IP joint flexes (flexor pollicis longus, median nerve) to compensate for the paralysed adductor pollicis.

## Musculocutaneous nerve (C5-C7, lateral cord)

- Pierces coracobrachialis and runs between biceps and brachialis.
- Motor: coracobrachialis, biceps brachii, brachialis (the anterior compartment of the arm).
- Sensory: lateral forearm, through the lateral cutaneous nerve of the forearm.
- Injury: weak elbow flexion and supination, absent biceps reflex, sensory loss over the lateral forearm. Brachioradialis (radial nerve) can still flex the elbow.

## Autonomous sensory zones (quick exam recall)

- Median: tip of the index finger.
- Ulnar: tip of the little finger.
- Radial: the skin over the first dorsal web space.$lesson_body$,
    true,
    0,
    'published',
    now(),
    now()
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = EXCLUDED."status",
    "updated_at" = now();

  -- 5. Upsert Lesson 2: Muscles of the upper limb
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'muscles-upper-limb',
    'Muscles of the upper limb',
    'article',
    $lesson_body$## Anterior forearm (flexors and pronators)

All arise mainly from the common flexor origin on the medial epicondyle. Nerve supply: **median nerve, except flexor carpi ulnaris and the medial half of flexor digitorum profundus (ulnar)**.

- **Superficial layer:** pronator teres (pronation), flexor carpi radialis (wrist flexion and abduction), palmaris longus (wrist flexion, tenses palmar aponeurosis), flexor carpi ulnaris (wrist flexion and adduction, ulnar nerve).
- **Intermediate layer:** flexor digitorum superficialis, flexes the PIP joints of the four fingers (inserts on the middle phalanges).
- **Deep layer:** flexor digitorum profundus (flexes the DIP joints, inserts on the distal phalanges, dual supply), flexor pollicis longus (flexes the thumb IP joint), pronator quadratus (pronation).

## Posterior forearm (extensors and supinator)

All supplied by the **radial nerve** (the deep ones by its posterior interosseous branch).

- **Superficial:** brachioradialis (flexes the elbow, best in mid-prone position), extensor carpi radialis longus and brevis (extend and abduct the wrist), extensor digitorum, extensor digiti minimi, extensor carpi ulnaris (extends and adducts the wrist), anconeus (assists triceps).
- **Deep:** supinator, abductor pollicis longus, extensor pollicis brevis, extensor pollicis longus, extensor indicis.

## Arm

- **Anterior compartment, musculocutaneous nerve:** biceps brachii (flexes the elbow and supinates the forearm), brachialis (main elbow flexor), coracobrachialis (flexes and adducts the arm).
- **Posterior compartment, radial nerve:** triceps brachii (extends the elbow, long head also extends the shoulder).

## Hand

- **Thenar muscles (median nerve, recurrent branch):** abductor pollicis brevis, flexor pollicis brevis, opponens pollicis. Adductor pollicis is supplied by the ulnar nerve.
- **Hypothenar muscles (ulnar nerve):** abductor digiti minimi, flexor digiti minimi brevis, opponens digiti minimi. They form the bulge on the ulnar side of the palm, at the base of the little finger.
- **Lumbricals:** arise from the FDP tendons, flex the MCP joints and extend the IP joints. Lateral two = median nerve, medial two = ulnar nerve.
- **Interossei (all ulnar nerve):** Dorsal interossei ABduct the fingers, Palmar interossei ADduct them (DAB, PAD). Both flex the MCP joints and extend the IP joints.

## Shoulder region

**Extrinsic muscles** (link the limb to the trunk):
- Trapezius: spinal accessory nerve (CN XI). Elevates and rotates the scapula.
- Latissimus dorsi: thoracodorsal nerve (C6-C8). Extends, adducts and medially rotates the arm.
- Levator scapulae: dorsal scapular nerve and C3-C4.
- Rhomboid major and minor: dorsal scapular nerve (C4-C5). Retract the scapula.

**Intrinsic muscles** (link the scapula to the humerus):
- Deltoid: axillary nerve (C5-C6). Abducts the arm (anterior fibres flex, posterior fibres extend).
- Teres major: lower subscapular nerve. Medially rotates and adducts.
- **Rotator cuff (SITS):** Supraspinatus (suprascapular nerve, starts abduction in the first 15 degrees), Infraspinatus (suprascapular nerve, lateral rotation), Teres minor (axillary nerve, lateral rotation), Subscapularis (upper and lower subscapular nerves, medial rotation). Every cuff muscle is a lateral rotator except subscapularis.

**Rotator cuff tests:**
- Supraspinatus: empty can test (arm elevated 90 degrees in the scapular plane, thumbs down, resist downward pressure).
- Infraspinatus: arm by the side, elbow flexed 90 degrees, resist internal rotation. Pain or weakness is positive.
- Teres minor: Hornblower sign (cannot externally rotate with the arm abducted and the elbow flexed).
- Subscapularis: lift-off test (hand on the lower back, cannot lift it away against resistance).

Supraspinatus is the most commonly injured cuff tendon.

## Pectoral region

- **Pectoralis major:** adducts and medially rotates the arm. Lateral and medial pectoral nerves.
- **Pectoralis minor:** depresses and protracts the scapula (ribs 3-5 to the coracoid). Medial pectoral nerve.
- **Serratus anterior:** holds the scapula against the rib cage and rotates it for overhead abduction. **Long thoracic nerve.**
- **Subclavius:** anchors and depresses the clavicle. Nerve to subclavius.

## Clinical pearls

- **Tennis elbow (lateral epicondylitis):** overuse of the extensor origin on the lateral epicondyle.
- **Golfer's elbow (medial epicondylitis):** overuse of the flexor origin on the medial epicondyle.
- **Nursemaid's elbow:** subluxation of the radial head under the annular ligament when a toddler is pulled by the hand or wrist.
- **Winged scapula:** serratus anterior paralysis from long thoracic nerve injury (for example during axillary surgery).
- **Cannot shrug the shoulder:** trapezius paralysis, spinal accessory nerve injury.$lesson_body$,
    false,
    1,
    'published',
    now(),
    now()
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = EXCLUDED."status",
    "updated_at" = now();

  -- 6. Upsert Lesson 3: Arterial supply of the upper limb
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'arterial-supply-upper-limb',
    'Arterial supply of the upper limb',
    'article',
    $lesson_body$## The main arterial pathway

Subclavian artery, then axillary artery (from the outer border of the first rib to the lower border of teres major), then brachial artery, then it divides into the radial and ulnar arteries at the level of the radial neck in the cubital fossa.

## Axillary artery

It is divided into three parts by pectoralis minor. The axillary vein lies medial to it. Mnemonic: Screw The Lawyers Save A Patient.

- **Part 1:** Superior thoracic artery.
- **Part 2:** Thoracoacromial artery and Lateral thoracic artery.
- **Part 3:** Subscapular artery, Anterior and Posterior circumflex humeral arteries.

The two circumflex humeral arteries form an anastomosis around the surgical neck of the humerus and can be damaged in fractures there.

## Brachial artery

The main supply of the arm. It runs on brachialis and is palpable medial to the biceps tendon in the cubital fossa.

Branches:
- **Profunda brachii:** the largest, travels with the radial nerve in the radial groove and supplies triceps.
- Superior ulnar collateral artery (travels with the ulnar nerve).
- Inferior ulnar collateral artery (elbow anastomosis).
- Muscular branches and the nutrient artery of the humerus.

## Radial artery

- Runs along the lateral forearm under brachioradialis.
- The pulse is felt just lateral to the flexor carpi radialis tendon at the wrist.
- Winds around the wrist, crosses the floor of the anatomical snuffbox and enters the palm between the first and second metacarpals.
- Forms the **deep palmar arch**.

## Ulnar artery

- The larger terminal branch. Runs down the ulnar side of the forearm deep to the superficial flexors.
- Gives off the common interosseous artery.
- Enters the hand through Guyon canal (between the pisiform and the hook of the hamate) with the ulnar nerve.
- Forms the **superficial palmar arch**.

## Palmar arches

- **Superficial arch:** lies just under the palmar aponeurosis, mainly ulnar artery, completed by the superficial palmar branch of the radial artery. Gives the common palmar digital arteries to the fingers.
- **Deep arch:** lies deeper, mainly radial artery, completed by the deep branch of the ulnar artery. Supplies the metacarpals and wrist joint.
- The two arches anastomose, which is why the hand tolerates loss of one artery. The Allen test checks this collateral flow.

## Clinical pearls

- **Volkmann ischaemic contracture:** brachial artery injury or compartment syndrome (classically after a supracondylar fracture in a child) leads to ischaemia and necrosis of the forearm flexors, replaced by fibrosis. The result is a fixed flexion deformity of the wrist and fingers. Warning signs are the "5 Ps": pain on passive stretch, pallor, paraesthesia, paralysis, pulselessness (a late sign).
- **Guyon canal syndrome:** ulnar nerve compression at the wrist. Common causes are a ganglion, lipoma or trauma.$lesson_body$,
    false,
    2,
    'published',
    now(),
    now()
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = EXCLUDED."status",
    "updated_at" = now();

  -- 7. Upsert Lesson 4: Venous drainage of the upper limb
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'venous-drainage-upper-limb',
    'Venous drainage of the upper limb',
    'article',
    $lesson_body$## Superficial veins

They run in the subcutaneous tissue and are the veins you use clinically.

- **Dorsal venous network** on the back of the hand drains laterally into the **cephalic vein** and medially into the **basilic vein**.
- **Cephalic vein:** runs up the lateral side, along the deltopectoral groove, and drains into the axillary vein.
- **Basilic vein:** runs up the medial side, pierces the deep fascia in the arm and joins the brachial veins to form the axillary vein.
- **Median cubital vein:** connects the cephalic to the basilic vein in the cubital fossa. It lies over the bicipital aponeurosis, which separates it from the brachial artery and median nerve. It is the usual site for venepuncture because of this protection.

## Deep veins

- Deep and superficial palmar venous arches accompany the arterial arches.
- In the forearm and arm, the deep veins follow the arteries as paired venae comitantes.
- The brachial veins (comitantes of the brachial artery) are joined by the basilic vein at the lower border of teres major to form the **axillary vein**.
- The axillary vein runs medial to the axillary artery and becomes the **subclavian vein** at the outer border of the first rib.

## Exam points

- Common sites for blood sampling: median cubital vein first, then cephalic and basilic.
- The bicipital aponeurosis is the key landmark protecting the brachial artery during venepuncture.
- A PICC line is usually threaded through the basilic vein or brachial vein, because it is the larger one.$lesson_body$,
    false,
    3,
    'published',
    now(),
    now()
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = EXCLUDED."status",
    "updated_at" = now();

  -- 8. Upsert Lesson 5: Lymphatic drainage of the upper limb and breast
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'lymphatic-drainage-upper-limb-breast',
    'Lymphatic drainage of the upper limb and breast',
    'article',
    $lesson_body$## Principles

- Superficial lymphatics travel with the superficial veins. Deep lymphatics travel with the deep arteries and veins.
- All lymph from the upper limb ends in the **axillary nodes**.

## Node groups

- **Axillary nodes:** drain the whole upper limb, and also the lateral part of the breast, the chest wall and the upper abdominal wall. They are arranged as pectoral (anterior), subscapular (posterior), humeral (lateral), central and apical groups.
- **Infraclavicular (deltopectoral) nodes:** lie between deltoid and pectoralis major beside the cephalic vein. They receive lymph from the superficial vessels along the radial (lateral) side of the hand, forearm and arm.
- **Supratrochlear (cubital) nodes:** lie in the superficial fascia just above the medial epicondyle. They receive lymph from the medial fingers, medial hand and medial forearm. An enlarged, tender supratrochlear node points to infection on that side of the hand or forearm.

## Breast drainage

- **About 75% goes to the axillary nodes:** the lateral and upper quadrants, including the axillary tail.
- **About 20% goes to the parasternal (internal thoracic) nodes:** the medial quadrants. These can also spread to the opposite breast.
- The rest goes to posterior intercostal and other nodes.
- Breast cancer in the axillary tail most often involves the axillary nodes first.

## Clinical pearls

- Sentinel node biopsy or axillary clearance is used to stage breast cancer.
- Surgery risks: **long thoracic nerve** injury causes a winged scapula, **thoracodorsal nerve** injury weakens latissimus dorsi (adduction and medial rotation), and **intercostobrachial nerve** injury causes numbness of the medial upper arm.
- Lymphoedema of the arm can follow axillary clearance or radiotherapy.$lesson_body$,
    false,
    4,
    'published',
    now(),
    now()
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = EXCLUDED."status",
    "updated_at" = now();

  -- 9. Upsert Lesson 6: Joints of the upper limb
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'joints-upper-limb',
    'Joints of the upper limb',
    'article',
    $lesson_body$## Acromioclavicular (AC) joint

- Plane synovial joint between the lateral end of the clavicle and the acromion.
- Ligaments: acromioclavicular ligament, and the **coracoclavicular ligament** (conoid and trapezoid parts). The coracoclavicular ligament is the strongest and suspends the weight of the limb from the clavicle.
- **Shoulder separation:** a heavy fall onto the point of the shoulder can tear the coracoclavicular ligament, and the outer end of the clavicle rides up and becomes easy to palpate.

## Sternoclavicular (SC) joint

- Saddle-type synovial joint between the clavicle, the manubrium and the first costal cartilage. It is the only bony link between the upper limb and the trunk.
- Ligaments: anterior and posterior sternoclavicular, interclavicular, and the strong costoclavicular ligament.
- Force along the clavicle usually breaks the clavicle rather than dislocating this joint. Dislocation is uncommon, and a posterior dislocation is dangerous because of the structures behind the joint.

## Shoulder (glenohumeral) joint

- Ball-and-socket synovial joint: head of the humerus in the glenoid cavity. The most mobile joint in the body, and therefore the least stable.
- **Static stabilisers:** glenoid labrum, joint capsule, glenohumeral ligaments (superior, middle, inferior), coracohumeral ligament, coraco-acromial arch. The transverse humeral ligament holds the long head of biceps in the bicipital groove.
- **Dynamic stabilisers:** the rotator cuff (SITS) and the long head of biceps tendon, which acts as a minor depressor of the humeral head.
- Movements: flexion, extension, abduction, adduction, medial and lateral rotation, circumduction.

**Anterior dislocation** (most common): from forced abduction, extension and external rotation. The arm is held abducted and externally rotated, the humeral head is felt anteriorly, and the patient cannot touch the opposite shoulder. Risks: axillary nerve, axillary artery, rotator cuff.

**Posterior dislocation** (uncommon): from direct force with internal rotation and adduction, and classically from seizures or electric shock. The arm is held adducted and internally rotated, and external rotation is impossible. The X-ray may show the **light bulb sign**.

## Elbow joint

- Hinge synovial joint: ulna (trochlear notch) with the trochlea, and radial head with the capitulum.
- Ligaments: radial (lateral) collateral, ulnar (medial) collateral, annular ligament around the radial head.
- **Posterior dislocation** is the usual type, from a fall on the hand with the elbow flexed. Check the ulnar nerve and brachial artery. In children, a supracondylar fracture threatens the brachial artery and the median nerve (especially the anterior interosseous branch).

## Radioulnar joints and interosseous membrane

- Pivot-type synovial joints that allow pronation and supination.
- Proximal: radial head in the radial notch of the ulna, held by the annular ligament.
- Distal: head of the ulna with the ulnar notch of the radius.
- The interosseous membrane joins the radius and ulna and gives attachment to forearm muscles. Force on the radius travels across it to the ulna.

## Wrist joint

- Condyloid synovial joint between the distal radius plus articular disc above and the scaphoid, lunate and triquetrum below. **The ulna is not part of the wrist joint.**
- Ligaments: palmar and dorsal radiocarpal, and the ulnar and radial collateral ligaments, which limit deviation to the opposite side.
- Movements: flexion, extension, abduction (radial deviation), adduction (ulnar deviation).
- **Fall on an outstretched hand:** the scaphoid is the most commonly fractured carpal bone (tenderness in the anatomical snuffbox, risk of avascular necrosis of the proximal pole), and **Colles fracture** (distal radius, dorsal displacement, "dinner fork" deformity) is the most common wrist fracture overall.$lesson_body$,
    false,
    5,
    'published',
    now(),
    now()
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = EXCLUDED."status",
    "updated_at" = now();

  -- 10. Upsert Lesson 7: Dermatomes, myotomes and reflexes
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'dermatomes-myotomes-reflexes',
    'Dermatomes, myotomes and reflexes',
    'article',
    $lesson_body$## Dermatomes (landmarks to remember)

A dermatome is the strip of skin supplied by one spinal nerve root. It matters for localising spinal cord and root lesions.

- C2: occipital protuberance
- C3: supraclavicular fossa
- C4: acromioclavicular joint
- C5: lateral side of the cubital fossa
- C6: thumb
- C7: middle finger
- C8: little finger
- T1: medial side of the cubital fossa
- T2: apex of the axilla

## Myotomes (what to test)

A myotome is the group of muscles supplied by one root.

- **C5:** shoulder abduction (and elbow flexion with C6)
- **C6:** elbow flexion and wrist extension
- **C7:** elbow extension (and wrist flexion)
- **C8:** finger flexion
- **T1:** finger abduction (dorsal interossei)

## Reflexes

- **Biceps:** C5-C6 (musculocutaneous nerve)
- **Supinator (brachioradialis):** C5-C6 in most textbooks (radial nerve)
- **Triceps:** C7, with C6-C8 contribution (radial nerve)

Note: some question banks quote the supinator reflex as C6-C7 and the triceps reflex as C7-C8. If a question gives you ranges, pick the answer that contains the root you expect, and learn the numbers your own question bank uses.

## Exam tip

Memory aid for the whole limb: C5 shoulder, C6 elbow flexion and wrist extension, C7 elbow extension, C8 fingers flexing, T1 fingers spreading.$lesson_body$,
    false,
    6,
    'published',
    now(),
    now()
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = EXCLUDED."status",
    "updated_at" = now();

  -- 11. Upsert Lesson 8: Carpal tunnel, snuffbox and other important structures
  INSERT INTO "lessons" (
    "id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at"
  ) VALUES (
    gen_random_uuid(),
    v_module_id,
    'carpal-tunnel-snuffbox-structures',
    'Carpal tunnel, snuffbox and other important structures',
    'article',
    $lesson_body$## Carpal tunnel

- **Roof:** flexor retinaculum, attached medially to the pisiform and hook of the hamate, and laterally to the tubercles of the scaphoid and trapezium.
- **Floor:** the carpal bones.
- **Contents (10 structures):** four tendons of flexor digitorum superficialis (the most superficial), four tendons of flexor digitorum profundus, the tendon of flexor pollicis longus (lateral), and the median nerve.

**Not inside the tunnel** (they pass superficial to the flexor retinaculum): the ulnar nerve and artery, the palmaris longus tendon, and the palmar cutaneous branch of the median nerve. Flexor carpi radialis runs in its own sheath on the lateral side. Pronator quadratus stays in the distal forearm.

## Anatomical snuffbox

A triangular hollow on the lateral side of the back of the hand, seen best with the thumb extended.

- **Medial (ulnar) border:** tendon of extensor pollicis longus.
- **Lateral (radial) border:** tendons of abductor pollicis longus and extensor pollicis brevis.
- **Proximal limit:** styloid process of the radius. **Distal limit:** base of the first metacarpal.
- **Floor:** scaphoid and trapezium.
- **Contents:** radial artery, superficial branch of the radial nerve, cephalic vein.
- Tenderness here after a fall on the outstretched hand suggests a scaphoid fracture.

## Ulnar (Guyon) canal

- Carries the ulnar nerve and artery into the hand.
- Borders: pisiform and flexor carpi ulnaris tendon medially, hook of the hamate laterally, palmar carpal ligament forms the roof, flexor retinaculum forms the floor.
- Ulnar canal syndrome means compression of the ulnar nerve here (ganglion, lipoma, trauma, repetitive pressure such as cycling).

## Extensor retinaculum and the six compartments

The retinaculum holds the extensor tendons in place at the wrist. Tendons pass under it in six synovial compartments, from lateral to medial:

1. Abductor pollicis longus and extensor pollicis brevis
2. Extensor carpi radialis longus and brevis
3. Extensor pollicis longus
4. Extensor digitorum and extensor indicis
5. Extensor digiti minimi
6. Extensor carpi ulnaris

Inflammation of compartment 1 is de Quervain tenosynovitis.

## High-yield hand and arm conditions

- **Dupuytren contracture:** thickening and shortening of the palmar fascia, producing a fixed flexion of the ring and little fingers.
- **Volkmann contracture:** ischaemic contracture of the forearm flexors.
- **Flexor tenosynovitis:** infection of a flexor tendon sheath after a puncture wound, with pain, swelling and difficulty moving the finger. In the thumb it can spread through the radial bursa, and in the little finger through the ulnar bursa, to the mid-palmar space. Infection in the middle three fingers usually stays in its own sheath.
- **Trigger finger:** a nodule on a flexor tendon catches in its pulley, causing painful clicking.
- **Mallet finger:** avulsion of the extensor tendon from the distal phalanx, so the fingertip stays flexed.
- **Boutonniere deformity:** rupture of the central slip of the extensor tendon, so the middle joint is flexed and the distal joint hyperextended.
- **Pancoast tumour:** a lung apex tumour that can damage the lower trunk of the brachial plexus (C8-T1), cause Horner syndrome (ptosis, miosis, anhidrosis) and thoracic outlet symptoms.$lesson_body$,
    false,
    7,
    'published',
    now(),
    now()
  )
  ON CONFLICT ("module_id", "slug") DO UPDATE SET
    "title" = EXCLUDED."title",
    "body" = EXCLUDED."body",
    "is_free_preview" = EXCLUDED."is_free_preview",
    "position" = EXCLUDED."position",
    "status" = EXCLUDED."status",
    "updated_at" = now();

  -- 12. Link course to Primary Pass & All-access plans if they exist
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

  -- 13. Also attach these 8 lessons to the "Anatomy" module in "emergix-primary" if that course exists
  SELECT id INTO v_primary_plan_id FROM "courses" WHERE "slug" = 'emergix-primary' LIMIT 1;
  IF v_primary_plan_id IS NOT NULL THEN
    SELECT id INTO v_all_access_plan_id FROM "modules" 
    WHERE "course_id" = v_primary_plan_id AND ("title" ILIKE '%Anatomy%' OR "title" ILIKE '%Upper Limb%') AND "deleted_at" IS NULL 
    LIMIT 1;

    IF v_all_access_plan_id IS NOT NULL THEN
      INSERT INTO "lessons" ("id", "module_id", "slug", "title", "type", "body", "is_free_preview", "position", "status", "created_at", "updated_at")
      SELECT gen_random_uuid(), v_all_access_plan_id, l."slug", l."title", l."type", l."body", l."is_free_preview", l."position", 'published', now(), now()
      FROM "lessons" l
      WHERE l."module_id" = v_module_id AND l."deleted_at" IS NULL
      ON CONFLICT ("module_id", "slug") DO UPDATE SET
        "title" = EXCLUDED."title",
        "body" = EXCLUDED."body",
        "is_free_preview" = EXCLUDED."is_free_preview",
        "position" = EXCLUDED."position",
        "status" = 'published',
        "updated_at" = now();
      RAISE NOTICE 'Also attached 8 lessons to emergix-primary Anatomy module: module_id=%', v_all_access_plan_id;
    END IF;
  END IF;

  -- 14. Ensure a published WhatsApp manual membership plan exists
  SELECT id INTO v_whatsapp_plan_id FROM "plans" WHERE "family_key" = 'whatsapp-manual' AND "deleted_at" IS NULL LIMIT 1;
  IF v_whatsapp_plan_id IS NULL THEN
    INSERT INTO "plans" (
      "id", "slug", "name", "description", "features", "access_months", "family_key", "family_name", "is_featured", "position", "status", "created_at", "updated_at"
    ) VALUES (
      gen_random_uuid(),
      'mrcem-primary-full-access',
      'MRCEM Primary Full Access (باقة الكورس الشامل)',
      'وصول كامل لكافة دروس وشروحات الكورس، بنك الأسئلة، والموديولات السريرية مع دعم مباشر.',
      '["Full access to Upper Limb Anatomy", "Anatomy, Physiology & Pathology modules", "Examiner clinical pearls & high-yield summaries", "Active WhatsApp mentorship"]'::jsonb,
      3,
      'whatsapp-manual',
      'WhatsApp Verified Access',
      true,
      1,
      'published',
      now(),
      now()
    ) RETURNING "id" INTO v_whatsapp_plan_id;

    -- Add default price: 299 SAR
    INSERT INTO "plan_prices" ("id", "plan_id", "currency", "region", "amount_minor", "created_at", "updated_at")
    VALUES (gen_random_uuid(), v_whatsapp_plan_id, 'SAR', 'ALL', 29900, now(), now())
    ON CONFLICT DO NOTHING;
  END IF;

  -- Link all published courses to this WhatsApp plan
  INSERT INTO "plan_courses" ("id", "plan_id", "course_id", "created_at", "updated_at")
  SELECT gen_random_uuid(), v_whatsapp_plan_id, c.id, now(), now()
  FROM "courses" c
  WHERE c.status = 'published' AND c.deleted_at IS NULL
  ON CONFLICT ("plan_id", "course_id") DO NOTHING;

  RAISE NOTICE 'Course and 8 lessons seeded successfully: course_id=%, module_id=%', v_course_id, v_module_id;
END $$;
`;

export async function runAutoMigrationsAndSeeds() {
  try {
    logger.info("Running automatic DB schema updates & migrations...");
    await pool.query(MEMBERSHIP_TABLES_SQL);
    logger.info("DB membership tables verified successfully.");

    logger.info("Ensuring course and lesson seed data...");
    await pool.query(UPPER_LIMB_SEED_SQL);
    logger.info("Course & lesson seed completed successfully.");
  } catch (err) {
    logger.error({ err }, "Auto-migration or seed encountered an error (continuing startup)");
  }
}
