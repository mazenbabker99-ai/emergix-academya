import re

def clean_lesson_title(filename: str) -> str:
    """Produces clean, professional medical title from raw filename."""
    name = re.sub(r'\.pdf$', '', filename, flags=re.IGNORECASE)
    name = re.sub(r'\s*_\s*MRCEM\s+EXPERT\s+LLC.*$', '', name, flags=re.IGNORECASE)
    name = re.sub(r'^\d+\s*[-:]\s*', '', name)
    name = re.sub(r'\s*-\s*', ' - ', name)
    name = name.strip()
    
    # Capitalize appropriately
    words = name.split()
    clean_words = []
    lowercase_words = {'and', 'of', 'the', 'in', 'on', 'at', 'to', 'for', 'with', 'a', 'an'}
    for i, w in enumerate(words):
        lw = w.lower()
        if i > 0 and lw in lowercase_words:
            clean_words.append(lw)
        elif w.upper() in {'CNS', 'GIT', 'ED', 'SBA', 'MRCEM', 'ECG', 'IV', 'IM', 'CT', 'MRI', 'CSF', 'ADH', 'ANP', 'RAAS', 'GFR', 'NACL', 'ABG', 'COPD', 'PE', 'DVT'}:
            clean_words.append(w.upper())
        else:
            clean_words.append(w.capitalize())
    return ' '.join(clean_words)

def slugify(text: str) -> str:
    """Generates url-safe slug."""
    s = text.lower()
    s = re.sub(r'[^a-z0-9]+', '-', s)
    return s.strip('-')

def clean_lesson_markdown(raw_text: str, title: str) -> str:
    """Transforms raw PDF text into high-quality medical Markdown with 100% complete content."""
    text = raw_text
    
    # 1. Strip private use glyphs and web icons first
    text = re.sub(r'[\ue000-\uf8ff\ufffd]', '', text)
    
    # 2. Fix common symbols and unicode quotes
    text = text.replace('\xa0', ' ')
    text = text.replace('–', '-').replace('—', '-')
    text = text.replace('’', "'").replace('‘', "'")
    text = text.replace('“', '"').replace('”', '"')
    
    # 3. Remove web headers, footers, pagination, and navigation buttons
    text = re.sub(r'\d{2}/\d{2}/\d{4},\s*\d{2}:\d{2}\s*.*?\|.*?LLC', '', text, flags=re.IGNORECASE)
    text = re.sub(r'https?://[^\s]+', '', text)
    text = re.sub(r'Mrcem Primary Complete Course[^\n]*', '', text, flags=re.IGNORECASE)
    text = re.sub(r'\(?\s*For\s+Diet[^\n\)]*\)?', '', text, flags=re.IGNORECASE)
    text = re.sub(r'Diet\s+ii[^\n]*', '', text, flags=re.IGNORECASE)
    text = re.sub(r'Overview\s+Comments', '', text, flags=re.IGNORECASE)
    text = re.sub(r'\bPrevious\s+Next\b', '', text, flags=re.IGNORECASE)
    text = re.sub(r'0%\s*Complete', '', text, flags=re.IGNORECASE)
    text = re.sub(r'Mark as Complete', '', text, flags=re.IGNORECASE)
    text = re.sub(r'Restart quiz', '', text, flags=re.IGNORECASE)
    text = re.sub(r'LinkedIn\s*Facebook\s*Twitter', '', text, flags=re.IGNORECASE)
    text = re.sub(r'\bPage\s+\d+\s+of\s+\d+\b', '', text, flags=re.IGNORECASE)
    text = re.sub(r'\b\d+\s*/\s*\d+\b', '', text)
    
    # Split into lines for formatting
    lines = [line.strip() for line in text.split('\n')]
    
    cleaned_lines = []
    in_pearl = False
    
    for line in lines:
        if not line:
            if cleaned_lines and cleaned_lines[-1] != "":
                cleaned_lines.append("")
            continue
            
        # Clinical pearl / high yield highlight
        if re.match(r'^(Clinical pearls?:?|Clinical high yield:?|High Yield:?|Key Points?:?)', line, flags=re.IGNORECASE):
            cleaned_lines.append("")
            cleaned_lines.append(f"> [!TIP]\n> **{line}**")
            in_pearl = True
            continue
            
        # Mnemonic highlight
        if re.match(r'^(Mnemonic:?|Remember:?)', line, flags=re.IGNORECASE):
            cleaned_lines.append("")
            cleaned_lines.append(f"> [!NOTE]\n> **{line}**")
            continue
            
        # Numbered headings (e.g. 1. Structure or 1: Femoral Artery)
        if re.match(r'^\d+[\.\:]\s+[A-Za-z]', line):
            cleaned_lines.append("")
            cleaned_lines.append(f"### {line}")
            cleaned_lines.append("")
            in_pearl = False
            continue
            
        # Section titles in ALL CAPS with length between 4 and 45
        if line.isupper() and len(line) > 3 and len(line) < 45 and not line.startswith('-') and re.search(r'[A-Za-z]', line):
            cleaned_lines.append("")
            cleaned_lines.append(f"## {line.title()}")
            cleaned_lines.append("")
            in_pearl = False
            continue
            
        # Bullet points
        if line.startswith(('•', '-', '*')):
            item_text = line.lstrip('•-* ').strip()
            cleaned_lines.append(f"- {item_text}")
            continue
            
        if in_pearl:
            cleaned_lines.append(f"> {line}")
            if line.endswith('.'):
                in_pearl = False
                cleaned_lines.append("")
        else:
            cleaned_lines.append(line)
            
    body = '\n'.join(cleaned_lines)
    # Remove multiple consecutive blank lines
    body = re.sub(r'\n{3,}', '\n\n', body).strip()
    
    # Prefix with standardized lesson intro header
    header = f"# {title}\n\n"
    return header + body
