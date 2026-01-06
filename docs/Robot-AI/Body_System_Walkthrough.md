# GhostMicro Walkthrough: 4-Body System & Neural Security

This document outlines the technical architecture for the expanded 4-body system and the newly implemented security layer.

## 1. Modular Body Identities (Reflex Layer)
The system now supports four distinct hardware chassis, identified via an analog voltage divider on the ESP32 Core.

| Body Type     | Target Voltage | Characteristics                                       |
| :------------ | :------------- | :---------------------------------------------------- |
| **ROVER**     | 1.0V           | 4WD ground exploration, stability, precision.         |
| **DRONE**     | 2.0V           | Quad-motor aerial flight, agility, verticality.       |
| **SUBMARINE** | 2.5V           | Deep-sea research, pressure resistance, acoustics.    |
| **HUMANOID**  | 3.3V           | Bipedal research, social interaction, complex joints. |

### AI Persona Adaptation
The Gemini Brain (Soul) dynamically updates its system instructions when a new body is detected. This changes the robot's tone, expertise, and interaction style to match its physical form.

## 2. GHOST_SIMULATOR (Emulation Layer)
Access: `/simulator`

The simulator allows for manual hardware verification without physical nodes:
- **Manual Switching**: Trigger body transitions to verify AI behavior.
- **Node Management**: Toggle connection status to test dashboard failsafes.
- **Data Payload Emulation**: Real-time JSON preview of the data transmission schema.

## 3. Neural Handshake Security
To prevent unauthorized control, a shared secret handshake is enforced across all Socket.IO connections.

- **Shared Secret**: `GHOST_BRAIN_99` (Configurable via `.env`).
- **Protocol**: Connections without the correct token in the `auth` handshake are rejected by the Python Brain.
- **Monitoring**: Unauthorized attempts are flagged in the Neural Log as `SECURITY BREACH`.

---
*Last updated: 2026-01-04*
