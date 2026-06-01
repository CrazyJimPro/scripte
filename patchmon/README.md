# 🚀 PatchMon v2.0.2 Setup (Docker)

Self-hosted Patch Management Plattform (v2 Release).

---

## 📋 Voraussetzungen

- Docker
- Docker Compose
- Linux Server
- Ports 3010 frei

---

## ⚙️ Installation

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/patchmon/patchmon-setup.sh)"
```

---

## 🧠 Was wird installiert

- PatchMon Backend v2.0.2
- PatchMon Frontend v2.0.2
- PostgreSQL 17
- Redis 7
- Automatische Konfiguration

---

## 🌐 Zugriff

```text
http://<SERVER-IP>:3010
```

---

## ⭐ Empfohlene Konfiguration

### Reverse Proxy (empfohlen)

Nutze Nginx Proxy Manager:

- Domain statt IP verwenden
- HTTPS aktivieren
- Port 3010 intern lassen

---

### Sicherheit

Nach Installation:

- `.env` sichern
- JWT_SECRET geheim halten
- Redis Passwort nicht teilen

---

## 🔐 Passwörter ändern

```bash
cd /home/chris/docker/patchmon
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

- PostgreSQL Daten
- Redis Daten
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

## 🚀 Status

PatchMon läuft in Version:

```text
2.0.2
```
