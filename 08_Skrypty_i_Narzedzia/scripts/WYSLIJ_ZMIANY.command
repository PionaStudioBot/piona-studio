#!/bin/bash
# ============================================
# PIONA Studio — WYŚLIJ ZMIANY
# Zapisuje twoją pracę i wysyła na GitHub
# Użycie: kliknij dwukrotnie lub wpisz /wyslij_zmiany
# ============================================

set -e

# --- Kolory ---
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
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
    echo -e "${RED}BŁĄD: Nie mogę znaleźć folderu PIONA Studio (.cursorrules nie istnieje)${NC}"
    echo "Upewnij się, że skrypt jest wewnątrz folderu PIONA Studio."
    read -p "Naciśnij Enter aby zamknąć..."
    exit 1
fi

cd "$PROJECT_DIR"

echo ""
echo -e "${BOLD}╔══════════════════════════════════════╗${NC}"
echo -e "${BOLD}║   PIONA Studio — WYŚLIJ ZMIANY      ║${NC}"
echo -e "${BOLD}╚══════════════════════════════════════╝${NC}"
echo ""

# --- Sprawdź czy Git jest zainstalowany ---
if ! command -v git &> /dev/null; then
    echo -e "${RED}BŁĄD: Git nie jest zainstalowany.${NC}"
    echo "Zainstaluj Git: https://git-scm.com/download/mac"
    read -p "Naciśnij Enter aby zamknąć..."
    exit 1
fi

# --- Sprawdź czy to repo Git ---
if [ ! -d ".git" ]; then
    echo -e "${RED}BŁĄD: Ten folder nie jest repozytorium Git.${NC}"
    echo "Uruchom najpierw: git init"
    read -p "Naciśnij Enter aby zamknąć..."
    exit 1
fi

# --- Sprawdź czy remote jest skonfigurowany ---
REMOTE_URL=$(git remote get-url origin 2>/dev/null || echo "")
if [ -z "$REMOTE_URL" ]; then
    echo -e "${YELLOW}⚠ UWAGA: Brak połączenia z GitHub (remote 'origin' nie istnieje).${NC}"
    echo ""
    echo "Zmiany zostaną zapisane LOKALNIE (commit), ale nie wysłane do chmury."
    echo "Aby skonfigurować GitHub, uruchom:"
    echo "  git remote add origin https://github.com/TWOJ-USERNAME/piona-studio.git"
    echo ""
    REMOTE_AVAILABLE=false
else
    REMOTE_AVAILABLE=true
fi

# --- Pokaż co się zmieniło ---
echo -e "${BLUE}📋 Sprawdzam zmiany...${NC}"
echo ""

CHANGES=$(git status --porcelain 2>/dev/null)
if [ -z "$CHANGES" ]; then
    echo -e "${GREEN}✓ Brak zmian do wysłania. Wszystko jest aktualne.${NC}"
    echo ""
    read -p "Naciśnij Enter aby zamknąć..."
    exit 0
fi

# Podsumowanie zmian
ADDED=$(echo "$CHANGES" | grep -c "^?" 2>/dev/null || echo "0")
MODIFIED=$(echo "$CHANGES" | grep -c "^ M\|^M " 2>/dev/null || echo "0")
DELETED=$(echo "$CHANGES" | grep -c "^ D\|^D " 2>/dev/null || echo "0")

echo -e "  ${GREEN}+ Nowe pliki:      ${ADDED}${NC}"
echo -e "  ${YELLOW}~ Zmodyfikowane:   ${MODIFIED}${NC}"
echo -e "  ${RED}- Usunięte:        ${DELETED}${NC}"
echo ""

# Pokaż listę zmienionych plików (max 20)
echo -e "${BLUE}Zmienione pliki:${NC}"
echo "$CHANGES" | head -20 | while read -r line; do
    STATUS="${line:0:2}"
    FILE="${line:3}"
    case "$STATUS" in
        "??") echo -e "  ${GREEN}+ $FILE${NC}" ;;
        " M"|"M "|"MM") echo -e "  ${YELLOW}~ $FILE${NC}" ;;
        " D"|"D ") echo -e "  ${RED}- $FILE${NC}" ;;
        *) echo -e "  $STATUS $FILE" ;;
    esac
done

TOTAL_CHANGES=$(echo "$CHANGES" | wc -l | tr -d ' ')
if [ "$TOTAL_CHANGES" -gt 20 ]; then
    echo -e "  ... i $(($TOTAL_CHANGES - 20)) więcej"
fi
echo ""

# --- Zapytaj o opis zmian ---
echo -e "${BOLD}Co zrobiłeś/aś? (krótki opis, np. 'Dodałem nowy SOP video'):${NC}"
read -p "> " COMMIT_MSG

if [ -z "$COMMIT_MSG" ]; then
    # Auto-generuj opis na podstawie daty i zmian
    COMMIT_MSG="Aktualizacja $(date '+%Y-%m-%d %H:%M') — $ADDED nowych, $MODIFIED zmienionych"
fi

# Dodaj autora do wiadomości
AUTHOR=$(git config user.name 2>/dev/null || echo "Zespół PIONA")
COMMIT_MSG="[$AUTHOR] $COMMIT_MSG"

# --- Dodaj wszystkie zmiany i commituj ---
echo ""
echo -e "${BLUE}💾 Zapisuję zmiany...${NC}"

git add -A
git commit -m "$COMMIT_MSG" --quiet

echo -e "${GREEN}✓ Zmiany zapisane lokalnie${NC}"

# --- Wyślij na GitHub (jeśli remote skonfigurowany) ---
if [ "$REMOTE_AVAILABLE" = true ]; then
    echo -e "${BLUE}☁ Wysyłam na GitHub...${NC}"

    # Pobierz aktualną nazwę brancha
    BRANCH=$(git branch --show-current 2>/dev/null || echo "main")

    # Najpierw pobierz zmiany z remote (jeśli są)
    if git fetch origin "$BRANCH" --quiet 2>/dev/null; then
        # Sprawdź czy jest coś do zmergowania
        LOCAL=$(git rev-parse "$BRANCH" 2>/dev/null)
        REMOTE=$(git rev-parse "origin/$BRANCH" 2>/dev/null || echo "")

        if [ -n "$REMOTE" ] && [ "$LOCAL" != "$REMOTE" ]; then
            echo -e "${YELLOW}↓ Pobieram zmiany od reszty zespołu...${NC}"

            if git merge "origin/$BRANCH" --no-edit --quiet 2>/dev/null; then
                echo -e "${GREEN}✓ Zmiany zespołu połączone automatycznie${NC}"
            else
                echo ""
                echo -e "${RED}⚠ KONFLIKT: Ty i ktoś inny edytowaliście ten sam fragment pliku.${NC}"
                echo -e "${YELLOW}Otwórz pliki oznaczone jako 'conflict' i wybierz właściwą wersję.${NC}"
                echo ""
                echo "Pliki w konflikcie:"
                git diff --name-only --diff-filter=U 2>/dev/null
                echo ""
                echo "Po rozwiązaniu konfliktu uruchom ten skrypt ponownie."
                read -p "Naciśnij Enter aby zamknąć..."
                exit 1
            fi
        fi
    fi

    # Push
    if git push origin "$BRANCH" --quiet 2>/dev/null; then
        echo -e "${GREEN}✓ Wysłano na GitHub${NC}"
    else
        echo -e "${RED}⚠ Nie udało się wysłać na GitHub.${NC}"
        echo "Zmiany są zapisane lokalnie. Sprawdź połączenie internetowe."
        echo "Możesz spróbować ponownie uruchamiając ten skrypt."
    fi
else
    echo -e "${YELLOW}⚠ Zmiany zapisane TYLKO lokalnie (brak połączenia z GitHub).${NC}"
fi

# --- Podsumowanie ---
echo ""
echo -e "${BOLD}══════════════════════════════════════${NC}"
echo -e "${GREEN}✓ GOTOWE!${NC}"
echo -e "  Commit: ${COMMIT_MSG}"
echo -e "  Czas:   $(date '+%Y-%m-%d %H:%M:%S')"
if [ "$REMOTE_AVAILABLE" = true ]; then
    echo -e "  Status: ${GREEN}Zapisano lokalnie + wysłano na GitHub${NC}"
else
    echo -e "  Status: ${YELLOW}Zapisano tylko lokalnie${NC}"
fi
echo -e "${BOLD}══════════════════════════════════════${NC}"
echo ""
read -p "Naciśnij Enter aby zamknąć..."
