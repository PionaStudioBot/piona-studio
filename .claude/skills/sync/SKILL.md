---
name: sync
description: |
  Synchronizuje projekt PIONA Studio z GitHub — pobiera zmiany zespołu, commituje lokalne zmiany z auto-wygenerowaną wiadomością i pushuje na GitHub. Uruchom ten skill gdy użytkownik wpisze /sync, "synchronizuj", "sync projekt", "wyślij zmiany", "pobierz zmiany zespołu", "zaktualizuj git", lub "zapisz i wyślij zmiany". Skill działa w 4 krokach: sprawdź lokalne zmiany → pobierz zmiany z GitHub → zapisz (commit) → wyślij (push). Zawsze używaj tego skilla dla wszelkich operacji Git sync w projekcie PIONA Studio.
---

# Sync — PIONA Studio Git Synchronizacja

Twoim zadaniem jest zsynchronizować folder projektu PIONA Studio z repozytorium GitHub. Wykonaj poniższe kroki **jeden po drugim**, raportując wynik każdego z nich.

## Lokalizacja projektu

Projekt PIONA Studio znajduje się w katalogu zawierającym plik `.cursorrules`. Standardowa ścieżka to katalog zamontowany w sesji Cowork (workspace folder). Znajdź go przez:

```bash
find /sessions -name ".cursorrules" -maxdepth 6 2>/dev/null | head -1 | xargs dirname
```

Jeśli nie znajdziesz, użyj ścieżki workspace z sesji.

## Krok 1 — Sprawdź lokalne zmiany

```bash
cd <PROJECT_DIR> && git status --porcelain
```

Podsumuj wynik: ile plików nowych, zmodyfikowanych, usuniętych. Jeśli brak zmian — powiedz to krótko i przejdź dalej.

## Krok 2 — Pobierz zmiany zespołu z GitHub

```bash
cd <PROJECT_DIR> && git fetch origin $(git branch --show-current) --quiet 2>&1
```

Następnie sprawdź czy są nowe commity:
```bash
LOCAL=$(git rev-parse HEAD); REMOTE=$(git rev-parse origin/$(git branch --show-current) 2>/dev/null || echo ""); [ "$LOCAL" != "$REMOTE" ] && echo "SĄ NOWE ZMIANY" || echo "BRAK NOWYCH ZMIAN"
```

Jeśli są nowe zmiany — wykonaj merge:
```bash
cd <PROJECT_DIR> && git merge origin/$(git branch --show-current) --no-edit --quiet 2>&1
```

Jeśli pojawi się **konflikt** — wypisz nazwy plików w konflikcie i zatrzymaj się. Poinformuj użytkownika że musi rozwiązać konflikty ręcznie, a potem uruchomić /sync ponownie.

## Krok 3 — Zapisz lokalne zmiany (commit)

Sprawdź ponownie czy są jakieś niezapisane zmiany (po merge mogły powstać nowe lub odwrotnie):

```bash
cd <PROJECT_DIR> && git status --porcelain
```

Jeśli **są zmiany do zapisania**:

1. Wygeneruj automatyczną wiadomość commita na podstawie listy zmienionych plików. Format:
   - Policz ile plików z każdej kategorii (nowe, zmodyfikowane, usunięte)
   - Wylistuj max 5 najbardziej znaczących nazw plików (bez ścieżki)
   - Sformatuj jako: `[Auto] Aktualizacja DD.MM HH:MM — X nowych, Y zmienionych: plik1, plik2, ...`

2. Dodaj wszystkie pliki i zapisz commit:
```bash
cd <PROJECT_DIR> && git add -A && git commit -m "<WIADOMOŚĆ>" --quiet 2>&1
```

Jeśli **brak zmian** — poinformuj że nie ma nic do zapisania.

## Krok 4 — Wyślij na GitHub (push)

```bash
cd <PROJECT_DIR> && git push origin $(git branch --show-current) --quiet 2>&1
```

Jeśli push się nie uda (brak internetu, brak uprawnień) — poinformuj użytkownika że zmiany są zapisane **lokalnie**, ale nie zostały wysłane do GitHub.

## Podsumowanie

Na końcu wyświetl zwięzłe podsumowanie w formacie:

```
✅ SYNC ZAKOŃCZONY — [data i godzina]
   Pobrano:  [zmiany zespołu / brak nowych]
   Zapisano: [nazwa commita / brak zmian]
   Wysłano:  [✓ GitHub / ⚠ tylko lokalnie]
```

## Zasady

- Jeśli `git` nie jest zainstalowany lub folder nie jest repozytorium Git — poinformuj o tym wprost i zakończ.
- Nie pytaj użytkownika o opis commita — generuj go automatycznie.
- Jeśli któryś krok się nie powiedzie, nie kontynuuj do następnego — opisz błąd i zatrzymaj się.
- Cały czas komunikuj się po polsku.
