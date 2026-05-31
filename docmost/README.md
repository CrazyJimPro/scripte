# 🚀 Docmost Setup mit Docker

Dieses Repository enthält ein Bash-Skript, um Docmost schnell und einfach in Docker bereitzustellen.

Alle benötigten Dateien und Ordner werden automatisch erstellt.

Ein sicherer APP_SECRET sowie ein Datenbankpasswort werden automatisch generiert und in einer `.env` gespeichert.

---

## 📋 Voraussetzungen

- Installiertes Docker
- Installiertes Docker Compose
- Installiertes OpenSSL
- Linux mit bash

---

## ⚙️ Installation

Führe einfach folgenden Einzeiler aus:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/docmost/docmost-setup.sh)"
```

---

## 🛠️ Das Skript erledigt automatisch

- Erstellen des Ordners `/home/chris/docker/docmost`
- Erstellen aller Datenordner
- Generieren eines sicheren `APP_SECRET`
- Generieren eines sicheren Datenbankpassworts
- Erstellen einer `.env`
- Generieren der `docker-compose.yml`
- Starten aller Container

---

## 🌐 Zugriff

Nach der Installation erreichst du Docmost unter:

```text
http://<deine-ip>:3090
```

---

## 📂 Projektstruktur

```text
/home/chris/docker/
└── docmost/
    ├── data/
    ├── db_data/
    ├── redis_data/
    ├── .env
    └── docker-compose.yml
```

---

## 🛑 Container stoppen

```bash
cd /home/chris/docker/docmost
docker compose down
```

---

## ▶️ Container starten

```bash
cd /home/chris/docker/docmost
docker compose up -d
```

---

## 🔄 Container aktualisieren

```bash
cd /home/chris/docker/docmost

docker compose pull
docker compose up -d
```

---

## 💾 Backup

Für ein vollständiges Backup folgende Daten sichern:

```text
/home/chris/docker/docmost/data
/home/chris/docker/docmost/db_data
/home/chris/docker/docmost/redis_data
/home/chris/docker/docmost/.env
```

---

## 🗑️ Deinstallation

Container stoppen:

```bash
cd /home/chris/docker/docmost

docker compose down
```

Anschließend den Ordner entfernen:

```bash
rm -rf /home/chris/docker/docmost
```

---

## ✅ Fertig

Dein Docmost-Server ist jetzt einsatzbereit.

Alle Daten werden dauerhaft unter

```text
/home/chris/docker/docmost
```

gespeichert und bleiben bei Container-Updates erhalten.
