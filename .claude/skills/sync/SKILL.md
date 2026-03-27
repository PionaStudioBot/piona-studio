---
name: sync
description: |
  Synchronizuje projekt PIONA Studio z GitHub — pobiera zmiany z GitHub, commituje lokalne zmiany i pushuje na GitHub. Uruchom ten skill gdy użytkownik wpisze /sync, "synchronizuj", "sync projekt", "wyślij zmiany", "pobierz zmiany zespołu", "zaktualizuj git", "zapisz i wyślij zmiany" lub "sprawdź zmiany". Skill działa w 4 krokach: sprawdź lokalne zmiany → pobierz zmiany z GitHub → zapisz (commit z auto-opisem) → wyślij (push). Zawsze używaj tego skilla dla wszelkich operacji Git w projekcie PIONA Studio.
---

# Sync — PIONA Studio Git Synchronizacja

## Kontekst środowiska

Ten skill działa w Cowork VM (środowisko Claude na Linuxie). VM widzi folder PIONA Studio przez warstwę `bindfs`. Niektóre operacje git mogą zwrócić warning o `.lock` — to nieszkodliwy artefakt bindfs, ignoruj go i kontynuuj.

**Pełny sync działa z poziomu Cowork:** commit lokalnych zmian + pobieranie zmian z GitHub + push. ✅

---

## Lokalizacja projektu

\`\`\`bash
find /sessions -name ".cursorrules" -maxdepth 6 2>/dev/null | head -1 | xargs dirname
\`\`\`

Użyj znalezionej ścieżki jako \`PROJECT_DIR\`. Standardowo: \`/sessions/.../mnt/PIONA-AI\`.

---

## Krok 1 — Sprawdź lokalne zmiany

\`\`\`bash
cd "<PROJECT_DIR>" && git status --porcelain
\`\`\`

Zlicz i wylistuj zmienione pliki według kategorii: nowe (\`??\`), zmodyfikowane (\`M\`), usunięte (\`D\`). Jeśli brak zmian — powiedz krótko i przejdź dalej.

---

## Krok 2 — Pobierz zmiany z GitHub

\`\`\`bash
cd "<PROJECT_DIR>" && git fetch origin main --quiet 2>&1
LOCAL=\$(git rev-parse HEAD); REMOTE=\$(git rev-parse origin/main 2>/dev/null || echo "")
[ "\$LOCAL" != "\$REMOTE" ] && echo "SĄ NOWE ZMIANY" || echo "BRAK NOWYCH ZMIAN"
\`\`\`

**Jeśli są nowe zmiany na GitHub:**

Wyświetl listę nowych commitów:
\`\`\`bash
cd "<PROJECT_DIR>" && git log --oneline HEAD..origin/main
\`\`\`

Następnie pobierz je przez reset:
\`\`\`bash
cd "<PROJECT_DIR>" && git reset --hard origin/main 2>&1
\`\`\`

Warning o \`.lock\` — ignoruj, to artefakt bindfs. Operacja się powiedzie.

**Jeśli brak nowych zmian:** powiedz krótko i przejdź do Kroku 3.

---

## Krok 3 — Zapisz lokalne zmiany (commit)

\`\`\`bash
cd "<PROJECT_DIR>" && git status --porcelain
\`\`\`

**Jeśli są zmiany do zapisania:**

Wygeneruj opis commita automatycznie — na podstawie listy zmienionych plików i kontekstu bieżącej sesji pracy. Format:

\`\`\`
[Auto] Aktualizacja DD.MM HH:MM — X nowych, Y zmienionych: plik1, plik2, plik3
\`\`\`

Zasady generowania opisu:
- Max 5 najważniejszych plików (tylko nazwa, bez pełnej ścieżki)
- Jeśli zmiany dotyczą jednego obszaru tematycznego (np. tylko \`wiedza/\`) — wspomnij o tym
- Jeśli w bieżącej sesji były konkretne zadania (np. pisanie strategii, edycja brandbooka, aktualizacja SEO) — użyj tej wiedzy by opis był znaczący, a nie tylko lista plików

\`\`\`bash
cd "<PROJECT_DIR>" && git add -A && git commit -m "<WIADOMOŚĆ>" --quiet 2>&1
\`\`\`

**Jeśli brak zmian:** poinformuj krótko.

---

## Krok 4 — Wyślij na GitHub (push)

\`\`\`bash
cd "<PROJECT_DIR>" && git push origin main --quiet 2>&1
\`\`\`

**Jeśli push się nie uda:**
- Brak internetu → poinformuj że zmiany są zapisane lokalnie, push przy następnej sesji
- Błąd uprawnień → poinformuj że należy sprawdzić token GitHub w konfiguracji
- Rejected (non-fast-forward) → zrób fetch + reset --hard origin/main, potem push ponownie

---

## Podsumowanie

Wyświetl zawsze na końcu:

\`\`\`
✅ SYNC ZAKOŃCZONY — [data i godzina]
   Lokalne zmiany:  [X plików / brak]
   GitHub (nowe):   [✓ pobrano X commitów / ✓ brak]
   Zapisano:        [nazwa commita / brak zmian]
   Wysłano:         [✓ GitHub / ⚠ tylko lokalnie]
\`\`\`

---

## Zasady

- **Używaj \`git reset --hard origin/main\`** do pobierania zmian z GitHub — działa w Cowork VM bez błędów uprawnień.
- **Kolejność gdy są JEDNOCZEŚNIE lokalne zmiany I zmiany na GitHub:** najpierw commit lokalnych zmian → potem reset --hard origin/main → potem push. UWAGA: reset --hard nadpisze lokalny stan — dlatego commit MUSI być przed reset.
- **Nigdy nie pytaj użytkownika o opis commita** — generuj automatycznie z listy zmienionych plików i kontekstu sesji.
- Jeśli \`git\` nie jest zainstalowany lub brak \`.git\` w folderze — poinformuj i zakończ.
- Komunikuj się wyłącznie po polsku.
- Jeśli któryś krok się nie powiedzie — opisz błąd i nie kontynuuj do następnego.
