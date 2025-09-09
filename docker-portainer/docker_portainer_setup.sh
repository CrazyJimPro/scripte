#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Robustiertes Install-Skript für Docker + Compose + Portainer
# Getestet auf Debian/Ubuntu-basierten Systemen

TARGET_USER="${SUDO_USER:-${USER:-$(id -un)}}"

echo "Ziel-Benutzer: $TARGET_USER"

echo "[1/8] System aktualisieren..."
sudo apt-get update -y
sudo apt-get upgrade -y

echo "[2/8] Voraussetzungen installieren..."
sudo apt-get install -y ca-certificates curl gnupg lsb-release

echo "[3/8] Docker-Repository einrichten..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL "https://download.docker.com/linux/$(. /etc/os-release && echo "$ID")/gpg" | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$(. /etc/os-release && echo "$ID") \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
echo "[4/8] Docker & Plugins installieren..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "[5/8] Docker Service aktivieren & starten..."
sudo systemctl enable --now docker

# Warte bis Docker antwortet (Timeout ~40s)
echo "[6/8] Auf Docker-Daemon warten..."
attempts=0
until sudo docker info >/dev/null 2>&1; do
  attempts=$((attempts+1))
  if [ "$attempts" -gt 20 ]; then
    echo "Fehler: Docker-Daemon reagiert nicht nach ~40s. Prüfe 'sudo systemctl status docker'." >&2
    exit 1
  fi
  sleep 2
done

echo "[7/8] Docker Compose prüfen..."
sudo docker compose version || sudo docker --version

echo "[8/8] Netzwerk, Volume und Portainer anlegen/starten..."
# Netzwerk anlegen (falls nicht vorhanden)
if ! sudo docker network inspect docker >/dev/null 2>&1; then
  echo "Erstelle Netzwerk 'docker'..."
  sudo docker network create docker
else
  echo "Netzwerk 'docker' existiert bereits."
fi

# Portainer-Volume + Container (Port 9000)
sudo docker volume create portainer_data >/dev/null || true

# falls ein älterer Portainer-Container existiert, entfernen (safe)
if sudo docker ps -a --format '{{.Names}}' | grep -q '^portainer$'; then
  echo "Vorhandenen Portainer-Container entfernen..."
  sudo docker rm -f portainer >/dev/null || true
fi

echo "Starte Portainer (http :9000)..."
sudo docker run -d \
  -p 9000:9000 \
  --name portainer \
  --restart=always \
  --network docker \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce:latest

echo ""
echo "Portainer-Status:"
sudo docker ps --filter "name=portainer" --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"

# Benutzer zur docker-Gruppe hinzufügen (sorgfältig TARGET_USER verwenden)
if id -nG "$TARGET_USER" | grep -qw docker; then
  echo "Benutzer $TARGET_USER ist bereits in der Gruppe 'docker'."
else
  echo "Füge Benutzer $TARGET_USER zur Gruppe 'docker' hinzu..."
  sudo usermod -aG docker "$TARGET_USER"
  echo "Benutzer $TARGET_USER zur 'docker'-Gruppe hinzugefügt."
fi

echo
echo "----------------------------------------------------"
echo "Fertig. Portainer sollte erreichbar sein unter: http://$(hostname -I | awk '{print $1}'):9000"
echo "Wichtig: Melde dich **neu an** (oder führe 'newgrp docker' in deiner Shell aus), damit die Gruppenzugehörigkeit aktiv wird."
echo "Wenn Portainer nicht läuft: 'sudo docker logs portainer --tail 100' und 'sudo systemctl status docker' prüfen."

