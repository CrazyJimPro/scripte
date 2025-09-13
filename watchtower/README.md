# Watchtower Setup Script for Raspberry Pi / Linux

[![Docker](https://img.shields.io/badge/Docker-✔-2496ED?logo=docker&logoColor=white)](https://www.docker.com/) 
[![Raspberry Pi](https://img.shields.io/badge/Raspberry%20Pi-Supported-C51A4A?logo=raspberrypi&logoColor=white)](https://www.raspberrypi.com/)  
[![GitHub stars](https://img.shields.io/github/stars/<BENUTZERNAME>/watchtower-setup?style=social)](https://github.com/<BENUTZERNAME>/watchtower-setup/stargazers) 
[![GitHub forks](https://img.shields.io/github/forks/<BENUTZERNAME>/watchtower-setup?style=social)](https://github.com/<BENUTZERNAME>/watchtower-setup/network/members)  
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Dieses Repository enthält ein Bash-Skript, das den [Watchtower](https://containrrr.dev/watchtower/) Container installiert.  
Watchtower überprüft regelmäßig alle Docker-Container auf Updates und aktualisiert diese automatisch.  

---

## ✨ Features

- Automatische Updates für **alle laufenden Container**  
- Bereinigt alte Images nach Updates (`WATCHTOWER_CLEANUP=true`)  
- Standard-Intervall: alle **5 Stunden** (`--interval 18000`)  
- Container startet automatisch nach Reboot (`--restart unless-stopped`)  
- Geeignet für **Raspberry Pi** und **Linux-Server**  

---

## 🚀 Quick Start

### 1. Voraussetzungen

- Docker installiert  
- Benutzer hat Rechte, den Docker Daemon (`/var/run/docker.sock`) zu nutzen  

### 2. Installation mit Einzeiler

```

bash -c "$(curl -fsSL https://raw.githubusercontent.com/<BENUTZERNAME>/scripte/main/watchtower/watchtower-setup.sh)"
```

*(ersetze `<BENUTZERNAME>` durch deinen GitHub-Benutzernamen)*


## 📂 Projektstruktur

Nach der Installation wird lediglich der Container erstellt:

```

watchtower/
└── watchtower.sh      # Installationsskript
```

## 🛠️ Verwaltung

* Logs anzeigen:

```

docker logs -f watchtower
```

* Container stoppen:

```
  docker stop watchtower
```

* Container entfernen:

```
  docker rm watchtower
```

---

## ⚠️ Hinweise

* Standardmäßig überwacht Watchtower **alle Container**.
* Falls nur bestimmte Container aktualisiert werden sollen, können deren Namen im Script am Ende angegeben werden.
* Stelle sicher, dass `/var/run/docker.sock` gemountet wird, sonst funktioniert der Zugriff nicht.

---

## 📜 Lizenz

MIT License – frei zur Nutzung und Anpassung.
