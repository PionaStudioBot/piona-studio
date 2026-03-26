# CLAUDE.md — Hub Główny PIONA Studio

## Spis treści
1. [Przegląd systemu](#1-przegląd-systemu)
2. [Mapa przestrzeni](#2-mapa-przestrzeni-kluczowe-dla-nawigacji-ai)
3. [Tabela asystentów](#3-tabela-asystentów)
4. [Nawigacja kontekstowa](#4-nawigacja-kontekstowa)
5. [Status systemu](#5-status-systemu)
6. [Zasady operacyjne](#6-zasady-operacyjne)
7. [Architektura synchronizacji i backupu](#7-architektura-synchronizacji-i-backupu)
   - 7.1 [Jak działa synchronizacja w praktyce](#71-jak-działa-synchronizacja-w-praktyce)
   - 7.2 [Protokół Sesji Cowork (OBOWIĄZKOWY)](#72-protokół-sesji-cowork-obowiązkowy)
   - 7.3 [Obsługa .auto-memory](#73-obsługa-auto-memory-pamięć-między-sesjami)

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
| `/06_Dane_i_Assety/Dane_Firmy/` | `o_nas.md` | Misja, filozofia, oferta i kluczowe informacje o zespole |
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
| `/backup` | Kopia zapasowa na GitHub (commit + push). Google Drive synchronizuje automatycznie |
| `/sync` | Commit + push na GitHub (koło ratunkowe). Sync zespołowy działa automatycznie przez Google Drive |

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
| Kim jesteśmy i co robimy | `/06_Dane_i_Assety/Dane_Firmy/o_nas.md` |
| **Brandingu, strategii marki, pozycjonowania** | `/05_Baza_Wiedzy/01_Brand_Core_Identity.md` + `03_Brand_Strategy.md` |
| **Psychologii klienta, UX, neuromarketingu** | `/05_Baza_Wiedzy/07_Behavioral_Economics.md` |
| **Copywritingu, content marketingu** | `/05_Baza_Wiedzy/04_Content_Strategy.md` + `06_Personas_Brand_Voice.md` |
| **Wyceny, pricingu, modeli zysków** | `/05_Baza_Wiedzy/08_Pricing_Profit_Engineering.md` |
| **Reguł MANDATORY dla AI** | `/05_Baza_Wiedzy/00_AI_System_Instructions.md` |

## 5. Status systemu
Aktualny stan projektu znajduje się w: [STATUS_UPDATES.md](./STATUS_UPDATES.md)

## 6. Zasady operacyjne
1. **Zasada Bezwzględnego Mentora (Strażnik & Edukator)**: AI komunikuje się brutalnie szczerze i chroni projekt przed "tarciem". Jeśli pomysł użytkownika (np. nowa funkcja) skomplikuje pracę, wymaga dublowania działań lub długoterminowo pogorszy jej płynność — zablokuj to, podaj uzasadnienie i **wyedukuj użytkownika**, tłumacząc techniczne konsekwencje. Twoim celem jest budowanie wspólnego zrozumienia architektury, aby użytkownik projektował coraz mądrzejsze systemy.
2. **Baza kontekstu**: Przed zadaniem związanym z PIONA Studio, AI zna `/06_Dane_i_Assety/Dane_Firmy/o_nas.md` (misja, filozofia, zespół) i `/05_Baza_Wiedzy/00_AI_System_Instructions.md` (Złota Zasada, mapa klastrów). Agenci NIE muszą tego powtarzać.
3. **Nawigacja przez TOC**: AI zawsze zaczyna od spisu treści pliku.
4. **Living Context**: Aktywny zapis bieżących informacji w `STATUS_UPDATES.md`.
5. **Praca Etapowa & Transparentność**: AI wykonuje jedną rzecz na raz, pokazuje każdą zmianę i czeka na zatwierdzenie przed kolejnym krokiem.
6. **Feedback trwały**: Workflow `/feedback` przetwarza i zapisuje feedback jako trwałe reguły. Szczegóły: `.claude/workflows/oferta.md`.
7. **Żelazna Pamięć (Architektura DRY)**: Bezwzględny zakaz "naiwnego" duplikowania plików czy wiedzy. Pojedyncze źródło prawdy jest święte. Jeśli 2 platformy wymagają tego samego pliku, stosuj dowiązania symboliczne (symlink), nigdy kopie. Raz wypracowane, eleganckie rozwiązania w systemie są ostateczne — nie zapominaj ustaleń i nie wracaj z przyzwyczajenia do starych metod.


## 7. Architektura synchronizacji i backupu

**Lokalizacja folderu PIONA Studio:**
- Mac Studio (Oskar): `~/Mój dysk/PIONA Studio/`
- MacBook (Wiktoria): `~/Mój dysk/PIONA Studio/`
- Google Drive: konto `kontakt.piona@gmail.com`, tryb „Powielaj pliki" (Mirror)
- GitHub: `PionaStudioBot/piona-studio` (private repo, backup)

**Warstwy bezpieczeństwa:**
1. **Google Drive** — real-time sync między urządzeniami, automatyczny, dwustronny
2. **Git snapshoty** — lokalny commit na starcie i na końcu każdej sesji Cowork (punkt odtworzenia)
3. **Detekcja konfliktów** — automatyczne wykrywanie nadpisań przez Google Drive sync
4. **Inteligentny merge** — Claude czyta obie wersje + bazę (snapshot), tworzy syntezę zachowującą zmiany obu stron
5. **GitHub** — backup na żądanie (`/backup`) lub piątkowy. Jednokierunkowy (lokalnie → GitHub)

**Zasady stałe:**
- Wiktoria nigdy nie musi otwierać terminala (Zero-Terminal Policy)
- `.git` folder zostaje wewnątrz Google Drive — NIE przenosimy go nigdzie (decyzja ostateczna, 25-03-2026)
- `core.fsmonitor=false` w git config (zabezpieczenie przed konfliktem z sync)
- Nigdy nie klikaj „Zachowaj mimo to" gdy Drive blokuje plik — to nadpisuje cudzą wersję

### 7.1 Jak działa synchronizacja w praktyce

Google Drive Mirror synchronizuje pliki między Mac Studio i MacBook w czasie rzeczywistym. Przy normalnej pracy (różne zadania = różne pliki) synchronizacja działa bezproblemowo. Jedyne ryzyko to sytuacja gdy oba Coworki edytują **ten sam plik w odstępie krótszym niż czas sync Google Drive (5-30 sekund)**. Wtedy Google Drive stosuje zasadę last-write-wins i jedna wersja nadpisuje drugą.

Dlatego każda sesja Cowork stosuje Protokół Sesji (sekcja 7.2), który: tworzy git snapshot jako punkt odtworzenia, na koniec sesji automatycznie wykrywa czy coś zostało nadpisane, i jeśli tak — merguje inteligentnie obie wersje zamiast wybierać jedną.

### 7.2 Protokół Sesji Cowork (OBOWIĄZKOWY)

> **KAŻDY Claude Cowork** (na Mac Studio i na MacBook) MUSI przestrzegać tego protokołu. To nie jest opcjonalne.

#### START SESJI (zanim cokolwiek zrobisz):

1. **Usuń stare lock files:** Sprawdź czy istnieją `.git/HEAD.lock` lub `.git/index.lock`. Jeśli tak — Google Drive zsynchronizował je z drugiego komputera. Usuń przez `mv .git/HEAD.lock .git/HEAD.lock.bak` (uwaga: `rm` nie działa na FUSE mount — używaj `mv`).
2. **Git snapshot:** `git add -A && git commit -m "snapshot-start: [macstudio/macbook] [YYYY-MM-DD HH:MM]"`
   - Jeśli `git status` pokazuje brak zmian do commitowania — OK, przejdź dalej
   - Jeśli są niezcommitowane zmiany — commituj je (przyszły z Google Drive sync od drugiego komputera)
   - Jeśli Drive zmienił `.git` na `.git (1)` — poproś użytkownika: Finder → Cmd+Shift+. → zmień nazwę z powrotem na `.git`
3. **Skan pamięci:** Przeczytaj listę plików w `.auto-memory/` i porównaj z `MEMORY.md`. Jeśli istnieją pliki pamięci nieujęte w indeksie — uzupełnij indeks automatycznie.
4. **Zapamiętaj edycje:** Przez całą sesję zapamiętuj w kontekście konwersacji: które pliki edytowałeś i jaka była ich treść po twojej edycji.

#### PODCZAS SESJI:

Normalna praca. Zero dodatkowego narzutu. Jedyny obowiązek: pamiętaj które pliki edytowałeś (punkt 3 powyżej).

#### KONIEC SESJI (przed aktualizacją SESSION.md):

1. **Weryfikacja edycji:** Ponownie przeczytaj każdy plik, który edytowałeś podczas sesji. Porównaj aktualną treść na dysku z tym co pamiętasz że zapisałeś.
2. **Jeśli treść się zgadza** — brak konfliktu. Przejdź do kroku 4.
3. **Jeśli treść się różni** — wykryty konflikt. Wykonaj procedurę merge:
   - Odczytaj wersję bazową z git snapshota: `git show HEAD~1:"ścieżka/do/pliku" > /tmp/restored.md && cp /tmp/restored.md "ścieżka/do/pliku"` (stan sprzed twoich edycji — uwaga: `git checkout` nie działa na FUSE/Google Drive mount, używaj `git show` + `cp`)
   - Masz teraz 3 wersje: **Baza** (snapshot), **Twoja** (w pamięci sesji), **Dysk** (z Google Drive sync, od drugiego Coworka)
   - Zrozum intencję obu zmian — co każda strona chciała osiągnąć
   - Stwórz **syntezę** łączącą wartość z obu wersji (NIE wybieraj jednej — merguj obie)
   - Zapisz zmergowaną wersję na dysk
   - Poinformuj użytkownika: „Wykryłem równoległą edycję [plik]. [Oskar/Wiktoria] zmienił(a) [co], drugi Cowork zmienił [co]. Połączyłem obie zmiany — sprawdź czy wynik jest poprawny."
4. **Git snapshot końcowy:** `git add -A && git commit -m "snapshot-end: [macstudio/macbook] [YYYY-MM-DD HH:MM]"`
5. **Aktualizuj SESSION.md** zgodnie z Regułą #5 z `.cursorrules`

### 7.3 Obsługa .auto-memory (pamięć między sesjami)

Pliki pamięci (`.auto-memory/*.md`) to osobne pliki z unikalnymi nazwami — każdy Cowork tworzy nowe pliki niezależnie, Google Drive synchronizuje je bez konfliktów. `MEMORY.md` to indeks (spis treści) — jeśli oba Coworki dodadzą wpis jednocześnie i jeden się zgubi, indeks jest automatycznie odbudowywany przez skan folderu na starcie sesji (punkt 2 Protokołu).

---
**Wersja**: 6.1
**Ostatnia aktualizacja**: 26-03-2026
