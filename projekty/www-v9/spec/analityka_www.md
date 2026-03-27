# Wytyczne Analityczne i Techniczne — Strona WWW PIONA Studio
**Powiązane**: `architektura_strony_www.md`, `strategia_seo.md`, `lejek_piona.md`

> **📋 CEL**: Mierzenie skuteczności strony jako narzędzia sprzedażowego. Każde kliknięcie, scroll i formularz muszą być śledzone — bo strona to lejek, a lejek bez danych to strzał w ciemno.

---

## 1. Google Analytics 4 (GA4)

### Konfiguracja podstawowa
- **Strumień danych**: Web (domena piona-studio.pl)
- **Enhanced Measurement**: Włączone (scrolle, wyszukiwania, kliknięcia w linki wychodzące, odtwarzanie wideo)
- **Cross-domain tracking**: skinow.pl, funfit2.pl (jeśli linkujemy jako case study z UTM-ami)

### Zdarzenia niestandardowe (Custom Events)
| Zdarzenie | Trigger | Cel |
|-----------|---------|-----|
| `form_submit` | Wysłanie formularza kontaktowego | Konwersja główna |
| `calendly_click` | Kliknięcie w widget Calendly | Konwersja main (fast-track) |
| `calendly_booking` | Potwierdzenie rezerwacji (Calendly webhook) | Konwersja potwierdzona |
| `cta_click` | Kliknięcie CTA „Umów konsultację" (na dowolnej podstronie) | Mikro-konwersja |
| `service_page_view` | Wejście na podstronę usługi | Interest stage |
| `portfolio_case_click` | Kliknięcie w case study | Consideration stage |
| `newsroom_article_read` | Scroll >75% artykułu w Newsroomie | Zaangażowanie |
| `phone_click` | Kliknięcie w numer telefonu (mobile) | Lead telefoniczny |
| `email_click` | Kliknięcie w adres email | Lead mailowy |

### Cele konwersji (GA4 Conversions)
1. **Główna**: `form_submit` + `calendly_booking`
2. **Pomocnicza**: `cta_click` + `calendly_click`
3. **Zaangażowanie**: `portfolio_case_click` + `newsroom_article_read`

---

## 2. Meta Pixel (Facebook/Instagram Ads)

### Zdarzenia standardowe
| Zdarzenie Meta | Trigger | Mapowanie na lejek |
|---------------|---------|-------------------|
| `PageView` | Każda strona | Awareness |
| `ViewContent` | Podstrona usługi / case study | Interest |
| `Lead` | Wysłanie formularza kontaktowego | Intent → Purchase |
| `Schedule` | Rezerwacja Calendly | Purchase |

### Custom Audiences (do kampanii retargetingowych)
| Audience | Definicja | Cel kampanii |
|----------|-----------|-------------|
| **Visitors 30d** | Wszyscy odwiedzający (30 dni) | Remarketing ogólny |
| **Service viewers** | Osoby, które odwiedziły podstronę usługi | Reklama konkretnej usługi |
| **Portfolio engaged** | Osoby, które kliknęły case study | Social proof remarketing |
| **Form abandoners** | Osoby na /kontakt, które NIE wysłały formularza | Oferta/zachęta do kontaktu |
| **Newsroom readers** | Osoby, które przeczytały artykuł (scroll >75%) | Edukacyjny retargeting |

---

## 3. Google Search Console

- **Weryfikacja domeny**: DNS lub plik HTML
- **Sitemap**: Automatycznie generowany XML (`/sitemap.xml`)
- **Zgłoszenie indeksacji**: Wszystkie kluczowe URL-e po launchu
- **Core Web Vitals**: Monitoring prędkości i UX (cel: wszystkie metryki "zielone")

---

## 4. Google Business Profile (Wizytówka Google)

- **Link do strony**: Główna + UTM `?utm_source=google&utm_medium=maps`
- **Posty na wizytówce**: Cotygodniowe (link do artykułu z Newsroomu lub usługi)
- **Zbieranie opinii**: Po każdym zamkniętym projekcie → automatyczny email z prośbą
- **Zdjęcia**: Aktualizacja co miesiąc (biuro, ekipa, realizacje)

---

## 5. UTM-y i śledzenie źródeł ruchu

### Schemat UTM dla PIONA
```
utm_source = [skąd] → google, instagram, facebook, linkedin, direct
utm_medium = [jak] → organic, paid, social, email, referral
utm_campaign = [co] → branding-2026, funfit-case, audyt-seo, newsletter
```

### Przykłady
| Link | UTM |
|------|-----|
| Link w bio na IG | `?utm_source=instagram&utm_medium=social&utm_campaign=bio-link` |
| Post na FB | `?utm_source=facebook&utm_medium=social&utm_campaign=post-branding` |
| Meta Ads → strona | `?utm_source=facebook&utm_medium=paid&utm_campaign=brand-awareness-q2` |
| Email follow-up | `?utm_source=email&utm_medium=email&utm_campaign=followup-oferta` |

---

## 6. Narzędzia dodatkowe

| Narzędzie | Cel | Priorytet |
|-----------|-----|-----------|
| **Hotjar / Microsoft Clarity** | Heatmapy i nagrania sesji (jak ludzie scrollują, co klikają) | Wysoki |
| **Google Tag Manager** | Zarządzanie wszystkimi tagami i zdarzeniami z jednego miejsca | Wymagany |
| **Calendly Analytics** | Śledzenie rezerwacji, konwersji z formularza vs Calendly | Wbudowany |

---

## 7. Dashboard raportowy (na przyszłość)

Docelowo: Looker Studio dashboard z kluczowymi KPI:
- **Ruch na stronie** (total, organic, paid, social)
- **Konwersje** (formularz + Calendly → łącznie i osobno)
- **Top artykuły** Newsroomu (po ruchu i zaangażowaniu)
- **Top podstrony usług** (po CTR na CTA)
- **Pozycje SEO** (top 6 fraz z `strategia_seo.md`)

---
**Status**: Wersja 1.0
**Ostatnia aktualizacja**: 05-03-2026
**Powiązane**: `strategia_seo.md`, `lejek_piona.md`, `kontakt_www.md`
