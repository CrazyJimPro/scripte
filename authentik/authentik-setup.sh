#!/bin/bash

set -e

echo "🚀 Starte Authentik Setup..."

# Docker prüfen
if ! command -v docker >/dev/null 2>&1; then
    echo "❌ Docker ist nicht installiert."
    exit 1
fi

# Docker Compose prüfen
if ! docker compose version >/dev/null 2>&1; then
    echo "❌ Docker Compose ist nicht verfügbar."
    exit 1
fi

# OpenSSL prüfen
if ! command -v openssl >/dev/null 2>&1; then
    echo "❌ OpenSSL ist nicht installiert."
    exit 1
fi

BASE_DIR="/home/chris/docker"
APP_NAME="authentik"
PROJECT_DIR="${BASE_DIR}/${APP_NAME}"

echo "📁 Erstelle Projektordner..."

mkdir -p "$PROJECT_DIR/database"
mkdir -p "$PROJECT_DIR/redis"
mkdir -p "$PROJECT_DIR/authentik/media"
mkdir -p "$PROJECT_DIR/authentik/custom-templates"

cd "$PROJECT_DIR"

echo "🔐 Generiere Zugangsdaten..."

AUTHENTIK_SECRET_KEY=$(openssl rand -hex 32)
AUTHENTIK_POSTGRES_PASSWORD=$(openssl rand -hex 16)

echo "📝 Erstelle .env..."

cat > .env <<EOF
AUTHENTIK_SECRET_KEY=$AUTHENTIK_SECRET_KEY
AUTHENTIK_POSTGRES_USER=authentik
AUTHENTIK_POSTGRES_PASSWORD=$AUTHENTIK_POSTGRES_PASSWORD
AUTHENTIK_POSTGRES_DB=authentik
AUTHENTIK_REDIS_HOST=redis
AUTHENTIK_POSTGRES_HOST=database
EOF

echo "📝 Erstelle docker-compose.yml..."

cat > docker-compose.yml <<'EOF'
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
      - /home/chris/docker/authentik/database:/var/lib/postgresql/data

  redis:
    image: redis:7
    container_name: authentik-redis
    restart: unless-stopped
    command: ["redis-server", "--save", "60", "1", "--loglevel", "warning"]
    volumes:
      - /home/chris/docker/authentik/redis:/data

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
      - /home/chris/docker/authentik/authentik/media:/media
      - /home/chris/docker/authentik/authentik/custom-templates:/templates
    depends_on:
      - database
      - redis
    ports:
      - "9010:9000"
      - "9444:9443"

  authentik-worker:
    image: ghcr.io/goauthentik/server:2025.8.1
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
      - /home/chris/docker/authentik/authentik/media:/media
      - /home/chris/docker/authentik/authentik/custom-templates:/templates
    depends_on:
      - database
      - redis
EOF

echo "🐳 Starte Container..."

docker compose up -d

LOCAL_IP=$(hostname -I | awk '{print $1}')

echo ""
echo "✅ Authentik wurde erfolgreich installiert!"
echo ""
echo "📁 Installationspfad:"
echo "$PROJECT_DIR"
echo ""
echo "🌐 Initial Setup Wizard:"
echo "http://$LOCAL_IP:9010/if/flow/initial-setup/"
echo ""
