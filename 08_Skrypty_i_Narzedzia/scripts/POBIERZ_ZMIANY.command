#!/bin/bash
# ============================================
# PIONA Studio — POBIERZ ZMIANY
# Pobiera najnowszą pracę zespołu z GitHub
# Użycie: kliknij dwukrotnie lub wpisz /pobierz_zmiany
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
    echo -e "${RED}BŁĄD: Nie mogę znaleźć folderu PIONA Studio${NC}"
    read -p "Naciśnij Enter aby zamknąć..."
    exit 1
fi

cd "$PROJECT_DIR"

echo ""
echo -e "${BOLD}╔══════════════════════════════════════╗${NC}"
echo -e "${BOLD}║   PIONA Studio — POBIERZ ZMIANY     ║${NC}"
echo -e "${BOLD}╚══════════════════════════════════════╝${NC}"
echo ""

# --- Weryfikacja ---
if ! command -v git &> /dev/null; then
    echo -e "${RED}BŁĄD: Git nie jest zainstalowany.${NC}"
    read -p "Naciśnij Enter aby zamknąć..."
    exit 1
fi

if [ ! -d ".git" ]; then
    echo -e "${RED}BŁĄD: Ten folder nie jest repozytorium Git.${NC}"
    read -p "Naciśnij Enter aby zamknąć..."
    exit 1
fi

REMOTE_URL=$(git remote get-url origin 2>/dev/null || echo "")
if [ -z "$REMOTE_URL" ]; then
    echo -e "${RED}BŁĄD: Brak połączenia z GitHub (remote 'origin').${NC}"
    echo "Skonfiguruj remote:"
    echo "  git remote add origin https://github.com/TWOJ-USERNAME/piona-studio.git"
    read -p "Naciśnij Enter aby zamknąć..."
    exit 1
fi

BRANCH=$(git branch --show-current 2>/dev/null || echo "main")

# --- Sprawdź czy masz niezapisane zmiany ---
LOCAL_CHANGES=$(git status --porcelain 2>/dev/null)
if [ -n "$LOCAL_CHANGES" ]; then
    echo -e "${YELLOW}⚠ Masz niezapisane lokalne zmiany!${NC}"
    echo ""
    CHANGE_COUNT=$(echo "$LOCAL_CHANGES" | wc -l | tr -d ' ')
    echo "  $CHANGE_COUNT plików zmienionych lokalnie."
    echo ""
    echo -e "${BOLD}Co chcesz zrobić?${NC}"
    echo "  1) Najpierw zapisz moje zmiany, potem pobierz (ZALECANE)"
    echo "  2) Schowaj moje zmiany tymczasowo i pobierz"
    echo "  3) Anuluj"
    echo ""
    read -p "Wybierz [1/2/3]: " CHOICE

    case "$CHOICE" in
        1)
            echo ""
            echo -e "${YELLOW}Uruchom najpierw WYSLIJ_ZMIANY, potem wróć tutaj.${NC}"
            read -p "Naciśnij Enter aby zamknąć..."
            exit 0
            ;;
        2)
            echo -e "${BLUE}📦 Chowam twoje zmiany tymczasowo (git stash)...${NC}"
            git stash push -m "Auto-stash przed pobraniem zmian $(date '+%Y-%m-%d %H:%M')"
            STASHED=true
            echo -e "${GREEN}✓ Zmiany schowane${NC}"
            ;;
        *)
            echo "Anulowano."
            read -p "Naciśnij Enter aby zamknąć..."
            exit 0
            ;;
    esac
else
    STASHED=false
fi

# --- Pobierz zmiany ---
echo ""
echo -e "${BLUE}☁ Łączę się z GitHub...${NC}"

if ! git fetch origin "$BRANCH" --quiet 2>/dev/null; then
    echo -e "${RED}⚠ Nie mogę połączyć się z GitHub.${NC}"
    echo "Sprawdź połączenie internetowe i spróbuj ponownie."

    # Przywróć stash jeśli był
    if [ "$STASHED" = true ]; then
        git stash pop --quiet 2>/dev/null
        echo -e "${GREEN}✓ Twoje lokalne zmiany przywrócone${NC}"
    fi

    read -p "Naciśnij Enter aby zamknąć..."
    exit 1
fi

# Sprawdź czy są nowe zmiany
LOCAL_HASH=$(git rev-parse "$BRANCH" 2>/dev/null)
REMOTE_HASH=$(git rev-parse "origin/$BRANCH" 2>/dev/null || echo "")

if [ "$LOCAL_HASH" = "$REMOTE_HASH" ]; then
    echo -e "${GREEN}✓ Wszystko aktualne — brak nowych zmian do pobrania.${NC}"

    if [ "$STASHED" = true ]; then
        echo -e "${BLUE}📦 Przywracam twoje lokalne zmiany...${NC}"
        git stash pop --quiet 2>/dev/null
        echo -e "${GREEN}✓ Przywrócono${NC}"
    fi

    echo ""
    read -p "Naciśnij Enter aby zamknąć..."
    exit 0
fi

# --- Pokaż co przychodzi ---
echo ""
echo -e "${BLUE}📋 Nowe zmiany od zespołu:${NC}"
echo ""

# Pokaż commity które zostaną pobrane
git log --oneline "$BRANCH".."origin/$BRANCH" 2>/dev/null | while read -r line; do
    echo -e "  ${GREEN}→ $line${NC}"
done
echo ""

# Pokaż zmienione pliki
echo -e "${BLUE}Zmienione pliki:${NC}"
git diff --stat "$BRANCH".."origin/$BRANCH" 2>/dev/null | head -20 | while read -r line; do
    echo "  $line"
done
echo ""

# --- Merguj zmiany ---
echo -e "${BLUE}🔄 Łączę zmiany...${NC}"

if git merge "origin/$BRANCH" --no-edit --quiet 2>/dev/null; then
    echo -e "${GREEN}✓ Zmiany zespołu pobrane i połączone!${NC}"
else
    echo ""
    echo -e "${RED}⚠ KONFLIKT przy łączeniu zmian!${NC}"
    echo ""
    echo "Pliki w konflikcie:"
    git diff --name-only --diff-filter=U 2>/dev/null | while read -r file; do
        echo -e "  ${RED}✗ $file${NC}"
    done
    echo ""
    echo -e "${YELLOW}Otwórz te pliki — Git oznaczył sporne fragmenty tak:${NC}"
    echo '  <<<<<<< TWOJA WERSJA'
    echo '  (twoje zmiany)'
    echo '  ======='
    echo '  (zmiany drugiej osoby)'
    echo '  >>>>>>> WERSJA ZESPOŁU'
    echo ""
    echo "Wybierz właściwą wersję, zapisz plik, i uruchom WYSLIJ_ZMIANY."

    if [ "$STASHED" = true ]; then
        echo ""
        echo -e "${YELLOW}UWAGA: Twoje lokalne zmiany są nadal schowane (stash).${NC}"
        echo "Po rozwiązaniu konfliktu uruchom: git stash pop"
    fi

    read -p "Naciśnij Enter aby zamknąć..."
    exit 1
fi

# --- Przywróć stash ---
if [ "$STASHED" = true ]; then
    echo -e "${BLUE}📦 Przywracam twoje lokalne zmiany...${NC}"
    if git stash pop --quiet 2>/dev/null; then
        echo -e "${GREEN}✓ Twoje lokalne zmiany przywrócone${NC}"
    else
        echo -e "${YELLOW}⚠ Konflikt przy przywracaniu twoich lokalnych zmian.${NC}"
        echo "Rozwiąż konflikty w plikach i uruchom WYSLIJ_ZMIANY."
    fi
fi

# --- Podsumowanie ---
echo ""
echo -e "${BOLD}══════════════════════════════════════${NC}"
echo -e "${GREEN}✓ GOTOWE! Masz najnowszą wersję.${NC}"
echo -e "  Czas: $(date '+%Y-%m-%d %H:%M:%S')"
echo -e "${BOLD}══════════════════════════════════════${NC}"
echo ""
read -p "Naciśnij Enter aby zamknąć..."
