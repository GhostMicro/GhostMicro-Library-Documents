# 📦 Genesis Dev-Kit Manual (Standard v1.0)

> *"Standardizing the Body for the Universal Soul."*

This manual defines the hardware standard for developers who want to build new "Bodies" compatible with the **Genesis AI OS**.

---

## 🛠️ 1. Hardware Specification (ESP32 Standard)

For the `ReflexCore` firmware to function optimally, hardware should follow this standard pin mapping:

| Component        | Pin (ESP32) | Mode   | Description                               |
| :--------------- | :---------- | :----- | :---------------------------------------- |
| **Status LED**   | GPIO 2      | Output | Connection status (Blink = Searching)     |
| **Body ID**      | GPIO 34     | Analog | Hardware identification (Resistor Ladder) |
| **I2C SDA**      | GPIO 21     | Data   | Motor Controller / Sensors                |
| **I2C SCL**      | GPIO 22     | Clock  | Motor Controller / Sensors                |
| **Ultrasonic T** | GPIO 5      | Output | Ultrasonic Trigger                        |
| **Ultrasonic E** | GPIO 18     | Input  | Ultrasonic Echo (Reflex Scan)             |
| **Battery**      | GPIO 35     | Analog | Voltage monitoring (via Divider)          |

---

## 🆔 2. Universal Body Identity (Resistor Ladder)

Genesis identifies hardware types via the voltage at **GPIO 34**. Install resistors based on the table below to choose your device's identity:

| Body Type        | Voltage Target | Suggested Resistor (VCC=3.3V) | AI Persona Support |
| :--------------- | :------------- | :---------------------------- | :----------------- |
| **ROVER**        | 0.5V           | 10k / 1.8k divider            | Tactical Commander |
| **DRONE**        | 0.9V           | 10k / 3.9k divider            | Tactical Commander |
| **STATIONARY**   | 2.1V           | 10k / 18k divider             | Lab Assistant      |
| **FARM_NODE**    | 2.5V           | 10k / 33k divider             | Nong Nob (TH)      |
| **SECURITY_HUB** | 3.3V           | Pull-up to 3.3V Direct        | Thunder God        |

---

## ⚡ 3. The Instinct System (Edge Intelligence)

Instincts allow hardware to "feel" its current state. Developers can implement new instincts in software:

1.  **SIGNAL_JITTER**: (Default) Derived from WiFi RSSI.
2.  **THERMAL_STRESS**: (Optional) Derived from Temperature sensors.
3.  **STABILITY_LOCK**: (Optional) Derived from IMU/MPU6050 sensors.

---

## 🚀 4. How to build a new Node

1.  **Clone Firmware**: Download the code from `micro-iot-ai-robot-firmware`.
2.  **Edit Config**: Modify `Config.h` if pins differ (Standard pins recommended).
3.  **Physical ID**: Solder the resistor to Pin 34 according to the desired Body Type.
4.  **Flash**: Upload the code to ESP32 and connect to your **Genesis Core**.

---
*Developed by GhostMicro Engineering Team*
