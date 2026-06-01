#!/bin/bash

set -e

echo "🚀 Starte Paperless Scanner Setup..."

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
APP_NAME="paperless-scanner"
PROJECT_DIR="${BASE_DIR}/${APP_NAME}"

# Vorhandene Installation prüfen
if [ -f "$PROJECT_DIR/docker-compose.yml" ]; then
    echo "❌ Installation bereits vorhanden:"
    echo "$PROJECT_DIR"
    exit 1
fi

echo "📁 Erstelle Projektordner..."

mkdir -p "$PROJECT_DIR/consume"
mkdir -p "$PROJECT_DIR/config"

cd "$PROJECT_DIR"

echo "📝 Erstelle docker-compose.yml..."

cat > docker-compose.yml <<'EOF'
services:
  scanner:
    image: fakeridoo/paperless-scanner:latest
    container_name: paperless-scanner
    restart: unless-stopped
    network_mode: host
    privileged: true

    ports:
      - "3000:3000"

    volumes:
      - /home/chris/docker/paperless-scanner/consume:/tmp
      - /home/chris/docker/paperless-scanner/config:/usr/src/app/config:rw

    devices:
      - "/dev/bus/usb:/dev/bus/usb"
EOF

echo "🐳 Starte Container..."

docker compose up -d

LOCAL_IP=$(hostname -I | awk '{print $1}')

echo ""
echo "✅ Paperless Scanner wurde erfolgreich installiert!"
echo ""
echo "📁 Installationspfad:"
echo "$PROJECT_DIR"
echo ""
echo "🌐 Zugriff:"
echo "http://$LOCAL_IP:3000"
echo ""
