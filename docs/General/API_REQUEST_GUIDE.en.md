# 📡 Key Genesis API Technical Guide

This document records how to use the API for the GhostMicro Licensing system, ensuring correct usage by both AI and developers.

---

## 🚀 Proven Usage Method

We always use **CURL** or **fetch** to send data via the **POST** method.

### 1. How to Generate a Key (Action: Encode)
Used to convert product/secret data into a 12-word phrase (GhostPass).

**Command:**
```bash
curl -X POST -H "Content-Type: application/json" \
-d '{
  "role": 1,
  "type": 0,
  "name": 500,
  "version": 1,
  "model": 88,
  "prodDate": 260105,
  "actDate": 0,
  "expiryDate": 2047,
  "sku": 777
}' \
https://key-genesis.vercel.app/api/encode
```

### 2. How to Verify a Key (Action: Decode)
Used to read data from a 12-word phrase to verify usage rights.

**Command:**
```bash
curl -X POST -H "Content-Type: application/json" \
-d '{
  "phrase": "ability abandon discover abandon ability arch abuse abandon wrong gentle abandon notice"
}' \
https://key-genesis.vercel.app/api/decode
```

---

## ⚠️ Cautions
1.  **JSON Only**: You must always set the `Content-Type: application/json` header.
2.  **Master Secret**: Although the API currently operates publicly, server-side checking of the `GHOSTPASS_MASTER_SECRET` may be implemented in the future for maximum security.
3.  **Mnemonic Checksum**: The 12th word of the phrase is a checksum. If even one word is changed, the API will immediately return `valid: false`.
