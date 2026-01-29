# Roadmap

เพื่อให้ระบบ **Genesis World** สมบูรณ์และเป็น Ecosystem ที่ทำงานร่วมกันได้อย่างมีประสิทธิภาพ โดยเน้นการสร้างจากฐานรากขึ้นสู่ยอดดังนี้ :

---

## **1. สรุปแผนการทำงาน (Phase-by-Phase Roadmap)**

การเริ่มทำระบบใหญ่ขนาดนี้ ต้องเริ่มจาก **"แกนกลาง"** แล้วขยายออกไปทีละส่วน :

### **เฟส 1 : การวางรากฐานและระบบประสาทกลาง (Core & Connectivity)**

* **เป้าหมาย:** สร้าง Core Genesis เพื่อให้เป็นศูนย์บัญชาการและที่เก็บข้อมูล
* **สิ่งที่ต้องทำ:** ติดตั้ง MQTT Broker, ระบบฐานข้อมูล และ Dashboard พื้นฐาน

### **เฟส 2 : การพัฒนาส่วนประสาทแยกส่วน (Sector AI Development)**

* **เป้าหมาย:** สร้างความฉลาดเฉพาะทางให้แต่ละระบบ (Home, Farm, Robot)
* **สิ่งที่ต้องทำ:** พัฒนา Logic การทำงานของแต่ละ Sector ให้ตัดสินใจเองได้ในระดับท้องถิ่น (Local Logic) โดยใช้ ESP32 หรือ STM32 เป็นตัวประมวลผลหน้างาน

### **เฟส 3 : การเชื่อมโยงระดับ Ecosystem (System Integration & AI Rules)**

* **เป้าหมาย:** ทำให้ Core Genesis สั่งงานข้ามระบบได้
* **สิ่งที่ต้องทำ:** เขียน **AI Rules** เพื่อให้ข้อมูลจากฟาร์มส่งผลต่อบ้าน หรือข้อมูลจากบ้านส่งผลต่อหุ่นยนต์

### **เฟส 4 : การสร้างโลกเสมือน (Digital Twin & Full Automation)**

* **เป้าหมาย:** การควบคุมผ่านโมเดล 3D และการพยากรณ์ล่วงหน้า
* **สิ่งที่ต้องทำ:** นำข้อมูลจากทุก Sector มา Render เป็นภาพ 3D และให้ AI เริ่มเรียนรู้เพื่อทำ Predictive Maintenance

---

## **2. รายการอุปกรณ์ที่ต้องใช้ (Hardware Essentials)**

> [!NOTE]
> สำหรับรายละเอียดทางวิศวกรรมของอุปกรณ์อิเล็กทรอนิกส์ที่เป็นมาตรฐานของโครงการ โปรดดูที่ [Master Hardware BOM](../02_core_iot/Hardware_BOM.md)

### **A. กลุ่มศูนย์กลาง (Core Genesis)**

* **Main Server :** Computer (PC/Mini PC) หรือ Raspberry Pi 4/5 (สำหรับเป็นสมองกลางและ Web Server)
* **Storage :** MicroSD Card (High Endurance) หรือ SSD สำหรับเก็บ Log ข้อมูลและ AI Models
* **Connectivity :** Router Wi-Fi 6 (เพื่อรองรับจำนวน Device ที่มากและมีความเสถียรสูง)

### **B. กลุ่มส่วนประสาทแยกส่วน (Sector AI Controllers)**

* **Smart Home :** **ESP32** (แนะนำรุ่น S3 เพราะรองรับ AI และ Matter)
* **Smart Farm :** **ESP32 + LoRa Module** (สำหรับส่งสัญญาณระยะไกล) หรือ **STM32** (หากต้องการความทนทานสูง)
* **Smart Robot :** **ESP32-S3** (รองรับ Camera/Voice) + **Motor Driver** (เช่น L298N หรือ BTS7960)

### **C. กลุ่มอุปกรณ์รับรู้และสั่งการ (Sensors & Actuators)**

| ระบบ            | เซนเซอร์ (Sensors)                                     | อุปกรณ์สั่งการ (Actuators)                           |
| --------------- | ----------------------------------------------------- | ------------------------------------------------ |
| **Smart Home**  | DHT22 (Temp/Hum), PIR (Motion), MQ-2 (Gas/Smoke)      | Magnetic Lock, Relay (Light/Plug), Servo (Blind) |
| **Smart Farm**  | Capacitive Soil Moisture, Light (BH1750), Rain Sensor | Solenoid Valve, Water Pump, Fogger               |
| **Smart Robot** | Ultrasonic/LiDAR (ระยะห่าง), MPU6050 (Gyro), GPS       | DC Gear Motor, Stepper Motor, Gripper            |

---
