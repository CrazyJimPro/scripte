# 🚀 Heimdall Setup mit Docker

Dieses Repository enthält ein Bash-Skript, um Heimdall schnell und einfach in Docker bereitzustellen.

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
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/heimdall/heimdall-setup.sh)"
```

---

## 🛠️ Das Skript erledigt automatisch

- Erstellen des Ordners `/home/chris/docker/heimdall`
- Erstellen des Konfigurationsordners
- Generieren der `docker-compose.yml`
- Starten des Containers

---

## 🌐 Zugriff

HTTP:

```text
http://<deine-ip>:7202
```

HTTPS:

```text
https://<deine-ip>:7203
```

---

## 📂 Projektstruktur

```text
/home/chris/docker/
└── heimdall/
    ├── config/
    └── docker-compose.yml
```

---

## 🛑 Container stoppen

```bash
cd /home/chris/docker/heimdall
docker compose down
```

---

## ▶️ Container starten

```bash
cd /home/chris/docker/heimdall
docker compose up -d
```

---

## 🔄 Container aktualisieren

```bash
cd /home/chris/docker/heimdall

docker compose pull
docker compose up -d
```

---

## 💾 Backup

Für ein vollständiges Backup folgende Daten sichern:

```text
/home/chris/docker/heimdall/config
```

---

## 🗑️ Deinstallation

Container stoppen:

```bash
cd /home/chris/docker/heimdall

docker compose down
```

Anschließend den Ordner entfernen:

```bash
rm -rf /home/chris/docker/heimdall
```

---

## ✅ Fertig

Dein Heimdall-Dashboard ist jetzt einsatzbereit.

Alle Daten werden dauerhaft unter

```text
/home/chris/docker/heimdall
```

gespeichert und bleiben bei Container-Updates erhalten.
