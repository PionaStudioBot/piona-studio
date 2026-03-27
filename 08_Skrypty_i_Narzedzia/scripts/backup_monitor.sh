#!/bin/bash

# Automatyczny backup plików projektu (event-based z fswatch)
# Reaguje natychmiast na zmiany, zero obciążenia CPU gdy idle
# v2.0 — obsługuje .md .html .css .js .py + zachowuje strukturę katalogów

# Dodaj Homebrew do PATH
export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"

PROJECT_DIR="/Users/oskarmakarski/Desktop/AI/PIONA Studio"
BACKUP_DIR="$PROJECT_DIR/Backup/FileSnapshots"
RETENTION_DAYS=14
MAX_BACKUPS_PER_FILE=10

# Sprawdź czy fswatch jest zainstalowany
if ! command -v fswatch &> /dev/null; then
    echo "❌ fswatch nie jest zainstalowany. Zainstaluj: brew install fswatch"
    exit 1
fi

# Utwórz folder Backup jeśli nie istnieje
mkdir -p "$BACKUP_DIR"

backup_file() {
    local file="$1"
    
    # Pomiń puste pliki i nieistniejące
    if [ ! -f "$file" ] || [ ! -s "$file" ]; then
        return
    fi

    # Oblicz ścieżkę relatywną do projektu
    local rel_path="${file#$PROJECT_DIR/}"
    
    # Stwórz strukturę katalogów zachowującą oryginalną lokalizację
    # np. 05_Baza_Wiedzy/plik.md → Backup/FileSnapshots/05_Baza_Wiedzy/
    local rel_dir=$(dirname "$rel_path")
    local filename=$(basename "$file")
    local date=$(date +%Y-%m-%d_%H-%M-%S)
    
    local target_dir="$BACKUP_DIR/$rel_dir"
    mkdir -p "$target_dir"
    
    local backup_name="${date}_${filename}"
    
    cp "$file" "$target_dir/$backup_name"
    echo "[$(date +%Y-%m-%d\ %H:%M:%S)] Backup: $rel_path → $rel_dir/$backup_name"
    
    # Per-file rotation: zachowaj ostatnich MAX_BACKUPS_PER_FILE kopii tego pliku
    local existing=($(ls -t "$target_dir"/*_"$filename" 2>/dev/null))
    if [ ${#existing[@]} -gt $MAX_BACKUPS_PER_FILE ]; then
        local to_delete=("${existing[@]:$MAX_BACKUPS_PER_FILE}")
        for old in "${to_delete[@]}"; do
            rm "$old"
            echo "[$(date +%Y-%m-%d\ %H:%M:%S)] Rotacja: usunięto $(basename "$old")"
        done
    fi
}

cleanup_old_backups() {
    local deleted=$(find "$BACKUP_DIR" -type f -mtime +$RETENTION_DAYS -delete -print 2>/dev/null | wc -l | tr -d ' ')
    if [ "$deleted" -gt 0 ]; then
        echo "[$(date +%Y-%m-%d\ %H:%M:%S)] Cleanup: usunięto $deleted starych backupów (>$RETENTION_DAYS dni)"
    fi
    
    # Usuń puste katalogi po czyszczeniu
    find "$BACKUP_DIR" -type d -empty -delete 2>/dev/null
}

echo "🔄 Backup monitor v2.0 uruchomiony (fswatch)"
echo "   Monitorowane typy: .md .html .css .js .py"
echo "   Retencja: ${RETENTION_DAYS} dni, max ${MAX_BACKUPS_PER_FILE} kopii/plik"
echo "---"

# Czyszczenie przy starcie
cleanup_old_backups

# Harmonogram czyszczenia (co 24h w tle)
(while true; do sleep 86400; cleanup_old_backups; done) &
CLEANUP_PID=$!

trap "kill $CLEANUP_PID 2>/dev/null; exit" SIGINT SIGTERM

# Główna pętla — monitoruj kluczowe typy plików
fswatch -0 -r \
    --include='\.(md|html|css|js|py)$' \
    --exclude='.*' \
    "$PROJECT_DIR" | while read -d "" file; do
    # Wyklucz foldery systemowe i backupy
    if [[ "$file" != *"/Backup/"* ]] && \
       [[ "$file" != *"/.git/"* ]] && \
       [[ "$file" != *"/.agent/"* ]] && \
       [[ "$file" != *"/.claude/"* ]] && \
       [[ "$file" != *"/.gemini/"* ]] && \
       [[ "$file" != *"/node_modules/"* ]] && \
       [[ "$file" != *"/__pycache__/"* ]] && \
       [[ "$file" != *"/pdf_venv/"* ]]; then
        backup_file "$file"
    fi
done
