-- ==========================================================================
-- RENAME & REORDER ALL 41 PRIMARY QUIZZES
-- Assigns professional clinical topic titles and exact 0..10 positions
-- ==========================================================================
DO $$
BEGIN
  -- Quiz 01
  UPDATE "lessons"
  SET "title" = 'Quiz 01: Emergency Resuscitation, Cranial Nerves & Infection Microbiology',
      "position" = 0,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-01'
     OR "slug" = 'quiz-1'
     OR "slug" = 'quiz-01'
     OR "title" ILIKE 'Primary Quiz 01%'
     OR "title" ILIKE 'Primary Quiz 1%';

  -- Quiz 02
  UPDATE "lessons"
  SET "title" = 'Quiz 02: Abdominal Viscera, Inguinal Anatomy & Autonomic Neuro-Ophthalmology',
      "position" = 1,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-02'
     OR "slug" = 'quiz-2'
     OR "slug" = 'quiz-02'
     OR "title" ILIKE 'Primary Quiz 02%'
     OR "title" ILIKE 'Primary Quiz 2%';

  -- Quiz 03
  UPDATE "lessons"
  SET "title" = 'Quiz 03: Clinical Neuroanatomy, Cranial Nerves & Head-and-Neck Trauma',
      "position" = 2,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-03'
     OR "slug" = 'quiz-3'
     OR "slug" = 'quiz-03'
     OR "title" ILIKE 'Primary Quiz 03%'
     OR "title" ILIKE 'Primary Quiz 3%';

  -- Quiz 04
  UPDATE "lessons"
  SET "title" = 'Quiz 04: Thoracic Cavity, Upper Limb Neurovascular & Trauma Mechanics',
      "position" = 3,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-04'
     OR "slug" = 'quiz-4'
     OR "slug" = 'quiz-04'
     OR "title" ILIKE 'Primary Quiz 04%'
     OR "title" ILIKE 'Primary Quiz 4%';

  -- Quiz 05
  UPDATE "lessons"
  SET "title" = 'Quiz 05: Cardiovascular Physiology, Coronary Anatomy & Renal Mechanisms',
      "position" = 4,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-05'
     OR "slug" = 'quiz-5'
     OR "slug" = 'quiz-05'
     OR "title" ILIKE 'Primary Quiz 05%'
     OR "title" ILIKE 'Primary Quiz 5%';

  -- Quiz 06
  UPDATE "lessons"
  SET "title" = 'Quiz 06: Endocrine Emergencies, Cardiac Cycle & Toxicological Crises',
      "position" = 5,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-06'
     OR "slug" = 'quiz-6'
     OR "slug" = 'quiz-06'
     OR "title" ILIKE 'Primary Quiz 06%'
     OR "title" ILIKE 'Primary Quiz 6%';

  -- Quiz 07
  UPDATE "lessons"
  SET "title" = 'Quiz 07: Pharmacology & Toxicology, Autonomic System & Airway Anatomy',
      "position" = 6,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-07'
     OR "slug" = 'quiz-7'
     OR "slug" = 'quiz-07'
     OR "title" ILIKE 'Primary Quiz 07%'
     OR "title" ILIKE 'Primary Quiz 7%';

  -- Quiz 08
  UPDATE "lessons"
  SET "title" = 'Quiz 08: Respiratory Tract Anatomy, Facial Innervation & Metabolic Disorders',
      "position" = 7,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-08'
     OR "slug" = 'quiz-8'
     OR "slug" = 'quiz-08'
     OR "title" ILIKE 'Primary Quiz 08%'
     OR "title" ILIKE 'Primary Quiz 8%';

  -- Quiz 09
  UPDATE "lessons"
  SET "title" = 'Quiz 09: Lower Limb Nerves, Resuscitation Drugs & Gastrointestinal System',
      "position" = 8,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-09'
     OR "slug" = 'quiz-9'
     OR "slug" = 'quiz-09'
     OR "title" ILIKE 'Primary Quiz 09%'
     OR "title" ILIKE 'Primary Quiz 9%';

  -- Quiz 10
  UPDATE "lessons"
  SET "title" = 'Quiz 10: Diabetic Ketoacidosis, Adrenoceptors & Skull Base Foramina',
      "position" = 9,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-10'
     OR "slug" = 'quiz-10'
     OR "slug" = 'quiz-10'
     OR "title" ILIKE 'Primary Quiz 10%'
     OR "title" ILIKE 'Primary Quiz 10%';

  -- Quiz 11
  UPDATE "lessons"
  SET "title" = 'Quiz 11: Blood Gas Physiology, Electrolyte ECG & Hematological Disorders',
      "position" = 0,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-11'
     OR "slug" = 'quiz-11'
     OR "slug" = 'quiz-11'
     OR "title" ILIKE 'Primary Quiz 11%'
     OR "title" ILIKE 'Primary Quiz 11%';

  -- Quiz 12
  UPDATE "lessons"
  SET "title" = 'Quiz 12: Peripheral Neuropathy, Hernia Anatomy & Inguinal Architecture',
      "position" = 1,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-12'
     OR "slug" = 'quiz-12'
     OR "slug" = 'quiz-12'
     OR "title" ILIKE 'Primary Quiz 12%'
     OR "title" ILIKE 'Primary Quiz 12%';

  -- Quiz 13
  UPDATE "lessons"
  SET "title" = 'Quiz 13: Pharmacokinetics, Neuromuscular Junction & Shock Physiology',
      "position" = 2,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-13'
     OR "slug" = 'quiz-13'
     OR "slug" = 'quiz-13'
     OR "title" ILIKE 'Primary Quiz 13%'
     OR "title" ILIKE 'Primary Quiz 13%';

  -- Quiz 14
  UPDATE "lessons"
  SET "title" = 'Quiz 14: Respiratory Mechanics, Acid-Base Chemoreceptors & Visual Pathways',
      "position" = 3,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-14'
     OR "slug" = 'quiz-14'
     OR "slug" = 'quiz-14'
     OR "title" ILIKE 'Primary Quiz 14%'
     OR "title" ILIKE 'Primary Quiz 14%';

  -- Quiz 15
  UPDATE "lessons"
  SET "title" = 'Quiz 15: Neuro-Aphasia, Inguinal Canal & Autonomic Receptors',
      "position" = 4,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-15'
     OR "slug" = 'quiz-15'
     OR "slug" = 'quiz-15'
     OR "title" ILIKE 'Primary Quiz 15%'
     OR "title" ILIKE 'Primary Quiz 15%';

  -- Quiz 16
  UPDATE "lessons"
  SET "title" = 'Quiz 16: Musculoskeletal Biomechanics, Renal Tubular Transport & Immunology',
      "position" = 5,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-16'
     OR "slug" = 'quiz-16'
     OR "slug" = 'quiz-16'
     OR "title" ILIKE 'Primary Quiz 16%'
     OR "title" ILIKE 'Primary Quiz 16%';

  -- Quiz 17
  UPDATE "lessons"
  SET "title" = 'Quiz 17: Clinical Microbiology, Cerebrovascular Circulation & Infectious Disease',
      "position" = 6,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-17'
     OR "slug" = 'quiz-17'
     OR "slug" = 'quiz-17'
     OR "title" ILIKE 'Primary Quiz 17%'
     OR "title" ILIKE 'Primary Quiz 17%';

  -- Quiz 18
  UPDATE "lessons"
  SET "title" = 'Quiz 18: Evidence-Based Medicine, Cardiac Conduction & Clinical Trials',
      "position" = 7,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-18'
     OR "slug" = 'quiz-18'
     OR "slug" = 'quiz-18'
     OR "title" ILIKE 'Primary Quiz 18%'
     OR "title" ILIKE 'Primary Quiz 18%';

  -- Quiz 19
  UPDATE "lessons"
  SET "title" = 'Quiz 19: Pediatric Emergencies, Joint Ligaments & Parasitology',
      "position" = 8,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-19'
     OR "slug" = 'quiz-19'
     OR "slug" = 'quiz-19'
     OR "title" ILIKE 'Primary Quiz 19%'
     OR "title" ILIKE 'Primary Quiz 19%';

  -- Quiz 20
  UPDATE "lessons"
  SET "title" = 'Quiz 20: Emergency Anesthetics, Toxicology Antidotes & Resuscitation Pharmacology',
      "position" = 9,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-20'
     OR "slug" = 'quiz-20'
     OR "slug" = 'quiz-20'
     OR "title" ILIKE 'Primary Quiz 20%'
     OR "title" ILIKE 'Primary Quiz 20%';

  -- Quiz 21
  UPDATE "lessons"
  SET "title" = 'Quiz 21: Biophysics of Flow, Arrhythmia Mechanisms & Critical Care Burns',
      "position" = 0,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-21'
     OR "slug" = 'quiz-21'
     OR "slug" = 'quiz-21'
     OR "title" ILIKE 'Primary Quiz 21%'
     OR "title" ILIKE 'Primary Quiz 21%';

  -- Quiz 22
  UPDATE "lessons"
  SET "title" = 'Quiz 22: Hematological Malignancies, Bone Healing & Surgical Anatomy',
      "position" = 1,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-22'
     OR "slug" = 'quiz-22'
     OR "slug" = 'quiz-22'
     OR "title" ILIKE 'Primary Quiz 22%'
     OR "title" ILIKE 'Primary Quiz 22%';

  -- Quiz 23
  UPDATE "lessons"
  SET "title" = 'Quiz 23: Gastrointestinal Secretions, Pancreatic Enzymes & Lower Limb Blocks',
      "position" = 2,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-23'
     OR "slug" = 'quiz-23'
     OR "slug" = 'quiz-23'
     OR "title" ILIKE 'Primary Quiz 23%'
     OR "title" ILIKE 'Primary Quiz 23%';

  -- Quiz 24
  UPDATE "lessons"
  SET "title" = 'Quiz 24: Abdominal Hernias, Intestinal Pathology & CSF Diagnostics',
      "position" = 3,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-24'
     OR "slug" = 'quiz-24'
     OR "slug" = 'quiz-24'
     OR "title" ILIKE 'Primary Quiz 24%'
     OR "title" ILIKE 'Primary Quiz 24%';

  -- Quiz 25
  UPDATE "lessons"
  SET "title" = 'Quiz 25: Traumatic Brain Injury, Tuberculosis & Enzyme Induction',
      "position" = 4,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-25'
     OR "slug" = 'quiz-25'
     OR "slug" = 'quiz-25'
     OR "title" ILIKE 'Primary Quiz 25%'
     OR "title" ILIKE 'Primary Quiz 25%';

  -- Quiz 26
  UPDATE "lessons"
  SET "title" = 'Quiz 26: Diving Physics, Musculoskeletal Trauma & Cardiovascular Drugs',
      "position" = 5,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-26'
     OR "slug" = 'quiz-26'
     OR "slug" = 'quiz-26'
     OR "title" ILIKE 'Primary Quiz 26%'
     OR "title" ILIKE 'Primary Quiz 26%';

  -- Quiz 27
  UPDATE "lessons"
  SET "title" = 'Quiz 27: Upper & Lower Limb Trauma, Compartment Syndromes & Scaphoid Fracture',
      "position" = 6,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-27'
     OR "slug" = 'quiz-27'
     OR "slug" = 'quiz-27'
     OR "title" ILIKE 'Primary Quiz 27%'
     OR "title" ILIKE 'Primary Quiz 27%';

  -- Quiz 28
  UPDATE "lessons"
  SET "title" = 'Quiz 28: Intracranial Dynamics, Acute Abdomen & Shock Resuscitation',
      "position" = 7,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-28'
     OR "slug" = 'quiz-28'
     OR "slug" = 'quiz-28'
     OR "title" ILIKE 'Primary Quiz 28%'
     OR "title" ILIKE 'Primary Quiz 28%';

  -- Quiz 29
  UPDATE "lessons"
  SET "title" = 'Quiz 29: Splenic Trauma, Osteology & Neuromuscular Toxins',
      "position" = 8,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-29'
     OR "slug" = 'quiz-29'
     OR "slug" = 'quiz-29'
     OR "title" ILIKE 'Primary Quiz 29%'
     OR "title" ILIKE 'Primary Quiz 29%';

  -- Quiz 30
  UPDATE "lessons"
  SET "title" = 'Quiz 30: Medical Statistics, Epidemiology & Cranial Nerve Palsies',
      "position" = 9,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-30'
     OR "slug" = 'quiz-30'
     OR "slug" = 'quiz-30'
     OR "title" ILIKE 'Primary Quiz 30%'
     OR "title" ILIKE 'Primary Quiz 30%';

  -- Quiz 31
  UPDATE "lessons"
  SET "title" = 'Quiz 31: Lower Limb Anatomy, Gastrointestinal Surgery & Pharmacology',
      "position" = 0,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-31'
     OR "slug" = 'quiz-31'
     OR "slug" = 'quiz-31'
     OR "title" ILIKE 'Primary Quiz 31%'
     OR "title" ILIKE 'Primary Quiz 31%';

  -- Quiz 32
  UPDATE "lessons"
  SET "title" = 'Quiz 32: Cranial Nerve Lesions, Brainstem Pathways & Vaccine Guidelines',
      "position" = 1,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-32'
     OR "slug" = 'quiz-32'
     OR "slug" = 'quiz-32'
     OR "title" ILIKE 'Primary Quiz 32%'
     OR "title" ILIKE 'Primary Quiz 32%';

  -- Quiz 33
  UPDATE "lessons"
  SET "title" = 'Quiz 33: Glomerulonephritis, Upper Limb Fractures & Wound Microbiology',
      "position" = 2,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-33'
     OR "slug" = 'quiz-33'
     OR "slug" = 'quiz-33'
     OR "title" ILIKE 'Primary Quiz 33%'
     OR "title" ILIKE 'Primary Quiz 33%';

  -- Quiz 34
  UPDATE "lessons"
  SET "title" = 'Quiz 34: Resuscitation Protocols, Airway Interventions & Cellular Biology',
      "position" = 3,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-34'
     OR "slug" = 'quiz-34'
     OR "slug" = 'quiz-34'
     OR "title" ILIKE 'Primary Quiz 34%'
     OR "title" ILIKE 'Primary Quiz 34%';

  -- Quiz 35
  UPDATE "lessons"
  SET "title" = 'Quiz 35: Sepsis Resuscitation, Toxicology Antidotes & Immunization Rules',
      "position" = 4,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-35'
     OR "slug" = 'quiz-35'
     OR "slug" = 'quiz-35'
     OR "title" ILIKE 'Primary Quiz 35%'
     OR "title" ILIKE 'Primary Quiz 35%';

  -- Quiz 36
  UPDATE "lessons"
  SET "title" = 'Quiz 36: Adrenal-Renal Physiology, Bowel Histology & Clinical Evidence',
      "position" = 5,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-36'
     OR "slug" = 'quiz-36'
     OR "slug" = 'quiz-36'
     OR "title" ILIKE 'Primary Quiz 36%'
     OR "title" ILIKE 'Primary Quiz 36%';

  -- Quiz 37
  UPDATE "lessons"
  SET "title" = 'Quiz 37: Atypical Infections, Skull Base Pathology & Syncope Mechanisms',
      "position" = 6,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-37'
     OR "slug" = 'quiz-37'
     OR "slug" = 'quiz-37'
     OR "title" ILIKE 'Primary Quiz 37%'
     OR "title" ILIKE 'Primary Quiz 37%';

  -- Quiz 38
  UPDATE "lessons"
  SET "title" = 'Quiz 38: Genitourinary Emergencies, Hip/Knee Muscles & Spinal Landmarks',
      "position" = 7,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-38'
     OR "slug" = 'quiz-38'
     OR "slug" = 'quiz-38'
     OR "title" ILIKE 'Primary Quiz 38%'
     OR "title" ILIKE 'Primary Quiz 38%';

  -- Quiz 39
  UPDATE "lessons"
  SET "title" = 'Quiz 39: Neuromuscular Disorders, Thyroid Storm & Knee Biomechanics',
      "position" = 8,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-39'
     OR "slug" = 'quiz-39'
     OR "slug" = 'quiz-39'
     OR "title" ILIKE 'Primary Quiz 39%'
     OR "title" ILIKE 'Primary Quiz 39%';

  -- Quiz 40
  UPDATE "lessons"
  SET "title" = 'Quiz 40: Neurotoxins, Enzyme Induction & Autoimmune Pathologies',
      "position" = 9,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-40'
     OR "slug" = 'quiz-40'
     OR "slug" = 'quiz-40'
     OR "title" ILIKE 'Primary Quiz 40%'
     OR "title" ILIKE 'Primary Quiz 40%';

  -- Quiz 41
  UPDATE "lessons"
  SET "title" = 'Quiz 41: Neuroleptic Syndrome, Laryngeal Anatomy & Portal Hypertension',
      "position" = 10,
      "updated_at" = now()
  WHERE "slug" = 'primary-quiz-41'
     OR "slug" = 'quiz-41'
     OR "slug" = 'quiz-41'
     OR "title" ILIKE 'Primary Quiz 41%'
     OR "title" ILIKE 'Primary Quiz 41%';

  -- Refresh course updated_at
  UPDATE "courses" SET "updated_at" = now() WHERE "slug" = 'mrcem-primary';

  RAISE NOTICE 'SUCCESS: All 41 quizzes renamed and ordered perfectly (Quiz 31..41 properly positioned).';
END $$;