# 🚀 Dashy Setup mit Docker

Dieses Repository enthält ein Bash-Skript, um Dashy schnell und einfach in Docker bereitzustellen.

Alle benötigten Dateien und Ordner werden automatisch erstellt.

---

## 📋 Voraussetzungen

- Installiertes Docker
- Installiertes Docker Compose
- Linux/macOS mit bash
- Internetzugang

---

## ⚙️ Installation

Führe einfach folgenden Einzeiler im gewünschten Verzeichnis aus:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/dashy/dashy-setup.sh)"
```

---

## 🛠️ Das Skript erledigt automatisch

- Erstellen der Projektstruktur
- Erstellen der benötigten Datenordner
- Generieren der docker-compose.yml
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
dashy/
├── dashy/
│   ├── icons/
│   └── conf.yml
├── docker-compose.yml
└── dashy-setup.sh
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

Folgende Daten regelmäßig sichern:

```text
dashy/
```

---

## ✅ Fertig

Dein Dashy Dashboard ist jetzt einsatzbereit.
