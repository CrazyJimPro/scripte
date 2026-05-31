# 🚀 TriliumNext Setup mit Docker

Dieses Repository enthält ein Bash-Skript, um TriliumNext schnell und einfach in Docker bereitzustellen.

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
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/trilium/trilium-setup.sh)"
```

---

## 🛠️ Das Skript erledigt automatisch

- Erstellen des Ordners `/home/chris/docker/trilium`
- Erstellen des Datenordners
- Generieren der `docker-compose.yml`
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
/home/chris/docker/
└── trilium/
    ├── data/
    └── docker-compose.yml
```

---

## 🛑 Container stoppen

```bash
cd /home/chris/docker/trilium
docker compose down
```

---

## ▶️ Container starten

```bash
cd /home/chris/docker/trilium
docker compose up -d
```

---

## 🔄 Container aktualisieren

```bash
cd /home/chris/docker/trilium

docker compose pull
docker compose up -d
```

---

## 💾 Backup

Für ein vollständiges Backup folgende Daten sichern:

```text
/home/chris/docker/trilium/data
```

---

## 🗑️ Deinstallation

Container stoppen:

```bash
cd /home/chris/docker/trilium

docker compose down
```

Anschließend den Ordner entfernen:

```bash
rm -rf /home/chris/docker/trilium
```

---

## ✅ Fertig

Dein TriliumNext-Server ist jetzt einsatzbereit.

Alle Daten werden dauerhaft unter

```text
/home/chris/docker/trilium
```

gespeichert und bleiben bei Container-Updates erhalten.
