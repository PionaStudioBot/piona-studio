# Specyfikacja Strony WWW — PIONA Studio (Dokument Końcowy)

> **📋 CEL DOKUMENTU**: Kompletna specyfikacja dla projektanta (UI/UX) i programisty do wdrożenia strony WWW PIONA Studio. Wszystkie decyzje strategiczne, copywriting, SEO i UX zostały podjęte — ten dokument jest ich podsumowaniem i mapą wdrożeniową.

---

## 1. PRZEGLĄD PROJEKTU

| Parametr | Wartość |
|----------|---------|
| **Klient** | PIONA Studio (agencja kreatywna, Zielona Góra) |
| **Domena** | piona-studio.pl |
| **Cel strony** | Narzędzie sprzedażowe w lejku: Consideration → Intent → Purchase |
| **Fraza główna** | Agencja reklamowa Zielona Góra |
| **Grup docelowa** | Przedsiębiorcy z budżetem (B2B), województwo lubuskie + Polska |
| **Oczekiwany wynik** | Zapytania ofertowe: formularz kontaktowy + rezerwacje Calendly |

---

## 2. MAPA STRONY (Sitemap)

```
piona-studio.pl/
├── / .......................... Strona Główna (HOME)
├── /uslugi/
│   ├── /branding-zielona-gora ........... Strategia i Branding B2B
│   ├── /projektowanie-logo-zielona-gora . Projektowanie Logo
│   ├── /prowadzenie-social-media-zielona-gora . Social Media
│   ├── /strony-internetowe-zielona-gora . Strony WWW & SEO
│   ├── /pozycjonowanie-stron-zielona-gora . Pozycjonowanie SEO
│   └── /filmy-reklamowe-lubuskie ........ Filmy Reklamowe
├── /o-nas .................... Culture Deck (O nas)
├── /portfolio ................ Portfolio / Case Studies
│   ├── /portfolio/lagow-lubuski
│   ├── /portfolio/skinow
│   ├── /portfolio/funfit
│   ├── /portfolio/dycha-teledyski
│   └── /portfolio/[...]
├── /newsroom ................. Magazyn / Newsroom
│   ├── /newsroom/wiedza
│   ├── /newsroom/klient
│   ├── /newsroom/kampania
│   └── /newsroom/[slug-artykulu]
└── /kontakt .................. Kontakt / Umów Rozmowę
```

---

## 3. DESIGN SYSTEM

### Kolorystyka
| Token | Hex | Użycie |
|-------|-----|--------|
| `--color-bg-dark` | `#212121` | Hero, CTA, stopka |
| `--color-bg-light` | `#F5F5F3` | Tło sekcji jasnych, body |
| `--color-accent` | `#B4F95A` | Pill-labele, buttony CTA, wyróżnienia |
| `--color-text` | `#212121` | Tekst główny |
| `--color-text-light` | `#D6D5D4` | Tekst na ciemnym tle, separatory |

### Typografia — Roc Grotesk
| Wariant | Użycie | Rozmiar (orientacyjny) |
|---------|--------|----------------------|
| **Roc Grotesk Wide Bold** | H1, nagłówki Hero | 48-72px (desktop) |
| **Roc Grotesk Condensed Bold** | H2, H3, podtytuły | 24-36px |
| **Roc Grotesk Regular** | Body, opisy, FAQ | 16-18px |

### Elementy UI
| Element | Opis |
|---------|------|
| **Pill-label** | Zaokrąglony prostokąt, tło `#B4F95A`, czarny tekst. Użycie: kategorie, sekcje, ceny |
| **CTA Button** | Tło `#B4F95A`, czarny tekst bold, border-radius, hover: lekka animacja/scale |
| **Ghost Button** | Transparent, biała obwódka, biały tekst. Użycie: CTA secondary |
| **Karty zespołu** | Zdjęcie + imię + rola + cytat. Zaokrąglone rogi |
| **Chromowane dłonie** | Motyw 3D wizualny na Hero i sekcjach CTA |
| **Flagi / Mapa drogi** | Timeline procesu 5 etapów. Motyw asfalt + flagi |

---

## 4. SZCZEGÓŁOWA DOKUMENTACJA PODSTRON

| Podstrona | Plik specyfikacji | Status |
|-----------|------------------|--------|
| Strona Główna | [strona_glowna_www.md](file:///Users/oskarmakarski/Desktop/AI/PIONA%20Studio/04_SEO_i_WWW/strona_glowna_www.md) | ✅ Gotowy |
| Culture Deck (O nas) | [culture_deck_www.md](file:///Users/oskarmakarski/Desktop/AI/PIONA%20Studio/04_SEO_i_WWW/culture_deck_www.md) | ✅ Gotowy |
| Podstrony Usług (×6) | [podstrony_uslug_www.md](file:///Users/oskarmakarski/Desktop/AI/PIONA%20Studio/04_SEO_i_WWW/podstrony_uslug_www.md) | ✅ Gotowy |
| Portfolio / Case Studies | [portfolio_case_studies_www.md](file:///Users/oskarmakarski/Desktop/AI/PIONA%20Studio/04_SEO_i_WWW/portfolio_case_studies_www.md) | ✅ Gotowy |
| Newsroom / Magazyn | [newsroom_www.md](file:///Users/oskarmakarski/Desktop/AI/PIONA%20Studio/04_SEO_i_WWW/newsroom_www.md) | ✅ Gotowy |
| Kontakt | [kontakt_www.md](file:///Users/oskarmakarski/Desktop/AI/PIONA%20Studio/04_SEO_i_WWW/kontakt_www.md) | ✅ Gotowy |

---

## 5. SEO — PODSUMOWANIE FRAZ

| Podstrona | Fraza H1 | Plik z long tailami |
|-----------|---------|-------------------|
| HOME | Agencja reklamowa Zielona Góra | `strategia_seo.md` sekcja 2.1 |
| Branding | Agencja brandingowa Zielona Góra | sekcja 2.4 |
| Logo | Projektowanie Logo Zielona Góra | sekcja 2.4 |
| Social Media | Prowadzenie Social Media Zielona Góra | sekcja 2.3 |
| WWW | Strony Internetowe Zielona Góra | sekcja 2.2 |
| SEO | Pozycjonowanie Stron Zielona Góra | sekcja 2.5 |
| Video | Filmy Reklamowe dla Firm Lubuskie | sekcja 2.6 |

Pełna strategia SEO → [strategia_seo.md](file:///Users/oskarmakarski/Desktop/AI/PIONA%20Studio/04_SEO_i_WWW/strategia_seo.md)

---

## 6. INTEGRACJE TECHNICZNE

| Integracja | Cel | Priorytet |
|-----------|-----|-----------|
| **Calendly** | Rezerwacja konsultacji (widget embedded) | Krytyczny |
| **Google Analytics 4** | Tracking zdarzeń i konwersji | Krytyczny |
| **Google Tag Manager** | Zarządzanie tagami | Krytyczny |
| **Meta Pixel** | Remarketing i śledzenie konwersji z reklam | Wysoki |
| **Google Search Console** | Indeksacja i monitoring SEO | Wysoki |
| **Hotjar / Clarity** | Heatmapy i nagrania sesji | Średni |
| **Email automation** | Auto-odpowiedź po formularzu | Wysoki |

Pełna specyfikacja analityki → [analityka_www.md](file:///Users/oskarmakarski/Desktop/AI/PIONA%20Studio/04_SEO_i_WWW/analityka_www.md)

---

## 7. DOKUMENTY ŹRÓDŁOWE

| Dokument | Ścieżka | Zawartość |
|----------|---------|-----------|
| Strategia SEO | `04_SEO_i_WWW/strategia_seo.md` | 6 fraz głównych + long taile |
| Architektura strony | `04_SEO_i_WWW/architektura_strony_www.md` | Struktura + lejek |
| Wytyczne UX/konwersji | `04_SEO_i_WWW/wytyczne_ux_i_konwersji_www.md` | Zasady copy i formularzy |
| Plan Newsroomu | `04_SEO_i_WWW/plan_bloga.md` | 15 artykułów SEO |
| Analityka | `04_SEO_i_WWW/analityka_www.md` | GA4, Meta Pixel, UTM-y |
| Brand & Visual Identity | `Dane_Firmy/brand_visual_identity.md` | Kolory, fonty, ton głosu, portfolio |
| Lejek sprzedażowy | `00_Strategia_2026/lejek_piona.md` | 5 etapów lejka |
| Strategia ofertowania | `02_Ofertowanie/strategia_ofertowania.md` | Speed to Lead, follow-up |

---
**Status**: Wersja 1.0
**Ostatnia aktualizacja**: 05-03-2026
