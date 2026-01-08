# คู่มือการพัฒนาอุปกรณ์ (Component Development Guide)

คู่มือนี้จะช่วยให้คุณสามารถเพิ่มอุปกรณ์ใหม่ หรือแก้ไขรูปร่างหน้าตาของอุปกรณ์ที่มีอยู่แล้วในระบบได้ด้วยตัวเอง

## 1. ไฟล์หลักที่ต้องแก้ไข
อุปกรณ์ทั้งหมดถูกจดทะเบียนไว้ในไฟล์:
[lib/registry.ts](file:///media/devg/Micro-SV6/GitHub/GhostMicro/micro-iot-circuit/lib/registry.ts)

## 2. โครงสร้างของออบเจกต์อุปกรณ์ (Component Manifest)

การเพิ่มอุปกรณ์ใหม่ จะใช้คำสั่ง `registry.register({...})` โดยมีโครงสร้างที่สำคัญดังนี้:

```typescript
registry.register({
    type: 'my-component',    // ID ห้ามซ้ำ
    name: 'My New Device',   // ชื่อที่แสดงใน Palette
    category: 'Sensors',     // หมวดหมู่ (Power, Passive, Semiconductor, Digital, IoT, etc.)
    width: 60,               // ความกว้างของกล่องขอบเขต (Bounding Box)
    height: 40,              // ความสูงของกล่องขอบเขต
    icon: 'cpu',             // ไอคอนจาก Lucide React
    properties: [            // กำหนดค่าที่ผู้ใช้แก้ไขได้ในแผง Property
        { name: 'label', type: 'string', default: 'U1', label: 'Label' }
    ],
    pins: [                  // จุดเชื่อมต่อสายไฟ (Relative to Center 0,0)
        { x: -30, y: 0, label: 'IN' },
        { x: 30, y: 0, label: 'OUT' }
    ],
    simulation: {            // กำหนดพฤติกรรมใน Simulator
        role: 'passive'      // (source, consumer, passive, switch, logic)
    },
    visuals: [               // รูปร่างหน้าตาของอุปกรณ์ (SVG/Canvas elements)
        { 
            type: 'rect', 
            props: { x: -20, y: -20, width: 40, height: 40, stroke: '#000', strokeWidth: 2 } 
        }
    ]
});
```

## 3. การวาดรูปอุปกรณ์ (Visuals System)

คุณสามารถใช้องค์ประกอบพื้นฐานเหล่านี้ในอาเรย์ `visuals` เพื่อวาดรูปอุปกรณ์:

| Type       | คุณสมบัติที่สำคัญ (Props)                               | ตัวอย่างการใช้งาน                      |
| ---------- | ------------------------------------------------ | ----------------------------------- |
| **rect**   | x, y, width, height, fill, stroke, strokeWidth   | ตัวถัง IC, ตัวต้านทาน                   |
| **circle** | x, y, radius, fill, stroke                       | จุดเชื่อมต่อ (Node), ขั้วไฟ               |
| **line**   | points (array [x,y,x,y...]), stroke, strokeWidth | ขาอุปกรณ์, สัญลักษณ์ Diode               |
| **arc**    | x, y, innerRadius, outerRadius, angle, rotation  | ประตูตรรกะ (Logic Gates), ทรานซิสเตอร์ |
| **text**   | x, y, text, fontSize, fill                       | ข้อความระบุชื่อขา หรือชื่อรุ่น               |

### เทคนิคการทำ Animation ตามสถานะ:
คุณสามารถใส่ `condition` เพื่อให้รูปเปลี่ยนไปตามสถานะของวงจรได้:
```typescript
{ 
    type: 'circle', 
    props: { x: 0, y: 0, radius: 10, fill: '#ff0000' },
    condition: { property: 'isPowered', value: true } // จะแสดงผลเมื่อมีไฟไหลผ่านเท่านั้น
}
```

## 4. ขั้นตอนการแก้ไขรูปภาพ
1. เปิดไฟล์ `lib/registry.ts`
2. หาอุปกรณ์ที่ต้องการแก้ (เช่น `type: 'led'`)
3. แก้ไขค่าพิกัดใน `visuals` หรือเปลี่ยนสี `fill`/`stroke`
4. บันทึกไฟล์ -> ระบบจะ Reload และแสดงผลใหม่ทันที!

---
*Created by Antigravity Engineering Assistant*
