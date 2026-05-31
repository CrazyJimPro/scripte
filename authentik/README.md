# Authentik Setup Script for Raspberry Pi / Linux

[![Docker](https://img.shields.io/badge/Docker-✔-2496ED?logo=docker&logoColor=white)](https://www.docker.com/) 
[![Raspberry Pi](https://img.shields.io/badge/Raspberry%20Pi-Supported-C51A4A?logo=raspberrypi&logoColor=white)](https://www.raspberrypi.com/)  
[![GitHub stars](https://img.shields.io/github/stars/<BENUTZERNAME>/authentik-setup?style=social)](https://github.com/<BENUTZERNAME>/authentik-setup/stargazers) 
[![GitHub forks](https://img.shields.io/github/forks/<BENUTZERNAME>/authentik-setup?style=social)](https://github.com/<BENUTZERNAME>/authentik-setup/network/members)  
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Dieses Repository enthält ein Bash-Skript, das die Installation von [Authentik](https://goauthentik.io/) über **Docker Compose** automatisiert.  
Es eignet sich besonders für den Einsatz auf einem **Raspberry Pi 5** oder jedem anderen Linux-Server mit Docker.  

---

## ✨ Features

- Erstellt automatisch die benötigte Ordnerstruktur (`database`, `redis`, `authentik`)  
- Generiert eine `.env` mit sicheren Zufallswerten  
- Legt eine passende `docker-compose.yml` an (ohne veraltetes `version:`-Feld)  
- Startet **Postgres, Redis, Authentik Server & Worker** direkt  
- Unterstützt **spezifische Versionen** oder automatisch die **aktuellste (`latest`)**  
- Erkennt automatisch die lokale IP und zeigt den **Setup-Link** an  

---

## 🚀 Quick Start

### 1. Voraussetzungen

- Docker installiert  
- Docker Compose V2 installiert (`docker compose` verfügbar)  

### 2. Installation mit Einzeiler

👉 Installation mit der neuesten Version (`latest`):

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/authentik/authentik-setup.sh)"

````

👉 Installation mit einer bestimmten Version (z. B. `2025.8.1`):

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/authentik/authentik-setup.sh)" 2025.8.1
```


---

## 📂 Projektstruktur

Nach der Ausführung des Skripts sieht die Struktur so aus:

```
authentik/
├── database/               # PostgreSQL-Daten
├── redis/                  # Redis-Daten
├── authentik/
│   ├── media/              # Authentik Media-Dateien
│   └── custom-templates/   # Eigene Templates
├── .env                    # Automatisch generierte Umgebungsvariablen
└── docker-compose.yml      # Compose-Datei für Authentik
```

---

## 🔑 Setup

Nach erfolgreicher Installation zeigt das Script einen Link wie diesen an:

```
✅ Authentik Setup abgeschlossen!
Rufe den Initial Setup Wizard auf unter: http://192.168.178.50:9010/if/flow/initial-setup/
```

👉 Dort kannst du deinen ersten **Admin-Account** erstellen.

---

## 🔄 Update auf neue Versionen

* Für die **neueste Version** genügt ein erneuter Aufruf des Scripts mit `latest`.
* Für eine **feste Version** einfach die gewünschte Version angeben, z. B.:

```bash
./authentik-setup.sh 2025.9.0
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
  docker logs -f authentik-server
  ```

---

## ⚠️ Hinweise

* Standardmäßig wird Port **9010 (HTTP)** und **9444 (HTTPS)** verwendet.
* Stelle sicher, dass keine anderen Dienste diese Ports blockieren.
* Passwörter und Secrets werden automatisch in `.env` generiert – diese Datei **nicht veröffentlichen**!

---

## 📜 Lizenz

MIT License – frei zur Nutzung und Anpassung.
