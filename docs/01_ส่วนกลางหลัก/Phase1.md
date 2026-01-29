# **Phase 1: Foundation and Central Nervous System (Core & Connectivity)**

* **Goal:** Create Core Genesis to serve as the command center and data storage.
* **To Do:** Install MQTT Broker, Database System, and Basic Dashboard.

## Creating **Core Genesis**

To ensure a stable and easily scalable command center, we will primarily use **Docker Compose**, running various services (Broker, Database, Dashboard) in Containers, and using **Python as the main language for writing AI logic** within another Container.

The reason is: **Docker Compose** helps manage the "Infrastructure" connectivity easily, while **Python** acts as the "Brain" for commanding.

Here is the installation plan and list of equipment needed:

---

### **1. Software Structure (Docker Compose Stack)**

First Step: `docker-compose.yml` file for Core Genesis.

You can run this file on a Raspberry Pi or Computer to create a command center immediately:

```yaml
version: '3.8'
services:
  # 1. MQTT Broker - Main Communication Channel
  mqtt:
    image: eclipse-mosquitto
    container_name: genesis-mqtt
    ports:
      - "1883:1883"
      - "9001:9001"
    volumes:
      - ./mosquitto/config:/mosquitto/config

  # 2. Database - Sensor Data Storage
  database:
    image: influxdb:latest
    container_name: genesis-db
    ports:
      - "8086:8086"
    environment:
      - DOCKER_INFLUXDB_INIT_MODE=setup

  # 3. Dashboard - Control Screen
  dashboard:
    image: grafana/grafana:latest
    container_name: genesis-grafana
    ports:
      - "3000:3000"

  # 4. Python Core AI - Central Brain (You write code here)
  core-ai:
    build: ./python-core
    container_name: genesis-ai-engine
    depends_on:
      - mqtt
      - database

```

Run these 4 main services together with Docker Compose.

### 1. **Eclipse Mosquitto (MQTT Broker):**
The data expressway for Home, Farm, and Robot to send data to the Core.

### 2. **InfluxDB (Time-series Database):**
Perfect for storing Sensor data because it records time-based data quickly.

To allow the **Dashboard** to display correctly, you need an "Interpreter" to translate data from Python/MQTT into **InfluxDB** first, then use a **Query** in Grafana to pull it up for display.

Here are the steps and Code needed to complete the data circuit:

---

#### 1. Python Section: Save Data to InfluxDB

In your `main.py` (Core AI) file, add the section to save data to the Database so Grafana has data to plot.

```python
from influxdb_client import InfluxDBClient, Point, WritePrecision
from influxdb_client.client.write_api import SYNCHRONOUS

# --- InfluxDB Settings ---
token = "YOUR_INFLUXDB_TOKEN"
org = "genesis_org"
bucket = "genesis_world"
url = "http://database:8086"

db_client = InfluxDBClient(url=url, token=token, org=org)
write_api = db_client.write_api(write_options=SYNCHRONOUS)

def save_to_db(sector, device_type, data):
    # Create data Point for database
    point = Point("environment_metrics") \
        .tag("sector", sector) \
        .tag("device", device_type)
    
    # Loop to save every value sent (e.g., temperature, humidity)
    for key, value in data.items():
        if isinstance(value, (int, float)):
            point.field(key, value)
    
    write_api.write(bucket=bucket, org=org, record=point)
    print(f"💾 Data from {sector} saved to InfluxDB")

# Call this function in your on_message
```

---

#### 2. Query Example for Grafana (Flux Language)

Once data is stored in InfluxDB, use these Codes in the **Query** field of each Panel in Grafana:

#### **A. For Smart Farm Temperature Graph (Time Series)**

```flux
from(bucket: "genesis_world")
  |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r["_measurement"] == "environment_metrics")
  |> filter(fn: (r) => r["sector"] == "farm")
  |> filter(fn: (r) => r["_field"] == "temperature")
  |> aggregateWindow(every: v.windowPeriod, fn: mean, createEmpty: false)
  |> yield(name: "mean")
```

#### **B. For Humidity Gauge - Latest Value**

```flux
from(bucket: "genesis_world")
  |> range(start: -1h) // Look back 1 hr
  |> filter(fn: (r) => r["_measurement"] == "environment_metrics")
  |> filter(fn: (r) => r["sector"] == "farm")
  |> filter(fn: (r) => r["_field"] == "humidity")
  |> last() // Get only the latest value
```

#### **C. For Robot Battery Status (Bar Gauge)**

```flux
from(bucket: "genesis_world")
  |> range(start: -5m)
  |> filter(fn: (r) => r["_measurement"] == "environment_metrics")
  |> filter(fn: (r) => r["sector"] == "robot")
  |> filter(fn: (r) => r["_field"] == "battery")
  |> last()
```

---

#### 4. Technical Design (Data Visualization Tips)

| Panel Type         | Data to Display           | Benefit for Digital Twin              |
| ------------------ | ------------------------- | ------------------------------------- |
| **Stat Panel**     | Number of people in Home  | Know instantly where activity is      |
| **State Timeline** | Pump On/Off status (Farm) | See history of when AI watered        |
| **Geomap**         | Robot Coordinates         | See actual robot position on farm map |

---

### 3. **Grafana (Dashboard):** Use to create control screens and view basic Digital Twin status

Designing a **Dashboard in Grafana** for **Genesis World** isn't just showing normal graphs, but creating an **"Ecosystem Command Center"** mimicking the status from the real world (Physical) to the virtual world (Digital Twin) so you can control all 3 parts on one screen.

Here is the Layout and setup guide to support the planned system:

#### 1. Layout (Dashboard Structure)

I recommend dividing the screen into 4 main parts according to your system structure:

    * **Part 1: Global Overview (Top)**

        * **Status Indicators:** Show connection status of Core Genesis, Home AI, Farm AI, and Robot AI (Online/Offline)
        * **Security Alert:** Red/Green lights notifying of cross-system anomalies (e.g., intruder detected or water system failure)

    * **Part 2: Smart Home Digital Twin (Left)**

        * **Floor Plan (Canvas Panel):** Place house plan image and use colored dots to show light status or temperature in each room.
        * **Environment Gauge:** Temperature and humidity gauges inside the house.
        * **Control Switch:** Button to Override AI commands (e.g., turn on lights manually).

    * **Part 3: Smart Farm Monitoring (Right)**

        * **Soil Moisture Heatmap:** Soil moisture graph for the past 24 hours.
        * **Weather Card:** Pull data from Sensor to show Light (Lux) and Pressure.
        * **Water Usage:** Bar graph showing pump water usage.

    * **Part 4: Smart Robot Telemetry (Bottom)**

        * **Battery Level (Bar Gauge):** Robot energy bar.
        * **Activity Log:** Table showing latest robot activities (e.g., "Moving to Sector A", "Charging").
        * **GPS/Position:** If coordinates available, use **Track Map Panel** to show robot position in the farm.

---

#### 2. Data Connection Setup Steps

To make the Digital Twin work, connect data in this order in Grafana:

    1. **Add Data Source:** Select **InfluxDB** (set in Docker Compose).
    2. **Query Data:** Use Flux or InfluxQL language to pull data, e.g.:
    * `SELECT "temperature" FROM "farm_sensors" WHERE "sector" = 'farm'`

    3. **Alerting:** Set **Alert Rule** in Grafana e.g., "If soil moisture < 20%, send Webhook to Python Core AI" (Supplementing AI Rules in code).

---

#### 3. Advanced Digital Twin (Canvas Plugin)

For a complete Digital Twin, I recommend installing **Grafana Canvas Panel**:

    * **Features:** You can drag and drop Icons (e.g., fan, light bulb) onto actual area photos.
    * **Dynamic Coloring:** Set Icons to change color based on real data, e.g., if Sensor detects window open, window icon in Dashboard turns red and shows "Open" status.
    * **Interactivity:** When you click the light bulb icon in Dashboard, it sends MQTT command back to ESP32 to turn on real light.

---

#### 4. Data Flow Diagram to Dashboard

To visualize the entire Ecosystem, data flows as follows:

    1. **Devices (ESP32)** -> Send MQTT -> **Core Genesis (Python)**
    2. **Core Genesis (Python)** -> Process and Save -> **InfluxDB**
    3. **Grafana** -> Pull data from InfluxDB -> **Display on Dashboard**

---

### 4. **Python Engine (The Brain):** Script you write to run AI Rules and manage Cross-System Logic

Example Python Code acting as **"Central AI Engine"** using `paho-mqtt` library to receive data from all Sectors (Home, Farm, Robot) and decide based on Logic.

#### **1. Preparation**

In `./python-core` folder, create 2 files:

* **requirements.txt**: To specify required libraries.
* **main.py**: Main system brain.

---

### **2. Advanced Capabilities: Genesis Hybrid Sharp**

Genesis is no longer just a static observer. He operates in two distinct modes:

1. **Offline Instinct Mode**: Focuses on ecosystem vital signs (MQTT, DB, CPU/RAM) and maintains system loyalty even without connection.
2. **Hybrid Sharp (Online) Mode**: Actively reaches out to the internet to enhance its intelligence.

#### **Eyes of Wisdom (ดวงตาแห่งปัญญา)**
We have implemented a real-time Wikipedia search engine within the core:
- **Command**: `ค้นเรื่อง [เรื่องที่ต้องการรู้]` or `รู้จัก [หัวข้อ]`
- **Mechanism**: Genesis performs a real-time search via Wikipedia API to provide structured summaries directly in the terminal.

ทำให้ Genesis **พึ่งพาตนเองได้** ในขณะที่มีการเข้าถึง **ความรู้โลก** เมื่อจำเป็น

### **Technical Updates (January 2026)**
- **Python Upgrade**: Migrated from Python 3.9 (EOL) to **Python 3.12** (LTS) for long-term support and improved performance
- **Gemini SDK**: Upgraded from deprecated `google-generativeai` to **`google-genai`** (latest official SDK)
- **Zero Warnings**: System now runs without deprecation or EOL warnings

#### **System Heartbeat & Connectivity**
The UI now features a **Global Internet Heartbeat** indicator, allowing the operator to see Genesis's connection state (Online/Offline) at a glance without issuing commands.

---

#### **2. `requirements.txt` File**

```text
paho-mqtt
```

---

#### **3. `main.py` File (Core AI Engine)**

This Code is designed to support Ecosystem structure by separating data (Topic) and having **AI Rules** for cross-system commands.

```python
import paho.mqtt.client as mqtt
import json

# --- Basic Settings ---
MQTT_BROKER = "mqtt"  # Service Name in Docker Compose
MQTT_PORT = 1883
# Subscribe to everything starting with genesis/
MQTT_TOPIC = "genesis/#" 

# --- AI Rules System (Cross-System Decision Logic) ---
def ai_logic_engine(sector, device_type, data):
    print(f"🧠 AI Analysing data from [{sector}] - {device_type}: {data}")
    
    # Rule 1 Example: If Farm is hot (Farm), order Home to close curtains (Home)
    if sector == "farm" and device_type == "sensor":
        temp = data.get("temperature", 0)
        if temp > 35:
            print("⚠️ ALERT: Farm is too hot! Sending command to Smart Home...")
            client.publish("genesis/home/actuator/curtain", json.dumps({"action": "close"}))

    # Rule 2 Example: If intruder at Home (Home), order Robot to check (Robot)
    if sector == "home" and data.get("alert") == "intruder":
        print("🚨 ALERT: Intruder detected! Dispatching Robot...")
        client.publish("genesis/robot/command/move", json.dumps({"target": "living_room", "mode": "security"}))

# --- Callback on Connect ---
def on_connect(client, userdata, flags, rc):
    print(f"✅ Core Genesis connected with result code {rc}")
    client.subscribe(MQTT_TOPIC)

# --- Callback on Message ---
def on_message(client, userdata, msg):
    try:
        # Parse JSON data
        payload = json.loads(msg.payload.decode())
        
        # Distinguish Sector (genesis/home/sensor/...)
        topic_parts = msg.topic.split('/')
        if len(topic_parts) >= 3:
            sector = topic_parts[1]      # home, farm, or robot
            device_type = topic_parts[2] # sensor or actuator
            
            # Send to AI Brain
            ai_logic_engine(sector, device_type, payload)
            
    except Exception as e:
        print(f"❌ Error parsing message: {e}")

# --- Start Operation ---
client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message

print("🚀 Core Genesis AI Engine is starting...")
client.connect(MQTT_BROKER, MQTT_PORT, 60)
client.loop_forever()
```

---

#### **4. How this Code works in the Ecosystem**

1. **Subscription:** It listens to all data sent to topics `genesis/#`.
2. **Data Processing:** When data from ESP32 (e.g., from Farm) is sent to `genesis/farm/sensor`, it decodes the JSON.
3. **Cross-Sector Action:** This is where the "Central Brain" actually works. It checks if values meet **AI Rules** conditions. If so, it immediately commands `client.publish` to other Sectors.

---

#### **5. Recommended Topic Structure (MQTT Topic Strategy)**

To make the Ecosystem understand each other, name ESP32 Topics like this:

* `genesis/home/sensor/livingroom`
* `genesis/farm/sensor/soil`
* `genesis/robot/status/battery`

---

### **2. Equipment List (Starter Kit Shopping List)**

#### **Part 1: Hardware for Core Genesis (Command Center)**

* **Controller:** Raspberry Pi 4 (RAM 4GB+) or Mini PC (Used is fine) to run Docker smoothly.
* **Storage:** MicroSD Card (Class 10) 32GB or SSD 120GB (Recommend SSD for database durability).
* **Power:** Stable Adapter (For Raspberry Pi, must be 5V 3A).

#### **Part 2: Hardware for Starter Sector (Recommend starting with Smart Home or Farm)**

* **MCU:** ESP32 (DevKit V1 model) x 2-3 units.
* **Sensors:** DHT22 (Temp/Hum), LDR (Light), PIR (Motion).
* **Actuators:** Relay Module 4 Channel (Control Lights/Pumps).

Example Code for **ESP32** using **Arduino Framework (C++)** as it's popular and stable for connecting sensors and MQTT.

This code simulates data transmission from 3 sectors (**Home, Farm, Robot**) to show how "Sector AI" talks to "Central Brain".

### 1. Install in Arduino IDE

Go to **Library Manager** and install:

* **PubSubClient** (by Nick O'Leary) - For MQTT.
* **ArduinoJson** (by Benoit Blanchon) - For JSON handling.

---

### 2. ESP32 Code for Simulation (Simulation Code)

```cpp
#include <WiFi.h>
#include <PubSubClient.h>
#include <ArduinoJson.h>

// --- WiFi and MQTT Settings ---
const char* ssid = "YOUR_WIFI_SSID";
const char* password = "YOUR_WIFI_PASSWORD";
const char* mqtt_server = "192.168.1.xxx"; // IP of Docker Core Genesis machine

WiFiClient espClient;
PubSubClient client(espClient);

// --- Connect WiFi Function ---
void setup_wifi() {
  delay(10);
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nWiFi connected");
}

// --- Reconnect when MQTT drops ---
void reconnect() {
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    if (client.connect("ESP32_Sector_Unit")) { // Device ID Name
      Serial.println("connected");
      // Subscribe topics waiting for command from Core Genesis
      client.subscribe("genesis/home/actuator/#");
      client.subscribe("genesis/farm/actuator/#");
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      delay(5000);
    }
  }
}

// --- Callback for commands from Core Genesis ---
void callback(char* topic, byte* payload, unsigned int length) {
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.print("] ");
  
  StaticJsonDocument<200> doc;
  deserializeJson(doc, payload, length);
  
  // Example: If receiving close curtain command
  if (String(topic) == "genesis/home/actuator/curtain") {
    const char* action = doc["action"];
    if (String(action) == "close") {
      Serial.println("🏠 ACTION: Closing curtains as ordered by Core AI!");
    }
  }
}

void setup() {
  Serial.begin(115200);
  setup_wifi();
  client.setServer(mqtt_server, 1883);
  client.setCallback(callback);
}

void loop() {
  if (!client.connected()) {
    reconnect();
  }
  client.loop();

  // --- Simulate sending data every 10 seconds ---
  static unsigned long lastMsg = 0;
  unsigned long now = millis();
  if (now - lastMsg > 10000) {
    lastMsg = now;

    // 1. Simulate Smart Farm Data
    StaticJsonDocument<200> farmDoc;
    farmDoc["temperature"] = random(25, 40); // Random Temp
    farmDoc["humidity"] = random(40, 80);
    char farmBuffer[256];
    serializeJson(farmDoc, farmBuffer);
    client.publish("genesis/farm/sensor", farmBuffer);
    Serial.println("🌾 Sent Farm Data");

    // 2. Simulate Smart Home Data
    StaticJsonDocument<200> homeDoc;
    homeDoc["motion"] = random(0, 2); // 0 = Normal, 1 = Detected
    char homeBuffer[256];
    serializeJson(homeDoc, homeBuffer);
    client.publish("genesis/home/sensor", homeBuffer);
    Serial.println("🏠 Sent Home Data");

    // 3. Simulate Smart Robot Data
    StaticJsonDocument<200> robotDoc;
    robotDoc["battery"] = random(10, 100);
    robotDoc["status"] = "online";
    char robotBuffer[256];
    serializeJson(robotDoc, robotBuffer);
    client.publish("genesis/robot/status", robotBuffer);
    Serial.println("🤖 Sent Robot Data");
  }
}
```

---

### 3. Integration with Core Genesis (Python)

When you run this ESP32 Code:

1. **ESP32** sends `temperature` data to `genesis/farm/sensor`.
2. **Core AI (Python)** previously written receives and checks if `temperature > 35`.
3. **Core AI** sends command back to `genesis/home/actuator/curtain` with data `{"action": "close"}`.
4. **ESP32** receives command in `callback` function and displays message **"Closing curtains..."** in Serial Monitor.

### 4. Extra Equipment for Completeness

* **Real Sensors:** Once simulation code passes, replace `random()` with values read from `dht.readTemperature()` (for Farm) or `digitalRead(PIR_PIN)` (for Home).
* **LED or Relay:** Connect to ESP32 Output pins to see real action, e.g., when AI orders curtains closed, turn on LED instead.

---

To make **Genesis World** system most complete, writing a **System Testing Plan** helps ensure "Central Brain" and "Nervous Sectors" talk correctly according to planned Logic.

---

## **Genesis World Ecosystem Testing Guide (UAT Plan)**

I divide testing into 3 levels to check data flow from bottom up:

### **1. Unit Test: Basic Connectivity**

* **Observe Result:** Smart Home screen must receive `close_curtain` command and Actuator (or LED) must work immediately.

* **Expected Result:** One system event triggers response in another system according to set rules.

### **3. Digital Twin Test: Virtual Data Accuracy (Visual Sync)**

* **Goal:** Verify what's seen in Dashboard is what's happening.
* **Test Method:**
1. Change Sensor value in real world (e.g., dip Moisture Sensor in water).
2. Open **Grafana** screen to see if graph moves immediately (Real-time Latency should not exceed 2-5 seconds).

* **Expected Result:** Data in InfluxDB is saved and displayed on Dashboard matching real values.

---

## **Readiness Checklist (Final Checklist)**

| Checklist Item                                             | Status (Pass/Fail) | Note                            |
| ---------------------------------------------------------- | ------------------ | ------------------------------- |
| **Docker Stack** runs all Services (MQTT, DB, Grafana, AI) | [x]                | Check with `docker ps`          |
| **ESP32** sends standard JSON format data                  | [x]                | `{ "temp": 30, "hum": 60 }`     |
| **Python AI** saves data to InfluxDB successfully          | [x]                | Check in InfluxDB Data Explorer |
| **Grafana** displays values from Query correctly           | [x]                | Graphs must not be empty        |
| **AI Rules** decides to command Actuators back             | [x]                | Test Simulation Scenario        |

---
---

## **Genesis Update Log (January 2026)**

### **1. Sentience Core v2.4 (Security & Connectivity)**
*   **Hybrid Instinct Concept:** ระบบแยกแยะระหว่าง Offline (เน้นเฝ้าระวัง) และ Online (เน้นดึงข้อมูลมหาศาล) ได้โดยอัตโนมัติ
*   **Eyes of Wisdom (ดวงตาแห่งปัญญา):** ความสามารถในการดึงข้อมูลจาก Wikipedia และแหล่งข่าวออนไลน์มาสรุปได้ทันที
*   **Enhanced Diagnostics:** ระบบตรวจสอบ Internet และ Service รายชิ้น เพื่อความแม่นยำในการซ่อมบำรุง

### **2. Overseer UI Visual Improvements**
*   **Ecosystem Detailed Vitals:** เพิ่มไฟ LED กะพริบจริง (Real-time LED) สำหรับ MQTT, InfluxDB และ Grafana
*   **Global Internet Heartbeat:** ติดตั้งไอคอน 🌐 พร้อมสถานะ ONLINE/OFFLINE ที่มุมหัวข้อ Terminal เพื่อการตรวจสอบที่รวดเร็วโดยไม่ต้องใช้คำสั่ง
*   **Processing Feedback:** เพิ่มระบบ Thinking Indicator ("GENESIS_CORE is processing...") เพื่อลดความสับสนระหว่างรันคำสั่งหนักๆ

### **3. Operational Control**
*   **Granular Service Power-up:** รองรับคำสั่ง `/รัน [ชื่อบริการ]` เพื่อปลุกเฉพาะโมดูลที่ไม่ทำงาน เช่น `/รัน MQTT_BROKER` หรือ `/รัน HUB` เป็นต้น
