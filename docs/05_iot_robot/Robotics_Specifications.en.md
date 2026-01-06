# 🤖 Robotics Specifications & Features

> *"A Robot is an Iot that moves and possesses Spatial Awareness."*

In the **GhostMicro** universe, we explicitly decouple **IoT (Infrastructure)** and **Robotics (Mechanics & AI)** to ensure developmental clarity, while maintaining unified control under the IoT ecosystem.

---

## ⚡ 1. IoT vs. Robotics Comparison

| Feature             | General IoT Node (e.g., Smart Farm) | Genesis Robot (e.g., Rover)           |
| :------------------ | :---------------------------------- | :------------------------------------ |
| **Telemetry**       | Low (Updates every 1-60s)           | High (Stream 50-100Hz)                |
| **Logic Layer**     | Passive (Periodic updates/commands) | Active (Reflex & Autonomous Mode)     |
| **Spatial Sensing** | None (Environmental values)         | Yes (Lidar/Ultrasonic Mapping & Grid) |
| **Safety**          | Software-based                      | Hardware Override (ReflexCore)        |

---

## 🦾 2. Robot-Specific Core Features

### A. Reflex & Instinct
Every robot must possess a **Reflex** layer running at the hardware level for immediate safety (Emergency Brake) and an **Instinct** system for reporting physical sensations (e.g., SIGNAL_JITTER).

### B. Neural Mapping
The ability to transform frequency data (Ultrasonic/Lidar) into an **Occupancy Grid** (Spatial Table). This allows the AI to "remember" permanent obstacles even when sensors are pointing elsewhere.

### C. Kinetic Authority
Managed via the **robot_command** protocol, supporting both manual control and delegated **Autonomous Loop** authority (AI self-driving).

---

## 🏗️ 3. Decoupled Development Workflow

1.  **Robot-specific Code**: Located in `micro-iot-ai-robot` and `micro-iot-ai-robot-firmware`.
2.  **IoT-specific Code**: Located in Dashboards, Page Generator, and Licensing (`key-genesis`).
3.  **Bridge**: Connected via **Socket.IO** and unified **Identity Tokens**, ensuring the central IoT system retains permission-based control.

---
*Developed by GhostMicro Robotics Division*
