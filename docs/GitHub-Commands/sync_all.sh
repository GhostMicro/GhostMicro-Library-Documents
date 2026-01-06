#!/bin/bash

# 🧠 GhostMicro - Sync All Repositories Script
# Script สำหรับ Clone หรือ Pull ทุก Repository ในบัญชี GhostMicro

ORG="GhostMicro"
TARGET_DIR="/media/devg/Micro-SV6/GitHub/GhostMicro"

echo "🔄 Starting GhostMicro System Sync..."
echo "📍 Location: $TARGET_DIR"

# 1. ดึงรายชื่อ Repo ทั้งหมดจาก GitHub
REPOS=$(gh repo list $ORG --limit 1000 --json name -q '.[].name')

for REPO in $REPOS; do
    echo "------------------------------------------------"
    if [ -d "$TARGET_DIR/$REPO" ]; then
        # กรณีมีโฟลเดอร์อยู่แล้ว -> ทำการ Pull อัปเดต
        echo "📂 Updating: $REPO"
        cd "$TARGET_DIR/$REPO" || continue
        git pull origin main || git pull origin master
        cd "$TARGET_DIR" || continue
    else
        # กรณีไม่มีโฟลเดอร์ -> ทำการ Clone ลงมาใหม่
        echo "📥 Cloning: $REPO"
        gh repo clone "$ORG/$REPO" "$TARGET_DIR/$REPO"
    fi
done

echo "------------------------------------------------"
echo "✅ SYNC COMPLETED: All systems are up to date."
