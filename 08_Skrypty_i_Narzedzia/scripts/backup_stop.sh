#!/bin/bash

PROJECT_DIR="/Users/oskarmakarski/Desktop/AI/PIONA Studio"
PID_FILE="$PROJECT_DIR/.backup_monitor.pid"

if [ ! -f "$PID_FILE" ]; then
    echo "❌ Backup nie działa"
    exit 1
fi

PID=$(cat "$PID_FILE")

if ps -p $PID > /dev/null 2>&1; then
    pkill -P $PID 2>/dev/null
    kill $PID 2>/dev/null
    rm "$PID_FILE"
    echo "✅ Backup zatrzymany"
else
    rm "$PID_FILE"
    echo "⚠️  Backup nie był aktywny (PID file wyczyszczony)"
fi
