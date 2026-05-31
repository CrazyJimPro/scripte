#!/bin/bash

set -e

echo "🚀 Starte Homarr Setup..."

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
APP_NAME="homarr"
PROJECT_DIR="${BASE_DIR}/${APP_NAME}"

echo "📁 Erstelle Projektordner..."
mkdir -p "$PROJECT_DIR/appdata"

cd "$PROJECT_DIR"

echo "🌐 Prüfe Docker Netzwerk 'proxy'..."

if ! docker network inspect proxy >/dev/null 2>&1; then
    echo "📦 Netzwerk 'proxy' existiert nicht. Erstelle es..."
    docker network create proxy
else
    echo "✅ Netzwerk 'proxy' bereits vorhanden."
fi

echo "🔐 Generiere SECRET_ENCRYPTION_KEY..."

SECRET_ENCRYPTION_KEY=$(openssl rand -hex 32)

echo "📝 Erstelle .env..."

cat > .env <<EOF
SECRET_ENCRYPTION_KEY=$SECRET_ENCRYPTION_KEY
EOF

echo "📝 Erstelle docker-compose.yml..."

cat > docker-compose.yml <<'EOF'
services:
  homarr:
    container_name: homarr
    image: ghcr.io/homarr-labs/homarr:latest
    restart: unless-stopped
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /home/chris/docker/homarr/appdata:/appdata
    environment:
      - SECRET_ENCRYPTION_KEY=${SECRET_ENCRYPTION_KEY}
    networks:
      - proxy
    ports:
      - "7575:7575"

networks:
  proxy:
    external: true
EOF

echo "🐳 Starte Container..."

docker compose up -d

LOCAL_IP=$(hostname -I | awk '{print $1}')

echo ""
echo "✅ Homarr wurde erfolgreich installiert!"
echo ""
echo "📁 Installationspfad:"
echo "$PROJECT_DIR"
echo ""
echo "🌐 Zugriff:"
echo "http://$LOCAL_IP:7575"
echo ""
