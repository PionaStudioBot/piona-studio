#!/bin/bash

PROJECT_DIR="/Users/oskarmakarski/Desktop/AI/PIONA Studio"
PID_FILE="$PROJECT_DIR/.backup_monitor.pid"
SCRIPT="$PROJECT_DIR/scripts/backup_monitor.sh"
LOG_FILE="$PROJECT_DIR/.backup_monitor.log"

if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    if ps -p $PID > /dev/null 2>&1; then
        echo "❌ Backup już działa (PID: $PID)"
        exit 1
    else
        rm "$PID_FILE"
    fi
fi

# Uruchom w tle
nohup "$SCRIPT" >> "$LOG_FILE" 2>&1 &
PID=$!
echo $PID > "$PID_FILE"

echo "✅ Backup uruchomiony (PID: $PID)"
echo "📝 Logi: $LOG_FILE"
