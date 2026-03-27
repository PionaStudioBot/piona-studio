# Architektura Strony WWW — PIONA Studio
**Wersja**: 2.0  
**Ostatnia aktualizacja**: 06-03-2026  
**Status**: ACTIVE

## Spis treści
1. [Mapa Strony (Sitemap)](#1-mapa-strony-sitemap)
2. [Strona Główna — Przegląd sekcji](#2-strona-główna--przegląd-sekcji)
3. [Lista podstron i przypisanie do lejka](#3-lista-podstron-i-przypisanie-do-lejka)
4. [Mapowanie Lejka na Stronę](#4-mapowanie-lejka-na-stronę)
5. [Elementy techniczne](#5-elementy-techniczne)

> **📋 EXECUTIVE SUMMARY**
> **Cel**: Strona jako główne narzędzie lejka sprzedażowego — każda sekcja odpowiada etapowi: Awareness → Interest → Consideration → Intent → Purchase.
> **Zasada**: Strona to case study naszych możliwości. Musi zachwycać już na wejściu.
> **Fraza główna**: Agencja reklamowa Zielona Góra
> **Powiązane**: `strategia_seo.md`, `lejek_piona.md`, `specyfikacja_www.md`, `inspiracje_wygladu_www.md`

---

## 1. Mapa Strony (Sitemap)

```
piona-studio.pl/
├── / .......................... Strona Główna → strona_glowna_www.md
├── /uslugi/
│   ├── /branding-zielona-gora ........... Strategia i Branding B2B
│   ├── /projektowanie-logo-zielona-gora . Projektowanie Logo
│   ├── /prowadzenie-social-media-zielona-gora . Social Media
│   ├── /strony-internetowe-zielona-gora . Strony WWW & SEO
│   ├── /pozycjonowanie-stron-zielona-gora . Pozycjonowanie SEO
│   └── /filmy-reklamowe-lubuskie ........ Filmy Reklamowe
├── /o-nas .................... Culture Deck → culture_deck_www.md
├── /portfolio ................ Portfolio / Case Studies → portfolio_case_studies_www.md
├── /newsroom ................. Magazyn / Newsroom → newsroom_www.md
│   ├── /newsroom/wiedza
│   ├── /newsroom/klient
│   └── /newsroom/kampania
└── /kontakt .................. Kontakt / Umów Rozmowę → kontakt_www.md
```

**Łącznie**: 1 Home + 6 podstron usług + 4 podstrony wspierające = **11 podstron** + artykuły Newsroomu

---

## 2. Strona Główna — Przegląd sekcji

| # | Sekcja | Etap lejka | Szczegóły |
|---|--------|-----------|-----------|
| 1 | **HERO** | Awareness | H1: „Pomagamy firmom wyglądać jak liderzy rynku" + CTA główny + pill-label SEO |
| 2 | **MARQUEE / TICKER** | Awareness→Interest | Pasek przewijany: `BRANDING · SOCIAL MEDIA · FILMY · STRONY WWW · SEO · STRATEGIA` |
| 3 | **CO ROBIMY** | Interest | Bento grid 6 kafelków usług (asymetryczny, klikalny) |
| 4 | **PROCES 5 ETAPÓW** | Consideration | Motyw drogi + flagi: Kawa na ławę → Strategia → Kreacja → Egzekucja → Piątka |
| 5 | **CASE STUDIES** | Consideration | Grid 3-4 top projektów (SKINOW, Dycha 14.4M, FunFit, Łagów) |
| 6 | **CULTURE DECK** | Consideration | Teaser zespołu i wibracji → „Zobacz nasz Culture Deck →" |
| 7 | **NEWSROOM** | Awareness+SEO | 2-3 najnowsze artykuły z feedu → „Czytaj dalej →" |
| 8 | **INTENT / CTA** | Intent→Purchase | Formularz (3 pola) + Calendly side-by-side |

Pełna specyfikacja copy → `strona_glowna_www.md`

---

## 3. Lista podstron i przypisanie do lejka

### Podstrony Usługowe (6 sztuk — rozdzielone pod SEO)

| Podstrona | URL | Fraza SEO H1 | Etap lejka |
|-----------|-----|-------------|-----------|
| Strategia i Branding B2B | `/uslugi/branding-zielona-gora` | Agencja brandingowa Zielona Góra | Interest |
| Projektowanie Logo | `/uslugi/projektowanie-logo-zielona-gora` | Projektowanie logo Zielona Góra | Interest |
| Prowadzenie Social Media | `/uslugi/prowadzenie-social-media-zielona-gora` | Prowadzenie social media Zielona Góra | Interest |
| Strony WWW & SEO | `/uslugi/strony-internetowe-zielona-gora` | Strony internetowe Zielona Góra | Interest |
| Pozycjonowanie SEO | `/uslugi/pozycjonowanie-stron-zielona-gora` | Pozycjonowanie stron Zielona Góra | Interest |
| Filmy Reklamowe | `/uslugi/filmy-reklamowe-lubuskie` | Filmy reklamowe dla firm Lubuskie | Interest |

Pełna specyfikacja 6 podstron (7-sekcyjny szablon) → `podstrony_uslug_www.md`

### Podstrony Wspierające (4 sztuki)

| Podstrona | URL | Cel | Etap lejka | Dokument |
|-----------|-----|-----|-----------|----------|
| Culture Deck (O nas) | `/o-nas` | Wibracje agencji, misja, zespół, proces | Consideration | `culture_deck_www.md` |
| Portfolio / Case Studies | `/portfolio` | 9 case'ów z metrykami i efektami | Consideration → Intent | `portfolio_case_studies_www.md` |
| Newsroom / Magazyn | `/newsroom` | Feed SEO z 3 zakładkami (Wiedza, Klient, Kampania) | Awareness + Consideration | `newsroom_www.md` |
| Kontakt / Umów Rozmowę | `/kontakt` | Formularz 3-polowy + Calendly fast-track | Intent → Purchase | `kontakt_www.md` |

---

## 4. Mapowanie Lejka na Stronę

```
AWARENESS     → Newsroom (Wiedza), Portfolio (wstępna inspiracja), Social Media PIONA, Google (SEO)
INTEREST      → Kafelki 6 usług na Home, Podstrony usługowe (szczegóły + FAQ + cennik)
CONSIDERATION → Portfolio (9 case'ów z metrykami), Culture Deck (O nas), Newsroom (Case study/Kampania)
INTENT        → Kontakt /kontakt (formularz 3-polowy + Calendly), CTA na każdej podstronie
PURCHASE      → Speed to Lead <4h, auto-odpowiedź, oferta PDF, follow-up 3-krokowy
```

---

## 5. Elementy techniczne

### Kanoniczny proces współpracy — 5 etapów (jedna wersja wszędzie)

| Etap | Nazwa | Opis skrócony |
|------|-------|---------------|
| 1 | **Kawa na ławę** | Szczere przegadanie wyzwań. Ty mówisz, my słuchamy |
| 2 | **Strategia** | Analiza konkurencji, research, plan działania oparty na faktach |
| 3 | **Kreacja** | Projektowanie z celem — koncepcje, feedback, szlifowanie |
| 4 | **Egzekucja** | Dopracowane wdrożenie — każdy detal ma znaczenie |
| 5 | **Piątka + Ewolucja** | Nie znikamy. Analizujemy wyniki, podpowiadamy co podkręcić |

### Kanoniczne CTA (jedna wersja wszędzie)
- **Główny**: „Umów bezpłatną konsultację" (Lime Green button)
- **Pomocniczy**: „Zobacz nasze portfolio →" (ghost button / link)

### Kanoniczny formularz (3 pola — z `lejek_piona.md`)
1. Imię — „Jak masz na imię?"
2. Email/Telefon — „Jak się z Tobą kontaktować?"
3. Czego potrzebujesz? — dropdown (Logo / Branding / WWW / Social / Film / SEO / Inne)

### Kanonyczna Stopka SEO
> *„Działamy stacjonarnie w Zielonej Górze, obsługujemy klientów z całego województwa Lubuskiego oraz Polski."*

### Integracje
- **Calendly**: Widget na `/kontakt` + każda podstrona usługi
- **GA4 + GTM + Meta Pixel**: Pełna specyfikacja → `analityka_www.md`
- **Auto-odpowiedź po formularzu**: Email + ekran potwierdzenia → `kontakt_www.md`

---
**Powiązane pliki**: `specyfikacja_www.md` (dokument końcowy), `inspiracje_wygladu_www.md` (brief wizualny), `wytyczne_ux_i_konwersji_www.md` (zasady UX)
