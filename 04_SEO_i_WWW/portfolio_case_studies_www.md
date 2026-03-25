# Podstrona Portfolio / Case Studies — PIONA Studio
**URL**: `/portfolio`
**Rola w lejku**: Consideration → Intent (social proof domykający decyzję)
**Powiązane**: `brand_visual_identity.md` (sekcja 11), `wytyczne_ux_i_konwersji_www.md` (sekcja 5), `podstrony_uslug_www.md`

> **📋 CEL STRATEGICZNY**
> Klient na etapie Consideration pyta: *„Czy oni naprawdę potrafią to, co mówią?"*
> Portfolio odpowiada DOWODAMI — nie galerią zdjęć, a historiami z mierzalnymi wynikami.
> **Inspiracja wizualna**: The AWWWARDS, Mbridge Case Studies (wynik w tytule), Oferta 2026 PIONA (grid 3-kolumnowy, view count overlay)

---

## ZASADA NADRZĘDNA

Portfolio PIONY to **nie galeria ładnych obrazków**. To zbiór mini-historii biznesowych:

> **Problem → Co zrobiliśmy → Jaki efekt osiągnęliśmy**

Każdy case study musi odpowiadać na pytanie klienta: *„A co to da MOJEJ firmie?"*

---

## 🏗 STRUKTURA SEKCJI (Wireframe & Copy)

---

### SEKCJA 1: HERO — PORTFOLIO
**Wizualnie**: Duży, pełnoekranowy kafelek z najlepszej realizacji (np. SKINOW) jako hero image. Na nim overlay z H1. Minimalistycznie, premiumowo.

- **Pill-label**: `PORTFOLIO`
- **H1 (Roc Grotesk Wide, Bold)**: DOBRA MARKA TO NIE PRZYPADEK. TO PROCES.
- **Sub-headline**: Zobacz projekty, które zrealizowaliśmy dla firm z charakterem. Od strategii, przez design, aż po mierzalne efekty.

---

### SEKCJA 2: FILTRY KATEGORII
**Wizualnie**: Poziomy pasek pill-labeli do filtrowania (jak tagi na blogu). Klient klika kategorię i widzi tylko odpowiednie projekty.

**Filtry:**
| Pill-label | Filtruje po |
|-----------|------------|
| `WSZYSTKO` | Domyślny — pokazuje wszystkie projekty |
| `BRANDING` | Identyfikacja wizualna, logo, strategia marki |
| `SOCIAL MEDIA` | Prowadzenie profili, Reelsy, kampanie |
| `VIDEO` | Filmy reklamowe, spoty, Reelsy |
| `WWW` | Strony internetowe, e-commerce |
| `SEO` | Pozycjonowanie, audyty |

**Dlaczego to ważne pod SEO**: Każdy filtr generuje unikalne URL-e (`/portfolio?kategoria=branding`) co pozwala na indeksowanie osobnych stron przez Google.

---

### SEKCJA 3: GRID PROJEKTÓW — KAFELKI
**Wizualnie**: Asymetryczny grid kafelków (inspiracja AWWWARDS). Duże zdjęcia-okładki — jak cover posty na Instagramie PIONY. Na hover: animacja + nazwa projektu + krótki opis + kategoria w pill-labelu.

**Układ grida**: 
- Trzy kolumny na desktopie (jak w Ofercie 2026)
- Dwie kolumny na tablecie
- Jedna kolumna na mobile
- Wyróżnione projekty = podwójna szerokość kafelka (span 2 kolumny)

**Zawartość kafelka (widok z grida, przed kliknięciem):**
```
┌──────────────────────────────┐
│                              │
│   [Duże zdjęcie/mockup]      │
│                              │
│   ┌─────────┐                │
│   │BRANDING │ ← pill-label   │
│   └─────────┘                │
│   ŁAGÓW LUBUSKI             │
│   Tożsamość regionu         │
│                              │
└──────────────────────────────┘
```

---

### SEKCJA 4: STRUKTURA POJEDYNCZEGO CASE STUDY (Po kliknięciu w kafelek)

Każdy case study otwiera się jako osobna podstrona (`/portfolio/lagow-lubuski`). Szablon identyczny dla każdego projektu:

---

#### A) HERO CASE STUDY
- **Pill-label**: `[KATEGORIA]` np. `BRANDING`
- **H1**: Nazwa projektu — Łagów Lubuski
- **Sub-headline (jednolinijkowy wynik)**: *„Od miasta bez rozpoznawalnej marki do spójnego systemu wizualnego, który przyciąga turystów."*
- **Wizualnie**: Pełnoekranowe zdjęcie / mockup kluczowy (np. logo na tle zamku Joannitów)

#### B) WYZWANIE — O CO CHODZIŁO?
- **H2**: Wyzwanie
- **Treść**: Krótki opis sytuacji klienta PRZED współpracą. Konkretny problem biznesowy, nie „chciał nowe logo".
- **Format**: 2-3 zdania, bold na kluczowym problemie.

#### C) ROZWIĄZANIE — CO ZROBILIŚMY?
- **H2**: Co zrobiliśmy
- **Treść**: Lista deliverables w pill-labelach + opis podejścia strategicznego.
- **Wizualnie**: Mockupy, zdjęcia wdrożeń, Key Visuale. Grid 2-3 kolumnowy z wizualizacjami.

#### D) PROCES — JAK TO WYGLĄDAŁO?
- **H2**: Proces
- **Treść**: Krótki opis przejścia przez etapy (Kawa na ławę → Strategia → Kreacja → Egzekucja).
- **Opcjonalnie**: Mini-timeline z czasem realizacji.

#### E) EFEKT — CO SIĘ ZMIENIŁO?
- **H2**: Efekt
- **Treść**: Mierzalne wyniki (jeśli dostępne) LUB opis jakościowej zmiany.
- **Wizualnie**: Metryki w dużych liczbach (overlay na zdjęciu), np:
  - `3.5M` wyświetleń Reelsów
  - `+120%` wzrost zaangażowania
  - `#1` pozycja w Google na frazę X
- **Jeśli brak liczbowych danych**: Opis transformacji wizualnej (before → after) lub cytat klienta.

#### F) OPINIA KLIENTA
- **Wizualnie**: Cytat w ramce z zaokrąglonymi rogami (brand color `#B4F95A` border).
- **Format**: Logo firmy + zdjęcie osoby + imię i nazwisko + stanowisko + cytat opisujący EFEKT (nie „fajnie się współpracowało").

#### G) CTA — TWÓJ PROJEKT MOŻE BYĆ NASTĘPNY
- **H3**: Chcesz podobnych efektów?
- **CTA**: Umów bezpłatną konsultację → [Formularz / Calendly]
- **Link do powiązanej usługi**: np. „Zobacz naszą ofertę brandingową →"

---

## KONKRETNE CASE STUDIES PIONA — PROJEKT KART

### 📂 CASE 1: ŁAGÓW LUBUSKI
| Pole | Treść |
|------|-------|
| **Kategoria** | Branding |
| **Klient** | Łagów Lubuski (miasto/region) |
| **Wyzwanie** | Miasto z potencjałem turystycznym, ale bez rozpoznawalnej marki. Brak spójnego systemu wizualnego — każda impreza wyglądała inaczej, każdy plakat miał inne logo. |
| **Co zrobiliśmy** | Logo łączące Wieżę Joannitów z falą jeziora. Paleta: żółty (#FFCB39), niebieski (#7EDBE8), zielony (#ABE271). System ikonografii turystycznej. Wdrożenia: leżaki eventowe, standy, materiały promocyjne. |
| **Efekt** | Spójny system wizualny dla całego regionu. Rozpoznawalność turystyczna. [metryki do uzupełnienia] |
| **Pill-labele** | `LOGO` `IDENTYFIKACJA` `SYSTEM WIZUALNY` `WDROŻENIA` |

### 📂 CASE 2: SPOKO TRAVEL
| Pole | Treść |
|------|-------|
| **Kategoria** | Branding + Social Media |
| **Klient** | Spoko Travel (agencja turystyczna) |
| **Wyzwanie** | Debiutująca agencja turystyczna bez tożsamości wizualnej. Chcieli wyróżnić się na rynku zdominowanym przez „poważne" biura podróży. |
| **Co zrobiliśmy** | Logo: litera "S" z samolotem. Paleta: pomarańcz (#EF6020), granat (#003285). Strategiczny content edukacyjny (posty o zasadach ETA w UK z wyliczonymi kosztami). |
| **Efekt** | Branding oparty na „bliskości i przyjazności". Content, który nie tylko promuje, ale edukuje klientów. |
| **Pill-labele** | `LOGO` `BRANDING` `CONTENT STRATEGY` |

### 📂 CASE 3: MUUU BISTRO
| Pole | Treść |
|------|-------|
| **Kategoria** | Branding |
| **Klient** | MUUU Bistro (gastronomia) |
| **Wyzwanie** | Bistro z unikalnym atutem — mleko z własnego gospodarstwa — ale wizualnie nieodróżnialne od innych kawiarni. |
| **Co zrobiliśmy** | Logo: stylizowana sylwetka krowy. Paleta: granat (#152C46), niebieski (#B0CCEB), piaskowy (#EACE9B). Ręcznie rysowane elementy, nawiązania do ceramiki Bolesławiec. Edukacja wokół hodowli jako element contentu. |
| **Efekt** | Marka, która OPOWIADA HISTORIĘ — od krowy do filiżanki. Spójność od menu po Instagram. |
| **Pill-labele** | `LOGO` `IDENTYFIKACJA` `KEY VISUAL` `MENU DESIGN` |

### 📂 CASE 4: NOWCAMP
| Pole | Treść |
|------|-------|
| **Kategoria** | Branding + Social Media |
| **Klient** | Nowcamp (wynajem kamperów) |
| **Wyzwanie** | Nowy biznes w niszy „van life" bez żadnej tożsamości. Potrzebna marka, która mówi „przygoda" zanim przeczytasz choćby jedno słowo. |
| **Co zrobiliśmy** | Logo: litera "n" ewoluująca w symbol leśnej drogi. Paleta: ciemna zieleń (#031E12), szałwiowa (#62B28E), miętowa biel (#EEFFF6). Posty „specs" (dane kamperów) + lifestylowy content podróżniczy. |
| **Efekt** | Budowanie zaangażowanej społeczności od zera. Content, który łączy dane techniczne z emocją podróży. |
| **Pill-labele** | `LOGO` `BRANDING` `SOCIAL MEDIA` `CONTENT` |

### 📂 CASE 5: SKINOW (Flagowy projekt 360°)
| Pole | Treść |
|------|-------|
| **Kategoria** | Branding + E-commerce + Social Media + Video |
| **Klient** | SKINOW (marka premium skincare, założyciel: Oskar Wejkuć) |
| **Wyzwanie** | Marka urodziła się z osobistej potrzeby założyciela — lata zmagań ze skórą, poczucie chaosu na twarzy i w głowie. Filozofia: „SKINOW to uporządkowanie chaosu, na twarzy i w głowie." Potrzeba: pełna tożsamość wizualna, sklep internetowy i obecność w social media od zera. |
| **Co zrobiliśmy** | **Branding**: Strategia → pozycjonowanie → identyfikacja wizualna → key visual → kampania launch. **Sklep**: Kompletny e-commerce skinow.pl (WooCommerce) — produkty premium (krem „Architekt Skóry" 359 zł, serum „Strażnik Równowagi" 319 zł, zestaw 629 zł), ścieżka zakupowa, sekcja „Wiedza", strona „O Marce". **Social Media**: Prowadzenie @skinow.lab na Instagramie. **Video**: Produkcja reklam video (rolki produktowe). Wizualność sklepu: minimalistyczna, laboratoryjno-premium, paleta ciemnej zieleni (#002B21) + off-white. |
| **Efekt** | Flagowy projekt PIONA Studio — pełna usługa 360° od strategii po działający e-commerce i aktywne social media. Dowód na to, że PIONA buduje marki, a nie tylko logotypy. |
| **Pill-labele** | `STRATEGIA` `LOGO` `KEY VISUAL` `E-COMMERCE` `SOCIAL MEDIA` `VIDEO` |

### 📂 CASE 6: FUNFIT II (Stała współpraca 2+ lata)
| Pole | Treść |
|------|-------|
| **Kategoria** | Social Media + Video + Produkt Cyfrowy + Meta Ads |
| **Klient** | FunFit II (klub fitness, Zielona Góra) |
| **Czas współpracy** | 2+ lata — najdłuższa stała współpraca PIONA Studio |
| **Wyzwanie** | Klub fitness potrzebował partnera, który kompleksowo zajmie się ich obecnością online — od contentu organicznego, przez płatne reklamy, po produkt cyfrowy zwiększający retencję nowych członków. |
| **Co zrobiliśmy** | **Content organiczny**: Prowadzenie profilu Instagram — strategia, grafiki, Reelsy, community management. **Meta Ads**: Kampanie reklamowe (płatne reklamy video skierowane do potencjalnych klientów). **Produkcja video**: Reklamy wideo (produkcja od scenariusza po postprodukcję). **Produkt cyfrowy**: „Kurs dla początkujących" — 20 modułów wideo + artykułów dla nowych klubowiczów (tematy: pierwsze treningi, regeneracja, plan treningowy, żywienie, systematyczność, progresja, przełamanie stagnacji). Kurs zmienia myślenie nowego członka i redukuje churn. Nagroda: voucher 30 zł na fitbar za ukończenie. Misja FunFit: „Aktywizowanie lokalnej społeczności do spędzania czasu w sposób aktywny." |
| **Efekt** | 2+ lata nieprzerwana współpraca. Kurs cyfrowy zwiększający retencję klubowiczów. Reklamy video napędzające nowych klientów. Dowód na model współpracy abonamentowej / stałego partnerstwa. |
| **Pill-labele** | `SOCIAL MEDIA` `META ADS` `VIDEO` `PRODUKT CYFROWY` `STAŁA WSPÓŁPRACA` |

### 📂 CASE 7: DYCHA / ISAMU — Teledyski muzyczne (~14.4 MLN wyświetleń)
| Pole | Treść |
|------|-------|
| **Kategoria** | Produkcja Filmowa (teledyski muzyczne) |
| **Klient** | Dycha (artysta), kanał IsAmU na YouTube |
| **Wyzwanie** | Artysta potrzebował profesjonalnych teledysków, które nie tylko będą wizualnie wyróżniające, ale staną się narzędziem promocji muzyki — generując miliony wyświetleń na YouTube i przekładając się na odsłuchy na Spotify. |
| **Co zrobiliśmy** | Produkcja i postprodukcja 5 teledysków muzycznych. Oskar Makarski / PIONA Studio wymienieni w opisach na YouTube. Wszystkie prod. CrackHouse. |
| **Teledyski** | **1.** „DYCHA & MAJSZI - MIŁOŚĆ ZA PIENIĄDZE" — **9.5 mln views** · **2.** „DYCHA - ONA DA" — **2.7 mln views** · **3.** „DYCHA - CELA TECHNO" — **1.4 mln views** · **4.** „DYCHA - KING KONG" — **479 tys. views** · **5.** „DYCHA - NAJARANA MAŁOLATA" — **338 tys. views** |
| **Efekt** | Łącznie **~14.4 mln wyświetleń** na YouTube. Teledyski stały się motorem promocji muzyki — przekładając się bezpośrednio na miliony odsłuchów na Spotify. |
| **Pill-labele** | `TELEDYSK` `YOUTUBE` `MONTAŻ` `POSTPRODUKCJA` `14M+ VIEWS` |
| **Wyróżnienie** | Projekt z największą łączną liczbą wyświetleń w portfolio PIONA Studio. |

### 📂 CASE 8: MGP GARAGE / D4TAILER / ISAMU — Filmy YouTube (~2.8 MLN wyświetleń)
| Pole | Treść |
|------|-------|
| **Kategoria** | Produkcja Filmowa (YouTube content) |
| **Klient** | MGP Garage, D4tailer, Isamu/Dycha |
| **Czas współpracy** | 3 lata (stała współpraca MGP GARAGE) |
| **Wyzwanie** | Twórcy YouTube (m.in. potężny kanał motoryzacyjny MGP GARAGE) potrzebowali profesjonalnej produkcji filmów na swoje kanały — od preprodukcji, przez realizację na planie, po dynamiczny montaż i postprodukcję zatrzymującą uwagę widza. |
| **Co zrobiliśmy** | Kompleksowa produkcja ponad 25 filmów na YouTube (głównie MGP GARAGE): scenariusz/koncepcja → produkcja (ekipa + sprzęt) → postprodukcja (montaż pod algorytmy YT, kolor-grading, sound design). |
| **Dowód Jakości (Komentarze)** | "Jakość filmów oraz sam montaż perfekt" · "Wyczuwam nowego montażystę (...) podwyżka proszę dla tego pana ❤️" · "Zajebista produkcja" — organiczne opinie pod produkcjami dla **D4tailer**. |
| **Efekt** | Gigantyczne zasięgi i zaangażowanie (ponad **~2.8 MLN wyświetleń łącznie** dla MGP GARAGE i D4tailer). Dowód na to, że PIONA tworzy formy, które nie tylko klikają się w algorytmie, ale zachwycają widzów profesjonalnym montażem (co rzadkie na domowych kanałach twórców). |
| **Pill-labele** | `YOUTUBE` `PRODUKCJA FILMOWA` `MONTAŻ` `POSTPRODUKCJA` `2.8M+ VIEWS` |

<details>
<summary><b>Rozwiń statystyki dodatkowych produkcji (D4tailer)</b></summary>

1. **ODEBRALIŚMY NOWE M5 G90 ft. Isamu...** — 202,000 wyświetleń | 9,300 likes 
2. **TOTALNA DEWASTACJA NAJTAŃSZYCH AUT Z OLX** — 65,090 wyświetleń | 4,554 likes

**Kluczowe "Social Proof" — komentarze organiczne widzów chwalących montaż PIONA Studio:**
> *@siekuwariat*: "Jakość filmów oraz sam montaż perfekt"
> *@dedusss93*: "Jakość i treść filmów poszła mega do góry, niema co pierdolić TOPKA."
> *@donkolanko2412*: "Mega dobry montaż! Fajnie zrobiony odcinek. Pozdro"
> *@M_Line_studio*: "Wyczuwam nowego montażystę czy zapach mnie myli? 🧐 podwyżka proszę dla tego pana ❤️"
</details>

<details>
<summary><b>Rozwiń pełną listę 25 zrealizowanych filmów dla MGP GARAGE (Statystyki)</b></summary>

1. **KUPIŁEM MERCEDESA C63s OD TROMBY!** — 249,119 wyświetleń | 9,219 likes
2. **Auta za 6, 000, 000 PLN, w garażu MGP!** — 228,275 wyświetleń | 7,438 likes
3. **PORSCHE 911 dla Was! | SUPRA, R8TT, EVO IX - start akcji!** — 167,921 wyświetleń | 6,590 likes
4. **Nowe Audi RS3 (8Y) zbudowane dla Was! | Jak je wygrać?** — 157,049 wyświetleń | 6,283 likes
5. **3 X VW GOLF ZA 200 000 PLN trafią do WAS *7GTI 6R 5R32** — 143,891 wyświetleń | 9,195 likes
6. **ODBIERAMY SAMOCHODY ZABRANE PRZEZ CBŚP!** — 139,951 wyświetleń | 4,830 likes
7. **Wygrał SUPRE MK5 *tour przez Polskę!** — 130,626 wyświetleń | 4,960 likes
8. **Zrobiłem GRUBE modyfikacje w samochodzie WIDZA!** — 128,055 wyświetleń | 6,431 likes
9. **DRIFTUJEMY 2 X E46 W BAZIE WOJSKOWEJ – A POTEM ODDAJĘ WAM JE ZA DARMO!** — 118,116 wyświetleń | 1,652 likes
10. **JEDZIEMY BMW M2 i E46 NA TOR!** — 112,952 wyświetleń | 1,023 likes
11. **BMW po TUNINGU na cel charytatywny!** — 111,948 wyświetleń | 6,420 likes
12. **WOZIMY WIDZÓW BMW M2!** — 109,189 wyświetleń | 2,907 likes
13. **KTO ZNAJDZIE MIKOŁAJA DOSTAJE AUTO ZA 0 PLN** — 106,662 wyświetleń | 2,546 likes
14. **Poniosło mnie… AUTO i 15 000 PLN dla moich widzów!** — 99,420 wyświetleń | 7,701 likes
15. **WYGRAŁ GOLFA 6R w Święta! *rozdaje samochody!** — 97,260 wyświetleń | 6,572 likes
16. **Auto i 41 000 PLN dla moich widzów ZA DARMO!** — 87,918 wyświetleń | 3,698 likes
17. **GRUBE MODYFIKACJE W BMW M2 + KUPIŁEM 2 X E46!** — 84,600 wyświetleń | 3,122 likes
18. **Jak szybkie jest AUDI RS3 8Y 2023!? *0-100 i 100-200 km/h I Q&amp;A** — 81,097 wyświetleń | 3,547 likes
19. **AUTA SZYBKICH I WŚCIEKŁYCH!** — 78,440 wyświetleń | 3,356 likes
20. **To on wygrał AUDI RS3** — 68,327 wyświetleń | 3,170 likes
21. **KUPIŁEM BMW M2, DZIUPLA + POLICJA!** — 64,949 wyświetleń | 1,923 likes
22. **To on zgarnął E93 | RS4 + Ultrace23** — 58,281 wyświetleń | 2,384 likes
23. **WYRZUCILI MNIE Z MYJNI i KUPIŁEM 100-LETNIĄ DZIUPLE *CHILL ZONE 1.0** — 53,336 wyświetleń | 1,777 likes
24. **To ONI wygrali C63s i RS6 *start akcji VW 8R** — 44,009 wyświetleń | 2,597 likes
25. **WRACA MGP! – BMW DLA WIDZA + prezenty za 10.000 PLN!** — 24,941 wyświetleń | 1,226 likes

**Łącznie: 2 546 332 wyświetlenia | 100 566 polubień** 
*(Informacja: ze względu na mechanizmy zabezpieczające YouTube zebranie precyzyjnej liczby komentarzy w trybie wsadowym jest utrudnione. Zasięg mówi jednak sam za siebie).*
</details>

### 📂 CASE 9: REELSY / WIDEO (Zbiorcza karta Social Proof)
| Pole | Treść |
|------|-------|
| **Kategoria** | Video + Social Media |
| **Klient** | Różne marki (FunFit, SKINOW, inni) |
| **Wizualnie** | Grid kafelków B&W z Reelsami + overlay view count. Identyczny układ jak w Ofercie 2026. |
| **Metryki** | 56k views, 120k views, 1.4M views, 3.5M views — nakładane na screenshoty. |
| **Materiały** | 3 reklamy wideo w archiwum: FunFit Reklama 1 & 2 (reklamy fitness), Rolka SKINOW 4 (reklama kosmetyczna). |
| **Pill-labele** | `REELS` `TIKTOK` `SPOTY` `REKLAMY` `MONTAŻ` |

---

## WYTYCZNE WIZUALNE

| Element | Wytyczna |
|---------|---------|
| **Zdjęcia / Mockupy** | Duże, pełnoekranowe. Mockupy postów IG, wizytówek, stron. Lifestyle fotografie z wdrożeń. |
| **View count overlay** | Metryki wyświetleń nakładane na B&W zdjęcia (jak w Ofercie 2026) |
| **Grid** | Asymetryczny — wyróżnione projekty zajmują 2 kolumny. Hover: animacja + opis. |
| **Pill-labele** | Zielone (`#B4F95A`) tło, czarny tekst — oznaczają kategorię i zakres prac |
| **Opinia klienta** | Ramka z zaokrąglonymi rogami, border `#B4F95A`, logo firmy + zdjęcie + stanowisko |
| **Before → After** | Gdzie możliwe — pokaz transformacji wizualnej (stary vs nowy branding) |

---

## POWIĄZANIA W LEJKU

```
Skąd klient trafia na Portfolio?
  ← Strona Główna (Sekcja 4: „Przejrzyj całe portfolio →")
  ← Podstrony usług (Sekcja E: Case Study → „Zobacz pełne portfolio →")
  ← Newsroom (artykuły case study linkują do pełnego projektu)
  ← Culture Deck (Sekcja 8: logotypy klientów → „Zobacz nasze realizacje →")

Dokąd idzie z Portfolio?
  → Podstrona konkretnej usługi (np. z case Łagów → podstrona Branding)
  → Kontakt / Calendly (CTA na dole każdego case study)
  → Newsroom (powiązane artykuły o procesie)
```

---

## SEO NA PORTFOLIO

Portfolio może rankować na frazy lokalne jeśli każdy case study ma:
- **Title tag**: `[Nazwa projektu] — Case Study | PIONA Studio Zielona Góra`
- **Meta description**: `Jak [opis problemu] → [opis wyniku]. Case study agencji PIONA Studio.`
- **Alt text na zdjęciach**: `Projekt logo [nazwa] — agencja brandingowa Zielona Góra`
- **Schema markup**: `CreativeWork` schema z opisem projektu

---
**Status**: Wersja 1.0
**Ostatnia aktualizacja**: 05-03-2026
**Powiązane**: `brand_visual_identity.md`, `wytyczne_ux_i_konwersji_www.md`, `podstrony_uslug_www.md`
