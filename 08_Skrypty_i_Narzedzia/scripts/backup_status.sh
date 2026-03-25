#!/bin/bash

PROJECT_DIR="/Users/oskarmakarski/Desktop/AI/PIONA Studio"
PID_FILE="$PROJECT_DIR/.backup_monitor.pid"
BACKUP_DIR="$PROJECT_DIR/Backup"

echo "📊 STATUS BACKUPU"
echo "================"

if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    if ps -p $PID > /dev/null 2>&1; then
        echo "✅ Status: AKTYWNY (PID: $PID)"
    else
        echo "❌ Status: NIEAKTYWNY (stary PID file)"
        rm "$PID_FILE"
    fi
else
    echo "❌ Status: NIEAKTYWNY"
fi

if [ -d "$BACKUP_DIR" ]; then
    BACKUP_COUNT=$(find "$BACKUP_DIR" -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
    echo "📦 Backupów: $BACKUP_COUNT"
fi
