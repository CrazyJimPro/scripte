# 🚀 Paperless Scanner Setup mit Docker

Dieses Repository enthält ein Bash-Skript, um Paperless Scanner schnell und einfach in Docker bereitzustellen.

Alle benötigten Dateien und Ordner werden automatisch erstellt.

---

## 📋 Voraussetzungen

- Installiertes Docker
- Installiertes Docker Compose
- Linux mit bash
- Unterstützter USB-Scanner
- Paperless-ngx (optional für den automatischen Import)

---

## ⚙️ Installation

Führe einfach folgenden Einzeiler aus:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/paperless-scanner/paperless-scanner-setup.sh)"
```

---

## 🛠️ Das Skript erledigt automatisch

- Erstellen des Ordners `/home/chris/docker/paperless-scanner`
- Erstellen aller benötigten Verzeichnisse
- Generieren der `docker-compose.yml`
- Starten des Containers

---

## 🌐 Zugriff

Nach der Installation erreichst du Paperless Scanner unter:

```text
http://<deine-ip>:3000
```

---

## ⭐ Empfohlene Konfiguration

### Scanner konfigurieren

Nach dem ersten Start:

1. Scanner einschalten
2. Scanner per USB verbinden
3. Oberfläche öffnen
4. Scanner auswählen
5. Testscan durchführen

### Verbindung mit Paperless-ngx

Wenn Paperless-ngx verwendet wird, empfiehlt es sich, den Consume-Ordner von Paperless als Zielordner zu konfigurieren.

Beispiel:

```text
/home/chris/docker/paperless-ngx/consume
```

Dadurch werden Dokumente automatisch importiert.

### PDF statt Bilder

Empfohlene Einstellungen:

```text
Dateiformat: PDF
Farbe: Automatisch
Auflösung: 300 DPI
Duplex: Aktivieren (falls verfügbar)
```

Diese Einstellungen liefern meist die beste Qualität für OCR.

### OCR in Paperless-ngx

Für optimale Suchergebnisse sollte die Texterkennung später von Paperless-ngx übernommen werden.

---

## 📂 Projektstruktur

```text
/home/chris/docker/
└── paperless-scanner/
    ├── consume/
    ├── config/
    └── docker-compose.yml
```

---

## 🛑 Container stoppen

```bash
cd /home/chris/docker/paperless-scanner
docker compose down
```

---

## ▶️ Container starten

```bash
cd /home/chris/docker/paperless-scanner
docker compose up -d
```

---

## 🔄 Container aktualisieren

```bash
cd /home/chris/docker/paperless-scanner

docker compose pull
docker compose up -d
```

---

## 💾 Backup

Für ein vollständiges Backup folgende Daten sichern:

```text
/home/chris/docker/paperless-scanner/config
```

---

## 🗑️ Deinstallation

Container stoppen:

```bash
cd /home/chris/docker/paperless-scanner

docker compose down
```

Anschließend den Ordner entfernen:

```bash
rm -rf /home/chris/docker/paperless-scanner
```

---

## 🔌 Verwendete Ports

```text
3000/tcp
```

---

## ✅ Fertig

Dein Paperless Scanner Server ist jetzt einsatzbereit.

Alle Daten werden dauerhaft unter

```text
/ home/chris/docker/paperless-scanner
```

gespeichert und bleiben bei Container-Updates erhalten.
