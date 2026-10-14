import os
import sys
import pypdf
import re
from cleaners import clean_lesson_title, slugify, clean_lesson_markdown

sys.stdout.reconfigure(encoding='utf-8')

OUTPUT_DIR = os.path.join('lib', 'db', 'migrations')
os.makedirs(OUTPUT_DIR, exist_ok=True)

def escape_sql_literal(text: str) -> str:
    return text.replace("'", "''")

def clean_quiz_markdown(raw_text: str, title: str) -> str:
    """Formats quiz questions, options, and rationales into structured, readable Markdown."""
    text = raw_text
    # Remove web headers/footers
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
            
        # Question counter like '1 / 15'
        q_num_match = re.match(r'^(\d+)\s*/\s*(\d+)$', line)
        if q_num_match:
            formatted.append("")
            formatted.append(f"## Question {q_num_match.group(1)} of {q_num_match.group(2)}")
            formatted.append("")
            in_explanation = False
            continue
            
        # Options A, B, C, D, E
        opt_match = re.match(r'^([A-E])[\.\:]\s*(.*)$', line)
        if opt_match:
            formatted.append(f"- **{opt_match.group(1)}.** {opt_match.group(2)}")
            continue
            
        # Clinical explanation / high yield notes
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
    return f"# {title}\n\n> [!NOTE]\n> **Practice Session Instructions:** Review each single best answer (SBA) scenario carefully. Consider your answer before reviewing the clinical explanation and high-yield pearls.\n\n" + body

def generate_qbank_seed():
    print("Generating Question Bank & Mock Seed...")
    sql_path = os.path.join(OUTPUT_DIR, "seed_mrcem_question_bank.sql")
    
    course_slug = "mrcem-question-bank"
    course_title = "MRCEM Primary: SBA Question Bank & Mock Simulations"
    course_summary = "41 High-yield topical SBA quizzes and 3 full mock exam simulation papers (6 complete papers) with clinical explanations."
    course_desc = "Master the MRCEM Primary examination format with over 600 single best answer questions. Test your clinical reasoning across anatomy, physiology, pharmacology, and pathology with detailed rationales, examiner tips, and high-yield pearls."
    
    sql_lines = []
    sql_lines.append(f"-- ==========================================================================")
    sql_lines.append(f"-- SEED SCRIPT: {course_title}")
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
    sql_lines.append(f"  SELECT id INTO v_exam_id FROM \"exams\" WHERE \"slug\" = 'mrcem-primary' LIMIT 1;")
    sql_lines.append(f"")
    sql_lines.append(f"  -- Upsert Course")
    sql_lines.append(f"  SELECT id INTO v_course_id FROM \"courses\" WHERE \"slug\" = '{course_slug}' LIMIT 1;")
    sql_lines.append(f"  IF v_course_id IS NULL THEN")
    sql_lines.append(f"    INSERT INTO \"courses\" (")
    sql_lines.append(f"      \"id\", \"exam_id\", \"slug\", \"title\", \"summary\", \"description\", \"is_free\", \"position\", \"status\", \"created_at\", \"updated_at\"")
    sql_lines.append(f"    ) VALUES (")
    sql_lines.append(f"      gen_random_uuid(),")
    sql_lines.append(f"      v_exam_id,")
    sql_lines.append(f"      '{course_slug}',")
    sql_lines.append(f"      '{escape_sql_literal(course_title)}',")
    sql_lines.append(f"      '{escape_sql_literal(course_summary)}',")
    sql_lines.append(f"      '{escape_sql_literal(course_desc)}',")
    sql_lines.append(f"      false,")
    sql_lines.append(f"      5,")
    sql_lines.append(f"      'published',")
    sql_lines.append(f"      now(),")
    sql_lines.append(f"      now()")
    sql_lines.append(f"    ) RETURNING \"id\" INTO v_course_id;")
    sql_lines.append(f"  ELSE")
    sql_lines.append(f"    UPDATE \"courses\" SET")
    sql_lines.append(f"      \"title\" = '{escape_sql_literal(course_title)}',")
    sql_lines.append(f"      \"exam_id\" = COALESCE(v_exam_id, \"exam_id\"),")
    sql_lines.append(f"      \"summary\" = '{escape_sql_literal(course_summary)}',")
    sql_lines.append(f"      \"description\" = '{escape_sql_literal(course_desc)}',")
    sql_lines.append(f"      \"position\" = 5,")
    sql_lines.append(f"      \"status\" = 'published',")
    sql_lines.append(f"      \"updated_at\" = now()")
    sql_lines.append(f"    WHERE \"id\" = v_course_id;")
    sql_lines.append(f"  END IF;")
    sql_lines.append(f"")
    
    # 4 Modules for Quizzes 1-41
    # 1 Module for Mock Exams
    quiz_folder = 'QUIZ 1 TO 41'
    quiz_files = []
    if os.path.exists(quiz_folder):
        all_q = [f for f in os.listdir(quiz_folder) if f.endswith('.pdf')]
        # Sort numerically
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
    
    # Collect Mock exam files
    mock_files = []
    for mdir in ['MOK 1', 'MOCK – II PAPER', 'MOCK III']:
        if os.path.exists(mdir):
            for f in sorted(os.listdir(mdir)):
                if f.endswith('.pdf'):
                    mock_files.append((mdir, f))
                    
    modules.append(("MRCEM Primary Full Mock Simulations", mock_files))
    
    total_q_lessons = 0
    used_slugs = set()
    
    for mod_pos, (mod_title, files) in enumerate(modules):
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
            except Exception as e:
                print(f"Error reading {pdf_path}: {e}")
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
            
            sql_lines.append(f"  -- Quiz Lesson: {title}")
            sql_lines.append(f"  INSERT INTO \"lessons\" (")
            sql_lines.append(f"    \"id\", \"module_id\", \"slug\", \"title\", \"type\", \"body\", \"is_free_preview\", \"position\", \"status\", \"created_at\", \"updated_at\"")
            sql_lines.append(f"  ) VALUES (")
            sql_lines.append(f"    gen_random_uuid(),")
            sql_lines.append(f"    v_module_id,")
            sql_lines.append(f"    '{slug}',")
            sql_lines.append(f"    '{escape_sql_literal(title)}',")
            sql_lines.append(f"    'article',")
            sql_lines.append(f"    '{escape_sql_literal(md_body)}',")
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
            total_q_lessons += 1
            
    sql_lines.append(f"  -- Connect Course to WhatsApp manual plan & standard plans")
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
    sql_lines.append(f"  RAISE NOTICE 'Successfully seeded Question Bank & Mocks ({total_q_lessons} lessons)';")
    sql_lines.append(f"END $$;")
    sql_lines.append(f"")
    
    with open(sql_path, "w", encoding="utf-8") as f:
        f.write("\n".join(sql_lines))
        
    print(f"Generated seed_mrcem_question_bank.sql: {total_q_lessons} lessons ({os.path.getsize(sql_path)/1024:.1f} KB)")

if __name__ == '__main__':
    generate_qbank_seed()
