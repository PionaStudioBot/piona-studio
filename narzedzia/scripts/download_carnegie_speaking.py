import urllib.request
import PyPDF2
import os

url = "https://cdn.bookey.app/files/pdf/book/en/the-quick-and-easy-way-to-effective-speaking.pdf"
output_file = "/Users/oskarmakarski/Desktop/AI/PIONA Studio/effective_speaking.txt"

print("Downloading PDF...")
try:
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    with urllib.request.urlopen(req) as response:
        pdf_content = response.read()
        
    with open("temp2.pdf", "wb") as f:
        f.write(pdf_content)

    print("Extracting text...")
    text = ""
    with open("temp2.pdf", "rb") as f:
        reader = PyPDF2.PdfReader(f)
        for i, page in enumerate(reader.pages):
            text += f"--- Page {i+1} ---\n"
            extracted = page.extract_text()
            if extracted:
                text += extracted + "\n"

    with open(output_file, "w") as f:
        f.write(text)
    print("Success. Saved to", output_file)
except Exception as e:
    print(f"Error: {e}")
