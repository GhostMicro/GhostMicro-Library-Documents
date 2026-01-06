#!/bin/bash

COLLABORATORS=("GridsMicro" "DarumaKlang" "GridsWeb" "WebShardow")
ORG="GhostMicro"

push_repo() {
    local dir=$1
    local repo_name=$2
    
    echo "Processing $dir -> $ORG/$repo_name"
    cd "/media/devg/Micro-SV6/GitHub/GhostMicro/$dir" || return
    
    # Initialize git if not already
    if [ ! -d ".git" ]; then
        git init
        git add .
        git commit -m "Initial commit"
    fi

    # Create repo on GitHub (skip if exists)
    gh repo create "$ORG/$repo_name" --private --confirm 2>/dev/null || echo "Repo $repo_name might already exist."

    # Update remote
    git remote remove origin 2>/dev/null
    git remote add origin "git@github.com-gridsmicro:$ORG/$repo_name.git"

    # Add collaborators
    for user in "${COLLABORATORS[@]}"; do
        echo "Adding collaborator $user to $repo_name..."
        gh repo add-collaborator "$ORG/$repo_name" "$user" --permission push 2>/dev/null
    done

    # Push
    git branch -M main
    git push -u origin main
    
    cd ..
}

# Base dashboard
push_repo "micro-iot-dashboard" "micro-iot-dashboard"

# Numbered dashboards
for i in {1..7}; do
    push_repo "micro-iot-dashboard-$i" "micro-iot-dashboard-$i"
done
