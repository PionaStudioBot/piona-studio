---
name: sync
description: |
  Synchronizuje projekt PIONA Studio z GitHub — commituje lokalne zmiany z auto-wygenerowaną wiadomością i pushuje na GitHub. Uruchom ten skill gdy użytkownik wpisze /sync, "synchronizuj", "sync projekt", "wyślij zmiany", "pobierz zmiany zespołu", "zaktualizuj git", "zapisz i wyślij zmiany" lub "sprawdź zmiany". Skill działa w 4 krokach: sprawdź lokalne zmiany → sprawdź GitHub → zapisz (commit z auto-opisem) → wyślij (push). Zawsze używaj tego skilla dla wszelkich operacji Git w projekcie PIONA Studio.
---

# Sync v4 — PIONA Studio Git Synchronizacja

## Kontekst środowiska

Cowork VM montuje folder PIONA Studio przez bindfs (FUSE). Ograniczenia:
- `unlink` → EPERM (blokuje `git merge`, `git pull`, `git checkout` bezpośrednio na zamontowanym folderze)
- `cp` (nadpisywanie) → DZIAŁA
- `git commit`, `git push`, `git fetch` → DZIAŁAJĄ
- Lock files `.git/*.lock` → nie da się usunąć przez `rm`, trzeba `mv plik plik.dead`

**Rozwiązanie:** Shadow Clone w `/tmp/` — merge odbywa się na natywnym filesystemie, wyniki wracają przez `cp`.

---

## Krok 0 — Znajdź folder projektu i wyczyść lock files

```bash
PROJECT_DIR=$(find /sessions -name ".cursorrules" -maxdepth 6 2>/dev/null | head -1 | xargs dirname)
echo "PROJECT_DIR=$PROJECT_DIR"
cd "$PROJECT_DIR"
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "BRANCH=$CURRENT_BRANCH"
find .git -name "*.lock" 2>/dev/null | while read f; do
  mv "$f" "${f}.dead" 2>/dev/null && echo "Usunięto lock: $f"
done
```

Jeśli nie było lock files — kontynuuj bez komentarza.

---

## Krok 1 — Sprawdź lokalne zmiany

```bash
cd "$PROJECT_DIR" && git status --porcelain
```

Zlicz i wylistuj zmienione pliki: nowe (`??`), zmodyfikowane (`M`), usunięte (`D`). Jeśli brak zmian — powiedz krótko i przejdź dalej.

---

## Krok 2 — Commit lokalnych zmian

**Jeśli są zmiany do zapisania:**

Wygeneruj opis commita automatycznie na podstawie listy zmienionych plików i kontekstu sesji. Format:

```
[Auto] Aktualizacja DD.MM HH:MM — X nowych, Y zmienionych: plik1, plik2, plik3
```

Zasady:
- Max 5 nazw plików (bez pełnej ścieżki)
- Jeśli zmiany dotyczą jednego obszaru — wspomnij o nim
- Jeśli w sesji były konkretne zadania — użyj tej wiedzy

```bash
cd "$PROJECT_DIR" && git add -A && git commit -m "<WIADOMOŚĆ>" --quiet 2>&1
```

Wyczyść lock files po commit:
```bash
find .git -name "*.lock" 2>/dev/null | while read f; do mv "$f" "${f}.dead" 2>/dev/null || true; done
```

**Nigdy nie pytaj użytkownika o opis commita.**

**Jeśli brak zmian:** poinformuj krótko, przejdź do Kroku 3.

---

## Krok 3 — Push na swój branch + fetch

```bash
cd "$PROJECT_DIR"
git push origin "$CURRENT_BRANCH" 2>&1
```

Jeśli push się nie powiódł z powodu braku upstream:
```bash
git push -u origin "$CURRENT_BRANCH" 2>&1
```

Następnie fetch:
```bash
git fetch origin --quiet 2>&1
```

Sprawdź rozbieżność z `origin/main`:
```bash
BEHIND=$(git log --oneline $CURRENT_BRANCH..origin/main 2>/dev/null | wc -l | tr -d ' ')
echo "Za origin/main o: $BEHIND commitów"
```

Sprawdź też czy inny branch (oskar/wika) ma zmiany do merge:
```bash
for BRANCH in oskar wika; do
  if [ "$BRANCH" != "$CURRENT_BRANCH" ]; then
    REMOTE_EXISTS=$(git rev-parse origin/$BRANCH 2>/dev/null)
    if [ -n "$REMOTE_EXISTS" ]; then
      BEHIND_BRANCH=$(git log --oneline main..origin/$BRANCH 2>/dev/null | wc -l | tr -d ' ')
      echo "origin/$BRANCH ma $BEHIND_BRANCH commitów do merge do main"
    fi
  fi
done
```

**Jeśli `BEHIND=0` i brak zmian na innych branchach:**
→ Nie trzeba merge'ować. Przejdź do Kroku 5 (podsumowanie).

**Jeśli `BEHIND > 0` lub inny branch ma zmiany:**
→ Wyświetl listę nowych commitów
→ Przejdź do Kroku 4 (Shadow Clone Merge)

---

## Krok 4 — Shadow Clone Merge

Merge odbywa się w tymczasowym klonie w `/tmp/`, bo bezpośredni merge na FUSE jest zablokowany.

### 4.1 — Przygotowanie shadow clone

```bash
# Wyczyść poprzedni shadow clone
rm -rf /tmp/piona-sync 2>/dev/null || true

cd "$PROJECT_DIR"
REMOTE_URL=$(git remote get-url origin)
USER_NAME=$(git config user.name)
USER_EMAIL=$(git config user.email)

# Klonuj z GitHub do /tmp (pełny git, brak FUSE)
git clone "$REMOTE_URL" /tmp/piona-sync 2>&1

cd /tmp/piona-sync
git config user.name "$USER_NAME"
git config user.email "$USER_EMAIL"
git fetch origin 2>&1
```

### 4.2 — Merge do main

```bash
cd /tmp/piona-sync
git checkout main
git pull origin main 2>&1

# Merguj aktualny branch do main
echo "--- Mergowanie $CURRENT_BRANCH do main ---"
git merge "origin/$CURRENT_BRANCH" --no-edit 2>&1
MERGE_EXIT=$?
echo "EXIT: $MERGE_EXIT"
```

Jeśli inny branch też ma zmiany:
```bash
# Merguj drugi branch do main (np. wika jeśli jesteś oskar)
git merge "origin/$OTHER_BRANCH" --no-edit 2>&1
```

**Jeśli merge przeszedł czysto (exit code 0):**
→ Przejdź do 4.4 (push i sync)

**Jeśli merge ma konflikty (exit code 1):**
→ Przejdź do 4.3

### 4.3 — Rozwiązywanie konfliktów (AI-Assisted)

Pobierz listę plików z konfliktem:
```bash
cd /tmp/piona-sync
CONFLICT_FILES=$(git diff --name-only --diff-filter=U)
echo "$CONFLICT_FILES"
```

Dla KAŻDEGO pliku z konfliktem, zastosuj procedurę według typu:

#### Markdown (*.md) — AI Synthesis

1. Wyciągnij trzy wersje:
```bash
git show :1:$FILE > /tmp/conflict_base.md     # wspólny przodek
git show :2:$FILE > /tmp/conflict_ours.md      # wersja main (ours)
git show :3:$FILE > /tmp/conflict_theirs.md    # wersja brancha (theirs)
```

2. Przeczytaj wszystkie trzy wersje (Read tool).

3. **AI analizuje kontekst obu zmian:**
   - Co zmienił aktualny branch i dlaczego?
   - Co zmienił drugi branch/main i dlaczego?
   - Czy zmiany są komplementarne (oba dodają coś) czy sprzeczne?

4. **AI proponuje zsyntezowaną wersję** i POKAZUJE ją użytkownikowi:
   - Wyświetl: „Plik X ma konflikt. Oto co zmieniły obie strony: [opis]. Proponuję taką wersję: [treść]. Zatwierdzasz?"
   - **Czekaj na zatwierdzenie użytkownika.**

5. Po zatwierdzeniu — zapisz rozwiązanie:
```bash
# Zapisz zsyntezowaną treść (Write tool do /tmp/piona-sync/$FILE)
cd /tmp/piona-sync && git add "$FILE"
```

#### Kod (*.js, *.html, *.css, *.py, *.sh) — BLOKUJ I PYTAJ

1. Wyciągnij obie wersje:
```bash
git show :2:$FILE > /tmp/conflict_ours_code
git show :3:$FILE > /tmp/conflict_theirs_code
```

2. Wyświetl obie wersje z diff i zapytaj użytkownika:
   - Którą wersję wybrać? (ours / theirs)
   - Czy AI ma zaproponować merge?
3. **Nie rozwiązuj automatycznie.** Czekaj na decyzję użytkownika.

#### Config (*.yaml, *.json, *.toml, .cursorrules, .gitignore) — TRY UNION

```bash
cd /tmp/piona-sync
git merge --abort
git checkout main
git merge "origin/$CURRENT_BRANCH" -Xunion --no-edit 2>&1
```

Jeśli union przejdzie — sprawdź składnię. Jeśli nie — traktuj jak konflikt kodu.

#### Binary (*.png, *.jpg, *.pdf) — ODRZUĆ

Poinformuj: „Plik binarny nie powinien być w git. Przenieś na Google Drive."
Abort merge, wyczyść shadow clone, zakończ sync z błędem.

### 4.3.1 — Finalizacja po rozwiązaniu konfliktów

```bash
cd /tmp/piona-sync
git commit -m "merge: resolved conflicts $(date '+%Y-%m-%d %H:%M')" 2>&1
```

### 4.4 — Push main + sync brancha

```bash
cd /tmp/piona-sync

# Push merged main na GitHub
git push origin main 2>&1

# Zaktualizuj swój branch z main (żeby miał najnowsze zmiany)
git checkout "$CURRENT_BRANCH"
git merge main --no-edit 2>&1
git push origin "$CURRENT_BRANCH" 2>&1
```

### 4.5 — Aktualizacja lokalnego folderu (cp-based, FUSE-safe)

```bash
cd /tmp/piona-sync
git checkout "$CURRENT_BRANCH"

# Porównaj z tym co jest lokalnie — skopiuj różnice
CHANGED=$(git diff --name-only HEAD "$PROJECT_DIR" 2>/dev/null || git diff --stat HEAD)

# Kopiuj WSZYSTKIE tracked pliki ze shadow clone (bezpieczne — nadpisuje FUSE)
git ls-files | while read f; do
  if [ -f "$f" ]; then
    mkdir -p "$PROJECT_DIR/$(dirname "$f")" 2>/dev/null
    cp "$f" "$PROJECT_DIR/$f" 2>/dev/null
  fi
done
echo "Pliki robocze skopiowane"

# Kopiuj git objects i refs żeby historia merge była widoczna
cp -r .git/objects/* "$PROJECT_DIR/.git/objects/" 2>/dev/null
cp -r .git/refs/* "$PROJECT_DIR/.git/refs/" 2>/dev/null
cp .git/packed-refs "$PROJECT_DIR/.git/packed-refs" 2>/dev/null

# Zaktualizuj HEAD ref
MERGE_COMMIT=$(git rev-parse HEAD)
echo "$MERGE_COMMIT" > "$PROJECT_DIR/.git/refs/heads/$CURRENT_BRANCH"
echo "Git refs zaktualizowane → $MERGE_COMMIT"
```

### 4.6 — Weryfikacja

```bash
cd "$PROJECT_DIR"
echo "--- Log ---"
git log --oneline -5
echo "--- Status ---"
git status --porcelain
```

Jeśli są niespodziewane unstaged changes:
```bash
cd "$PROJECT_DIR" && git add -A && git commit -m "sync: post-merge cleanup" --quiet 2>&1
```

### 4.7 — Cleanup

```bash
rm -rf /tmp/piona-sync
echo "Shadow clone wyczyszczony"
```

**ZAWSZE wykonaj cleanup**, nawet jeśli merge failuje.

---

## Krok 5 — Podsumowanie

Wyświetl ZAWSZE na końcu:

```
✅ SYNC ZAKOŃCZONY — [data i godzina]
   Branch:          [nazwa brancha]
   Lokalne zmiany:  [X plików / brak]
   Push branch:     [✓ / ⚠ błąd]
   Merge do main:   [✓ bez konfliktów / 🔀 rozwiązano X konfliktów / ⏭ nie wymagany]
   Push main:       [✓ GitHub / ⏭ nie wymagany]
   Sync lokalny:    [X plików zaktualizowanych / brak zmian]
   Konflikty:       [lista plików rozwiązanych / brak]
```

---

## Zasady

1. **Nigdy nie wykonuj `git merge` ani `git pull` bezpośrednio na zamontowanym folderze** — zawsze przez shadow clone w `/tmp/`.
2. **Nigdy nie pytaj o opis commita** — generuj automatycznie.
3. **Nigdy nie rób `git push --force`** — to kasuje historię innych osób.
4. **Lock files** — usuwaj przez `mv plik plik.dead`, nie `rm`.
5. **Konflikty markdown** — AI syntezuje i proponuje rozwiązanie, czeka na zatwierdzenie użytkownika.
6. **Konflikty kodu** — BLOKUJ, pokaż obie wersje, zapytaj użytkownika.
7. **Konflikty binarne** — nie powinno ich być w git. Poinformuj o Google Drive.
8. **Komunikuj się po polsku.**
9. **Jeśli którykolwiek krok się nie powiedzie** — opisz błąd, NIE kontynuuj do następnego.
10. **Po shadow clone ZAWSZE rób cleanup** (`rm -rf /tmp/piona-sync`), nawet jeśli merge failuje.

---

## Wersja

| Wersja | Data | Zmiana |
|--------|------|--------|
| 4.0 | 2026-03-27 | Shadow Clone z GitHub (nie lokalu) + AI-Assisted Conflict Resolution |
| 3.0 | 2026-03-27 | Shadow Clone z lokalu, merge branches oskar/wika → main |
| 2.0 | 2026-03-26 | Commit + push only, merge przez SYNC.command na Macu |
