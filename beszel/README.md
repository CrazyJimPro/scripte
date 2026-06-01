# 🚀 Beszel Setup mit Docker

Dieses Repository enthält ein Bash-Skript, um Beszel schnell und einfach in Docker bereitzustellen.

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
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/beszel/beszel-setup.sh)"
```

---

## 🛠️ Das Skript erledigt automatisch

- Erstellen des Ordners `/home/chris/docker/beszel`
- Erstellen des Datenordners
- Automatisches Anlegen des Docker-Netzwerks `docker`
- Generieren der `docker-compose.yml`
- Starten des Containers

---

## 🌐 Zugriff

Nach der Installation erreichst du Beszel unter:

```text
http://<deine-ip>:8090
```

---

## 📂 Projektstruktur

```text
/home/chris/docker/
└── beszel/
    ├── data/
    └── docker-compose.yml
```

---

## 🛑 Container stoppen

```bash
cd /home/chris/docker/beszel
docker compose down
```

---

## ▶️ Container starten

```bash
cd /home/chris/docker/beszel
docker compose up -d
```

---

## 🔄 Container aktualisieren

```bash
cd /home/chris/docker/beszel

docker compose pull
docker compose up -d
```

---

## 💾 Backup

Für ein vollständiges Backup folgende Daten sichern:

```text
/home/chris/docker/beszel/data
```

---

## 🗑️ Deinstallation

Container stoppen:

```bash
cd /home/chris/docker/beszel

docker compose down
```

Anschließend den Ordner entfernen:

```bash
rm -rf /home/chris/docker/beszel
```

---

## ✅ Fertig

Dein Beszel-Server ist jetzt einsatzbereit.

Alle Daten werden dauerhaft unter

```text
/home/chris/docker/beszel
```

gespeichert und bleiben bei Container-Updates erhalten.
