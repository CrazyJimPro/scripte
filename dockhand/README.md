# 🚀 DockHand Setup mit Docker

Dieses Repository enthält ein Bash-Skript, um DockHand schnell und einfach in Docker bereitzustellen.

Alle benötigten Dateien und Ordner werden automatisch erstellt.

---

## 📋 Voraussetzungen

- Installiertes Docker
- Installiertes Docker Compose
- Linux/macOS mit bash
- Internetzugang

---

## ⚙️ Installation

Führe einfach folgenden Einzeiler im gewünschten Verzeichnis aus:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/dockhand/dockhand-setup.sh)"
```

---

## 🛠️ Das Skript erledigt automatisch

- Erstellen der Projektstruktur
- Erstellen des Datenordners
- Generieren der docker-compose.yml
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
dockhand/
├── dockhand_data/
├── docker-compose.yml
└── dockhand-setup.sh
```

---

## 🛑 Container stoppen

```bash
docker compose down
```

---

## ▶️ Container starten

```bash
docker compose up -d
```

---

## 🔄 Backup

Wichtige Daten befinden sich im Ordner:

```text
dockhand_data/
```

Diesen Ordner regelmäßig sichern.

---

## ✅ Fertig

Dein DockHand-Server ist jetzt einsatzbereit.
