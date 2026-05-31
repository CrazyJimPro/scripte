# 🚀 Cloudflare Tunnel Setup mit Docker

Dieses Repository enthält ein Bash-Skript, um einen Cloudflare Tunnel schnell und einfach in Docker bereitzustellen.

Der Tunnel-Token wird während der Installation abgefragt und automatisch in einer `.env` gespeichert.

---

## 📋 Voraussetzungen

- Installiertes Docker
- Installiertes Docker Compose
- Linux/macOS mit bash
- Ein vorhandener Cloudflare Tunnel Token

---

## ⚙️ Installation

Führe einfach folgenden Einzeiler im gewünschten Verzeichnis aus:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/cloudflare/cloudflare-setup.sh)"
```

---

## 🛠️ Das Skript erledigt automatisch

- Erstellen der Projektstruktur
- Abfrage des Tunnel Tokens
- Erstellen einer `.env`
- Generieren der docker-compose.yml
- Starten des Containers

---

## 📂 Projektstruktur

```text
cloudflare/
├── cloudflared/
├── .env
├── docker-compose.yml
└── cloudflare-setup.sh
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

Folgende Dateien sichern:

```text
cloudflared/
.env
```

---

## ✅ Fertig

Der Cloudflare Tunnel wird automatisch nach dem Containerstart verbunden.
