#!/bin/bash

# Name des Containers
CONTAINER_NAME="watchtower"

# Prüfen, ob Watchtower schon läuft
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
  echo "Watchtower läuft bereits. Neustart..."
  docker stop $CONTAINER_NAME
  docker rm $CONTAINER_NAME
fi

# Watchtower starten
docker run -d \
  --name $CONTAINER_NAME \
  --restart unless-stopped \
  -e WATCHTOWER_CLEANUP=true \
  -e DOCKER_API_VERSION=1.44 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  nickfedor/watchtower \
  --interval 18000   # 5 Stunden in Sekunden
