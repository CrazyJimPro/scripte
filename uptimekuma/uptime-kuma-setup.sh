#!/bin/bash

set -e

echo "🚀 Starte Uptime Kuma Setup..."

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
APP_NAME="uptime-kuma"
PROJECT_DIR="${BASE_DIR}/${APP_NAME}"

echo "📁 Erstelle Projektordner..."

mkdir -p "$PROJECT_DIR/data"

cd "$PROJECT_DIR"

echo "📝 Erstelle docker-compose.yml..."

cat > docker-compose.yml <<'EOF'
services:
  uptime-kuma:
    image: louislam/uptime-kuma:2
    container_name: uptime-kuma
    restart: always
    ports:
      - "3001:3001"
    volumes:
      - /home/chris/docker/uptime-kuma/data:/app/data
      - /var/run/docker.sock:/var/run/docker.sock:ro
    environment:
      - TZ=Europe/Berlin
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3001"]
      interval: 30s
      retries: 3
      start_period: 10s
      timeout: 5s
    logging:
      driver: json-file
      options:
        max-size: "10m"
        max-file: "3"
EOF

echo "🐳 Starte Container..."

docker compose up -d

LOCAL_IP=$(hostname -I | awk '{print $1}')

echo ""
echo "✅ Uptime Kuma wurde erfolgreich installiert!"
echo ""
echo "📁 Installationspfad:"
echo "$PROJECT_DIR"
echo ""
echo "🌐 Zugriff:"
echo "http://$LOCAL_IP:3001"
echo ""
