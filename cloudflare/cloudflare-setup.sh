#!/bin/bash

set -e

echo "🚀 Starte Cloudflare Tunnel Setup..."

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
APP_NAME="cloudflare"
PROJECT_DIR="${BASE_DIR}/${APP_NAME}"

echo "📁 Erstelle Projektordner..."
mkdir -p "$PROJECT_DIR/cloudflared"

cd "$PROJECT_DIR"

echo ""
read -s -p "🔑 Bitte Cloudflare Tunnel Token eingeben: " TUNNEL_TOKEN
echo ""

if [ -z "$TUNNEL_TOKEN" ]; then
    echo "❌ Kein Tunnel Token angegeben."
    exit 1
fi

echo "📝 Erstelle .env..."

cat > .env <<EOF
TUNNEL_TOKEN=$TUNNEL_TOKEN
EOF

echo "📝 Erstelle docker-compose.yml..."

cat > docker-compose.yml <<'EOF'
services:
  cloudflare:
    image: cloudflare/cloudflared:latest
    container_name: cloudflare
    restart: unless-stopped
    command: tunnel --no-autoupdate run
    volumes:
      - /home/chris/docker/cloudflare/cloudflared:/home/nonroot/.cloudflared
    environment:
      - TUNNEL_TOKEN=${TUNNEL_TOKEN}
EOF

echo "🐳 Starte Container..."

docker compose up -d

echo ""
echo "✅ Cloudflare Tunnel wurde erfolgreich installiert!"
echo ""
echo "📁 Installationspfad:"
echo "$PROJECT_DIR"
echo ""
