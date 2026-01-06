# Micro-IoT Generator: Project Log

**Create Date**: 2026-01-03
**Maintainer**: GhostMicro Team

## 1. Project Background & Original Request
**Objective**: Build an "Intelligent IoT Generator / Pin Manager Platform".
**Problem**: Developing for ESP8266/ESP32 is complex due to pin conflicts (Strapping pins, Input-only pins) and repetitive code writing for standard sensors.
**Goal**: Create a web-based tool where users select a board, add modules, and get a ready-to-flash `.ino` file with assured pin safety.

## 2. Core Features Implemented

### A. Intelligent Pin Manager
- **Hardware Abstraction**: Defined capabilities for `ESP8266_NODEMCU` (limited pins) and `ESP32_DEVKIT_V1` (flexible matrix).
- **Safety First**: Restricted pins (Boot STRAPPING, TX/RX) are blocked by default.
- **Bus Sharing**: I2C modules automatically share SDA/SCL pins.
- **Resource Tracking**: Real-time visualization of used pins.

### B. Module Ecosystem (25+ Modules)
Expanded from basic sensors to 6 categories:
1.  **Environmental**: DHT11/22, DS18B20, BME280, Soil Moisture, Rain Sensor.
2.  **Security**: PIR, Ultrasonic, Door Switch.
3.  **Actuators**: Relays, Servo, Buzzer.
4.  **Display**: OLED SSD1306, LCD 1602 I2C.
5.  **Power**: PZEM-004T, Voltage Sensor.
6.  **Identity**: RFID-RC522.

### C. Standardized IoT Protocol (GRIDS-IOT-V1)
Implemented a strict MQTT standard for seamless dashboard integration:
-   **Discovery**: Auto-broadcasts device capabilities on `grids/discovery/[ID]`.
-   **Telemetry**: Sends data to `grids/[ID]/tele/[MODULE]`.
-   **Command**: Listens on `grids/[ID]/cmnd/[MODULE]`.

### D. Code Generation Engine
-   **Dynamic Injection**: Replaces placeholder tags (`{{PIN_0}}`, `{{ID}}`) with actual allocations.
-   **Pattern**: Includes -> Network Config -> Globals -> Setup -> Loop.

## 3. Latest Directives
-   **Docs**: Maintain this log in `/docs`.
-   **Readme**: Write a THAI Language README.
-   **Docs Repo**: Create `micro-iot-gen-docs` with MkDocs.
-   **OTA & Keys**:
    -   All generated code MUST support Arduino OTA.
    -   Inject `GHOST_KEY` from `key-genesis` for authentication.

## 4. GhostMicro Evolution: The 4 Core Identities
Expanded the modular identification system:
- **Identities**: Defined 4 distinct hardware chassis: **ROVER, DRONE, SUBMARINE, HUMANOID**.
- **Hardware Calibration**: Established fixed voltage thresholds (1.0V, 2.0V, 2.5V, 3.3V) for reliable body detection.
- **Cognitive Specialization**: AI personas (Gemini) now adapt tone and knowledge based on the active chassis (e.g., Submarine researcher, Humanoid assistant).

## 5. Asset & Log Archive
All conversation history and visual assets are permanently archived:
- **Screenshots/Mockups**: `docs/assets/mockups/`
- **Dashboard Walkthrough**: [docs/Walkthrough_4Body_System.md](file:///media/devg/Micro-SV6/GitHub/GhostMicro/docs/Walkthrough_4Body_System.md)

## 6. GHOST_SIMULATOR (Hardware Emulation)
Developed a high-fidelity manual control panel for system verification:
- **Body Switching**: One-click transition between all core identities.
- **Node Control**: Manual toggle for station IDs and network connection states (Neural Link).
- **Payload Preview**: Real-time JSON schema preview showing exactly what data each node transmits.

## 7. Neural Handshake Security
Implemented a robust security layer across the decentralized architecture:
- **GHOST_SECRET**: Enforced a 256-bit style shared secret for all Socket.IO handshakes.
- **Validation**: Python Brain rejects any connection without a valid token.
- **Breach Detection**: Unauthorized access attempts are logged as "SECURITY BREACH" in the Neural Log.

## 8. Next Steps
1.  **Chassis Design**: Physical PCB design for Analog identification resistors.
2.  **Sensor Integration**: Implementing body-specific sensor drivers (Depth for Sub, IMU for Drone).
3.  **Autonomous Navigation**: Integrating CV/Spatial awareness into the Soul layer.

## 9. Phase 11: GhostMicro Instinct Factory (TinyML)
- **Concept**: Embedded "Instincts" for urgent edge decisions.
- **Tools**: Developed `instinct_converter.py` for TFLite to C conversion.
- **UI**: Added **Instinct Dashboard** to the Console for real-time neural monitoring.
- **Templates**: Created Sensory and Muscle firmware cores with TFLite support.

## 10. Phase 12: Structural Engineering & GHOST_SLOT
- **Standardization**: Declared the **40-Pin "Ghost Scale"** standard for modular connectivity.
- **Interface**: Designed the **GHOST_SLOT** (Neural Slot) using PCIe-style edge connectors.
- **Wiring**: Standardized on **40-Pin Ribbon Cables (IDC)** for internal neural bridges.
- **Manuals**: Created `HARDWARE_GUIDE.md`, `WIRING_DIAGRAM.md`, and `BOM_MASTER.md`.

## 11. Current Technical SAVE POINT
- **Core Brain**: Running on Port 8000 (Python).
- **Mission Control**: Running on Port 3000 (Next.js).
- **Security**: GHOST_SECRET "GHOST_99_ALPHA" enforced.
- **Simulation**: `simulate_hardware.py` updated with Instinct emulation.
