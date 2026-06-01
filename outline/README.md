# 🚀 Outline Setup mit Docker

Dieses Repository enthält ein Bash-Skript, um Outline schnell und einfach in Docker bereitzustellen.

Alle benötigten Dateien und Ordner werden automatisch erstellt.

Secrets, Datenbankpasswort und OIDC-Zugangsdaten werden in einer `.env` gespeichert.

---

## 📋 Voraussetzungen

- Installiertes Docker
- Installiertes Docker Compose
- Installiertes OpenSSL
- Ein eingerichteter Authentik OIDC Provider

---

## ⚙️ Installation

Führe einfach folgenden Einzeiler aus:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/outline/outline-setup.sh)"
```

---

## 🛠️ Das Skript erledigt automatisch

- Erstellen des Ordners `/home/chris/docker/outline`
- Erstellen aller Datenordner
- Generieren aller benötigten Secrets
- Abfrage von OIDC Client ID und Secret
- Erstellen einer `.env`
- Generieren der `docker-compose.yml`
- Starten aller Container

---

## 🌐 Zugriff

Nach der Installation erreichst du Outline unter:

```text
http://<deine-ip>:3024
```

---

## 📂 Projektstruktur

```text
/home/chris/docker/
└── outline/
    ├── db/
    ├── redis/
    ├── data/
    ├── .env
    └── docker-compose.yml
```

---

## 🛑 Container stoppen

```bash
cd /home/chris/docker/outline
docker compose down
```

---

## ▶️ Container starten

```bash
cd /home/chris/docker/outline
docker compose up -d
```

---

## 🔄 Container aktualisieren

```bash
cd /home/chris/docker/outline

docker compose pull
docker compose up -d
```

---

## 💾 Backup

Für ein vollständiges Backup folgende Daten sichern:

```text
/home/chris/docker/outline/db
/home/chris/docker/outline/redis
/home/chris/docker/outline/data
/home/chris/docker/outline/.env
```

---

## 🗑️ Deinstallation

Container stoppen:

```bash
cd /home/chris/docker/outline

docker compose down
```

Anschließend den Ordner entfernen:

```bash
rm -rf /home/chris/docker/outline
```

---

## ✅ Fertig

Dein Outline-Server ist jetzt einsatzbereit.

Alle Daten werden dauerhaft unter

```text
/home/chris/docker/outline
```

gespeichert und bleiben bei Container-Updates erhalten.
