#!/bin/bash

set -e

echo "🚀 Starte Outline Setup..."

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
APP_NAME="outline"
PROJECT_DIR="${BASE_DIR}/${APP_NAME}"

echo "📁 Erstelle Projektordner..."

mkdir -p "$PROJECT_DIR/db"
mkdir -p "$PROJECT_DIR/redis"
mkdir -p "$PROJECT_DIR/data"

LOCAL_IP=$(hostname -I | awk '{print $1}')

echo ""
read -p "🔑 OIDC_CLIENT_ID: " OIDC_CLIENT_ID
read -s -p "🔑 OIDC_CLIENT_SECRET: " OIDC_CLIENT_SECRET
echo ""

DB_PASSWORD=$(openssl rand -hex 16)
SECRET_KEY=$(openssl rand -hex 32)
UTILS_SECRET=$(openssl rand -hex 32)

cd "$PROJECT_DIR"

echo "📝 Erstelle .env..."

cat > .env <<EOF
DB_PASSWORD=$DB_PASSWORD
SECRET_KEY=$SECRET_KEY
UTILS_SECRET=$UTILS_SECRET

OIDC_CLIENT_ID=$OIDC_CLIENT_ID
OIDC_CLIENT_SECRET=$OIDC_CLIENT_SECRET

LOCAL_IP=$LOCAL_IP
EOF

echo "📝 Erstelle docker-compose.yml..."

cat > docker-compose.yml <<'EOF'
services:
  outline:
    container_name: outline
    image: outlinewiki/outline:latest
    restart: unless-stopped
    environment:
      DATABASE_URL: postgres://outline:${DB_PASSWORD}@outline-db:5432/outline
      REDIS_URL: redis://outline-redis:6379
      SECRET_KEY: ${SECRET_KEY}
      UTILS_SECRET: ${UTILS_SECRET}
      URL: http://${LOCAL_IP}:3024
      HOST: 0.0.0.0
      PORT: 3000
      TZ: Europe/Berlin
      DEFAULT_LANGUAGE: de_DE
      FILE_STORAGE_LOCAL_ROOT_DIR: /var/lib/outline/data
      FILE_STORAGE_UPLOAD_MAX_SIZE: 26214400
      OIDC_CLIENT_ID: ${OIDC_CLIENT_ID}
      OIDC_CLIENT_SECRET: ${OIDC_CLIENT_SECRET}
      OIDC_AUTH_URI: http://${LOCAL_IP}:9191/application/o/authorize/
      OIDC_TOKEN_URI: http://${LOCAL_IP}:9191/application/o/token/
      OIDC_USERINFO_URI: http://${LOCAL_IP}:9191/application/o/userinfo/
      OIDC_DISPLAY_NAME: Authentik
      OIDC_SCOPES: openid profile email
      ENABLE_UPDATES: "true"
      NODE_ENV: production
      FILE_STORAGE: local
      PGSSLMODE: disable
      FORCE_HTTPS: "false"
      WEB_CONCURRENCY: 1
      FILE_STORAGE_IMPORT_MAX_SIZE: 5120000
      LOG_LEVEL: info
      RATE_LIMITER_ENABLED: "true"
      RATE_LIMITER_REQUESTS: 1000
      RATE_LIMITER_DURATION_WINDOW: 60
    ports:
      - "3024:3000"
    volumes:
      - /home/chris/docker/outline/data:/var/lib/outline/data
    depends_on:
      - outline-db
      - outline-redis

  outline-db:
    container_name: outline-db
    image: postgres:15
    restart: unless-stopped
    environment:
      TZ: Europe/Berlin
      POSTGRES_USER: outline
      POSTGRES_PASSWORD: ${DB_PASSWORD}
      POSTGRES_DB: outline
    volumes:
      - /home/chris/docker/outline/db:/var/lib/postgresql/data

  outline-redis:
    container_name: outline-redis
    image: redis:7
    restart: unless-stopped
    environment:
      TZ: Europe/Berlin
    volumes:
      - /home/chris/docker/outline/redis:/data
EOF

echo "🐳 Starte Container..."

docker compose up -d

echo ""
echo "✅ Outline wurde erfolgreich installiert!"
echo ""
echo "📁 Installationspfad:"
echo "$PROJECT_DIR"
echo ""
echo "🌐 Zugriff:"
echo "http://$LOCAL_IP:3024"
echo ""
