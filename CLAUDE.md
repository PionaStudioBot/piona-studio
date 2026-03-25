# CLAUDE.md — Hub Główny PIONA Studio

## Spis treści
1. [Przegląd systemu](#1-przegląd-systemu)
2. [Mapa przestrzeni](#2-mapa-przestrzeni-kluczowe-dla-nawigacji-ai)
3. [Tabela asystentów](#3-tabela-asystentów)
4. [Nawigacja kontekstowa](#4-nawigacja-kontekstowa)
5. [Status systemu](#5-status-systemu)
6. [Zasady operacyjne](#6-zasady-operacyjne)

## 0. Protokół startowy dla nowego modelu AI

> **KAŻDY model AI** (Claude, Gemini, Antigravity, Cursor, inne) wchodzący w ten folder MUSI przeczytać pliki w tej kolejności:
> 1. `.cursorrules` — zasady pracy z plikami (reguły, zakazy, struktura)
> 2. `SESSION.md` — stan ostatniej sesji, następny krok, otwarte pytania
> 3. `CLAUDE.md` — mapa przestrzeni, nawigacja kontekstowa (ten plik)
>
> Nie zaczynaj pracy bez przeczytania tych trzech plików. To jest jedyny sposób na zachowanie ciągłości między sesjami i platformami.

## 1. Przegląd systemu
**PIONA Studio** to agencja brandingowa, kreatywna i wideo z Zielonej Góry, skupiona na rozwiązywaniu problemów biznesowych poprzez design, video i marketing.
**Misja**: Budowa tożsamości marek, które chcą dominować na rynku i być liderami w branży.
**Kluczowa zasada**: "Rozwiązania > Usługi". Nie sprzedajemy projektowania — sprzedajemy rozwiązania biznesowe.
**Pozycja rynkowa**: Top of Mind agencja kreatywna dla przedsiębiorców w województwie lubuskim.

## 2. Mapa przestrzeni (KLUCZOWE dla nawigacji AI)

> **CEL**: AI skanuje tę sekcję PIERWSZĄ by znaleźć relevantne pliki.

### 2.1 Katalog główny
| Plik | Opis zawartości |
|------|-----------------|
| `.cursorrules` | Zasady pracy AI z plikami, protokół startowy, reguły organizacji |
| `SESSION.md` | Handoff między sesjami — stan pracy, następny krok, ustalenia |
| `CLAUDE.md` | Hub nawigacyjny, mapa projektu (ten plik) |
| `STATUS_UPDATES.md` | Stan systemu, Living Context Log, postępy celów |
| `MASTERPLAN.md` | Fazy wdrożenia systemu AI, backlog zadań |

### 2.2 Podziały tematyczne

| Lokalizacja | Plik | Opis zawartości (1 linia) |
|-------------|------|---------------------------|
| `/00_Strategia_2026/` | `strategia_rozwoju_2026.md` | Główne cele roczne, harmonogram etapów, marketing operacyjny |
| `/00_Strategia_2026/` | `lejek_piona.md` | **Pełna strategia lejka** — Awareness → Interest → Consideration → Intent → Purchase |
| `/01_Procesy_Wewnetrzne/` | `system_pozyskiwania_klienta.md` | Skrypty rozmów, proces follow-up, zasady sprzedaży lokalnej |
| `/01_Procesy_Wewnetrzne/` | `README.md` | Spis SOPów i procesów do wdrożenia |
| `/02_Ofertowanie/` | `strategia_ofertowania.md` | Struktura oferty PDF, Speed to Lead, follow-up, Przewodnik Współpracy |
| `/03_Rozwoj_i_Trendy/` | `analiza_rynku.md` | Trendy w brandingu, nowe technologie (AI), notatki |
| `/04_SEO_i_WWW/` | `strategia_seo.md` | **6 głównych fraz SEO + Keyword Mapping** z long tailami |
| `/04_SEO_i_WWW/` | `architektura_strony_www.md` | Budowa strony głównej + lista podstron mapowana na lejek |
| `/04_SEO_i_WWW/` | `plan_bloga.md` | **15 artykułów blogowych** z frazami SEO, CTA i priorytetem publikacji |
| `/06_Dane_i_Assety/` | `Brand Assets/` | Logotypy, fonty, kolory — identyfikacja wizualna PIONA Studio |
| `/06_Dane_i_Assety/` | `PIONA_AI_Brandbook.md` | Brandbook — zasady stosowania identyfikacji wizualnej |
| `/07_Projekty_Aktywne/` | `www-v9/` | **Aktywna wersja strony WWW** — HTML, CSS, JS, modele 3D |
| `/08_Skrypty_i_Narzedzia/` | `scripts/` | Skrypty backup (bash + Python) — Git commit, ZIP archive, Google Drive sync |
| `/Dane_Firmy/` | `o_nas.md` | Misja, filozofia, oferta i kluczowe informacje o zespole |
| `/05_Baza_Wiedzy/` | `00_AI_System_Instructions.md` | **Instrukcje AI + Złota Zasada aktualizacji bazy** |
| `/05_Baza_Wiedzy/` | `01_Brand_Core_Identity.md` | Fundamenty marki, archetpy, głos, storytelling |
| `/05_Baza_Wiedzy/` | `03_Brand_Strategy.md` | **Strategia marki, 3C, Ehrenberg-Bass, 25 reguł MANDATORY** |
| `/05_Baza_Wiedzy/` | `07_Behavioral_Economics.md` | Neuromarketing, System 1/2, Perceived Value, Halo Effect |
| `/05_Baza_Wiedzy/` | `10_Marketing_Foundations.md` | Fundamenty marketingu, pricing, kampanie, segmentacja |

### 2.3 Baza Wiedzy (KRYTYCZNE dla AI)

> **OBOWIĄZEK:** Przed każdym zadaniem związanym z **marketingiem, brandingiem, copywritingiem, strategią, UX/UI, ofertowaniem lub tworzeniem treści** — AI MUSI przeczytać odpowiedni klaster z `/05_Baza_Wiedzy/` i stosować się do reguł MANDATORY RULES zawartych w każdym pliku.

Pełna mapa klastrów: `/05_Baza_Wiedzy/00_AI_System_Instructions.md`

## 3. Tabela asystentów

### 3.1 Wywołania (Agents)
| Agent | Rola | Odpowiedzialność |
|-------|------|------------------|
| `@ceo` | Szef Firmy | Rozwój biznesu, partnerstwa, promocja agencji, wizja |
| `@strateg` | Lead Strategist | Strategia marki, diagnoza problemów, pozycjonowanie |
| `@creative` | Creative Director | Branding, video (Reels, YT), tożsamość wizualna |

### 3.2 Slash Commands
| Command | Opis |
|---------|------|
| `/init` | Synchronizacja `CLAUDE.md` i weryfikacja struktury |
| `/feedback` | Przetwórz feedback i zapisz jako trwałą regułę w bazie wiedzy |
| `/knowledge-load` | Załaduj bazę wiedzy przed zadaniem marketingowym/brandingowym |
| `/manual-backup` | Kopia zapasowa + synchronizacja z Google Drive |
| `/sync` | Uruchomienie skryptu SYNC.command do wymiany danych zespołu |

## 4. Nawigacja kontekstowa
| Jeśli pytanie dotyczy... | Przeczytaj... |
|--------------------------|---------------|
| Celów na ten rok | `/00_Strategia_2026/strategia_rozwoju_2026.md` |
| Strategii lejka sprzedażowego | `/00_Strategia_2026/lejek_piona.md` |
| Rozmowy z nowym klientem | `/01_Procesy_Wewnetrzne/system_pozyskiwania_klienta.md` |
| Struktury oferty / Speed to Lead | `/02_Ofertowanie/strategia_ofertowania.md` |
| Fraz SEO i keyword mapping | `/04_SEO_i_WWW/strategia_seo.md` |
| Strony WWW — budowa i podstrony | `/04_SEO_i_WWW/architektura_strony_www.md` |
| Planu artykułów blogowych | `/04_SEO_i_WWW/plan_bloga.md` |
| Kim jesteśmy i co robimy | `/Dane_Firmy/o_nas.md` |
| **Brandingu, strategii marki, pozycjonowania** | `/05_Baza_Wiedzy/01_Brand_Core_Identity.md` + `03_Brand_Strategy.md` |
| **Psychologii klienta, UX, neuromarketingu** | `/05_Baza_Wiedzy/07_Behavioral_Economics.md` |
| **Copywritingu, content marketingu** | `/05_Baza_Wiedzy/04_Content_Strategy.md` + `06_Personas_Brand_Voice.md` |
| **Wyceny, pricingu, modeli zysków** | `/05_Baza_Wiedzy/08_Pricing_Profit_Engineering.md` |
| **Reguł MANDATORY dla AI** | `/05_Baza_Wiedzy/00_AI_System_Instructions.md` |

## 5. Status systemu
Aktualny stan projektu znajduje się w: [STATUS_UPDATES.md](./STATUS_UPDATES.md)

## 6. Zasady operacyjne
1. **Zasada Bezwzględnego Mentora (Strażnik & Edukator)**: AI komunikuje się brutalnie szczerze i chroni projekt przed "tarciem". Jeśli pomysł użytkownika (np. nowa funkcja) skomplikuje pracę, wymaga dublowania działań lub długoterminowo pogorszy jej płynność — zablokuj to, podaj uzasadnienie i **wyedukuj użytkownika**, tłumacząc techniczne konsekwencje. Twoim celem jest budowanie wspólnego zrozumienia architektury, aby użytkownik projektował coraz mądrzejsze systemy.
2. **Baza kontekstu**: Przed zadaniem związanym z PIONA Studio, AI zna `/Dane_Firmy/o_nas.md` (misja, filozofia, zespół) i `/05_Baza_Wiedzy/00_AI_System_Instructions.md` (Złota Zasada, mapa klastrów). Agenci NIE muszą tego powtarzać.
3. **Nawigacja przez TOC**: AI zawsze zaczyna od spisu treści pliku.
4. **Living Context**: Aktywny zapis bieżących informacji w `STATUS_UPDATES.md`.
5. **Praca Etapowa & Transparentność**: AI wykonuje jedną rzecz na raz, pokazuje każdą zmianę i czeka na zatwierdzenie przed kolejnym krokiem.
6. **Feedback trwały**: Workflow `/feedback` przetwarza i zapisuje feedback jako trwałe reguły. Szczegóły: `.agent/workflows/feedback.md`.
7. **Żelazna Pamięć (Architektura DRY)**: Bezwzględny zakaz "naiwnego" duplikowania plików czy wiedzy. Pojedyncze źródło prawdy jest święte. Jeśli 2 platformy wymagają tego samego pliku, stosuj dowiązania symboliczne (symlink), nigdy kopie. Raz wypracowane, eleganckie rozwiązania w systemie są ostateczne — nie zapominaj ustaleń i nie wracaj z przyzwyczajenia do starych metod.


---
**Wersja**: 4.0
**Ostatnia aktualizacja**: 24-03-2026
