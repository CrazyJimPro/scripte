# 🚀 Dashy Setup mit Docker

Dieses Repository enthält ein Bash-Skript, um Dashy schnell und einfach in Docker bereitzustellen.

Alle benötigten Dateien und Ordner werden automatisch erstellt.

Zusätzlich wird automatisch eine Standard-`conf.yml` erzeugt, sodass Dashy direkt einsatzbereit ist.

---

## 📋 Voraussetzungen

- Installiertes Docker
- Installiertes Docker Compose
- Linux mit bash
- Schreibrechte auf `/home/chris/docker`

---

## ⚙️ Installation

Führe einfach folgenden Einzeiler aus:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/dashy/dashy-setup.sh)"
```

---

## 🛠️ Das Skript erledigt automatisch

- Erstellen des Ordners `/home/chris/docker/dashy`
- Erstellen der Unterordner `user-data` und `icons`
- Erzeugen einer Standard-`conf.yml`
- Generieren der `docker-compose.yml`
- Starten des Containers

---

## 🌐 Zugriff

Nach der Installation erreichst du Dashy unter:

```text
http://<deine-ip>:4000
```

---

## 📂 Projektstruktur

```text
/home/chris/docker/
└── dashy/
    ├── user-data/
    │   └── conf.yml
    ├── icons/
    └── docker-compose.yml
```

---

## 🛑 Container stoppen

```bash
cd /home/chris/docker/dashy
docker compose down
```

---

## ▶️ Container starten

```bash
cd /home/chris/docker/dashy
docker compose up -d
```

---

## 🔄 Container aktualisieren

```bash
cd /home/chris/docker/dashy

docker compose pull
docker compose up -d
```

---

## 💾 Backup

Für ein vollständiges Backup die folgenden Ordner sichern:

```text
/home/chris/docker/dashy/user-data
/home/chris/docker/dashy/icons
```

---

## 🗑️ Deinstallation

```bash
cd /home/chris/docker/dashy

docker compose down
```

Anschließend den Ordner entfernen:

```bash
rm -rf /home/chris/docker/dashy
```

---

## ✅ Fertig

Dein Dashy Dashboard ist jetzt einsatzbereit.

Alle Konfigurationsdaten werden dauerhaft unter

```text
/home/chris/docker/dashy
```

gespeichert und bleiben bei Container-Updates erhalten.
