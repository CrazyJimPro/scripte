#!/bin/bash
set -e

# Basisverzeichnis = aktuelles Verzeichnis
BASE_DIR=$(pwd)

echo "📁 Erstelle Projektstruktur unter: $BASE_DIR"

# Verzeichnisse
mkdir -p $BASE_DIR/{database,redis,authentik/media,authentik/custom-templates}

# .env Datei mit Standardwerten
if [ ! -f "$BASE_DIR/.env" ]; then
cat <<EOF > $BASE_DIR/.env
# Authentik Konfiguration
AUTHENTIK_SECRET_KEY=$(openssl rand -hex 32)
AUTHENTIK_POSTGRES_USER=authentik
AUTHENTIK_POSTGRES_PASSWORD=$(openssl rand -hex 16)
AUTHENTIK_POSTGRES_DB=authentik
AUTHENTIK_REDIS_HOST=redis
AUTHENTIK_POSTGRES_HOST=database
EOF
fi

# docker-compose.yml erstellen
cat <<'EOF' > $BASE_DIR/docker-compose.yml

services:
  database:
    image: postgres:15
    container_name: authentik-db
    restart: unless-stopped
    environment:
      POSTGRES_USER: ${AUTHENTIK_POSTGRES_USER}
      POSTGRES_PASSWORD: ${AUTHENTIK_POSTGRES_PASSWORD}
      POSTGRES_DB: ${AUTHENTIK_POSTGRES_DB}
    volumes:
      - ./database:/var/lib/postgresql/data

  redis:
    image: redis:7
    container_name: authentik-redis
    restart: unless-stopped
    command: ["redis-server", "--save", "60", "1", "--loglevel", "warning"]
    volumes:
      - ./redis:/data

  authentik-server:
    image: ghcr.io/goauthentik/server:2025.8.1
    container_name: authentik-server
    restart: unless-stopped
    command: server
    environment:
      AUTHENTIK_SECRET_KEY: ${AUTHENTIK_SECRET_KEY}
      AUTHENTIK_POSTGRESQL__HOST: database
      AUTHENTIK_POSTGRESQL__USER: ${AUTHENTIK_POSTGRES_USER}
      AUTHENTIK_POSTGRESQL__PASSWORD: ${AUTHENTIK_POSTGRES_PASSWORD}
      AUTHENTIK_POSTGRESQL__NAME: ${AUTHENTIK_POSTGRES_DB}
      AUTHENTIK_REDIS__HOST: redis
    volumes:
      - ./authentik/media:/media
      - ./authentik/custom-templates:/templates
    depends_on:
      - database
      - redis
    ports:
      - "9010:9000"
      - "9444:9443"

  authentik-worker:
    image: ghcr.io/goauthentik/server:latest
    container_name: authentik-worker
    restart: unless-stopped
    command: worker
    environment:
      AUTHENTIK_SECRET_KEY: ${AUTHENTIK_SECRET_KEY}
      AUTHENTIK_POSTGRESQL__HOST: database
      AUTHENTIK_POSTGRESQL__USER: ${AUTHENTIK_POSTGRES_USER}
      AUTHENTIK_POSTGRESQL__PASSWORD: ${AUTHENTIK_POSTGRES_PASSWORD}
      AUTHENTIK_POSTGRESQL__NAME: ${AUTHENTIK_POSTGRES_DB}
      AUTHENTIK_REDIS__HOST: redis
    volumes:
      - ./authentik/media:/media
      - ./authentik/custom-templates:/templates
    depends_on:
      - database
      - redis
EOF

# Container starten
echo "🚀 Starte Docker Container..."
docker compose up -d

# Lokale IP automatisch ermitteln
LOCAL_IP=$(hostname -I | awk '{print $1}')

echo "✅ Authentik Setup abgeschlossen!"
echo "Rufe den Initial Setup Wizard auf unter: http://$LOCAL_IP:9010/if/flow/initial-setup/"

