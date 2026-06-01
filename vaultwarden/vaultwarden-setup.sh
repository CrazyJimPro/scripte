#!/bin/bash

set -e

echo "🚀 Starte Vaultwarden Setup..."

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
APP_NAME="vaultwarden"
PROJECT_DIR="${BASE_DIR}/${APP_NAME}"

echo "📁 Erstelle Projektordner..."
mkdir -p "$PROJECT_DIR/data"

cd "$PROJECT_DIR"

echo "🔐 Generiere ADMIN_TOKEN..."

ADMIN_TOKEN=$(openssl rand -hex 32)

echo "📝 Erstelle .env..."

cat > .env <<EOF
ADMIN_TOKEN=$ADMIN_TOKEN
WEBSOCKET_ENABLED=true
EOF

echo "📝 Erstelle docker-compose.yml..."

cat > docker-compose.yml <<'EOF'
services:
  vaultwarden:
    image: vaultwarden/server:latest
    container_name: vaultwarden
    restart: unless-stopped
    env_file:
      - .env
    volumes:
      - /home/chris/docker/vaultwarden/data:/data
    ports:
      - "8088:80"
      - "3012:3012"
EOF

echo "🐳 Starte Container..."

docker compose pull
docker compose up -d

LOCAL_IP=$(hostname -I | awk '{print $1}')

echo ""
echo "✅ Vaultwarden wurde erfolgreich installiert!"
echo ""
echo "📁 Installationspfad:"
echo "$PROJECT_DIR"
echo ""
echo "🌐 Zugriff:"
echo "http://$LOCAL_IP:8088"
echo ""
echo "🔑 Admin Token:"
echo "$ADMIN_TOKEN"
echo ""
echo "📄 Token gespeichert in:"
echo "$PROJECT_DIR/.env"
echo ""
