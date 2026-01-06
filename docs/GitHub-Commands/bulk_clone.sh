#!/bin/bash
REPOS=(
    "ghost-instinct-factory"
    "GhostPassV8"
    "GhostPassV8-Doc"
    "GP-Node-Docs"
    "key-genesis"
    "micro-iot-ai-robot"
    "micro-iot-ai-robot-console"
    "micro-iot-ai-robot-docs"
    "micro-iot-ai-robot-firmware"
    "micro-iot-ai-robot-hardware"
    "micro-iot-dashboard"
    "micro-iot-gen"
    "micro-iot-gen-docs"
    "micro-iot-library"
    "micro-iot-page"
)

# วนลูป Clone ทีละอัน
for repo in "${REPOS[@]}"; do
    echo "Cloning $repo..."
    gh repo clone "GhostMicro/$repo"
done
