import re
import sys

sys.stdout.reconfigure(encoding='utf-8')

with open('mrcemexpert_full.html', 'r', encoding='utf-8') as f:
    html = f.read()

def clean_tags(s):
    return re.sub(r'<[^>]+>', '', s).strip()

print("=== NAVIGATION LINKS ===")
nav = re.findall(r'<a[^>]+href="([^"]+)"[^>]*>(.*?)</a>', html, re.I)
seen = set()
for href, text in nav:
    t = clean_tags(text)
    if t and len(t) > 2 and t not in seen and not href.startswith('#'):
        seen.add(t)
        print(f"  {t} -> {href}")

print("\n=== SECTIONS & TEXTS ===")
# Find all divs with text or headers
elements = re.findall(r'<(h[1-5]|p|blockquote)[^>]*>(.*?)</\1>', html, re.I | re.DOTALL)
for tag, content in elements:
    c = clean_tags(content)
    if len(c) > 10 and not c.startswith('/*') and not 'window.' in c:
        print(f"[{tag.upper()}] {c}")
