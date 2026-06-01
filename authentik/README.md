# 🚀 Authentik Setup mit Docker

Dieses Repository enthält ein Bash-Skript, um Authentik schnell und einfach in Docker bereitzustellen.

Alle benötigten Dateien und Ordner werden automatisch erstellt.

Ein sicherer Secret Key sowie ein PostgreSQL-Passwort werden automatisch generiert und in einer `.env` gespeichert.

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
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/authentik/authentik-setup.sh)"
```

---

## 🛠️ Das Skript erledigt automatisch

- Erstellen des Ordners `/home/chris/docker/authentik`
- Erstellen aller Datenordner
- Generieren eines sicheren Secret Keys
- Generieren eines PostgreSQL-Passworts
- Erstellen einer `.env`
- Generieren der `docker-compose.yml`
- Starten aller Container

---

## 🌐 Zugriff

Initial Setup Wizard:

```text
http://<deine-ip>:9010/if/flow/initial-setup/
```

Weboberfläche:

```text
http://<deine-ip>:9010
```

HTTPS:

```text
https://<deine-ip>:9444
```

---

## 📂 Projektstruktur

```text
/home/chris/docker/
└── authentik/
    ├── database/
    ├── redis/
    ├── authentik/
    │   ├── media/
    │   └── custom-templates/
    ├── .env
    └── docker-compose.yml
```

---

## 🛑 Container stoppen

```bash
cd /home/chris/docker/authentik
docker compose down
```

---

## ▶️ Container starten

```bash
cd /home/chris/docker/authentik
docker compose up -d
```

---

## 🔄 Container aktualisieren

```bash
cd /home/chris/docker/authentik

docker compose pull
docker compose up -d
```

---

## 💾 Backup

Für ein vollständiges Backup folgende Daten sichern:

```text
/home/chris/docker/authentik/database
/home/chris/docker/authentik/redis
/home/chris/docker/authentik/authentik/media
/home/chris/docker/authentik/authentik/custom-templates
/home/chris/docker/authentik/.env
```

---

## 🗑️ Deinstallation

Container stoppen:

```bash
cd /home/chris/docker/authentik

docker compose down
```

Anschließend den Ordner entfernen:

```bash
rm -rf /home/chris/docker/authentik
```

---

## ✅ Fertig

Dein Authentik-Server ist jetzt einsatzbereit.

Alle Daten werden dauerhaft unter

```text
/home/chris/docker/authentik
```

gespeichert und bleiben bei Container-Updates erhalten.
