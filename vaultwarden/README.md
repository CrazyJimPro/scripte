# 🚀 Vaultwarden Setup mit Docker

Dieses Repository enthält ein Bash-Skript, um Vaultwarden schnell und einfach in Docker bereitzustellen.

Ein sicherer Admin-Token wird automatisch generiert und in einer `.env` gespeichert.

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
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/vaultwarden/vaultwarden-setup.sh)"
```

---

## 🛠️ Das Skript erledigt automatisch

- Erstellen des Ordners `/home/chris/docker/vaultwarden`
- Erstellen des Datenordners
- Generieren eines sicheren Admin-Tokens
- Erstellen einer `.env`
- Generieren der `docker-compose.yml`
- Starten des Containers

---

## 🌐 Zugriff

Weboberfläche:

```text
http://<deine-ip>:8088
```

Admin-Bereich:

```text
http://<deine-ip>:8088/admin
```

---

## 📂 Projektstruktur

```text
/home/chris/docker/
└── vaultwarden/
    ├── data/
    ├── .env
    └── docker-compose.yml
```

---

## 🛑 Container stoppen

```bash
cd /home/chris/docker/vaultwarden
docker compose down
```

---

## ▶️ Container starten

```bash
cd /home/chris/docker/vaultwarden
docker compose up -d
```

---

## 🔄 Container aktualisieren

```bash
cd /home/chris/docker/vaultwarden

docker compose pull
docker compose up -d
```

---

## 💾 Backup

Für ein vollständiges Backup folgende Daten sichern:

```text
/home/chris/docker/vaultwarden/data
/home/chris/docker/vaultwarden/.env
```

---

## 🗑️ Deinstallation

Container stoppen:

```bash
cd /home/chris/docker/vaultwarden

docker compose down
```

Anschließend den Ordner entfernen:

```bash
rm -rf /home/chris/docker/vaultwarden
```

---

## 🔑 Admin Token anzeigen

```bash
grep ADMIN_TOKEN /home/chris/docker/vaultwarden/.env
```

---

## ✅ Fertig

Dein Vaultwarden-Server ist jetzt einsatzbereit.

Alle Daten werden dauerhaft unter

```text
/home/chris/docker/vaultwarden
```

gespeichert und bleiben bei Container-Updates erhalten.
