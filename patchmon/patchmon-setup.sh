#!/bin/bash

set -e

echo "🚀 PatchMon Setup wird gestartet..."

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

DB_PASSWORD=$(openssl rand -hex 16)
JWT_SECRET=$(openssl rand -hex 32)
REDIS_PASSWORD=$(openssl rand -hex 16)

echo "⚙️ Erstelle .env..."

cat > "$PROJECT_DIR/.env" <<EOF
POSTGRES_DB=patchmon_db
POSTGRES_USER=patchmon_user
POSTGRES_PASSWORD=${DB_PASSWORD}

JWT_SECRET=${JWT_SECRET}

REDIS_PASSWORD=${REDIS_PASSWORD}

LOCAL_IP=${LOCAL_IP}
EOF

cd "$PROJECT_DIR"

echo "📝 Erstelle docker-compose.yml..."

cat > docker-compose.yml <<EOF
services:
  patchmon-database:
    image: postgres:17-alpine
    container_name: patchmon-db
    restart: unless-stopped
    environment:
      POSTGRES_DB: \${POSTGRES_DB}
      POSTGRES_USER: \${POSTGRES_USER}
      POSTGRES_PASSWORD: \${POSTGRES_PASSWORD}
    volumes:
      - /home/chris/docker/patchmon/postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U patchmon_user -d patchmon_db"]
      interval: 3s
      timeout: 5s
      retries: 7
    networks:
      - patchmon-net

  patchmon-redis:
    image: redis:7-alpine
    container_name: patchmon-redis
    restart: unless-stopped
    command: redis-server --requirepass \${REDIS_PASSWORD}
    volumes:
      - /home/chris/docker/patchmon/redis_data:/data
    healthcheck:
      test: ["CMD", "redis-cli", "--no-auth-warning", "-a", "\${REDIS_PASSWORD}", "ping"]
      interval: 3s
      timeout: 5s
      retries: 7
    networks:
      - patchmon-net

  backend:
    image: ghcr.io/patchmon/patchmon-backend:latest
    container_name: patchmon-backend
    restart: unless-stopped
    environment:
      LOG_LEVEL: info
      DATABASE_URL: postgresql://\${POSTGRES_USER}:\${POSTGRES_PASSWORD}@patchmon-database:5432/\${POSTGRES_DB}
      JWT_SECRET: \${JWT_SECRET}
      SERVER_PROTOCOL: http
      SERVER_HOST: \${LOCAL_IP}
      SERVER_PORT: 3010
      CORS_ORIGIN: http://\${LOCAL_IP}:3010

      DB_CONNECTION_LIMIT: 30
      DB_POOL_TIMEOUT: 20
      DB_IDLE_TIMEOUT: 300
      DB_MAX_LIFETIME: 1800

      RATE_LIMIT_WINDOW_MS: 900000
      RATE_LIMIT_MAX: 5000
      AUTH_RATE_LIMIT_WINDOW_MS: 600000
      AUTH_RATE_LIMIT_MAX: 500
      AGENT_RATE_LIMIT_WINDOW_MS: 60000
      AGENT_RATE_LIMIT_MAX: 1000

      REDIS_HOST: patchmon-redis
      REDIS_PORT: 6379
      REDIS_PASSWORD: \${REDIS_PASSWORD}
      REDIS_DB: 0

    volumes:
      - /home/chris/docker/patchmon/agent_files:/app/agents

    depends_on:
      patchmon-database:
        condition: service_healthy
      patchmon-redis:
        condition: service_healthy

    networks:
      - patchmon-net

  patchmon-frontend:
    image: ghcr.io/patchmon/patchmon-frontend:latest
    container_name: patchmon-frontend
    restart: unless-stopped
    ports:
      - "3010:3000"
    depends_on:
      backend:
        condition: service_healthy
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
echo "✅ PatchMon läuft!"
echo "Frontend: http://${LOCAL_IP}:3010"
echo ""
