# Roadmap

To ensure **Genesis World** is complete and functions as an efficient ecosystem, the construction focuses on building from the foundation up to the pinnacle as follows:

---

## **1. Phase-by-Phase Roadmap**

Starting a large system requires beginning with the **"Core"** and expanding outward one part at a time:

### **Phase 1: Foundation and Central Nervous System (Core & Connectivity)**

* **Goal:** Create Core Genesis to serve as the command center and data storage.
* **To Do:** Install MQTT Broker, Database System, and Basic Dashboard.

### **Phase 2: Sector AI Development**

* **Goal:** Create specialized intelligence for each system (Home, Farm, Robot).
* **To Do:** Develop operational logic for each sector to enable local decision-making using ESP32 or STM32 as edge processors.

### **Phase 3: Ecosystem Integration (System Integration & AI Rules)**

* **Goal:** Enable Core Genesis to execute cross-system commands.
* **To Do:** Write **AI Rules** so that data from the farm affects the home, or home data affects the robot.

### **Phase 4: Virtual World Creation (Digital Twin & Full Automation)**

* **Goal:** Control via 3D models and predictive forecasting.
* **To Do:** Render data from all sectors into 3D images and enable AI to learn for Predictive Maintenance.

---

## **2. Hardware Essentials**

> [!NOTE]
> For the master engineering source of truth regarding electronic components, please refer to the [Master Hardware BOM](../02_core_iot/Hardware_BOM.md).

### **A. Central Group (Core Genesis)**

* **Main Server:** Computer (PC/Mini PC) or Raspberry Pi 4/5 (as the central brain and Web Server).
* **Storage:** MicroSD Card (High Endurance) or SSD for storing Data Logs and AI Models.
* **Connectivity:** Wi-Fi 6 Router (to support many devices with high stability).

### **B. Sector AI Controllers**

* **Smart Home:** **ESP32** (Recommend S3 model as it supports AI and Matter).
* **Smart Farm:** **ESP32 + LoRa Module** (for long-range transmission) or **STM32** (if high durability is needed).
* **Smart Robot:** **ESP32-S3** (Supports Camera/Voice) + **Motor Driver** (e.g., L298N or BTS7960).

### **C. Sensors & Actuators**

| System          | Sensors                                               | Actuators                                        |
| --------------- | ----------------------------------------------------- | ------------------------------------------------ |
| **Smart Home**  | DHT22 (Temp/Hum), PIR (Motion), MQ-2 (Gas/Smoke)      | Magnetic Lock, Relay (Light/Plug), Servo (Blind) |
| **Smart Farm**  | Capacitive Soil Moisture, Light (BH1750), Rain Sensor | Solenoid Valve, Water Pump, Fogger               |
| **Smart Robot** | Ultrasonic/LiDAR (Distance), MPU6050 (Gyro), GPS      | DC Gear Motor, Stepper Motor, Gripper            |

---
