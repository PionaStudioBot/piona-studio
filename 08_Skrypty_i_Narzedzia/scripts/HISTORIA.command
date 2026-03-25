#!/bin/bash
# ============================================
# PIONA Studio — HISTORIA ZMIAN
# Pokaż kto co zmienił i kiedy
# Użycie: kliknij dwukrotnie lub wpisz /historia
# ============================================

# --- Kolory ---
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# --- Znajdź folder PIONA Studio ---
find_project_root() {
    local current="$(cd "$(dirname "$0")" && pwd)"
    while [ "$current" != "/" ]; do
        if [ -f "$current/.cursorrules" ]; then
            echo "$current"
            return 0
        fi
        current="$(dirname "$current")"
    done
    echo ""
    return 1
}

PROJECT_DIR=$(find_project_root)
if [ -z "$PROJECT_DIR" ]; then
    echo -e "${RED}BŁĄD: Nie mogę znaleźć folderu PIONA Studio${NC}"
    read -p "Naciśnij Enter aby zamknąć..."
    exit 1
fi

cd "$PROJECT_DIR"

echo ""
echo -e "${BOLD}╔══════════════════════════════════════╗${NC}"
echo -e "${BOLD}║   PIONA Studio — HISTORIA ZMIAN     ║${NC}"
echo -e "${BOLD}╚══════════════════════════════════════╝${NC}"
echo ""

echo -e "${BOLD}Co chcesz zobaczyć?${NC}"
echo "  1) Ostatnie 20 zmian (kto, co, kiedy)"
echo "  2) Zmiany z ostatniego tygodnia"
echo "  3) Historia konkretnego pliku"
echo "  4) Co zmieniła konkretna osoba"
echo "  5) Aktualny status (co jest zmienione teraz)"
echo ""
read -p "Wybierz [1/2/3/4/5]: " CHOICE

echo ""

case "$CHOICE" in
    1)
        echo -e "${BLUE}📋 Ostatnie 20 zmian:${NC}"
        echo ""
        git log --oneline --graph --decorate --all -20 --format="%C(yellow)%h%C(reset) %C(green)%ad%C(reset) %C(bold)%an%C(reset): %s" --date=format:'%d.%m %H:%M' 2>/dev/null
        ;;
    2)
        echo -e "${BLUE}📋 Zmiany z ostatniego tygodnia:${NC}"
        echo ""
        git log --since="7 days ago" --format="%C(yellow)%h%C(reset) %C(green)%ad%C(reset) %C(bold)%an%C(reset): %s" --date=format:'%d.%m %H:%M' 2>/dev/null
        if [ $? -ne 0 ] || [ -z "$(git log --since='7 days ago' --oneline 2>/dev/null)" ]; then
            echo -e "${YELLOW}Brak zmian w ostatnim tygodniu.${NC}"
        fi
        ;;
    3)
        echo -e "${BOLD}Wpisz ścieżkę do pliku (np. 05_Baza_Wiedzy/03_Brand_Strategy.md):${NC}"
        read -p "> " FILEPATH
        if [ -z "$FILEPATH" ]; then
            echo "Nie podano pliku."
        else
            echo ""
            echo -e "${BLUE}📋 Historia pliku: $FILEPATH${NC}"
            echo ""
            git log --follow --format="%C(yellow)%h%C(reset) %C(green)%ad%C(reset) %C(bold)%an%C(reset): %s" --date=format:'%d.%m %H:%M' -- "$FILEPATH" 2>/dev/null
            if [ $? -ne 0 ] || [ -z "$(git log --follow --oneline -- "$FILEPATH" 2>/dev/null)" ]; then
                echo -e "${YELLOW}Nie znaleziono historii dla tego pliku.${NC}"
                echo "Sprawdź czy ścieżka jest poprawna."
            fi
        fi
        ;;
    4)
        echo -e "${BOLD}Wpisz imię (np. Oskar lub Wiktoria):${NC}"
        read -p "> " AUTHOR_NAME
        if [ -z "$AUTHOR_NAME" ]; then
            echo "Nie podano imienia."
        else
            echo ""
            echo -e "${BLUE}📋 Zmiany od: $AUTHOR_NAME${NC}"
            echo ""
            git log --author="$AUTHOR_NAME" -20 --format="%C(yellow)%h%C(reset) %C(green)%ad%C(reset): %s" --date=format:'%d.%m %H:%M' 2>/dev/null
            if [ -z "$(git log --author="$AUTHOR_NAME" --oneline -1 2>/dev/null)" ]; then
                echo -e "${YELLOW}Brak zmian od: $AUTHOR_NAME${NC}"
                echo ""
                echo "Dostępni autorzy:"
                git log --format="%an" | sort -u
            fi
        fi
        ;;
    5)
        echo -e "${BLUE}📋 Aktualny status:${NC}"
        echo ""

        CHANGES=$(git status --porcelain 2>/dev/null)
        if [ -z "$CHANGES" ]; then
            echo -e "${GREEN}✓ Czysto — brak niezapisanych zmian.${NC}"
        else
            echo "$CHANGES" | while read -r line; do
                STATUS="${line:0:2}"
                FILE="${line:3}"
                case "$STATUS" in
                    "??") echo -e "  ${GREEN}+ NOWY:        $FILE${NC}" ;;
                    " M"|"M "|"MM") echo -e "  ${YELLOW}~ ZMIENIONY:   $FILE${NC}" ;;
                    " D"|"D ") echo -e "  ${RED}- USUNIĘTY:    $FILE${NC}" ;;
                    *) echo -e "  $STATUS $FILE" ;;
                esac
            done

            echo ""
            TOTAL=$(echo "$CHANGES" | wc -l | tr -d ' ')
            echo -e "${BOLD}Razem: $TOTAL plików do zapisania${NC}"
            echo "Uruchom WYSLIJ_ZMIANY aby je zapisać."
        fi
        ;;
    *)
        echo "Nieznana opcja. Wybierz 1-5."
        ;;
esac

echo ""
read -p "Naciśnij Enter aby zamknąć..."
