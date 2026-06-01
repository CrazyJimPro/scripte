# 🚀 PatchMon Setup mit Docker

Self-hosted Patch Management Plattform.

---

## 📋 Voraussetzungen

- Docker
- Docker Compose
- Linux Server

---

## ⚙️ Installation

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/patchmon/patchmon-setup.sh)"
```

---

## 🛠️ Automatisch erstellt

- PostgreSQL Database
- Redis Cache
- Backend API
- Frontend UI
- sichere Passwörter
- `.env` Datei

---

## 🌐 Zugriff

```text
http://<IP>:3010
```

---

## ⭐ Empfohlene Konfiguration

### 1. Reverse Proxy

Empfohlen über Nginx Proxy Manager:

- Domain statt IP verwenden
- HTTPS aktivieren

---

### 2. Sicherheit

Nach Installation unbedingt:

- `.env` Datei sichern
- Passwörter nicht öffentlich speichern
- JWT_SECRET geheim halten

---

### 3. Redis Passwort

Änderbar in:

```text
/home/chris/docker/patchmon/.env
```

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

Wichtig:

- postgres_data
- redis_data
- agent_files
- .env
```

---


## 🗑️ Deinstallation


```bash
cd /home/chris/docker/patchmon
docker compose down
rm -rf /home/chris/docker/patchmon
```

---

## ✅ Fertig

PatchMon ist einsatzbereit.
