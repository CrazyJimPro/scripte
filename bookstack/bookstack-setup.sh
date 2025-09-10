#!/bin/bash
set -e

# Basisverzeichnis = aktuelles Verzeichnis
BASE_DIR=$(pwd)

echo "📁 Erstelle Projektstruktur unter: $BASE_DIR"

# Verzeichnisse
mkdir -p $BASE_DIR/{mysql,uploads}

# .env Datei mit Standardwerten
if [ ! -f "$BASE_DIR/.env" ]; then
cat <<EOF > $BASE_DIR/.env
# BookStack MySQL
MYSQL_ROOT_PASSWORD=$(openssl rand -hex 16)
MYSQL_DATABASE=bookstack
MYSQL_USER=bookstack
MYSQL_PASSWORD=$(openssl rand -hex 16)

# BookStack App
APP_URL=http://$(hostname -I | awk '{print $1}'):6875
APP_KEY=$(openssl rand -hex 32)
EOF
fi

# docker-compose.yml erstellen
cat <<'EOF' > $BASE_DIR/docker-compose.yml
services:
  db:
    image: mysql:8
    container_name: bookstack-db
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
    volumes:
      - ./mysql:/var/lib/mysql

  bookstack:
    image: solidnerd/bookstack:latest
    container_name: bookstack
    restart: unless-stopped
    environment:
      DB_HOST: db
      DB_DATABASE: ${MYSQL_DATABASE}
      DB_USERNAME: ${MYSQL_USER}
      DB_PASSWORD: ${MYSQL_PASSWORD}
      APP_URL: ${APP_URL}
      APP_KEY: ${APP_KEY}
    depends_on:
      - db
    volumes:
      - ./uploads:/var/www/bookstack/public/uploads
    ports:
      - "6875:8080"
EOF

# Container starten
echo "🚀 Starte Docker Container..."
docker compose up -d

# Lokale IP automatisch ermitteln
LOCAL_IP=$(hostname -I | awk '{print $1}')

echo "✅ BookStack Setup abgeschlossen!"
echo "Rufe BookStack im Browser auf unter: http://$LOCAL_IP:6875"

