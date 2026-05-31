# 📊 Beszel Setup Script

Dieses Script installiert und startet [Beszel](https://github.com/henrygd/beszel), eine leichtgewichtige Monitoring-Lösung für deine Server und Container.

---

## 📂 Projektstruktur

```

scripte/beszel/
├── beszel-setup.sh      # Setup Script
├── docker-compose.yml   # Compose Datei (wird automatisch erstellt)
└── beszel/              # Persistente Daten (Volume)

```
## ⚡ Installation

Kopiere und führe den folgenden Einzeiler aus:

````
bash -c "$(curl -fsSL https://raw.githubusercontent.com/<DEIN-USER>/<DEIN-REPO>/main/scripte/beszel/beszel-setup.sh)"
````

Das Script erstellt die Projektstruktur, generiert eine `docker-compose.yml` und startet die Container automatisch.

---

## 🔑 Standardkonfiguration

* **Port:** `8090`
* **Containername:** `beszel`
* **Datenvolumen:** `./beszel:/beszel_data`

Beszel ist danach unter deiner **lokalen IP auf Port 8090** erreichbar, z. B.:

```
http://deineIP:8090
```

---

## 🔄 Update

Zum Updaten auf die neueste Version:

```bash
cd scripte/beszel
docker compose pull
docker compose up -d
```

---

## 📌 Hinweis

Dieses Script ist für **Docker-Umgebungen** optimiert und legt alle Daten persistent im `beszel`-Ordner ab, damit bei einem Neustart keine Konfiguration verloren geht.
