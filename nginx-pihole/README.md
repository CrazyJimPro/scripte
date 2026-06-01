# 🚀 Nginx Proxy Manager + Pi-hole Setup mit Docker

Dieses Repository enthält ein Bash-Skript, um Nginx Proxy Manager und Pi-hole gemeinsam in Docker bereitzustellen.

Alle benötigten Dateien und Ordner werden automatisch erstellt.

---

## 📋 Voraussetzungen

- Installiertes Docker
- Installiertes Docker Compose
- Linux mit bash
- Freie Ports 53, 80, 81 und 443

---

## ⚙️ Installation

Führe einfach folgenden Einzeiler aus:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/nginx-pihole/nginx-pihole-setup.sh)"
```

---

## 🛠️ Das Skript erledigt automatisch

- Erstellen des Ordners `/home/chris/docker/nginx-pihole`
- Erstellen der Docker-Netzwerke
- Erstellen der `.env`
- Generieren der `docker-compose.yml`
- Starten aller Container

---

## 🌐 Zugriff

### Nginx Proxy Manager

```text
http://<deine-ip>:81
```

Standard Login:

```text
E-Mail: admin@example.com
Passwort: changeme
```

Beim ersten Login musst du die Zugangsdaten ändern.

### Pi-hole

```text
http://<deine-ip>:8081/admin
```

Standard Passwort:

```text
PaSSW0rd
```

---

## ⭐ Empfohlene Konfiguration

### Nginx Proxy Manager

- Direkt nach dem ersten Login E-Mail-Adresse und Passwort ändern
- Für jeden Dienst HTTPS aktivieren
- Let's Encrypt Zertifikate verwenden

### Pi-hole

Empfohlene Upstream-DNS Server:

```text
https://dns10.quad9.net/dns-query
https://1.1.1.1/dns-query
```

Empfohlene Blockliste:

```text
https://big.oisd.nl/
```

### Cloudflare Tunnel

Falls Cloudflare Tunnel genutzt wird:

- Nur Nginx Proxy Manager veröffentlichen
- Pi-hole nicht direkt ins Internet stellen

---

## 🔐 Passwörter ändern

Die Standardpasswörter werden in der Datei

```text
/home/chris/docker/nginx-pihole/.env
```

gespeichert.

Beispiel:

```text
DB_PASSWORD=npmpass
PIHOLE_PASSWORD=PaSSW0rd
```

Nach einer Änderung Container neu starten:

```bash
cd /home/chris/docker/nginx-pihole
docker compose up -d
```

Pi-hole Passwort alternativ direkt ändern:

```bash
docker exec -it pihole pihole setpassword
```

---

## 📂 Projektstruktur

```text
/home/chris/docker/
└── nginx-pihole/
    ├── data/
    ├── letsencrypt/
    ├── postgres-data/
    ├── pihole/
    │   └── etc-pihole/
    ├── .env
    └── docker-compose.yml
```

---

## 🛑 Container stoppen

```bash
cd /home/chris/docker/nginx-pihole
docker compose down
```

---

## ▶️ Container starten

```bash
cd /home/chris/docker/nginx-pihole
docker compose up -d
```

---

## 🔄 Container aktualisieren

```bash
cd /home/chris/docker/nginx-pihole

docker compose pull
docker compose up -d
```

---

## 💾 Backup

Für ein vollständiges Backup folgende Daten sichern:

```text
/home/chris/docker/nginx-pihole/data
/home/chris/docker/nginx-pihole/letsencrypt
/home/chris/docker/nginx-pihole/postgres-data
/home/chris/docker/nginx-pihole/pihole
/home/chris/docker/nginx-pihole/.env
```

---

## 🗑️ Deinstallation

```bash
cd /home/chris/docker/nginx-pihole
docker compose down

rm -rf /home/chris/docker/nginx-pihole
```

---

## ✅ Fertig

Nginx Proxy Manager und Pi-hole sind jetzt einsatzbereit.

Alle Daten werden dauerhaft unter

```text
/home/chris/docker/nginx-pihole
```

gespeichert und bleiben bei Container-Updates erhalten.
