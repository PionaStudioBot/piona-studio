import urllib.request
import PyPDF2

url = "https://cdn.bookey.app/files/pdf/book/en/how-brands-grow.pdf"
output_file = "/Users/oskarmakarski/Desktop/AI/PIONA Studio/how_brands_grow.txt"

print("Downloading PDF...")
try:
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    with urllib.request.urlopen(req) as response:
        pdf_content = response.read()
        
    with open("temp3.pdf", "wb") as f:
        f.write(pdf_content)

    print("Extracting text...")
    text = ""
    with open("temp3.pdf", "rb") as f:
        reader = PyPDF2.PdfReader(f)
        for i, page in enumerate(reader.pages):
            text += f"--- Page {i+1} ---\n"
            extracted = page.extract_text()
            if extracted:
                text += extracted + "\n"

    with open(output_file, "w") as f:
        f.write(text)
    print("Success")
except Exception as e:
    print(f"Error: {e}")
