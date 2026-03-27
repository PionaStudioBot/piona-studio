# Audyt Strategiczny Dokumentacji — PIONA Studio
**Data audytu**: 06-03-2026
**Zakres**: Wszystkie pliki .md w folderze PIONA Studio (z wyjątkiem /downloads)
**Przeanalizowano**: 22 pliki w 6 katalogach

---

## METODOLOGIA

Każdy plik przeczytany i cross-referencyjnie porównany z:
- `lejek_piona.md` (źródło prawdy strategicznej)
- `brand_visual_identity.md` (źródło prawdy wizualnej)
- `o_nas.md` (źródło prawdy o firmie)
- `strategia_ofertowania.md` (źródło prawdy sprzedażowej)

Ocena w skali: 🔴 Krytyczne / 🟡 Ważne / 🟢 Drobne

---

## 🔴 PROBLEMY KRYTYCZNE

### 🔴 1. `architektura_strony_www.md` — NIEAKTUALNA, ROZBIEŻNA Z PLIKAMI PODSTRON
**Problem**: Dokument-matka architektury nie odzwierciedla pracy wykonanej w nowych plikach. 
- Sekcja 1 (Strona Główna) ma inny opis niż `strona_glowna_www.md` (brak sekcji Marquee, Culture Deck, Newsroom z nowego wireframe'u)
- W liście podstron brakuje osobnej podstrony **Pozycjonowanie SEO** — `podstrony_uslug_www.md` definiuje 6 usług, a architektura tylko 5
- Mapowanie lejka (sekcja 3) nie uwzględnia nowych podstron: Culture Deck, Portfolio z 9 case'ami, Newsroom z 3 zakładkami
- Wersja: 1.0 z 23-02-2026 — nieaktualizowana od 11 dni
**Wpływ**: Projektant czytający ten plik jako punkt wyjścia dostanie niepełny obraz

> **REKOMENDACJA**: Zaktualizować `architektura_strony_www.md` do wersji 2.0, synchronizując z: `strona_glowna_www.md`, `podstrony_uslug_www.md` (6 usług, nie 5), `specyfikacja_www.md`, `inspiracje_wygladu_www.md`

---

### 🔴 2. `o_nas.md` — BRAKUJE NOWYCH BRANŻ I CASE'ÓW
**Problem**: Sekcja „Branże i Portfolio" wymienia tylko 6 branż z 2025, ale brakuje:
- **Fitness / Wellness** — FunFit II (2+ lata współpracy, kurs cyfrowy, Meta Ads)
- **Kosmetyki / Skincare** — SKINOW (sklep e-commerce, branding 360°)
- **Muzyka / Entertainment** — Dycha/IsAmU (teledyski 14.4M views)
- **YouTube / Twórcy internetowi** — MGP Garage, D4tailer

**Wpływ**: Klient B2B pytający „czy robiliście coś w mojej branży?" nie znajdzie odpowiedzi. Branże są argumentem sprzedażowym.

> **REKOMENDACJA**: Dodać 4 nowe branże do `o_nas.md`. Zaktualizować sekcję Portfolio o nowe case'y z `portfolio_case_studies_www.md`.

---

### 🔴 3. `analiza_rynku.md` — PUSTY PLACEHOLDER (678 bajtów)
**Problem**: Plik ma jedynie 3 bullet pointy typu „Nowe technologie w video (AI video generation, VR/AR)" i notatkę „Tu wpisuj swoje przemyślenia". Zero faktycznej analizy.
**Wpływ**: Brak analizy rynku = brak danych do podejmowania strategicznych decyzji. Strategia rozwoju 2026 nie ma podbudowy rynkowej.

> **REKOMENDACJA**: Wypełnić danymi: (A) Analiza konkurencji ZG (jakie agencje działają, co oferują, jakie mają ceny), (B) Trendy w branży kreatywnej 2026, (C) Potencjał rynkowy województwa lubuskiego.

---

### 🔴 4. `MASTERPLAN.md` — NIEAKTUALIZOWANY, NIE ODZWIERCIEDLA PRACY NAD WWW
**Problem**: Ostatnia aktualizacja: 23-02-2026. Od tego czasu wykonano ogromną pracę nad stroną WWW (10 plików), ale MASTERPLAN tego nie rejestruje:
- Faza 2 „Do Wdrożenia" wciąż ma checkbox `[ ] Strona WWW: Wdrożenie wg. architektura_strony_www.md` — tymczasem mamy już 13 plików dokumentacji WWW
- Brakuje wzmianek o: inspiracjach wizualnych, analityce, podstronach usług, portfolio rozszerzonym
- Backlog pomysłów nie został zaktualizowany o wypracowane rozwiązania (lead magnet, szablon auto-odpowiedzi — oba PARTIALLY zrealizowane)
**Wpływ**: MASTERPLAN to „mapa główna" projektu — nieaktualny = dezorientacja

> **REKOMENDACJA**: Aktualizacja MASTERPLAN do v3.0 z nową checklist odzwierciedlającą wykonaną pracę i nowe priorytety.

---

## 🟡 PROBLEMY WAŻNE

### 🟡 5. STOPKA SEO — NIESPÓJNOŚĆ MIĘDZY PLIKAMI
**Problem**: Zdanie SEO lokalne występuje w 3 wersjach:
- `architektura_strony_www.md`: *„Działamy stacjonarnie w Zielonej Górze, **ale** obsługujemy klientów z całego województwa Lubuskiego oraz Polski"*
- `podstrony_uslug_www.md`: *„Działamy stacjonarnie w Zielonej Górze, obsługujemy klientów z całego województwa Lubuskiego oraz Polski"* (poprawione przez Oskara — bez „ale")
- `culture_deck_www.md`: Inna wersja w pill-labelu „ZIELONA GÓRA TO MY"

> **REKOMENDACJA**: Ustalić jedną, kanoniczną wersję stopki SEO i propagować ją do WSZYSTKICH plików.

---

### 🟡 6. CENNIK — BRAK CENY ZA STRONĘ WWW I SEO
**Problem**: `o_nas.md` zawiera szczegółowy cennik dla Social Media, Video, Identyfikacji i Brandingu, ale:
- **Strony internetowe** — brak ceny (tylko „indywidualnie")
- **SEO / Pozycjonowanie** — brak nawet wzmianki w cenniku
- **Kampanie Meta Ads** — brak ceny obsługi
Tymczasem `podstrony_uslug_www.md` definiuje te usługi jako pełnoprawne podstrony z FAQ „ile to kosztuje?"

> **REKOMENDACJA**: Uzupełnić cennik w `o_nas.md` o widełki cenowe dla WWW, SEO i Meta Ads (nawet orientacyjne „od X zł").

---

### 🟡 7. `strona_glowna_www.md` — COPY WYMAGA DOPRECYZOWANIA
**Problem**: Wireframe Home jest najbardziej ogólny ze wszystkich podstron. Brakuje:
- Konkretnego H1 (jest tylko wytyczna „Musi natychmiast przyciągać uwagę")
- Sekcji Marquee/ticker (z `inspiracje_wygladu_www.md` — wzorzec #5)
- Precyzyjnego opisu sekcji Case Studies (jak wyglądają kafelki, ile ich jest)
- Integracji z Culture Deck (sekcja 5 mówi „Zobacz nasz Culture Deck" ale nie ma copy)

> **REKOMENDACJA**: Zaktualizować `strona_glowna_www.md` z konkretnymi H1, copy każdej sekcji i integracją z nowym wzorcem marquee.

---

### 🟡 8. BRAK SPÓJNOŚCI W PROCESIE 5 ETAPÓW
**Problem**: Proces współpracy opisany jest w 4 różnych plikach z drobnymi rozbieżnościami:
- `lejek_piona.md` (etap Consideration) — 5 kroków
- `strategia_ofertowania.md` (sekcja 5) — 5 kroków + Bonus
- `culture_deck_www.md` (sekcja 5) — tabela 5 etapów z nieco innym słownictwem
- `architektura_strony_www.md` (sekcja 4) — „Proces w 4 krokach" (!)

> **REKOMENDACJA**: Ustalić JEDEN kanoniczny opis 5 etapów i propagować go do wszystkich plików. Architektura strony mówi o „4 krokach" — to jest błąd, powinno być 5.

---

### 🟡 9. `strategia_seo.md` — BRAKUJE FRAZY DLA NOWEJ PODSTRONY SEO
**Problem**: `podstrony_uslug_www.md` definiuje 6 podstron usługowych, w tym osobną „Pozycjonowanie stron Zielona Góra". Tymczasem `strategia_seo.md` wylistowuje tylko 5 głównych fraz (sekcja 2.1-2.5) + Video. Fraza „Pozycjonowanie stron Zielona Góra" jest wymieniona, ale nie ma dedykowanego Keyword Mappingu z long tailami (sekcja 2.5 jest skrócona).

> **REKOMENDACJA**: Rozbudować sekcję 2.5 w `strategia_seo.md` o pełny Keyword Mapping dla podstrony SEO.

---

## 🟢 DROBNE USPRAWNIENIA

### 🟢 10. `system_pozyskiwania_klienta.md` — NIEAKTUALIZOWANY OD STYCZNIA
- Wersja 1.1 z 16-01-2026. Nie uwzględnia nowych elementów: strony WWW jako kanału pozyskiwania, Calendly, auto-odpowiedzi.
- Brakuje powiązania z workflow z `kontakt_www.md`.

### 🟢 11. `STATUS_UPDATES.md` — POTENCJALNIE ZDEZAKTUALIZOWANY
- Nie czytałem szczegółowo, ale jeśli jest w formie Living Context Log, powinien odzwierciedlać pracę nad WWW.

### 🟢 12. BRAK DOKUMENTU: „IDEAL CLIENT PROFILE"
- Lejek mówi o „firmach z charakterem", ale nigdzie nie ma profilu idealnego klienta (ICP): branża, przychody, problemy, motywacje, obiekcje. To kluczowe dla celowania treści na stronie.

### 🟢 13. BRAK FAQ GLOBALNEGO
- `architektura_strony_www.md` mówi o FAQ na każdej podstronie, ale cennik i procesy (pytania typu „Ile kosztuje strona?") nie mają przygotowanych odpowiedzi.

---

## PODSUMOWANIE PRIORYTETÓW

| Priorytet | Plik | Akcja |
|-----------|------|-------|
| **1 (Krytyczny)** | `architektura_strony_www.md` | Aktualizacja do v2.0 — synchronizacja z 13 plikami WWW |
| **2 (Krytyczny)** | `o_nas.md` | Dodanie 4 nowych branż i case'ów |
| **3 (Krytyczny)** | `MASTERPLAN.md` | Aktualizacja do v3.0 — odzwierciedlenie pracy nad WWW |
| **4 (Krytyczny)** | `analiza_rynku.md` | Wypełnienie treścią — analiza konkurencji ZG |
| **5 (Ważny)** | `strona_glowna_www.md` | Doprecyzowanie copy H1 i dodanie sekcji Marquee |
| **6 (Ważny)** | Wszystkie pliki | Ujednolicenie stopki SEO |
| **7 (Ważny)** | Wszystkie pliki | Ujednolicenie opisu 5 etapów procesu |
| **8 (Ważny)** | `o_nas.md` | Uzupełnienie cennika o WWW, SEO, Meta Ads |
| **9 (Ważny)** | `strategia_seo.md` | Rozbudowa Keyword Mapping dla podstrony SEO |
| **10 (Drobny)** | Nowy plik | Stworzenie Ideal Client Profile |

---
**Status**: Wersja 1.0
**Data**: 06-03-2026
