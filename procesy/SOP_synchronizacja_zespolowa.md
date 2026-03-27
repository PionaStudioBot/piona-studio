# SOP: Synchronizacja Zespołowa PIONA Studio

## O co chodzi?

Oskar (Mac Studio) i Wiktoria (MacBook) pracują jednocześnie na tym samym folderze PIONA Studio. Google Drive synchronizuje pliki między komputerami automatycznie w czasie rzeczywistym. Protokół Sesji Cowork chroni przed utratą danych gdy obie osoby edytują ten sam plik w tym samym czasie.

## Architektura

```
Warstwa 1 — TRANSPORT:    Google Drive Mirror (automatyczny, dwustronny, real-time)
Warstwa 2 — RECOVERY:     Git snapshoty lokalne (commit na start i koniec każdej sesji Cowork)
Warstwa 3 — DETEKCJA:     Weryfikacja edycji na koniec sesji (Claude porównuje pamięć z dyskiem)
Warstwa 4 — MERGE:        Inteligentny three-way merge przez Claude (synteza obu wersji)
Warstwa 5 — BACKUP:       GitHub (na żądanie /backup lub piątkowy)
```

**Zasada:** Google Drive synchronizuje wszystko. Git jest siatką bezpieczeństwa — punktem odtworzenia gdy Drive nadpisze czyjąś edycję.

---

## Codzienny workflow

### Zaczynam pracę

1. Otwórz Cowork
2. Powiedz: **"Rozpocznij sesję"** — Claude wykona Protokół startowy automatycznie (usuwa stare lock files, robi git snapshot, skanuje pamięć)
3. Pracuj normalnie

### Kończę pracę

1. Powiedz Claude: **"Zakończ sesję"** — Claude wykona Protokół końcowy automatycznie (weryfikuje swoje edycje, wykrywa konflikty, merguje jeśli trzeba, robi git snapshot)
2. Gotowe

### Chcę wysłać backup na GitHub

Powiedz: `/backup` — Claude commituje i pushuje na GitHub.

---

## Co jeśli pojawi się komunikat o błędzie?

### Sytuacja 1: Claude mówi „HEAD.lock zablokował snapshot"

**Co to znaczy:** Google Drive zsynchronizował plik blokady z drugiego komputera. Claude poradził sobie (`mv` zamiast `rm`) — prawdopodobnie snapshot się powiódł mimo warningów. Nie wymaga Twojej akcji, chyba że Claude wyraźnie poprosi o pomoc.

### Sytuacja 2: Claude mówi „index.lock — potrzebuję Twojej pomocy"

**Co zrobić (bez terminala):**
1. Otwórz Finder
2. Naciśnij **Cmd+Shift+.** (pokazuje ukryte pliki)
3. Przejdź do folderu `PIONA Studio`
4. Wejdź do folderu `.git`
5. Znajdź plik `index.lock` — przesuń go do Kosza
6. Wróć do Cowork i powiedz: „Gotowe, usunęłam index.lock"

### Sytuacja 3: Claude mówi „`.git` zmienił się na `.git (1)`"

**Co to znaczy:** Google Drive zmienił nazwę folderu git podczas synchronizacji. To psuje całe repozytorium na tym komputerze.

**Co zrobić (bez terminala):**
1. Otwórz Finder
2. Naciśnij **Cmd+Shift+.** (pokazuje ukryte pliki)
3. Przejdź do folderu `PIONA Studio`
4. Znajdź folder `.git (1)`
5. Kliknij na niego raz, naciśnij **Enter**, zmień nazwę na `.git` (usuń ` (1)`)
6. Naciśnij Enter
7. Wróć do Cowork i powiedz: „Gotowe, zmieniłam nazwę z powrotem na .git"

### Sytuacja 4: Claude mówi „Wykryłem konflikt — mergowałem [plik]"

**Co to znaczy:** Obie osoby edytowały ten sam plik prawie jednocześnie. Drive nadpisał jedną wersję. Claude wykrył to i połączył obie zmiany. **Nie trzeba nic robić** — przeczytaj tylko co Claude zmergował i potwierdź że wynik jest poprawny.

### Sytuacja 5: Widzę komunikat „Zachowaj mimo to" od Google Drive

**Nigdy nie klikaj „Zachowaj mimo to"** — to nadpisuje wersję drugiej osoby. Zamknij dialog i powiedz Claude co się stało.

---

## Protokół Sesji Cowork (szczegóły techniczne)

Każda sesja Cowork wykonuje ten protokół automatycznie. Tu jest opis co Claude robi i dlaczego.

### START SESJI

1. **Usuwa stare lock files** — sprawdza `.git/HEAD.lock` i `.git/index.lock`. Jeśli istnieją (Drive przyniósł je z drugiego komputera) — usuwa przez `mv lock lock.bak`. Jeśli nie może (brak uprawnień) — prosi użytkownika o pomoc przez Finder.
2. **Git snapshot** — `git add -A && git commit -m "snapshot-start: [macstudio/macbook] [data godzina]"`. To jest punkt odtworzenia — jeśli coś pójdzie nie tak, można cofnąć do tego momentu. Jeśli są niezcommitowane zmiany (przyszły z Drive od drugiego komputera) — też je commituje.
3. **Skan pamięci** — przegląda `.auto-memory/` i uzupełnia `MEMORY.md` jeśli są nowe pliki pamięci.

### PODCZAS SESJI

Normalna praca. Claude zapamiętuje które pliki edytował i jak wyglądały po edycji.

### KONIEC SESJI

1. **Weryfikacja** — ponownie czyta każdy plik który edytował. Porównuje z tym co pamięta że zapisał.
2. **Jeśli treść się zgadza** — brak konfliktu, przechodzi dalej.
3. **Jeśli treść się różni** — wykryty konflikt (Drive nadpisał). Claude pobiera wersję bazową z git snapshota, ma teraz 3 wersje: Baza (snapshot) + Jego edycja (pamięć) + Dysk (wersja Drive). Tworzy syntezę łączącą obie zmiany. Informuje użytkownika.
4. **Git snapshot końcowy** — `git commit` z wynikiem sesji.
5. **Aktualizuje SESSION.md** — handoff dla następnej sesji.

---

## Ważne zasady

- **`rm` nie działa na FUSE mount** — Claude używa `mv lock lock.bak` (nie `rm`) przy lock files. To normalne, nie jest błędem.
- **`git checkout HEAD -- plik` nie działa na FUSE** — Claude używa `git show HEAD:"ścieżka" > /tmp/restored.md && cp /tmp/restored.md "ścieżka"` przy recovery.
- **Warningi `unable to unlink tmp_obj`** — pojawiają się przy każdym commit na FUSE mount. Nie blokują commitów — są kosmetyczne.
- **Nigdy nie klikaj „Zachowaj mimo to"** gdy Drive blokuje plik — to nadpisuje cudzą wersję bez merge.

---

## Co Git śledzi, a co nie

### Śledzone przez Git (synchronizowane przez GitHub przy /backup):
- Wszystkie pliki `.md` (strategie, SOP, baza wiedzy, sesje)
- Pliki `.py`, `.sh`, `.command` (skrypty)
- Pliki `.html`, `.css`, `.js` (strona WWW)
- `.cursorrules`, `SESSION.md`, `CLAUDE.md`

### NIE śledzone przez Git (synchronizowane przez Google Drive):
- Obrazy (jpg, png, gif, svg), video (mp4, mov)
- Pliki projektowe (psd, ai, sketch), fonty, modele 3D
- ZIPy, PDFy, folder `10_Archiwum/`, folder `Backup/`, Brand Assets

---

## FAQ

**P: Czy muszę cokolwiek robić ręcznie przy synchronizacji?**
O: Prawie nigdy. Powiedz „Rozpocznij sesję" i „Zakończ sesję" — Claude robi resztę. Ręczna akcja wymagana tylko przy index.lock lub `.git (1)` (instrukcje wyżej).

**P: Co jeśli zapomnę powiedzieć „Zakończ sesję"?**
O: Twoje edycje są w Google Drive (zsynchronizowane). Nie ma git snapshota końcowego — ale przy następnej sesji Cowork na dowolnym komputerze, Protokół startowy commituje niezcommitowane zmiany automatycznie.

**P: Co jeśli oba Coworki edytują ten sam plik jednocześnie?**
O: Drive zastosuje last-write-wins (jedna wersja nadpisze drugą). Protokół końcowy to wykryje i zmerguje automatycznie — żadne dane nie giną.

**P: Czy mogę pracować offline?**
O: Tak. Google Drive buforuje zmiany i synchronizuje gdy wróci internet. Git snapshoty są zawsze lokalne — nie wymagają sieci.

**P: Co jeśli przypadkowo usunę plik?**
O: Git pamięta wszystko. Powiedz Claude: „Odzyskaj plik [ścieżka] z ostatniego snapshota" — Claude użyje `git show` żeby przywrócić.

---

*Wersja: 2.0 | Data: 2026-03-26 | Autor: Oskar + Claude*
*Poprzednia wersja (v1.0, Git-centric workflow) zastąpiona przez Google Drive + Protokół Sesji Cowork*
