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

PROJECT_DIR="dashy"

echo "📁 Erstelle Projektordner..."

mkdir -p "$PROJECT_DIR/dashy/icons"

cd "$PROJECT_DIR"

echo "📝 Erstelle docker-compose.yml..."

cat > docker-compose.yml <<'EOF'
services:
  dashy:
    container_name: dashy
    image: lissy93/dashy
    volumes:
      - ./dashy:/app/user-data/
      - ./dashy/icons:/app/public/item-icons/
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
echo "🌐 Zugriff:"
echo "http://$LOCAL_IP:4000"
echo ""
