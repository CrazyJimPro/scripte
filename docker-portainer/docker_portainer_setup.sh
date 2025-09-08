#!/bin/bash
set -e

# Script für Installation von Docker, Docker Compose und Portainer
# Getestet auf Debian/Ubuntu-basierten Systemen

echo "[1/6] System aktualisieren..."
sudo apt-get update -y
sudo apt-get upgrade -y

echo "[2/6] Docker installieren..."
sudo apt-get remove -y docker docker-engine docker.io containerd runc || true
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Docker GPG Key und Repo hinzufügen
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release && echo "$ID")/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$(. /etc/os-release && echo "$ID") \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "[3/6] Docker Compose prüfen..."
docker compose version

echo "[4/6] Docker Netzwerk 'docker' erstellen (falls nicht vorhanden)..."
docker network inspect docker >/dev/null 2>&1 || docker network create docker

echo "[5/6] Portainer installieren..."
docker volume create portainer_data
docker run -d \
    -p 9000:9000 \
    --name portainer \
    --restart=always \
    --network docker \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:latest

echo "[6/6] Benutzer zur Docker-Gruppe hinzufügen..."
sudo usermod -aG docker $USER

echo "----------------------------------------------------"
echo "Installation abgeschlossen!"
echo "Docker Version: $(docker --version)"
echo "Portainer läuft auf: http://$(hostname -I | awk '{print $1}'):9000"
echo "Bitte melde dich einmal neu an oder starte die Session neu, damit die Docker-Gruppenzugehörigkeit aktiv wird."
