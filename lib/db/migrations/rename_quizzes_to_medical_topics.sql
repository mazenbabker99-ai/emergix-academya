-- ==========================================================================
-- RENAME MRCEM PRIMARY QUIZZES TO PROFESSIONAL MEDICAL TOPIC NAMES
-- Replaces generic numbers with high-yield curriculum subject titles
-- ==========================================================================
DO $$
DECLARE
  v_count int := 0;
BEGIN
  -- Quiz 01
  UPDATE "lessons"
  SET "title" = 'Quiz 01: Emergency Resuscitation, Cranial Nerves & Infection Microbiology', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-01', 'quiz-1', 'quiz-01')
     OR "title" ILIKE 'Quiz _ 1'
     OR "title" ILIKE 'Primary Quiz 01'
     OR "title" = 'Quiz 1';
  -- Quiz 02
  UPDATE "lessons"
  SET "title" = 'Quiz 02: Abdominal Viscera, Inguinal Anatomy & Autonomic Neuro-Ophthalmology', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-02', 'quiz-2', 'quiz-02')
     OR "title" ILIKE 'Quiz _ 2'
     OR "title" ILIKE 'Primary Quiz 02'
     OR "title" = 'Quiz 2';
  -- Quiz 03
  UPDATE "lessons"
  SET "title" = 'Quiz 03: Clinical Neuroanatomy, Cranial Nerves & Head-and-Neck Trauma', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-03', 'quiz-3', 'quiz-03')
     OR "title" ILIKE 'Quiz _ 3'
     OR "title" ILIKE 'Primary Quiz 03'
     OR "title" = 'Quiz 3';
  -- Quiz 04
  UPDATE "lessons"
  SET "title" = 'Quiz 04: Thoracic Cavity, Upper Limb Neurovascular & Trauma Mechanics', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-04', 'quiz-4', 'quiz-04')
     OR "title" ILIKE 'Quiz _ 4'
     OR "title" ILIKE 'Primary Quiz 04'
     OR "title" = 'Quiz 4';
  -- Quiz 05
  UPDATE "lessons"
  SET "title" = 'Quiz 05: Cardiovascular Physiology, Coronary Anatomy & Renal Mechanisms', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-05', 'quiz-5', 'quiz-05')
     OR "title" ILIKE 'Quiz _ 5'
     OR "title" ILIKE 'Primary Quiz 05'
     OR "title" = 'Quiz 5';
  -- Quiz 06
  UPDATE "lessons"
  SET "title" = 'Quiz 06: Endocrine Emergencies, Cardiac Cycle & Toxicological Crises', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-06', 'quiz-6', 'quiz-06')
     OR "title" ILIKE 'Quiz _ 6'
     OR "title" ILIKE 'Primary Quiz 06'
     OR "title" = 'Quiz 6';
  -- Quiz 07
  UPDATE "lessons"
  SET "title" = 'Quiz 07: Pharmacology & Toxicology, Autonomic System & Airway Anatomy', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-07', 'quiz-7', 'quiz-07')
     OR "title" ILIKE 'Quiz _ 7'
     OR "title" ILIKE 'Primary Quiz 07'
     OR "title" = 'Quiz 7';
  -- Quiz 08
  UPDATE "lessons"
  SET "title" = 'Quiz 08: Respiratory Tract Anatomy, Facial Innervation & Metabolic Disorders', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-08', 'quiz-8', 'quiz-08')
     OR "title" ILIKE 'Quiz _ 8'
     OR "title" ILIKE 'Primary Quiz 08'
     OR "title" = 'Quiz 8';
  -- Quiz 09
  UPDATE "lessons"
  SET "title" = 'Quiz 09: Lower Limb Nerves, Resuscitation Drugs & Gastrointestinal System', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-09', 'quiz-9', 'quiz-09')
     OR "title" ILIKE 'Quiz _ 9'
     OR "title" ILIKE 'Primary Quiz 09'
     OR "title" = 'Quiz 9';
  -- Quiz 10
  UPDATE "lessons"
  SET "title" = 'Quiz 10: Diabetic Ketoacidosis, Adrenoceptors & Skull Base Foramina', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-10', 'quiz-10', 'quiz-10')
     OR "title" ILIKE 'Quiz _ 10'
     OR "title" ILIKE 'Primary Quiz 10'
     OR "title" = 'Quiz 10';
  -- Quiz 11
  UPDATE "lessons"
  SET "title" = 'Quiz 11: Blood Gas Physiology, Electrolyte ECG & Hematological Disorders', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-11', 'quiz-11', 'quiz-11')
     OR "title" ILIKE 'Quiz _ 11'
     OR "title" ILIKE 'Primary Quiz 11'
     OR "title" = 'Quiz 11';
  -- Quiz 12
  UPDATE "lessons"
  SET "title" = 'Quiz 12: Peripheral Neuropathy, Hernia Anatomy & Inguinal Architecture', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-12', 'quiz-12', 'quiz-12')
     OR "title" ILIKE 'Quiz _ 12'
     OR "title" ILIKE 'Primary Quiz 12'
     OR "title" = 'Quiz 12';
  -- Quiz 13
  UPDATE "lessons"
  SET "title" = 'Quiz 13: Pharmacokinetics, Neuromuscular Junction & Shock Physiology', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-13', 'quiz-13', 'quiz-13')
     OR "title" ILIKE 'Quiz _ 13'
     OR "title" ILIKE 'Primary Quiz 13'
     OR "title" = 'Quiz 13';
  -- Quiz 14
  UPDATE "lessons"
  SET "title" = 'Quiz 14: Respiratory Mechanics, Acid-Base Chemoreceptors & Visual Pathways', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-14', 'quiz-14', 'quiz-14')
     OR "title" ILIKE 'Quiz _ 14'
     OR "title" ILIKE 'Primary Quiz 14'
     OR "title" = 'Quiz 14';
  -- Quiz 15
  UPDATE "lessons"
  SET "title" = 'Quiz 15: Neuro-Aphasia, Inguinal Canal & Autonomic Receptors', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-15', 'quiz-15', 'quiz-15')
     OR "title" ILIKE 'Quiz _ 15'
     OR "title" ILIKE 'Primary Quiz 15'
     OR "title" = 'Quiz 15';
  -- Quiz 16
  UPDATE "lessons"
  SET "title" = 'Quiz 16: Musculoskeletal Biomechanics, Renal Tubular Transport & Immunology', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-16', 'quiz-16', 'quiz-16')
     OR "title" ILIKE 'Quiz _ 16'
     OR "title" ILIKE 'Primary Quiz 16'
     OR "title" = 'Quiz 16';
  -- Quiz 17
  UPDATE "lessons"
  SET "title" = 'Quiz 17: Clinical Microbiology, Cerebrovascular Circulation & Infectious Disease', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-17', 'quiz-17', 'quiz-17')
     OR "title" ILIKE 'Quiz _ 17'
     OR "title" ILIKE 'Primary Quiz 17'
     OR "title" = 'Quiz 17';
  -- Quiz 18
  UPDATE "lessons"
  SET "title" = 'Quiz 18: Evidence-Based Medicine, Cardiac Conduction & Clinical Trials', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-18', 'quiz-18', 'quiz-18')
     OR "title" ILIKE 'Quiz _ 18'
     OR "title" ILIKE 'Primary Quiz 18'
     OR "title" = 'Quiz 18';
  -- Quiz 19
  UPDATE "lessons"
  SET "title" = 'Quiz 19: Pediatric Emergencies, Joint Ligaments & Parasitology', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-19', 'quiz-19', 'quiz-19')
     OR "title" ILIKE 'Quiz _ 19'
     OR "title" ILIKE 'Primary Quiz 19'
     OR "title" = 'Quiz 19';
  -- Quiz 20
  UPDATE "lessons"
  SET "title" = 'Quiz 20: Emergency Anesthetics, Toxicology Antidotes & Resuscitation Pharmacology', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-20', 'quiz-20', 'quiz-20')
     OR "title" ILIKE 'Quiz _ 20'
     OR "title" ILIKE 'Primary Quiz 20'
     OR "title" = 'Quiz 20';
  -- Quiz 21
  UPDATE "lessons"
  SET "title" = 'Quiz 21: Biophysics of Flow, Arrhythmia Mechanisms & Critical Care Burns', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-21', 'quiz-21', 'quiz-21')
     OR "title" ILIKE 'Quiz _ 21'
     OR "title" ILIKE 'Primary Quiz 21'
     OR "title" = 'Quiz 21';
  -- Quiz 22
  UPDATE "lessons"
  SET "title" = 'Quiz 22: Hematological Malignancies, Bone Healing & Surgical Anatomy', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-22', 'quiz-22', 'quiz-22')
     OR "title" ILIKE 'Quiz _ 22'
     OR "title" ILIKE 'Primary Quiz 22'
     OR "title" = 'Quiz 22';
  -- Quiz 23
  UPDATE "lessons"
  SET "title" = 'Quiz 23: Gastrointestinal Secretions, Pancreatic Enzymes & Lower Limb Blocks', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-23', 'quiz-23', 'quiz-23')
     OR "title" ILIKE 'Quiz _ 23'
     OR "title" ILIKE 'Primary Quiz 23'
     OR "title" = 'Quiz 23';
  -- Quiz 24
  UPDATE "lessons"
  SET "title" = 'Quiz 24: Abdominal Hernias, Intestinal Pathology & CSF Diagnostics', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-24', 'quiz-24', 'quiz-24')
     OR "title" ILIKE 'Quiz _ 24'
     OR "title" ILIKE 'Primary Quiz 24'
     OR "title" = 'Quiz 24';
  -- Quiz 25
  UPDATE "lessons"
  SET "title" = 'Quiz 25: Traumatic Brain Injury, Tuberculosis & Enzyme Induction', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-25', 'quiz-25', 'quiz-25')
     OR "title" ILIKE 'Quiz _ 25'
     OR "title" ILIKE 'Primary Quiz 25'
     OR "title" = 'Quiz 25';
  -- Quiz 26
  UPDATE "lessons"
  SET "title" = 'Quiz 26: Diving Physics, Musculoskeletal Trauma & Cardiovascular Drugs', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-26', 'quiz-26', 'quiz-26')
     OR "title" ILIKE 'Quiz _ 26'
     OR "title" ILIKE 'Primary Quiz 26'
     OR "title" = 'Quiz 26';
  -- Quiz 27
  UPDATE "lessons"
  SET "title" = 'Quiz 27: Upper & Lower Limb Trauma, Compartment Syndromes & Scaphoid Fracture', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-27', 'quiz-27', 'quiz-27')
     OR "title" ILIKE 'Quiz _ 27'
     OR "title" ILIKE 'Primary Quiz 27'
     OR "title" = 'Quiz 27';
  -- Quiz 28
  UPDATE "lessons"
  SET "title" = 'Quiz 28: Intracranial Dynamics, Acute Abdomen & Shock Resuscitation', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-28', 'quiz-28', 'quiz-28')
     OR "title" ILIKE 'Quiz _ 28'
     OR "title" ILIKE 'Primary Quiz 28'
     OR "title" = 'Quiz 28';
  -- Quiz 29
  UPDATE "lessons"
  SET "title" = 'Quiz 29: Splenic Trauma, Osteology & Neuromuscular Toxins', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-29', 'quiz-29', 'quiz-29')
     OR "title" ILIKE 'Quiz _ 29'
     OR "title" ILIKE 'Primary Quiz 29'
     OR "title" = 'Quiz 29';
  -- Quiz 30
  UPDATE "lessons"
  SET "title" = 'Quiz 30: Medical Statistics, Epidemiology & Cranial Nerve Palsies', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-30', 'quiz-30', 'quiz-30')
     OR "title" ILIKE 'Quiz _ 30'
     OR "title" ILIKE 'Primary Quiz 30'
     OR "title" = 'Quiz 30';
  -- Quiz 31
  UPDATE "lessons"
  SET "title" = 'Quiz 31: Lower Limb Anatomy, Gastrointestinal Surgery & Pharmacology', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-31', 'quiz-31', 'quiz-31')
     OR "title" ILIKE 'Quiz _ 31'
     OR "title" ILIKE 'Primary Quiz 31'
     OR "title" = 'Quiz 31';
  -- Quiz 32
  UPDATE "lessons"
  SET "title" = 'Quiz 32: Cranial Nerve Lesions, Brainstem Pathways & Vaccine Guidelines', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-32', 'quiz-32', 'quiz-32')
     OR "title" ILIKE 'Quiz _ 32'
     OR "title" ILIKE 'Primary Quiz 32'
     OR "title" = 'Quiz 32';
  -- Quiz 33
  UPDATE "lessons"
  SET "title" = 'Quiz 33: Glomerulonephritis, Upper Limb Fractures & Wound Microbiology', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-33', 'quiz-33', 'quiz-33')
     OR "title" ILIKE 'Quiz _ 33'
     OR "title" ILIKE 'Primary Quiz 33'
     OR "title" = 'Quiz 33';
  -- Quiz 34
  UPDATE "lessons"
  SET "title" = 'Quiz 34: Resuscitation Protocols, Airway Interventions & Cellular Biology', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-34', 'quiz-34', 'quiz-34')
     OR "title" ILIKE 'Quiz _ 34'
     OR "title" ILIKE 'Primary Quiz 34'
     OR "title" = 'Quiz 34';
  -- Quiz 35
  UPDATE "lessons"
  SET "title" = 'Quiz 35: Sepsis Resuscitation, Toxicology Antidotes & Immunization Rules', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-35', 'quiz-35', 'quiz-35')
     OR "title" ILIKE 'Quiz _ 35'
     OR "title" ILIKE 'Primary Quiz 35'
     OR "title" = 'Quiz 35';
  -- Quiz 36
  UPDATE "lessons"
  SET "title" = 'Quiz 36: Adrenal-Renal Physiology, Bowel Histology & Clinical Evidence', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-36', 'quiz-36', 'quiz-36')
     OR "title" ILIKE 'Quiz _ 36'
     OR "title" ILIKE 'Primary Quiz 36'
     OR "title" = 'Quiz 36';
  -- Quiz 37
  UPDATE "lessons"
  SET "title" = 'Quiz 37: Atypical Infections, Skull Base Pathology & Syncope Mechanisms', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-37', 'quiz-37', 'quiz-37')
     OR "title" ILIKE 'Quiz _ 37'
     OR "title" ILIKE 'Primary Quiz 37'
     OR "title" = 'Quiz 37';
  -- Quiz 38
  UPDATE "lessons"
  SET "title" = 'Quiz 38: Genitourinary Emergencies, Hip/Knee Muscles & Spinal Landmarks', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-38', 'quiz-38', 'quiz-38')
     OR "title" ILIKE 'Quiz _ 38'
     OR "title" ILIKE 'Primary Quiz 38'
     OR "title" = 'Quiz 38';
  -- Quiz 39
  UPDATE "lessons"
  SET "title" = 'Quiz 39: Neuromuscular Disorders, Thyroid Storm & Knee Biomechanics', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-39', 'quiz-39', 'quiz-39')
     OR "title" ILIKE 'Quiz _ 39'
     OR "title" ILIKE 'Primary Quiz 39'
     OR "title" = 'Quiz 39';
  -- Quiz 40
  UPDATE "lessons"
  SET "title" = 'Quiz 40: Neurotoxins, Enzyme Induction & Autoimmune Pathologies', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-40', 'quiz-40', 'quiz-40')
     OR "title" ILIKE 'Quiz _ 40'
     OR "title" ILIKE 'Primary Quiz 40'
     OR "title" = 'Quiz 40';
  -- Quiz 41
  UPDATE "lessons"
  SET "title" = 'Quiz 41: Neuroleptic Syndrome, Laryngeal Anatomy & Portal Hypertension', "updated_at" = now()
  WHERE "slug" IN ('primary-quiz-41', 'quiz-41', 'quiz-41')
     OR "title" ILIKE 'Quiz _ 41'
     OR "title" ILIKE 'Primary Quiz 41'
     OR "title" = 'Quiz 41';

  RAISE NOTICE 'SUCCESS: All 41 MRCEM Primary quizzes renamed to professional medical topic titles.';
END $$;