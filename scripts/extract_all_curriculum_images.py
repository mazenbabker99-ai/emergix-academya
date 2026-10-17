import os
import sys
import pypdf
import json
import re
from cleaners import clean_lesson_title, slugify

sys.stdout.reconfigure(encoding='utf-8')

# Allow decompressing large high-res medical anatomical scans (up to 2 GB)
try:
    pypdf.overwrite_configuration(pypdf.Configuration(
        zlib_maximum_output_length=2_000_000_000,
        image_maximum_buffer_size=2_000_000_000
    ))
except Exception as e:
    print(f"Config warning: {e}")

CURRICULUM_MODULES = [
    # Anatomy (65 lessons)
    ('UPPER LIMB ANATOMY', 'anatomy', 'Upper Limb Anatomy'),
    ('lower limb anatomy', 'anatomy', 'Lower Limb Anatomy'),
    ('THORAX ANATOMY', 'anatomy', 'Thorax Anatomy & Mediastinum'),
    ('ABDOMEN ANATOMY', 'anatomy', 'Abdomen & Peritoneum'),
    ('H&N ANATOMY', 'anatomy', 'Head & Neck Anatomy'),
    ('CENTRAL NERVOUS SYSTEM-', 'anatomy', 'Central Nervous System & Spine'),
    ('CRANIAL NERVE ANATOMY', 'anatomy', 'Cranial Nerves In-Depth'),
    # Physiology (99 lessons)
    ('cell physiology', 'physiology', 'Cell Physiology & Membrane Transport'),
    ('cardiac physiology', 'physiology', 'Cardiovascular Physiology & Hemodynamics'),
    ('resp physiolgy', 'physiology', 'Respiratory Physiology & Ventilation'),
    ('renal physilolgy', 'physiology', 'Renal Physiology & Acid-Base Balance'),
    ('git physiology', 'physiology', 'Gastrointestinal (GIT) Physiology'),
    ('endocrine physiology', 'physiology', 'Endocrine Physiology & Metabolism'),
    ('blood physilolgy and pathology', 'physiology', 'Blood Physiology & Coagulation Pathways'),
    # Pharmacology & Toxicology (24 lessons)
    ('resp pharma', 'pharmacology', 'Respiratory Pharmacology & Asthma Management'),
    ('cardio pharma', 'pharmacology', 'Cardiovascular Pharmacology & Anticoagulants'),
    ('cns pharma', 'pharmacology', 'CNS Pharmacology & Analgesia'),
    ('anathesia drug', 'pharmacology', 'Anesthesia & Sedation Drugs'),
    ('drug toxicity', 'pharmacology', 'Emergency Toxicology & Antidotes'),
    # Pathology & Microbiology (33 lessons)
    ('pathology', 'pathology-micro', 'General Pathology, Inflammation & Anemia'),
    ('micro', 'pathology-micro', 'Clinical Microbiology, Bacteria & Antibiotics'),
]

BASE_OUTPUT_DIR = os.path.join('artifacts', 'oscepass', 'public', 'lessons', 'images')
os.makedirs(BASE_OUTPUT_DIR, exist_ok=True)

manifest = {}
total_extracted_images = 0
total_lessons_with_images = 0

print("=== STARTING COMPLETE CURRICULUM IMAGE EXTRACTION ===")

for folder_name, category, module_title in CURRICULUM_MODULES:
    if not os.path.exists(folder_name):
        print(f"Skipping missing folder: {folder_name}")
        continue
        
    module_slug = slugify(module_title)
    pdf_files = sorted([f for f in os.listdir(folder_name) if f.endswith('.pdf')])
    print(f"\nProcessing [{category.upper()}] {module_title} ({len(pdf_files)} lessons)...")
    
    module_img_count = 0
    
    for pdf_file in pdf_files:
        pdf_path = os.path.join(folder_name, pdf_file)
        title = clean_lesson_title(pdf_file)
        lesson_slug = slugify(title)
        
        target_dir = os.path.join(BASE_OUTPUT_DIR, module_slug, lesson_slug)
        
        try:
            reader = pypdf.PdfReader(pdf_path)
        except Exception as e:
            print(f"  Error reading {pdf_file}: {e}")
            continue
            
        lesson_images = []
        img_idx = 1
        
        for p_idx, page in enumerate(reader.pages):
            try:
                for img in page.images:
                    ext = img.name.split('.')[-1] if '.' in img.name else 'png'
                    if ext.lower() not in ['png', 'jpg', 'jpeg', 'webp']:
                        ext = 'png'
                    filename = f"figure_{img_idx:02d}_p{p_idx + 1}.{ext}"
                    
                    os.makedirs(target_dir, exist_ok=True)
                    file_path = os.path.join(target_dir, filename)
                    
                    # Write image file
                    with open(file_path, "wb") as f_out:
                        f_out.write(img.data)
                        
                    rel_url = f"/lessons/images/{module_slug}/{lesson_slug}/{filename}"
                    lesson_images.append({
                        "page": p_idx + 1,
                        "filename": filename,
                        "url": rel_url,
                        "sizeBytes": len(img.data)
                    })
                    img_idx += 1
            except Exception as e_page:
                print(f"    Notice on page {p_idx + 1} of {pdf_file}: {e_page}")
                
        if lesson_images:
            total_lessons_with_images += 1
            total_extracted_images += len(lesson_images)
            module_img_count += len(lesson_images)
            manifest[lesson_slug] = {
                "title": title,
                "module": module_title,
                "category": category,
                "moduleSlug": module_slug,
                "images": lesson_images
            }
            print(f"  ✓ {title}: Extracted {len(lesson_images)} images")
            
    print(f"-> {module_title} Total Images Extracted: {module_img_count}")

# Save manifest to disk
manifest_path = os.path.join('artifacts', 'oscepass', 'public', 'lessons', 'images_manifest.json')
with open(manifest_path, "w", encoding="utf-8") as f_mf:
    json.dump(manifest, f_mf, indent=2, ensure_ascii=False)

print(f"\n==========================================")
print(f"EXTRACTION COMPLETED SUCCESSFULLY!")
print(f"TOTAL IMAGES EXTRACTED: {total_extracted_images}")
print(f"LESSONS WITH IMAGES: {total_lessons_with_images}")
print(f"MANIFEST SAVED TO: {manifest_path}")
print(f"==========================================")
