# **Phase 2: Sector AI & Intelligent Dashboard (The Digital Twin)**

## **1. วิสัยทัศน์และเป้าหมาย (Vision)**
ใน Phase 1 เราสร้าง "จิตวิญญาณ" (Genesis Core) เสร็จแล้ว ใน Phase 2 นี้เราจะสร้าง "ร่างกาย" (Body) และ "ประสาทสัมผัส" (Senses) ให้กับระบบ
เราจะเปลี่ยนจากการสั่งงานผ่านจอดำ (CLI) ไปสู่ **Cyberpunk Visual Command Center** ที่สวยงามและทันสมัย

### **เป้าหมายหลัก**
1.  **สมองส่วนกลาง (Genesis Dashboard)**: หน้าเว็บ Next.js แสดงผล 3D ให้ท่านเห็นสถานะของบ้านและฟาร์มได้ทันที
2.  **ระบบประสาทส่วนขอบ (Sector AI)**: สมองย่อยที่ฝังอยู่ใน ESP32 ทำหน้าที่ตัดสินใจอัตโนมัติ (เช่น รดน้ำเมื่อดินแห้ง) แม้เน็ตหลุดก็ยังทำงานได้ (Instinct)
3.  **ฝาแฝดดิจิทัล (Digital Twin)**: การเชื่อมต่อโลกจริง (MQTT) เข้ากับโลกเสมือน (3D Scene) แบบ Real-time

---

## **2. สถาปัตยกรรม: The Trinity**

### **A. ใบหน้า: Intelligent Dashboard (Next.js)**
*   **เทคโนโลยี**: Next.js 16, TailwindCSS (Theme: Midnight Tech), React Three Fiber (3D).
*   **ความสามารถ**:
    *   **Vision Deck**: โมเดล 3 มิติ จำลองสภาพบ้านและฟาร์ม
    *   **Genesis Chat**: ช่องทางสื่อสารกับ Genesis AI โดยตรง
    *   **System Vitals**: กราฟแสดงสถานะระบบ CPU, RAM, Network

### **B. แขนขา: Sector AI (Edge Devices)**
*   **แนวคิด**: "สัญชาตญาณ สำคัญกว่า ความฉลาด" (Instinct over Intelligence)
*   **Sector 1: Smart Home**: ดูแลความปลอดภัยและแสงสว่าง
*   **Sector 2: Smart Farm**: ดูแลพืชผล รดน้ำอัตโนมัติ ควบคุมอุณหภูมิ

### **C. สะพานเชื่อม: MQTT & WebSockets**
*   **โปรโตคอล**: MQTT Port 9001 (WebSockets) ให้หน้าเว็บคุยกับฮาร์ดแวร์ได้โดยตรง

---

## **3. สถานะการดำเนินการ (Roadmap Status)**

### **Step 1: Dashboard Foundation** ✅
- [x] ติดตั้ง Next.js 16 + Tailwind CSS (ใช้ v3.4 เพื่อความเสถียร)
- [x] เชื่อมต่อ MQTT WebSockets (Port 9001)
- [x] สร้างหน้าแชท GenesisChat

### **Step 2: Digital Twin (3D)** ✅
- [x] สร้าง Scene 3D ด้วย React Three Fiber
- [x] เชื่อมต่อสถานะไฟ (Light) ใน 3D กับ MQTT

### **Step 3: Sector AI Prototype** ✅
- [x] เขียนโปรแกรมจำลอง (Simulator) ให้มี "สัญชาตญาณ" (Instinct Mode)
- [x] ทดสอบการรดน้ำอัตโนมัติเมื่อดินแห้ง (โดยไม่ต้องรอคำสั่งจาก Server)