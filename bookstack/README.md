# 🚀 BookStack Setup mit Docker

Dieses Repository enthält ein Bash-Skript, um BookStack schnell und einfach in Docker bereitzustellen.

Alle benötigten Dateien und Ordner werden automatisch erstellt.

Ein sicherer APP_KEY sowie ein Datenbankpasswort werden automatisch generiert und in einer `.env` gespeichert.

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
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/bookstack/bookstack-setup.sh)"
```

---

## 🛠️ Das Skript erledigt automatisch

- Erstellen des Ordners `/home/chris/docker/bookstack`
- Erstellen aller Datenordner
- Generieren eines sicheren APP_KEY
- Generieren eines sicheren Datenbankpassworts
- Erstellen einer `.env`
- Generieren der `docker-compose.yml`
- Starten aller Container
- Warten auf die Datenbankinitialisierung

---

## 🌐 Zugriff

Nach der Installation erreichst du BookStack unter:

```text
http://<deine-ip>:6875
```

---

## 📂 Projektstruktur

```text
/home/chris/docker/
└── bookstack/
    ├── db/
    ├── config/
    ├── uploads/
    ├── .env
    └── docker-compose.yml
```

---

## 🛑 Container stoppen

```bash
cd /home/chris/docker/bookstack
docker compose down
```

---

## ▶️ Container starten

```bash
cd /home/chris/docker/bookstack
docker compose up -d
```

---

## 🔄 Container aktualisieren

```bash
cd /home/chris/docker/bookstack

docker compose pull
docker compose up -d
```

---

## 💾 Backup

Für ein vollständiges Backup folgende Daten sichern:

```text
/home/chris/docker/bookstack/db
/home/chris/docker/bookstack/config
/home/chris/docker/bookstack/uploads
/home/chris/docker/bookstack/.env
```

---

## 🗑️ Deinstallation

Container stoppen:

```bash
cd /home/chris/docker/bookstack

docker compose down
```

Anschließend den Ordner entfernen:

```bash
rm -rf /home/chris/docker/bookstack
```

---

## ✅ Fertig

Dein BookStack-Server ist jetzt einsatzbereit.

Alle Daten werden dauerhaft unter

```text
/ home/chris/docker/bookstack
```

gespeichert und bleiben bei Container-Updates erhalten.
