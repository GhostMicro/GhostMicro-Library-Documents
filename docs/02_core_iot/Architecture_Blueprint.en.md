# **GhostMicro Blueprint: "Modular AI Nervous System"**

**"Computer is the Soul"** -> **"ESP32 is the Spinal Cord"** -> **"Robot is the Body"**

This is the **Refined Blueprint** that emphasizes maximum flexibility and security, following the concept of **"Interchangeable Bodies"**.

---

## 1. Design Philosophy

We are not just building a single robot; we are building a **"Central Nervous System" (The Core)** that can be plugged into any body (car, drone, robotic arm, spider robot) and work immediately. The operations are divided into several layers:

### **Layer 1: The Cognitive Layer (Brain/Soul)**
*   **Hardware:** PC / Server / Cloud (runs Python + TensorFlow)
*   **Tasks:** Thinking, analyzing, object classification (Vision), Path Planning, and high-level decision making.
*   **Speed:** Slow (50ms - 500ms) but the most intelligent.

### **Layer 2: The Reflex Layer (Spinal Cord/The Core)**
*   **Hardware:** **GhostMicro Core** (ESP32 or main mediator board)
*   **Tasks:**
    *   **Gateway:** Connects WiFi/WebSocket with the Brain.
    *   **Translation:** Translates commands from the brain ("Forward") into a standard protocol for the body.
    *   **Safety (Crucial):** Monitors **Heartbeat** from the brain. If the signal is lost, triggers an Emergency Stop immediately.
*   **Speed:** Medium (10ms - 50ms) with high stability.

### **Layer 3: The Hardware Layer (Body/Muscles)**
*   **Hardware:** Arduino Nano / STM32 / Motor Driver (attached to the robot structure)
*   **Tasks:**
    *   **Actuation:** Controls motors, servos, and PID Control.
    *   **Proprioception:** Reads wheel speed, tilt (IMU).
    *   **Instinct:** Basic self-protection systems like "Stop when a cliff is detected," or "Cut power if wheels are Overcurrent" without waiting for commands from the brain.
*   **Speed:** Very fast (Real-time < 1ms).

---

## 2. Modular Hardware Structure

To allow "The Core" to change bodies, we must define a **Standard Interface (The Neck)**:

*   **The Core (Head):** A box containing ESP32 + Battery Management + Status Display + Female Connector.
*   **The Body Interface:** A standard connection point (Header Pin) that every body must have:
    *   `VCC/GND`: Power supply
    *   `I2C (SDA/SCL)`: Main communication
    *   `INT (Interrupt)`: For the body to call the main core in emergencies.
    *   `ID_PIN`: Analog pin or Resistor ID to tell the Core what body it is plugged into (e.g., Car = 1k Ohm, Drone = 4.7k Ohm).

---

## 3. Safety & Failsafe Protocols

AI systems can freeze or WiFi can drop. Protection systems are paramount:

1.  **Heartbeat Protocol:**
    *   PC sends `{"heartbeat": timestamp}` every 500ms.
    *   The Core (ESP32) if not received for > 2000ms -> **Enters SAFE STATE immediately** (stop motors, land, sound alert).
2.  **Local Reflex:**
    *   Collision sensors (Ultrasonic/Lidar) are processed at Layer 3 (Body).
    *   If an obstacle is hit at a dangerous distance, the body will **"Brake itself"** immediately and then report to the Core: "Braked, obstacle detected" (without waiting for the brain).

---

## 4. Project Folder Structure

Divided by role to support multiple bodies in the future:

### 🧠 **1. Brain (Python Control Center)**
`/micro-iot-ai-robot/`
*   `bi-directional-gateway`: Python Server connects both WebSocket (Web) & TCP (Robot)
*   `ai-models`: YOLO/TensorFlow scripts
*   `modules`: Logic separated by mode (DriveMode, FlightMode)

### 🦎 **2. The Core (Firmware for ESP32)**
`/micro-iot-ai-robot-firmware/firmware-core`
*   Role: Handles WiFi, Heartbeat, reading Body ID, sending Standard I2C commands.

### 🦾 **3. The Bodies (Firmware for Slaves)**
`/micro-iot-ai-robot-firmware/firmware-bodies`
*   `/chassis-rover-v1`: Code for Arduino Nano on the rover (focuses on wheel speed PID).
*   `/chassis-drone-v1`: Code for Flight Controller (focuses on Stabilization).
*   `/chassis-arm-v1`: Code for robotic arm (Inverse Kinematics).

### 📊 **4. Dashboard (Supervisor UI)**
`/micro-iot-ai-robot-console/`
*   Next.js App for viewing robot status, switching AI/Manual modes, and camera feed.

### 📊 **5. User & Developer Manual**
*   Location: `/media/devg/Micro-SV6/GitHub/GhostMicro/micro-iot-ai-robot-docs`
*   Role: User and developer documentation.
*   Includes:
    *   `user-manual.md`: User guide.
    *   `developer-manual.md`: Developer guide.
    *   `version-history.md`: Version history logs.
    *   `development-plan.md`: Development goals.

---

## 5. Phase 1 Development Plan (The Rover)

We will start with the simplest body, the **"Survey Vehicle,"** to test the Nervous System.

1.  **Build The Core:** Stable WiFi connection, automatic connection, and status display.
2.  **Build Body (Rover):** Use Arduino Nano to receive simple I2C commands (Forward/Backward) and implement automatic braking.
3.  **System Integration:** Test Heartbeat (unplugging the computer should stop the robot).
4.  **Add Brain:** Write Python code to send movement loops.
