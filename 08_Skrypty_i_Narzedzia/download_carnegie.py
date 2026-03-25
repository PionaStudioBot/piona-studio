import urllib.request
import PyPDF2

url = "https://dn720004.ca.archive.org/0/items/english-collections-1/How%20To%20Win%20Friends%20And%20Influence%20People%20-%20Carnegie%2C%20Dale.pdf"
output_file = "/Users/oskarmakarski/Desktop/AI/PIONA Studio/how_to_win_friends.txt"

print("Downloading PDF...")
try:
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    with urllib.request.urlopen(req) as response:
        pdf_content = response.read()
        
    with open("temp.pdf", "wb") as f:
        f.write(pdf_content)

    print("Extracting text...")
    text = ""
    with open("temp.pdf", "rb") as f:
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
