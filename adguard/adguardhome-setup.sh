#!/bin/bash

set -e

echo "🚀 Starte AdGuard Home Setup..."

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
APP_NAME="adguardhome"
PROJECT_DIR="${BASE_DIR}/${APP_NAME}"

echo "📁 Erstelle Projektordner..."

mkdir -p "$PROJECT_DIR/conf"
mkdir -p "$PROJECT_DIR/work"

cd "$PROJECT_DIR"

echo "📝 Erstelle docker-compose.yml..."

cat > docker-compose.yml <<'EOF'
services:
  adguardhome:
    image: adguard/adguardhome:latest
    container_name: adguardhome
    restart: unless-stopped
    ports:
      - "53:53/tcp"
      - "53:53/udp"
      - "67:67/udp"
      - "80:80/tcp"
      - "443:443/tcp"
      - "3030:3000/tcp"
    volumes:
      - /home/chris/docker/adguardhome/conf:/opt/adguardhome/conf
      - /home/chris/docker/adguardhome/work:/opt/adguardhome/work
EOF

echo "🐳 Starte Container..."

docker compose up -d

LOCAL_IP=$(hostname -I | awk '{print $1}')

echo ""
echo "✅ AdGuard Home wurde erfolgreich installiert!"
echo ""
echo "📁 Installationspfad:"
echo "$PROJECT_DIR"
echo ""
echo "🧙 Setup Wizard:"
echo "http://$LOCAL_IP:3030"
echo ""
echo "🌐 Nach der Einrichtung:"
echo "http://$LOCAL_IP"
echo ""
