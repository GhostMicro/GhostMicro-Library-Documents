# 🏗️ GhostMicro System Architecture & Layers

เอกสารนี้สรุปโครงสร้าง **Folder Structure** ตามหน้าที่ (Layers) และอธิบาย **Operational Flow** (การไหลของข้อมูล) ในรูปแบบ Pipeline เพื่อให้เห็นภาพการทำงานจริงของทั้งระบบ

---

## 🏛️ 1. Layer Breakdown (โครงสร้างแบ่งตามชั้น)

ระบบแบ่งออกเป็น 5 Layer หลัก ตั้งแต่ฮาร์ดแวร์ระดับล่างสุด ไปจนถึง AI ระดับบนสุด

| Layer                                              | Component Name                                            | Folder Path                                                 | Role & Responsibility (หน้าที่)                                                                                                       | Technologies                                  |
| :------------------------------------------------- | :-------------------------------------------------------- | :---------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------- | :-------------------------------------------- |
| **L1: The Soul**<br>(จิตวิญญาณ/สมอง)                 | `micro-iot-ai-robot`                                      | `/micro-iot-ai-robot`                                       | **Central Decision Maker**<br>- รับข้อมูลจากทุก Node<br>- ประมวลผลอารมณ์ (Moods)<br>- ตัดสินใจระดับสูง (AI Agent)<br>- เก็บความทรงจำ (Memory) | Python, FastAPI,<br>Socket.IO, Gemini         |
| **L2: The Interface**<br>(การสื่อสาร/หน้าจอ)          | `micro-iot-dashboard-hub`<br>`micro-iot-ai-robot-console` | `/micro-iot-dashboard-hub`<br>`/micro-iot-ai-robot-console` | **Human-Machine Interaction**<br>- แสดงสถานะระบบ<br>- รับคำสั่ง Manual Control<br>- รวมศูนย์การเข้าถึง (Hub)                               | Next.js, React,<br>Tailwind, Socket.IO Client |
| **L3: The Nervous System**<br>(ระบบประสาท/โครงข่าย) | `micro-iot-library`<br>`GP-Node-Docs`                     | `/micro-iot-library`<br>`/GP-Node-Docs`                     | **Infrastructure & Driver**<br>- คลัง Driver มาตรฐาน<br>- เอกสาร API และ Protocol<br>- ระบบยืนยันตัวตน (GhostPass)                     | C++, Arduino Libs,<br>Documentation           |
| **L4: The Reflex**<br>(ไขสันหลัง/เฟิร์มแวร์)            | `micro-iot-ai-robot-firmware`<br>(ReflexCore)             | `/micro-iot-ai-robot-firmware`<br>`/firmware-core`          | **Edge Computing & Safety**<br>- อ่านค่า Sensor จริง<br>- ตัดสินใจฉุกเฉิน (Reflex Override)<br>- ส่ง Heartbeat ยืนยันสถานะ                   | C++, ESP32,<br>Arduino Framework              |
| **L5: The Body**<br>(ฮาร์ดแวร์จริง)                   | `micro-iot-ai-robot-hardware`<br>Sensors / Actuators      | `/micro-iot-ai-robot-hardware`<br>(Physical)                | **Physical Action**<br>- มอเตอร์, เซนเซอร์, ปั๊มน้ำ<br>- ระบุตัวตน (Body ID Identity)                                                      | PCB, 3D Print,<br>Electronics                 |

---

## 🔄 2. Operational Flow (วงจรการทำงานจริง)

รูปแบบการทำงานเป็น **Closed Loop System** ข้อมูลไหลจากกายหยาบสู่จิตวิญญาณและวนกลับมาเป็นการกระทำ

### 🔵 The Genesis Loop (CircleCI Style Workflow)

แผนภาพนี้แสดงลำดับการไหลของข้อมูล (Data Pipeline) เมื่อระบบทำงานจริง:

```mermaid
graph LR
    %% Styles
    classDef hardware fill:#f9f,stroke:#333,stroke-width:2px;
    classDef reflex fill:#bbf,stroke:#333,stroke-width:2px;
    classDef network fill:#dfd,stroke:#333,stroke-width:2px;
    classDef soul fill:#fdd,stroke:#333,stroke-width:4px;
    classDef action fill:#ffd,stroke:#333,stroke-width:2px;

    subgraph Phase 1: Sensation (รับรู้)
        S1[Sensor Reads]:::hardware -->|Raw Analog/Digital| R1
        S2[Body ID Check]:::hardware -->|Voltage Pin 34| R2
    end

    subgraph Phase 2: Reflex & Instinct (Reflex + Instinct)
        R1[Reflex Analysis]:::reflex -->|Safe?| R3{Safety Check}
        R2[Identity Logic]:::reflex -->|Config Profile| R4[Telemetry Pack]
        I1[Instinct Monitoring]:::reflex -->|Signal/Thermal| R4
        R3 -- Yes --> R4
        R3 -- No (Danger) --> Override[STOP/ACT NOW!]:::action
    end

    subgraph Phase 3: Transmission (ส่งผ่าน)
        R4 -->|JSON/Socket.IO| N1[Network Gateway]:::network
        N1 -->|Event: telemetry| C1
    end

    subgraph Phase 4: Cognition (คิดวิเคราะห์)
        C1[Genesis Core]:::soul -->|Update Mood/Energy| C2{AI Decision}
        C2 -->|Routine| A1[Keep Monitoring]
        C2 -->|Stimulus| A2[Generate Action]
    end

    subgraph Phase 5: Action (สั่งการ)
        A2 -->|Event: command| N1
        N1 -->|Parse CMD| R5[Motor/Relay Ctrl]:::reflex
        R5 -->|Drive| M1[Actuators]:::hardware
    end

    %% Link Back
    M1 -.->|Feedback| S1
```

---

## 📝 3. คำอธิบายขั้นตอน (Deep Dive)

### 1. Sensation (การรับรู้)
*   **Location:** `Layer 5 (Physical)` & `Layer 4 (Firmware)`
*   **Action:** เซนเซอร์ (เช่น อุณหภูมิ, Distance, Batt) อ่านค่าดิบ
*   **Check:** อ่าน ID Pin 34 เพื่อยืนยันว่าตัวเองคือ "Robot" หรือ "Smart Farm Node"

### 2. Reflex & Instinct (Edge Intelligence - ระบบอัจฉริยะส่วนปลาย)
*   **Location:** `Layer 4 (ReflexCore.cpp)`
*   **Action:**
    *   **Reflex**: หากเกิดอันตรายวิกฤต -> **Reflex Override** จะตัดการทำงานทันที
    *   **Instinct**: ตรวจสอบสุขภาพฮาร์ดแวร์ (เช่น WiFi RSSI, Thermal) และส่ง "ความรู้สึก" (Instinct Report) ไปยัง Soul เพื่อปรับอารมณ์และพฤติกรรม (Mood/Behavior)


### 3. Transmission (การส่งผ่าน)
*   **Location:** `Layer 3 (Network Library)`
*   **Action:** ส่ง JSON Packet ผ่าน Socket.IO (WiFi) ไปยัง Server
*   **Protocol:** `{"battery": 85, "reflex": "NONE", "id": "ROVER_MK1"}`

### 4. Cognition (จิตวิญญาณ - คิดที่ Server)
*   **Location:** `Layer 1 (Genesis Core / main.py)`
*   **Action:**
    *   รับข้อมูล -> อัปเดต state (Energy, Mood)
    *   ประเมินผล -> LLM หรือ Logic ธรรมดาตัดสินใจ
    *   **Decision:** "พลังงานต่ำจัง... กลับไปชาร์จดีกว่า" หรือ "ดินแห้งแล้ว... เปิดน้ำโซน 2"

### 5. Action (การสั่งการ)
*   **Location:** `Layer 4 -> Layer 5`
*   **Action:** ส่งคำสั่งกลับมาที่ ESP32 เพื่อขับเคลื่อนมอเตอร์หรือเปิดปิด Relay
