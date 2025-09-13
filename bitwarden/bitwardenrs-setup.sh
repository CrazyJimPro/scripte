#!/bin/bash
set -e

# ==============================
# Bitwarden_RS (Vaultwarden) Setup Script
# ==============================

# Versionsauswahl: entweder Argument oder "latest"
BITWARDENRS_VERSION="${1:-latest}"

# Zielverzeichnis im aktuellen Pfad
BASE_DIR="$(pwd)/bitwardenrs"

# Ordnerstruktur anlegen
mkdir -p "$BASE_DIR/data"

# .env-Datei erzeugen, falls nicht vorhanden
if [ ! -f "$BASE_DIR/.env" ]; then
    cat <<EOF > "$BASE_DIR/.env"
# BitwardenRS Environment File

# Admin Token (zufällig generiert)
ADMIN_TOKEN=$(openssl rand -hex 32)

# Websocket aktivieren
WEBSOCKET_ENABLED=true
EOF
fi

# docker-compose.yml erstellen
cat <<EOF > "$BASE_DIR/docker-compose.yml"
services:
  bitwardenrs:
    image: bitwardenrs/server:$BITWARDENRS_VERSION
    container_name: bitwardenrs
    restart: unless-stopped
    env_file: .env
    volumes:
      - ./data:/data
    ports:
      - "8088:80"   # Web-UI auf Port 8088
      - "3012:3012" # WebSocket
EOF

# Container starten
cd "$BASE_DIR"
docker compose pull
docker compose up -d

# Lokale IP ermitteln
LOCAL_IP=$(hostname -I | awk '{print $1}')

echo ""
echo "✅ Bitwarden_RS Setup abgeschlossen!"
echo "Rufe die Weboberfläche auf unter: http://$LOCAL_IP:8088"
echo "Admin-Interface aktivieren mit Token aus .env:"
echo ""
grep ADMIN_TOKEN .env
