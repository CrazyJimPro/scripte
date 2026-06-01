# 🚀 Stirling PDF Setup mit Docker

Dieses Repository enthält ein Bash-Skript, um Stirling PDF schnell und einfach in Docker bereitzustellen.

Alle benötigten Dateien und Ordner werden automatisch erstellt.

---

## 📋 Voraussetzungen

- Installiertes Docker
- Installiertes Docker Compose
- Linux mit bash

---

## ⚙️ Installation

Führe einfach folgenden Einzeiler aus:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/stirlingpdf/stirlingpdf-setup.sh)"
```

---

## 🛠️ Das Skript erledigt automatisch

- Erstellen des Ordners `/home/chris/docker/stirlingpdf`
- Erstellen aller Konfigurationsordner
- Generieren der `docker-compose.yml`
- Starten des Containers

---

## 🌐 Zugriff

Nach der Installation erreichst du Stirling PDF unter:

```text
http://<deine-ip>:8180
```

---

## ⭐ Empfohlene Konfiguration

### OCR aktivieren

Stirling PDF unterstützt OCR (Texterkennung) für eingescannte Dokumente.

Für deutschsprachige Dokumente empfiehlt sich die Installation des deutschen Tesseract-Sprachpakets innerhalb der Anwendung.

### PDF-Sicherheit

Wenn Stirling PDF ausschließlich im Heimnetz verwendet wird:

```text
DOCKER_ENABLE_SECURITY=false
```

ist in Ordnung.

Falls Stirling PDF über das Internet erreichbar ist:

```text
DOCKER_ENABLE_SECURITY=true
```

verwenden und zusätzlich einen Reverse Proxy mit HTTPS einsetzen.

### Große PDF-Dateien

Für häufige OCR- oder PDF-Konvertierungen empfiehlt sich:

- mindestens 2 CPU-Kerne
- mindestens 2 GB RAM

---

## 📂 Projektstruktur

```text
/home/chris/docker/
└── stirlingpdf/
    ├── config/
    │   ├── stirling-pdf/
    │   └── tesseract-training-data/
    └── docker-compose.yml
```

---

## 🛑 Container stoppen

```bash
cd /home/chris/docker/stirlingpdf
docker compose down
```

---

## ▶️ Container starten

```bash
cd /home/chris/docker/stirlingpdf
docker compose up -d
```

---

## 🔄 Container aktualisieren

```bash
cd /home/chris/docker/stirlingpdf

docker compose pull
docker compose up -d
```

---

## 💾 Backup

Für ein vollständiges Backup folgende Daten sichern:

```text
/home/chris/docker/stirlingpdf/config
```

---

## 🗑️ Deinstallation

Container stoppen:

```bash
cd /home/chris/docker/stirlingpdf

docker compose down
```

Anschließend den Ordner entfernen:

```bash
rm -rf /home/chris/docker/stirlingpdf
```

---

## 🔌 Verwendete Ports

```text
8180/tcp
```

---

## ✅ Fertig

Dein Stirling PDF Server ist jetzt einsatzbereit.

Alle Daten werden dauerhaft unter

```text
/ home/chris/docker/stirlingpdf
```

gespeichert und bleiben bei Container-Updates erhalten.
