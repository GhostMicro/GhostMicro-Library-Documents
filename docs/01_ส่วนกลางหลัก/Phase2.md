# **Phase 2: Sector AI & Intelligent Dashboard (The Digital Twin)**

## **1. Vision & Objectives**
In Phase 1, we established the "Soul" (Genesis Core). In Phase 2, we build the "Body" and "Senses".
We will move from a CLI-based interaction to a full **Cyberpunk Visual Command Center** and deploy **Distributed Intelligence** to edge devices.

### **Core Goals**
1.  **The centralized Brain (Genesis Web)**: A Next.js dashboard that acts as the visual cortex, allowing the user to *see* the system state in 3D.
2.  **The Distributed Nervous System (Sector AI)**: specialized logic running on ESP32/STM32 for autonomous operation (Home, Farm, Robot).
3.  **The Digital Twin**: Real-time synchronization between the physical world (MQTT) and the virtual world (3D Scene).

---

## **2. Architecture: The Trinity**

### **A. The Face: Intelligent Dashboard (Next.js)**
*   **Tech Stack**: Next.js 16 (App Router), TailwindCSS v4, React Three Fiber (R3F), Zutstand (State Mgt).
*   **Theme**: "Midnight Tech" - Deep Gray/Black background, Neon Orange/Pink accents, Glassmorphism.
*   **Modules**:
    *   **Vision Deck**: 3D Digital Twin of the environment (Home/Farm).
    *   **Control Panel**: Manual overrides for all actuators.
    *   **Genesis Chat**: Direct interface to talk to the AI (Text/Voice).
    *   **System Vitals**: Real-time graphs of CPU, RAM, Network, MQTT latency.

### **B. The Limbs: Sector AI (Edge Devices)**
*   **Concept**: "Instinct over Intelligence". If the Core Server dies, the Edge must survive.
*   **Sector 1: Smart Home (ESP32)**
    *   **Role**: Comfort & Security.
    *   **Instinct**: Auto-close curtains if temp > 30°C. Turn on night lights if motion detected.
*   **Sector 2: Smart Farm (ESP32)**
    *   **Role**: Life Support.
    *   **Instinct**: Emergency watering if soil moisture < 20%. Auto-fan if humidity > 80%.
*   **Sector 3: Robot (STM32/ESP32)**
    *   **Role**: Mobile Sentry.
    *   **Instinct**: Obstacle avoidance, Self-docking when battery < 10%.

### **C. The Bridge: MQTT & WebSockets**
*   **Protocol**: MQTT over WebSockets (Port 9001) for the Web App.
*   **Data Flow**: `Sensor -> ESP32 -> MQTT Broker -> Genesis Core (AI Analysis) -> MQTT Broker -> Dashboard (Visualization)`

---

## **3. Implementation Roadmap**

### **Step 1: The Dashboard Foundation (`micro-iot-dashboard`)** ✅
- [x] Initialize Next.js 16 project.
- [x] Configure TailwindCSS ("Midnight Tech" Theme - *Used v3.4 stable for compatibility*).
- [x] Implement `MqttHook` context provider for global connectivity.
- [x] Create `GenesisChat` component to replace the old terminal UI.

### **Step 2: The Digital Twin (3D Visualization)** ✅
- [x] Setup `Canvas` with React Three Fiber.
- [x] Create low-poly models for:
    - **Farm**: Soil beds, Water pump, Grow lights.
    - **Home**: Room layout, Lights, Curtains.
- [x] Bind 3D properties to MQTT states (e.g., Light mesh glows when `home/light` is ON).

### **Step 3: Sector AI Prototype (Simulated & Real)** ✅
- [x] Refine `simulate_esp32.py` to support "Instinct" mode (local rule execution).
- [ ] Phase out simulation: Flash actual ESP32 with **Micro-Genesis Firmware**.

### **Step 4: Integration (The Awakening)**
- [x] Connect Genesis Core (Python) to the Dashboard.
- [ ] Genesis can control the 3D scene (e.g., User asks "Show me the farm", Camera moves to Farm).

---

## **4. Definition of Done (Phase 2)**
1.  **Visual Control**: User can click a 3D light bulb to toggle the real light.
2.  **Voice/Chat Control**: User can type "Turn on farm lights" -> Light turns on -> 3D model updates.
3.  **Resilience**: Unplugging the Server does not stop the Farm from watering itself (Edge Instinct).

