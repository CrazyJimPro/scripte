# 🚀 Docker + Docker Compose + Portainer Installer

Dieses Repository enthält ein Bash-Skript zur automatischen Installation von:

- [Docker](https://www.docker.com/)  
- [Docker Compose](https://docs.docker.com/compose/) (Plugin)  
- [Portainer](https://www.portainer.io/) als Web-UI für Docker  
- Ein dediziertes Docker-Netzwerk (`docker`)  

---

## 📋 Features

- Installation von Docker über das **offizielle Repository**  
- Automatische Installation des **Docker Compose Plugins**  
- Erstellung eines **Docker Netzwerks** mit dem Namen `docker`  
- Automatischer Start von **Portainer** (läuft auf Port `9000`)  
- Aktueller Benutzer wird zur **Docker-Gruppe** hinzugefügt → kein `sudo` nötig  

---

## 🔧 Installation mit Einzeiler

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/CrazyJimPro/scripte/main/docker-portainer/docker_portainer_setup.sh)"

````

---

## 🌐 Zugriff auf Portainer

Nach der Installation erreichst du Portainer über:

```
http://<deine-server-ip>:9000
```

👉 Beim ersten Start kannst du einen Admin-Benutzer anlegen.

---

## ⚠️ Hinweis

* Nach der Installation musst du dich **neu einloggen** oder einmal aus- und wieder einloggen, damit deine Gruppenzugehörigkeit (`docker`) aktiv wird.
* Alternativ sofort aktivieren mit:

  ```bash
  newgrp docker
  ```

---

## 📦 Updates

### Docker & Compose updaten

```bash
sudo apt-get update && sudo apt-get upgrade -y
```

### Portainer updaten

```bash
docker stop portainer
docker rm portainer
docker pull portainer/portainer-ce:latest
docker run -d \
    -p 9000:9000 \
    --name portainer \
    --restart=always \
    --network docker \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:latest
```

---

## 📝 Lizenz

Dieses Projekt steht unter der **MIT Lizenz**.
