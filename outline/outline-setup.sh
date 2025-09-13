#!/bin/bash
set -e

# Basis-Ordner
BASE_DIR="$HOME/docker/outline"

# Lokale IP ermitteln
LOCAL_IP=$(hostname -I | awk '{print $1}')

# Secrets generieren
DB_PASSWORD=$(openssl rand -hex 16)
SECRET_KEY=$(openssl rand -hex 32)
UTILS_SECRET=$(openssl rand -hex 32)

# Eingaben vom Nutzer
read -p "Bitte gib den OIDC_CLIENT_ID ein: " OIDC_CLIENT_ID
read -p "Bitte gib den OIDC_CLIENT_SECRET ein: " OIDC_CLIENT_SECRET

# Ordnerstruktur anlegen
mkdir -p "$BASE_DIR/db" "$BASE_DIR/redis" "$BASE_DIR/data"

# docker-compose.yml erstellen
cat > "$BASE_DIR/docker-compose.yml" <<EOL
services:
  outline:
    container_name: outline
    image: outlinewiki/outline:latest
    restart: always
    environment:
      - DATABASE_URL=postgres://outline:${DB_PASSWORD}@outline-db:5432/outline
      - REDIS_URL=redis://outline-redis:6379
      - SECRET_KEY=${SECRET_KEY}
      - UTILS_SECRET=${UTILS_SECRET}
      - URL=http://${LOCAL_IP}:3024
      - HOST=0.0.0.0
      - PORT=3000
      - TZ=Europe/Berlin
      - DEFAULT_LANGUAGE=de_DE
      - FILE_STORAGE_LOCAL_ROOT_DIR=/var/lib/outline/data
      - FILE_STORAGE_UPLOAD_MAX_SIZE=26214400
      - OIDC_CLIENT_ID=${OIDC_CLIENT_ID}
      - OIDC_CLIENT_SECRET=${OIDC_CLIENT_SECRET}
      - OIDC_AUTH_URI=http://${LOCAL_IP}:9191/application/o/authorize/
      - OIDC_TOKEN_URI=http://${LOCAL_IP}:9191/application/o/token/
      - OIDC_USERINFO_URI=http://${LOCAL_IP}:9191/application/o/userinfo/
      - OIDC_DISPLAY_NAME=Authentik
      - OIDC_SCOPES=openid profile email
      - ENABLE_UPDATES=true
      - NODE_ENV=production
      - FILE_STORAGE=local
      - PGSSLMODE=disable
      - FORCE_HTTPS=false
      - WEB_CONCURRENCY=1
      - FILE_STORAGE_IMPORT_MAX_SIZE=5120000
      - LOG_LEVEL=info
      - RATE_LIMITER_ENABLED=true
      - RATE_LIMITER_REQUESTS=1000
      - RATE_LIMITER_DURATION_WINDOW=60
    ports:
      - "3024:3000"
    volumes:
      - ${BASE_DIR}/data:/var/lib/outline/data
    depends_on:
      - outline-db
      - outline-redis

  outline-db:
    container_name: outline-db
    image: postgres:15
    restart: always
    environment:
      - TZ=Europe/Berlin
      - POSTGRES_USER=outline
      - POSTGRES_PASSWORD=${DB_PASSWORD}
      - POSTGRES_DB=outline
    volumes:
      - ${BASE_DIR}/db:/var/lib/postgresql/data

  outline-redis:
    container_name: outline-redis
    image: redis:7
    restart: always
    environment:
      - TZ=Europe/Berlin
    volumes:
      - ${BASE_DIR}/redis:/data
EOL

# Container starten
cd "$BASE_DIR"
docker compose up -d

# Health-Check: prüft, ob Outline erreichbar ist
echo
echo "⏳ Prüfe, ob Outline auf http://${LOCAL_IP}:3024 erreichbar ist..."
SUCCESS=false
for i in {1..10}; do
    if curl -s "http://${LOCAL_IP}:3024" >/dev/null; then
        echo "✅ Outline ist erreichbar unter: http://${LOCAL_IP}:3024"
        SUCCESS=true
        # Optional: Browser öffnen (nur auf Desktop)
        if command -v xdg-open >/dev/null; then
            xdg-open "http://${LOCAL_IP}:3024"
        fi
        break
    else
        echo "Warte auf Outline... (${i}/10)"
        sleep 3
    fi
done

if [ "$SUCCESS" = false ]; then
    echo "⚠️ Outline konnte nach 10 Versuchen nicht erreicht werden!"
    echo "Prüfe Firewall, Ports und Docker-Container."
fi

echo
echo "Datenbank-User: outline"
echo "Datenbank-Passwort: ${DB_PASSWORD}"
echo "Container-Logs ansehen: docker logs -f outline"
