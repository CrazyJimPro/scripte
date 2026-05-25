#!/bin/bash

set -e

echo "🚀 Starte TriliumNext Setup..."

# Prüfen ob Docker installiert ist
if ! command -v docker &> /dev/null; then
    echo "❌ Docker ist nicht installiert."
    exit 1
fi

# Prüfen ob Docker Compose verfügbar ist
if ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose ist nicht verfügbar."
    exit 1
fi

# Projektordner
PROJECT_DIR="trilium"

echo "📁 Erstelle Projektordner..."
mkdir -p "$PROJECT_DIR/data"

cd "$PROJECT_DIR"

echo "📝 Erstelle docker-compose.yml..."

cat > docker-compose.yml <<EOF
services:
  trilium:
    container_name: trilium
    hostname: trilium
    image: triliumnext/trilium:latest
    restart: unless-stopped
    security_opt:
      - no-new-privileges:true
    ports:
      - "8099:8080"
    volumes:
      - ./data:/home/node/trilium-data
    environment:
      TZ: Europe/Berlin
EOF

echo "🐳 Starte Container..."

docker compose up -d

LOCAL_IP=$(hostname -I | awk '{print $1}')

echo ""
echo "✅ TriliumNext wurde erfolgreich installiert!"
echo ""
echo "🌐 Zugriff:"
echo "http://$LOCAL_IP:8099"
echo ""
