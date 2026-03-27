# 🧠 PIONA Studio — Master-Instrukcja dla Web Developera
> **Wersja:** 1.1 (Zintegrowana z Bazą Wiedzy C-Level)
> **Cel dokumentu:** Przełożenie założeń biznesowych, lejka sprzedażowego i filozofii PIONA na konkretny język architektury i kodu strony WWW.

Ten dokument tłumaczy **DLACZEGO** strona PIONA Studio wygląda w określony sposób i **JAK** należy to zakodować, aby spełniała swoje zadanie: *była wysoce konwertującą maszyną do generowania leadów B2B*.

> [!CAUTION]
> **MANDATORY AI INSTRUCTION (INTEGRACJA Z BAZĄ WIEDZY):**
> Przed przystąpieniem do jakichkolwiek prac deweloperskich, doradczych, analitycznych lub strategicznych dla PIONA Studio, **KAŻDY agent AI ma absolutny obowiązek jako pierwszy krok użyć swoich narzędzi (np. odczytu plików / listowania katalogów) aby przeanalizować plik:** `05_Baza_Wiedzy/00_AI_System_Instructions.md` i podążać za zawartym tam frameworkiem (np. odczyt `01_Brand_Core_Identity.md` itd.). Zignorowanie tego kroku odcina AI od zgromadzonego know-how C-Level, de-optymalizując proces i jest surowo zabronione. Cała praca ma opierać się na zdobytej tam wiedzy!

---

## 🏗️ 1. Architektura Lejka a Architektura Strony (Przyczyna ➔ Skutek)
Strona nie jest katalogiem informacji. Została zaplanowana zgodnie z Lejkiem Sprzedażowym (Awareness ➔ Interest ➔ Consideration ➔ Intent ➔ Purchase). 

* **ŚWIADOMOŚĆ (Awareness) ➔ Wdrażasz System "Pillar & Clusters"**
  * *Dlaczego:* Klienci nie szukają od razu "PIONA Studio", tylko rozwiązań ich problemów (SEO).
  * *Wytyczna dla Dev:* Strona główna to "Pillar Page". Oprócz niej musisz zbudować aż **6 osobnych podstron Landing Page** dla każdej usługi (Branding, Logo, Social Media, WWW, SEO, Filmy). Pędź ruch z klastrów tematycznych (Newsroom/Blog) prosto na te landingi.
* **ZAINTERESOWANIE (Interest) ➔ Wdrażasz Asymetryczne Gridy Usług (Home)**
  * *Dlaczego:* Chcemy by klient w pierwszych sekundach na stronie głównej zobaczył zwięzłą listę "Co robimy" bez czytania ścian tekstu.
  * *Wytyczna dla Dev:* Bento-Grid dla 6 usług na HOME. Interaktywne (hover-glow), wysoce responsywne kafelki pełniące rolę drogowskazów w podstrony.
* **ROZWAŻANIE (Consideration) ➔ Wdrażasz Dowody Społeczne (Data-Driven)**
  * *Dlaczego:* Klienci B2B potrzebują twardych danych przed wydaniem tysięcy złotych.
  * *Wytyczna dla Dev:* Osobna, potężna strona `/portfolio`. Case Studies kodujemy tak, by na pierwszym planie świeciły liczby (np. *„14.4 mln wyświetleń", "Wzrost ROI o 40 000 zł"*). Galeria zdjęć bez pomysłu to błąd — liczą się namacalne wyniki. + Osobna zakładka `/o-nas` (Culture Deck), pokazująca "z kim" klient będzie pracował.
* **INTENCJA (Intent) ➔ Wdrażasz Agresywne CTA i Fast-Track**
  * *Dlaczego:* Gdy klient jest gotów kupić, najmniejszy opór formularza go odstraszy.
  * *Wytyczna dla Dev:* Formularz kontaktowy sprowadzony w kodzie do 3 pól (Imię, Metoda Kontaktu, Drop-down "Czego potrzebujesz"). W sekcji `/kontakt` obok klasycznego maila **musisz wpiąć widget Calendly** do samodzielnego rezerwowania 15/30-minutowych calli (Fast-Track).

---

## 🔎 2. Strategia SEO w Praktyce Front-Endu
Lokalne dominowanie na rynek B2B (Woj. Lubuskie / Polska) narzuca rygorystyczne normy dla HTML5 i struktury nagłówków.

* **Zasada Głównej Frazy ➔ Restrykcyjne H1**
  * *Dlaczego:* Boty Google muszą od razu wiedzieć, o czym jest dany Landing Page.
  * *Wytyczna dla Dev:* Każda ze strategicznych podstron (jest ich 11) ma precyzyjny tag `<H1>`. Strona główna ma w nagłówku frazę ukierunkowaną na *„Agencja Reklamowa Zielona Góra"* wplecioną sprytnie jako mniejszy pill nad tekstem HERO. 
* **Zasada Węzłów Semantycznych (Long-Tails) ➔ Budowa H2/H3**
  * *Dlaczego:* Nie chcemy "upychać" słów po przecinku. To szkodzi UX.
  * *Wytyczna dla Dev:* Używamy rozbudowanych nagłówków sekcji (np. z FAQ). Buduj w HTML tagi `<h2>` i `<h3>` dla takich fraz jak: *"Dlaczego profesjonalne strony internetowe decydują o sukcesie firmy w Zielonej Górze?"*. 
* **Lokalny Boost w Stopce ➔ Globane Footer tag**
  * *Dlaczego:* Pająki indeksujące czytają stopkę każdej podstrony.
  * *Wytyczna dla Dev:* W stopce (`<footer>`) globalnie musisz zaszyć tekst SEO: *„Działamy stacjonarnie w Zielonej Górze, obsługujemy klientów z całego województwa Lubuskiego oraz Polski."*

---

## 🎨 3. PIONA UX & Komunikacja (Żelazne Zasady Designu)
Czerpiemy z najlepszych rynkowych wzorców (np. Moxie, Icea), ucinając zbędny żargon. 

* **ZERO MAŚLANEGO JĘZYKA ➔ Business & ROI Focus**
  * Projektując i układając teksty z CMSa, usuwaj lanie wody o "młdym, kreatywnym i pełnym pasji zespole". Pisz konkretami: *"Myślimy biznesem, generujemy ROI"*.
* **Poczucie Kontroli ➔ Wizualizacja "Timeline'u"**
  * Klienci cenią bezpieczeństwo. Dlatego na kodowanej podstronie usług zawsze umieszczasz **Wertykalny Timeline Procesu** z 5 krokami. Wyjaśnij kodem: Co ➔ Po co ➔ Kiedy.
* **Dłonie Chrome 3D ➔ Inżynieria WebGL i Optymalizacja**
  * Cechą marki są modele `hand-low-x.glb` wyświetlane poprzez tag `<model-viewer>`. 
  * Wymagamy renderowania PBR uderzającego w pełen Chrome. Jako developer musisz wstawić atrybuty `environment-image="neutral"`, a poprzez JavaScript iterować materiały: ustawić `setMetallicFactor(1.0)` oraz `setRoughnessFactor(0.05)`.
  * Ręka w sekcji Hero musi być wycentrowana w rogu, wielka i nieograniczona kontenerami obcinającymi `overflow`. Musi robić ogromne wrażenie od pierwszych ułamków sekund (tzw. LCP).

---

## ⚙️ 4. Check-lista Technologiczna (V8 - Ostateczna Fuzja)
Lista weryfikacyjna przed zamknięciem kodu strony:

- [ ] **Google Tag Manager & Meta Pixel:** Zainstalowane w sekcji `<head>`, mierzące konwersje kliknięć (Zbij Pionę) oraz wyświetlenia widgetu Calendly.
- [ ] **Szybkość ładowania (Web Vitals):** Ciemne motywy graficzne (Dark-Glass, glow overlays) bazują mocno na CSS-gradients i Blur. Pilnuj optymalizacji obciążenia GPU. Zmniejsz wagę modeli WebGL z użyciem kompresji Draco.
- [ ] **Responsywność H1 (RWD):** Olbrzymie nagłówki "Roc Grotesk" z `clamp()` muszą układać się perfekcyjnie zarówno na desktopie 4K jak i wąskich iPhone'ach by nie wypadały za viewport. Dowodem tego mają być nasze pille i tagi (`Branding`, `Strony WWW` obok CTO).
- [ ] **Hover Glow Effects:** Sprawienie, by strona "żyła" i reagowała z kursorem użytkownika, to fundament Piona Studio V8. Karty Portfolio mają się delikatnie powiększać wysuwając `ZOBACZ →`, a usługi mają aktywować się zieloną poświatą przy hoverze.

Dzięki przełożeniu strategii biznesowej bezpośrednio na kod operacyjny, wspólnie wydamy maszynę B2B najnowszej generacji. Powodzenia kodowaniu!
