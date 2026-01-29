# Circuit Design Web Editor - Project Documentation

## 1. Project Overview
**Project Name:** `micro-iot-circuit`
**Description:** A professional web-based circuit diagram editor built with Next.js, specifically tailored for Industrial IoT and AI Electronics design.

> [!NOTE]
> **Design Scope:** เครื่องมือนี้เน้นไปที่การออกแบบ **วงจรไฟฟ้ากายภาพ (Physical Circuit)** เท่านั้น ไม่ระรวมถึงการตั้งกฎ Logic หรือ Rule Designer (AI Rules) ซึ่งจะถูกพัฒนาแยกส่วนกันในภายหลัง

**Current Status:** Completed Core Development (Phases 1-9)

## 2. Technology Stack
- **Framework:** Next.js 15 (App Router)
- **Language:** TypeScript
- **Styling:** Tailwind CSS (Custom utility-based architecture)
- **Canvas Engine:** React-Konva (HTML5 Canvas wrapper for high performance)
- **State Management:** Zustand (Simplified global state)
- **Icons:** Lucide React

## 3. Architecture & Implementation Details

### 3.1 Directory Structure
```
micro-iot-circuit/
├── app/                  # Next.js App Router
│   ├── globals.css       # Global styles (Tailwind base)
│   └── page.tsx          # Main Editor Layout
├── components/
│   ├── canvas/           # Konva Canvas Components
│   │   ├── CircuitCanvas.tsx # Main Stage
│   │   ├── Component.tsx     # Renderer for all components
│   │   ├── Wire.tsx          # Wire renderer
│   │   └── Grid.tsx          # Dynamic background grid
│   ├── circuit/          # UI Logic Components
│   │   ├── ComponentPalette.tsx # Left sidebar
│   │   ├── PropertiesPanel.tsx  # Right sidebar
│   │   └── Toolbar.tsx          # Top tools
│   └── ui/               # Reusable UI Elements (Button, Input, Panel)
├── lib/
│   ├── store.ts          # Zustand Store (State Logic)
│   ├── components.ts     # Component Definitions & Geometry
│   ├── export.ts         # JSON Save/Load Logic
│   ├── canvas-export.ts  # PNG Export Logic
│   └── hooks.ts          # Custom React Hooks
└── types/
    └── circuit.ts        # TypeScript Interfaces
```

### 3.2 State Management (Zustand)
The application uses a centralized store (`useCircuitStore`) to manage:
- **Canvas State:** `zoom` level, `offset` (pan x,y), `gridSize`, `snapToGrid`.
- **Circuit Data:** 
  - `components`: Array of objects (id, type, position, rotation, properties).
  - `wires`: Array of connections (from/to component IDs & indices).
- **Selection:** `selectedIds` array for tracking active items.
- **Tool Mode:** `select`, `pan`, `wire`.
- **Wire Drawing State:** Temporary state for tracking the wire being drawn.
- **History:** Past/Future stacks for Undo/Redo functionality.

### 3.3 Core Features Implemented

#### A. Infinite Canvas
- **Implementation:** Uses `react-konva` Stage/Layer structure.
- **Features:**
  - **Pan:** Drag canvas background or hold Space/H key.
  - **Zoom:** Mouse wheel integration with cursor-centered scaling logic.
  - **Grid:** Dynamic grid lines that mathematically scale with zoom level.

#### B. Component System
- **Registry:** `COMPONENT_DEFINITIONS` maps component types to visual properties (SVG paths, dimensions, connection points).
- **Rendering:** Custom `Component` renderer for 11+ types (Resistor, Capacitor, Inductor, Battery, LED, Diode, Transistor, switch, IC, etc.).
- **Interaction:**
  - **Drag & Drop:** From palette to canvas.
  - **Snap-to-grid:** Automated alignment to grid points (configurable).
  - **Visual Feedback:** Selection highlight boxes.

#### C. Wire Tool & Connections
- **Data Model:** Wires strictly connect `fromComponentId:pointIndex` to `toComponentId:pointIndex`.
- **Interaction:**
  - **Activation:** 'W' key or Toolbar button.
  - **Workflow:** Click start point (green dot) -> Move mouse (green dashed preview) -> Click end point.
  - **Logic:** Calculates absolute positions of rotating connection points.

#### D. Properties Editor
- **Dynamic Panel:** Shows properties based on the currently selected component.
- **Editable Fields:** 
  - **Meta:** Label, Value.
  - **Geometry:** Position X/Y, Rotation (0-360).
- **Real-time Updates:** Changes in the panel reflect immediately on the canvas via store actions.

#### E. File Operations & Persistence
- **JSON Format:** Custom schema for full state preservation.
- **Export:** 
  - **JSON:** Complete project save file.
  - **PNG:** High-resolution rendering of the current view.
- **Auto-save:** `useAutoSave` hook automatically persists state to localStorage every few seconds and on change.

### 3.4 Key Challenges & Solutions
- **CSS Architecture:** Encountered build issues with Next.js 15 and Tailwind CSS when using custom `@apply` classes. **Solution:** Refactored the entire UI to use inline Tailwind utility classes, removing dependency on global custom classes and ensuring robust builds.
- **Wire Routing:** Handling wire drawing while components are rotated. **Solution:** Implemented trigonometric transformation logic to calculate precise absolute coordinates of connection points regardless of component rotation.

## 4. Completed Phases
- ✅ **Phase 1: Foundation & Design System** (Project setup, Tailwind config)
- ✅ **Phase 2: Types & Data Models** (TS Intefaces, Component Registry)
- ✅ **Phase 3: State Management** (Zustand Store, Actions)
- ✅ **Phase 4: Core Canvas System** (Grid, Pan, Zoom, Renderers)
- ✅ **Phase 5: UI Components** (Toolbar, Palette, Panels)
- ✅ **Phase 6: Main Layout Integration** (Responsive layout)
- ✅ **Phase 7: Save/Load System** (JSON Export/Import)
- ✅ **Phase 8: Wire Tool Implementation** (Connection logic, Drawing state)
- ✅ **Phase 9: Advanced Features** (Shortcuts, Auto-save, PNG Export)

## 5. Usage Guide
- **Selection:** Click component / `V` key.
- **Pan:** Drag background / `H` key / Middle mouse.
- **Wire:** `W` key -> Click Green Dot -> Click Destination.
- **Rotate:** Edit property panel (Rotation).
- **Delete:** `Del` / `Backspace` key.
- **Undo/Redo:** `Ctrl+Z` / `Ctrl+Shift+Z`.

## 6. Future Roadmap (Optional)
- [ ] Advanced Wire Routing (Orthogonal/Manhattan lines)
- [ ] Multi-selection support (Box select)
- [ ] Copy/Paste functionality
- [ ] Circuit Simulation (SPICE integration)

## 7. Strategic Analysis: Industrial IoT & AI Focus

### 7.1 Gap Analysis (Current vs. Goal)
The current version functions well as a general-purpose electronics editor. To meet the "Industrial IoT & AI" requirement, the following gaps are identified:
1.  **Component Library:** Currently lacks specific IoT modules (ESP32, Sensors, AI Modules, Relays, Industrial PLCs).
2.  **Workflow Integration:** No link between the visual circuit and the firmware code.
3.  **Documentation Output:** Lacks Bill of Materials (BOM) export which is critical for industrial planning.

### 7.2 Enhancement Plan (Immediate Actions)
-   **Enhanced Wiring:**
    -   **Drag-to-Connect:** Smooth drag-and-drop wire creation.
    -   **Magnetic Snapping:** Cursor automatically snaps to connection points within 15px radius for precision.
    -   **Color Coding:** Wires can be customized with standard electrical colors (Red/Black/Green/Blue/etc.) via Properties Panel.
-   **Circuit Simulation (Basic):**
    -   **Voltage Propagation:** Simulation engine propagates specific voltage levels (e.g., 5V, 3.3V) from sources.
    -   **Visual Feedback:** Components glow or highlight when powered.
    -   **Controllable Sources:** Power supply/Battery voltage can be adjusted in the Properties Panel.
-   **Add IoT Components:** Extend `types/circuit.ts` and `lib/components.ts` to include `microcontroller` (ESP32), `sensor` (DHT/Ultrasonic), and `actuator` (Relay).
-   **Firmware Skeleton Gen:** (Future) Generating C++/MicroPython starter code based on connections (e.g., "Pin 4 connected to LED" -> `pinMode(4, OUTPUT)`).

## 8. User Adoption & Go-to-Market Strategy

### 8.1 Positioning
**"The Scratchpad for the AI/IoT Engineer"**
Instead of competing with complex CAD tools like KiCad or EasyEDA (which are for PCB manufacturing), position this tool as a **System Architecture & Prototyping** tool. It is for the "Ideation" phase where speed and clarity matter more than manufacturing precision.

### 8.2 User Access Strategy
1.  **Zero-Friction Access:**
    -   Host on Vercel Edge Network for global low-latency.
    -   No login required for basic usage (localStorage saves).
    -   PWA (Progressive Web App) support for tablet/mobile field work.

2.  **Ecosystem Value:**
    -   Pre-load "GhostMicro" standard headers and connectors.
    -   Create a library of "Standard Patterns" (e.g., standard sensor interface circuits) that users can drop in.

3.  **Community & Content:**
    -   **"Click-to-Code":** Write tutorials showing a diagram created here, then exporting a prompt for an AI Coder to generate the firmware. This bridges "Hardware Design" -> "AI Code Generation".
    -   **Open Component Registry:** Allow users to submit JSON definitions for new modules.

## 9. Workflow Log
- **2026-01-07 (Part 2):**
  - Received user feedback requesting improved wiring (point-to-point dragging) and circuit simulation.
  - **Action Plan:**
    - Refactor `Wire.tsx` and `useCircuitStore` to support better drawing interaction.
    - Implement a basic simulation engine to propagate state (Power/Signal).
    - Update `Component.tsx` to react to simulation state (e.g. LED turning on).
- **2026-01-07 (Part 1):**
  - Analyzed current codebase (Phases 1-9 complete).
  - Identified gap in IoT-specific components.
  - Formulated User Adoption Strategy favoring "Prototyping/Ideation" niche.
  - **Action:** Implemented `microcontroller` and `sensor` components with custom rendering logic.
  - **Result:** Successfully extended the editor engine to support IoT-specific modules.