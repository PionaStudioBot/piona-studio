# CLAUDE.md — Hub Główny PIONA Studio

## 0. Protokół startowy dla nowego modelu AI

> **KAŻDY model AI** wchodzący w ten folder MUSI przeczytać pliki w tej kolejności:
> 1. `.cursorrules` — zasady pracy z plikami, routing plików
> 2. `SESSION.md` — stan ostatniej sesji, następny krok, otwarte pytania
> 3. `CLAUDE.md` — mapa przestrzeni, nawigacja kontekstowa (ten plik)
>
> Nie zaczynaj pracy bez przeczytania tych trzech plików.

## 1. Przegląd systemu

**PIONA Studio** — agencja brandingowa, kreatywna i wideo z Zielonej Góry.
**Misja**: Budowa tożsamości marek, które chcą dominować na rynku i być liderami w branży.
**Kluczowa zasada**: "Rozwiązania > Usługi". Nie sprzedajemy projektowania — sprzedajemy rozwiązania biznesowe.
**Pozycja rynkowa**: Top of Mind agencja kreatywna dla przedsiębiorców w województwie lubuskim.

## 2. Mapa przestrzeni

### 2.1 Katalog główny
| Plik | Opis |
|------|------|
| `.cursorrules` | Zasady pracy AI, routing plików |
| `SESSION.md` | Handoff między sesjami — stan, następny krok |
| `CLAUDE.md` | Hub nawigacyjny (ten plik) |
| `STATUS_UPDATES.md` | Living Context Log, postępy celów |
| `MASTERPLAN.md` | Fazy wdrożenia, backlog zadań |

### 2.2 Struktura folderów

> ⚠️ **Pre-migracja (Faza 0)**: Aktualna struktura numeryczna. Po Fazie 2 ścieżki zostaną zaktualizowane do struktury semantycznej. Docelowy routing: `.claude/rules/file-routing.md`

| Lokalizacja | Kluczowe pliki |
|-------------|----------------|
| `/00_Strategia_2026/` | `strategia_rozwoju_2026.md`, `lejek_piona.md` |
| `/01_Procesy_Wewnetrzne/` | `system_pozyskiwania_klienta.md` |
| `/02_Ofertowanie/` | `strategia_ofertowania.md` |
| `/04_SEO_i_WWW/` | `strategia_seo.md`, `architektura_strony_www.md`, `plan_bloga.md` |
| `/05_Baza_Wiedzy/` | Klastry wiedzy — patrz `00_AI_System_Instructions.md` |
| `/06_Dane_i_Assety/Dane_Firmy/` | `o_nas.md` |
| `/07_Projekty_Aktywne/www-v9/` | Aktywna wersja strony WWW |

### 2.3 Baza Wiedzy

Instrukcje AI + Złota Zasada + mapa klastrów: `.claude/rules/_system_instructions.md`
Przed zadaniem brandingowym/marketingowym/contentowym — załaduj klaster przez `/wiedza`.

## 3. Asystenci i komendy

### Agents
| Agent | Rola |
|-------|------|
| `@ceo` | Rozwój biznesu, wizja, partnerstwa |
| `@strateg` | Strategia marki, pozycjonowanie, diagnoza |
| `@creative` | Branding, video, tożsamość wizualna |

### Slash Commands
| Command | Opis |
|---------|------|
| `/feedback` | Przetwórz feedback i zapisz jako trwałą regułę w `.auto-memory` |
| `/wiedza` | Załaduj odpowiedni klaster bazy wiedzy przed zadaniem |
| `/sync` | Commit + merge branches + push na GitHub |
| `/backup` | Git commit + ZIP archive + Google Drive sync |

## 4. Nawigacja kontekstowa

| Pytanie dotyczy... | Przeczytaj... |
|--------------------|---------------|
| Celów na ten rok | `/00_Strategia_2026/strategia_rozwoju_2026.md` |
| Strategii lejka sprzedażowego | `/00_Strategia_2026/lejek_piona.md` |
| Rozmów z klientem, follow-up | `/01_Procesy_Wewnetrzne/system_pozyskiwania_klienta.md` |
| Struktury oferty / Speed to Lead | `/02_Ofertowanie/strategia_ofertowania.md` |
| SEO i keyword mapping | `/04_SEO_i_WWW/strategia_seo.md` |
| Strony WWW — budowa, podstrony | `/04_SEO_i_WWW/architektura_strony_www.md` |
| Planu artykułów blogowych | `/04_SEO_i_WWW/plan_bloga.md` |
| Kim jesteśmy i co robimy | `/06_Dane_i_Assety/Dane_Firmy/o_nas.md` |
| Branding, strategia marki | `/05_Baza_Wiedzy/01_Brand_Core_Identity.md` + `03_Brand_Strategy.md` |
| Psychologia klienta, UX | `/05_Baza_Wiedzy/07_Behavioral_Economics.md` |
| Copywriting, content marketing | `/05_Baza_Wiedzy/04_Content_Strategy.md` + `06_Personas_Brand_Voice.md` |
| Pricing, modele zysków | `/05_Baza_Wiedzy/08_Pricing_Profit_Engineering.md` |
| Zasady operacyjne AI | `.claude/rules/operational-rules.md` |
| Architektura sync, Git Branches | `.claude/rules/sync-architecture.md` |
| Routing plików (co gdzie trafia) | `.claude/rules/file-routing.md` |

## 5. Status systemu

Aktualny stan projektu: [STATUS_UPDATES.md](./STATUS_UPDATES.md)

## 6. Zasady operacyjne

→ Pełne reguły: `.claude/rules/operational-rules.md`

## 7. Architektura synchronizacji

→ Model Git Branches: `.claude/rules/sync-architecture.md`
→ Skill `/sync` v3 (shadow clone): `.claude/skills/sync/SKILL.md`

---
**Wersja**: 7.0
**Ostatnia aktualizacja**: 26-03-2026
