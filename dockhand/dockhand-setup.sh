#!/bin/bash

set -e

echo "🚀 Starte DockHand Setup..."

# Docker prüfen
if ! command -v docker &> /dev/null; then
    echo "❌ Docker ist nicht installiert."
    exit 1
fi

# Docker Compose prüfen
if ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose ist nicht verfügbar."
    exit 1
fi

PROJECT_DIR="dockhand"

echo "📁 Erstelle Projektordner..."
mkdir -p "$PROJECT_DIR/dockhand_data"

cd "$PROJECT_DIR"

echo "📝 Erstelle docker-compose.yml..."

cat > docker-compose.yml <<EOF
services:
  dockhand:
    image: fnsys/dockhand:latest
    container_name: dockhand
    restart: unless-stopped
    ports:
      - "3033:3000"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./dockhand_data:/app/data

volumes:
  dockhand_data:
EOF

echo "🐳 Starte Container..."

docker compose up -d

LOCAL_IP=\$(hostname -I | awk '{print \$1}')

echo ""
echo "✅ DockHand wurde erfolgreich installiert!"
echo ""
echo "🌐 Zugriff:"
echo "http://\$LOCAL_IP:3033"
echo ""
