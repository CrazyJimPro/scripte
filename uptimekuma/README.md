# 🚀 Uptime Kuma Setup mit Docker

Dieses Repository enthält ein Bash-Skript, um Uptime Kuma schnell und einfach in Docker bereitzustellen.

Alle benötigten Dateien und Ordner werden automatisch erstellt.

---

## 📋 Voraussetzungen

- Installiertes Docker
- Installiertes Docker Compose
- Linux mit bash

---

## ⚙️ Installation

Führe einfach folgenden Einzeiler aus:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/uptime-kuma/uptime-kuma-setup.sh)"
```

---

## 🛠️ Das Skript erledigt automatisch

- Erstellen des Ordners `/home/chris/docker/uptime-kuma`
- Erstellen des Datenordners
- Generieren der `docker-compose.yml`
- Starten des Containers

---

## 🌐 Zugriff

Nach der Installation erreichst du Uptime Kuma unter:

```text
http://<deine-ip>:3001
```

Beim ersten Aufruf wird automatisch der Administrator-Account eingerichtet.

---

## 📂 Projektstruktur

```text
/home/chris/docker/
└── uptime-kuma/
    ├── data/
    └── docker-compose.yml
```

---

## 🛑 Container stoppen

```bash
cd /home/chris/docker/uptime-kuma
docker compose down
```

---

## ▶️ Container starten

```bash
cd /home/chris/docker/uptime-kuma
docker compose up -d
```

---

## 🔄 Container aktualisieren

```bash
cd /home/chris/docker/uptime-kuma

docker compose pull
docker compose up -d
```

---

## 💾 Backup

Für ein vollständiges Backup folgende Daten sichern:

```text
/home/chris/docker/uptime-kuma/data
```

---

## 🗑️ Deinstallation

Container stoppen:

```bash
cd /home/chris/docker/uptime-kuma

docker compose down
```

Anschließend den Ordner entfernen:

```bash
rm -rf /home/chris/docker/uptime-kuma
```

---

## ✅ Fertig

Dein Uptime-Kuma-Server ist jetzt einsatzbereit.

Alle Daten werden dauerhaft unter

```text
/home/chris/docker/uptime-kuma
```

gespeichert und bleiben bei Container-Updates erhalten.
