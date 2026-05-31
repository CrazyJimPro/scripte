#!/bin/bash

set -e

echo "🚀 Starte Dashy Setup..."

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
APP_NAME="dashy"
PROJECT_DIR="${BASE_DIR}/${APP_NAME}"

echo "📁 Erstelle Projektordner..."
mkdir -p "$PROJECT_DIR/user-data"
mkdir -p "$PROJECT_DIR/icons"

cd "$PROJECT_DIR"

echo "📝 Erstelle Standard-Konfiguration..."

cat > user-data/conf.yml <<'EOF'
pageInfo:
  title: Dashy

appConfig:
  theme: colorful

sections:
  - name: Willkommen
    items:
      - title: Dashy Dokumentation
        url: https://dashy.to/docs
EOF

echo "📝 Erstelle docker-compose.yml..."

cat > docker-compose.yml <<'EOF'
services:
  dashy:
    container_name: dashy
    image: lissy93/dashy
    volumes:
      - /home/chris/docker/dashy/user-data:/app/user-data
      - /home/chris/docker/dashy/icons:/app/public/item-icons
    ports:
      - "4000:8080"
    environment:
      - NODE_ENV=production
      - UID=1000
      - GID=1000
    restart: unless-stopped
EOF

echo "🐳 Starte Container..."

docker compose up -d

LOCAL_IP=$(hostname -I | awk '{print $1}')

echo ""
echo "✅ Dashy wurde erfolgreich installiert!"
echo ""
echo "📁 Installationspfad:"
echo "$PROJECT_DIR"
echo ""
echo "🌐 Zugriff:"
echo "http://$LOCAL_IP:4000"
echo ""
