#!/bin/bash

# รายชื่อเพื่อนๆ
COLLABORATORS=("DarumaKlang" "GridsWeb" "WebShardow")
# บัญชีที่พุชขึ้น (เนื่องจาก gh login เป็น GridsMicro แต่ SSH เป็น GhostMicro)
# เพื่อให้สร้าง Repo ได้เลย จะสร้างใน GridsMicro ก่อน
MY_USER="GridsMicro"

push_repo() {
    local dir=$1
    local repo_name=$2
    
    echo "------------------------------------------------"
    echo "Processing $dir..."
    cd "/media/devg/Micro-SV6/GitHub/GhostMicro/$dir" || return
    
    # 1. Initialize Git if needed
    if [ ! -d ".git" ]; then
        git init
        git add .
        git commit -m "Initial commit from GhostMicro Dashboard Suite"
    fi

    # 2. Create Repository on GitHub (GridsMicro)
    echo "Creating repo $MY_USER/$repo_name..."
    gh repo create "$repo_name" --private -y 2>/dev/null || echo "Repo already exists."

    # 3. Add Collaborators via API
    for user in "${COLLABORATORS[@]}"; do
        echo "Adding $user as collaborator..."
        gh api -X PUT "repos/$MY_USER/$repo_name/collaborators/$user" -f permission=push >/dev/null 2>&1
    done

    # 4. Set Remote (ใช้ HTTPS เพื่อใช้ Token ของ GridsMicro ที่ Login ไว้)
    # หรือใช้ SSH ถ้ามั่นใจว่า Key ตรง แต่เคสนี้ Token กับ SSH คนละบัญชีกัน
    # ผมจะใช้ HTTPS remote เพื่อให้ Git ใช้ Token ที่ gh CLI มีอยู่
    git remote remove origin 2>/dev/null
    git remote add origin "https://github.com/$MY_USER/$repo_name.git"
    
    # 5. Push
    git branch -M main
    git push -u origin main
    
    cd ..
}

# รันสำหรับทุก Dashboard
push_repo "micro-iot-dashboard" "micro-iot-dashboard"
for i in {1..7}; do
    push_repo "micro-iot-dashboard-$i" "micro-iot-dashboard-$i"
done
