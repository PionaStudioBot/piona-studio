# INSTRUKCJA: Reorganizacja Folderów — ~/Desktop/AI/PIONA Studio

## Cel
Zsynchronizować strukturę folderów na Mac Studio (Oskar) i MacBooku (Wiktoria):
```
~/Desktop/AI/
└── PIONA Studio/     ← Git repo (synchronizowany)
```

---

## CZĘŚĆ 1: MAC STUDIO (OSKAR)

### Krok 1: Utwórz folder AI na Pulpicie

Otwórz **Finder** → przejdź na **Pulpit** → kliknij prawy przycisk → **New Folder** → nazwij `AI`

Lub w Terminalu:
```
mkdir -p ~/Desktop/AI
```

### Krok 2: Przenieś folder PIONA Studio

Otwórz Terminal i wpisz:
```
mv ~/Desktop/PIONA\ Studio ~/Desktop/AI/PIONA\ Studio
```

To przeniesie folder z Pulpitu do folderu `AI`.

### Krok 3: Sprawdź czy wszystko działa

```
cd ~/Desktop/AI/PIONA\ Studio
git status
```

Powinno pokazać: `On branch main` i `nothing to commit, working tree clean`

### Krok 4: Sprawdź czy skrypty znajdują się

```
ls 08_Skrypty_i_Narzedzia/scripts/SYNC.command
```

Powinno pokazać ścieżkę do pliku (bez błędu).

**Gotowe na Mac Studio!** Skrypty będą działać z nowej lokalizacji (szukają `.cursorrules` automatycznie).

---

## CZĘŚĆ 2: MACBOOK (WIKTORIA)

### Krok 1: Utwórz folder AI na Pulpicie

Otwórz **Finder** → przejdź na **Pulpit** → kliknij prawy przycisk → **New Folder** → nazwij `AI`

Lub w Terminalu:
```
mkdir -p ~/Desktop/AI
```

### Krok 2: Usuń stary folder PIONA Studio

```
rm -rf ~/Desktop/PIONA\ Studio
```

### Krok 3: Sklonuj repo do nowej lokalizacji

```
cd ~/Desktop/AI
git clone https://github.com/PionaStudioBot/piona-studio.git "PIONA Studio"
```

### Krok 4: Sprawdź czy wszystko działa

```
cd ~/Desktop/AI/PIONA\ Studio
git status
```

Powinno pokazać: `On branch main` i `nothing to commit, working tree clean`

### Krok 5: Sprawdź czy skrypty są dostępne

```
ls 08_Skrypty_i_Narzedzia/scripts/SYNC.command
```

**Gotowe na MacBooku!**

---

## Po reorganizacji — TEST SYNCHRONIZACJI

1. **Oskar:** Tworzy plik testowy
   ```
   cd ~/Desktop/AI/PIONA\ Studio
   echo "Test Oskara" > test_oskar.txt
   ./08_Skrypty_i_Narzedzia/scripts/SYNC.command
   ```
   Opisz: "Test synchronizacji"

2. **Wiktoria:** Pobiera zmiany
   ```
   cd ~/Desktop/AI/PIONA\ Studio
   ./08_Skrypty_i_Narzedzia/scripts/SYNC.command
   ```
   Powinna zobaczyć plik `test_oskar.txt`

3. **Wiktoria:** Dodaje swój plik
   ```
   echo "Test Wiktorii" > test_wiktoria.txt
   ./08_Skrypty_i_Narzedzia/scripts/SYNC.command
   ```
   Opisz: "Test synchronizacji"

4. **Oskar:** Pobiera zmiany
   ```
   cd ~/Desktop/AI/PIONA\ Studio
   ./08_Skrypty_i_Narzedzia/scripts/SYNC.command
   ```
   Powinien zobaczyć plik `test_wiktoria.txt`

**Jeśli oboje widzą sobie pliki — system działa!** Usuńcie pliki testowe.

---

## Notatki
- Folder `AI/` na Pulpicie — lokalnie, nie synchronizowany
- Wewnątrz `AI/` folder `PIONA Studio/` — w pełni synchronizowany przez Git
- Wiktoria może tworzyć inne projekty w `~/Desktop/AI/` bez wpływu na PIONA Studio
- Skrypty `.command` działają z nowej lokalizacji (szukają `.cursorrules` automatycznie)
