---
name: backup
description: |
  Wykonuje backup projektu PIONA Studio na GitHub — koło ratunkowe na wypadek szkód AI. Uruchom gdy użytkownik wpisze /backup, "zrób backup", "zapisz pracę", "zabezpiecz projekt", "kopia zapasowa", "archiwizuj" lub sygnalizuje koniec etapu pracy. Skill commituje wszystkie zmiany i pushuje na swój branch + main.
---

# Backup — PIONA Studio (Koło Ratunkowe GitHub)

## Kontekst

Backup PIONA Studio to snapshot stanu projektu na GitHub. Jego rola: niezależna kopia na wypadek gdyby AI narobił szkód w plikach.

**Architektura bezpieczeństwa PIONA Studio:**
- Warstwa 1: Git branches (oskar/wika) — codzienna praca
- Warstwa 2: GitHub main (merged) — TEN SKILL
- Warstwa 3: Claude (semantic merge konfliktów) — /sync

**Lokalizacja projektu:**
- Cowork VM: `/sessions/.../mnt/PIONA-AI`
- Mac Studio (Oskar): `~/Desktop/AI/PIONA-AI/` → branch `oskar`
- MacBook (Wiktoria): `~/Desktop/AI/PIONA-AI/` → branch `wika`
- GitHub: `PionaStudioBot/piona-studio` (private repo)

---

## Krok 0 — Znajdź folder projektu i aktualny branch

```bash
PROJECT_DIR=$(find /sessions -name ".cursorrules" -maxdepth 6 2>/dev/null | head -1 | xargs dirname)
echo "PROJECT_DIR: $PROJECT_DIR"
cd "$PROJECT_DIR"
MY_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
echo "BRANCH: $MY_BRANCH"
```

Jeśli `MY_BRANCH` to `main` — poinformuj: "Jesteś na branchu main. Backup powinien działać z brancha oskar lub wika." i czekaj na odpowiedź.

---

## Krok 1 — Wyczyść lock files

```bash
cd "$PROJECT_DIR"
find .git -name "*.lock" 2>/dev/null | while read f; do mv "$f" "${f}.dead" 2>/dev/null || true; done
echo "Lock files wyczyszczone"
```

---

## Krok 2 — Sprawdź lokalne zmiany

```bash
cd "$PROJECT_DIR" && git status --porcelain
```

Zlicz i wylistuj zmienione pliki według kategorii: nowe (`??`), zmodyfikowane (`M`), usunięte (`D`).

Jeśli brak zmian — poinformuj:
> ℹ Brak zmian od ostatniego backupu. Projekt jest aktualny na GitHub.

I zakończ (nie twórz pustego commita).

---

## Krok 3 — Commit + Push na swój branch

Wygeneruj opis commita automatycznie:
```
[Backup] DD.MM.YYYY HH:MM — X nowych, Y zmienionych: najważniejsze pliki/foldery
```

```bash
cd "$PROJECT_DIR"
git add -A
git commit -m "<WIADOMOŚĆ>" 2>&1
find .git -name "*.lock" 2>/dev/null | while read f; do mv "$f" "${f}.dead" 2>/dev/null || true; done
git push origin "$MY_BRANCH" 2>&1
```

---

## Krok 4 — Merge do main (shadow clone w /tmp)

```bash
rm -rf /tmp/piona-backup 2>/dev/null || true
REMOTE_URL=$(cd "$PROJECT_DIR" && git remote get-url origin)
git clone "$REMOTE_URL" /tmp/piona-backup 2>&1
cd /tmp/piona-backup

git config user.name "$(cd "$PROJECT_DIR" && git config user.name)"
git config user.email "$(cd "$PROJECT_DIR" && git config user.email)"

git fetch origin 2>&1
git checkout main
git pull origin main 2>&1

echo "--- Mergowanie $MY_BRANCH do main ---"
git merge "origin/$MY_BRANCH" --no-edit 2>&1
MERGE_EXIT=$?
```

**Jeśli `MERGE_EXIT != 0` (konflikt):**
Rozwiąż konflikty jak w /sync (three-way merge, synteza nie wybór).

**Po udanym merge:**
```bash
cd /tmp/piona-backup
git push origin main 2>&1
```

Wyczyść:
```bash
rm -rf /tmp/piona-backup
```

---

## Krok 5 — Zaktualizuj SESSION.md

Przed zakończeniem backupu, zaktualizuj datę ostatniej sesji w `SESSION.md` jeśli to koniec sesji pracy.

---

## Krok 6 — Potwierdź

```
✅ BACKUP ZAKOŃCZONY — [data i godzina]
   Branch:      [oskar / wika]
   Zmiany:      [X plików / brak zmian]
   Push branch: [✅ wysłano / ⚠ błąd]
   Merge main:  [✅ / ⚠ konflikt rozwiązany]
   Push main:   [✅ GitHub / ⚠ tylko lokalnie]
```

---

## Zasady

- **Nigdy nie rób `git merge` ani `git pull` na mounted folderze** — merge w `/tmp/piona-backup/`
- **Nigdy nie pytaj użytkownika o opis commita** — generuj automatycznie
- **Nie twórz pustych commitów** — jeśli brak zmian, zakończ informując użytkownika
- **Nigdy nie używaj `rm` na plikach `.git/`** — używaj `mv plik plik.dead`
- Komunikuj się wyłącznie po polsku
- Jeśli któryś krok się nie powiedzie — opisz błąd i nie kontynuuj do następnego
