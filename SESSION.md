# SESSION.md — Handoff Między Sesjami AI

> **DLA MODELU AI:** Ten plik MUSISZ przeczytać jako **DRUGI** — zaraz po `.cursorrules`.
> Znajdziesz tu dokładny stan pracy z poprzedniej sesji. Nie zaczynaj nic bez przeczytania tego pliku.
> Po zakończeniu sesji (komenda `/backup` lub "zapisz pracę") — zaktualizuj WSZYSTKIE pola poniżej.

---

## Ostatnia sesja

| Pole | Wartość |
|------|---------|
| **Data** | 2026-03-27 (sesja 4) |
| **Platforma** | Claude Desktop (Cowork mode) |
| **Model** | Claude Sonnet 4.6 |
| **Czas trwania** | ~2h |

---

## Aktywne zadanie

**Nazwa:** Finalizacja infrastruktury zespołowej — Git Branches + Google Drive Assets

**Opis:** Migracja całego systemu na nową architekturę: semantyczna struktura folderów w git repo, branch isolation (oskar/wika/main), setup MacBooka Wiktorii, assety binarne na Google Drive `PIONA Studio/`.

---

## Stan roboczy (gdzie skończyliśmy)

**Etap:** CAŁA INFRASTRUKTURA ZESPOŁOWA — ZAKOŃCZONA ✅

**Co zostało zrobione w tej sesji (27-03-2026, Cowork, sesja 4):**

1. **Migracja struktury** — z numerycznej (00_-10_) na semantyczną (`context/`, `wiedza/`, `planning/`, `procesy/`, `projekty/`, `narzedzia/`). 109 plików, historia git zachowana (rename 100% similarity).
2. **CLAUDE.md v8.0** — przebudowany hub nawigacyjny z nową mapą folderów i nawigacją kontekstową.
3. **Skrypt `setup_wika.command`** — jednorazowy setup MacBooka Wiktorii. Klonuje repo, ustawia branch `wika`, konfiguruje git credentials przez macOS Keychain.
4. **`SOP_wiktoria_cowork.md`** — instrukcja Zero-Terminal dla Wiktorii (tylko `/sync`).
5. **Naprawa korupcji repo** — stare `.lock.dead` pliki z FUSE obejścia trafiły do `.git/refs/` Wiktorii. Fix: `find .git/refs -name “*.dead” -delete` + fresh clone.
6. **Merge branchy** — `oskar` → `main` → `wika` przez shadow clone. Wszystkie 3 branche zsynchronizowane z nową strukturą.
7. **Sync-architecture.md** — zaktualizowana z sekcją “Assety binarne” i “Setup Wiktorii”.

**Stan branchy na GitHub (27-03-2026 ~02:00):**
- `oskar` → `b41aae9` (najnowszy, Google Drive folder name fix)
- `main` → `86ef4f4` (merge oskar + main, rozwiązany konflikt)
- `wika` → `63619a6` (nowa struktura, zsync z main)

---

## Następny krok

**Do zrobienia w następnej sesji:**
1. **Przeniesienie assetów** — posortować istniejące pliki binarne z `PIONA Studio/` do właściwych podfolderów (`brand/`, `oferty/`, `portfolio/`, `www/`)
2. **Powrót do pracy merytorycznej** — strona WWW, blog, SEO, ofertowanie

---

## Otwarte pytania / flagi dla Oskara

- [x] ~~GitHub repo~~ — założone (PionaStudioBot/piona-studio)
- [x] ~~Architektura synchronizacji v3~~ — Git branches, shadow clone merge, działa
- [x] ~~Migracja struktury folderów~~ — semantyczna, zakończona 27-03-2026
- [x] ~~Setup MacBooka Wiktorii~~ — repo sklonowane, branch wika, zsynchronizowany
- [x] ~~Google Drive subfolders~~ — `brand/`, `oferty/`, `portfolio/`, `www/` w `PIONA Studio/` (27-03-2026)
- [x] ~~Remount Cowork Wiktorii~~ — workspace ustawiony na `Desktop/AI/PIONA-AI` (27-03-2026)
- [ ] **Stary folder `Desktop/AI/PIONA Studio`** — pusty, do usunięcia z Findera

---

## Ważne ustalenia z tej sesji

- **Protokół Sesji Cowork** — OBOWIĄZKOWY dla każdego Coworka. Szczegóły: CLAUDE.md Sekcja 7.2
- **Google Drive Mirror = last-write-wins** przy jednoczesnej edycji tego samego pliku. NIE tworzy conflict files przy normalnej pracy online
- **Realne okno ryzyka jest wąskie** — ten sam plik, te same sekundy. Różne pliki lub ten sam plik edytowany minuty/godziny później → sync działa bezproblemowo
- **Jeśli konflikt nastąpi, ginie JEDNA edycja** — nie cały dzień pracy. Kolejne edycje po konflikcie sync-ują się normalnie
- **Git snapshoty to diffy, nie kopie** — lekkie, lokalne, ułamek sekundy. Push na GitHub zostaje ręczny (/backup)
- **Merge = synteza, nie wybór** — Claude czyta obie wersje, rozumie intencję, łączy. Nie „wybierz A albo B"
- **MEMORY.md odbudowywany ze skanu folderu** — jeśli indeks jest nieaktualny, Cowork uzupełnia go automatycznie
- **Lock files (HEAD.lock, index.lock) synchronizują się przez Drive** — usuwaj `mv lock lock.bak` (nie `rm` — EPERM na FUSE) przed każdym git commit
- **`.git (1)` = Drive rename conflict** — Drive zmienił nazwę folderu git. Fix: Finder → Cmd+Shift+. → ręcznie zmień z powrotem na `.git`
- **`git checkout HEAD -- plik` nie działa na FUSE** — używaj `git show HEAD:"ścieżka" > /tmp/restored.md && cp /tmp/restored.md "ścieżka"`
- Wszystkie ustalenia z sesji 25-03 nadal obowiązują
