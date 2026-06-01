#!/bin/bash

set -e

echo "🚀 Starte BookStack Setup..."

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
APP_NAME="bookstack"
PROJECT_DIR="${BASE_DIR}/${APP_NAME}"

echo "📁 Erstelle Projektordner..."

mkdir -p "$PROJECT_DIR/db"
mkdir -p "$PROJECT_DIR/config"
mkdir -p "$PROJECT_DIR/uploads"

cd "$PROJECT_DIR"

LOCAL_IP=$(hostname -I | awk '{print $1}')

echo "🔐 Generiere Zugangsdaten..."

APP_KEY=$(openssl rand -hex 32)
DB_PASSWORD=$(openssl rand -hex 16)

echo "📝 Erstelle .env..."

cat > .env <<EOF
APP_URL=http://$LOCAL_IP:6875
APP_KEY=$APP_KEY

DB_HOST=db
DB_DATABASE=bookstack
DB_USERNAME=bookstack
DB_PASSWORD=$DB_PASSWORD
EOF

echo "📝 Erstelle docker-compose.yml..."

cat > docker-compose.yml <<'EOF'
services:
  db:
    image: mariadb:11
    container_name: bookstack-db
    restart: unless-stopped
    environment:
      MYSQL_DATABASE: ${DB_DATABASE}
      MYSQL_USER: ${DB_USERNAME}
      MYSQL_PASSWORD: ${DB_PASSWORD}
      MYSQL_ROOT_PASSWORD: ${DB_PASSWORD}
    volumes:
      - /home/chris/docker/bookstack/db:/var/lib/mysql

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
      - /home/chris/docker/bookstack/config:/config
      - /home/chris/docker/bookstack/uploads:/config/uploads
    ports:
      - "6875:80"
    depends_on:
      - db
EOF

echo "🐳 Starte Container..."

docker compose up -d

echo "⏳ Warte auf Datenbank..."

until docker exec -e MYSQL_PWD="$DB_PASSWORD" bookstack-db mysqladmin ping -h localhost >/dev/null 2>&1; do
    sleep 2
done

echo ""
echo "✅ BookStack wurde erfolgreich installiert!"
echo ""
echo "📁 Installationspfad:"
echo "$PROJECT_DIR"
echo ""
echo "🌐 Zugriff:"
echo "http://$LOCAL_IP:6875"
echo ""
