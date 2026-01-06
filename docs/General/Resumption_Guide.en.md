# 🏁 GhostMicro: Resumption Guide (Memory Point) 💾✨

If you're returning after a long time, here is what you need to know to resume work immediately!

## 🚀 1. How to Wake up the System

1.  **Start the Brain (Python)**:
    - Go to: `/media/devg/Micro-SV6/GitHub/GhostMicro/micro-iot-ai-robot`
    - Run: `./venv/bin/python main.py` (Server will be on Port 8000)
2.  **Start the Console (Dashboard)**:
    - Go to: `/media/devg/Micro-SV6/GitHub/GhostMicro/micro-iot-ai-robot-console`
    - Run: `npm run dev` (Dashboard will be at http://localhost:3000)
3.  **Start Virtual Hardware (If no physical robot is available)**:
    - Run: `python simulate_hardware.py` to send simulated data to the Dashboard.

---

## 🏗️ 2. Current Architecture

- **The Brain**: Handles Logic, AI (Gemini), and OTA Updates.
- **The Console**: Holographic control panel and **Instinct Dashboard**.
- **Hardware (GHOST_SLOT)**: 40-pin connection standard (Ribbon Cable) for switching robot "bodies".

---

## 🎯 3. Your Next Steps

When you return, these are the most exciting upcoming missions:

### A. Physical Design (Engineering)
- Use external AI to design the **"Middle Layer Case"** (ESP32 Core enclosure) with a **40-pin Edge Connector**.
- Purchase components according to [**BOM_MASTER.md**](file:///media/devg/Micro-SV6/GitHub/GhostMicro/micro-iot-ai-robot-hardware/bom/BOM_MASTER.md) to begin assembling **The Rover (Car)** as the first unit.

### B. AI & Instinct (Brain Work)
- Try training simple TFLite models (e.g., fall detection) and use `instinct_converter.py` to deploy to the ESP32.
- Test brainwave visualization on the **Instinct HUD**.

### C. Advanced Navigation (Next Phase)
- Begin **Phase 8: Autonomous Navigation** (AI-guided camera navigation).

---
*Recorded on: 2026-01-04 // GhostMicro Intelligence Group*
