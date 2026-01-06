# GhostPass: Identity & Licensing System 🆔

**GhostPass** is the core of security and identity verification in the GhostMicro universe, responsible for creating a **"Digital Soul"** for both humans and robots.

---

## 🔐 1. Core Philosophy

### The 12-Word Rule (BIP-39 Style)
We use the same standard as crypto wallets for identity creation:
- **Human Identity**: Uses 12 words to verify ownership (Owner).
- **Robot Identity (Soul)**: Uses 12 words to create a Unique ID and Encryption Key.

### Master Authority
The system is highly secure, using a **Master Secret Salt** combined with the 12 words, making it extremely difficult to brute-force the actual key.

---

## 🏷️ 2. Product Hierarchy (v8.1)

The system categorizes products into a clear hierarchy for license management:

### Type (Primary Category)
- **0**: Software (Computer programs)
- **1**: Hardware (Physical devices)
- **2**: App (Mobile applications)

### Product
*(Under Type 1: Hardware)*
- **Index 0**: IoT Smart Home
- **Index 1**: IoT Smart Farm
- **Index 2**: **Robot** (Latest addition)

---

## 🛠️ 3. API & Integration

### Key-Genesis API
API for creating and verifying License Keys.
- **Endpoint**: `https://api.ghostmicro.com/genesis` (Mockup)
- **Payload**: JSON specifying `type`, `product_index`, and `mnemonic_hash`.

### Usage in Micro-IoT
The Generator embeds the `GHOST_KEY` obtained from GhostPass into the firmware of every ESP32 to allow identity verification with the Server.

---
*Last Updated: 2026-01-04*
