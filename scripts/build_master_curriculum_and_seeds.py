import os
import sys
import pypdf
import re
from cleaners import clean_lesson_title, slugify, clean_lesson_markdown

sys.stdout.reconfigure(encoding='utf-8')

OUTPUT_DIR = os.path.join('lib', 'db', 'migrations')
BASE_IMG_DIR = os.path.join('artifacts', 'oscepass', 'public', 'lessons', 'images')
os.makedirs(OUTPUT_DIR, exist_ok=True)

def escape_sql(text: str) -> str:
    """Escapes single quotes for PostgreSQL string literals."""
    return text.replace("'", "''")

# 21 Basic Science Modules in Curriculum Sequence
ALL_MODULES = [
    # Anatomy (7 modules - 65 lessons)
    ('UPPER LIMB ANATOMY', 'upper-limb-anatomy', 'Upper Limb Anatomy'),
    ('lower limb anatomy', 'lower-limb-anatomy', 'Lower Limb Anatomy'),
    ('THORAX ANATOMY', 'thorax-anatomy-mediastinum', 'Thorax Anatomy & Mediastinum'),
    ('ABDOMEN ANATOMY', 'abdomen-peritoneum', 'Abdomen & Peritoneum'),
    ('H&N ANATOMY', 'head-neck-anatomy', 'Head & Neck Anatomy'),
    ('CENTRAL NERVOUS SYSTEM-', 'central-nervous-system-spine', 'Central Nervous System & Spine'),
    ('CRANIAL NERVE ANATOMY', 'cranial-nerves-in-depth', 'Cranial Nerves In-Depth'),
    # Physiology (7 modules - 99 lessons)
    ('cell physiology', 'cell-physiology-membrane-transport', 'Cell Physiology & Membrane Transport'),
    ('cardiac physiology', 'cardiovascular-physiology-hemodynamics', 'Cardiovascular Physiology & Hemodynamics'),
    ('resp physiolgy', 'respiratory-physiology-ventilation', 'Respiratory Physiology & Ventilation'),
    ('renal physilolgy', 'renal-physiology-acid-base-balance', 'Renal Physiology & Acid-Base Balance'),
    ('git physiology', 'gastrointestinal-git-physiology', 'Gastrointestinal (GIT) Physiology'),
    ('endocrine physiology', 'endocrine-physiology-metabolism', 'Endocrine Physiology & Metabolism'),
    ('blood physilolgy and pathology', 'blood-physiology-coagulation-pathways', 'Blood Physiology & Coagulation Pathways'),
    # Pharmacology & Toxicology (5 modules - 24 lessons)
    ('resp pharma', 'respiratory-pharmacology-asthma-management', 'Respiratory Pharmacology & Asthma Management'),
    ('cardio pharma', 'cardiovascular-pharmacology-anticoagulants', 'Cardiovascular Pharmacology & Anticoagulants'),
    ('cns pharma', 'cns-pharmacology-analgesia', 'CNS Pharmacology & Analgesia'),
    ('anathesia drug', 'anesthesia-sedation-drugs', 'Anesthesia & Sedation Drugs'),
    ('drug toxicity', 'emergency-toxicology-antidotes', 'Emergency Toxicology & Antidotes'),
    # Pathology & Microbiology (2 modules - 33 lessons)
    ('pathology', 'general-pathology-inflammation-anemia', 'General Pathology, Inflammation & Anemia'),
    ('micro', 'clinical-microbiology-bacteria-antibiotics', 'Clinical Microbiology, Bacteria & Antibiotics'),
]

COURSES = [
    {
        'slug': 'mrcem-primary',
        'title': 'MRCEM Primary: Complete Flagship Masterclass',
        'summary': 'Comprehensive basic sciences curriculum covering clinical anatomy, applied physiology, emergency pharmacology, pathology, and microbiology.',
        'description': 'The complete flagship preparation course for the Royal College of Emergency Medicine (RCEM) Primary examination. Includes all 21 core curriculum modules, 221 detailed lecture notes, 269 embedded anatomical and clinical figures, and interactive topic knowledge checks.',
        'position': 1,
        'modules': ALL_MODULES,
    },
    {
        'slug': 'mrcem-anatomy',
        'title': 'MRCEM Primary: Clinical Anatomy Masterclass',
        'summary': 'Comprehensive clinical anatomy covering upper & lower limbs, thorax, abdomen, head & neck, CNS, and cranial nerves.',
        'description': 'Master the essential clinical anatomy required for the Royal College of Emergency Medicine (RCEM) Primary exam. Features high-yield mnemonics, dissection landmarks, and high-resolution anatomical illustrations organized into 7 focused clinical modules.',
        'position': 2,
        'modules': ALL_MODULES[0:7],
    },
    {
        'slug': 'mrcem-physiology',
        'title': 'MRCEM Primary: Applied Emergency Physiology',
        'summary': 'In-depth physiological principles from cell membrane dynamics to cardiovascular, respiratory, renal, and acid-base disorders.',
        'description': 'Clinical and applied emergency physiology covering cellular transport, cardiac cycle, hemodynamics, respiratory mechanics, gas exchange, renal autoregulation, endocrinology, and hematology tailored for MRCEM Primary.',
        'position': 3,
        'modules': ALL_MODULES[7:14],
    },
    {
        'slug': 'mrcem-pharmacology',
        'title': 'MRCEM Primary: Emergency Pharmacology & Toxicology',
        'summary': 'High-yield pharmacology of emergency resuscitation drugs, cardiovascular agents, analgesics, anesthetics, and acute toxidromes.',
        'description': 'Essential pharmacokinetics, mechanisms of action, adverse effects, and overdose management for emergency physicians. Covers bronchodilators, antiplatelets, anesthetics, and emergency antidotes.',
        'position': 4,
        'modules': ALL_MODULES[14:19],
    },
    {
        'slug': 'mrcem-pathology-micro',
        'title': 'MRCEM Primary: Pathology & Clinical Microbiology',
        'summary': 'High-frequency pathology and microbiology covering bacterial classification, antibiotic resistance, cellular injury, and inflammation.',
        'description': 'Master microbial pathogens, diagnostic methods, antibiotic coverage, immune hypersensitivity reactions, cellular injury, and systemic pathology tested in MRCEM Primary.',
        'position': 5,
        'modules': ALL_MODULES[19:21],
    },
]

def build_lesson_markdown(folder: str, pdf_file: str, mod_slug: str) -> tuple[str, str, int]:
    """Extracts text and embeds images page by page into rich medical Markdown."""
    pdf_path = os.path.join(folder, pdf_file)
    title = clean_lesson_title(pdf_file)
    les_slug = slugify(title)
    
    img_dir = os.path.join(BASE_IMG_DIR, mod_slug, les_slug)
    imgs = sorted([f for f in os.listdir(img_dir) if f.endswith(('.png', '.jpg', '.jpeg', '.webp'))]) if os.path.exists(img_dir) else []
    
    # Map page -> images
    page_images: dict[int, list[str]] = {}
    used_images = set()
    for img in imgs:
        m = re.search(r'_p(\d+)\.', img)
        if m:
            p = int(m.group(1))
            page_images.setdefault(p, []).append(img)
    
    reader = pypdf.PdfReader(pdf_path)
    full_content: list[str] = []
    fig_counter = 1
    
    for p_idx, page in enumerate(reader.pages):
        p_num = p_idx + 1
        p_text = page.extract_text() or ''
        cleaned_p_text = clean_lesson_markdown(p_text, '').replace(f'# \n\n', '').strip()
        
        if cleaned_p_text:
            if full_content and not full_content[-1].startswith('![') and not full_content[-1].endswith(('.', ':', '!', '?', '>', '#', ')')) and cleaned_p_text[0].islower():
                # Seamlessly rejoin sentence broken across page boundary
                full_content[-1] = full_content[-1] + " " + cleaned_p_text
            else:
                full_content.append(cleaned_p_text)
            
        if p_num in page_images:
            for img in page_images[p_num]:
                used_images.add(img)
                img_url = f"/lessons/images/{mod_slug}/{les_slug}/{img}"
                caption = f"{title} — Clinical Figure {fig_counter} (Page {p_num} Reference)"
                full_content.append(f"![{title} - Clinical Figure {fig_counter}]({img_url})\n*{caption}*")
                fig_counter += 1
                
    # Any residual unmapped images appended defensively
    remaining = [img for img in imgs if img not in used_images]
    if remaining:
        full_content.append("## Additional Clinical Illustrations")
        for img in remaining:
            img_url = f"/lessons/images/{mod_slug}/{les_slug}/{img}"
            full_content.append(f"![{title} - Reference]({img_url})\n*{title} — Anatomical Reference*")
            
    final_md = f"# {title}\n\n" + "\n\n".join(full_content)
    return title, final_md, len(imgs)

def generate_course_seed(course_def: dict):
    slug = course_def['slug']
    title = course_def['title']
    summary = course_def['summary']
    desc = course_def['description']
    pos = course_def['position']
    modules = course_def['modules']
    
    sql_filename = f"seed_{slug.replace('-', '_')}.sql"
    if slug == 'mrcem-primary':
        sql_filename = "seed_flagship_mrcem_primary.sql"
    sql_path = os.path.join(OUTPUT_DIR, sql_filename)
    
    print(f"\n==========================================")
    print(f"Generating Seed for: {title} ({len(modules)} modules)")
    print(f"==========================================")
    
    sql = []
    sql.append("-- ==========================================================================")
    sql.append(f"-- COURSE SEED: {title}")
    sql.append("-- Generated with 100% full curriculum text & embedded clinical illustrations")
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
    sql.append(f"  -- 2. Upsert Course: {slug}")
    sql.append(f"  SELECT id INTO v_course_id FROM \"courses\" WHERE \"slug\" = '{slug}' LIMIT 1;")
    sql.append("  IF v_course_id IS NULL THEN")
    sql.append("    INSERT INTO \"courses\" (")
    sql.append("      \"id\", \"exam_id\", \"slug\", \"title\", \"summary\", \"description\", \"is_free\", \"position\", \"status\", \"created_at\", \"updated_at\"")
    sql.append("    ) VALUES (")
    sql.append("      gen_random_uuid(),")
    sql.append("      v_exam_id,")
    sql.append(f"      '{slug}',")
    sql.append(f"      '{escape_sql(title)}',")
    sql.append(f"      '{escape_sql(summary)}',")
    sql.append(f"      '{escape_sql(desc)}',")
    sql.append("      false,")
    sql.append(f"      {pos},")
    sql.append("      'published',")
    sql.append("      now(),")
    sql.append("      now()")
    sql.append("    ) RETURNING \"id\" INTO v_course_id;")
    sql.append("  ELSE")
    sql.append("    UPDATE \"courses\" SET")
    sql.append(f"      \"title\" = '{escape_sql(title)}',")
    sql.append("      \"exam_id\" = COALESCE(v_exam_id, \"exam_id\"),")
    sql.append(f"      \"summary\" = '{escape_sql(summary)}',")
    sql.append(f"      \"description\" = '{escape_sql(desc)}',")
    sql.append(f"      \"position\" = {pos},")
    sql.append("      \"status\" = 'published',")
    sql.append("      \"deleted_at\" = NULL,")
    sql.append("      \"updated_at\" = now()")
    sql.append("    WHERE \"id\" = v_course_id;")
    sql.append("  END IF;")
    sql.append("")
    
    total_lessons = 0
    total_imgs = 0
    
    for mod_pos, (folder, mod_slug, mod_title) in enumerate(modules):
        if not os.path.exists(folder):
            print(f"Warning: missing folder {folder}")
            continue
            
        pdf_files = sorted([f for f in os.listdir(folder) if f.endswith('.pdf')])
        sql.append(f"  -- ==========================================================================")
        sql.append(f"  -- Module {mod_pos + 1}: {mod_title} ({len(pdf_files)} lessons)")
        sql.append(f"  -- ==========================================================================")
        sql.append(f"  SELECT id INTO v_module_id FROM \"modules\" WHERE \"course_id\" = v_course_id AND \"title\" = '{escape_sql(mod_title)}' AND \"deleted_at\" IS NULL LIMIT 1;")
        sql.append("  IF v_module_id IS NULL THEN")
        sql.append(f"    INSERT INTO \"modules\" (\"id\", \"course_id\", \"title\", \"position\", \"created_at\", \"updated_at\")")
        sql.append(f"    VALUES (gen_random_uuid(), v_course_id, '{escape_sql(mod_title)}', {mod_pos}, now(), now())")
        sql.append("    RETURNING \"id\" INTO v_module_id;")
        sql.append("  ELSE")
        sql.append(f"    UPDATE \"modules\" SET \"position\" = {mod_pos}, \"updated_at\" = now() WHERE \"id\" = v_module_id;")
        sql.append("  END IF;")
        sql.append("")
        
        used_slugs = set()
        for les_pos, pdf_file in enumerate(pdf_files):
            les_title, md_body, img_count = build_lesson_markdown(folder, pdf_file, mod_slug)
            total_imgs += img_count
            total_lessons += 1
            
            base_slug = slugify(les_title)
            les_slug = base_slug
            counter = 2
            while les_slug in used_slugs:
                les_slug = f"{base_slug}-{counter}"
                counter += 1
            used_slugs.add(les_slug)
            
            is_preview = "true" if les_pos == 0 else "false"
            
            sql.append(f"  -- Lesson: {les_title} ({img_count} images)")
            sql.append("  INSERT INTO \"lessons\" (")
            sql.append("    \"id\", \"module_id\", \"slug\", \"title\", \"type\", \"body\", \"is_free_preview\", \"position\", \"status\", \"created_at\", \"updated_at\"")
            sql.append("  ) VALUES (")
            sql.append("    gen_random_uuid(),")
            sql.append("    v_module_id,")
            sql.append(f"    '{les_slug}',")
            sql.append(f"    '{escape_sql(les_title)}',")
            sql.append("    'article',")
            sql.append(f"    '{escape_sql(md_body)}',")
            sql.append(f"    {is_preview},")
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
            sql.append("    \"deleted_at\" = NULL,")
            sql.append("    \"updated_at\" = now();")
            sql.append("")
            
        print(f"  ✓ Module: {mod_title} ({len(pdf_files)} lessons)")

    # Connect to plans
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
    sql.append(f"  RAISE NOTICE 'Successfully seeded {escape_sql(title)} ({total_lessons} lessons, {total_imgs} images)';")
    sql.append("END $$;")
    sql.append("")
    
    with open(sql_path, "w", encoding="utf-8") as f:
        f.write("\n".join(sql))
        
    print(f"Generated {sql_filename}: {total_lessons} lessons, {total_imgs} images embedded, size: {os.path.getsize(sql_path)/1024:.1f} KB")

def update_cleanup_script():
    sql_path = os.path.join(OUTPUT_DIR, "cleanup_courses.sql")
    content = """-- ==========================================================================
-- CLEANUP SCRIPT: Keep all 5 Master Curriculum Courses + SBA Question Bank
-- ==========================================================================
UPDATE "courses"
SET "status" = 'published', "deleted_at" = NULL
WHERE "slug" IN (
  'mrcem-primary',
  'mrcem-anatomy',
  'mrcem-physiology',
  'mrcem-pharmacology',
  'mrcem-pathology-micro',
  'mrcem-sba'
);

-- Archive any old test or legacy courses
UPDATE "courses"
SET "status" = 'archived', "deleted_at" = now()
WHERE "slug" NOT IN (
  'mrcem-primary',
  'mrcem-anatomy',
  'mrcem-physiology',
  'mrcem-pharmacology',
  'mrcem-pathology-micro',
  'mrcem-sba'
) AND "deleted_at" IS NULL;
"""
    with open(sql_path, "w", encoding="utf-8") as f:
        f.write(content)
    print("Updated cleanup_courses.sql to maintain all 5 master courses published.")

def main():
    print("==========================================================================")
    print("STARTING MASTER CURRICULUM & EMBEDDED IMAGES SEED GENERATION")
    print("==========================================================================")
    for c in COURSES:
        generate_course_seed(c)
    update_cleanup_script()
    print("\n==========================================================================")
    print("ALL 5 MASTER COURSES GENERATED WITH EMBEDDED IMAGES!")
    print("==========================================================================")

if __name__ == '__main__':
    main()
