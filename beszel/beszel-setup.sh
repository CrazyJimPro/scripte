#!/bin/bash
set -e

# Lokale IP ermitteln
LOCAL_IP=$(hostname -I | awk '{print $1}')

# Arbeitsverzeichnis
mkdir -p ~/docker/beszel
cd ~/docker/beszel

# Docker-Netzwerk prüfen/erstellen
if ! docker network ls | grep -q "docker"; then
  echo "Erstelle Docker-Netzwerk 'docker'..."
  docker network create docker
fi

# docker-compose.yml schreiben
cat > docker-compose.yml <<EOL
version: "3.9"

services:
  beszel:
    image: henrygd/beszel
    container_name: beszel
    restart: unless-stopped
    ports:
      - "8090:8090"
    volumes:
      - ./beszel:/beszel_data
    networks:
      - docker

networks:
  docker:
    external: true
EOL

# Container starten
docker compose up -d

echo "-----------------------------------"
echo "✅ Beszel ist jetzt erreichbar unter:"
echo "👉 http://$LOCAL_IP:8090"
echo "-----------------------------------"
