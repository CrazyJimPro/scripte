#!/bin/bash

set -e

echo "🚀 Starte Beszel Setup..."

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
APP_NAME="beszel"
PROJECT_DIR="${BASE_DIR}/${APP_NAME}"

echo "📁 Erstelle Projektordner..."
mkdir -p "$PROJECT_DIR/beszel"

cd "$PROJECT_DIR"

echo "🌐 Prüfe Docker Netzwerk 'docker'..."

if ! docker network inspect docker >/dev/null 2>&1; then
    echo "📦 Netzwerk 'docker' existiert nicht. Erstelle es..."
    docker network create docker
else
    echo "✅ Netzwerk 'docker' bereits vorhanden."
fi

echo "📝 Erstelle docker-compose.yml..."

cat > docker-compose.yml <<'EOF'
services:
  beszel:
    image: henrygd/beszel
    container_name: beszel
    restart: unless-stopped
    ports:
      - "8090:8090"
    volumes:
      - /home/chris/docker/beszel/beszel:/beszel_data
    networks:
      - docker

networks:
  docker:
    external: true
EOF

echo "🐳 Starte Container..."

docker compose up -d

LOCAL_IP=$(hostname -I | awk '{print $1}')

echo ""
echo "✅ Beszel wurde erfolgreich installiert!"
echo ""
echo "📁 Installationspfad:"
echo "$PROJECT_DIR"
echo ""
echo "🌐 Zugriff:"
echo "http://$LOCAL_IP:8090"
echo ""
