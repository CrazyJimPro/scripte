Alles klar 👍 – dann machen wir das README so, dass jedes Script einen **Einzeiler zum direkten Ausführen** bekommt, und beim Watchtower geben wir zusätzlich noch die wichtigsten Infos.

Hier die überarbeitete Variante:

````markdown
# Docker-Skripte Sammlung

Dieses Repository enthält verschiedene Bash-Skripte zur Installation und Verwaltung von Docker-Containern.  
Alle Skripte können direkt per Einzeiler ausgeführt werden.

---

## Skripte

### Watchtower
Startet den [Watchtower](https://containrrr.dev/watchtower/) Container, der automatisch alle laufenden Docker-Container auf Updates überprüft und aktualisiert.  
- Cleanup von alten Images (`WATCHTOWER_CLEANUP=true`)  
- Intervall: alle **5 Stunden**  
- Container startet automatisch nach einem Reboot neu  

**Einzeiler:**
```bash
bash -c "$(curl -fsSL https://github.com/CrazyJimPro/scripte/main/watchtower/watchtower.sh)"
````

Logs ansehen:

```bash
docker logs -f watchtower
```

---

### Authentik

Installiert den **Authentik** Identity Provider.

**Einzeiler:**

```bash
bash -c "$(curl -fsSL https://github.com/CrazyJimPro/scripte/main/authentik/authentik-setup.sh)"
```

---

### Portainer

Startet **Portainer** als Weboberfläche für Docker-Management.

**Einzeiler:**

```bash
bash -c "$(curl -fsSL https://github.com/CrazyJimPro/scripte/main/portainer/portainer.sh)"
```

---

### Pi-hole

Installiert **Pi-hole** als Netzwerk-weiten Adblocker in Docker.

**Einzeiler:**

```bash
bash -c "$(curl -fsSL https://github.com/CrazyJimPro/scripte/main/pihole/pihole.sh)"
```

---

## Hinweise

* Jedes Skript ist **autark** und kann unabhängig ausgeführt werden.
* Logs und Status der Container lassen sich mit `docker ps` und `docker logs <container>` prüfen.
* Weitere Skripte werden nach und nach ergänzt.

```

---

👉 Soll ich die Struktur so machen, dass du nur den **Ordnernamen + Skriptname eintragen** musst, damit es konsistent bleibt, falls du später neue Scripts hinzufügst?
```
