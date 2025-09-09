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
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower \
  --interval 18000   # 5 Stunden in Sekunden
