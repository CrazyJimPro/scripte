# 🚀 PatchMon v2 (Final Setup)

Sauberes Docker Setup für PatchMon v2.x (Single Server Architecture)

---

## 📋 Voraussetzungen

- Docker
- Docker Compose
- Linux Server
- Port 3010 frei

---

## ⚙️ Installation

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/patchmon/patchmon-setup.sh)"
```

---

## 🧠 Architektur Hinweis (wichtig)

PatchMon v2 nutzt **keinen separaten Backend/Frontend Stack mehr**.

✔ Stattdessen:
- ein Server Container
- integrierte UI + API

---

## 🌐 Zugriff

```text
http://<SERVER-IP>:3010
```

---

## 🔐 Standard-Komponenten

- PostgreSQL 17
- Redis 7
- PatchMon Server v2.0.2

---

## ⭐ Empfohlene Konfiguration

### Reverse Proxy (optional)

Empfohlen:

- Nginx Proxy Manager
- HTTPS aktivieren
- interne IP nicht öffentlich nutzen

---

## 🔑 Passwort & Secrets ändern

Alle Secrets liegen in:

```text
/home/chris/docker/patchmon/.env
```

Ändern:

```bash
nano .env
docker compose up -d
```

---

## 💾 Backup

Wichtige Daten:

```text
/home/chris/docker/patchmon
```

Enthält:

- Datenbank
- Redis Cache
- Agent Files
- Konfiguration

---

## 🗑️ Deinstallation

```bash
cd /home/chris/docker/patchmon
docker compose down
rm -rf /home/chris/docker/patchmon
```

---

## 🚀 Status

PatchMon läuft in **v2 Architektur (Single Container Server Mode)**.
