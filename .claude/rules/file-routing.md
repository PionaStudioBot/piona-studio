---
name: File Routing Table — PIONA-AI
description: Gdzie trafia każdy nowy plik. AI musi sprawdzić tę tabelę przed stworzeniem lub przeniesieniem pliku.
---

# FILE ROUTING TABLE

> **ZASADA NADRZĘDNA:** Tekst/kod → git repo (`~/Desktop/AI/PIONA-AI/`). Binaria → Google Drive (`PIONA Studio/`).

## Routing per typ treści

| Typ treści | Folder docelowy | Przykłady |
|------------|-----------------|-----------|
| Tożsamość firmy, brandbook, brand voice | `context/` | o_nas.md, brandbook.md |
| Wiedza referencyjna (teoria, frameworki) | `wiedza/<klaster>/` | brand_strategy_identity/, pricing_business_models/ |
| Plany, cele, strategie działania | `planning/` | strategia_2026.md, plan_bloga.md |
| SOPy, procedury, szablony ofert | `procesy/` | system_pozyskiwania_klienta.md, ofertowanie.md |
| Kod, spec, treści strony — projekt aktywny | `projekty/<nazwa>/` | www-v9/index.html, www-v9/spec/ |
| Skrypty operacyjne (backup, sync, narzędzia) | `narzedzia/scripts/` | piona_backup.py, sync.sh |
| Pliki binarne GOTOWE (logotypy, fonty) | Google Drive: `PIONA Studio/brand/` | logo-główne.png, font.woff2 |
| Pliki binarne GOTOWE (oferty PDF/PNG) | Google Drive: `PIONA Studio/oferty/` | oferta_24it.png |
| Pliki binarne GOTOWE (portfolio) | Google Drive: `PIONA Studio/portfolio/` | portfolio_2025.png |
| Niesortowane, do obróbki, tymczasowe | `inbox/` (.gitignore) | zdjecia z telefonu, surowe notatki |
| Stare wersje projektów, archiwalne pliki | `archiwum/` | www-v1-v8/, stare_skrypty/ |
| **Dane klienta** (brief, strategia, notatki, plany kampanii, analizy, spec, kod) | `klienci/<nazwa>/` | klienci/funfit/KLIENT.md, klienci/funfit/strategia/ |
| **Projekty klienta** (www, landing page, kampania) | `klienci/<nazwa>/projekty/<projekt>/` | klienci/funfit/projekty/www-landing-q2/ |
| **Binaria klienta** (logo, zdjęcia, video, PSD, PDF) | Google Drive: `PIONA Studio/klienci/<nazwa>/` | klienci/funfit/assety-klienta/, deliverables/ |

## Zasady szczegółowe

**`context/`** — max 5 plików. To jest tożsamość firmy, nie biblioteka. Jeśli coś jest "teorią o brandingu" → idzie do `wiedza/brand_strategy_identity/`, nie do `context/`.

**`wiedza/`** — tylko zdystylowana, zweryfikowana wiedza. Surowe notatki → `inbox/`. Nowy klaster wymaga zgody Oskara.

**`planning/`** — plany i strategie *działania*. Jeśli to procedura krok-po-kroku → `procesy/`. Jeśli to teoria → `wiedza/`.

**`projekty/`** — jeden subfolder per projekt (`www-v9/`, `klient-xyz/`). Spec i treści RAZEM z kodem — nie rozdzielaj.

**`inbox/`** — jest w `.gitignore`. Nie sync'uje się między branchami. Tymczasowy bufor, czyść regularnie.

**`klienci/`** — jeden subfolder per klient (`funfit/`, `24it-solutions/`). Nazwy: lowercase, kebab-case, bez polskich znaków. Każdy klient ma identyczną strukturę podfolderów (brief/, strategia/, projekty/, analizy/, komunikacja/) i plik `KLIENT.md` jako jedyne źródło prawdy. Projekty klientów trafiają do `klienci/<nazwa>/projekty/`, NIE do top-level `projekty/`. Nowy klient = skopiuj `_szablon/`. Binaria klienta → Google Drive `PIONA Studio/klienci/<nazwa>/`.

**NIGDY** nie twórz plików bezpośrednio w root (`~/Desktop/AI/PIONA-AI/`). Dopuszczalne pliki w root: `CLAUDE.md`, `SESSION.md`, `STATUS_UPDATES.md`, `MASTERPLAN.md`, `.cursorrules`, `.gitignore`, `.gitattributes`.
