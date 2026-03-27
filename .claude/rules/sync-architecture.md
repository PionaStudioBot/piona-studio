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
**Pliki binarne** (logotypy, oferty, portfolio, fonty) → Google Drive (`PIONA Studio/`)

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
→ Skill `/sync` v4 obsługuje automatycznie (patrz `.claude/skills/sync/SKILL.md`)
→ `/sync` robi PEŁNĄ synchronizację z Cowork: commit → push branch → shadow clone merge do main → push main → sync lokalny
→ NIE wymaga uruchamiania SYNC.command ani terminala na Macu

## Znane ograniczenia FUSE/bindfs (Cowork VM)

Cowork VM montuje folder przez bindfs. Ograniczenia:
- `unlink` na plikach `.git/` → EPERM → używaj `mv lock lock.dead`
- `git merge` / `git checkout` → FAIL bezpośrednio na mounted folder
- `cp` (nadpisywanie pliku) → DZIAŁA
- `git commit`, `git push`, `git fetch` → DZIAŁAJĄ

**Dlatego `/sync` v4 używa shadow clone w `/tmp/`** — klonuje repo z GitHub do `/tmp/piona-sync/`, tam wykonuje merge (pełny git, brak ograniczeń FUSE), potem kopiuje wyniki z powrotem przez `cp` i aktualizuje git refs.

**Flow:** commit lokalne → push branch → clone z GitHub do /tmp → merge w /tmp → push main z /tmp → cp plików z /tmp na FUSE → cleanup /tmp

## Assety binarne — Google Drive

Pliki binarne (logotypy, fonty, zdjęcia, PDF oferty, portfolio, wideo) **nie trafiają do git** — są w `.gitignore`. Żyją na współdzielonym Google Drive:

| Typ assetów | Ścieżka Google Drive |
|-------------|----------------------|
| Logotypy, fonty, identyfikacja wizualna | `PIONA Studio/brand/` |
| Oferty PDF/PNG | `PIONA Studio/oferty/` |
| Portfolio, case studies | `PIONA Studio/portfolio/` |
| Materiały www (zdjęcia, video) | `PIONA Studio/www/` |

Folder `PIONA Studio/` — istniejący współdzielony folder Google Drive. Oskar i Wiktoria mają już dostęp.
Oskar i Wiktoria mają już dostęp — folder synchronizuje się lokalnie przez Google Drive dla macOS na obu komputerach.

## Setup Wiktorii (jednorazowy)

Skrypt: `narzedzia/scripts/setup_wika.command`

Kroki dla Oskara (robi jeden raz na MacBooku Wiktorii):
1. Skopiuj plik `setup_wika.command` na pulpit MacBooka Wiktorii
2. Kliknij prawym → „Otwórz" (pierwsze uruchomienie wymaga obejścia Gatekeepera)
3. Poczekaj aż terminal wyświetli `✅ GOTOWE!`
4. Otwórz aplikację Cowork → zmień folder workspace na `Desktop/AI/PIONA-AI`
5. Gotowe — Wiktoria od teraz używa `/sync` w Cowork (pełna synchronizacja, bez potrzeby terminala)

## Reguły stałe

- `.git` jest lokalny (NIE na Google Drive) — brak problemów z Drive renaming, lock sync
- `inbox/` jest w `.gitignore` — każda osoba ma swój lokalny inbox
- Assety binarne (logotypy, pdf, zdjęcia) → Google Drive `PIONA Assets/`, NIE w git
- Nigdy nie używaj `git merge` / `git pull` bezpośrednio na mounted folderze
- Nigdy nie używaj `rm` na plikach `.git/` — używaj `mv plik plik.dead`
