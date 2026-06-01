# 🚀 AdGuard Home Setup mit Docker

Dieses Repository enthält ein Bash-Skript, um AdGuard Home schnell und einfach in Docker bereitzustellen.

Alle benötigten Dateien und Ordner werden automatisch erstellt.

---

## 📋 Voraussetzungen

- Installiertes Docker
- Installiertes Docker Compose
- Linux mit bash
- Freier Port 53 auf dem Host

---

## ⚠️ Wichtiger Hinweis

AdGuard Home benötigt standardmäßig Port 53.

Falls bereits ein DNS-Dienst läuft (z. B. Pi-hole, systemd-resolved, DNSMasq oder ein anderer DNS-Server), muss dieser zuvor deaktiviert oder umkonfiguriert werden.

---

## ⚙️ Installation

Führe einfach folgenden Einzeiler aus:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/adguardhome/adguardhome-setup.sh)"
```

---

## 🛠️ Das Skript erledigt automatisch

- Erstellen des Ordners `/home/chris/docker/adguardhome`
- Erstellen aller Datenordner
- Generieren der `docker-compose.yml`
- Starten des Containers

---

## 🌐 Zugriff

### Erster Start

Einrichtungsassistent:

```text
http://<deine-ip>:3001
```

### Nach Abschluss des Assistenten

Weboberfläche:

```text
http://<deine-ip>
```

oder

```text
https://<deine-ip>
```

---

## 📂 Projektstruktur

```text
/home/chris/docker/
└── adguardhome/
    ├── conf/
    ├── work/
    └── docker-compose.yml
```

---

## 🛑 Container stoppen

```bash
cd /home/chris/docker/adguardhome
docker compose down
```

---

## ▶️ Container starten

```bash
cd /home/chris/docker/adguardhome
docker compose up -d
```

---

## 🔄 Container aktualisieren

```bash
cd /home/chris/docker/adguardhome

docker compose pull
docker compose up -d
```

---

## 💾 Backup

Für ein vollständiges Backup folgende Daten sichern:

```text
/home/chris/docker/adguardhome/conf
/home/chris/docker/adguardhome/work
```

---

## 🗑️ Deinstallation

Container stoppen:

```bash
cd /home/chris/docker/adguardhome

docker compose down
```

Anschließend den Ordner entfernen:

```bash
rm -rf /home/chris/docker/adguardhome
```

---

## 🔌 Verwendete Ports

```text
53/tcp
53/udp
67/udp (DHCP)
80/tcp
443/tcp
3001/tcp
```

---

## ✅ Fertig

Dein AdGuard Home Server ist jetzt einsatzbereit.

Alle Daten werden dauerhaft unter

```text
/home/chris/docker/adguardhome
```

gespeichert und bleiben bei Container-Updates erhalten.
