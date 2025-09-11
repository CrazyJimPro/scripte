#!/bin/bash
set -e

# Basisverzeichnis = aktuelles Verzeichnis
BASE_DIR=$(pwd)

echo "📁 Erstelle Projektstruktur unter: $BASE_DIR"

# Verzeichnisse
mkdir -p $BASE_DIR/{data,db_data,redis_data}

# Lokale IP automatisch ermitteln
LOCAL_IP=$(hostname -I | awk '{print $1}')

# Secret Key und Passwort generieren
APP_SECRET=$(openssl rand -hex 32)
DB_PASSWORD=$(openssl rand -hex 16)

# .env Datei mit Standardwerten
if [ ! -f "$BASE_DIR/.env" ]; then
cat <<EOF > $BASE_DIR/.env
# Docmost Konfiguration
APP_URL=http://$LOCAL_IP:3090
APP_SECRET=$APP_SECRET
DB_PASSWORD=$DB_PASSWORD
EOF
fi

# docker-compose.yml erstellen
cat <<'EOF' > $BASE_DIR/docker-compose.yml
services:
  docmost:
    image: docmost/docmost:latest
    container_name: docmost
    depends_on:
      - db
      - redis
    environment:
      APP_URL: ${APP_URL}
      APP_SECRET: ${APP_SECRET}
      DATABASE_URL: postgresql://docmost:${DB_PASSWORD}@db:5432/docmost?schema=public
      REDIS_URL: redis://redis:6379
    ports:
      - "3090:3000"
    restart: unless-stopped
    volumes:
      - ./data:/app/data/storage

  db:
    image: postgres:16-alpine
    container_name: docmost-db
    environment:
      POSTGRES_DB: docmost
      POSTGRES_USER: docmost
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    restart: unless-stopped
    volumes:
      - ./db_data:/var/lib/postgresql/data

  redis:
    image: redis:7.2-alpine
    container_name: docmost-redis
    restart: unless-stopped
    volumes:
      - ./redis_data:/data
EOF

# Container starten
echo "🚀 Starte Docker Container..."
docker compose up -d

echo "✅ Docmost Setup abgeschlossen!"
echo "Rufe Docmost auf unter: http://$LOCAL_IP:3090"
