# My Note

### 1. Command to create repository and add collaborators

```bash
#!/bin/bash
REPO_NAME=$1
# List of collaborator usernames to add
COLLABORATORS=("GridsMicro" "DarumaKlang" "GridsWeb" "WebShardow")

# 1. Create Repository (Private)
gh repo create "$REPO_NAME" --private --confirm

# 2. Loop to add all collaborators
for user in "${COLLABORATORS[@]}"; do
  gh repo add-collaborator "$REPO_NAME" "$user" --permission push
done
```

---

### 2. Command to Clone Multiple Repositories at Once

If you want to pull all projects at once, you can use this script:

```bash
#!/bin/bash
# List of Repositories to Clone
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

# Loop to clone each one
for repo in "${REPOS[@]}"; do
    echo "Cloning $repo..."
    gh repo clone "GhostMicro/$repo"
done
```
*Note: Change `GhostMicro/` to your User or Organization name.*

---

### 3. Command to Push Multiple Repositories at Once

"The `gh` command bible" for easy memorization:

🛠️ Interesting `gh` commands summary:

```bash
gh auth login	## Login to GitHub (choose Browser or Token)
gh auth status	## Check which user is currently connected
gh auth refresh -s <scope>	## Request additional permissions (e.g., delete_repo or admin:org)
gh repo create <name>	## Create a new repository on Cloud immediately
gh repo list <user>	## View all repositories in that account
gh repo view <name>	## View repository details (use --web to open in browser)
gh repo delete <name>	## Permanently delete repository (Fast and Dangerous ⚠️)
gh repo add-collaborator <name> <user>	## Invite friends to collaborate with permissions
gh repo clone <name>        ## Download Repository for the first time
git pull origin main        ## Pull the latest code from GitHub
```

### 4. Automatic Data Sync (Ghost Sync)

To pull all organization work or update every repo on your machine to be current:

```bash
chmod +x sync_all.sh
./sync_all.sh    ## Update all systems locally to match GitHub (GhostMicro)
```

**What the system does:**
1. Checks all repositories on the Cloud.
2. **Clone**: If the repository is not on the machine, it downloads it immediately.
3. **Pull**: If it already exists, it pulls the latest version.

---

### 5. GhostMicro Conversation Log: 2026-01-05

**Project Status:** System reset (Git Reset) and bulk data recovery (Bulk Clone) successful 🚀

#### 📌 Main Events

**1. System Reset & Recovery (Git Factory Reset)**
- Removed `~/.gitconfig`, `~/.ssh` and cleared `.git` in all `GhostMicro` folders to eliminate account confusion.
- Standardized to **GridsMicro** system.
- Developed `bulk_clone.sh` script to pull back 15 repositories at once.

**2. Generator V2 Upgrade (Stage 3 & 4)**
- **Technical Logic**: Added support for **RFID RC522** (UID retrieval) and **PZEM-004T** (Power measurement).
- **Efficiency**: Optimized Arduino code to be **Non-blocking (Async)**, allowing WiFi/MQTT to run in the background without freezing.
- **Ecosystem**: Set up a **Library Hub** for searching and downloading necessary libraries.

**3. Starting Robot Project (Robot Phase 1)**
- Verified **Rover Robot** infrastructure and prepared control code (Reflex Layer).

#### 📑 Related Docs
- [GP-Node-Docs/docs/index.md](file:///media/devg/Micro-SV6/GitHub/GhostMicro/GP-Node-Docs/docs/index.md) - Welcome to GhostPass system.
- [GP-Node-Docs/docs/api-reference.md](file:///media/devg/Micro-SV6/GitHub/GhostMicro/GP-Node-Docs/docs/api-reference.md) - How to use Encode/Decode API.
- [Key-Genesis API](https://key-genesis.vercel.app/) - Licensing distribution system.
