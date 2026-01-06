# 📂 GhostMicro Project Index (สารบัญโครงการ)

**Last Updated:** 2026-01-06
**Maintainer:** Antigravity (AI)

เอกสารนี้รวบรวมรายชื่อ Repository ทั้งหมดในจักรวาล `GhostMicro` พร้อมคำอธิบายหน้าที่และการเข้าถึง

---

## 🏗️ Core & Documentation
| Folder Name         | Description (TH)                        | Description (EN)                                      | Status   |
| :------------------ | :-------------------------------------- | :---------------------------------------------------- | :------- |
| **docs**            | ศูนย์รวมเอกสาร คู่มือ และบันทึกของโครงการทั้งหมด | Central hub for all documentation, manuals, and logs. | ✅ Active |
| **GhostPassV8**     | โปรเจกต์หลักของระบบยืนยันตัวตน version 8 (ปัจจุบัน 8.2)     | Main project for Identity Authentication System v8.   | ✅ Active |
| **GhostPassV8-Doc** | เอกสารเฉพาะทางสำหรับ GhostPass V8 (ปัจจุบัน 8.2)         | Dedicated documentation for GhostPass V8.             | ✅ Active |
| **GP-Node-Docs**    | คู่มือสำหรับ Node และ Developer              | Documentation for Node implementation and developers. | ✅ Active |

## 🌐 Dashboard Suite (Distributed Ecosystem)
| Folder Name                 | Theme Style          | Port | Description                              |
| :-------------------------- | :------------------- | :--- | :--------------------------------------- |
| **micro-iot-dashboard-hub** | **Central Hub**      | 3000 | ศูนย์บัญชาการหลักเพื่อเข้าถึงทุก Dashboard        |
| **micro-iot-dashboard**     | **Genesis Core (0)** | 3001 | ธีมหลัก Cyberpunk (ตำแหน่งเดิมของ Brain)      |
| **micro-iot-dashboard-1**   | **Industrial (1)**   | 3002 | ธีมสีเหลืองอุตสาหกรรม เน้นความทนทาน           |
| **micro-iot-dashboard-2**   | **Matrix (2)**       | 3003 | ธีม Bio-hacking สไตล์ Matrix Green         |
| **micro-iot-dashboard-3**   | **Minimal Lab (3)**  | 3004 | ธีมคลีนสีขาว-ฟ้า สำหรับห้องปฏิบัติการ              |
| **micro-iot-dashboard-4**   | **Synthwave (4)**    | 3005 | ธีมย้อนยุค 80s สีม่วงนีออนเรืองแสง              |
| **micro-iot-dashboard-5**   | **Prismatic (5)**    | 3006 | ธีมหรูหราสีรุ้ง Ultra-Premium Rainbow         |
| **micro-iot-dashboard-6**   | **Ultra-Pro (6)**    | 3007 | ธีมมือโปร เน้นความแม่นยำและข้อมูลสูง             |
| **micro-iot-dashboard-7**   | **Stark HUD (7)**    | 3008 | ธีมถอดแบบ J.A.R.V.I.S. (Stark Industries) |
| **micro-iot-dashboard-8**   | **Tactical HUD (8)** | 3009 | แดชบอร์ดสำรองสำหรับภารกิจภาคสนาม              |

## 🤖 Robot & AI Layer
| Folder Name                     | Description (TH)                     | Description (EN)                    | Port/API |
| :------------------------------ | :----------------------------------- | :---------------------------------- | :------- |
| **micro-iot-ai-robot**          | **Genesis Core**: เซิร์ฟเวอร์ Python+AI | Central AI Brain (FastAPI/SIO)      | 8000     |
| **micro-iot-ai-robot-console**  | แผงควบคุมหุ่นยนต์แบบเก่า                  | Legacy Console (ToBeDeprecated)     | 3010     |
| **micro-iot-ai-robot-firmware** | **The Body**: เฟิร์มแวร์ ESP32          | ESP32 Reflex Firmware (C++/Arduino) | Hardware |
| **micro-iot-ai-robot-hardware** | แปลนฮาร์ดแวร์ PCB & 3D                 | PCB & 3D Case Schematics            | -        |
| **ghost-instinct-factory**      | โรงงาน TinyML                        | TinyML Model & Logic Converter      | -        |

## ⚙️ Services & Libraries
| Folder Name           | Description (TH)      | Description (EN)                    | Status     |
| :-------------------- | :-------------------- | :---------------------------------- | :--------- |
| **micro-iot-page**    | **Unified Generator** | เว็บสร้างโค้ดแบบ Drag & Drop ครบวงจร   | ✅ Active   |
| **key-genesis**       | **Licensing Engine**  | ระบบสร้างคำ 12 คำ (Mnemonic) ประจำเครื่อง | ✅ Active   |
| **micro-iot-library** | **Library Manager**   | ระบบจัดการไลบรารี Arduino แบบส่วนตัว    | 🚧 Building |

---
> [!TIP]
> **Ghost Sync Protocol**: ใช้คำสั่ง `./sync_all.sh` ใน Root เพื่ออัปเดตทุก Repository ให้เป็นปัจจุบันเสมอ
