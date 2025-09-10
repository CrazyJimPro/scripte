#!/bin/bash
set -e

# Basisverzeichnis = aktuelles Verzeichnis
BASE_DIR=$(pwd)

echo "📁 Erstelle Projektstruktur unter: $BASE_DIR"

# Verzeichnisse
mkdir -p $BASE_DIR/{db,config,uploads}

# Lokale IP automatisch ermitteln
LOCAL_IP=$(hostname -I | awk '{print $1}')

# .env Datei mit Standardwerten
if [ ! -f "$BASE_DIR/.env" ]; then
    echo "⚙️  Generiere APP_KEY..."
    APP_KEY=$(openssl rand -hex 32)
    DB_PASSWORD=$(openssl rand -hex 16)

    cat <<EOF > $BASE_DIR/.env
# BookStack Konfiguration
APP_URL=http://$LOCAL_IP:6875
APP_KEY=$APP_KEY

# Datenbank
DB_HOST=db
DB_DATABASE=bookstack
DB_USERNAME=bookstack
DB_PASSWORD=$DB_PASSWORD
EOF
fi

# docker-compose.yml erstellen
cat <<EOF > $BASE_DIR/docker-compose.yml
services:
  db:
    image: mariadb:11
    container_name: bookstack-db
    restart: unless-stopped
    environment:
      MYSQL_DATABASE: \${DB_DATABASE}
      MYSQL_USER: \${DB_USERNAME}
      MYSQL_PASSWORD: \${DB_PASSWORD}
      MYSQL_ROOT_PASSWORD: \${DB_PASSWORD}
    volumes:
      - ./db:/var/lib/mysql

  bookstack:
    image: lscr.io/linuxserver/bookstack:latest
    container_name: bookstack
    restart: unless-stopped
    environment:
      APP_URL: \${APP_URL}
      APP_KEY: \${APP_KEY}
      DB_HOST: \${DB_HOST}
      DB_DATABASE: \${DB_DATABASE}
      DB_USERNAME: \${DB_USERNAME}
      DB_PASSWORD: \${DB_PASSWORD}
    volumes:
      - ./config:/config
      - ./uploads:/config/uploads
    ports:
      - "6875:80"
    depends_on:
      - db
EOF

# Container starten
echo "🚀 Starte Docker Container..."
docker compose up -d

echo "⏳ Warte, bis die Datenbank bereit ist..."
# Robuste DB-Warte-Schleife direkt im Container mit MYSQL_PWD
until docker exec -e MYSQL_PWD=$DB_PASSWORD bookstack-db mysqladmin ping -h localhost >/dev/null 2>&1; do
  sleep 2
done

echo "✅ BookStack Setup abgeschlossen!"
echo "Rufe BookStack auf unter: http://$LOCAL_IP:6875"

