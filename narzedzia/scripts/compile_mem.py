import os
import glob
from datetime import datetime

baza_dir = "/Users/oskarmakarski/Desktop/AI/PIONA Studio/05_Baza_Wiedzy"
dane_dir = "/Users/oskarmakarski/Desktop/AI/PIONA Studio/Dane_Firmy"

cats = {
    "Instructions": [],
    "Identity": [],
    "Career": [],
    "Projects": [],
    "Preferences": []
}

def clean_line(line):
    return line.strip().replace('\n', ' ')

out_lines = []

# Process Dane Firmy (Identity, Career, Projects)
for file_path in glob.glob(f"{dane_dir}/*.md"):
    try:
        stat = os.stat(file_path)
        date_str = datetime.fromtimestamp(stat.st_mtime).strftime('%Y-%m-%d')
        with open(file_path, 'r', encoding='utf-8') as f:
            for line in f:
                line = clean_line(line)
                if not line or line.startswith('#'): continue
                if "Oskar" in line or "Makarski" in line or "imię" in line.lower() or "lat" in line.lower():
                    cats["Identity"].append(f"[{date_str}] - {line}")
                elif "PIONA Studio" in line or "Agencja" in line:
                    if "projekt" in line.lower() or "agencja" in line.lower():
                        cats["Projects"].append(f"[{date_str}] - PIONA Studio: {line}")
                elif "doświadczen" in line.lower() or "CEO" in line or "strateg" in line.lower():
                    cats["Career"].append(f"[{date_str}] - {line}")
    except Exception as e:
        pass

# Process Baza_Wiedzy (Instructions, Preferences)
for file_path in sorted(glob.glob(f"{baza_dir}/*.md")):
    fname = os.path.basename(file_path)
    if "Print" in fname: continue
    
    stat = os.stat(file_path)
    date_str = datetime.fromtimestamp(stat.st_mtime).strftime('%Y-%m-%d')
    doc_name = fname.replace(".md", "")
    
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
        paragraphs = content.split('\n\n')
        for p in paragraphs:
            text = " ".join(l.strip() for l in p.split('\n') if l.strip())
            if not text or text.startswith('#'): continue
            
            # Remove markdown tables and messy formatting to keep it clean
            if '|' in text and '-' in text:
                continue
            
            # Skip pure links or code formatting noise if needed
            text = text.replace("- **", "").replace("**", "")
            
            if "MANDATORY" in text or "ZASADA" in text or "ZAKAZ" in text or "MUSISZ" in text or "Rules" in text:
                cats["Instructions"].append(f"[{date_str}] - [{doc_name}] {text}")
            elif "Prefer" in text or "C-Level" in text or "Slop" in text or "ROI" in text or "LTV" in text or "Wartość" in text:
                cats["Preferences"].append(f"[{date_str}] - [{doc_name}] {text}")
            else:
                # Add all remaining knowledge under Instructions as core business rules
                cats["Instructions"].append(f"[{date_str}] - [{doc_name}] {text}")

# Write raw parsed data
out_path = "/Users/oskarmakarski/Desktop/AI/PIONA Studio/claude_memory.txt"
with open(out_path, 'w', encoding='utf-8') as f:
    for cat in ["Instructions", "Identity", "Career", "Projects", "Preferences"]:
        f.write(f"## {cat}\n")
        seen = set()
        for item in cats[cat]:
            if item not in seen:
                f.write(f"{item}\n")
                seen.add(item)
        if not cats[cat]:
            f.write(f"[unknown] - No records found for {cat}.\n")
        f.write("\n")

print("Done generating claude_memory.txt")
