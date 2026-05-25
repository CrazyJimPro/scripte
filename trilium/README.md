# 🚀 TriliumNext Setup mit Docker

Dieses Repository enthält ein Bash-Skript, um TriliumNext schnell und einfach in Docker bereitzustellen.

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
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/trilium/trilium-setup.sh)"
```

---

## 🛠️ Das Skript erledigt automatisch

- Erstellen der Projektstruktur
- Erstellen des Datenordners
- Generieren der docker-compose.yml
- Starten des Containers

---

## 🌐 Zugriff

Nach der Installation erreichst du TriliumNext unter:

```text
http://<deine-ip>:8099
```

---

## 📂 Projektstruktur

```text
trilium/
├── data/
├── docker-compose.yml
└── trilium-setup.sh
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
data/
```

Diesen Ordner regelmäßig sichern.

---

## ✅ Fertig

Dein TriliumNext-Server ist jetzt einsatzbereit.
