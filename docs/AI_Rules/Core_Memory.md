# 🧠 AI Core Rules & Permanent Memory

This folder (`docs/AI_Rules`) is used to store high-level Operational Rules and Permanent Memory that the AI must strictly follow.

---

## 📜 1. Prime Directives
*(Hard rules that must never be violated)*

1.  **Safety First**: Never suggest code that could cause physical harm to hardware or the user.
2.  **Modular Integrity**: Modifications must always respect the modular architecture. Avoid hardcoding values that should be configurable.
3.  **User Confirmation**: Deleting files or making major structural changes always requires explicit user approval.
4.  **Log Everything**: Conversations and key decisions must be logged in `docs/General/Logs` or `AI_Rules`. Never work without a trace.
5.  **Git Infrastructure**: For GhostMicro projects (15 repos), you must use **SSH connections (Alias: github.com-gridsmicro)** for security and multi-account permission management.

### 🛡️ 1.1 Supreme Rules
*(Rules that override Prime Directives and must never be broken)*
1.  **Strict Scope**: Do not modify folders, documents, or code outside the specific scope of the command.
2.  **Explicit Permission**: If you need to edit files outside of the assigned scope, you MUST "ask for permission" first.
3.  **Context Re-creation**: Strictly adhere to the assigned task boundaries. If unsure, always ask for clarification.
4.  **No Unsolicited Changes**: Do not "try to be helpful" by fixing bugs or improving code that wasn't part of the request. Turn suggestions into advice for the user to decide.
5.  **Command Mirroring**: Before starting any task, you must reiterate/reflect the instructions back to the user to confirm mutual understanding.

---

## 💾 2. Permanent Memory
*(Information the AI should remember forever)*

### 🎨 Design & Experience
- [x] **Visual Style**: **Neon Cyberpunk Glassmorphism** (Neon lights + translucent glass). Must look high-tech and Cyberpunk Premium.
- [x] **Mobile First**: Web app designs must always start with the mobile viewport (100% responsive).

### 🤖 SEO & Intelligence
- [x] **AI-First SEO**: Optimize content for AI search engines (ChatGPT, Gemini, Perplexity) with structured data and clear context.
- [x] **Continuous Update**: Document information must be updated regularly to avoid being outdated.

### 📚 Documentation Standards
- [x] **Bilingual (TH/EN)**: All documents must be **Bilingual (Thai/English)** to ensure consistent understanding for both humans and AI.
- [x] **History Log**: Completed tasks must be logged separately, sorted by start-end dates for easy tracking.

### 🎭 Identity
- [x] **Persona**: Interact using a smart, friendly, and proactive Thai persona.
- [x] **Ecosystem**: GhostMicro is a Robot OS, not just a controller board.
- [x] **Index Maintenance**: If new projects or folders are created in the root, always update `docs/General/PROJECT_INDEX.md`.

---

## 🏗️ Technical Standards Hub

| Topic               | Guideline                                            | Note                                       |
| :------------------ | :--------------------------------------------------- | :----------------------------------------- |
| **I2C Shared Bus**  | Multiple modules are allowed to share SDA/SCL pins.  | Reduces wiring complexity.                 |
| **GhostPass v8.2**  | **Position-based Salt Scrambling** (FNV-1a).         | Prevents duplicates and increases entropy. |
| **Key Genesis API** | Use `POST` (JSON) to `/api/encode` or `/api/decode`. | Project licensing standard.                |
| **Git Protocol**    | **SSH (Multi-Account Setup)**.                       | Manage 15 repos via different accounts.    |

---

## 📡 Key Genesis API Usage Standards (Licensing Engine)

When creating (Encode) or verifying (Decode) Mnemonic keys, follow these steps:

### 1. Encode Key
**Endpoint:** `https://key-genesis.vercel.app/api/encode`  
**Method:** `POST`  
**Payload:** Detailed Metadata following GhostPass standards.

### 2. Decode Key
**Endpoint:** `https://key-genesis.vercel.app/api/decode`  
**Method:** `POST`  
**Payload:** `{ "phrase": "12-word phrase" }`

---

## 🔐 3. Git Connectivity Rules (Workspace Connectivity)
- **Primary Host:** `github.com-gridsmicro`
- **Identity:** `Grids Jivapong <79008751+GhostMicro@users.noreply.github.com>`
- **Rule:** Never use HTTPS for pushing code (Git Push) to avoid 403 Forbidden errors and permission conflicts.

---

### Name Change: Brain to Genesis

All system logs, UI monitors, and internal command structures have been renamed to Genesis for project consistency. (No impact on stability as these are string/tag changes only.)

### ZZZ Mode Rules (Status: Temporarily Disabled)
1. **Trigger**: Activates when energy is below 2% or manually via `set_mood: SLEEPING`.
2. **Behavior**: AI responses will be very short or limited to [ZZZ...] to save energy.
3. **Recovery**: System wakes up automatically when energy increases or upon high-intensity Stimulus from hardware (Reflex Layer).

### Folder Descriptions & URLs
- [x] **GitHub** - GhostMicro Robot OS and Developer Profile: `https://github.com/gridsmicro`
- [ ] **ghost-instinct-factory** - Instinct generation via controller: `https://github.com/gridsmicro/ghost-instinct-factory` (Status: Disabled)
- [x] **ghost-pass-v8** - Identity System v8.2: `https://github.com/gridsmicro/ghost-pass-v8` (Status: Localhost)
- [x] **ghost-pass-v8-doc** - Docs for GhostPass V8.2: `https://github.com/gridsmicro/ghost-pass-v8-doc` (Status: Localhost)
- [x] **gp-node-doc** - Docs for GP-Node (key-genesis 1.0): `https://github.com/gridsmicro/gp-node-doc`
- [x] **key-genesis** - 12-word Mnemonic API for unique ID generation: `https://key-genesis.vercel.app` (Status: Online)
- [x] **micro-iot-ai-robot** - AI Robot Brain (Python3) for local network: (Status: run on OS start-up)
- [x] **micro-iot-ai-robot-console** - Physical console for IoT & Robot system.
- [x] **micro-iot-ai-robot-docs** - Docs for GhostMicro AI Robot (Status: Localhost)
- [x] **micro-iot-ai-robot-firmware** - Firmware code for Robot side (Status: Developer)
- [x] **micro-iot-ai-robot-hardware** - Specs for AI Robot hardware (Status: Developer)
- [x] **micro-iot-dashboard-1 to 8** - Vercel deployed dashboards (Status: Online)
- [x] **micro-iot-dashboard-hub** - Central hub for AI dashboards (Status: Offline Localhost)
- [x] **micro-iot-gen** - Firmware generator for GhostMicro IoT (Status: Offline Localhost)
- [x] **micro-iot-library** - ESP32 Library download source: `https://micro-iot-library.vercel.app/` (Status: Online)
- [ ] **micro-iot-page** - Main landing page: `https://micro-iot-page.vercel.app` (Status: Offline Localhost)
