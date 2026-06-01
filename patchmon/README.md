# 🚀 PatchMon Setup (Docker)

Self-hosted Patch Management Plattform.

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

## 🧠 Was wird installiert

- PatchMon Backend (latest)
- PatchMon Frontend (latest)
- PostgreSQL 17
- Redis 7

---

## 🌐 Zugriff

```text
http://<SERVER-IP>:3010
```

---

## ⚠️ Hinweis zur Version

PatchMon stellt aktuell **keine stabilen 2.x Docker-Tags** bereit.

Darum wird verwendet:

```text
ghcr.io/patchmon/patchmon-backend:latest
ghcr.io/patchmon/patchmon-frontend:latest
```

---

## ⭐ Empfohlene Konfiguration

### Reverse Proxy

Empfohlen über Nginx Proxy Manager:

- Domain statt IP
- HTTPS aktivieren
- Port 3010 intern lassen

---

## 🔐 Passwörter ändern

```bash
cd /home/chris/docker/patchmon
nano .env
docker compose up -d
```

---

## 💾 Backup

```text
/home/chris/docker/patchmon
```

Enthält:

- Datenbank
- Redis
- Agent Files
- Konfiguration (.env)

---

## 🗑️ Deinstallation

```bash
cd /home/chris/docker/patchmon
docker compose down
rm -rf /home/chris/docker/patchmon
```

---

## ✅ Status

PatchMon läuft stabil mit aktuellen GHCR Images.
