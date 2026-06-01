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

Setup Wizard:

```text
http://<deine-ip>:3030
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

## ⭐ Empfohlene Konfiguration

Nach dem ersten Login empfiehlt es sich, sichere DNS-over-HTTPS-Server als Upstream-DNS einzutragen.

### Quad9

```text
https://dns10.quad9.net/dns-query
```

### Cloudflare

```text
https://1.1.1.1/dns-query
```

### Kombination (Empfohlen)

```text
https://dns10.quad9.net/dns-query
https://1.1.1.1/dns-query
```

Vorteile:

- DNS-Anfragen werden verschlüsselt übertragen
- Schutz vor DNS-Manipulation
- Höhere Privatsphäre
- Quad9 blockiert bekannte Malware-Domains
- Cloudflare bietet sehr schnelle Antwortzeiten

---

## 🔒 DNS-Blocklisten

Für einen guten Werbe-, Tracking- und Malware-Schutz empfiehlt sich mindestens folgende Blockliste:

### OISD Full

```text
https://big.oisd.nl/
```

OISD kombiniert zahlreiche bekannte Werbe-, Tracking- und Malware-Listen und gilt als eine der beliebtesten Konfigurationen für AdGuard Home.

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
3030/tcp (Setup Wizard)
```

---

## ✅ Fertig

Dein AdGuard Home Server ist jetzt einsatzbereit.

Alle Daten werden dauerhaft unter

```text
/home/chris/docker/adguardhome
```

gespeichert und bleiben bei Container-Updates erhalten.
