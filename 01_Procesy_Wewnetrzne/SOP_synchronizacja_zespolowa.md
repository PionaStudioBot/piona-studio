# SOP: Synchronizacja Zespołowa PIONA Studio

## O co chodzi?
System pozwala Oskarowi (Mac Studio) i Wiktorii (MacBook) pracować jednocześnie na tym samym folderze PIONA Studio. Zmiany jednej osoby automatycznie trafiają do drugiej — bez nadpisywania, bez duplikatów.

## Architektura
- **Git + GitHub** = synchronizacja plików tekstowych (markdown, skrypty, konfiguracja)
- **Google Drive Shared Drive** = synchronizacja assetów binarnych (logotypy, fonty, video, PSD)
- **Backup ZIP + Google Drive** = warstwa bezpieczeństwa (bez zmian vs. obecny system)

## Codzienny workflow

### Zaczynam pracę (rano)
1. Otwórz Terminal
2. Wpisz: `./08_Skrypty_i_Narzedzia/scripts/POBIERZ_ZMIANY.command`
   - LUB kliknij dwukrotnie plik `POBIERZ_ZMIANY.command` w Finderze
3. Gotowe — masz najnowszą wersję ze zmianami całego zespołu

### Kończę pracę (wieczór / koniec etapu)
1. Otwórz Terminal
2. Wpisz: `./08_Skrypty_i_Narzedzia/scripts/WYSLIJ_ZMIANY.command`
   - LUB kliknij dwukrotnie plik `WYSLIJ_ZMIANY.command` w Finderze
3. Wpisz krótki opis co zrobiłeś/aś (np. "Dodałam SOP onboardingu klienta")
4. Gotowe — twoja praca jest na GitHubie, dostępna dla reszty zespołu

### Chcę zobaczyć historię zmian
1. Uruchom `HISTORIA.command`
2. Wybierz co chcesz zobaczyć:
   - Ostatnie 20 zmian
   - Zmiany z ostatniego tygodnia
   - Historię konkretnego pliku
   - Zmiany konkretnej osoby
   - Aktualny status (co jest zmienione)

## Co jeśli pojawi się konflikt?
Konflikt = oboje edytowaliście tę samą linijkę tego samego pliku. Przy 2-osobowym zespole to rzadkość.

Gdy się zdarzy, skrypt pokaże komunikat i wskaże pliki w konflikcie. W pliku zobaczysz:
```
<<<<<<< TWOJA WERSJA
(to co ty napisałeś/aś)
=======
(to co napisała druga osoba)
>>>>>>> WERSJA ZESPOŁU
```

Rozwiązanie: otwórz plik, wybierz właściwą wersję (albo połącz obie), usuń znaczniki `<<<<<<<`, `=======`, `>>>>>>>`, zapisz plik, uruchom `WYSLIJ_ZMIANY`.

## Jednorazowa konfiguracja (tylko raz na każdym komputerze)

### Krok 1: Zainstaluj Git (jeśli nie masz)
macOS ma Git wbudowany. Sprawdź: otwórz Terminal, wpisz `git --version`. Jeśli nie ma, zainstaluj Xcode Command Line Tools: `xcode-select --install`.

### Krok 2: Skonfiguruj swoją tożsamość
```bash
git config --global user.name "Twoje Imię"
git config --global user.email "twoj@email.com"
```
Przykład dla Oskara:
```bash
git config --global user.name "Oskar"
git config --global user.email "kontakt.piona@gmail.com"
```
Przykład dla Wiktorii:
```bash
git config --global user.name "Wiktoria"
git config --global user.email "wiktoria@email.com"
```

### Krok 3: Połącz z GitHub (tylko Mac Studio — raz)
```bash
cd "/ścieżka/do/PIONA Studio"
git remote add origin https://github.com/NAZWA-KONTA/piona-studio.git
git push -u origin main
```

### Krok 4: Sklonuj repo (MacBook Wiktorii — raz)
```bash
cd ~/Desktop
git clone https://github.com/NAZWA-KONTA/piona-studio.git "PIONA Studio"
```
Po sklonowaniu Wiktoria ma identyczny folder. Od teraz używa `POBIERZ_ZMIANY` i `WYSLIJ_ZMIANY`.

### Krok 5: GitHub authentication
Przy pierwszym push/pull GitHub poprosi o login. Najprościej:
1. Zainstaluj GitHub CLI: `brew install gh`
2. Zaloguj się: `gh auth login` (wybierz HTTPS, przeglądarkę)
3. Gotowe — nie będzie więcej pytał o hasło

## Co Git śledzi, a co nie

### Śledzone przez Git (synchronizowane między komputerami):
- Wszystkie pliki `.md` (strategie, SOP, baza wiedzy, sesje)
- Pliki `.py`, `.sh`, `.command` (skrypty)
- Pliki `.html`, `.css`, `.js` (strona WWW)
- `.cursorrules`, `SESSION.md`, `CLAUDE.md`

### NIE śledzone przez Git (sync przez Google Drive lub backup ZIP):
- Obrazy (jpg, png, gif, svg)
- Video (mp4, mov)
- Pliki projektowe (psd, ai, sketch)
- Fonty (woff, woff2, ttf)
- Modele 3D (glb, gltf)
- ZIPy, PDFy
- Folder `10_Archiwum/`
- Folder `Backup/`
- Brand Assets

## Lokalizacja skryptów
```
08_Skrypty_i_Narzedzia/scripts/
├── WYSLIJ_ZMIANY.command    ← zapisz + wyślij swoją pracę
├── POBIERZ_ZMIANY.command   ← pobierz pracę zespołu
├── HISTORIA.command          ← historia zmian
├── piona_backup.py           ← backup ZIP (bez zmian)
└── backup_*.sh               ← pomocnicze skrypty backup
```

## FAQ

**P: Czy mogę pracować offline?**
O: Tak. `WYSLIJ_ZMIANY` zapisuje lokalnie nawet bez internetu. Gdy połączysz się z internetem, uruchom skrypt ponownie — wyśle zaległe zmiany.

**P: Co jeśli przypadkowo usunę plik?**
O: Git pamięta wszystko. W historii (`HISTORIA`) znajdziesz każdą wersję każdego pliku. Odzyskanie: `git checkout HEAD~1 -- ścieżka/do/pliku.md`

**P: Czy muszę coś robić z Google Drive?**
O: Nie dla plików tekstowych — Git to obsługuje. Google Drive for Desktop synchronizuje automatycznie folder Brand Assets i inne assety binarne.

**P: Jak często powinienem wysyłać zmiany?**
O: Minimum raz dziennie na koniec pracy. Idealnie — po każdym większym bloku pracy (np. po napisaniu SOPa, po sesji z AI).

---
*Wersja: 1.0 | Data: 2026-03-25 | Autor: Oskar + Claude*
