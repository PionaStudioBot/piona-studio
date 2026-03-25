---
name: backup
description: |
  Wykonuje backup projektu PIONA Studio na GitHub — koło ratunkowe na wypadek szkód AI. Uruchom gdy użytkownik wpisze /backup, "zrób backup", "zapisz pracę", "zabezpiecz projekt", "kopia zapasowa", "archiwizuj" lub sygnalizuje koniec etapu pracy. Skill commituje wszystkie zmiany i pushuje na GitHub. Google Drive synchronizuje pliki automatycznie — nie wymaga interwencji.
---

# Backup — PIONA Studio (Koło Ratunkowe GitHub)

## Kontekst

Backup PIONA Studio to snapshot stanu projektu na GitHub. Jego rola: niezależna kopia na wypadek gdyby AI narobił szkód w plikach, które zsynchronizowałyby się przez Google Drive na oba komputery (Mac Studio Oskara i MacBook Wiktorii).

**Architektura bezpieczeństwa PIONA Studio:**
- Warstwa 1: Google Drive (real-time sync, automatyczny) — NIE wymaga interwencji
- Warstwa 2: GitHub (piątkowy backup + manualny /backup) — TEN SKILL
- Warstwa 3: Claude (semantic merge konfliktów) — na żądanie

**Lokalizacja projektu:**
- Cowork VM: `/sessions/.../mnt/PIONA Studio`
- Mac Studio: `~/Mój dysk/PIONA Studio/`
- MacBook Wiktorii: `~/Mój dysk/PIONA Studio/`
- GitHub: `PionaStudioBot/piona-studio` (private repo)

---

## Krok 1 — Znajdź folder projektu

```bash
find /sessions -name "CLAUDE.md" -path "*/PIONA Studio/*" -maxdepth 6 2>/dev/null | head -1 | xargs dirname
```

Użyj znalezionej ścieżki jako `PROJECT_DIR`.

---

## Krok 2 — Sprawdź czy Git jest zainicjalizowany

```bash
cd "<PROJECT_DIR>" && git status --porcelain 2>&1
```

**Jeśli Git NIE jest zainicjalizowany** (błąd "not a git repository"):

Poinformuj użytkownika:
> ⚠ Git nie jest jeszcze skonfigurowany w nowym folderze PIONA Studio (`~/Mój dysk/`).
> Potrzebuję jednorazowej konfiguracji — zainicjalizować Git i podłączyć do GitHub repo `PionaStudioBot/piona-studio`.
> Czy mogę to zrobić?

Po zgodzie:
```bash
cd "<PROJECT_DIR>" && git init && git remote add origin https://github.com/PionaStudioBot/piona-studio.git
```

**Jeśli Git jest zainicjalizowany** — przejdź do Kroku 3.

---

## Krok 3 — Sprawdź lokalne zmiany

```bash
cd "<PROJECT_DIR>" && git status --porcelain
```

Zlicz i wylistuj zmienione pliki według kategorii: nowe (`??`), zmodyfikowane (`M`), usunięte (`D`).

Jeśli brak zmian — poinformuj:
> ℹ Brak zmian od ostatniego backupu. Projekt jest aktualny na GitHub.

I zakończ (nie twórz pustego commita).

---

## Krok 4 — Commit + Push

Wygeneruj opis commita automatycznie na podstawie:
- Listy zmienionych plików i folderów
- Kontekstu bieżącej sesji pracy (jeśli znany)
- Daty i godziny

Format commita:
```
[Backup] DD.MM.YYYY HH:MM — X nowych, Y zmienionych: najważniejsze pliki/foldery
```

Wykonaj:
```bash
cd "<PROJECT_DIR>" && git add -A && git commit -m "<WIADOMOŚĆ>" && git push origin main 2>&1
```

**Jeśli push się nie uda:**
- `rejected` / `non-fast-forward` — NIE rób `git pull`. Poinformuj użytkownika: "GitHub ma nowsze zmiany. Użyj `git push --force` żeby nadpisać (backup jest ważniejszy niż historia remote) — ale potrzebuję Twojej zgody."
- Brak internetu → poinformuj że commit jest zapisany lokalnie, push przy następnej okazji
- Błąd autoryzacji → poinformuj że trzeba sprawdzić token GitHub

---

## Krok 5 — Zaktualizuj SESSION.md

Przed zakończeniem backupu, zaktualizuj datę ostatniej sesji w `SESSION.md` jeśli to koniec sesji pracy.

---

## Krok 6 — Potwierdź

Wyświetl zwięzłe podsumowanie:

```
✅ BACKUP ZAKOŃCZONY — [data i godzina]
   Zmiany:     [X plików / brak zmian]
   Commit:     [nazwa commita]
   GitHub:     [✅ wysłano / ⚠ tylko lokalnie]
   Google Drive: ✅ synchronizuje się automatycznie
```

---

## Zasady

- **Nigdy nie rób `git pull` ani `git merge`** — backup jest jednokierunkowy (lokalnie → GitHub)
- **Nigdy nie pytaj użytkownika o opis commita** — generuj automatycznie
- **Nie twórz pustych commitów** — jeśli brak zmian, zakończ informując użytkownika
- **Google Drive NIE wymaga interwencji** — pliki synchronizują się automatycznie, nie uruchamiaj żadnych skryptów Drive
- Komunikuj się wyłącznie po polsku
- Jeśli któryś krok się nie powiedzie — opisz błąd i nie kontynuuj do następnego
