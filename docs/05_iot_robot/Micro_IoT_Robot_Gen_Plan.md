# 🤖 Micro-Robot-Gen: Architecture & Development Plan

> *"From IoT Simplicity to Robotics Complexity"*

**Date**: 2026-01-06  
**Status**: Planning Phase  
**Target**: Create a comprehensive robot design and firmware generation tool

---

## 📊 1. Architecture Analysis: micro-iot-gen

### 1.1 Core Components
**Technology Stack**:
- **Framework**: Next.js 14 (App Router)
- **State Management**: Zustand
- **Language**: TypeScript
- **Styling**: Tailwind CSS

**Key Modules**:
```
micro-iot-gen/
├── lib/
│   ├── store.ts              # Zustand state (board, modules, config)
│   ├── hardware/
│   │   ├── board-defs.ts     # ESP32/ESP8266 pin definitions
│   │   └── pin-allocator.ts  # Auto pin assignment logic
│   └── generator/
│       └── code-gen.ts       # Arduino code generation
├── data/
│   ├── modules.ts            # 20+ sensor/actuator definitions
│   └── libraries.ts          # Arduino library metadata
└── components/
    ├── BoardSelector.tsx     # UI for board selection
    ├── ModuleList.tsx        # Drag-drop module interface
    └── CodePreview.tsx       # Generated code display
```

### 1.2 Key Design Patterns
1. **Module Definition System**: Each sensor/actuator is a JSON-like object with:
   - Pin requirements (`digital-in`, `analog-in`, `pwm`, `i2c`)
   - Code templates (constructor, setup, loop)
   - Power consumption
   - Library dependencies

2. **Pin Allocator**: Smart algorithm that:
   - Reserves pins for modules
   - Handles shared buses (I2C, SPI)
   - Prevents conflicts
   - Prefers "safe" pins (avoids boot-critical pins)

3. **Code Generation**: Template-based system:
   ```cpp
   constructorCode: 'DHT dht_{{ID}}({{PIN_0}}, DHT22);'
   ```
   Replaced with actual pin numbers and unique IDs

---

## 🎯 2. Micro-Robot-Gen: Vision & Scope

### 2.1 Fundamental Differences

| Aspect           | IoT Gen           | Robot Gen                            |
| ---------------- | ----------------- | ------------------------------------ |
| **Complexity**   | Static sensors    | Dynamic motion control               |
| **Calculations** | None              | Kinematics, Torque, PID              |
| **Safety**       | Basic             | Critical (collision, emergency stop) |
| **Power**        | Simple sum        | Peak current, motor stall protection |
| **Feedback**     | One-way telemetry | Closed-loop control (encoders)       |

### 2.2 Target Robot Types
1. **Differential Drive** (2-wheel rover)
2. **Mecanum Wheels** (4-wheel omnidirectional)
3. **Robot Arm** (2-6 DOF)
4. **Hexapod** (6-leg walker)
5. **Drone** (Quadcopter - future)

---

## 🏗️ 3. System Architecture

### 3.1 Technology Stack
```
micro-robot-gen/
├── Framework: Next.js 14 (TypeScript)
├── State: Zustand + Immer (for complex nested state)
├── 3D Visualization: Three.js / React Three Fiber
├── Calculations: Math.js library
├── PCB Design: KiCad Python API (future)
└── UI Theme: Cyberpunk Robotics (dark + neon orange/red)
```

### 3.2 Core Modules

#### A. Robot Configuration Store
```typescript
interface RobotState {
  robotType: 'differential' | 'mecanum' | 'arm' | 'hexapod';
  chassis: {
    wheelDiameter: number;    // mm
    wheelBase: number;        // mm (distance between wheels)
    weight: number;           // kg
    maxSpeed: number;         // m/s
  };
  motors: MotorConfig[];
  sensors: SensorConfig[];
  power: PowerConfig;
  kinematics: KinematicsData;
}
```

#### B. Calculator Modules

**1. Motor Calculator**
```typescript
interface MotorCalculator {
  calculateTorque(weight: number, wheelDiameter: number): number;
  selectMotor(requiredTorque: number): MotorRecommendation;
  calculateGearRatio(motorRPM: number, desiredSpeed: number): number;
}
```

**2. Power Budget Calculator**
```typescript
interface PowerCalculator {
  calculatePeakCurrent(motors: Motor[], sensors: Sensor[]): number;
  selectBattery(runtime: number, current: number): BatterySpec;
  designVoltageRegulator(inputV: number, outputV: number, current: number): RegulatorSpec;
}
```

**3. Kinematics Calculator**
```typescript
interface KinematicsCalculator {
  // Differential Drive
  calculateWheelVelocities(linearV: number, angularV: number): [number, number];
  
  // Robot Arm
  forwardKinematics(jointAngles: number[]): Position3D;
  inverseKinematics(targetPos: Position3D): number[];
}
```

**4. PID Tuner**
```typescript
interface PIDTuner {
  suggestParameters(systemType: string): PIDGains;
  simulateResponse(kp: number, ki: number, kd: number): ResponseCurve;
}
```

#### C. Component Library

**Motor Drivers**:
- L298N (2A per channel)
- TB6612FNG (1.2A per channel)
- DRV8833 (1.5A per channel)
- PCA9685 (16-channel PWM for servos)

**Sensors**:
- HC-SR04 (Ultrasonic)
- MPU6050 (IMU - Gyro + Accel)
- Rotary Encoder (Motor feedback)
- VL53L0X (ToF Distance)

**Power Components**:
- LM2596 (Buck Converter)
- TP4056 (Li-ion Charger)
- AMS1117 (LDO Regulator)

#### D. Code Generator

**Enhanced Template System**:
```cpp
// Motor Control Template
class MotorController_{{ID}} {
private:
  int pinA = {{PIN_A}};
  int pinB = {{PIN_B}};
  int pinPWM = {{PIN_PWM}};
  int encoder = {{PIN_ENC}};
  
  // PID Variables
  float kp = {{KP}};
  float ki = {{KI}};
  float kd = {{KD}};
  
public:
  void setSpeed(int speed) {
    // Generated PID control code
  }
};
```

#### E. Visual Designer

**Features**:
1. **3D Robot Preview**: Show chassis, wheels, sensors in 3D
2. **Component Placement**: Drag-drop sensors onto robot body
3. **Wiring Diagram**: Auto-generate connection diagram
4. **PCB Layout**: Visual pin assignment on ESP32 board

---

## 🎨 4. UI/UX Design

### 4.1 Theme: "Robotics Command Center"
- **Color Scheme**: 
  - Background: `#0a0a0a` (deep black)
  - Primary: `#ff6b35` (robot orange)
  - Secondary: `#f72585` (neon pink)
  - Accent: `#4cc9f0` (electric blue)
- **Typography**: 
  - Headers: "Orbitron" (futuristic)
  - Body: "Inter" (clean, readable)
- **Effects**: 
  - Glassmorphism panels
  - Animated circuit board background
  - Glowing borders on active components

### 4.2 Page Structure
```
/
├── /configure        # Robot type & chassis setup
├── /motors           # Motor selection & calculation
├── /sensors          # Sensor placement
├── /power            # Power system design
├── /kinematics       # Motion planning
├── /pcb              # PCB layout generator
├── /code             # Firmware preview & download
└── /simulate         # 3D simulation (future)
```

---

## 📋 5. Development Roadmap

### Phase 1: Foundation (Week 1-2)
- [x] Analyze micro-iot-gen architecture ✅
- [ ] Create project structure
- [ ] Setup Next.js + TypeScript + Tailwind
- [ ] Design state management schema
- [ ] Create basic UI layout

### Phase 2: Calculator Modules (Week 3-4)
- [ ] Motor torque calculator
- [ ] Power budget calculator
- [ ] Kinematics calculator (differential drive)
- [ ] PID parameter tuner
- [ ] Voltage divider calculator

### Phase 3: Component Library (Week 5-6)
- [ ] Define motor driver modules
- [ ] Define sensor modules
- [ ] Define power component modules
- [ ] Create component database

### Phase 4: Code Generator (Week 7-8)
- [ ] Template engine
- [ ] Motor control code generation
- [ ] Sensor integration code
- [ ] PID controller code
- [ ] Complete firmware assembly

### Phase 5: Visual Designer (Week 9-10)
- [ ] 3D robot preview (Three.js)
- [ ] Component placement UI
- [ ] Wiring diagram generator
- [ ] Pin assignment visualizer

### Phase 6: PCB Tools (Week 11-12)
- [ ] Gerber file generator
- [ ] BOM exporter
- [ ] Schematic diagram generator
- [ ] PCB layout optimizer

---

## 🧮 6. Key Algorithms

### 6.1 Motor Torque Calculation
```
Required Torque (Nm) = (Weight × Gravity × Wheel Radius) / Gear Ratio
```

### 6.2 Differential Drive Kinematics
```
Left Wheel Speed = Linear Velocity - (Angular Velocity × Wheel Base / 2)
Right Wheel Speed = Linear Velocity + (Angular Velocity × Wheel Base / 2)
```

### 6.3 Power Budget
```
Peak Current = Σ(Motor Stall Current) + Σ(Sensor Current) + 20% Safety Margin
Battery Capacity (mAh) = Average Current × Runtime (hours) × 1000
```

### 6.4 PID Control
```
Output = Kp × Error + Ki × Σ(Error) + Kd × (Error - Previous Error)
```

---

## 🎯 7. Success Criteria

### Minimum Viable Product (MVP)
- [ ] Generate firmware for 2-wheel differential drive robot
- [ ] Calculate motor requirements from weight/speed
- [ ] Auto-assign pins for 2 motors + 1 ultrasonic sensor
- [ ] Generate complete Arduino code with PID control
- [ ] Export BOM (Bill of Materials)

### Full Feature Set
- [ ] Support 4 robot types (differential, mecanum, arm, hexapod)
- [ ] 3D visual designer
- [ ] PCB Gerber file generation
- [ ] Real-time simulation
- [ ] Integration with Genesis AI OS

---

## 📦 8. Deliverables

### Documentation
- [ ] User Guide (TH/EN)
- [ ] API Reference
- [ ] Component Database
- [ ] Example Projects

### Code
- [ ] GitHub Repository: `micro-robot-gen`
- [ ] npm Package (calculator modules)
- [ ] Arduino Library Templates

### Tools
- [ ] Web Application (localhost)
- [ ] CLI Tool (optional)
- [ ] VS Code Extension (future)

---

*Planning Document v1.0 - Created by Antigravity*
*Next: Begin Phase 1 Implementation*
