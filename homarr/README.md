# 🚀 Homarr Setup mit Docker

Dieses Repository enthält ein Bash-Skript, um Homarr schnell und einfach in Docker bereitzustellen.

Alle benötigten Dateien und Ordner werden automatisch erstellt.

Ein sicherer SECRET_ENCRYPTION_KEY wird automatisch generiert und in einer .env-Datei gespeichert.

---

## 📋 Voraussetzungen

- Installiertes Docker
- Installiertes Docker Compose
- Linux/macOS mit bash
- Vorhandenes Docker Netzwerk "proxy"

---

## ⚙️ Installation

Führe einfach folgenden Einzeiler im gewünschten Verzeichnis aus:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/homarr/homarr-setup.sh)"
```

---

## 🛠️ Das Skript erledigt automatisch

- Erstellen der Projektstruktur
- Generieren eines SECRET_ENCRYPTION_KEY
- Erstellen einer .env-Datei
- Erstellen der docker-compose.yml
- Starten des Containers

---

## 🌐 Zugriff

Nach der Installation erreichst du Homarr unter:

```text
http://<deine-ip>:7575
```

---

## 📂 Projektstruktur

```text
homarr/
├── homarr/
│   └── appdata/
├── .env
├── docker-compose.yml
└── homarr-setup.sh
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

Folgende Daten regelmäßig sichern:

```text
homarr/appdata/
.env
```

---

## ✅ Fertig

Dein Homarr Dashboard ist jetzt einsatzbereit.
