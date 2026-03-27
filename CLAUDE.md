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

> Struktura semantyczna — routing: `.claude/rules/file-routing.md`

| Folder | Opis | Kluczowe pliki |
|--------|------|----------------|
| `context/` | Tożsamość firmy (max 5 plików) | `o_nas.md`, `brandbook.md`, `brand_visual_identity.md` |
| `wiedza/` | Baza wiedzy — 4 klastry tematyczne | patrz sekcja 2.3 |
| `planning/` | Strategie i plany działania | `strategia_2026.md`, `lejek_piona.md`, `strategia_seo.md` |
| `procesy/` | SOPy, procedury, szablony ofert | `system_pozyskiwania_klienta.md`, `strategia_ofertowania.md` |
| `projekty/` | Aktywne projekty (kod + spec) | `www-v9/` |
| `narzedzia/` | Skrypty operacyjne | `scripts/` |
| `archiwum/` | Stare wersje, archiwa (gitignored) | — |
| `inbox/` | Bufor tymczasowy (gitignored) | — |

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
| Celów na ten rok | `planning/strategia_2026.md` |
| Strategii lejka sprzedażowego | `planning/lejek_piona.md` |
| Rozmów z klientem, follow-up | `procesy/system_pozyskiwania_klienta.md` |
| Struktury oferty / Speed to Lead | `procesy/strategia_ofertowania.md` |
| SEO i keyword mapping | `planning/strategia_seo.md` |
| Strony WWW — budowa, podstrony | `planning/architektura_www.md` |
| Planu artykułów blogowych | `planning/plan_bloga.md` |
| Kim jesteśmy i co robimy | `context/o_nas.md` |
| Brand book, tożsamość marki | `context/brandbook.md` |
| Branding, strategia marki | `wiedza/brand_strategy_identity/` |
| Psychologia klienta, UX | `wiedza/customer_psychology_ux/` |
| Copywriting, content marketing | `wiedza/marketing_content_strategy/` |
| Pricing, modele zysków | `wiedza/pricing_business_models/` |
| Spec WWW, treści podstron | `projekty/www-v9/spec/` |
| Kod WWW (HTML/CSS/JS) | `projekty/www-v9/` |
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
**Wersja**: 8.0
**Ostatnia aktualizacja**: 27-03-2026
