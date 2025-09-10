#!/bin/bash
set -e

# Basisverzeichnis = aktuelles Verzeichnis
BASE_DIR=$(pwd)

echo "📁 Erstelle Projektstruktur unter: $BASE_DIR/heimdall"

# Verzeichnisse
mkdir -p $BASE_DIR/heimdall/{config}

# docker-compose.yml erstellen
cat <<'EOF' > $BASE_DIR/heimdall/docker-compose.yml
services:
  heimdall:
    image: linuxserver/heimdall:latest
    container_name: heimdall
    restart: unless-stopped
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Berlin
    volumes:
      - ./config:/config
    ports:
      - "7202:80"
      - "7203:443"
EOF

# Container starten
echo "🚀 Starte Docker Container..."
cd $BASE_DIR/heimdall
docker compose up -d

# Lokale IP automatisch ermitteln
LOCAL_IP=$(hostname -I | awk '{print $1}')

echo "✅ Heimdall Setup abgeschlossen!"
echo "Aufruf im Browser: http://$LOCAL_IP:7202 oder https://$LOCAL_IP:7203"

