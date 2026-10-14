import os
import sys
import pypdf
import re
from cleaners import clean_lesson_title, slugify, clean_lesson_markdown

sys.stdout.reconfigure(encoding='utf-8')

CURRICULUM = {
    'mrcem-anatomy': {
        'title': 'MRCEM Primary: Clinical Anatomy Masterclass',
        'summary': 'Comprehensive, high-yield clinical anatomy covering upper & lower limbs, thorax, abdomen, head & neck, and cranial nerves.',
        'description': 'Master the essential clinical anatomy required for the Royal College of Emergency Medicine (RCEM) Primary exam. Includes high-yield mnemonics, clinical pearls, dissection landmarks, and high-frequency exam questions.',
        'position': 1,
        'modules': [
            ('UPPER LIMB ANATOMY', 'Upper Limb Anatomy'),
            ('lower limb anatomy', 'Lower Limb Anatomy'),
            ('THORAX ANATOMY', 'Thorax Anatomy & Mediastinum'),
            ('ABDOMEN ANATOMY', 'Abdomen & Peritoneum'),
            ('H&N ANATOMY', 'Head & Neck Anatomy'),
            ('CENTRAL NERVOUS SYSTEM-', 'Central Nervous System & Spine'),
            ('CRANIAL NERVE ANATOMY', 'Cranial Nerves In-Depth'),
        ]
    },
    'mrcem-physiology': {
        'title': 'MRCEM Primary: Applied Emergency Physiology',
        'summary': 'In-depth physiological principles from cell membrane dynamics to cardiovascular, respiratory, and acid-base disorders.',
        'description': 'Clinical and applied emergency physiology covering cellular transport, cardiac cycle, respiratory mechanics, gas exchange, renal autoregulation, endocrinology, and hematology tailored for MRCEM Primary.',
        'position': 2,
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
        'description': 'Essential pharmacokinetics, mechanisms of action, adverse effects, and overdose management for emergency physicians. Covers bronchodilators, antiplatelets, anesthetics, and emergency antidotes.',
        'position': 3,
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
        'description': 'Master microbial pathogens, diagnostic methods, antibiotic coverage, immune hypersensitivity reactions, cellular injury, and systemic pathology tested in MRCEM Primary.',
        'position': 4,
        'modules': [
            ('pathology', 'General Pathology, Inflammation & Anemia'),
            ('micro', 'Clinical Microbiology, Bacteria & Antibiotics'),
        ]
    }
}

OUTPUT_DIR = os.path.join('lib', 'db', 'migrations')
os.makedirs(OUTPUT_DIR, exist_ok=True)

def escape_sql_literal(text: str) -> str:
    """Escapes single quotes for PostgreSQL string literals."""
    return text.replace("'", "''")

def process_curriculum():
    total_processed = 0
    
    for course_slug, course_info in CURRICULUM.items():
        print(f"\n==========================================")
        print(f"Generating Seed for: {course_info['title']}")
        print(f"==========================================")
        
        sql_filename = f"seed_{course_slug.replace('-', '_')}.sql"
        sql_path = os.path.join(OUTPUT_DIR, sql_filename)
        
        sql_lines = []
        sql_lines.append(f"-- ==========================================================================")
        sql_lines.append(f"-- SEED SCRIPT: {course_info['title']}")
        sql_lines.append(f"-- Auto-generated for Emergix Academy")
        sql_lines.append(f"-- ==========================================================================")
        sql_lines.append(f"DO $$")
        sql_lines.append(f"DECLARE")
        sql_lines.append(f"  v_exam_id uuid;")
        sql_lines.append(f"  v_course_id uuid;")
        sql_lines.append(f"  v_module_id uuid;")
        sql_lines.append(f"  v_whatsapp_plan_id uuid;")
        sql_lines.append(f"  v_primary_plan_id uuid;")
        sql_lines.append(f"  v_all_access_plan_id uuid;")
        sql_lines.append(f"BEGIN")
        sql_lines.append(f"  -- 1. Locate MRCEM Primary exam")
        sql_lines.append(f"  SELECT id INTO v_exam_id FROM \"exams\" WHERE \"slug\" = 'mrcem-primary' LIMIT 1;")
        sql_lines.append(f"")
        sql_lines.append(f"  -- 2. Upsert Course: {course_slug}")
        sql_lines.append(f"  SELECT id INTO v_course_id FROM \"courses\" WHERE \"slug\" = '{course_slug}' LIMIT 1;")
        sql_lines.append(f"  IF v_course_id IS NULL THEN")
        sql_lines.append(f"    INSERT INTO \"courses\" (")
        sql_lines.append(f"      \"id\", \"exam_id\", \"slug\", \"title\", \"summary\", \"description\", \"is_free\", \"position\", \"status\", \"created_at\", \"updated_at\"")
        sql_lines.append(f"    ) VALUES (")
        sql_lines.append(f"      gen_random_uuid(),")
        sql_lines.append(f"      v_exam_id,")
        sql_lines.append(f"      '{course_slug}',")
        sql_lines.append(f"      '{escape_sql_literal(course_info['title'])}',")
        sql_lines.append(f"      '{escape_sql_literal(course_info['summary'])}',")
        sql_lines.append(f"      '{escape_sql_literal(course_info['description'])}',")
        sql_lines.append(f"      false,")
        sql_lines.append(f"      {course_info['position']},")
        sql_lines.append(f"      'published',")
        sql_lines.append(f"      now(),")
        sql_lines.append(f"      now()")
        sql_lines.append(f"    ) RETURNING \"id\" INTO v_course_id;")
        sql_lines.append(f"  ELSE")
        sql_lines.append(f"    UPDATE \"courses\" SET")
        sql_lines.append(f"      \"title\" = '{escape_sql_literal(course_info['title'])}',")
        sql_lines.append(f"      \"exam_id\" = COALESCE(v_exam_id, \"exam_id\"),")
        sql_lines.append(f"      \"summary\" = '{escape_sql_literal(course_info['summary'])}',")
        sql_lines.append(f"      \"description\" = '{escape_sql_literal(course_info['description'])}',")
        sql_lines.append(f"      \"position\" = {course_info['position']},")
        sql_lines.append(f"      \"status\" = 'published',")
        sql_lines.append(f"      \"updated_at\" = now()")
        sql_lines.append(f"    WHERE \"id\" = v_course_id;")
        sql_lines.append(f"  END IF;")
        sql_lines.append(f"")
        
        course_lesson_count = 0
        used_slugs = set()
        
        for mod_pos, (folder_name, mod_title) in enumerate(course_info['modules']):
            if not os.path.exists(folder_name):
                print(f"Warning: Folder {folder_name} not found, skipping.")
                continue
                
            pdf_files = sorted([f for f in os.listdir(folder_name) if f.endswith('.pdf')])
            print(f"  -> Module {mod_pos + 1}: {mod_title} ({len(pdf_files)} files)")
            
            sql_lines.append(f"  -- ==========================================")
            sql_lines.append(f"  -- Module {mod_pos + 1}: {mod_title}")
            sql_lines.append(f"  -- ==========================================")
            sql_lines.append(f"  SELECT id INTO v_module_id FROM \"modules\" WHERE \"course_id\" = v_course_id AND \"title\" = '{escape_sql_literal(mod_title)}' AND \"deleted_at\" IS NULL LIMIT 1;")
            sql_lines.append(f"  IF v_module_id IS NULL THEN")
            sql_lines.append(f"    INSERT INTO \"modules\" (\"id\", \"course_id\", \"title\", \"position\", \"created_at\", \"updated_at\")")
            sql_lines.append(f"    VALUES (gen_random_uuid(), v_course_id, '{escape_sql_literal(mod_title)}', {mod_pos}, now(), now())")
            sql_lines.append(f"    RETURNING \"id\" INTO v_module_id;")
            sql_lines.append(f"  ELSE")
            sql_lines.append(f"    UPDATE \"modules\" SET \"position\" = {mod_pos}, \"updated_at\" = now() WHERE \"id\" = v_module_id;")
            sql_lines.append(f"  END IF;")
            sql_lines.append(f"")
            
            for les_pos, pdf_file in enumerate(pdf_files):
                pdf_path = os.path.join(folder_name, pdf_file)
                try:
                    reader = pypdf.PdfReader(pdf_path)
                    raw_text = "\n".join([page.extract_text() for page in reader.pages if page.extract_text()])
                except Exception as e:
                    print(f"    Error reading {pdf_file}: {e}")
                    raw_text = f"Content for {pdf_file}"
                    
                title = clean_lesson_title(pdf_file)
                base_slug = slugify(title)
                slug = base_slug
                counter = 2
                while slug in used_slugs:
                    slug = f"{base_slug}-{counter}"
                    counter += 1
                used_slugs.add(slug)
                
                md_body = clean_lesson_markdown(raw_text, title)
                # First lesson in every module is a free preview
                is_free_preview = "true" if les_pos == 0 else "false"
                
                escaped_body = escape_sql_literal(md_body)
                escaped_title = escape_sql_literal(title)
                
                sql_lines.append(f"  -- Lesson: {title}")
                sql_lines.append(f"  INSERT INTO \"lessons\" (")
                sql_lines.append(f"    \"id\", \"module_id\", \"slug\", \"title\", \"type\", \"body\", \"is_free_preview\", \"position\", \"status\", \"created_at\", \"updated_at\"")
                sql_lines.append(f"  ) VALUES (")
                sql_lines.append(f"    gen_random_uuid(),")
                sql_lines.append(f"    v_module_id,")
                sql_lines.append(f"    '{slug}',")
                sql_lines.append(f"    '{escaped_title}',")
                sql_lines.append(f"    'article',")
                sql_lines.append(f"    '{escaped_body}',")
                sql_lines.append(f"    {is_free_preview},")
                sql_lines.append(f"    {les_pos},")
                sql_lines.append(f"    'published',")
                sql_lines.append(f"    now(),")
                sql_lines.append(f"    now()")
                sql_lines.append(f"  ) ON CONFLICT (\"module_id\", \"slug\") DO UPDATE SET")
                sql_lines.append(f"    \"title\" = EXCLUDED.\"title\",")
                sql_lines.append(f"    \"body\" = EXCLUDED.\"body\",")
                sql_lines.append(f"    \"is_free_preview\" = EXCLUDED.\"is_free_preview\",")
                sql_lines.append(f"    \"position\" = EXCLUDED.\"position\",")
                sql_lines.append(f"    \"status\" = 'published',")
                sql_lines.append(f"    \"updated_at\" = now();")
                sql_lines.append(f"")
                
                course_lesson_count += 1
                total_processed += 1
                
        # Connect course to WhatsApp plan and other plans
        sql_lines.append(f"  -- 3. Connect Course to WhatsApp manual plan & standard plans")
        sql_lines.append(f"  SELECT id INTO v_whatsapp_plan_id FROM \"plans\" WHERE \"family_key\" = 'whatsapp-manual' AND \"deleted_at\" IS NULL LIMIT 1;")
        sql_lines.append(f"  IF v_whatsapp_plan_id IS NOT NULL THEN")
        sql_lines.append(f"    INSERT INTO \"plan_courses\" (\"id\", \"plan_id\", \"course_id\", \"created_at\", \"updated_at\")")
        sql_lines.append(f"    VALUES (gen_random_uuid(), v_whatsapp_plan_id, v_course_id, now(), now())")
        sql_lines.append(f"    ON CONFLICT (\"plan_id\", \"course_id\") DO NOTHING;")
        sql_lines.append(f"  END IF;")
        sql_lines.append(f"")
        sql_lines.append(f"  SELECT id INTO v_primary_plan_id FROM \"plans\" WHERE \"slug\" = 'primary-pass' LIMIT 1;")
        sql_lines.append(f"  IF v_primary_plan_id IS NOT NULL THEN")
        sql_lines.append(f"    INSERT INTO \"plan_courses\" (\"id\", \"plan_id\", \"course_id\", \"created_at\", \"updated_at\")")
        sql_lines.append(f"    VALUES (gen_random_uuid(), v_primary_plan_id, v_course_id, now(), now())")
        sql_lines.append(f"    ON CONFLICT (\"plan_id\", \"course_id\") DO NOTHING;")
        sql_lines.append(f"  END IF;")
        sql_lines.append(f"")
        sql_lines.append(f"  SELECT id INTO v_all_access_plan_id FROM \"plans\" WHERE \"slug\" = 'all-access' LIMIT 1;")
        sql_lines.append(f"  IF v_all_access_plan_id IS NOT NULL THEN")
        sql_lines.append(f"    INSERT INTO \"plan_courses\" (\"id\", \"plan_id\", \"course_id\", \"created_at\", \"updated_at\")")
        sql_lines.append(f"    VALUES (gen_random_uuid(), v_all_access_plan_id, v_course_id, now(), now())")
        sql_lines.append(f"    ON CONFLICT (\"plan_id\", \"course_id\") DO NOTHING;")
        sql_lines.append(f"  END IF;")
        sql_lines.append(f"")
        sql_lines.append(f"  RAISE NOTICE 'Successfully seeded {course_info['title']} ({course_lesson_count} lessons)';")
        sql_lines.append(f"END $$;")
        sql_lines.append(f"")
        
        with open(sql_path, "w", encoding="utf-8") as f:
            f.write("\n".join(sql_lines))
            
        print(f"Generated {sql_filename}: {course_lesson_count} lessons, file size: {os.path.getsize(sql_path)/1024:.1f} KB")

    print(f"\n==========================================")
    print(f"ALL 4 MASTER COURSES GENERATED SUCCESSFULLY!")
    print(f"TOTAL LESSONS PROCESSED: {total_processed}")
    print(f"==========================================")

if __name__ == '__main__':
    process_curriculum()
