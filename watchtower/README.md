# Watchtower Setup Script for Raspberry Pi / Linux

[![Docker](https://img.shields.io/badge/Docker-✔-2496ED?logo=docker&logoColor=white)](https://www.docker.com/) 
[![Raspberry Pi](https://img.shields.io/badge/Raspberry%20Pi-Supported-C51A4A?logo=raspberrypi&logoColor=white)](https://www.raspberrypi.com/)  
[![GitHub stars](https://img.shields.io/github/stars/CrazyJimPro/scripte?style=social)](https://github.com/CrazyJimPro/scripte/stargazers) 
[![GitHub forks](https://img.shields.io/github/forks/CrazyJimPro/scripte?style=social)](https://github.com/CrazyJimPro/scripte/network/members)  
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

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/watchtower/watchtower-setup.sh)"
```

---

## 📂 Projektstruktur

Nach der Installation wird lediglich der Container erstellt:

```
watchtower/
└── watchtower-setup.sh      # Installationsskript
```

---

## 🛠️ Verwaltung

* Logs anzeigen:

  ```bash
  docker logs -f watchtower
  ```

* Container stoppen:

  ```bash
  docker stop watchtower
  ```

* Container entfernen:

  ```bash
  docker rm watchtower
  ```

---

## ⚙️ Häufig genutzte Environment-Variablen

| Variable                     | Beschreibung                                                                  |
| ---------------------------- | ----------------------------------------------------------------------------- |
| `WATCHTOWER_CLEANUP`         | Entfernt alte Images nach einem Update (`true/false`)                         |
| `WATCHTOWER_SCHEDULE`        | Cron-Syntax für Update-Intervalle (z. B. `0 0 4 * * *` für 04:00 Uhr täglich) |
| `WATCHTOWER_POLL_INTERVAL`   | Zeit in Sekunden zwischen Update-Checks (Alternative zu `--interval`)         |
| `WATCHTOWER_INCLUDE_STOPPED` | Bezieht auch gestoppte Container in Updates ein                               |
| `WATCHTOWER_MONITOR_ONLY`    | Nur prüfen, keine Updates durchführen (`true/false`)                          |

👉 Standardmäßig nutzt dein Script:

* `WATCHTOWER_CLEANUP=true`
* `--interval 18000` (alle 5 Stunden)

---

## ⚠️ Hinweise

* Standardmäßig überwacht Watchtower **alle Container**.
* Falls nur bestimmte Container aktualisiert werden sollen, können deren Namen im Script am Ende angegeben werden.
* Stelle sicher, dass `/var/run/docker.sock` gemountet wird, sonst funktioniert der Zugriff nicht.
* Watchtower aktualisiert standardmäßig **auch sich selbst**. Willst du das verhindern, schließe den Container über ein Label aus: `--label com.centurylinklabs.watchtower.enable=false`.
* ⚠️ **Sicherheit:** Das Mounten von `/var/run/docker.sock` gibt dem Container faktisch Root-Rechte auf dem Host, da darüber beliebige Docker-Befehle ausgeführt werden können. Nur auf vertrauenswürdigen Systemen einsetzen.

---

## 📜 Lizenz

MIT License – frei zur Nutzung und Anpassung.

