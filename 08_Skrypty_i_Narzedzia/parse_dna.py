import PyPDF2
import os

pdf_path = "/Users/oskarmakarski/Desktop/AI/PIONA Studio/downloads/The-DNA-of-Distinctive-Brands-Distinctive-BAT-Guide-To-DBAs.pdf"
output_path = "/Users/oskarmakarski/Desktop/AI/PIONA Studio/distinctive_brands.txt"

print(f"Opening: {pdf_path}")
try:
    with open(pdf_path, "rb") as f:
        reader = PyPDF2.PdfReader(f)
        total_pages = len(reader.pages)
        print(f"Found {total_pages} pages. Extracting text...")
        with open(output_path, "w", encoding="utf-8") as out:
            for i, page in enumerate(reader.pages):
                out.write(f"--- Page {i+1} ---\n")
                text = page.extract_text()
                if text:
                    out.write(text + "\n")
    print(f"Extraction successful. Saved to {output_path}")
except Exception as e:
    print(f"Error extracting PDF: {e}")
