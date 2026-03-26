---
name: sync
description: |
  Synchronizuje projekt PIONA Studio z GitHub — wykonuje Protokół Sesji Cowork (weryfikacja edycji + merge jeśli konflikt) i pushuje na GitHub. Uruchom ten skill gdy użytkownik wpisze /sync, "synchronizuj", "sync projekt", "wyślij zmiany", "zaktualizuj git", "zapisz i wyślij zmiany". Skill działa w 5 krokach: usuń lock files → snapshot → weryfikacja edycji → merge jeśli konflikt → push na GitHub. Zawsze używaj tego skilla dla wszelkich operacji Git w projekcie PIONA Studio.
---

# Sync — PIONA Studio Git Synchronizacja

## Kontekst środowiska (ważne)

Ten skill działa w Cowork VM (środowisko Claude na Linuxie). VM widzi folder PIONA Studio przez warstwę `bindfs` (zamontowany dysk z macOS), która blokuje niektóre operacje na plikach.

**Znane ograniczenia FUSE/bindfs:**
- `rm` na plikach `.git/` zwraca EPERM — używaj `mv lock lock.bak`
- `git checkout HEAD -- plik` zwraca EPERM — używaj `git show HEAD:"ścieżka" > /tmp/restored.md && cp /tmp/restored.md "ścieżka"`
- `git merge` i `git pull` są niedostępne z poziomu Cowork — merge robi Claude ręcznie przez three-way synthesis
- Warningi `unable to unlink tmp_obj` przy każdym commit — kosmetyczne, nie blokują commitów

**Podział odpowiedzialności:**
- **Cowork (ten skill):** snapshot + weryfikacja edycji + merge + push na GitHub ✅
- **Fizyczny komputer:** Google Drive synchronizuje pliki automatycznie między urządzeniami ✅

---

## Lokalizacja projektu

```bash
find /sessions -name ".cursorrules" -maxdepth 6 2>/dev/null | head -1 | xargs dirname
```

Użyj znalezionej ścieżki jako `PROJECT_DIR`. Standardowo: `/sessions/.../mnt/PIONA Studio`.

---

## Krok 1 — Usuń stare lock files

```bash
ls "<PROJECT_DIR>/.git/HEAD.lock" "<PROJECT_DIR>/.git/index.lock" 2>/dev/null
```

Jeśli któryś z plików istnieje — Google Drive zsynchronizował go z drugiego komputera. Usuń przez `mv`:

```bash
mv "<PROJECT_DIR>/.git/HEAD.lock" "<PROJECT_DIR>/.git/HEAD.lock.bak" 2>/dev/null || true
mv "<PROJECT_DIR>/.git/index.lock" "<PROJECT_DIR>/.git/index.lock.bak" 2>/dev/null || true
```

**Jeśli `mv` też zwraca błąd (index.lock):** poinformuj użytkownika:
> ⚠ Nie mogę usunąć `index.lock` z poziomu Cowork. Otwórz Finder → naciśnij Cmd+Shift+. (ukryte pliki) → przejdź do PIONA Studio/.git → przesuń `index.lock` do Kosza → powiedz mi „gotowe".

Czekaj na odpowiedź użytkownika przed kontynuacją.

---

## Krok 2 — Git snapshot (commit lokalnych zmian)

```bash
cd "<PROJECT_DIR>" && git status --porcelain
```

Zlicz zmienione pliki. Następnie wykonaj commit:

```bash
cd "<PROJECT_DIR>" && git add -A && git commit -m "snapshot-end: macstudio $(date '+%Y-%m-%d %H:%M') /sync" 2>&1
```

Jeśli commit się nie powiódł z powodu HEAD.lock — wróć do Kroku 1. Jeśli brak zmian — poinformuj krótko i przejdź dalej.

---

## Krok 3 — Weryfikacja edycji (detekcja konfliktu)

> Ten krok wykonuj **tylko jeśli** w bieżącej sesji Claude edytował jakiekolwiek pliki. Jeśli `/sync` wywołano po sesji bez edycji plików — pomiń Krok 3 i 4.

Dla każdego pliku edytowanego w bieżącej sesji:

1. Przeczytaj plik z dysku (Read tool)
2. Porównaj z tym co pamiętasz że zapisałeś
3. Jeśli treść się **zgadza** → brak konfliktu, przejdź do kolejnego pliku
4. Jeśli treść się **różni** → wykryty konflikt → przejdź do Kroku 4

Jeśli żaden plik nie ma konfliktu — poinformuj: „Brak konfliktów — wszystkie edycje zachowane."

---

## Krok 4 — Merge (tylko przy wykrytym konflikcie)

Wykonaj three-way merge dla każdego pliku z konfliktem.

**Pobierz wersję bazową z ostatniego snapshota:**
```bash
git show HEAD~1:"ścieżka/do/pliku" > /tmp/restored_base.md 2>/dev/null || git show HEAD:"ścieżka/do/pliku" > /tmp/restored_base.md
cat /tmp/restored_base.md
```

Masz teraz 3 wersje:
- **Baza** — stan z git snapshota (sprzed sesji)
- **Twoja** — co pamiętasz że zapisałeś (pamięć sesji)
- **Dysk** — aktualny stan pliku (wersja Drive, z drugiego komputera)

**Zasady merge:**
- Zrozum intencję każdej zmiany (co każda strona chciała osiągnąć)
- Stwórz syntezę łączącą wartość z obu wersji — NIE wybieraj jednej
- Zapisz zmergowaną wersję na dysk

**Poinformuj użytkownika:**
> 🔀 Wykryłem równoległą edycję `[nazwa pliku]`. [Co zmieniła wersja Drive] + [co zmieniłem ja]. Połączyłem obie zmiany — sprawdź czy wynik jest poprawny.

Po merge — wróć do Kroku 2 i zrób kolejny snapshot z mergem.

---

## Krok 5 — Push na GitHub

Sprawdź czy są nowe commity na GitHub:

```bash
cd "<PROJECT_DIR>" && git fetch origin main --quiet 2>&1
LOCAL=$(git rev-parse main); REMOTE=$(git rev-parse origin/main 2>/dev/null || echo "")
[ "$LOCAL" != "$REMOTE" ] && echo "SĄ NOWE ZMIANY NA GITHUB" || echo "BRAK NOWYCH ZMIAN"
```

Jeśli są nowe zmiany — wylistuj je i poinformuj:
```bash
cd "<PROJECT_DIR>" && git log --oneline main..origin/main
```
> ⚠ Na GitHub są nowe zmiany (lista powyżej). Claude nie może ich pobrać z poziomu Cowork — są dostępne przez Google Drive automatycznie.

Następnie push:
```bash
cd "<PROJECT_DIR>" && git push origin main --quiet 2>&1
```

**Jeśli push się nie uda:**
- Brak internetu → poinformuj że snapshot jest zapisany lokalnie, push przy następnej sesji
- Błąd uprawnień → poinformuj że należy sprawdzić token GitHub w konfiguracji

---

## Podsumowanie

Wyświetl zawsze na końcu:

```
✅ SYNC ZAKOŃCZONY — [data i godzina]
   Lock files:      [usunięte / brak]
   Snapshot:        [X plików / brak zmian]
   Konflikty:       [brak / zmergowano: plik1, plik2]
   GitHub (nowe):   [⚠ są / ✓ brak]
   Push:            [✓ GitHub / ⚠ tylko lokalnie]
```

---

## Zasady

- **Nigdy nie wykonuj `git merge` ani `git pull`** — w Cowork VM to zawsze zwróci błąd uprawnień.
- **Nigdy nie używaj `rm` na plikach `.git/`** — używaj `mv lock lock.bak`.
- **Nigdy nie używaj `git checkout HEAD -- plik`** — używaj `git show HEAD:"ścieżka" > /tmp/restored.md && cp /tmp/restored.md "ścieżka"`.
- **Nigdy nie pytaj użytkownika o opis commita** — generuj automatycznie.
- Komunikuj się wyłącznie po polsku.
- Jeśli któryś krok się nie powiedzie — opisz błąd i nie kontynuuj do następnego.
