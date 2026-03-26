# Plan Testów — Protokół Sesji Cowork

**Data utworzenia:** 26-03-2026
**Cel:** Walidacja systemu synchronizacji dwóch sesji Cowork (Mac Studio + MacBook)
**Plik testowy:** `09_Notatki_i_Brudnopisy/TEST_SYNC_PLIK.md`
**Po testach:** Usunąć oba pliki testowe (ten plan + plik testowy)

---

## Przygotowanie przed testami

1. Upewnij się że Google Drive sync działa na obu komputerach (zielone checkmarki)
2. Upewnij się że `TEST_SYNC_PLIK.md` jest widoczny na obu komputerach
3. Git snapshot: `git add -A && git commit -m "pre-test: baseline"` (z Mac Studio)
4. Poczekaj 30 sekund na sync do MacBook

---

## TEST 1: Snapshot na starcie sesji (Baseline)

**Cel:** Weryfikacja że Cowork poprawnie tworzy git snapshot na starcie sesji.
**Wymaga:** Jednego komputera (Mac Studio).

**Kroki:**
1. Otwórz nową sesję Cowork na Mac Studio
2. Powiedz Coworkowi: "Rozpocznij sesję zgodnie z Protokołem z CLAUDE.md 7.2"
3. Obserwuj czy Cowork wykonuje `git add -A && git commit`
4. Sprawdź `git log --oneline -3`

**Oczekiwany rezultat:**
- Cowork wykonał `git commit` z wiadomością `snapshot-start: macstudio [data] [godzina]`
- `git log` pokazuje nowy commit na górze historii
- Cowork przeskanował `.auto-memory/` i porównał z `MEMORY.md`

**PASS:** Snapshot widoczny w `git log`, Cowork zgłosił wykonanie protokołu startowego.
**FAIL:** Brak commita, Cowork pominął snapshot, albo `git commit` zwrócił błąd (np. index.lock).

---

## TEST 2: Normalna praca — różne pliki, oba komputery (Sanity Check)

**Cel:** Potwierdzenie że Google Drive sync działa poprawnie przy edycji różnych plików.
**Wymaga:** Obu komputerów jednocześnie.

**Kroki:**
1. **Mac Studio (Oskar):** Otwórz Cowork, powiedz: "W pliku TEST_SYNC_PLIK.md, w Sekcji Oskara wpisz: Oskar był tu - test 2"
2. **Poczekaj 60 sekund** (czas na sync Google Drive)
3. **MacBook (Wiktoria):** Otwórz Cowork, powiedz: "Przeczytaj plik 09_Notatki_i_Brudnopisy/TEST_SYNC_PLIK.md"
4. Sprawdź czy Wiktoria widzi wpis Oskara
5. **MacBook (Wiktoria):** Powiedz: "W pliku TEST_SYNC_PLIK.md, w Sekcji Wiktorii wpisz: Wiktoria była tu - test 2"
6. **Poczekaj 60 sekund**
7. **Mac Studio (Oskar):** Przeczytaj TEST_SYNC_PLIK.md

**Oczekiwany rezultat:**
- Po kroku 4: MacBook widzi "Oskar był tu - test 2" w Sekcji Oskara
- Po kroku 7: Mac Studio widzi OBA wpisy — Oskara i Wiktorii

**PASS:** Oba wpisy widoczne na obu komputerach po sync.
**FAIL:** Któryś wpis brakuje na jednym z komputerów.

**Czyszczenie:** Przywróć TEST_SYNC_PLIK.md do stanu bazowego (usuń wpisy testowe).

---

## TEST 3: Ten sam plik, różny czas — sync zdąży (Sanity Check)

**Cel:** Potwierdzenie że edycja tego samego pliku z odstępem 2+ minut nie powoduje konfliktu.
**Wymaga:** Obu komputerów.

**Kroki:**
1. **Mac Studio (Oskar):** Cowork edytuje Sekcję wspólną: zmień "Wartość bazowa: 100" na "Wartość bazowa: 200"
2. **Poczekaj 2 minuty** (pewność synca)
3. **MacBook (Wiktoria):** Przeczytaj TEST_SYNC_PLIK.md — zweryfikuj że wartość = 200
4. **MacBook (Wiktoria):** Cowork edytuje Sekcję wspólną: zmień "Status: aktywny" na "Status: przetestowany"
5. **Poczekaj 2 minuty**
6. **Mac Studio (Oskar):** Przeczytaj TEST_SYNC_PLIK.md

**Oczekiwany rezultat:**
- Po kroku 6: Mac Studio widzi "Wartość bazowa: 200" ORAZ "Status: przetestowany"
- Obie zmiany zachowane, zero utraty danych

**PASS:** Oba komputery mają identyczną treść z obiema zmianami.
**FAIL:** Któraś zmiana zaginęła, albo wartość wróciła do starej.

**Czyszczenie:** Przywróć TEST_SYNC_PLIK.md do stanu bazowego.

---

## TEST 4: KONFLIKT — ten sam plik, jednoczesna edycja (KRYTYCZNY)

**Cel:** Wywołanie kontrolowanego konfliktu i weryfikacja że Protokół Sesji go wykrywa i merguje.
**Wymaga:** Obu komputerów, precyzyjnej koordynacji.

### Faza A: Wywołanie konfliktu

**Kroki:**
1. **Oba komputery:** Upewnij się że TEST_SYNC_PLIK.md jest w stanie bazowym
2. **Mac Studio (Oskar):** Otwórz Cowork, wykonaj Protokół startowy (snapshot)
3. **MacBook (Wiktoria):** Otwórz Cowork, wykonaj Protokół startowy (snapshot)
4. **JEDNOCZEŚNIE (sygnał "teraz!"):**
   - **Mac Studio:** Powiedz Coworkowi: "W TEST_SYNC_PLIK.md zmień Sekcję Oskara na: Oskar dodał feedback o kolorach marki - test 4"
   - **MacBook:** Powiedz Coworkowi: "W TEST_SYNC_PLIK.md zmień Sekcję Wiktorii na: Wiktoria dodała feedback o tonie komunikacji - test 4"
5. **Poczekaj 30 sekund** (Google Drive sync)
6. **Oba komputery:** Przeczytaj TEST_SYNC_PLIK.md — zanotuj co widzisz

**Oczekiwany rezultat po kroku 6:**
- Prawdopodobnie jedno z urządzeń ma OBA wpisy (sync zdążył), drugie ma tylko swój
- LUB jedno urządzenie straciło wpis drugiego (last-write-wins)
- To jest OCZEKIWANE zachowanie — test dopiero sprawdza czy system to wykryje

### Faza B: Detekcja konfliktu (end-of-session)

**Kroki:**
7. **Mac Studio (Oskar):** Powiedz Coworkowi: "Zakończ sesję zgodnie z Protokołem z CLAUDE.md 7.2"
8. Obserwuj czy Cowork:
   a. Ponownie czyta TEST_SYNC_PLIK.md
   b. Porównuje z tym co sam zapisał
   c. Wykrywa różnicę (jeśli plik został nadpisany przez sync)
   d. Jeśli wykrył — pobiera bazę z git snapshot, merguje, informuje cię

**Oczekiwany rezultat:**
- **Scenariusz A (brak konfliktu):** Cowork czyta plik, treść się zgadza z tym co zapisał, raportuje "brak konfliktu" → PASS
- **Scenariusz B (wykryty konflikt):** Cowork czyta plik, wykrywa że jego edycja zniknęła, pobiera bazę z git, merguje wersję swoją + dyskową, zapisuje syntezę zawierającą OBA wpisy, informuje użytkownika → PASS
- **Scenariusz C (konflikt ale niewykryty):** Cowork czyta plik, nie zauważa różnicy, kończy sesję → FAIL

### Faza C: Weryfikacja merge'a

**Kroki:**
9. **Po zakończeniu sesji na obu komputerach:** Poczekaj 60 sekund na sync
10. **Oba komputery:** Przeczytaj TEST_SYNC_PLIK.md

**PASS KOŃCOWY:** TEST_SYNC_PLIK.md na obu komputerach zawiera:
- Sekcja Oskara: "Oskar dodał feedback o kolorach marki - test 4"
- Sekcja Wiktorii: "Wiktoria dodała feedback o tonie komunikacji - test 4"
- Sekcja wspólna: niezmieniona

**FAIL:** Którykolwiek wpis brakuje w finalnej wersji pliku na którymkolwiek komputerze.

**Czyszczenie:** Przywróć TEST_SYNC_PLIK.md do stanu bazowego. Git commit.

---

## TEST 5: Oba Coworki dodają feedback jednocześnie (Memory System)

**Cel:** Weryfikacja że osobne pliki pamięci nie kolidują, a MEMORY.md jest odbudowywany ze skanu.
**Wymaga:** Obu komputerów.

**Kroki:**
1. **JEDNOCZEŚNIE:**
   - **Mac Studio:** Powiedz Coworkowi: "Zapamiętaj feedback: W testach zawsze używaj pliku z 09_Notatki_i_Brudnopisy, nigdy z produkcji. Zapisz jako feedback_test_oskar.md"
   - **MacBook:** Powiedz Coworkowi: "Zapamiętaj feedback: Przy synchronizacji sprawdzaj zawsze dwa komputery, nie jeden. Zapisz jako feedback_test_wiktoria.md"
2. **Poczekaj 60 sekund** na sync
3. **Mac Studio:** Sprawdź `ls .auto-memory/` — czy widać oba pliki?
4. **MacBook:** Sprawdź `ls .auto-memory/` — czy widać oba pliki?
5. **Mac Studio:** Otwórz nową sesję Cowork. Protokół startowy powinien przeskanować folder i uzupełnić MEMORY.md
6. Sprawdź MEMORY.md — czy zawiera wpisy o obu feedbackach?

**PASS:** Oba pliki feedback istnieją na obu komputerach. MEMORY.md zawiera wpisy o obu po skanie.
**FAIL:** Któryś plik brakuje, albo MEMORY.md nie został uzupełniony o brakujący wpis.

**Czyszczenie:** Usuń feedback_test_oskar.md i feedback_test_wiktoria.md. Zaktualizuj MEMORY.md.

---

## TEST 6: Git recovery — odzyskanie utraconej edycji (Recovery)

**Cel:** Potwierdzenie że git snapshot pozwala odzyskać nadpisaną edycję.
**Wymaga:** Jednego komputera (Mac Studio).

**Kroki:**
1. Git snapshot: `git add -A && git commit -m "test6: pre-edit"`
2. Cowork edytuje TEST_SYNC_PLIK.md — dodaje tekst "WAŻNA EDYCJA DO ODZYSKANIA"
3. Git snapshot: `git add -A && git commit -m "test6: after-edit"`
4. **Symulacja nadpisania:** Ręcznie (lub przez drugi komputer) nadpisz TEST_SYNC_PLIK.md stanem bazowym (bez "WAŻNA EDYCJA")
5. Sprawdź `git diff` — czy pokazuje utracone zmiany?
6. Odzyskaj: `git show HEAD:09_Notatki_i_Brudnopisy/TEST_SYNC_PLIK.md` — czy widać "WAŻNA EDYCJA"?
7. Przywróć: `git checkout HEAD -- 09_Notatki_i_Brudnopisy/TEST_SYNC_PLIK.md`

**PASS:** `git show HEAD` zawiera utraconą edycję. Recovery przez `git show` + `cp` przywraca ją na dysk.
**FAIL:** Git nie ma snapshota, albo `git show` nie zawiera edycji.

**⚠️ ODKRYCIE (26-03-2026):** `git checkout HEAD -- plik` NIE działa na FUSE/Google Drive mount (EPERM przy unlink). Prawidłowa komenda recovery:
```bash
git show HEAD:"ścieżka/do/pliku" > /tmp/restored.md && cp /tmp/restored.md "ścieżka/do/pliku"
```
Tak samo `mv` działa tam gdzie `rm` nie — przy HEAD.lock używaj `mv lock lock.bak` zamiast `rm lock`.

**Czyszczenie:** Przywróć stan bazowy.

---

## TEST 7: index.lock blokuje snapshot (Edge Case)

**Cel:** Sprawdzenie jak Cowork radzi sobie gdy git snapshot nie przechodzi z powodu index.lock.
**Wymaga:** Jednego komputera.

**Kroki:**
1. Utwórz pusty plik `.git/index.lock` (symulacja stanu po crashu gita lub konflikcie Google Drive sync)
2. Otwórz Cowork, powiedz: "Rozpocznij sesję zgodnie z Protokołem"
3. Obserwuj reakcję Coworka na błąd `git commit`

**Oczekiwany rezultat:**
- Cowork wykrywa błąd index.lock
- Próbuje usunąć/przenieść plik lock
- Jeśli się uda — kontynuuje snapshot
- Jeśli nie (brak uprawnień, jak w Cowork VM) — informuje użytkownika i proponuje ręczne usunięcie
- NIE przechodzi do pracy bez snapshota lub bez poinformowania o braku snapshota

**PASS:** Cowork rozpoznaje problem, podejmuje działanie, informuje użytkownika.
**FAIL:** Cowork ignoruje błąd i zaczyna pracę bez snapshota.

---

## TEST 8: Sesja crashuje bez end-protocol (Edge Case)

**Cel:** Co się dzieje gdy Cowork nie wykona procedury końca sesji (np. sesja wygaśnie, użytkownik zamknie okno).
**Wymaga:** Jednego komputera, potem drugiego.

**Kroki:**
1. **Mac Studio:** Otwórz Cowork, wykonaj Protokół startowy (snapshot-start)
2. **Mac Studio:** Cowork edytuje TEST_SYNC_PLIK.md — dodaje tekst
3. **Mac Studio:** ZAMKNIJ Cowork BEZ komendy zakończenia sesji (symulacja crasha)
4. **Poczekaj 60 sekund** na sync
5. **MacBook:** Otwórz Cowork, wykonaj Protokół startowy
6. Obserwuj: czy git status/log pokazuje niezcommitowane zmiany od Oskara?

**Oczekiwany rezultat:**
- Na starcie sesji MacBook: `git status` pokazuje zmieniony TEST_SYNC_PLIK.md (edycja Oskara zsynchronizowana przez Google Drive, ale nie commitowana)
- Cowork commituje te zmiany jako snapshot-start → edycja Oskara jest bezpieczna w git
- Jeśli edycja Oskara została nadpisana przez sync → git diff z ostatnim snapshotem ujawnia co zginęło

**PASS:** Edycja Oskara (bez end-protocol) jest widoczna w git historii po starcie sesji na MacBook.
**FAIL:** Edycja Oskara przepadła bezpowrotnie — brak w git, brak na dysku.

---

## TEST 9: Dwie sesje cały dzień, jedna edycja tego samego pliku (Scenariusz Realny)

**Cel:** Symulacja realnego dnia pracy — najważniejszy test, bo odwzorowuje rzeczywistość.
**Wymaga:** Obu komputerów, ~30 minut.

**Kroki:**
1. **Rano (Mac Studio):** Otwórz Cowork. Protokół startowy. Edytuj TEST_SYNC_PLIK.md — Sekcja Oskara: "Poranny wpis Oskara"
2. **Poczekaj 2 minuty**
3. **Rano (MacBook):** Otwórz Cowork. Protokół startowy. Sprawdź czy widzi poranny wpis Oskara
4. **MacBook:** Edytuj TEST_SYNC_PLIK.md — Sekcja Wiktorii: "Poranny wpis Wiktorii"
5. **Poczekaj 2 minuty**
6. **Południe (Mac Studio):** Edytuj TEST_SYNC_PLIK.md — Sekcja Oskara: dodaj "Południowy wpis Oskara" (pod porannym)
7. **JEDNOCZEŚNIE (symulacja konfliktu):**
   - **Mac Studio:** Edytuj Sekcję wspólną: "Wartość bazowa: 500"
   - **MacBook:** Edytuj Sekcję wspólną: "Status: zaktualizowany"
8. **Poczekaj 30 sekund**
9. **Mac Studio:** Zakończ sesję (Protokół końcowy)
10. **MacBook:** Zakończ sesję (Protokół końcowy)
11. **Poczekaj 60 sekund** na sync
12. **Oba komputery:** Przeczytaj TEST_SYNC_PLIK.md

**PASS KOŃCOWY:** Finalny plik zawiera WSZYSTKO:
- Sekcja Oskara: "Poranny wpis Oskara" + "Południowy wpis Oskara"
- Sekcja Wiktorii: "Poranny wpis Wiktorii"
- Sekcja wspólna: "Wartość bazowa: 500" ORAZ "Status: zaktualizowany"
- Zero utraconego contentu

**FAIL:** Jakikolwiek wpis brakuje w finalnej wersji.

---

## Kolejność wykonania testów

| Kolejność | Test | Typ | Zależność |
|-----------|------|-----|-----------|
| 1 | TEST 1 (Snapshot) | Baseline | Brak — wykonaj pierwszy |
| 2 | TEST 7 (index.lock) | Edge case | Po TEST 1 — testuje obsługę błędu snapshota |
| 3 | TEST 2 (Różne pliki) | Sanity | Po TEST 1 — potwierdza basic sync |
| 4 | TEST 3 (Ten sam plik, różny czas) | Sanity | Po TEST 2 — potwierdza sync z odstępem |
| 5 | TEST 6 (Git recovery) | Recovery | Po TEST 1 — potwierdza że git działa jako safety net |
| 6 | TEST 4 (KONFLIKT) | Krytyczny | Po TEST 1-3 i TEST 6 — core test systemu |
| 7 | TEST 5 (Memory system) | Średni | Po TEST 4 — testuje osobny podsystem |
| 8 | TEST 8 (Crash) | Edge case | Po TEST 4 — testuje recovery bez end-protocol |
| 9 | TEST 9 (Cały dzień) | Realny | OSTATNI — integracyjny test all-in-one |

---

## Po zakończeniu testów

1. Przywróć TEST_SYNC_PLIK.md do stanu bazowego lub usuń
2. Usuń ten plik (PLAN_TESTOW_SYNC.md)
3. Usuń testowe pliki feedback (feedback_test_oskar.md, feedback_test_wiktoria.md)
4. Git commit: `git add -A && git commit -m "cleanup: test files removed"`
5. Zaktualizuj SESSION.md z wynikami testów
