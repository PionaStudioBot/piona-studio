---
description: Generuje spersonalizowaną ofertę PIONA Studio (PDF copy) na podstawie zapytania i szablonu bazowego. Unika AI Slop-u przez wstrzykiwanie zmiennych do stałej struktury.
---

# Workflow: Generowanie Pełnej Oferty (PIONA Studio)

Wywołanie tej komendy (`/oferta`) służy do przygotowania personalizowanych tekstów na slajdy ofertowe bez utraty wytycznych brandowych i bez syndromu obłędu "wymieńmy wszystko od zera" (AI slop).

Postępuj zgodnie z poniższymi instrukcjami, gdy użytkownik wpisze komendę.

## Krok 1. Zebranie wymagań od użytkownika (Briefing)
Jeśli użytkownik wpisał po prostu `/oferta`, odpisz zwięźle prosząc o parametry wejściowe. Jeśli parametry podał od razu – przeskocz do Kroku 2.

**Parametry do zebrania:**
1. **Dla kogo ta oferta?** (Branża i krótki opis problemu klienta).
2. **Kategoria usługi?** (Narzuca nam to jaki Szablon Bazowy załadować. Na początek mamy `OFA_SocialMedia_Base.md`).
3. **Pakiety Cenowe / Wycena?** (Jakie kwoty przygotować do tabeli Inwestycji).
4. **Case Study / Referencja:** (Krótka informacja o sukcesie poprzedniego klienta w podobnej branży na slajd Social Proof).

*(Ważność oferty wynosi domyślnie 14 dni, system wpisze to automatycznie na Slajdzie 7).*

## Krok 2. Ciche procesowanie w tle (Praca Agenta)
Kiedy otrzymasz parametry, MUSISZ odczytać naraz:
- `02_Ofertowanie/System_Ofert/Szablony_Tekstowe/OFA_SocialMedia_Base.md` (lub inny wskazany).
- Twój kontekst ToV (Tone of Voice PIONA) oraz "Eager Want" Carnegie.

## Krok 3. Generowanie Outputu (Personalizacja)
Teraz przekształć Bazowy Szablon, wprowadzając do niego zmiany wynikające ze specyfiki klienta:
- **Zasieg Modyfikacji:** Zmień okładkę (SLAJD 1). Na SLAJD 2 (Twój profil to słup...) oraz SLAJD 4 zadbaj o delikatne wstawki idealnie dopasowane (np. nawiązanie do maszyn rolniczych, fotowoltaiki itp. używając "Eager Want").
- **Twardo zablokowane:** NIE zmieniaj logiki procesu PIONA (SLAJD 5 - SYSTEM ETAPOWY muszą stanowić 4 kroki, nie 10 i nie 2). 
- **Inwestycja:** Wstaw precyzyjne kwoty dla tego klienta na SLAJDACH INTENT.
- **Wynik:** Wygeneruj użytkownikowi ten nowy zmodowany plik blokami w formacie Markdown (możesz go wyświetlić bezpośrednio w odpowiedzi w bloku kodu z oznaczeniami slajdów). 

Zero wariacji stylu. Zachowaj 100% skanowalności i oryginalne zasady boldowania wybranych statystyk z szablonu.
