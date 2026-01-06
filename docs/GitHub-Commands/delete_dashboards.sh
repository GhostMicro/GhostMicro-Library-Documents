#!/bin/bash

MY_USER="GridsMicro"
REPOS=("micro-iot-dashboard" "micro-iot-dashboard-1" "micro-iot-dashboard-2" "micro-iot-dashboard-3" "micro-iot-dashboard-4" "micro-iot-dashboard-5" "micro-iot-dashboard-6" "micro-iot-dashboard-7")

for repo in "${REPOS[@]}"; do
    echo "Deleting $MY_USER/$repo..."
    gh repo delete "$MY_USER/$repo" --yes
done

echo "Done. All 8 repositories have been removed from $MY_USER."
