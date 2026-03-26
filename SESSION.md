# SESSION.md — Handoff Między Sesjami AI

> **DLA MODELU AI:** Ten plik MUSISZ przeczytać jako **DRUGI** — zaraz po `.cursorrules`.
> Znajdziesz tu dokładny stan pracy z poprzedniej sesji. Nie zaczynaj nic bez przeczytania tego pliku.
> Po zakończeniu sesji (komenda `/backup` lub "zapisz pracę") — zaktualizuj WSZYSTKIE pola poniżej.

---

## Ostatnia sesja

| Pole | Wartość |
|------|---------|
| **Data** | 2026-03-26 (sesja 3) |
| **Platforma** | Claude Desktop (Cowork mode) |
| **Model** | Claude Opus 4.6 |
| **Czas trwania** | ~3h |

---

## Aktywne zadanie

**Nazwa:** Wdrożenie Protokołu Sesji Cowork — system synchronizacji dwóch sesji

**Opis:** Zaprojektowanie i wdrożenie systemu bezpiecznej pracy dwóch Claude Cowork sesji (Mac Studio Oskara + MacBook Wiktorii) na tym samym folderze Google Drive. Trzy warstwy: git snapshot (recovery), detekcja konfliktów (na starcie i końcu sesji), inteligentny merge przez Claude (synteza obu wersji, nie wybór jednej).

---

## Stan roboczy (gdzie skończyliśmy)

**Etap:** PROTOKÓŁ SESJI COWORK WDROŻONY ✅

**Co zostało zrobione w tej sesji (26-03-2026, Cowork, sesja 3):**

**Audyt i diagnostyka problemu synchronizacji (kontynuacja z sesji 2):**
1. **Testy synchronizacji** — przetestowano jednoczesną edycję pliku z dwóch komputerów. Odkryto: Google Drive Mirror używa last-write-wins, nie tworzy conflict files przy normalnej pracy online. Zmiany jednej strony mogą zniknąć bez śladu.
2. **Analiza ryzyka** — zidentyfikowano że realne okno ryzyka jest wąskie (ten sam plik, te same sekundy), ale przy plikach systemowych (SESSION.md, MEMORY.md, STATUS_UPDATES.md) jest realne.
3. **Research branżowy** — zbadano jak duże firmy rozwiązują problem concurrent editing (Git branches, optimistic locking, CRDT, Obsidian Sync). Oceniono co jest adaptowalne dla 2-osobowej agencji.
4. **Odrzucone rozwiązania:** ownership zones (band-aid, nie skaluje się), git branches (nie działają z jednym folderem Google Drive), per-edit monitoring (zbyt kosztowny), lock files (wymaga manualnej dyscypliny), rozbijanie shared files na osobne per-user (łamie DRY).

**Zaprojektowanie i wdrożenie Protokołu Sesji Cowork:**
5. **CLAUDE.md v6.0** — przebudowana Sekcja 7: nowe warstwy bezpieczeństwa, dodane podsekcje 7.1 (jak działa sync), 7.2 (Protokół Sesji — START/PODCZAS/KONIEC), 7.3 (obsługa .auto-memory).
6. **Protokół trzywarstwowy:** git snapshot na starcie sesji (punkt odtworzenia) → normalna praca bez narzutu → weryfikacja edycji + inteligentny merge na końcu sesji.

**Nowa architektura synchronizacji (v2):**
```
Warstwa 1 — TRANSPORT:    Google Drive „Mój dysk" (Mirror, automatyczny, dwustronny)
Warstwa 2 — RECOVERY:     Git snapshoty lokalne (commit na start i koniec każdej sesji Cowork)
Warstwa 3 — DETEKCJA:     Weryfikacja edycji na koniec sesji (porównanie pamięci sesji z dyskiem)
Warstwa 4 — MERGE:        Inteligentny three-way merge przez Claude (Baza + Wersja A + Wersja B → Synteza)
Warstwa 5 — BACKUP:       GitHub (na żądanie /backup lub piątkowy)
```

---

## Następny krok

**Do zrobienia w następnej sesji:**
1. **Pierwszy test Protokołu Sesji** — uruchomić sesję na obu komputerach, zweryfikować że git snapshot działa, opcjonalnie wywołać kontrolowany konflikt i przetestować merge
2. **Konfiguracja nocnego Git cron** — automatyczny commit + push na GitHub o 23:00 (backup historii)
3. **Aktualizacja SOP** — `01_Procesy_Wewnetrzne/SOP_synchronizacja_zespolowa.md` — nowy workflow z Protokołem Sesji
4. **Przebudowa skill /sync** — dostosować do nowej architektury

**Inne zaległe zadania (z poprzednich sesji):**
- Praca nad `downloads/` — zawartość do posortowania
- Archiwizacja starych skryptów sync → `10_Archiwum/`
- Usunąć `folder testowy do usuniecia` z PIONA Studio
- Usunąć stary pusty folder z pulpitu (`Desktop/AI/PIONA Studio`)

---

## Otwarte pytania / flagi dla Oskara

- [x] ~~GitHub repo~~ — założone (PionaStudioBot/piona-studio)
- [x] ~~Google Drive sync~~ — wdrożony i przetestowany
- [x] ~~Protokół Sesji Cowork~~ — zaprojektowany i wdrożony w CLAUDE.md v6.0
- [ ] **Nocny Git cron** — do skonfigurowania (backup historii na GitHub)
- [ ] **Test Protokołu na żywo** — kontrolowany konflikt na dwóch komputerach
- [ ] **Stary folder `Desktop/AI/PIONA Studio`** — pusty, do usunięcia
- [ ] Folder `downloads/` — skrzynka podawcza, zostaje w root celowo

---

## Ważne ustalenia z tej sesji

- **Protokół Sesji Cowork** — OBOWIĄZKOWY dla każdego Coworka. Szczegóły: CLAUDE.md Sekcja 7.2
- **Google Drive Mirror = last-write-wins** przy jednoczesnej edycji tego samego pliku. NIE tworzy conflict files przy normalnej pracy online
- **Realne okno ryzyka jest wąskie** — ten sam plik, te same sekundy. Różne pliki lub ten sam plik edytowany minuty/godziny później → sync działa bezproblemowo
- **Jeśli konflikt nastąpi, ginie JEDNA edycja** — nie cały dzień pracy. Kolejne edycje po konflikcie sync-ują się normalnie
- **Git snapshoty to diffy, nie kopie** — lekkie, lokalne, ułamek sekundy. Push na GitHub zostaje ręczny (/backup)
- **Merge = synteza, nie wybór** — Claude czyta obie wersje, rozumie intencję, łączy. Nie „wybierz A albo B"
- **MEMORY.md odbudowywany ze skanu folderu** — jeśli indeks jest nieaktualny, Cowork uzupełnia go automatycznie
- Wszystkie ustalenia z sesji 25-03 nadal obowiązują
