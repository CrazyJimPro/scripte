#!/bin/bash
set -e

# Basisverzeichnis = aktuelles Verzeichnis
BASE_DIR=$(pwd)

echo "📁 Erstelle Projektstruktur unter: $BASE_DIR"

# Verzeichnisse
mkdir -p $BASE_DIR/{db,uploads}

# .env Datei mit Standardwerten
if [ ! -f "$BASE_DIR/.env" ]; then
    echo "⚙️  Generiere APP_KEY..."
    APP_KEY=$(docker run -it --rm --entrypoint /bin/bash lscr.io/linuxserver/bookstack:latest appkey | tr -d '\r\n')

    cat <<EOF > $BASE_DIR/.env
# BookStack Konfiguration
APP_URL=http://localhost:6875
APP_KEY=$APP_KEY

# Datenbank
DB_HOST=db
DB_DATABASE=bookstack
DB_USERNAME=bookstack
DB_PASSWORD=$(openssl rand -hex 16)
EOF
fi

# docker-compose.yml erstellen
cat <<'EOF' > $BASE_DIR/docker-compose.yml
services:
  bookstack:
    image: lscr.io/linuxserver/bookstack:latest
    container_name: bookstack
    restart: unless-stopped
    environment:
      APP_URL: ${APP_URL}
      APP_KEY: ${APP_KEY}
      DB_HOST: ${DB_HOST}
      DB_DATABASE: ${DB_DATABASE}
      DB_USERNAME: ${DB_USERNAME}
      DB_PASSWORD: ${DB_PASSWORD}
    volumes:
      - ./uploads:/config
    ports:
      - "6875:80"
    depends_on:
      - db
EOF

# Container starten
echo "🚀 Starte Docker Container..."
docker compose up -d

# Lokale IP automatisch ermitteln
LOCAL_IP=$(hostname -I | awk '{print $1}')

echo "✅ BookStack Setup abgeschlossen!"
echo "Rufe BookStack auf unter: http://$LOCAL_IP:6875"
