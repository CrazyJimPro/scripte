# 🚀 DockHand Setup mit Docker

Dieses Repository enthält ein Bash-Skript, um DockHand schnell und einfach in Docker bereitzustellen.

Alle benötigten Dateien und Ordner werden automatisch erstellt.

---

## 📋 Voraussetzungen

- Installiertes Docker
- Installiertes Docker Compose
- Linux mit bash
- Internetzugang

---

## ⚙️ Installation

Führe einfach folgenden Einzeiler aus:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/dockhand/dockhand-setup.sh)"
```

---

## 🛠️ Das Skript erledigt automatisch

- Erstellen des Ordners `/home/chris/docker/dockhand`
- Erstellen des Datenordners
- Generieren der `docker-compose.yml`
- Starten des Containers

---

## 🌐 Zugriff

Nach der Installation erreichst du DockHand unter:

```text
http://<deine-ip>:3033
```

---

## 📂 Projektstruktur

```text
/home/chris/docker/
└── dockhand/
    ├── dockhand_data/
    └── docker-compose.yml
```

---

## 🛑 Container stoppen

```bash
cd /home/chris/docker/dockhand
docker compose down
```

---

## ▶️ Container starten

```bash
cd /home/chris/docker/dockhand
docker compose up -d
```

---

## 🔄 Container aktualisieren

```bash
cd /home/chris/docker/dockhand

docker compose pull
docker compose up -d
```

---

## 💾 Backup

Für ein vollständiges Backup folgende Daten sichern:

```text
/home/chris/docker/dockhand/dockhand_data
```

---

## 🗑️ Deinstallation

Container stoppen:

```bash
cd /home/chris/docker/dockhand

docker compose down
```

Anschließend den Ordner entfernen:

```bash
rm -rf /home/chris/docker/dockhand
```

---

## ✅ Fertig

Dein DockHand-Server ist jetzt einsatzbereit.

Alle Daten werden dauerhaft unter

```text
/home/chris/docker/dockhand
```

gespeichert und bleiben bei Container-Updates erhalten.
