#include <Arduino.h>
#include <ArduinoJson.h>
#include <ArduinoOTA.h>
#include <ESPmDNS.h>
#include <PubSubClient.h>
#include <WiFi.h>

const char *ssid = "AIS_2.4G";
const char *password = "034322835";

WiFiClient espClient;
PubSubClient client(espClient);
const char *mqtt_server = "broker.hivemq.com";
const int mqtt_port = 1883;
const char *device_id = "micro_node_631";
const char *ghost_identity = "UNREGISTERED-DEV-KEY"; // Signed Identity

void sendTelemetry(String key, float value) {
  JsonDocument doc; // V7 Automatic Sizing
  doc[key] = value;
  doc["unit"] = "raw";
  char buffer[256];
  serializeJson(doc, buffer);
  String topic = String("grids/") + device_id + "/tele/" + key;
  client.publish(topic.c_str(), buffer);
}

void publishDiscovery() {
  JsonDocument doc; // V7 Automatic Sizing
  doc["sig"] = "GRIDS-IOT-V1";
  doc["device_id"] = device_id;
  doc["uid"] = ghost_identity;
  doc["board"] = "esp32-devkit-v1";
  doc["ver"] = "1.0.0";

  JsonArray mods = doc.createNestedArray("modules");

  char buffer[1024];
  serializeJson(doc, buffer);
  String topic = String("grids/discovery/") + device_id;
  client.publish(topic.c_str(), buffer);
}

void callback(char *topic, byte *payload, unsigned int length) {
  String msg = "";
  for (int i = 0; i < length; i++)
    msg += (char)payload[i];
  Serial.print("[MQTT] ");
  Serial.print(topic);
  Serial.print(": ");
  Serial.println(msg);

  // Discovery Broadcast Response
  if (String(topic) == "grids/broadcast/discover" && msg == "SCAN") {
    publishDiscovery();
  }

  // Command Handling
  String topicStr = String(topic);
  if (topicStr.startsWith(String("grids/") + device_id + "/cmnd/")) {
    String mod = topicStr.substring(topicStr.lastIndexOf('/') + 1);
  }
}

void setupOTA() {
  ArduinoOTA.setHostname(device_id);
  ArduinoOTA.onStart([]() { Serial.println("Start updating"); });
  ArduinoOTA.onEnd([]() { Serial.println("\nEnd"); });
  ArduinoOTA.onProgress([](unsigned int progress, unsigned int total) {
    Serial.printf("Progress: %u%%\r", (progress / (total / 100)));
  });
  ArduinoOTA.onError(
      [](ota_error_t error) { Serial.printf("Error[%u]: ", error); });
  ArduinoOTA.begin();
}

boolean reconnect() {
  if (client.connect(device_id, NULL, NULL,
                     (String("grids/") + device_id + "/status").c_str(), 1,
                     true, "offline")) {
    Serial.println("MQTT Connected");
    client.publish((String("grids/") + device_id + "/status").c_str(), "online",
                   true);
    client.subscribe((String("grids/") + device_id + "/cmnd/#").c_str());
    client.subscribe("grids/broadcast/discover");
    publishDiscovery();
    return true;
  }
  return false;
}

void setup() {
  Serial.begin(115200);

  // Connect WiFi (Timeout 10s)
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);
  int try_wifi = 0;
  while (WiFi.status() != WL_CONNECTED && try_wifi < 20) {
    delay(500);
    Serial.print(".");
    try_wifi++;
  }
  if (WiFi.status() == WL_CONNECTED)
    Serial.println("\nWiFi Connected");
  else
    Serial.println("\nWiFi Timeout");

  setupOTA();
  client.setServer(mqtt_server, mqtt_port);
  client.setCallback(callback);
}

unsigned long lastReconnect = 0;
void loop() {
  ArduinoOTA.handle();

  if (!client.connected()) {
    unsigned long now = millis();
    if (now - lastReconnect > 5000) {
      lastReconnect = now;
      if (reconnect()) {
        lastReconnect = 0;
      }
    }
  } else {
    client.loop();
  }
}