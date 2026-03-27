# PIONA Studio - Information Architecture & Subpage Layouts

Dokument określa finalną strukturę podstron (Sitemap) oraz uniwersalny, zoptymalizowany pod kątem SEO i konwersji (UX/UI) szkielet (Wireframe) dla usługowych Landing Page'y (Pillar Pages).

## 🚨 1. Analiza i Korekta Pierwotnego Planu (Znalezione Luki i Błędy)

Analiza wstępnie zaplanowanej listy podstron usługowych pod kątem naszego `PIONA_SEO_Keyword_Mapping.md` ujawniła dwie strategiczne luki, które od razu korygujemy:

### LUKA A: Katastrofa Kanibalizacyjna ("Tworzenie stron internetowych & SEO")
Połączenie Stron WWW i SEO na jednym Landing Page'u to **krytyczny błąd strukturalny**. 
*   **Powód:** Łamiemy naszą *Zasadę Zero Kanibalizacji*. To dwa odrębne giga-filary wyszukiwań. Algorytm Google nie będzie wiedział, w czym ta podstrona jest najlepsza. Użytkownik szukający rzemieślniczego kodowania WWW ma inną intencję niż prezes szukający twardego twardego wzrostu ROAS z wizytówki Google Maps (SEO).
*   **Rozwiązanie (Fix):** Kategoryczne rozdzielenie na dwa osobne Pillar Pages (Silosy). 
    1.  LP: Tworzenie stron internetowych Zielona Góra
    2.  LP: Pozycjonowanie stron Zielona Góra

### LUKA B: Duplikacja i Rozmycie ("Projektowanie logo..." ORAZ "Kompleksowy branding")
Z punktu widzenia intencji wyszukiwani w Google, rozbijanie tego na dwie osobne zakładki rozmywa "Link Juice" (moc SEO). Osoba wpisująca "Projektowanie logo" często ostatecznie potrzebuje kompleksowego brandingu, ale nie wie o tym na etapie wyszukiwania (tzw. zjawisko *Unaware/Problem-Aware*).
*   **Rozwiązanie (Fix):** Tworzymy JEDEN potężny Landing Page "Projektowanie Logo Zielona Góra", a "Kompleksowy branding" instalujemy wewnątrz jako osobną, premium sekcję (H2) i najwyższy pakiet cenowy. Upsellujemy klienta po wejściu na stronę, a nie zmuszamy go do wybierania zakładki przed kliknięciem.

---

## 🗺️ 2. Finalna Architektura Strony (Sitemap) nałożona na SEO

Poniższa struktura to finalny kompromis między użytecznością użytkownika (UX) a architekturą informacji dla Czołgów SEO (Googlebot):

### A. Core / Global (Nawigacja główna)
1.  **Strona Główna (HUB)** [Fraza: *Agencja reklamowa Zielona Góra*]
2.  **Portfolio / Nasze realizacje** (Z mocnym linkowaniem wewnętrznym z każdego Case Study do konkretnych usług).
3.  **Culture Deck / O nas** (Zaufanie, budowanie marki eksperckiej i miejsca pracy).
4.  **Kontakt** (+ Formularz / Calendly widget).

### B. Usługi / Pillar Pages (Rozwijane Menu "Co robimy" / "Oferta")
Każda z tych podstron to dedykowany, jednofrazowy (Zero Kanibalizacji) Landing Page z własnym lejkiem sprzedażowym:
1.  **Tworzenie stron internetowych**
2.  **Pozycjonowanie stron (SEO) i Google Maps**
3.  **Projektowanie logo i branding**
4.  **Prowadzenie social media (Fanpage / Reels)**
5.  **Produkcja wideo i filmy reklamowe**

### C. Content Hub
1.  **Baza wiedzy / Blog** (Do przechwytywania fraz o intencji czysto informacyjnej - Top of Funnel).

---

## 🏗️ 3. Uniwersalny Układ Podstrony Usługowej (Pillar Page Wireframe)

Aby utrzymać drastyczną spójność i nie zmuszać użytkownika do "nauki" nawigacji na każdej podstronie, aplikujemy zunifikowany model **AICIP (Awareness, Interest, Consideration, Intent, Purchase)** dopasowany do podstrony *lokalnej usługi*:

1.  **HERO (Awareness)**
    *   **H1:** Mocny akcent na Frazę Główną Pillar (np. *Skuteczne Prowadzenie Social Media Zielona Góra*).
    *   **Subheadline:** Wynik biznesowy usługi (np. *Zwiększamy zaangażowanie i zdobywamy leady przez Facebooka i TikToka.*)
    *   **CTA:** Umów darmową wycenę / Odbierz audyt.
2.  **PROBLEM / AGNIZACJA (Interest - "Odkrycie Rany")**
    *   Krótka sekcja edukująca, dlaczego klient w ogóle tego potrzebuje.
    *   *Przykład dla Stron WWW:* "Twój biznes rośnie, ale Twoja strona zatrzymała się w 2015 roku? Tracisz klientów, którzy wchodzą ze smartfonów."
3.  **SOLUTION & PAKIETY (Consideration - H2/H3 Long Tails)**
    *   Moduł "Co dokładnie robimy" lub "Cennik/Pakiety".
    *   To tutaj przemycamy frazy z długiego ogona: *H2: Ile kosztuje strona internetowa?*, *H2: Projektowanie sklepów internetowych (E-commerce)*.
4.  **METHODOLOGY (The PIONA Process - Intent)**
    *   Pokazanie "Kuchni" PIONA Studio. Jak wygląda proces krok po kroku (Brief -> Strategia -> Realizacja -> Raport). To ubija obiekcję "a co, jeśli oni są amatorami?". PIONA nie działa na oślep - PIONA ma system.
5.  **USŁUGOWY SOCIAL PROOF (Consideration)**
    *   *Kluczowe:* Nie dajemy tutaj ogólnych opinii z Google. Dajemy Case Study i opinie BARDZO KONKRETNIE związane z tą usługą (np. na podstronie Social Media -> Wypowiedź Prezesa o tym, jak wzrosła mu konwersja z FB Ads).
6.  **FAQ (Local SEO Powerhouse)**
    *   Sekcja Pytania i Odpowiedzi zbudowana na bazie znaczników `Schema.org/FAQPage`.
    *   Służy do zgarniania zapytań głosowych i "People Also Ask" w Google, np. *Czy prowadzicie szkolenia z Meta Ads?*, *Odzyskujecie zablokowane konta reklamowe?*
7.  **PURCHASE FORM (Final CTA)**
    *   Zunifikowana sekcja kontaktowa (taka sama jak na HUBie): Mocny nagłówek "Umów strategiczną konsultację", wybór z kalendarza (Calendly), maksymalnie 3 pola formularza i obietnica odpowiedzi <24h.

---
*Notatka systemowa: Każde kodowanie / projektowanie graficzne (Figma/Web) czy generowanie tekstów na którąkolwiek z sekcji domeny pionastudio.pl (lub subdomen klientów B2B budowanych w tym modelu), musi ściśle realizować ten układ kaskadowy sekcji i powiązań nawigacyjnych. Ten plik stanowi rozszerzenie do SEO Keyword Mapping.*
