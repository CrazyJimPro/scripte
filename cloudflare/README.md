# 🚀 Cloudflare Tunnel Setup mit Docker

Dieses Repository enthält ein Bash-Skript, um einen Cloudflare Tunnel schnell und einfach in Docker bereitzustellen.

Der Tunnel-Token wird während der Installation abgefragt und automatisch in einer `.env` gespeichert.

---

## 📋 Voraussetzungen

- Installiertes Docker
- Installiertes Docker Compose
- Linux mit bash
- Ein Cloudflare Tunnel Token

---

## ⚙️ Installation

Führe einfach folgenden Einzeiler aus:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/cloudflare/cloudflare-setup.sh)"
```

---

## 🛠️ Das Skript erledigt automatisch

- Erstellen des Ordners `/home/chris/docker/cloudflare`
- Abfrage des Tunnel Tokens
- Erstellen einer `.env`
- Generieren der `docker-compose.yml`
- Starten des Containers

---

## 📂 Projektstruktur

```text
/home/chris/docker/
└── cloudflare/
    ├── cloudflared/
    ├── .env
    └── docker-compose.yml
```

---

## 🛑 Container stoppen

```bash
cd /home/chris/docker/cloudflare
docker compose down
```

---

## ▶️ Container starten

```bash
cd /home/chris/docker/cloudflare
docker compose up -d
```

---

## 🔄 Container aktualisieren

```bash
cd /home/chris/docker/cloudflare

docker compose pull
docker compose up -d
```

---

## 💾 Backup

Für ein vollständiges Backup folgende Dateien sichern:

```text
/home/chris/docker/cloudflare/cloudflared
/home/chris/docker/cloudflare/.env
```

---

## 🗑️ Deinstallation

```bash
cd /home/chris/docker/cloudflare

docker compose down
```

Anschließend den Ordner entfernen:

```bash
rm -rf /home/chris/docker/cloudflare
```

---

## ✅ Fertig

Dein Cloudflare Tunnel ist jetzt einsatzbereit.

Alle Konfigurationsdaten werden dauerhaft unter

```text
/ home/chris/docker/cloudflare
```

gespeichert und bleiben bei Container-Updates erhalten.
