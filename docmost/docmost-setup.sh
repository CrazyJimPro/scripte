#!/bin/bash

set -e

echo "🚀 Starte Docmost Setup..."

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
APP_NAME="docmost"
PROJECT_DIR="${BASE_DIR}/${APP_NAME}"

echo "📁 Erstelle Projektordner..."

mkdir -p "$PROJECT_DIR/data"
mkdir -p "$PROJECT_DIR/db_data"
mkdir -p "$PROJECT_DIR/redis_data"

cd "$PROJECT_DIR"

LOCAL_IP=$(hostname -I | awk '{print $1}')

echo "🔐 Generiere Zugangsdaten..."

APP_SECRET=$(openssl rand -hex 32)
DB_PASSWORD=$(openssl rand -hex 16)

echo "📝 Erstelle .env..."

cat > .env <<EOF
APP_URL=http://$LOCAL_IP:3090
APP_SECRET=$APP_SECRET
DB_PASSWORD=$DB_PASSWORD
EOF

echo "📝 Erstelle docker-compose.yml..."

cat > docker-compose.yml <<'EOF'
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
      - /home/chris/docker/docmost/data:/app/data/storage

  db:
    image: postgres:16-alpine
    container_name: docmost-db
    environment:
      POSTGRES_DB: docmost
      POSTGRES_USER: docmost
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    restart: unless-stopped
    volumes:
      - /home/chris/docker/docmost/db_data:/var/lib/postgresql/data

  redis:
    image: redis:7.2-alpine
    container_name: docmost-redis
    restart: unless-stopped
    volumes:
      - /home/chris/docker/docmost/redis_data:/data
EOF

echo "🐳 Starte Container..."

docker compose up -d

echo ""
echo "✅ Docmost wurde erfolgreich installiert!"
echo ""
echo "📁 Installationspfad:"
echo "$PROJECT_DIR"
echo ""
echo "🌐 Zugriff:"
echo "http://$LOCAL_IP:3090"
echo ""
