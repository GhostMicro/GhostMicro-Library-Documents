# 🛰️ Neural Mapping System

> *"Enabling robots to perceive the world through frequency and visualize it at a conscious level."*

The **Neural Mapping** system in Stage 4 transforms raw distance readings into clear spatial visualizations that both AI and humans can easily understand.

---

## 🛠️ System Architecture

The system operates across three primary layers:

1.  **Reflex Layer (Physical Scan)**:
    *   The ESP32 activates **Mapping Mode** (50Hz).
    *   Transmits `DISTANCE_SCAN` data via Socket.IO to the Core Server.
2.  **Soul Layer (Processing & Safety)**:
    *   `main.py` acts as a data relay.
    *   The **Autonomous Brake** monitors obstacles in real-time to prevent collisions during mapping.
3.  **Visualization Layer (Neural Radar UI)**:
    *   A Glassmorphism-styled dashboard.
    *   Displays a real-time **Radar Sweep** on an HTML Canvas.

---

## 🖥️ Visualization Interface (Neural Radar Dashboard)

The mapping interface is accessible at:
`http://localhost:8000/static/index.html`

### Key Features:
*   **Real-time Radar**: Displays obstacle impact points (Point Cloud) with a 5-second persistence.
*   **Dynamic Scanning**: Scan frequency adjusts based on the active operating mode.
*   **System Awareness**: Displays energy levels and AI mood concurrently.
*   **Control Hub**: Instantly toggle Mapping Mode via the dashboard.

---

## 🚀 Future Roadmap

*   **Occupancy Grid**: Simulating maps in a grid format to remember permanent obstacle positions.
*   **Pathfinding (A*)**: Calculating the safest path while avoiding detected obstacles.
*   **SLAM-Lite**: Self-localization system within the generated map.

---
*Developed by GhostMicro Engineering Team*
