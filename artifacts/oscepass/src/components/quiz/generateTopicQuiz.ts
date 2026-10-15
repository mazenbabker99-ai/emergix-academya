import type { ParsedQuestion } from './parseQuestions';

/**
 * Pre-curated high-yield MRCEM SBA practice questions for major RCEM basic sciences curriculum modules.
 * Rendered at the bottom of lecture notes ("بعد الدرس") to provide an interactive test.
 */
const HIGH_YIELD_TOPIC_BANK: Record<string, ParsedQuestion[]> = {
  // Upper limb / Brachial plexus
  'brachial-plexus': [
    {
      id: 'bp-1',
      questionNumber: 1,
      stem: 'A neonate born following a difficult delivery involving shoulder dystocia presents with the right upper extremity hanging limp at the side, medially rotated at the shoulder and pronated at the forearm with wrist flexion ("waiter\'s tip"). Which neural structures have been avulsed or stretched?',
      options: [
        { key: 'A', text: 'C8 and T1 anterior rami (lower trunk)' },
        { key: 'B', text: 'C5 and C6 anterior rami (upper trunk)' },
        { key: 'C', text: 'Posterior cord of the brachial plexus' },
        { key: 'D', text: 'Long thoracic nerve of Bell' },
        { key: 'E', text: 'Medial cord of the brachial plexus' },
      ],
      correctKey: 'B',
      explanation: 'Erb-Duchenne palsy involves traction damage to the C5-C6 roots (upper trunk). Muscles affected include supraspinatus, infraspinatus, deltoid, biceps brachii, and brachialis, leading to adduction, internal rotation, and forearm pronation ("waiter\'s tip").',
    },
    {
      id: 'bp-2',
      questionNumber: 2,
      stem: 'A 24-year-old cyclist sustains an injury to the wrist. Examination shows numbness over the lateral 3.5 digits and thenar wasting, but sensation over the thenar eminence itself is completely normal. What anatomical fact explains the preserved sensation over the thenar eminence?',
      options: [
        { key: 'A', text: 'The radial nerve innervates the central palm' },
        { key: 'B', text: 'The palmar cutaneous branch arises proximal to the flexor retinaculum' },
        { key: 'C', text: 'The ulnar nerve supplies sensory innervation to the lateral palm' },
        { key: 'D', text: 'The thenar eminence is supplied exclusively by C7 dermatome' },
        { key: 'E', text: 'The recurrent motor branch provides sensory collateral' },
      ],
      correctKey: 'B',
      explanation: 'The palmar cutaneous branch of the median nerve arises approximately 5 cm proximal to the wrist and passes superficial to the flexor retinaculum. Therefore, sensation over the thenar eminence is typically spared in carpal tunnel syndrome.',
    },
    {
      id: 'bp-3',
      questionNumber: 3,
      stem: 'A 42-year-old male sustains a midshaft humerus fracture after a fall. On examination, he is unable to extend his wrist and fingers ("wrist drop") and has loss of sensation over the first dorsal web space. Which nerve and vessel travel together in the spiral groove at this level?',
      options: [
        { key: 'A', text: 'Median nerve and brachial artery' },
        { key: 'B', text: 'Radial nerve and profunda brachii artery' },
        { key: 'C', text: 'Axillary nerve and posterior circumflex humeral artery' },
        { key: 'D', text: 'Ulnar nerve and superior ulnar collateral artery' },
        { key: 'E', text: 'Musculocutaneous nerve and anterior circumflex humeral artery' },
      ],
      correctKey: 'B',
      explanation: 'The radial nerve and profunda brachii artery (deep brachial artery) descend together through the radial (spiral) groove on the posterior surface of the humerus, where they are vulnerable to injury in midshaft humerus fractures.',
    },
  ],

  // Default Upper Limb Anatomy questions
  'upper-limb': [
    {
      id: 'ul-1',
      questionNumber: 1,
      stem: 'A 32-year-old woman is evaluated following an anterior shoulder dislocation. After successful reduction, physical examination reveals weakened shoulder abduction beyond 15 degrees and sensory loss over the lateral aspect of the upper arm ("regimental badge area"). Which nerve is injured?',
      options: [
        { key: 'A', text: 'Suprascapular nerve' },
        { key: 'B', text: 'Axillary nerve' },
        { key: 'C', text: 'Musculocutaneous nerve' },
        { key: 'D', text: 'Radial nerve' },
        { key: 'E', text: 'Long thoracic nerve' },
      ],
      correctKey: 'B',
      explanation: 'The axillary nerve (C5-C6) winds around the surgical neck of the humerus in the quadrangular space and is the most commonly injured nerve in anterior shoulder dislocations. It supplies deltoid and teres minor, and sensory to the regimental badge area.',
    },
    {
      id: 'ul-2',
      questionNumber: 2,
      stem: 'During venipuncture at the cubital fossa, an emergency doctor notes the protective structure that lies superficial to the brachial artery and median nerve, separating them from the median cubital vein. What is this landmark structure?',
      options: [
        { key: 'A', text: 'Flexor retinaculum' },
        { key: 'B', text: 'Bicipital aponeurosis' },
        { key: 'C', text: 'Pronator teres aponeurosis' },
        { key: 'D', text: 'Brachioradialis tendon' },
        { key: 'E', text: 'Intermuscular septum' },
      ],
      correctKey: 'B',
      explanation: 'The bicipital aponeurosis (lacertus fibrosus) runs medially from the biceps tendon to merge with deep fascia of the forearm. It separates the superficial median cubital vein from the deep brachial artery and median nerve, shielding them during cannulation.',
    },
  ],

  // Toxicology / Antidotes
  toxicology: [
    {
      id: 'tox-1',
      questionNumber: 1,
      stem: 'A 20-year-old presents 5 hours after consuming an acute massive overdose of paracetamol. By what primary mechanism does the antidote N-acetylcysteine (NAC) prevent severe hepatic failure?',
      options: [
        { key: 'A', text: 'Direct competitive inhibition of CYP2E1' },
        { key: 'B', text: 'Replenishing intracellular glutathione stores to conjugate NAPQI' },
        { key: 'C', text: 'Inducing hepatic glucuronidation pathways' },
        { key: 'D', text: 'Binding circulating paracetamol to prevent tissue uptake' },
        { key: 'E', text: 'Chelating iron radicals generated during lipid peroxidation' },
      ],
      correctKey: 'B',
      explanation: 'Paracetamol is metabolized in therapeutic doses by glucuronidation and sulfation. Overdose shunts excess drug to CYP2E1, forming toxic N-acetyl-p-benzoquinone imine (NAPQI). NAC acts as a glutathione precursor, detoxifying NAPQI into non-toxic mercapturic acid.',
    },
    {
      id: 'tox-2',
      questionNumber: 2,
      stem: 'An unconscious agricultural worker is brought to the ED with pinpoint pupils, hypersalivation, bronchorrhea, and muscle fasciculations. What is the immediate pharmacological priority to reverse life-threatening respiratory secretions?',
      options: [
        { key: 'A', text: 'Pralidoxime (2-PAM) IV infusion' },
        { key: 'B', text: 'Atropine IV titrated to clear chest secretions' },
        { key: 'C', text: 'Physostigmine IV push' },
        { key: 'D', text: 'Naloxone IV' },
        { key: 'E', text: 'Sodium bicarbonate IV' },
      ],
      correctKey: 'B',
      explanation: 'In organophosphate toxicity (cholinergic crisis), atropine is the cornerstone antidote. It is titrated to achieve "atropinisation": clearing of bronchorrhea, resolution of bronchospasm, and heart rate >80 bpm. Pralidoxime is added to reactivate acetylcholinesterase.',
    },
  ],

  // Physiology
  cardio: [
    {
      id: 'cv-1',
      questionNumber: 1,
      stem: 'According to the Frank-Starling law of the heart, an increase in left ventricular end-diastolic volume directly augments stroke volume. What fundamental biophysical property mediates this response?',
      options: [
        { key: 'A', text: 'Length-dependent increase in myofilament sensitivity to calcium' },
        { key: 'B', text: 'Selective opening of voltage-gated T-type calcium channels' },
        { key: 'C', text: 'Direct beta-1 adrenergic receptor stimulation' },
        { key: 'D', text: 'Inhibition of sarcoplasmic reticulum calcium reuptake (SERCA)' },
        { key: 'E', text: 'Activation of the parasympathetic muscarinic M2 receptor' },
      ],
      correctKey: 'A',
      explanation: 'The Frank-Starling mechanism reflects intrinsic length-dependent activation of cardiac muscle: stretching sarcomeres toward optimal length (approx 2.2 micrometers) increases troponin C affinity for calcium and cross-bridge formation.',
    },
    {
      id: 'cv-2',
      questionNumber: 2,
      stem: 'A 65-year-old patient presents with acute inferior wall myocardial infarction. Twelve-lead ECG demonstrates marked sinus bradycardia (34 bpm) with ST-elevation in II, III, and aVF. Occlusion of which coronary artery is the cause?',
      options: [
        { key: 'A', text: 'Left anterior descending (LAD) artery' },
        { key: 'B', text: 'Right coronary artery (RCA)' },
        { key: 'C', text: 'Left circumflex (LCx) artery' },
        { key: 'D', text: 'Obtuse marginal branch' },
        { key: 'E', text: 'Left main coronary artery' },
      ],
      correctKey: 'B',
      explanation: 'In 90% of individuals (right-dominant), the RCA supplies the inferior wall (via the posterior descending artery) as well as the sinoatrial node (60%) and atrioventricular node (90%). Occlusion causes inferior STEMI and bradyarrhythmias.',
    },
  ],
};

/**
 * Returns topical questions if lesson title or body matches medical keywords,
 * ensuring every lesson has an interactive SBA knowledge check.
 */
export function getLessonTopicQuiz(lessonTitle: string, lessonBody: string): ParsedQuestion[] {
  const t = (lessonTitle + ' ' + lessonBody).toLowerCase();

  if (t.includes('brachial') || t.includes('plexus') || t.includes('radial') || t.includes('carpal')) {
    return HIGH_YIELD_TOPIC_BANK['brachial-plexus'];
  }
  if (t.includes('upper limb') || t.includes('arm') || t.includes('shoulder') || t.includes('axillary')) {
    return HIGH_YIELD_TOPIC_BANK['upper-limb'];
  }
  if (t.includes('toxic') || t.includes('poison') || t.includes('paracetamol') || t.includes('antidote')) {
    return HIGH_YIELD_TOPIC_BANK['toxicology'];
  }
  if (t.includes('cardio') || t.includes('coronary') || t.includes('artery') || t.includes('heart') || t.includes('infarct')) {
    return HIGH_YIELD_TOPIC_BANK['cardio'];
  }

  // General high-yield emergency medicine practice check
  return [
    {
      id: 'gen-1',
      questionNumber: 1,
      stem: `A 28-year-old trauma patient is assessed in resuscitation according to ATLS principles. In managing clinical priorities for this scenario ("${lessonTitle}"), what is the essential immediate step following primary survey airway and breathing stabilization?`,
      options: [
        { key: 'A', text: 'Assessment of circulation and hemorrhage control' },
        { key: 'B', text: 'Comprehensive head-to-toe secondary survey' },
        { key: 'C', text: 'Immediate transport to CT scan suite' },
        { key: 'D', text: 'Oral antibiotic prophylaxis' },
        { key: 'E', text: 'Routine laboratory urinalysis' },
      ],
      correctKey: 'A',
      explanation: 'In emergency medicine, the structured ABCDE approach dictates addressing Airway, Breathing, and then immediately Circulation with hemorrhage control before proceeding to disability and secondary surveys.',
    },
    {
      id: 'gen-2',
      questionNumber: 2,
      stem: `When reviewing high-yield Royal College principles for "${lessonTitle}", which management decision represents the primary evidence-based standard?`,
      options: [
        { key: 'A', text: 'Structured evaluation aligning with RCEM and NICE guidelines' },
        { key: 'B', text: 'Delayed intervention pending non-urgent imaging' },
        { key: 'C', text: 'Discharge with routine outpatient follow-up' },
        { key: 'D', text: 'Empirical broad-spectrum therapy without clinical assessment' },
        { key: 'E', text: 'Observation only without hemodynamic monitoring' },
      ],
      correctKey: 'A',
      explanation: 'RCEM syllabus highlights systematic clinical assessment, early risk stratification, and targeted guideline-directed intervention.',
    },
  ];
}
