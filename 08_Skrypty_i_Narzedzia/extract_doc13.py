import PyPDF2
import os

pdf_path = "/Users/oskarmakarski/Desktop/AI/PIONA Studio/downloads/HowBrandsGrow.pdf"
output_text_path = "/Users/oskarmakarski/Desktop/AI/PIONA Studio/how_brands_grow_analysis.txt"

print(f"Opening: {pdf_path}")
try:
    with open(pdf_path, "rb") as f:
        reader = PyPDF2.PdfReader(f)
        total_pages = len(reader.pages)
        print(f"Found {total_pages} pages. Extracting text...")
        with open(output_text_path, "w", encoding="utf-8") as out:
            for i, page in enumerate(reader.pages):
                out.write(f"--- Page {i+1} ---\n")
                text = page.extract_text()
                if text:
                    out.write(text + "\n")
    print(f"Text extraction successful. Saved to {output_text_path}")
except Exception as e:
    print(f"Error extracting text from PDF: {e}")
