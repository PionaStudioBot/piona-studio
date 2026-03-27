---
name: Architektura Synchronizacji PIONA Studio
description: Model Git Branches — jak działa synchronizacja, branche, /sync v3, reguły pracy Oskara i Wiktorii.
---

# ARCHITEKTURA SYNCHRONIZACJI v3 (Git Branches)

## Model

```
OSKAR (Mac Studio):                 WIKTORIA (MacBook):
~/Desktop/AI/PIONA-AI/              ~/Desktop/AI/PIONA-AI/
└── branch: oskar                   └── branch: wika
          ↕ git push/pull ↕
    GitHub: PionaStudioBot/piona-studio
    ├── main    ← merged, canonical
    ├── oskar   ← Oskar's working branch
    └── wika    ← Wiktoria's working branch
```

**Pliki tekstowe** (markdown, HTML, CSS, JS, Python) → git repo (`~/Desktop/AI/PIONA-AI/`)
**Pliki binarne** (logotypy, oferty, portfolio, fonty) → Google Drive (`Mój dysk/PIONA Assets/`)

## Warstwy bezpieczeństwa

1. **Lokalne commity** — git snapshot na starcie i końcu każdej sesji Cowork (automatyczny)
2. **Branch isolation** — każda osoba pracuje na swoim branchu, brak ryzyka nadpisania
3. **Merge świadomy** — `/sync` łączy zmiany przez git merge, nie last-write-wins
4. **GitHub backup** — `/sync` pushuje merged main na GitHub

## Protokół Sesji Cowork (OBOWIĄZKOWY)

**START sesji:**
1. Usuń lock files: `find .git -name "*.lock" | while read f; do mv "$f" "${f}.dead" 2>/dev/null; done`
2. Sprawdź aktualny branch: `git rev-parse --abbrev-ref HEAD`
3. Kontynuuj pracę

**KONIEC sesji / na żądanie `/sync`:**
→ Skill `/sync` v3 obsługuje automatycznie (patrz `.claude/skills/sync/SKILL.md`)

## Znane ograniczenia FUSE/bindfs (Cowork VM)

Cowork VM montuje folder przez bindfs. Ograniczenia:
- `unlink` na plikach `.git/` → EPERM → używaj `mv lock lock.dead`
- `git merge` / `git checkout` → FAIL bezpośrednio na mounted folder
- `cp` (nadpisywanie pliku) → DZIAŁA
- `git commit`, `git push`, `git fetch` → DZIAŁAJĄ

**Dlatego `/sync` używa shadow clone w `/tmp/`** — merge odbywa się tam, wyniki wracają przez `cp`.

## Assety binarne — Google Drive

Pliki binarne (logotypy, fonty, zdjęcia, PDF oferty, portfolio, wideo) **nie trafiają do git** — są w `.gitignore`. Żyją na współdzielonym Google Drive:

| Typ assetów | Ścieżka Google Drive |
|-------------|----------------------|
| Logotypy, fonty, identyfikacja wizualna | `Mój dysk/PIONA Assets/brand/` |
| Oferty PDF/PNG | `Mój dysk/PIONA Assets/oferty/` |
| Portfolio, case studies | `Mój dysk/PIONA Assets/portfolio/` |
| Materiały www (zdjęcia, video) | `Mój dysk/PIONA Assets/www/` |

Folder `PIONA Assets/` musi być **udostępniony Wiktorii** przez Google Drive (Shared Drive lub „Udostępnij z osobą").
Obie osoby mają ten sam folder zsynchronizowany lokalnie przez Google Drive dla macOS.

## Setup Wiktorii (jednorazowy)

Skrypt: `narzedzia/scripts/setup_wika.command`

Kroki dla Oskara (robi jeden raz na MacBooku Wiktorii):
1. Skopiuj plik `setup_wika.command` na pulpit MacBooka Wiktorii
2. Kliknij prawym → „Otwórz" (pierwsze uruchomienie wymaga obejścia Gatekeepera)
3. Poczekaj aż terminal wyświetli `✅ GOTOWE!`
4. Otwórz aplikację Cowork → zmień folder workspace na `Desktop/AI/PIONA-AI`
5. Gotowe — Wiktoria od teraz używa tylko `/sync` w Cowork

## Reguły stałe

- `.git` jest lokalny (NIE na Google Drive) — brak problemów z Drive renaming, lock sync
- `inbox/` jest w `.gitignore` — każda osoba ma swój lokalny inbox
- Assety binarne (logotypy, pdf, zdjęcia) → Google Drive `PIONA Assets/`, NIE w git
- Nigdy nie używaj `git merge` / `git pull` bezpośrednio na mounted folderze
- Nigdy nie używaj `rm` na plikach `.git/` — używaj `mv plik plik.dead`
