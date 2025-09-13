# 📦 Script-Sammlung (Docker Setups)

Dieses Repository enthält eine Sammlung von **Bash-Skripten**, die automatisch Docker-Container mit den passenden **docker-compose.yml** und `.env`-Dateien erstellen.  
Alle Skripte folgen dem gleichen Aufbau, sodass du deine Services mit **einem einzigen Befehl** starten kannst. 🚀  

---

## 📋 Voraussetzungen

- Linux/macOS Terminal mit `bash`
- Installiertes **Docker** & **Docker Compose**

---

## ⚙️ Aktuell verfügbare Skripte

| Script               | Beschreibung |
|----------------------|--------------|
| `authentik-setup.sh` | Setup von [Authentik](https://goauthentik.io/) mit PostgreSQL & Redis |
| `pihole-setup.sh`    | Setup von [Pi-hole](https://pi-hole.net/) im Docker Container |
| `heimdall-setup.sh`  | Setup von [Heimdall Dashboard](https://heimdall.site/) |
| `bookstack-setup.sh` | Setup von [Bookstack](https://www.bookstackapp.com/) (ARM64 kompatibel) |
| `docmost-setup.sh`   | Setup von [Docmost](https://github.com/docmost/docmost) mit PostgreSQL & Redis |

---

## ▶️ Nutzung

Beispiel für die Ausführung eines Scripts (z. B. Docmost):

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/docmost/docmost-setup.sh)"
```

Nach der Ausführung:

* werden automatisch alle benötigten Ordner erstellt
* eine `.env` mit zufälligen Passwörtern & Keys angelegt
* die Container gestartet (`docker compose up -d`)

---

## 📂 Struktur

Jedes Setup-Script erstellt seine eigene Projektstruktur, z. B. für Docmost:

```
docmost/
├── data/
├── db_data/
├── redis_data/
├── .env
├── docker-compose.yml
└── docmost-setup.sh
```

---

## ✅ Ziel

Diese Sammlung soll dir helfen, schnell und unkompliziert verschiedene **Selfhosted Services** mit Docker einzurichten.
Neue Skripte können einfach ergänzt werden.

```
