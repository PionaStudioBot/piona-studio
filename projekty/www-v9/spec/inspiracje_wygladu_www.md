# Inspiracje Wyglądu Strony Internetowej — PIONA Studio
**Cel**: Dokument stanowi brief wizualny dla projektanta UI/UX. Przeanalizowano 9 projektów z Behance, wyciągnięto esencjonalne wzorce i przetłumaczono je na konkretne wytyczne dla strony PIONA Studio.

---

## PRZEANALIZOWANE PROJEKTY

| # | Projekt | Styl | Kluczowy element do zaadaptowania |
|---|---------|------|----------------------------------|
| 1 | **Kin Website** | Minimalistyczny, architektoniczny | Split-screen layout, monospaced detale |
| 2 | **Digital Agency (Atomic)** | Dark mode, tech-forward | Ciemne tło + lime accent, bento box |
| 3 | **Lyrical Lemonade** | Playful, scrapbook | Ręczne fonty, tekstury papieru, collage |
| 4 | **Crazy Creative** | Futurystyczny dark | Glassmorphism, neonowe poświaty, glow |
| 5 | **Torii** | Editorial, japoński | Seryfy, torn paper, asymetria, whitespace |
| 6 | **Personal Portfolio** | Bento-box, playful | Zaokrąglone karty, doodles, moduły |
| 7 | **Creative Agency (Zaman)** | Neo-brutalizm | Neonowy kursor, rotujące 3D, klasyka+tech |
| 8 | **Dopamine** | High-energy, brutalizm | Bloki kolorystyczne, marquee, flicker |
| 9 | **Fedoriv Agency** | High-end brutalizm | Limonka CTA, kondensowane fonty, floating cards |

---

## SYNTEZA — CO NAM SIĘ PODOBA (Powtarzające się wzorce)

Po przeanalizowaniu 9 projektów, następujące wzorce pojawiały się wielokrotnie i **pasują do DNA PIONA Studio**:

### 🔵 WZORZEC 1: DARK MODE + NEONOWY AKCENT
**Gdzie widzimy**: Digital Agency (#2), Crazy Creative (#4), Creative Agency (#7), Fedoriv (#9)
**Co nas ciągnie**: Głębokie ciemne tło (`#000000` - `#1A1A1A`) z jednym jaskrawym akcentem (limonka, cyjan, magenta).
**Dlaczego pasuje do PIONA**: Nasza paleta to Already `#212121` (Almost Black) + `#B4F95A` (Lime Green) — to DOKŁADNIE ten schemat. Fedoriv używa niemal identycznej kombinacji (`#1A1A1A` + `#CCFF00`).

> **WYTYCZNA DLA PROJEKTANTA**: Strona PIONA powinna mieć dominujący dark mode w Hero, CTA i stopce, z jasnym off-white na sekcjach treściowych. Lime `#B4F95A` jako jedyny akcent kolorystyczny — w pill-labelach, buttonach i hover states. Zero dodatkowych kolorów.

---

### 🔵 WZORZEC 2: DUŻA, ODWAŻNA TYPOGRAFIA
**Gdzie widzimy**: Kin (#1), Creative Agency (#7), Dopamine (#8), Fedoriv (#9)
**Co nas ciągnie**: Nagłówki H1 zajmują 60-80% widocznego ekranu. Fonty grube, wide lub condensed. Tekst jest elementem wizualnym, nie tylko informacją.
**Dlaczego pasuje do PIONA**: Roc Grotesk Wide Bold jest stworzony do tego — jest odważny, czytelny i dominujący.

> **WYTYCZNA DLA PROJEKTANTA**: H1 na Hero: Roc Grotesk Wide Bold, min. 64px (desktop), full-width. Typografia jest GŁÓWNYM elementem wizualnym — ważniejsza niż zdjęcia. Kontrast grubości: H1 ultra-bold vs body ultra-light. Inspiracja: Fedoriv — kondensowane fonty jako tło-dekoracja za nagłówkiem.

---

### 🔵 WZORZEC 3: ASYMETRYCZNE LAYOUTY + FLOATING ELEMENTS
**Gdzie widzimy**: Kin (#1), Torii (#5), Creative Agency (#7), Fedoriv (#9)
**Co nas ciągnie**: Elementy nie są zamknięte w sztywnych gridach. Karty, zdjęcia i bloki tekstu „lewitują", nachodzą na siebie i tworzą efekt głębi.
**Dlaczego pasuje do PIONA**: Wyłamuje się ze schematu „kolejny szablon agencyjny". Buduje wrażenie ruchu i dynamiki.

> **WYTYCZNA DLA PROJEKTANTA**: Unikać symetrycznych gridów „blok pod blokiem". Użyć: overlapping elementów (tekst nachodzący na zdjęcie), floating cards (karty z cieniem unoszące się nad tłem), asymetryczne split-screeny (60/40 zamiast 50/50). Inspiracja: Fedoriv — karty z nagrodami lewitujące na tle sekcji.

---

### 🔵 WZORZEC 4: ZAOKRĄGLONE ROGI + PILL-LABELE
**Gdzie widzimy**: Digital Agency (#2), Personal Portfolio (#6), Fedoriv (#9)
**Co nas ciągnie**: Duży border-radius na kartach, buttonach i pill-labelach. Nie sharp corners, nie pełne koła — zaokrąglone prostokąty (16-24px radius).
**Dlaczego pasuje do PIONA**: Pill-labele to DNA naszych ofert i Instagrama. Zaokrąglone rogi = nowoczesność + przystępność.

> **WYTYCZNA DLA PROJEKTANTA**: Border-radius: 16px na kartach, 24px na buttonach, full-rounded na pill-labelach. Konsekwentnie na KAŻDYM elemencie interaktywnym. Inspiracja: Fedoriv — zaokrąglone CTA „Be our client" → nasze „ZBIJ PIONĘ →".

---

### 🔵 WZORZEC 5: MARQUEE / PRZEWIJANY TEKST
**Gdzie widzimy**: Dopamine (#8), Creative Agency (#7)
**Co nas ciągnie**: Poziomy pasek z przewijanym tekstem (ticker/marquee). Dynamiczny element, który dodaje „energy" i wypełnia przestrzeń między sekcjami.
**Dlaczego pasuje do PIONA**: Dodaje ruch bez ciężkich animacji. Może prezentować usługi, hasła lub nazwy klientów.

> **WYTYCZNA DLA PROJEKTANTA**: Marquee/ticker na pełną szerokość między Hero a sekcją „Co robimy". Tekst: frazy usług w Roc Grotesk Condensed, przedzielone symbolem `·` lub `★`. Np: `BRANDING · SOCIAL MEDIA · FILMY · STRONY WWW · SEO · STRATEGIA`. Kolor: `#B4F95A` tekst na ciemnym tle. Wolna prędkość — efekt premium, nie chaos.

---

### 🔵 WZORZEC 6: INTERAKCJE I MIKRO-ANIMACJE
**Gdzie widzimy**: Crazy Creative (#4), Creative Agency (#7), Dopamine (#8)
**Co nas ciągnie**: Custom cursor, hover-reveal (tekst/obraz pojawiający się na hover), smooth scroll, parallax na zdjęciach, entrance animations (elementy wjeżdżające z dołu przy scrollowaniu).
**Dlaczego pasuje do PIONA**: Strona, która „żyje", buduje wrażenie profesjonalizmu i kreatywności. Cel z `strategia_rozwoju_2026.md`: „Zajebista strona internetowa — witryna, która sama w sobie jest case study naszych możliwości."

> **WYTYCZNA DLA PROJEKTANTA**:
> - **Scroll reveal**: Elementy (karty, teksty, zdjęcia) wjeżdżają z opacity 0→1 i translateY +30px→0 przy scrollowaniu
> - **Hover na kartach portfolio**: Skala 1→1.03 + pojawienie się overlay z tytułem projektu
> - **Custom cursor**: Na sekcjach portfolio — kursor zmienia się na kółko z tekstem „ZOBACZ" lub „OTWÓRZ"
> - **Parallax**: Delikatny na background images w Hero i sekcji Case Studies (max. 10-15% offset)
> - **Magnetic buttons**: CTA przyciąga kursor z 20px dystansu (efekt magnetyczny)

---

### 🔵 WZORZEC 7: SPLIT-SCREEN I MODULARNOŚĆ
**Gdzie widzimy**: Kin (#1), Digital Agency (#2), Personal Portfolio (#6)
**Co nas ciągnie**: Sekcje dzielone na pół (tekst lewo + obraz prawo) lub modułowe bento-boxy (karty różnych rozmiarów w gridzie).
**Dlaczego pasuje do PIONA**: Bento-box idealny do prezentacji usług (kafelki) i case studies (grid portfolio).

> **WYTYCZNA DLA PROJEKTANTA**: Sekcja „Co robimy" → bento grid usług (6 kafelków: 2 duże + 4 mniejsze). Sekcja procesu → split-screen (tekst lewo, wizualizacja timeline prawo). Portfolio grid → bento (1 duży kafelek span-2 + 4 mniejsze).

---

## ELEMENTY ODRZUCONE (nie pasują do DNA PIONA)

| Wzorzec | Dlaczego NIE |
|---------|-------------|
| Scrapbook / ręczne fonty (Lyrical Lemonade #3) | Zbyt chaotyczne, nie pasuje do „minimalizm z edge'em" PIONA |
| Glassmorphism / neon glow (Crazy Creative #4) | Za bardzo tech/SaaS, PIONA to agencja, nie startup |
| Wielokolorowe bloki (Dopamine #8) | PIONA ma oszczędną paletę 3 kolorów — wielobarwność to chaos |
| Seryfy w nagłówkach (Torii #5) | Sprzeczne z Roc Grotesk — nasz font jest bezszeryfowy |
| Doodles / ręczne rysunki (Personal Portfolio #6) | Zbyt „cute" — PIONA to „pewni siebie profesjonaliści", nie „kreatywny freelancer" |

---

## KOŃCOWY BRIEF DLA PROJEKTANTA — STYL WIZUALNY PIONA STUDIO

### Esencja w jednym zdaniu:
> **Dark premium minimalizm z limonkowym znakiem rozpoznawczym — Fedoriv meets własne DNA PIONA.**

### Fundamenty:

| Aspekt | Wytyczna |
|--------|---------|
| **Tryb** | Dark mode (Hero, CTA, stopka) + off-white (sekcje treściowe) |
| **Kolor wiodący** | `#212121` (Almost Black) — dominujący |
| **Kolor akcentu** | `#B4F95A` (Lime Green) — JEDYNY akcent |
| **Trzeci kolor** | `#D6D5D4` (Warm Gray) — separatory, subtext |
| **Tło jasne** | `#F5F5F3` (Off-white) — sekcje treściowe |
| **Font H1** | Roc Grotesk Wide Bold, 64-96px desktop |
| **Font H2/H3** | Roc Grotesk Condensed Bold, 24-40px |
| **Font body** | Roc Grotesk Regular, 16-18px |
| **Border-radius** | 16px karty, 24px buttony, full-round pill-labele |
| **Whitespace** | Dużo. Luksus = oddech. Min. 80px padding między sekcjami |
| **Layouty** | Asymetryczne split-screeny, bento gridy, floating cards |
| **Animacje** | Scroll reveal, hover scale, custom cursor, marquee, parallax |
| **Zdjęcia** | Autentyczne (zero stocków), lekki B&W z limonkowym akcentem |
| **Ikony brand** | Chromowane dłonie, motyw drogi z flagami, sygnet PIONA |

### Wzorce inspiracyjne — ranking zbieżności z PIONA:
1. 🥇 **Fedoriv** — najbliższy wizualnie (limonka, kondensowane fonty, floating cards)
2. 🥈 **Digital Agency (Atomic)** — dark + lime, bento box, lead gen focus
3. 🥉 **Kin** — split-screen, whitespace, architektoniczny minimalizm
4. **Creative Agency (Zaman)** — neo-brutalizm, custom cursor, neon
5. **Dopamine** — marquee element, modułowe karty

---
**Status**: Wersja 1.0
**Ostatnia aktualizacja**: 05-03-2026
**Źródła**: 9 projektów Behance (linki w sekcji 1)
