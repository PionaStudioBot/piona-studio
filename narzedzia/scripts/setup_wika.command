#!/bin/bash
# ============================================================
# PIONA Studio — Setup MacBooka Wiktorii
# Double-click żeby uruchomić (plik .command na macOS)
# ============================================================
#
# UWAGA DLA OSKARA:
# Przy pierwszym uruchomieniu terminal zapyta o hasło GitHub.
# Wpisz Personal Access Token (PAT) bota PionaStudioBot.
# macOS Keychain zapamięta to na stałe — następne razy bez pytania.
# ============================================================

REPO_URL="https://github.com/PionaStudioBot/piona-studio.git"
TARGET_DIR="$HOME/Desktop/AI/PIONA-AI"
BRANCH="wika"

echo "============================================"
echo "  PIONA Studio — Setup Wiktorii"
echo "============================================"
echo ""

# Krok 1 — Utwórz folder Desktop/AI/ jeśli nie istnieje
echo "→ Tworzę folder Desktop/AI/..."
mkdir -p "$HOME/Desktop/AI"

# Krok 2 — Sklonuj lub zaktualizuj repo
if [ -d "$TARGET_DIR/.git" ]; then
    echo "→ Repo już istnieje — aktualizuję do najnowszej wersji..."
    cd "$TARGET_DIR"
    git fetch origin 2>&1
    git checkout "$BRANCH" 2>&1
    git pull origin "$BRANCH" 2>&1
else
    echo "→ Klonuję repozytorium PIONA Studio..."
    echo "   (przy pytaniu o hasło wpisz token GitHub — zostanie zapamiętany)"
    git clone "$REPO_URL" "$TARGET_DIR" 2>&1
    cd "$TARGET_DIR"
    git checkout "$BRANCH" 2>&1
fi

if [ $? -ne 0 ]; then
    echo ""
    echo "❌ Coś poszło nie tak. Skopiuj błąd powyżej i wyślij Oskarowi."
    read -p "Naciśnij Enter żeby zamknąć..."
    exit 1
fi

# Krok 3 — Skonfiguruj git
cd "$TARGET_DIR"
git config user.name "Wiktoria"
git config user.email "kontakt.piona@gmail.com"

# Krok 4 — Włącz macOS Keychain dla przechowywania credentials
git config credential.helper osxkeychain

echo ""
echo "============================================"
echo "  ✅ GOTOWE!"
echo "============================================"
echo ""
echo "  Branch:    wika"
echo "  Folder:    ~/Desktop/AI/PIONA-AI"
echo ""
echo "  Następny krok:"
echo "  Otwórz aplikację Cowork i zmień folder"
echo "  workspace na: Desktop/AI/PIONA-AI"
echo ""
echo "============================================"
read -p "Naciśnij Enter żeby zamknąć..."
