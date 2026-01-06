# 🏗️ GhostMicro System Architecture & Layers

This document summarizes the **Folder Structure** by duty (Layers) and explains the **Operational Flow** (Data Pipeline) to visualize how the entire system works in practice.

---

## 🏛️ 1. Layer Breakdown

The system is divided into 5 main layers, from the lowest hardware level up to the highest AI level.

| Layer                                                      | Component Name                                            | Folder Path                                                 | Role & Responsibility                                                                                                                    | Technologies                                  |
| :--------------------------------------------------------- | :-------------------------------------------------------- | :---------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------- | :-------------------------------------------- |
| **L1: The Soul**<br>(Mind/Brain)                           | `micro-iot-ai-robot`                                      | `/micro-iot-ai-robot`                                       | **Central Decision Maker**<br>- Receives data from all nodes<br>- Processes moods<br>- High-level AI Agent decisions<br>- Memory storage | Python, FastAPI,<br>Socket.IO, Gemini         |
| **L2: The Interface**<br>(Communication/Display)           | `micro-iot-dashboard-hub`<br>`micro-iot-ai-robot-console` | `/micro-iot-dashboard-hub`<br>`/micro-iot-ai-robot-console` | **Human-Machine Interaction**<br>- Displays system status<br>- Accepts manual control commands<br>- Centralized hub access               | Next.js, React,<br>Tailwind, Socket.IO Client |
| **L3: The Nervous System**<br>(Networking/Network Library) | `micro-iot-library`<br>`GP-Node-Docs`                     | `/micro-iot-library`<br>`/GP-Node-Docs`                     | **Infrastructure & Drivers**<br>- Standard driver repository<br>- API & Protocol documentation<br>- Identity system (GhostPass)          | C++, Arduino Libs,<br>Documentation           |
| **L4: The Reflex**<br>(Spinal Cord/Firmware)               | `micro-iot-ai-robot-firmware`<br>(ReflexCore)             | `/micro-iot-ai-robot-firmware`<br>`/firmware-core`          | **Edge Computing & Safety**<br>- Reads physical sensors<br>- Emergency overrides (Reflex Override)<br>- Status heartbeats                | C++, ESP32,<br>Arduino Framework              |
| **L5: The Body**<br>(Physical Hardware)                    | `micro-iot-ai-robot-hardware`<br>Sensors / Actuators      | `/micro-iot-ai-robot-hardware`<br>(Physical)                | **Physical Action**<br>- Motors, sensors, water pumps<br>- Physical identity identification (Body ID)                                    | PCB, 3D Print,<br>Electronics                 |

---

## 🔄 2. Operational Flow

The operation is a **Closed Loop System** where data flows from the physical body to the soul and back into action.

### 🔵 The Genesis Loop

This diagram shows the sequence of data flow (Data Pipeline) during operation:

```mermaid
graph LR
    %% Styles
    classDef hardware fill:#f9f,stroke:#333,stroke-width:2px;
    classDef reflex fill:#bbf,stroke:#333,stroke-width:2px;
    classDef network fill:#dfd,stroke:#333,stroke-width:2px;
    classDef soul fill:#fdd,stroke:#333,stroke-width:4px;
    classDef action fill:#ffd,stroke:#333,stroke-width:2px;

    subgraph Phase 1: Sensation
        S1[Sensor Reads]:::hardware -->|Raw Analog/Digital| R1
        S2[Body ID Check]:::hardware -->|Voltage Pin 34| R2
    end

    subgraph Phase 2: Reflex & Instinct (Reflex + Instinct)
        R1[Reflex Analysis]:::reflex -->|Safe?| R3{Safety Check}
        R2[Identity Logic]:::reflex -->|Config Profile| R4[Telemetry Pack]
        I1[Instinct Monitoring]:::reflex -->|Signal/Thermal| R4
        R3 -- Yes --> R4
        R3 -- No (Danger) --> Override[STOP/ACT NOW!]:::action
    end

    subgraph Phase 3: Transmission
        R4 -->|JSON/Socket.IO| N1[Network Gateway]:::network
        N1 -->|Event: telemetry| C1
    end

    subgraph Phase 4: Cognition
        C1[Genesis Core]:::soul -->|Update Mood/Energy| C2{AI Decision}
        C2 -->|Routine| A1[Keep Monitoring]
        C2 -->|Stimulus| A2[Generate Action]
    end

    subgraph Phase 5: Action
        A2 -->|Event: command| N1
        N1 -->|Parse CMD| R5[Motor/Relay Ctrl]:::reflex
        R5 -->|Drive| M1[Actuators]:::hardware
    end

    %% Link Back
    M1 -.->|Feedback| S1
```

---

## 📝 3. Deep Dive into Pipeline Steps

### 1. Sensation
*   **Location:** `Layer 5 (Physical)` & `Layer 4 (Firmware)`
*   **Action:** Physical sensors (e.g., Temp, Distance, Batt) read raw values.
*   **Check:** Reads ID Pin 34 to confirm if it's a "Robot" or "Smart Farm Node".

### 2. Reflex & Instinct (Edge Intelligence)
*   **Location:** `Layer 4 (ReflexCore.cpp)`
*   **Action:**
    *   **Reflex**: If critical danger exists -> **Reflex Override** cuts power immediately.
    *   **Instinct**: Monitors hardware health (e.g., WiFi RSSI, Thermal) and sends "feelings" (Instinct Report) to the Soul to adjust Mood/Behavior.

### 3. Transmission
*   **Location:** `Layer 3 (Network Library)`
*   **Action:** Sends JSON packets via Socket.IO (WiFi) to the server.
*   **Protocol:** `{"battery": 85, "reflex": "NONE", "id": "ROVER_MK1"}`

### 4. Cognition (Soul - Server Side processing)
*   **Location:** `Layer 1 (Genesis Core / main.py)`
*   **Action:**
    *   Receives data -> Updates state (Energy, Mood).
    *   Evaluation -> LLM or logic decides.
    *   **Decision:** "Energy low... returning to charge" or "Soil is dry... opening water zone 2".

### 5. Action
*   **Location:** `Layer 4 -> Layer 5`
*   **Action:** Sends commands back to the ESP32 to drive motors or toggle relays.
