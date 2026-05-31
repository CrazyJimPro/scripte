# 🚀 Homarr Setup mit Docker

Dieses Repository enthält ein Bash-Skript, um Homarr schnell und einfach in Docker bereitzustellen.

Ein sicherer `SECRET_ENCRYPTION_KEY` wird automatisch generiert und in einer `.env` gespeichert.

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
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/homarr/homarr-setup.sh)"
```

---

## 🛠️ Das Skript erledigt automatisch

- Erstellen des Ordners `/home/chris/docker/homarr`
- Erstellen des Datenordners
- Generieren eines sicheren `SECRET_ENCRYPTION_KEY`
- Erstellen einer `.env`
- Automatisches Anlegen des Docker-Netzwerks `proxy`
- Generieren der `docker-compose.yml`
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
/home/chris/docker/
└── homarr/
    ├── appdata/
    ├── .env
    └── docker-compose.yml
```

---

## 🛑 Container stoppen

```bash
cd /home/chris/docker/homarr
docker compose down
```

---

## ▶️ Container starten

```bash
cd /home/chris/docker/homarr
docker compose up -d
```

---

## 🔄 Container aktualisieren

```bash
cd /home/chris/docker/homarr

docker compose pull
docker compose up -d
```

---

## 💾 Backup

Für ein vollständiges Backup folgende Daten sichern:

```text
/home/chris/docker/homarr/appdata
/home/chris/docker/homarr/.env
```

---

## 🗑️ Deinstallation

Container stoppen:

```bash
cd /home/chris/docker/homarr

docker compose down
```

Anschließend den Ordner entfernen:

```bash
rm -rf /home/chris/docker/homarr
```

---

## ✅ Fertig

Dein Homarr Dashboard ist jetzt einsatzbereit.

Alle Daten werden dauerhaft unter

```text
/home/chris/docker/homarr
```

gespeichert und bleiben bei Container-Updates erhalten.
