# **GhostMicro Blueprint: "Genesis Universal AI OS"**

**"From Smart Farm to Smart Home and Robotics... It's all one life."**

This is the **Unified Vision Blueprint** that merges original IoT roots with the latest AI Agent technology to create a single operating system that can control everything.

---

## 1. Design Philosophy

**"Everything has a Soul"**

We aren't just building a light switch or a remote-controlled robot. We are building the **"Genesis Core" (The Soul)**—an AI spirit that can inhabit any body, whether it be:
*   **A House**: A home that cares for its residents (Smart Home)
*   **A Farm**: A farm that nurtures crops like children (Smart Farm)
*   **A Robot**: A robot that patrols and protects the area (Autonomous Agent)

### 🧩 The Trinity Architecture

The system is divided into three layers that work together in every context:

#### **Layer 1: The Soul (Genesis Core)**
*   **Location:** Server / Cloud / PC
*   **Role:** The brain and heart; possesses Moods, Memories (0-8), and Decision-making.
*   **Context:**
    *   *Robot Context:* "I'm hungry (Low Battery). Returning to charge."
    *   *Farm Context:* "I'm thirsty (Dry Soil). Opening water valve Zone 3."
    *   *Home Context:* "I'm hot (High Room Temp). Turning on AC."

#### **Layer 2: The Reflex (Universal Node)**
*   **Location:** **ESP32 (GhostMicro Firmware)**
*   **Role:** The neurons or spinal cord connecting to the real world.
*   **Feature:** **Auto-Identity** (Pin 34) system that immediately tells the Soul what it is.

#### **Layer 3: The Body (Physical World)**
*   **Location:** Actual Hardware
*   **Types:** 
    *   **Mobile Bodies:** Rover, Drone, Robotic Arm
    *   **Stationary Bodies:** Garden Plot, Bedroom, Gate

---

## 2. Universal Body Identity

We use the **Resistor ID (Pin 34)** technique and **Software Configuration** to change the role of the same ESP32 into different devices:

| ID Value        | Body Type      | Role            | Reflex Logic (Instinct)                |
| :-------------- | :------------- | :-------------- | :------------------------------------- |
| **0 - 500**     | `ROVER_MK1`    | Exploration Bot | Obstacle avoidance, return to dock     |
| **501 - 1000**  | `DRONE_V1`     | Drone           | Altitude hold, emergency landing       |
| **1001 - 1500** | `FARM_NODE_A`  | Farm Controller | Stop water on rain, cut power on short |
| **1501 - 2000** | `SECURITY_HUB` | Security Box    | Siren on intrusion, instant alert      |
| **2001+**       | `GENERIC_IOT`  | Switch/Plug     | Cut power on overload, toggle by time  |

---

## 3. Safety and Stability (Origins of Safety)

Foundation from Smart Farm where "durability" and "self-reliance" are applied to robotics:
1.  **Offline Survival:** If the Server goes down (Soul lost), the Node (Body) must still perform basic functions (Timed watering, collision avoidance, cliff detection).
2.  **Heartbeat Protocol:** Constant pulse check. If silent for too long, enter Safe Mode.
3.  **Telemetry:** Health reporting (Battery/Voltage/Status) back to the Soul.

---

## 4. Current Ecosystem Map

### 🌍 **The Brain (Center)**
*   `micro-iot-ai-robot`: Genesis Core (FastAPI/Python) - The heart of all systems.

### 🕸️ **The Nervous System (Connectivity)**
*   `micro-iot-dashboard-hub`: Unified hub for all dashboard themes.
*   `micro-iot-library`: Knowledge base and Drivers for all Node types.

### 🦎 **The Nodes (Endpoints)**
*   `micro-iot-ai-robot-firmware`: **Universal Firmware** usable for both Robot and Smart Farm Nodes (via config or Body ID change).

---

## 5. Conclusion

"GhostMicro isn't just a robot project... it's a **platform for enchanting objects with life.**"
The ultimate goal is to create a world where humans coexist with technology that feels and cares for us like a family member.
