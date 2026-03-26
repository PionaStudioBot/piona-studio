# PROTOKÓŁ ORGANIZACJI PLIKÓW PIONA STUDIO
Ten plik definiuje Złote Zasady ułożenia folderów, aby praca z AI oraz praca ludzka była uporządkowana, logiczna i sprawna.

**Reguła #1: CZYSTOŚĆ GŁÓWNEGO KATALOGU**
Główny folder `/AI/PIONA Studio/` powinien pozostawać maksymalnie przejrzysty. 
Tworzenie w nim nowych folderów lub plików nie jest absolutnie zakazane, ale musi mieć bardzo silne uzasadnienie (np. dodanie zupełnie nowego, kluczowego obszaru agencji). W innym wypadku, w pierwszej kolejności próbuj dopasować nowe pliki i foldery zleceń do istniejącej struktury numerycznej od `01_` do `10_`. 

**Reguła #2: SYSTEM NUMERYCZNY (PARA + JOHNNY.DECIMAL)**
Zanim utworzysz nowy element, dopasuj go do poniższych kategorii:
- `01_Projekty_Aktywne` do `07_Projekty_Aktywne`: Aktualnie rozwijane projekty (kodowanie, nowe oferty w toku, prototypy WWW).
- `08_Skrypty_i_Narzedzia`: Wszystkie samodzielne skrypty np. automatyzacje w Pythonie i narzędzia pomocnicze.
- `09_Notatki_i_Brudnopisy`: Surowe dane, tymczasowe notatki, wyeksportowane logi, brudnopisy, luźne myśli. To bezpieczne miejsce na "śmieci", które mogą się kiedyś przydać.
- `10_Archiwum`: Zimny magazyn projektów. Cmentarzysko starych plików.

**Reguła #3: ŚWIĘTOŚĆ BAZY WIEDZY**
Folder `05_Baza_Wiedzy` to "Złota Klatka". Znajdują się w nim TYLKO zdyestylowane, zweryfikowane i wyciągnięte do esencji zasady. 
ZAKAZ dodawania do `05_Baza_Wiedzy` tymczasowych notatek, surowych wyników badań czy fragmentów logów (te idą do `09_ Notatki_i_Brudnopisy`). Rozszerzanie `05_Baza_Wiedzy` wymaga prośby od Oskara lub użycia komendy `/feedback` w celu stałego zapisania reguły.

**Reguła #4: ARCHIWIZUJ, NIE USUWAJ**
Dbamy o wiedzę historyczną. Zamiast bezpowrotnie usuwać starsze iteracje projektów czy paczek (np. WWW V1, V2), po prostu wynoś przestarzałe foldery do `10_Archiwum/`.