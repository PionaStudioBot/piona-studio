# SOP — Praca Wiktorii w Cowork (Zero-Terminal)

> Jedyna komenda którą Wiktoria wpisuje: `/sync`

---

## Jak zacząć sesję

1. Otwórz aplikację **Cowork** na MacBooku
2. Upewnij się że folder workspace to `Desktop/AI/PIONA-AI`
3. Zacznij pracę normalnie — pisz, edytuj pliki, twórz notatki

Nie musisz nic robić z Gitem. Cowork i Claude zarządzają tym automatycznie.

---

## Jak zapisać i zsynchronizować zmiany

Po skończonej pracy wpisz w Cowork:

```
/sync
```

Claude zrobi automatycznie:
- Zapisze Twoje zmiany (commit)
- Wyśle na GitHub (push)
- Pobierze zmiany Oskara jeśli coś dodał
- Połączy zmiany jeśli edytowałyście ten sam plik

Na końcu zobaczysz podsumowanie `✅ SYNC ZAKOŃCZONY`.

---

## Gdzie są assety (logotypy, zdjęcia, PDF)?

Pliki graficzne **nie są w folderze PIONA-AI** — są na Google Drive:

- Logotypy, fonty → `Mój dysk / PIONA Assets / brand /`
- Oferty PDF → `Mój dysk / PIONA Assets / oferty /`
- Portfolio, zdjęcia → `Mój dysk / PIONA Assets / portfolio /`

Google Drive synchronizuje te pliki automatycznie — nie musisz nic robić.

---

## Co zrobić gdy coś nie działa

| Problem | Co zrobić |
|---------|-----------|
| `/sync` zwraca błąd | Napisz Oskarowi co dokładnie wyświetlił Claude |
| Cowork nie widzi plików | Sprawdź czy folder workspace to `Desktop/AI/PIONA-AI` |
| Brakuje assetów (logotypów, zdjęć) | Sprawdź Google Drive `PIONA Assets/` |
| Nie możesz się połączyć z GitHub | Sprawdź połączenie z internetem, spróbuj ponownie |

---

## Czego NIE robić

- Nie otwieraj terminala — nie jest potrzebny
- Nie przenoś ani nie usuwaj folderu `Desktop/AI/PIONA-AI` z Findera
- Nie edytuj plików z folderu `.git` (ukryty folder) — Cowork robi to za Ciebie
- Nie instaluj dodatkowych narzędzi — wszystko jest już skonfigurowane

---

*Ostatnia aktualizacja: 27-03-2026*
