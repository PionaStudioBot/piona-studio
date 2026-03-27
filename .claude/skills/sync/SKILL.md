---
name: sync
description: |
  Synchronizuje projekt PIONA-AI z GitHub używając modelu Git Branches (oskar/wika/main).
  Uruchom gdy użytkownik wpisze /sync, "synchronizuj", "sync projekt", "wyślij zmiany", "zapisz i wyślij zmiany".
  Skill działa w 3 fazach: commit+push na branch → merge w /tmp (shadow clone) → aktualizacja lokalna przez cp.
  Zawsze używaj tego skilla dla wszelkich operacji Git w projekcie PIONA Studio.
---

# Sync v3 — PIONA Studio Git Branches

## Kontekst środowiska

Cowork VM montuje folder użytkownika przez `bindfs` (FUSE). Ograniczenia:
- `git merge`, `git checkout` → FAIL na mounted folderze (unlink EPERM)
- `git commit`, `git push`, `git fetch` → DZIAŁAJĄ
- `cp` (nadpisywanie pliku) → DZIAŁA
- Lock files (HEAD.lock, index.lock) → nie da się usunąć przez `rm`, używaj `mv plik plik.dead`

**Rozwiązanie:** merge odbywa się w `/tmp/piona-sync/` (lokalne VM, brak FUSE), wyniki wracają przez `cp`.

---

## Krok 0 — Znajdź folder projektu i aktualny branch

```bash
PROJECT_DIR=$(find /sessions -name ".cursorrules" -maxdepth 6 2>/dev/null | head -1 | xargs dirname)
echo "PROJECT_DIR: $PROJECT_DIR"
cd "$PROJECT_DIR"
MY_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
echo "BRANCH: $MY_BRANCH"
```

Jeśli `MY_BRANCH` to `main` — poinformuj: "Jesteś na branchu main. Upewnij się, że pracujesz na swoim branchu (oskar lub wika). Czy mam przełączyć?" i czekaj na odpowiedź.

---

## Krok 1 — Wyczyść lock files

```bash
cd "$PROJECT_DIR"
find .git -name "*.lock" 2>/dev/null | while read f; do mv "$f" "${f}.dead" 2>/dev/null || true; done
echo "Lock files wyczyszczone"
```

Jeśli `mv` zwraca błąd (packed-refs.lock, refs/heads/*.lock) — poinformuj:
> ⚠ Nie mogę wyczyścić lock file `[nazwa]` z poziomu Cowork. Otwórz Finder → Cmd+Shift+. (ukryte pliki) → przejdź do Desktop/AI/PIONA-AI/.git → przesuń plik do Kosza → powiedz "gotowe".

Czekaj na odpowiedź użytkownika przed kontynuacją.

---

## Krok 2 — Commit i push na swój branch (FUSE mount)

```bash
cd "$PROJECT_DIR"
git status --porcelain
```

Jeśli są zmiany — zrób commit:

```bash
cd "$PROJECT_DIR"
COMMIT_MSG="sync: $(git diff --cached --name-only 2>/dev/null | head -3 | tr '\n' ', ' | sed 's/,$//')$(git diff --name-only 2>/dev/null | head -3 | tr '\n' ', ' | sed 's/,$//')"
[ -z "${COMMIT_MSG//sync: /}" ] && COMMIT_MSG="sync: session update"
git add -A
git commit -m "$COMMIT_MSG $(date '+%Y-%m-%d %H:%M')" 2>&1
```

Wyczyść lock files po commit:
```bash
find .git -name "*.lock" 2>/dev/null | while read f; do mv "$f" "${f}.dead" 2>/dev/null || true; done
```

Push na swój branch:
```bash
cd "$PROJECT_DIR"
git push origin "$MY_BRANCH" 2>&1
```

Jeśli push się nie powiódł z powodu braku upstream:
```bash
git push -u origin "$MY_BRANCH" 2>&1
```

---

## Krok 3 — Merge w /tmp (shadow clone)

```bash
# Wyczyść poprzedni shadow clone jeśli istnieje
rm -rf /tmp/piona-sync 2>/dev/null || true

# Klonuj z GitHub do /tmp — pełny git, brak FUSE
REMOTE_URL=$(cd "$PROJECT_DIR" && git remote get-url origin)
git clone "$REMOTE_URL" /tmp/piona-sync 2>&1
cd /tmp/piona-sync

# Skonfiguruj user
git config user.name "$(cd "$PROJECT_DIR" && git config user.name)"
git config user.email "$(cd "$PROJECT_DIR" && git config user.email)"

# Pobierz wszystkie branche
git fetch origin 2>&1

# Przejdź na main i pobierz najnowszy stan
git checkout main
git pull origin main 2>&1

# Zmerguj mój branch do main
echo "--- Mergowanie $MY_BRANCH do main ---"
git merge "origin/$MY_BRANCH" --no-edit 2>&1
MERGE_EXIT=$?
```

**Jeśli `MERGE_EXIT != 0` (konflikt):**
```bash
git diff --name-only --diff-filter=U
```

Dla każdego pliku z konfliktem:
1. Odczytaj zawartość pliku z `/tmp/piona-sync/<plik>` (zawiera markery konfliktu `<<<<<<<`)
2. Odczytaj wersję bazową: `git show HEAD:"<plik>"`
3. Wykonaj three-way merge (synteza, nie wybór)
4. Zapisz zmergowaną wersję
5. `git add <plik>`

Po rozwiązaniu konfliktów:
```bash
cd /tmp/piona-sync
git commit -m "merge: resolved conflicts $(date '+%Y-%m-%d %H:%M')" 2>&1
```

Poinformuj:
> 🔀 Rozwiązałem konflikt w `[nazwa pliku]`. [Opis co połączyłem]. Sprawdź czy wynik jest poprawny.

**Po udanym merge — push main:**
```bash
cd /tmp/piona-sync
git push origin main 2>&1
```

**Zaktualizuj swój branch (pobierz zmiany drugiej osoby):**
```bash
cd /tmp/piona-sync
git checkout "$MY_BRANCH"
git merge main --no-edit 2>&1
git push origin "$MY_BRANCH" 2>&1
```

---

## Krok 4 — Aktualizacja lokalnego folderu (cp-based, FUSE-safe)

```bash
cd /tmp/piona-sync

# Znajdź pliki które różnią się między lokalnym a origin/MY_BRANCH
CHANGED_FILES=$(git diff --name-only "origin/$MY_BRANCH" HEAD 2>/dev/null)

if [ -z "$CHANGED_FILES" ]; then
  echo "Brak nowych plików do zaktualizowania lokalnie"
else
  echo "$CHANGED_FILES" | while read f; do
    if [ -f "$f" ]; then
      # Upewnij się że katalog docelowy istnieje
      mkdir -p "$PROJECT_DIR/$(dirname "$f")" 2>/dev/null
      cp "$f" "$PROJECT_DIR/$f" 2>/dev/null && echo "Zaktualizowano: $f"
    fi
  done
fi
```

Zaktualizuj lokalny ref:
```bash
cd "$PROJECT_DIR"
find .git -name "*.lock" 2>/dev/null | while read f; do mv "$f" "${f}.dead" 2>/dev/null || true; done
git fetch origin "$MY_BRANCH" --quiet 2>&1
git update-ref "refs/heads/$MY_BRANCH" "origin/$MY_BRANCH" 2>/dev/null || true
```

Wyczyść shadow clone:
```bash
rm -rf /tmp/piona-sync
```

---

## Krok 5 — Podsumowanie

Wyświetl zawsze na końcu:

```
✅ SYNC ZAKOŃCZONY — [data i godzina]
   Branch:          [oskar / wika]
   Commit:          [X plików / brak zmian]
   Push branch:     [✓ / ⚠ błąd]
   Merge do main:   [✓ bez konfliktów / 🔀 rozwiązano konflikty w: plik1, plik2]
   Push main:       [✓ GitHub / ⚠ tylko lokalnie]
   Aktualizacja:    [X plików zaktualizowanych lokalnie / brak zmian]
```

---

## Zasady

- **Nigdy** nie wykonuj `git merge` ani `git pull` bezpośrednio na mounted folderze — zawsze przez `/tmp/piona-sync/`
- **Nigdy** nie używaj `rm` na plikach `.git/` — używaj `mv plik plik.dead`
- **Zawsze** czyść `/tmp/piona-sync/` na końcu i na początku skilla
- **Nigdy** nie pytaj użytkownika o opis commita — generuj automatycznie
- Komunikuj się wyłącznie po polsku
- Jeśli któryś krok się nie powiedzie — opisz błąd i nie kontynuuj do następnego
