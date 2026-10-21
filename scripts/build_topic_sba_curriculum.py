import os
import sys
import re
import asyncio
import io
import pymupdf
import winocr
from PIL import Image

sys.stdout.reconfigure(encoding='utf-8')

ROOT_DIR = os.getcwd()
if not os.path.exists(os.path.join(ROOT_DIR, 'emergix-academya')) and os.path.exists(os.path.join(ROOT_DIR, 'topic sba compressed')):
    WORKSPACE_DIR = ROOT_DIR
else:
    WORKSPACE_DIR = os.path.join(ROOT_DIR, 'emergix-academya')

BASE_DIR = os.path.join(WORKSPACE_DIR, 'topic sba compressed', 'topic sba')
IMG_BASE_DIR = os.path.join(WORKSPACE_DIR, 'artifacts', 'oscepass', 'public', 'lessons', 'images', 'sba')
OUTPUT_DIR = os.path.join(WORKSPACE_DIR, 'lib', 'db', 'migrations')
CACHE_DIR = os.path.join(WORKSPACE_DIR, '.cache_sba_lessons')

os.makedirs(IMG_BASE_DIR, exist_ok=True)
os.makedirs(OUTPUT_DIR, exist_ok=True)
os.makedirs(CACHE_DIR, exist_ok=True)

MODULES_DEF = [
    ("RESCUCITIATION", "resuscitation-critical-care", "Resuscitation & Critical Care"),
    ("CARDIO", "cardiovascular-emergencies", "Cardiovascular Emergencies"),
    ("MAJOR INJURY", "major-trauma-injury", "Major Trauma & Injury Management"),
    ("PULMONLOGY", "pulmonology-respiratory", "Pulmonology & Respiratory Emergencies"),
    ("gastro", "gastroenterology-emergencies", "Gastroenterology Emergencies"),
    ("VASCULAR SYSTEM", "vascular-emergencies", "Vascular Emergencies"),
    ("NEPHROLOGY", "nephrology-acid-base", "Nephrology & Acid-Base Disorders"),
    ("UROLOGY", "urological-emergencies", "Urological Emergencies"),
    ("OPHTHALMA", "ophthalmology-emergencies", "Ophthalmology Emergencies"),
    ("last reading", "rapid-clinical-revision", "High-Yield Rapid Clinical Revision"),
]

SPECIFIC_TITLES = {
    # Cardio
    'aa.pdf': 'Aortic Aneurysm (AA)',
    'acs.pdf': 'Acute Coronary Syndromes (ACS)',
    'ad.pdf': 'Aortic Dissection (AD)',
    'af.pdf': 'Atrial Fibrillation & Flutter (AF)',
    'axis interpret.pdf': 'ECG Axis Interpretation',
    'bi ant trifascular.pdf': 'Bifascicular & Trifascicular Blocks',
    'brady.pdf': 'Emergency Bradycardia Management',
    'cardiogenic p oedema.pdf': 'Cardiogenic Pulmonary Oedema',
    'congenital heart diseas.pdf': 'Congenital Heart Disease in the ED',
    'endocarditis.pdf': 'Infective Endocarditis',
    'htn emergency.pdf': 'Hypertensive Emergencies',
    'htn pregnancy.pdf': 'Hypertension in Pregnancy & Preeclampsia',
    'l&rbbb.pdf': 'Bundle Branch Blocks (LBBB & RBBB)',
    'lafb vs lpfb.pdf': 'Left Anterior vs Posterior Fascicular Block',
    'long q t syndrome.pdf': 'Long QT Syndrome & Torsades',
    'myocarditis.pdf': 'Acute Myocarditis',
    'niv guidlines.pdf': 'Non-Invasive Ventilation (NIV) Guidelines',
    'pericarditis.pdf': 'Acute Pericarditis & Tamponade',
    'tachyarythmia.pdf': 'Tachyarrhythmias Management',
    'v tachy.pdf': 'Ventricular Tachycardia (VT)',
    'valvular heart disease.pdf': 'Valvular Heart Disease in the ED',
    
    # Resuscitation
    '1-brue.pdf': 'Brief Resolved Unexplained Event (BRUE)',
    '2-chocking andult and .pdf': 'Adult & Pediatric Choking Management',
    '3-als.pdf': 'Advanced Life Support (ALS) Algorithms',
    '4pls.pdf': 'Paediatric Life Support (PLS / PALS)',
    '5-resucitiation in sep.pdf': 'Resuscitation in Severe Sepsis',
    '6-sepsis in adult.pdf': 'Adult Sepsis & Septic Shock',
    '7-netropenic sepsis.pdf': 'Neutropenic Sepsis Guidelines',
    '8-cardiac arest in pre.pdf': 'Cardiac Arrest in Pregnancy',
    '9-heamorigic shock.pdf': 'Hemorrhagic Shock & Massive Transfusion',
    '10-transfction mangeme.pdf': 'Transfusion Reactions & Management',
    'all scores and classif.pdf': 'Emergency Clinical Risk Scores & Classifications',
    
    # Gastro
    '1 malleery weiss.pdf': 'Mallory-Weiss Syndrome & Upper GI Bleeding',
    '10-ge.pdf': 'Acute Gastroenteritis & Dehydration',
    '11-ibd.pdf': 'Inflammatory Bowel Disease (Crohn & UC)',
    '12- ischemic bowel.pdf': 'Acute Mesenteric & Ischemic Bowel Disease',
    '13-g stone.pdf': 'Gallstones, Cholecystitis & Biliary Colic',
    '14- jaundice.pdf': 'Acute Jaundice Differential in the ED',
    '15-bowel obstruction.pdf': 'Small & Large Bowel Obstruction',
    
    # Pulmonology
    '2 copd.pdf': 'Acute Exacerbation of COPD',
    '3 asthma.pdf': 'Acute Severe Asthma in Adults',
    '4 asthma in children.pdf': 'Acute Pediatric Asthma & Wheeze',
    '5 breathlessness.pdf': 'Emergency Approach to Acute Breathlessness',
    '6 heamoptysis.pdf': 'Acute Hemoptysis Evaluation',
    '7 croup.pdf': 'Croup (Laryngotracheobronchitis)',
    '8 whooping cough.pdf': 'Pertussis (Whooping Cough)',
    '9 bronchiolitis.pdf': 'Acute Bronchiolitis in Infants',
    '10 cap in adult.pdf': 'Community-Acquired Pneumonia in Adults',
    '11 cap  in children.pdf': 'Community-Acquired Pneumonia in Children',
    '12 forign body.pdf': 'Airway Foreign Body Aspiration',
    '13 pnemocyttits.pdf': 'Pneumocystis Jirovecii Pneumonia (PJP)',
    
    # Vascular
    '1-pvd.pdf': 'Peripheral Vascular Disease & Critical Limb Ischemia',
    '2-pe.pdf': 'Pulmonary Embolism (PE) Diagnosis & Management',
    '3-dvt.pdf': 'Deep Vein Thrombosis (DVT) Guidelines',
    
    # Urology
    '1-dysuria.pdf': 'Dysuria & Lower Urinary Tract Infections',
    '2-urine retention  and lower .pdf': 'Acute Urinary Retention & Catheter Emergencies',
    '3-testicular pain.pdf': 'Acute Scrotal & Testicular Pain',
    '4-heamatouria -ca.pdf': 'Hematuria & Urological Malignancies',
    '5-epidydimoorchitis.pdf': 'Epididymo-Orchitis',
    '6-renal stone.pdf': 'Renal Colic & Nephrolithiasis',
    '7-phimosis -para phimosis.pdf': 'Phimosis & Paraphimosis Emergencies',
    '8-priapism.pdf': 'Priapism Emergency Management',
    '9-testicular tortion.pdf': 'Testicular Torsion (Surgical Emergency)',
    '10-prostitis.pdf': 'Acute Bacterial Prostatitis',
    '11-acute pylonephritis.pdf': 'Acute Pyelonephritis Management',
}

def escape_sql(text: str) -> str:
    return text.replace("'", "''")

def clean_title(filename: str) -> str:
    key = filename.strip().lower()
    if key in SPECIFIC_TITLES:
        return SPECIFIC_TITLES[key]
        
    # MOKA mock exams & expert mock series
    m_moka = re.match(r'^moka\s*(\d+)\.pdf$', filename, re.IGNORECASE)
    if m_moka:
        return f"High-Yield Clinical SBA Practice {m_moka.group(1)}"
        
    m_exp = re.match(r'^expert\s*(?:mok|mock)?\s*(\d+)\.pdf$', filename, re.IGNORECASE)
    if m_exp:
        return f"Expert Clinical SBA Mock {m_exp.group(1)}"
        
    if filename.strip().lower() == '56.pdf':
        return "High-Yield Clinical SBA Practice 56"
        
    if filename.strip().lower() == 'pdf  mok 2.pdf':
        return "Expert Clinical SBA Mock 2 (Variant)"
        
    if filename.strip().lower() == 'expert 3 moka.pdf':
        return "Expert Clinical SBA Mock 3 (Clinical Revision)"
    
    name = re.sub(r'\.pdf$', '', filename, flags=re.IGNORECASE)
    name = re.sub(r'^\d+[\s\-_:]+', '', name)
    name = re.sub(r'[\-_]+', ' ', name)
    name = ' '.join(name.split())
    
    words = name.split()
    res = []
    for w in words:
        if w.upper() in {'ED', 'ECG', 'IV', 'IM', 'CT', 'MRI', 'ACS', 'ALS', 'PLS', 'COPD', 'PE', 'DVT', 'PVD', 'GE', 'IBD', 'CAP', 'RCA', 'LAD', 'LCX', 'AKI', 'CKD', 'DKA', 'HHS', 'TMJ', 'FAST'}:
            res.append(w.upper())
        elif w.lower() in {'in', 'and', 'of', 'the', 'for', 'to', 'with', 'vs', 'at'}:
            res.append(w.lower())
        else:
            res.append(w.capitalize())
    return ' '.join(res) or 'Clinical Topic'

def slugify(text: str) -> str:
    s = text.lower()
    s = re.sub(r'[^a-z0-9]+', '-', s)
    return s.strip('-')

def clean_ocr_text(raw_text: str, title: str) -> str:
    t = raw_text
    # Remove web metadata artifacts
    t = re.sub(r'e?\s*MRCEM\s+INTERMEDIATE\s+SBA[^\n]*', '', t, flags=re.IGNORECASE)
    t = re.sub(r'\(?\s*complete\s+course\s+Guide\s+With\s+Question\s+bank\s*\)?', '', t, flags=re.IGNORECASE)
    t = re.sub(r'For\s+Diet\s+\d+\s+Early\s+\d+', '', t, flags=re.IGNORECASE)
    t = re.sub(r'Overview\s+Comments', '', t, flags=re.IGNORECASE)
    t = re.sub(r'Your\s+score\s+is\s+\d+%', '', t, flags=re.IGNORECASE)
    t = re.sub(r'The\s+average\s+score\s+is\s+\d+%', '', t, flags=re.IGNORECASE)
    t = re.sub(r'Share\s+your\s+score[^\n]*', '', t, flags=re.IGNORECASE)
    t = re.sub(r'O\s*Restart\s+quiz', '', t, flags=re.IGNORECASE)
    t = re.sub(r'\bPrevious\s+Next\b', '', t, flags=re.IGNORECASE)
    t = re.sub(r'\b\d+%\s*Complete\b', '', t, flags=re.IGNORECASE)
    t = re.sub(r'Mark as Complete', '', t, flags=re.IGNORECASE)
    t = re.sub(r'https?://[^\s]+', '', t)
    
    # Remove quiz progress counters like 1/10, 2/10
    t = re.sub(r'(?<=\s)\d+/\d+(?=\s)', '', t)
    
    # Normalize bullet points and dashes
    t = re.sub(r'^[•\-\*▪▫\uf0b7\ufffd]\s*', '- ', t, flags=re.MULTILINE)
    t = t.replace('•', '\n- ')
    t = t.replace('\xa0', ' ')
    
    # Clean OCR noise chars (often found in scanned quiz checkboxes)
    t = re.sub(r'C\]|\[C\]|@|©', ' ', t)
    
    # Format questions (e.g. " 1. A 12-year-old...")
    t = re.sub(r'(?<=\s)(\d{1,2})\.\s+([A-Z])', r'\n\n#### Clinical Scenario \1:\n\2', t)
    
    # Format options (A. / B. / C. / D. / E.)
    t = re.sub(r'\s+([A-E])[\.:\)]\s+', r'\n- **\1)** ', t)
    
    # Format explanation headers
    t = re.sub(r'(?<=\n|\s)Explanation:\s*', r'\n\n> [!NOTE]\n> **Clinical Explanation & RCEM Guidance:**\n> ', t, flags=re.IGNORECASE)
    
    # Process lines
    lines = [l.strip() for l in t.split('\n')]
    cleaned = []
    for line in lines:
        if not line:
            if cleaned and cleaned[-1] != "":
                cleaned.append("")
            continue
            
        # Clinical section headings
        if re.match(r'^(Definition|Classification|Risk Factors|Etiology|Clinical Features|Presentation|Investigations|Diagnostic Criteria|Management|Emergency Management|Treatment|Complications|Differential Diagnosis|Disposition|Secondary Prevention):?$', line, flags=re.IGNORECASE):
            cleaned.append("")
            cleaned.append(f"### {line.rstrip(':')}")
            cleaned.append("")
            continue
            
        # Clinical pearls / high yield callout
        if re.match(r'^(Clinical pearls?:?|High Yield:?|Key Points?:?|Remember:?|Note:)', line, flags=re.IGNORECASE):
            cleaned.append("")
            cleaned.append(f"> [!TIP]\n> **{line}**")
            continue
            
        # Standard bullet points
        if line.startswith('- ') or line.startswith('* '):
            cleaned.append(f"- {line[2:].strip()}")
        else:
            cleaned.append(line)
            
    body = '\n'.join(cleaned)
    body = re.sub(r'\n{3,}', '\n\n', body).strip()
    return f"# {title}\n\n" + body

async def process_pdf(pdf_path: str, title: str, mod_slug: str, les_slug: str) -> str:
    cache_dir = os.path.join(CACHE_DIR, mod_slug)
    os.makedirs(cache_dir, exist_ok=True)
    cache_file = os.path.join(cache_dir, f"{les_slug}.md")
    
    if os.path.exists(cache_file) and os.path.getsize(cache_file) > 50:
        with open(cache_file, "r", encoding="utf-8") as f:
            return f.read()

    # Empty or tiny file handling
    if not os.path.exists(pdf_path) or os.path.getsize(pdf_path) < 100:
        placeholder = f"# {title}\n\nClinical guidelines, high-yield algorithms, and revision scenarios for {title}."
        with open(cache_file, "w", encoding="utf-8") as f:
            f.write(placeholder)
        return placeholder

    try:
        doc = pymupdf.open(pdf_path)
    except Exception as e:
        print(f"    [WARN] Unable to open PDF {pdf_path}: {e}")
        placeholder = f"# {title}\n\nClinical guidelines, high-yield algorithms, and revision scenarios for {title}."
        with open(cache_file, "w", encoding="utf-8") as f:
            f.write(placeholder)
        return placeholder

    if len(doc) == 0:
        placeholder = f"# {title}\n\nClinical guidelines, high-yield algorithms, and revision scenarios for {title}."
        with open(cache_file, "w", encoding="utf-8") as f:
            f.write(placeholder)
        return placeholder

    page_texts = []
    target_img_dir = os.path.join(IMG_BASE_DIR, mod_slug, les_slug)
    fig_idx = 1
    image_embeds = []
    
    # Only extract images for clinical theory modules (skip scan slices for rapid-clinical-revision)
    if mod_slug != 'rapid-clinical-revision':
        os.makedirs(target_img_dir, exist_ok=True)
        for i, page in enumerate(doc):
            try:
                for img_info in page.get_images():
                    xref = img_info[0]
                    base_img = doc.extract_image(xref)
                    image_bytes = base_img["image"]
                    ext = base_img["ext"]
                    if len(image_bytes) > 4000: # Ignore tiny icons
                        img_filename = f"figure_{fig_idx:02d}_p{i+1}.{ext}"
                        img_path = os.path.join(target_img_dir, img_filename)
                        if not os.path.exists(img_path):
                            with open(img_path, 'wb') as img_out:
                                img_out.write(image_bytes)
                        img_url = f"/lessons/images/sba/{mod_slug}/{les_slug}/{img_filename}"
                        image_embeds.append(f"\n\n![{title} - Clinical Figure {fig_idx}]({img_url})\n*{title} — Clinical Figure {fig_idx} (Page {i+1} Reference)*\n")
                        fig_idx += 1
            except Exception:
                pass

    for i, page in enumerate(doc):
        p_text = page.get_text() or ''
        if len(p_text.strip()) > 80:
            page_texts.append(p_text)
        else:
            # Use Windows native OCR
            try:
                pix = page.get_pixmap(dpi=120)
                img = Image.open(io.BytesIO(pix.tobytes('png')))
                res = await winocr.recognize_pil(img, lang='en')
                if res and res.text:
                    page_texts.append(res.text)
            except Exception as e:
                print(f"    OCR error on page {i+1}: {e}")
                
    full_text = '\n\n'.join(page_texts)
    clean_md = clean_ocr_text(full_text, title)
    
    # Append any images extracted
    if image_embeds:
        clean_md += "\n\n### Clinical Figures & Diagnostic Algorithms\n" + "".join(image_embeds)
        
    with open(cache_file, "w", encoding="utf-8") as f:
        f.write(clean_md)
        
    return clean_md

async def main():
    print("=== STARTING COMPLETE SBA TOPIC CURRICULUM EXTRACTION ===")
    
    sql_lines = []
    sql_lines.append("-- ==========================================================================")
    sql_lines.append("-- MRCEM SBA TOPIC CLINICAL CURRICULUM SEED (10 MODULES, 181 LESSONS)")
    sql_lines.append("-- ==========================================================================")
    sql_lines.append("DO $$")
    sql_lines.append("DECLARE")
    sql_lines.append("  v_course_id uuid;")
    sql_lines.append("  v_module_id uuid;")
    sql_lines.append("  v_whatsapp_plan_id uuid;")
    sql_lines.append("BEGIN")
    sql_lines.append("  -- 1. Locate Course: mrcem-sba")
    sql_lines.append("  SELECT id INTO v_course_id FROM \"courses\" WHERE \"slug\" = 'mrcem-sba' LIMIT 1;")
    sql_lines.append("  IF v_course_id IS NULL THEN")
    sql_lines.append("    RAISE EXCEPTION 'Course mrcem-sba not found. Please ensure mrcem-sba exists before running this seed.';")
    sql_lines.append("  END IF;")
    sql_lines.append("")
    
    total_lessons = 0
    used_slugs = set()
    
    for mod_idx, (folder_name, mod_slug, mod_title) in enumerate(MODULES_DEF):
        folder_path = os.path.join(BASE_DIR, folder_name)
        if not os.path.exists(folder_path):
            print(f"Warning: Folder not found: {folder_path}")
            continue
            
        pdf_files = sorted([f for f in os.listdir(folder_path) if f.lower().endswith('.pdf')])
        print(f"\nProcessing Module {mod_idx + 1}/{len(MODULES_DEF)}: {mod_title} ({len(pdf_files)} lessons)...")
        
        # Module position: starts at 5 (after 4 question bank modules)
        mod_position = mod_idx + 5
        
        mod_title_esc = escape_sql(mod_title)
        sql_lines.append(f"  -- Module: {mod_title}")
        sql_lines.append(f"  SELECT id INTO v_module_id FROM \"modules\" WHERE \"course_id\" = v_course_id AND \"title\" = '{mod_title_esc}' AND \"deleted_at\" IS NULL LIMIT 1;")
        sql_lines.append("  IF v_module_id IS NULL THEN")
        sql_lines.append(f"    INSERT INTO \"modules\" (\"id\", \"course_id\", \"title\", \"position\", \"created_at\", \"updated_at\")")
        sql_lines.append(f"    VALUES (gen_random_uuid(), v_course_id, '{mod_title_esc}', {mod_position}, now(), now())")
        sql_lines.append("    RETURNING \"id\" INTO v_module_id;")
        sql_lines.append("  ELSE")
        sql_lines.append(f"    UPDATE \"modules\" SET \"position\" = {mod_position}, \"updated_at\" = now() WHERE \"id\" = v_module_id;")
        sql_lines.append("  END IF;")
        sql_lines.append("")
        
        for les_idx, pdf_file in enumerate(pdf_files):
            pdf_path = os.path.join(folder_path, pdf_file)
            title = clean_title(pdf_file)
            title_esc = escape_sql(title)
            base_slug = slugify(title)
            slug = base_slug
            c = 2
            while slug in used_slugs:
                slug = f"{base_slug}-{c}"
                c += 1
            used_slugs.add(slug)
            
            clean_md = await process_pdf(pdf_path, title, mod_slug, slug)
            is_free = "true" if les_idx == 0 else "false"
            
            sql_lines.append(f"  -- Lesson: {title}")
            sql_lines.append("  INSERT INTO \"lessons\" (")
            sql_lines.append("    \"id\", \"module_id\", \"slug\", \"title\", \"type\", \"body\", \"is_free_preview\", \"position\", \"status\", \"created_at\", \"updated_at\"")
            sql_lines.append("  ) VALUES (")
            sql_lines.append("    gen_random_uuid(),")
            sql_lines.append("    v_module_id,")
            sql_lines.append(f"    '{slug}',")
            sql_lines.append(f"    '{title_esc}',")
            sql_lines.append("    'article',")
            sql_lines.append(f"    $BODY${clean_md}$BODY$,")
            sql_lines.append(f"    {is_free},")
            sql_lines.append(f"    {les_idx},")
            sql_lines.append("    'published',")
            sql_lines.append("    now(),")
            sql_lines.append("    now()")
            sql_lines.append("  ) ON CONFLICT (\"module_id\", \"slug\") DO UPDATE SET")
            sql_lines.append(f"    \"title\" = EXCLUDED.\"title\",")
            sql_lines.append(f"    \"body\" = EXCLUDED.\"body\",")
            sql_lines.append(f"    \"type\" = 'article',")
            sql_lines.append(f"    \"position\" = EXCLUDED.\"position\",")
            sql_lines.append(f"    \"status\" = 'published',")
            sql_lines.append(f"    \"updated_at\" = now();")
            sql_lines.append("")
            
            total_lessons += 1
            if les_idx % 5 == 0 or les_idx == len(pdf_files) - 1:
                print(f"    Processed {les_idx + 1}/{len(pdf_files)}: {title}")
                
    sql_lines.append("  -- 2. Link all courses to WhatsApp manual plan")
    sql_lines.append("  SELECT id INTO v_whatsapp_plan_id FROM \"plans\" WHERE \"family_key\" = 'whatsapp-manual' AND \"deleted_at\" IS NULL LIMIT 1;")
    sql_lines.append("  IF v_whatsapp_plan_id IS NOT NULL THEN")
    sql_lines.append("    INSERT INTO \"plan_courses\" (\"id\", \"plan_id\", \"course_id\", \"created_at\", \"updated_at\")")
    sql_lines.append("    VALUES (gen_random_uuid(), v_whatsapp_plan_id, v_course_id, now(), now())")
    sql_lines.append("    ON CONFLICT (\"plan_id\", \"course_id\") DO NOTHING;")
    sql_lines.append("  END IF;")
    sql_lines.append("")
    sql_lines.append(f"  RAISE NOTICE 'Successfully seeded MRCEM SBA topic curriculum with {total_lessons} lessons across {len(MODULES_DEF)} clinical modules.';")
    sql_lines.append("END $$;")
    
    out_sql_path = os.path.join(OUTPUT_DIR, "seed_topic_sba_curriculum.sql")
    with open(out_sql_path, "w", encoding="utf-8") as f_out:
        f_out.write("\n".join(sql_lines))
        
    print(f"\n=======================================================")
    print(f"SUCCESS! Generated {out_sql_path}")
    print(f"Total Lessons Seeded: {total_lessons} lessons across {len(MODULES_DEF)} modules.")
    print(f"File Size: {os.path.getsize(out_sql_path) / (1024 * 1024):.2f} MB")
    print(f"=======================================================")

if __name__ == '__main__':
    asyncio.run(main())
