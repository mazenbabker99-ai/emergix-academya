import os
import sys
import pypdf
import re
from cleaners import clean_lesson_title, slugify, clean_lesson_markdown

sys.stdout.reconfigure(encoding='utf-8')

OUTPUT_DIR = os.path.join('lib', 'db', 'migrations')
os.makedirs(OUTPUT_DIR, exist_ok=True)

def escape_sql(text: str) -> str:
    return text.replace("'", "''")

# =========================================================================
# 1. PRIMARY CURRICULUM MODULES (21 Modules - 221 Lessons)
# =========================================================================
PRIMARY_MODULES = [
    # Anatomy
    ('UPPER LIMB ANATOMY', 'Upper Limb Anatomy'),
    ('lower limb anatomy', 'Lower Limb Anatomy'),
    ('THORAX ANATOMY', 'Thorax Anatomy & Mediastinum'),
    ('ABDOMEN ANATOMY', 'Abdomen & Peritoneum'),
    ('H&N ANATOMY', 'Head & Neck Anatomy'),
    ('CENTRAL NERVOUS SYSTEM-', 'Central Nervous System & Spine'),
    ('CRANIAL NERVE ANATOMY', 'Cranial Nerves In-Depth'),
    # Physiology
    ('cell physiology', 'Cell Physiology & Membrane Transport'),
    ('cardiac physiology', 'Cardiovascular Physiology & Hemodynamics'),
    ('resp physiolgy', 'Respiratory Physiology & Ventilation'),
    ('renal physilolgy', 'Renal Physiology & Acid-Base Balance'),
    ('git physiology', 'Gastrointestinal (GIT) Physiology'),
    ('endocrine physiology', 'Endocrine Physiology & Metabolism'),
    ('blood physilolgy and pathology', 'Blood Physiology & Coagulation Pathways'),
    # Pharmacology & Toxicology
    ('resp pharma', 'Respiratory Pharmacology & Asthma Management'),
    ('cardio pharma', 'Cardiovascular Pharmacology & Anticoagulants'),
    ('cns pharma', 'CNS Pharmacology & Analgesia'),
    ('anathesia drug', 'Anesthesia & Sedation Drugs'),
    ('drug toxicity', 'Emergency Toxicology & Antidotes'),
    # Pathology & Microbiology
    ('pathology', 'General Pathology, Inflammation & Anemia'),
    ('micro', 'Clinical Microbiology, Bacteria & Antibiotics'),
]

def generate_primary_seed():
    print("\n--- Generating Flagship Course: MRCEM Primary ---")
    sql_path = os.path.join(OUTPUT_DIR, "seed_flagship_mrcem_primary.sql")
    
    course_slug = "mrcem-primary"
    course_title = "MRCEM Primary"
    course_summary = "Comprehensive preparation covering clinical anatomy, applied physiology, emergency pharmacology, pathology, and microbiology."
    course_desc = "Master the complete basic sciences curriculum for the Royal College of Emergency Medicine (RCEM) Primary examination. Features high-yield clinical pearls, anatomical dissection landmarks, systemic physiology, emergency pharmacokinetics, and microbial classifications organized into 21 high-yield topics."
    
    sql = []
    sql.append("-- ==========================================================================")
    sql.append(f"-- FLAGSHIP COURSE: {course_title}")
    sql.append("-- ==========================================================================")
    sql.append("DO $$")
    sql.append("DECLARE")
    sql.append("  v_exam_id uuid;")
    sql.append("  v_course_id uuid;")
    sql.append("  v_module_id uuid;")
    sql.append("  v_whatsapp_plan_id uuid;")
    sql.append("  v_primary_plan_id uuid;")
    sql.append("  v_all_access_plan_id uuid;")
    sql.append("BEGIN")
    sql.append("  -- 1. Locate MRCEM Primary exam")
    sql.append("  SELECT id INTO v_exam_id FROM \"exams\" WHERE \"slug\" = 'mrcem-primary' LIMIT 1;")
    sql.append("")
    sql.append("  -- 2. Upsert Course: mrcem-primary")
    sql.append("  SELECT id INTO v_course_id FROM \"courses\" WHERE \"slug\" = 'mrcem-primary' LIMIT 1;")
    sql.append("  IF v_course_id IS NULL THEN")
    sql.append("    INSERT INTO \"courses\" (")
    sql.append("      \"id\", \"exam_id\", \"slug\", \"title\", \"summary\", \"description\", \"is_free\", \"position\", \"status\", \"created_at\", \"updated_at\"")
    sql.append("    ) VALUES (")
    sql.append("      gen_random_uuid(),")
    sql.append("      v_exam_id,")
    sql.append("      'mrcem-primary',")
    sql.append(f"      '{escape_sql(course_title)}',")
    sql.append(f"      '{escape_sql(course_summary)}',")
    sql.append(f"      '{escape_sql(course_desc)}',")
    sql.append("      false,")
    sql.append("      1,")
    sql.append("      'published',")
    sql.append("      now(),")
    sql.append("      now()")
    sql.append("    ) RETURNING \"id\" INTO v_course_id;")
    sql.append("  ELSE")
    sql.append("    UPDATE \"courses\" SET")
    sql.append(f"      \"title\" = '{escape_sql(course_title)}',")
    sql.append("      \"exam_id\" = COALESCE(v_exam_id, \"exam_id\"),")
    sql.append(f"      \"summary\" = '{escape_sql(course_summary)}',")
    sql.append(f"      \"description\" = '{escape_sql(course_desc)}',")
    sql.append("      \"position\" = 1,")
    sql.append("      \"status\" = 'published',")
    sql.append("      \"deleted_at\" = NULL,")
    sql.append("      \"updated_at\" = now()")
    sql.append("    WHERE \"id\" = v_course_id;")
    sql.append("  END IF;")
    sql.append("")
    
    total_lessons = 0
    used_slugs = set()
    
    for mod_pos, (folder_name, mod_title) in enumerate(PRIMARY_MODULES):
        if not os.path.exists(folder_name):
            print(f"Skipping missing folder: {folder_name}")
            continue
            
        pdf_files = sorted([f for f in os.listdir(folder_name) if f.endswith('.pdf')])
        print(f"  -> Module {mod_pos + 1}: {mod_title} ({len(pdf_files)} lessons)")
        
        sql.append(f"  -- Module {mod_pos + 1}: {mod_title}")
        sql.append(f"  SELECT id INTO v_module_id FROM \"modules\" WHERE \"course_id\" = v_course_id AND \"title\" = '{escape_sql(mod_title)}' AND \"deleted_at\" IS NULL LIMIT 1;")
        sql.append("  IF v_module_id IS NULL THEN")
        sql.append(f"    INSERT INTO \"modules\" (\"id\", \"course_id\", \"title\", \"position\", \"created_at\", \"updated_at\")")
        sql.append(f"    VALUES (gen_random_uuid(), v_course_id, '{escape_sql(mod_title)}', {mod_pos}, now(), now())")
        sql.append("    RETURNING \"id\" INTO v_module_id;")
        sql.append("  ELSE")
        sql.append(f"    UPDATE \"modules\" SET \"position\" = {mod_pos}, \"updated_at\" = now() WHERE \"id\" = v_module_id;")
        sql.append("  END IF;")
        sql.append("")
        
        for les_pos, pdf_file in enumerate(pdf_files):
            pdf_path = os.path.join(folder_name, pdf_file)
            try:
                reader = pypdf.PdfReader(pdf_path)
                raw_text = "\n".join([page.extract_text() for page in reader.pages if page.extract_text()])
            except Exception as e:
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
            is_free_preview = "true" if les_pos == 0 else "false"
            
            sql.append(f"  -- Lesson: {title}")
            sql.append("  INSERT INTO \"lessons\" (")
            sql.append("    \"id\", \"module_id\", \"slug\", \"title\", \"type\", \"body\", \"is_free_preview\", \"position\", \"status\", \"created_at\", \"updated_at\"")
            sql.append("  ) VALUES (")
            sql.append("    gen_random_uuid(),")
            sql.append("    v_module_id,")
            sql.append(f"    '{slug}',")
            sql.append(f"    '{escape_sql(title)}',")
            sql.append("    'article',")
            sql.append(f"    '{escape_sql(md_body)}',")
            sql.append(f"    {is_free_preview},")
            sql.append(f"    {les_pos},")
            sql.append("    'published',")
            sql.append("    now(),")
            sql.append("    now()")
            sql.append("  ) ON CONFLICT (\"module_id\", \"slug\") DO UPDATE SET")
            sql.append("    \"title\" = EXCLUDED.\"title\",")
            sql.append("    \"body\" = EXCLUDED.\"body\",")
            sql.append("    \"is_free_preview\" = EXCLUDED.\"is_free_preview\",")
            sql.append("    \"position\" = EXCLUDED.\"position\",")
            sql.append("    \"status\" = 'published',")
            sql.append("    \"updated_at\" = now();")
            sql.append("")
            total_lessons += 1
            
    # Connect course to WhatsApp manual plan & standard plans
    sql.append("  -- 3. Connect Course to WhatsApp manual plan & standard plans")
    sql.append("  SELECT id INTO v_whatsapp_plan_id FROM \"plans\" WHERE \"family_key\" = 'whatsapp-manual' AND \"deleted_at\" IS NULL LIMIT 1;")
    sql.append("  IF v_whatsapp_plan_id IS NOT NULL THEN")
    sql.append("    INSERT INTO \"plan_courses\" (\"id\", \"plan_id\", \"course_id\", \"created_at\", \"updated_at\")")
    sql.append("    VALUES (gen_random_uuid(), v_whatsapp_plan_id, v_course_id, now(), now())")
    sql.append("    ON CONFLICT (\"plan_id\", \"course_id\") DO NOTHING;")
    sql.append("  END IF;")
    sql.append("")
    sql.append("  SELECT id INTO v_primary_plan_id FROM \"plans\" WHERE \"slug\" = 'primary-pass' LIMIT 1;")
    sql.append("  IF v_primary_plan_id IS NOT NULL THEN")
    sql.append("    INSERT INTO \"plan_courses\" (\"id\", \"plan_id\", \"course_id\", \"created_at\", \"updated_at\")")
    sql.append("    VALUES (gen_random_uuid(), v_primary_plan_id, v_course_id, now(), now())")
    sql.append("    ON CONFLICT (\"plan_id\", \"course_id\") DO NOTHING;")
    sql.append("  END IF;")
    sql.append("")
    sql.append("  SELECT id INTO v_all_access_plan_id FROM \"plans\" WHERE \"slug\" = 'all-access' LIMIT 1;")
    sql.append("  IF v_all_access_plan_id IS NOT NULL THEN")
    sql.append("    INSERT INTO \"plan_courses\" (\"id\", \"plan_id\", \"course_id\", \"created_at\", \"updated_at\")")
    sql.append("    VALUES (gen_random_uuid(), v_all_access_plan_id, v_course_id, now(), now())")
    sql.append("    ON CONFLICT (\"plan_id\", \"course_id\") DO NOTHING;")
    sql.append("  END IF;")
    sql.append("")
    sql.append(f"  RAISE NOTICE 'Successfully seeded MRCEM Primary with {total_lessons} lessons across {len(PRIMARY_MODULES)} modules.';")
    sql.append("END $$;")
    
    with open(sql_path, "w", encoding="utf-8") as f:
        f.write("\n".join(sql))
        
    print(f"Generated {sql_path}: {total_lessons} lessons, {os.path.getsize(sql_path)/1024:.1f} KB")

# =========================================================================
# 2. SBA CURRICULUM MODULES (5 Modules - 47 Lessons)
# =========================================================================
def clean_quiz_markdown(raw_text: str, title: str) -> str:
    text = raw_text
    text = re.sub(r'\d{2}/\d{2}/\d{4},\s*\d{2}:\d{2}\s*.*?\|.*?LLC', '', text, flags=re.IGNORECASE)
    text = re.sub(r'https?://[^\s]+', '', text)
    text = re.sub(r'Restart quiz[^\n]*\n', '', text, flags=re.IGNORECASE)
    text = re.sub(r'Your score is[^\n]*\n', '', text, flags=re.IGNORECASE)
    text = re.sub(r'The average score[^\n]*\n', '', text, flags=re.IGNORECASE)
    text = re.sub(r'LinkedIn\s*Facebook\s*Twitter[^\n]*\n', '', text, flags=re.IGNORECASE)
    text = re.sub(r'Overview\s+Comments[^\n]*\n', '', text, flags=re.IGNORECASE)
    text = re.sub(r'[\ue000-\uf8ff]', '', text)
    
    lines = [l.strip() for l in text.split('\n')]
    formatted = []
    in_explanation = False
    
    for line in lines:
        if not line:
            if formatted and formatted[-1] != "":
                formatted.append("")
            continue
            
        q_num_match = re.match(r'^(\d+)\s*/\s*(\d+)$', line)
        if q_num_match:
            formatted.append("")
            formatted.append(f"## Question {q_num_match.group(1)} of {q_num_match.group(2)}")
            formatted.append("")
            in_explanation = False
            continue
            
        opt_match = re.match(r'^([A-E])[\.\:]\s*(.*)$', line)
        if opt_match:
            formatted.append(f"- **{opt_match.group(1)}.** {opt_match.group(2)}")
            continue
            
        if re.search(r'^(Explanation:?|Rationale:?|Discussion:?|Clinical pearls?:?)', line, flags=re.IGNORECASE):
            formatted.append("")
            formatted.append(f"> [!TIP]\n> **{line}**")
            in_explanation = True
            continue
            
        if in_explanation:
            formatted.append(f"> {line}")
            if line.endswith('.'):
                in_explanation = False
                formatted.append("")
        else:
            formatted.append(line)
            
    body = '\n'.join(formatted)
    body = re.sub(r'\n{3,}', '\n\n', body).strip()
    return f"# {title}\n\n> [!NOTE]\n> **Instructions:** Single best answer scenario. Read carefully before reviewing the detailed rationale.\n\n" + body

def generate_sba_seed():
    print("\n--- Generating Flagship Course: MRCEM SBA ---")
    sql_path = os.path.join(OUTPUT_DIR, "seed_flagship_mrcem_sba.sql")
    
    course_slug = "mrcem-sba"
    course_title = "MRCEM SBA"
    course_summary = "High-yield Single Best Answer (SBA) question bank and timed mock exam simulation papers with full clinical rationales."
    course_desc = "Master the MRCEM SBA (Intermediate) examination with over 600 single best answer questions. Features 41 topical SBA quizzes and 3 full mock exam simulation papers with comprehensive explanations, examiner pearls, and diagnostic algorithms."
    
    sql = []
    sql.append("-- ==========================================================================")
    sql.append(f"-- FLAGSHIP COURSE: {course_title}")
    sql.append("-- ==========================================================================")
    sql.append("DO $$")
    sql.append("DECLARE")
    sql.append("  v_exam_id uuid;")
    sql.append("  v_course_id uuid;")
    sql.append("  v_module_id uuid;")
    sql.append("  v_whatsapp_plan_id uuid;")
    sql.append("  v_primary_plan_id uuid;")
    sql.append("  v_all_access_plan_id uuid;")
    sql.append("BEGIN")
    sql.append("  -- 1. Locate MRCEM SBA exam (fallback to primary if exam slug differs)")
    sql.append("  SELECT id INTO v_exam_id FROM \"exams\" WHERE \"slug\" = 'mrcem-sba' LIMIT 1;")
    sql.append("  IF v_exam_id IS NULL THEN")
    sql.append("    SELECT id INTO v_exam_id FROM \"exams\" WHERE \"slug\" = 'mrcem-primary' LIMIT 1;")
    sql.append("  END IF;")
    sql.append("")
    sql.append("  -- 2. Upsert Course: mrcem-sba")
    sql.append("  SELECT id INTO v_course_id FROM \"courses\" WHERE \"slug\" = 'mrcem-sba' LIMIT 1;")
    sql.append("  IF v_course_id IS NULL THEN")
    sql.append("    INSERT INTO \"courses\" (")
    sql.append("      \"id\", \"exam_id\", \"slug\", \"title\", \"summary\", \"description\", \"is_free\", \"position\", \"status\", \"created_at\", \"updated_at\"")
    sql.append("    ) VALUES (")
    sql.append("      gen_random_uuid(),")
    sql.append("      v_exam_id,")
    sql.append("      'mrcem-sba',")
    sql.append(f"      '{escape_sql(course_title)}',")
    sql.append(f"      '{escape_sql(course_summary)}',")
    sql.append(f"      '{escape_sql(course_desc)}',")
    sql.append("      false,")
    sql.append("      2,")
    sql.append("      'published',")
    sql.append("      now(),")
    sql.append("      now()")
    sql.append("    ) RETURNING \"id\" INTO v_course_id;")
    sql.append("  ELSE")
    sql.append("    UPDATE \"courses\" SET")
    sql.append(f"      \"title\" = '{escape_sql(course_title)}',")
    sql.append("      \"exam_id\" = COALESCE(v_exam_id, \"exam_id\"),")
    sql.append(f"      \"summary\" = '{escape_sql(course_summary)}',")
    sql.append(f"      \"description\" = '{escape_sql(course_desc)}',")
    sql.append("      \"position\" = 2,")
    sql.append("      \"status\" = 'published',")
    sql.append("      \"deleted_at\" = NULL,")
    sql.append("      \"updated_at\" = now()")
    sql.append("    WHERE \"id\" = v_course_id;")
    sql.append("  END IF;")
    sql.append("")
    
    quiz_folder = 'QUIZ 1 TO 41'
    quiz_files = []
    if os.path.exists(quiz_folder):
        all_q = [f for f in os.listdir(quiz_folder) if f.endswith('.pdf')]
        def quiz_num(fname):
            m = re.search(r'QUIZ\s*_\s*(\d+)', fname, re.I)
            return int(m.group(1)) if m else 999
        quiz_files = sorted(all_q, key=quiz_num)
        
    modules = [
        ("High-Yield SBA Quizzes: Part 1 (Quizzes 01 - 10)", quiz_files[:10]),
        ("High-Yield SBA Quizzes: Part 2 (Quizzes 11 - 20)", quiz_files[10:20]),
        ("High-Yield SBA Quizzes: Part 3 (Quizzes 21 - 30)", quiz_files[20:30]),
        ("High-Yield SBA Quizzes: Part 4 (Quizzes 31 - 41)", quiz_files[30:]),
    ]
    
    mock_files = []
    for mdir in ['MOK 1', 'MOCK – II PAPER', 'MOCK III']:
        if os.path.exists(mdir):
            for f in sorted(os.listdir(mdir)):
                if f.endswith('.pdf'):
                    mock_files.append((mdir, f))
    modules.append(("MRCEM SBA Mock Simulations", mock_files))
    
    total_lessons = 0
    used_slugs = set()
    
    for mod_pos, (mod_title, files) in enumerate(modules):
        sql.append(f"  -- Module {mod_pos + 1}: {mod_title}")
        sql.append(f"  SELECT id INTO v_module_id FROM \"modules\" WHERE \"course_id\" = v_course_id AND \"title\" = '{escape_sql(mod_title)}' AND \"deleted_at\" IS NULL LIMIT 1;")
        sql.append("  IF v_module_id IS NULL THEN")
        sql.append(f"    INSERT INTO \"modules\" (\"id\", \"course_id\", \"title\", \"position\", \"created_at\", \"updated_at\")")
        sql.append(f"    VALUES (gen_random_uuid(), v_course_id, '{escape_sql(mod_title)}', {mod_pos}, now(), now())")
        sql.append("    RETURNING \"id\" INTO v_module_id;")
        sql.append("  ELSE")
        sql.append(f"    UPDATE \"modules\" SET \"position\" = {mod_pos}, \"updated_at\" = now() WHERE \"id\" = v_module_id;")
        sql.append("  END IF;")
        sql.append("")
        
        for les_pos, item in enumerate(files):
            if isinstance(item, tuple):
                fdir, fname = item
                pdf_path = os.path.join(fdir, fname)
            else:
                fname = item
                pdf_path = os.path.join(quiz_folder, fname)
                
            try:
                reader = pypdf.PdfReader(pdf_path)
                raw_text = "\n".join([page.extract_text() for page in reader.pages if page.extract_text()])
            except Exception:
                raw_text = f"Quiz file {fname}"
                
            title = clean_lesson_title(fname)
            base_slug = slugify(title)
            slug = base_slug
            counter = 2
            while slug in used_slugs:
                slug = f"{base_slug}-{counter}"
                counter += 1
            used_slugs.add(slug)
            
            md_body = clean_quiz_markdown(raw_text, title)
            is_free_preview = "true" if (mod_pos == 0 and les_pos == 0) else "false"
            
            sql.append(f"  -- Lesson: {title}")
            sql.append("  INSERT INTO \"lessons\" (")
            sql.append("    \"id\", \"module_id\", \"slug\", \"title\", \"type\", \"body\", \"is_free_preview\", \"position\", \"status\", \"created_at\", \"updated_at\"")
            sql.append("  ) VALUES (")
            sql.append("    gen_random_uuid(),")
            sql.append("    v_module_id,")
            sql.append(f"    '{slug}',")
            sql.append(f"    '{escape_sql(title)}',")
            sql.append("    'article',")
            sql.append(f"    '{escape_sql(md_body)}',")
            sql.append(f"    {is_free_preview},")
            sql.append(f"    {les_pos},")
            sql.append("    'published',")
            sql.append("    now(),")
            sql.append("    now()")
            sql.append("  ) ON CONFLICT (\"module_id\", \"slug\") DO UPDATE SET")
            sql.append("    \"title\" = EXCLUDED.\"title\",")
            sql.append("    \"body\" = EXCLUDED.\"body\",")
            sql.append("    \"is_free_preview\" = EXCLUDED.\"is_free_preview\",")
            sql.append("    \"position\" = EXCLUDED.\"position\",")
            sql.append("    \"status\" = 'published',")
            sql.append("    \"updated_at\" = now();")
            sql.append("")
            total_lessons += 1
            
    # Connect course to plans
    sql.append("  -- 3. Connect Course to WhatsApp manual plan & standard plans")
    sql.append("  SELECT id INTO v_whatsapp_plan_id FROM \"plans\" WHERE \"family_key\" = 'whatsapp-manual' AND \"deleted_at\" IS NULL LIMIT 1;")
    sql.append("  IF v_whatsapp_plan_id IS NOT NULL THEN")
    sql.append("    INSERT INTO \"plan_courses\" (\"id\", \"plan_id\", \"course_id\", \"created_at\", \"updated_at\")")
    sql.append("    VALUES (gen_random_uuid(), v_whatsapp_plan_id, v_course_id, now(), now())")
    sql.append("    ON CONFLICT (\"plan_id\", \"course_id\") DO NOTHING;")
    sql.append("  END IF;")
    sql.append("")
    sql.append("  SELECT id INTO v_primary_plan_id FROM \"plans\" WHERE \"slug\" = 'primary-pass' LIMIT 1;")
    sql.append("  IF v_primary_plan_id IS NOT NULL THEN")
    sql.append("    INSERT INTO \"plan_courses\" (\"id\", \"plan_id\", \"course_id\", \"created_at\", \"updated_at\")")
    sql.append("    VALUES (gen_random_uuid(), v_primary_plan_id, v_course_id, now(), now())")
    sql.append("    ON CONFLICT (\"plan_id\", \"course_id\") DO NOTHING;")
    sql.append("  END IF;")
    sql.append("")
    sql.append("  SELECT id INTO v_all_access_plan_id FROM \"plans\" WHERE \"slug\" = 'all-access' LIMIT 1;")
    sql.append("  IF v_all_access_plan_id IS NOT NULL THEN")
    sql.append("    INSERT INTO \"plan_courses\" (\"id\", \"plan_id\", \"course_id\", \"created_at\", \"updated_at\")")
    sql.append("    VALUES (gen_random_uuid(), v_all_access_plan_id, v_course_id, now(), now())")
    sql.append("    ON CONFLICT (\"plan_id\", \"course_id\") DO NOTHING;")
    sql.append("  END IF;")
    sql.append("")
    sql.append(f"  RAISE NOTICE 'Successfully seeded MRCEM SBA with {total_lessons} lessons across {len(modules)} modules.';")
    sql.append("END $$;")
    
    with open(sql_path, "w", encoding="utf-8") as f:
        f.write("\n".join(sql))
        
    print(f"Generated {sql_path}: {total_lessons} lessons, {os.path.getsize(sql_path)/1024:.1f} KB")

# =========================================================================
# 3. CLEANUP SCRIPT: ARCHIVE UNWANTED FRAGMENTED COURSES
# =========================================================================
def generate_cleanup_script():
    sql_path = os.path.join(OUTPUT_DIR, "cleanup_courses.sql")
    sql = """-- Cleanup: Keep ONLY the two flagship courses: 'mrcem-primary' and 'mrcem-sba'
UPDATE "courses"
SET "status" = 'archived', "deleted_at" = now()
WHERE "slug" NOT IN ('mrcem-primary', 'mrcem-sba') AND "deleted_at" IS NULL;
"""
    with open(sql_path, "w", encoding="utf-8") as f:
        f.write(sql)
    print(f"Generated {sql_path}")

if __name__ == '__main__':
    generate_primary_seed()
    generate_sba_seed()
    generate_cleanup_script()
