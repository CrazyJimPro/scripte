#!/bin/bash

set -e

echo "🚀 PatchMon v2 FINAL Setup startet..."

BASE_DIR="/home/chris/docker"
APP_NAME="patchmon"
PROJECT_DIR="${BASE_DIR}/${APP_NAME}"

if [ -f "$PROJECT_DIR/docker-compose.yml" ]; then
    echo "❌ PatchMon ist bereits installiert: $PROJECT_DIR"
    exit 1
fi

mkdir -p "$PROJECT_DIR/postgres_data"
mkdir -p "$PROJECT_DIR/redis_data"
mkdir -p "$PROJECT_DIR/agent_files"

LOCAL_IP=$(hostname -I | awk '{print $1}')

POSTGRES_PASSWORD=$(openssl rand -hex 16)
REDIS_PASSWORD=$(openssl rand -hex 16)
JWT_SECRET=$(openssl rand -hex 32)

echo "⚙️ Erstelle .env..."

cat > "$PROJECT_DIR/.env" <<EOF
POSTGRES_DB=patchmon_db
POSTGRES_USER=patchmon_user
POSTGRES_PASSWORD=${POSTGRES_PASSWORD}

REDIS_PASSWORD=${REDIS_PASSWORD}
JWT_SECRET=${JWT_SECRET}

LOCAL_IP=${LOCAL_IP}
EOF

cd "$PROJECT_DIR"

echo "📝 Erstelle docker-compose.yml (v2 korrekt)..."

cat > docker-compose.yml <<EOF
services:

  patchmon:
    image: ghcr.io/patchmon/patchmon-server:2.0.2
    container_name: patchmon
    restart: unless-stopped

    ports:
      - "3010:3000"

    environment:
      LOG_LEVEL: info
      DATABASE_URL: postgresql://\${POSTGRES_USER}:\${POSTGRES_PASSWORD}@patchmon-db:5432/\${POSTGRES_DB}
      JWT_SECRET: \${JWT_SECRET}

      REDIS_HOST: patchmon-redis
      REDIS_PORT: 6379
      REDIS_PASSWORD: \${REDIS_PASSWORD}

      CORS_ORIGIN: http://\${LOCAL_IP}:3010

    depends_on:
      - patchmon-db
      - patchmon-redis

    networks:
      - patchmon-net

  patchmon-db:
    image: postgres:17-alpine
    container_name: patchmon-db
    restart: unless-stopped

    environment:
      POSTGRES_DB: \${POSTGRES_DB}
      POSTGRES_USER: \${POSTGRES_USER}
      POSTGRES_PASSWORD: \${POSTGRES_PASSWORD}

    volumes:
      - /home/chris/docker/patchmon/postgres_data:/var/lib/postgresql/data

    networks:
      - patchmon-net

  patchmon-redis:
    image: redis:7-alpine
    container_name: patchmon-redis
    restart: unless-stopped

    command: redis-server --requirepass \${REDIS_PASSWORD}

    volumes:
      - /home/chris/docker/patchmon/redis_data:/data

    networks:
      - patchmon-net

networks:
  patchmon-net:
    external: true
EOF

echo "🌐 Prüfe Netzwerk..."
docker network inspect patchmon-net >/dev/null 2>&1 || docker network create patchmon-net

echo "🐳 Starte PatchMon..."
docker compose up -d

echo ""
echo "✅ PatchMon v2 FINAL läuft!"
echo "👉 http://${LOCAL_IP}:3010"
echo ""
