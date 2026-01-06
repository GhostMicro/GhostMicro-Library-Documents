#!/bin/bash

# รายชื่อเพื่อนๆ ที่จะเชิญเป็นทีมงาน
COLLABORATORS=("GridsMicro" "DarumaKlang" "GridsWeb" "WebShardow")
MY_ORG="GhostMicro"

push_to_ghostmicro() {
    local dir=$1
    local repo_name=$2
    
    echo "------------------------------------------------"
    echo "🚀 Preparing: $ORG/$repo_name from directory: $dir"
    cd "/media/devg/Micro-SV6/GitHub/GhostMicro/$dir" || return
    
    # 1. จัดการเรื่อง Git Local
    if [ ! -d ".git" ]; then
        git init
        git add .
        git commit -m "GhostMicro IoT Dashboard - Initial Theme Release"
    fi

    # 2. สร้าง Repository บน GitHub (GhostMicro)
    echo "📦 Creating repository on GitHub..."
    gh repo create "$repo_name" --private -y 2>/dev/null || echo "Repo already exists on GitHub."

    # 3. จัดการ Remote (ใช้ HTTPS ตามที่ Login ไว้เพื่อความง่าย)
    git remote remove origin 2>/dev/null
    git remote add origin "https://github.com/$MY_ORG/$repo_name.git"

    # 4. เชิญทีมงานเข้าร่วมโปรเจกต์
    for user in "${COLLABORATORS[@]}"; do
        echo "👥 Inviting $user..."
        # ใช้ gh api เพื่อความแน่นอนในการกำหนดสิทธิ์ push
        gh api -X PUT "repos/$MY_ORG/$repo_name/collaborators/$user" -f permission=push >/dev/null 2>&1
    done

    # 5. พุชโค้ดขึ้นสู่ Main Branch
    echo "📤 Pushing code to GitHub..."
    git branch -M main
    git push -u origin main
    
    cd ..
}

# เริ่มกระบวนการพุชทั้งหมด 8 ตัว
push_to_ghostmicro "micro-iot-dashboard" "micro-iot-dashboard"

for i in {1..7}; do
    push_to_ghostmicro "micro-iot-dashboard-$i" "micro-iot-dashboard-$i"
done

echo "------------------------------------------------"
echo "✅ SUCCESS: All 8 dashboards pushed to GhostMicro account!"
