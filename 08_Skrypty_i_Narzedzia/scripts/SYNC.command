#!/bin/bash
# PIONA Studio — SYNC
# Kliknij dwukrotnie aby zsynchronizowac

cd "$(dirname "$0")/../.."
PROJECT_DIR="$(pwd)"

if [ ! -f "$PROJECT_DIR/.cursorrules" ]; then
  echo "BLAD: Nie moge znalezc folderu PIONA Studio"
  read -p "Nacisnij Enter aby zamknac..."
  exit 1
fi

python3 "$PROJECT_DIR/08_Skrypty_i_Narzedzia/scripts/piona_sync.py"
read -p "Nacisnij Enter aby zamknac..."
