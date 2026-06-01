#!/bin/bash

set -e

echo "🚀 Starte Nginx Proxy Manager + Pi-hole Setup..."

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
APP_NAME="nginx-pihole"
PROJECT_DIR="${BASE_DIR}/${APP_NAME}"

# Vorhandene Installation prüfen
if [ -f "$PROJECT_DIR/docker-compose.yml" ]; then
    echo "❌ Installation bereits vorhanden:"
    echo "$PROJECT_DIR"
    exit 1
fi

echo "📁 Erstelle Projektordner..."

mkdir -p "$PROJECT_DIR/data"
mkdir -p "$PROJECT_DIR/letsencrypt"
mkdir -p "$PROJECT_DIR/postgres-data"
mkdir -p "$PROJECT_DIR/pihole/etc-pihole"

cd "$PROJECT_DIR"

# Docker-Netzwerke erstellen
if ! docker network inspect proxy >/dev/null 2>&1; then
    echo "🌐 Erstelle Netzwerk: proxy"
    docker network create proxy
fi

if ! docker network inspect npm_default >/dev/null 2>&1; then
    echo "🌐 Erstelle Netzwerk: npm_default"
    docker network create npm_default
fi

echo "⚙️ Erstelle .env..."

cat > .env <<EOF
DB_PASSWORD=npmpass
PIHOLE_PASSWORD=PaSSW0rd
EOF

echo "📝 Erstelle docker-compose.yml..."

cat > docker-compose.yml <<'EOF'
services:
  npm:
    image: jc21/nginx-proxy-manager:latest
    container_name: npm
    restart: unless-stopped

    ports:
      - "80:80"
      - "443:443"
      - "81:81"

    environment:
      TZ: Europe/Berlin
      DB_POSTGRES_HOST: npm_db
      DB_POSTGRES_PORT: 5432
      DB_POSTGRES_USER: npm
      DB_POSTGRES_PASSWORD: ${DB_PASSWORD}
      DB_POSTGRES_NAME: npm

    volumes:
      - /home/chris/docker/nginx-pihole/data:/data
      - /home/chris/docker/nginx-pihole/letsencrypt:/etc/letsencrypt

    depends_on:
      - npm_db

    networks:
      - npm_default
      - proxy

  npm_db:
    image: postgres:18
    container_name: npm_db
    restart: unless-stopped

    environment:
      POSTGRES_USER: npm
      POSTGRES_PASSWORD: ${DB_PASSWORD}
      POSTGRES_DB: npm

    volumes:
      - /home/chris/docker/nginx-pihole/postgres-data:/var/lib/postgresql

    networks:
      - npm_default

  pihole:
    image: pihole/pihole:latest
    container_name: pihole
    restart: unless-stopped

    ports:
      - "53:53/udp"
      - "53:53/tcp"
      - "8081:80"
      - "8444:443"

    environment:
      TZ: Europe/Berlin
      FTLCONF_webserver_api_password: ${PIHOLE_PASSWORD}
      FTLCONF_dns_listeningMode: ALL

    volumes:
      - /home/chris/docker/nginx-pihole/pihole/etc-pihole:/etc/pihole

    cap_add:
      - NET_ADMIN
      - SYS_TIME
      - SYS_NICE

    networks:
      - npm_default
      - proxy

networks:
  npm_default:
    external: true

  proxy:
    external: true
EOF

echo "🐳 Starte Container..."

docker compose up -d

LOCAL_IP=$(hostname -I | awk '{print $1}')

echo ""
echo "✅ Nginx Proxy Manager + Pi-hole wurden erfolgreich installiert!"
echo ""
echo "🌐 Nginx Proxy Manager:"
echo "http://$LOCAL_IP:81"
echo ""
echo "🌐 Pi-hole:"
echo "http://$LOCAL_IP:8081/admin"
echo ""
