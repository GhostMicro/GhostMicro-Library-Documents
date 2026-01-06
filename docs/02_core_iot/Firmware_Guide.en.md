# GhostMicro: Wireless Core Upgrade Manual (OTA)

This manual will help you upgrade the robot's "heart" wirelessly without needing to unplug the board and use a USB cable.

## 1. Preparation
- Use **PlatformIO** in VS Code to Compile the `firmware-core` project.
- Once compilation is finished, you will get a file named `firmware.bin` (usually located in `/firmware-core/.pio/build/esp32dev/`).

## 2. Flashing Procedure
1.  **Open Dashboard**: Go to the GhostMicro Mirror Dashboard.
2.  **Locate Maintenance**: Scroll down to the **System Maintenance // OTA** section at the bottom left.
3.  **Select Binary**: Click or drag and drop to select the `.bin` file you prepared.
4.  **Initiate Upgrade**: Click the purple button **"UPGRADE NEURAL CORE"**.

## 3. Behind the Scenes
- **Neural Uplink**: The Dashboard sends the file to the brain (Python Brain).
- **Neural Handshake**: The Brain signals the ESP32 that new software is available.
- **Self-Update**: The ESP32 downloads the file and flashes itself, then reboots automatically.

## 4. Troubleshooting
- **LINK DOWN**: Check if the robot is connected to the same WiFi network as the brain.
- **Upload Failed**: Check file size and write permissions in the `firmware/` folder on the server side.
- **Authentication Error**: The `GHOST_SECRET` code in the Dashboard and Brain must match.

---
> [!IMPORTANT]
> **Warning**: Do not turn off the robot while the system is "UPGRADING CORE," as it may corrupt the software.

## 5. Unified vs Modular (One or Four?)
You might wonder if you need separate firmware for all 4 robot bodies? The answer is:

- **Core (ESP32)**: **Use only one (Unified)**! The program is smart enough to detect the body (Body Detection) via voltage and adjust its operation mode automatically.
- **Body (Arduino)**: Recommended to have **separate ones (Modular)** such as `rover-chassis.ino` or `drone-props.ino` for the most precise motor control based on the physics of each body.

**Summary**: When upgrading via OTA, you only need to compile one file for the ESP32 to control all bodies! 🎯✨
