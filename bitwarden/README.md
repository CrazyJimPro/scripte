# Bitwarden_RS (Vaultwarden) Setup Script for Raspberry Pi / Linux

[![Docker](https://img.shields.io/badge/Docker-✔-2496ED?logo=docker&logoColor=white)](https://www.docker.com/) 
[![Raspberry Pi](https://img.shields.io/badge/Raspberry%20Pi-Supported-C51A4A?logo=raspberrypi&logoColor=white)](https://www.raspberrypi.com/)  
[![GitHub stars](https://img.shields.io/github/stars/<BENUTZERNAME>/bitwardenrs-setup?style=social)](https://github.com/<BENUTZERNAME>/bitwardenrs-setup/stargazers) 
[![GitHub forks](https://img.shields.io/github/forks/<BENUTZERNAME>/bitwardenrs-setup?style=social)](https://github.com/<BENUTZERNAME>/bitwardenrs-setup/network/members)  
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Dieses Repository enthält ein Bash-Skript, das die Installation von **Bitwarden_RS** (heute bekannt als [Vaultwarden](https://github.com/dani-garcia/vaultwarden)) über **Docker Compose** automatisiert.  
Es eignet sich besonders für den Einsatz auf einem **Raspberry Pi 5** oder jedem anderen Linux-Server mit Docker.  

---

## ✨ Features

- Erstellt automatisch die benötigte Ordnerstruktur (`data`)  
- Generiert eine `.env` mit sicherem Admin-Token  
- Legt eine passende `docker-compose.yml` an  
- Startet den Bitwarden_RS-Container direkt  
- Unterstützt **spezifische Versionen** oder automatisch die **aktuellste (`latest`)**  
- Erkennt automatisch die lokale IP und zeigt den **Setup-Link** an  

---

## 🚀 Quick Start

### 1. Voraussetzungen

- Docker installiert  
- Docker Compose V2 installiert (`docker compose` verfügbar)  

### 2. Installation mit Einzeiler

👉 Installation mit der neuesten Version (`latest`):

```

bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/bitwarden/bitwardenrs-setup.sh)"
````

👉 Installation mit einer bestimmten Version (z. B. `1.32.0`):

```

bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/bitwarden/bitwardenrs-setup.sh)" 1.32.0
```


---

## 📂 Projektstruktur

Nach der Ausführung des Skripts sieht die Struktur so aus:

```
bitwardenrs/
├── data/       # Vaultwarden-Daten (SQLite DB, Konfig, etc.)
├── .env        # Enthält das Admin-Token und Variablen
└── docker-compose.yml
```

---

## 🔑 Setup

Nach erfolgreicher Installation zeigt das Script einen Link wie diesen an:

```
✅ BitwardenRS Setup abgeschlossen!
Rufe die Weboberfläche auf unter: http://192.168.178.50:8088
Admin-Interface aktivieren mit Token aus .env:
ADMIN_TOKEN=xxxxxxxxxxxxxxxx
```

👉 Das Admin-Interface erreichst du unter:

```
http://deineIP:8088/admin
```

---

## 🔄 Update auf neue Versionen

* Für die **neueste Version** genügt ein erneuter Aufruf des Scripts mit `latest`.
* Für eine **feste Version** einfach die gewünschte Version angeben, z. B.:

```bash
./bitwardenrs-setup.sh 1.33.0
```

---

## 🛠️ Verwaltung

* Container starten:

  ```bash
  docker compose up -d
  ```

* Container stoppen:

  ```bash
  docker compose down
  ```

* Logs anzeigen:

  ```bash
  docker logs -f bitwardenrs
  ```

---

## ⚠️ Hinweise

* Standardmäßig wird Port **8088 (Web-UI)** und **3012 (Websocket)** verwendet.
* Stelle sicher, dass keine anderen Dienste diese Ports blockieren.
* Das Admin-Token wird beim Setup in `.env` gespeichert – diese Datei **nicht veröffentlichen**!

---

## 📜 Lizenz

MIT License – frei zur Nutzung und Anpassung.

