#!/bin/bash

set -e

echo "🚀 Starte Stirling PDF Setup..."

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
APP_NAME="stirlingpdf"
PROJECT_DIR="${BASE_DIR}/${APP_NAME}"

# Vorhandene Installation prüfen
if [ -f "$PROJECT_DIR/docker-compose.yml" ]; then
    echo "❌ Installation bereits vorhanden:"
    echo "$PROJECT_DIR"
    exit 1
fi

echo "📁 Erstelle Projektordner..."

mkdir -p "$PROJECT_DIR/config/tesseract-training-data"
mkdir -p "$PROJECT_DIR/config/stirling-pdf"

cd "$PROJECT_DIR"

echo "📝 Erstelle docker-compose.yml..."

cat > docker-compose.yml <<'EOF'
services:
  stirling-pdf:
    image: frooodle/s-pdf:latest
    container_name: stirling-pdf
    restart: unless-stopped
    ports:
      - "8180:8080"
    volumes:
      - /home/chris/docker/stirlingpdf/config/tesseract-training-data:/usr/share/tesseract-ocr/4.00/tessdata
      - /home/chris/docker/stirlingpdf/config/stirling-pdf:/configs
    environment:
      - DOCKER_ENABLE_SECURITY=false
EOF

echo "🐳 Starte Container..."

docker compose up -d

LOCAL_IP=$(hostname -I | awk '{print $1}')

echo ""
echo "✅ Stirling PDF wurde erfolgreich installiert!"
echo ""
echo "📁 Installationspfad:"
echo "$PROJECT_DIR"
echo ""
echo "🌐 Zugriff:"
echo "http://$LOCAL_IP:8180"
echo ""
