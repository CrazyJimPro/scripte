# 🚀 Heimdall Setup

[![Docker](https://img.shields.io/badge/Docker-✔-blue)](https://www.docker.com/)
[![Linux](https://img.shields.io/badge/Linux-✔-yellow)](https://www.kernel.org/)
[![Heimdall](https://img.shields.io/badge/Heimdall-✔-green)](https://github.com/linuxserver/Heimdall)

Ein automatisiertes Setup-Skript für [Heimdall](https://github.com/linuxserver/Heimdall) mit Docker Compose.  
Heimdall ist ein eleganter **Application Dashboard** für deine selbstgehosteten Dienste.

---

## 📂 Projektstruktur



heimdall/
├── config/                # Konfigurationsordner von Heimdall
├── docker-compose.yml     # Docker Compose Datei
└── heimdall-setup.sh      # Setup-Skript

````

---

## ⚙️ Installation

1. Repository klonen oder nur das Script verwenden:
   ```bash
   git clone https://github.com/CrazyJimPro/scripte.git
   cd scripte/heimdall
````

2. Setup-Skript starten:

   ```bash
   bash heimdall-setup.sh
   ```

   Oder als **Einzeiler direkt von GitHub**:

   ```bash
   bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/heimdall/heimdall-setup.sh)"
   ```

---

## 🌐 Zugriff

Nach der Installation erreichst du Heimdall unter:

* **HTTP:** `http://<deine-ip>:7202`
* **HTTPS:** `https://<deine-ip>:7203`

Standardmäßig werden deine Konfigurationen im Ordner
`heimdall/config` gespeichert.

---

## 🔄 Update auf neue Version

Um Heimdall auf die neueste Version zu aktualisieren:

```bash
cd ~/scripte/heimdall
docker compose pull
docker compose up -d
```

---

## 🛠️ Anforderungen

* Linux-Server (z. B. Ubuntu, Debian)
* Docker & Docker Compose installiert
* Port **7202** (HTTP) und **7203** (HTTPS) frei

---

✨ Fertig – dein Heimdall Dashboard läuft jetzt!

```

---

👉 Soll ich dir diese `README.md` auch gleich als fertige Datei im GitHub-Repo unter `scripte/heimdall/README.md` ablegen, so wie bei Authentik und den anderen?
```
