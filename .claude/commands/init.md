---
description: Inicjalizacja systemu - weryfikacja struktury i aktualizacja CLAUDE.md
---

# /init — Inicjalizacja i synchronizacja systemu

## ZADANIE

Komenda /init wykonuje pełną weryfikację i synchronizację dokumentacji PIONA Studio:

1. **Skanuj strukturę plików** — znajdź wszystkie .md w projekcie.
2. **AKTUALIZUJ CLAUDE.md** — synchronizuj mapę plików.
3. **Sprawdź Backup** — czy proces `backup_monitor.sh` działa.
4. **Raportuj status** — pokaż co jest OK, co wymaga uwagi.

## AKTUALIZACJA CLAUDE.md

Przy każdym uruchomieniu /init:
- Przeskanuj foldery: `/00_Strategia_2026/`, `/01_Procesy_Wewnetrzne/`, `/02_Ofertowanie/`, `/03_Rozwoj_i_Trendy/`, `/Dane_Firmy/`.
- Zaktualizuj opis jeśli plik jest nowy.
- Weryfikuj obecność Spisu Treści i Executive Summary.

## ZASADY

- Po dużych zmianach zawsze uruchom `/init`.
- Synchronizuj MIRROR po zmianach w `.claude/`.
