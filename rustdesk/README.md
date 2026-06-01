# 🚀 RustDesk Server Setup mit Docker

Dieses Repository enthält ein Bash-Skript, um einen eigenen RustDesk-Server schnell und einfach in Docker bereitzustellen.

Alle benötigten Dateien und Ordner werden automatisch erstellt.

---

## 📋 Voraussetzungen

- Installiertes Docker
- Installiertes Docker Compose
- Linux mit bash
- Freigegebene Ports in Router und Firewall

---

## ⚙️ Installation

Führe einfach folgenden Einzeiler aus:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/rustdesk/rustdesk-setup.sh)"
```

---

## 🛠️ Das Skript erledigt automatisch

- Erstellen des Ordners `/home/chris/docker/rustdesk`
- Erstellen des Datenordners
- Generieren der `docker-compose.yml`
- Starten des ID-Servers (hbbs)
- Starten des Relay-Servers (hbbr)

---

## 📂 Projektstruktur

```text
/home/chris/docker/
└── rustdesk/
    ├── data/
    └── docker-compose.yml
```

---

## 🔑 Öffentlichen Schlüssel anzeigen

Nach dem ersten Start erzeugt RustDesk automatisch die Schlüssel.

Anzeigen des Public Keys:

```bash
cat /home/chris/docker/rustdesk/data/id_ed25519.pub
```

Diesen Schlüssel in den RustDesk-Clients hinterlegen.

---

## 🛑 Container stoppen

```bash
cd /home/chris/docker/rustdesk
docker compose down
```

---

## ▶️ Container starten

```bash
cd /home/chris/docker/rustdesk
docker compose up -d
```

---

## 🔄 Container aktualisieren

```bash
cd /home/chris/docker/rustdesk

docker compose pull
docker compose up -d
```

---

## 💾 Backup

Für ein vollständiges Backup folgende Daten sichern:

```text
/home/chris/docker/rustdesk/data
```

Wichtig: Der Ordner enthält die Server-Schlüssel. Ohne diese müssten alle Clients neu konfiguriert werden.

---

## 🗑️ Deinstallation

Container stoppen:

```bash
cd /home/chris/docker/rustdesk

docker compose down
```

Anschließend den Ordner entfernen:

```bash
rm -rf /home/chris/docker/rustdesk
```

---

## 🌐 Erforderliche Ports

Bei Verwendung von `network_mode: host` müssen die folgenden Ports erreichbar sein:

```text
21115/TCP
21116/TCP
21116/UDP
21117/TCP
21118/TCP
21119/TCP
```

Je nach RustDesk-Version können zusätzliche Ports genutzt werden.

---

## ✅ Fertig

Dein eigener RustDesk-Server ist jetzt einsatzbereit.

Alle Daten werden dauerhaft unter

```text
/home/chris/docker/rustdesk
```

gespeichert und bleiben bei Container-Updates erhalten.
