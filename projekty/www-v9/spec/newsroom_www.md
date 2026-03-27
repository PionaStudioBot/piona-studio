# Podstrona Magazyn / Newsroom — PIONA Studio
**URL**: `/newsroom`
**Rola w lejku**: Awareness (SEO → ruch organiczny) + Consideration (treści budujące autorytet)
**Powiązane**: `plan_bloga.md`, `strategia_seo.md`, `architektura_strony_www.md`

> **📋 CEL STRATEGICZNY**
> Newsroom pełni **podwójną funkcję**: (1) napędza SEO — każdy artykuł targetuje long tail z `strategia_seo.md` i linkuje do podstrony usługowej, (2) buduje autorytet — klient widzi, że PIONA nie tylko robi, ale też ROZUMIE marketing.
> **Zasada z `plan_bloga.md`**: Każdy artykuł = konkretna fraza SEO + call to action wchodzący do lejka.
> **Nie** nazywamy tego "Blogiem" — to Newsroom / Magazyn. Brzmi bardziej premium i profesjonalnie. Jest to dynamiczny feed, nie statyczna lista postów.
> **Inspiracja**: Feeders Newsroom, 10rano.pl (feed wizualny), Mbridge (artykuły z danymi)

---

## ZASADA NADRZĘDNA

Newsroom PIONY to **nie blog z AI-generowanymi artykułami o "5 trendach w marketingu"**. To repozytorium wiedzy, w którym każdy tekst:
1. **Rozwiązuje konkretny problem klienta** (np. „Dlaczego moja reklama na FB nie sprzedaje?")
2. **Rankuje na frazę SEO** (np. „Reklama na Facebooku i Instagramie Zielona Góra")
3. **Kończy się CTA wchodzącym do lejka** (np. „Darmowy audyt konta reklamowego")

---

## 🏗 STRUKTURA SEKCJI (Wireframe & Copy)

---

### SEKCJA 1: HERO — NEWSROOM
**Wizualnie**: Proste, czytelne otwarcie. Off-white tło. Duży H1. Pod spodem od razu filtry kategorii.

- **Pill-label**: `NEWSROOM`
- **H1 (Roc Grotesk Wide, Bold)**: NEWSROOM PIONY
- **Sub-headline**: Wiedza, case study i kampanie — bez lania wody. Konkretne treści dla firm, które chcą rosnąć.

---

### SEKCJA 2: FILTRY / ZAKŁADKI KATEGORII
**Wizualnie**: Trzy duże zakładki (taby) lub pill-labele do przełączania widoku. Klient od razu widzi, jakiego rodzaju treści szuka.

| Zakładka | Treści w kategorii | Cel w lejku | Ikona sugerowana |
|----------|-------------------|-------------|-----------------|
| **WIEDZA** | Artykuły edukacyjne, poradniki, analizy rynkowe | Awareness → Interest | 📚 |
| **KLIENT** | Case study, backstage projektów, opinie klientów | Consideration → Intent | 🤝 |
| **KAMPANIA** | Wyniki kampanii, metryki, ROI, dane z reklam | Consideration → Intent | 📊 |

**Dlaczego 3 kategorie, a nie więcej?**
- Za dużo kategorii = chaos. Trzy to optymalny balans między porządkiem a elastycznością.
- Mapping do lejka: Wiedza = góra lejka, Klient = środek, Kampania = dół.

**SEO**: Każda zakładka generuje osobny URL (`/newsroom/wiedza`, `/newsroom/klient`, `/newsroom/kampania`) indeksowalny przez Google.

---

### SEKCJA 3: FEED ARTYKUŁÓW
**Wizualnie**: Układ postów przypominający feed IG lub siatkę Pinteresta (inspiracja: Feeders Newsroom). Asymetryczny grid 2-3 kolumnowy. Każdy artykuł = karta z dużym coverem, tytułem, kategorią i czasem czytania.

**Karta artykułu w feedzie:**
```
┌───────────────────────────────┐
│  [Cover image — grafika       │
│   z wykresem / zdjęciem /     │
│   typografią jak post na IG]  │
│                               │
│  ┌─────────┐  ⏱ 6 min        │
│  │ WIEDZA  │                  │
│  └─────────┘                  │
│  Dlaczego Twoja reklama       │
│  na FB nie sprzedaje?         │
│  5 błędów, przez które...     │
└───────────────────────────────┘
```

**Elementy karty:**
- Cover image (grafika jak cover na IG PIONY — pill-label w tytule, bold typografia)
- Pill-label kategorii (`WIEDZA` / `KLIENT` / `KAMPANIA`)
- Tytuł artykułu (clickbait, ale merytoryczny — hook + obietnica)
- Czas czytania (np. ⏱ 6 min)
- Data publikacji

**Sortowanie domyślne**: Od najnowszych. Wyróżnione artykuły (Pillar Pages) mogą być „przypięte" na górze.

---

### SEKCJA 4: SZABLON POJEDYNCZEGO ARTYKUŁU (Po kliknięciu)

Każdy artykuł otwiera się jako osobna podstrona (`/newsroom/dlaczego-reklama-na-fb-nie-sprzedaje`).

**Układ artykułu:**
```
┌───────────────────────────────────────────┐
│ [Pill-label: WIEDZA]  ⏱ 6 min  📅 Data  │
│                                           │
│ H1: Dlaczego Twoja reklama na Facebooku   │
│ nie sprzedaje? 5 błędów, przez które      │
│ lubuskie firmy tracą budżet.             │
│                                           │
│ [Cover image — pełna szerokość]           │
├───────────────────────────────────────────┤
│ TREŚĆ:                                    │
│   H2: [Problem klienta]                  │
│   H2: [Rozwiązanie / Wiedza]             │
│   H2: [Przykład / Case Study PIONA]      │
│   H2: [Podsumowanie]                     │
├───────────────────────────────────────────┤
│ CTA BOX (wyróżniony, zielona ramka):     │
│ "Chcesz sprawdzić, czy Twoje reklamy     │
│  są dobrze ustawione?"                    │
│ [BUTTON: Darmowy audyt konta →]           │
├───────────────────────────────────────────┤
│ POWIĄZANE ARTYKUŁY (grid 3 karty)        │
│                                           │
│ POWIĄZANE USŁUGI (link do podstrony)     │
└───────────────────────────────────────────┘
```

**Kluczowe elementy artykułu:**
- **H1 = fraza SEO long tail** (z `plan_bloga.md`)
- **Linkowanie wewnętrzne**: Każdy artykuł linkuje do min. 1 podstrony usługowej i min. 1 innego artykułu
- **CTA box na końcu**: Dopasowany do kategorii artykułu (z `plan_bloga.md`)
- **Schema Article markup**: Dla wyświetlania w Google jako rich snippet
- **Powiązane artykuły**: 3 karty z feedu (utrzymanie użytkownika na stronie)

---

### SEKCJA 5: MAPOWANIE ARTYKUŁÓW DO KATEGORII

Na bazie `plan_bloga.md` — przypisanie istniejących 15 artykułów do 3 zakładek:

| Zakładka | Artykuły (z plan_bloga.md) |
|----------|----|
| **WIEDZA** | Art. 1 (Reklama na FB nie sprzedaje), Art. 2 (Rolki vs sprzedaż), Art. 7 (Branding vs identyfikacja), Art. 8 (Materiały firmowe must have), Art. 10 ⭐ (Pillar: Jak promować firmę w ZG 2026), Art. 12 (Audyt SEO błędy), Art. 13 (Google Maps ZG), Art. 15 ⭐ (Cennik stron WWW) |
| **KLIENT** | Art. 3 (Agencja vs freelancer), Art. 4 (Dlaczego agencja?), Art. 5 (Rebranding firm rodzinnych), Art. 6 (Proces projektowania logo), Art. 11 (Abonament 360°), Art. 14 (WooCommerce vs Allegro) |
| **KAMPANIA** | Art. 9 (Filmy z drona dla deweloperów), case study artykuły z realizacji (FunFit, SKINOW, Dycha → wyniki, metryki, ROI) |

---

### SEKCJA 6: CTA BOTTOM — NEWSLETTER / KONTAKT
**Wizualnie**: Ciemne tło na dole Newsroomu. Zachęta do kontaktu.

- **H2**: Chcesz wiedzieć więcej? Pogadajmy.
- **CTA primary**: Umów bezpłatną konsultację →
- **CTA secondary** (opcjonalny): Obserwuj nas na Instagramie → @studio.piona

---

## SEO NA NEWSROOMIE

| Element | Wytyczna |
|---------|---------|
| **URL artykułu** | `/newsroom/[slug-z-frazy-seo]` np. `/newsroom/ile-kosztuje-strona-internetowa-2026` |
| **Title tag** | `[Tytuł artykułu] | PIONA Studio — Agencja Reklamowa Zielona Góra` |
| **Meta description** | 150-160 znaków, zawiera frazę główną + obietnicę wartości |
| **H1** | = fraza long tail z `strategia_seo.md` |
| **Linkowanie** | Min. 2 linki → podstrony usług. Min. 1 link → inny artykuł. |
| **Schema** | `Article` schema z autorem (PIONA Studio), datą, obrazem |
| **Priorytet publikacji** | Zgodny z `plan_bloga.md` sekcja 7 (Pillar Page #1, potem cennik WWW #2) |

---

## POWIĄZANIA W LEJKU

```
Skąd klient trafia na Newsroom?
  ← Google (frazy long tail → artykuł = punkt wejścia do lejka)
  ← Strona Główna (Sekcja 5.5: „Newsroom PIONY →")
  ← Social Media PIONA (linki w bio, stories, posty)

Dokąd idzie z Newsroomu?
  → Podstrona usługi (link wewnętrzny z artykułu lub CTA)
  → Portfolio / Case Studies (artykuły w zakładce KLIENT/KAMPANIA)
  → Kontakt / Calendly (CTA box na końcu artykułu)
```

---
**Status**: Wersja 1.0
**Ostatnia aktualizacja**: 05-03-2026
**Powiązane**: `plan_bloga.md`, `strategia_seo.md`, `architektura_strony_www.md`, `wytyczne_ux_i_konwersji_www.md`
