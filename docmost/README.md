Perfekt 👍 hier eine saubere **README.md** für dein `docmost-setup.sh` im selben Stil wie die anderen:

````markdown
# 🚀 Docmost Setup mit Docker

Dieses Repository enthält ein Bash-Skript, um **Docmost** mit PostgreSQL und Redis schnell und einfach in Docker bereitzustellen.  
Alle benötigten Dateien (`.env`, `docker-compose.yml`) werden automatisch erstellt.  

---

## 📋 Voraussetzungen

- Installiertes **Docker** & **Docker Compose**
- Linux/macOS Terminal mit `bash`
- Internetzugang (zum Laden der Images)

---

## ⚙️ Installation

Führe einfach folgenden Einzeiler im gewünschten Verzeichnis aus:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/docmost/docmost-setup.sh)"
````

Das Skript erledigt für dich:

* Erstellen der Projektstruktur (`data`, `db_data`, `redis_data`)
* Generieren einer `.env` mit:

  * `APP_URL` → Lokale IP + Port 3090
  * `APP_SECRET` → Zufälliger geheimer Schlüssel
  * `DB_PASSWORD` → Zufälliges Passwort für PostgreSQL
* Erstellen von `docker-compose.yml`
* Starten der Container mit `docker compose up -d`

---

## 🌐 Zugriff

Nach der Installation erreichst du Docmost unter:

```
http://<deine-lokale-ip>:3090
```

---

## 📂 Projektstruktur

```
docmost/
├── data/          # Docmost Daten (Uploads, Dateien)
├── db_data/       # PostgreSQL Datenbankdaten
├── redis_data/    # Redis Daten
├── .env           # Automatisch generierte Umgebungsvariablen
├── docker-compose.yml
└── docmost-setup.sh
```

---

## 🛑 Container stoppen & starten

```bash
# Stoppen
docker compose down

# Starten
docker compose up -d
```

---

## 🔄 Backup-Hinweis

Die relevanten Daten liegen in folgenden Ordnern und sollten regelmäßig gesichert werden:

* `data/`
* `db_data/`
* `redis_data/`

---

## ✅ Fertig

Dein Docmost-Setup ist jetzt einsatzbereit.
Rufe es einfach im Browser auf und lege direkt los!

```

---

Soll ich dir die fertige **README.md** auch gleich so vorbereiten, dass sie automatisch mit im Script angelegt wird (wie `.env` & `docker-compose.yml`), oder willst du sie nur auf GitHub nutzen?
```
