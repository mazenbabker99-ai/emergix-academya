import os
import sys

sys.stdout.reconfigure(encoding='utf-8')

CURRICULUM = {
    'mrcem-anatomy': {
        'title': 'MRCEM Primary: Clinical Anatomy Masterclass',
        'summary': 'Comprehensive, high-yield clinical anatomy covering upper & lower limbs, thorax, abdomen, head & neck, and cranial nerves.',
        'modules': [
            ('UPPER LIMB ANATOMY', 'Upper Limb Anatomy'),
            ('lower limb anatomy', 'Lower Limb Anatomy'),
            ('THORAX ANATOMY', 'Thorax Anatomy & Mediastinum'),
            ('ABDOMEN ANATOMY', 'Abdomen & Peritoneum'),
            ('H&N ANATOMY', 'Head & Neck Anatomy'),
            ('CENTRAL NERVOUS SYSTEM-', 'Central Nervous System'),
            ('CRANIAL NERVE ANATOMY', 'Cranial Nerves Anatomy'),
        ]
    },
    'mrcem-physiology': {
        'title': 'MRCEM Primary: Applied Emergency Physiology',
        'summary': 'In-depth physiological principles from cell membrane dynamics to cardiovascular, respiratory, and acid-base disorders.',
        'modules': [
            ('cell physiology', 'Cell Physiology & Membrane Transport'),
            ('cardiac physiology', 'Cardiovascular Physiology & Hemodynamics'),
            ('resp physiolgy', 'Respiratory Physiology & Ventilation'),
            ('renal physilolgy', 'Renal Physiology & Acid-Base Balance'),
            ('git physiology', 'Gastrointestinal (GIT) Physiology'),
            ('endocrine physiology', 'Endocrine Physiology & Metabolism'),
            ('blood physilolgy and pathology', 'Blood Physiology & Coagulation Pathways'),
        ]
    },
    'mrcem-pharmacology': {
        'title': 'MRCEM Primary: Emergency Pharmacology & Toxicology',
        'summary': 'High-yield pharmacology of emergency drugs, analgesics, cardiovascular agents, anesthetics, and acute toxidromes.',
        'modules': [
            ('resp pharma', 'Respiratory Pharmacology & Asthma Management'),
            ('cardio pharma', 'Cardiovascular Pharmacology & Anticoagulants'),
            ('cns pharma', 'CNS Pharmacology & Analgesia'),
            ('anathesia drug', 'Anesthesia & Sedation Drugs'),
            ('drug toxicity', 'Emergency Toxicology & Antidotes'),
        ]
    },
    'mrcem-pathology-micro': {
        'title': 'MRCEM Primary: Pathology & Clinical Microbiology',
        'summary': 'High-frequency pathology and microbiology covering bacterial classification, antibiotic resistance, and inflammation.',
        'modules': [
            ('pathology', 'General Pathology, Inflammation & Anemia'),
            ('micro', 'Clinical Microbiology, Bacteria & Antibiotics'),
        ]
    }
}

total_lessons = 0
for course_slug, course_data in CURRICULUM.items():
    title = course_data['title']
    print(f"=== {title} ===")
    course_total = 0
    for folder, mod_title in course_data['modules']:
        if not os.path.exists(folder):
            print(f"  [MISSING FOLDER] {folder}")
            continue
        pdfs = [f for f in os.listdir(folder) if f.endswith('.pdf')]
        course_total += len(pdfs)
        print(f"  * Module: {mod_title} ({len(pdfs)} lessons in '{folder}')")
    print(f"  -> Total lessons: {course_total}\n")
    total_lessons += course_total

print(f"GRAND TOTAL THEORY LESSONS: {total_lessons}")
