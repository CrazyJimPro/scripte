#!/bin/bash

set -e

echo "🚀 Starte RustDesk Server Setup..."

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

BASE_DIR="/home/chris/docker"
APP_NAME="rustdesk"
PROJECT_DIR="${BASE_DIR}/${APP_NAME}"

echo "📁 Erstelle Projektordner..."

mkdir -p "$PROJECT_DIR/data"

cd "$PROJECT_DIR"

echo "📝 Erstelle docker-compose.yml..."

cat > docker-compose.yml <<'EOF'
services:
  hbbs:
    container_name: rustdesk-id
    image: rustdesk/rustdesk-server:latest
    environment:
      - ALWAYS_USE_RELAY=Y
    command: hbbs
    volumes:
      - /home/chris/docker/rustdesk/data:/root
    network_mode: host
    depends_on:
      - hbbr
    restart: unless-stopped

  hbbr:
    container_name: rustdesk-relay
    image: rustdesk/rustdesk-server:latest
    command: hbbr
    volumes:
      - /home/chris/docker/rustdesk/data:/root
    network_mode: host
    restart: unless-stopped
EOF

echo "🐳 Starte Container..."

docker compose up -d

echo ""
echo "✅ RustDesk Server wurde erfolgreich installiert!"
echo ""
echo "📁 Installationspfad:"
echo "$PROJECT_DIR"
echo ""
echo "🔑 Öffentlicher Schlüssel:"
echo "/home/chris/docker/rustdesk/data/id_ed25519.pub"
echo ""
echo "📋 Diesen Schlüssel später in den RustDesk Clients hinterlegen."
echo ""
