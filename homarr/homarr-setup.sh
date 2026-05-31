#!/bin/bash

set -e

echo "🚀 Starte Homarr Setup..."

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

PROJECT_DIR="homarr"

echo "📁 Erstelle Projektordner..."
mkdir -p "$PROJECT_DIR/homarr/appdata"

cd "$PROJECT_DIR"

# Proxy Netzwerk prüfen
if ! docker network inspect proxy >/dev/null 2>&1; then
    echo "❌ Docker Netzwerk 'proxy' existiert nicht."
    echo "Bitte zuerst das Netzwerk erstellen:"
    echo ""
    echo "docker network create proxy"
    exit 1
fi

echo "🔐 Generiere SECRET_ENCRYPTION_KEY..."

SECRET_ENCRYPTION_KEY=$(openssl rand -hex 32)

echo "📝 Erstelle .env..."

cat > .env <<EOF
SECRET_ENCRYPTION_KEY=$SECRET_ENCRYPTION_KEY
EOF

echo "📝 Erstelle docker-compose.yml..."

cat > docker-compose.yml <<'EOF'
services:
  homarr:
    container_name: homarr
    image: ghcr.io/homarr-labs/homarr:latest
    restart: unless-stopped
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./homarr/appdata:/appdata
    environment:
      - SECRET_ENCRYPTION_KEY=${SECRET_ENCRYPTION_KEY}
    networks:
      - proxy
    ports:
      - "7575:7575"

networks:
  proxy:
    external: true
EOF

echo "🐳 Starte Container..."

docker compose up -d

LOCAL_IP=$(hostname -I | awk '{print $1}')

echo ""
echo "✅ Homarr wurde erfolgreich installiert!"
echo ""
echo "🌐 Zugriff:"
echo "http://$LOCAL_IP:7575"
echo ""
