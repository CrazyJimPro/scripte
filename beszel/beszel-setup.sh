#!/bin/bash
set -e

# Lokale IP ermitteln
LOCAL_IP=$(hostname -I | awk '{print $1}')

# Secret Key generieren
SECRET_KEY=$(openssl rand -hex 32)

# Sicheres Passwort für die DB generieren
DB_PASSWORD=$(openssl rand -hex 16)

# Ausgabe für den Nutzer
echo "Lokale IP: $LOCAL_IP"
echo "Secret Key: $SECRET_KEY"
echo "DB Passwort: $DB_PASSWORD"

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
    image: ghcr.io/beszel/beszel:latest
    depends_on:
      - db
      - redis
    environment:
      APP_URL: "http://$LOCAL_IP:3095"
      APP_SECRET: "$SECRET_KEY"
      DATABASE_URL: "postgresql://beszel:$DB_PASSWORD@db:5432/beszel"
      REDIS_URL: "redis://redis:6379"
    ports:
      - "3095:3000"
    restart: unless-stopped
    networks:
      - docker
    volumes:
      - ./data:/app/data

  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: beszel
      POSTGRES_USER: beszel
      POSTGRES_PASSWORD: $DB_PASSWORD
    restart: unless-stopped
    networks:
      - docker
    volumes:
      - ./db_data:/var/lib/postgresql/data

  redis:
    image: redis:7.2-alpine
    restart: unless-stopped
    networks:
      - docker
    volumes:
      - ./redis_data:/data

networks:
  docker:
    external: true
EOL

# Container starten
docker compose up -d

echo "-----------------------------------"
echo "Beszel ist jetzt erreichbar unter:"
echo "👉 http://$LOCAL_IP:3095"
echo "-----------------------------------"
