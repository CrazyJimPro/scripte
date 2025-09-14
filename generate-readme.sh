#!/bin/bash
set -e

# Datei in die README geschrieben wird
README="README.md"

# Header
cat <<EOF > $README
# 🐧 Script-Sammlung

Dieses Repository enthält verschiedene **Setup-Skripte**, um Anwendungen schnell mit Docker Compose zu installieren und zu starten.  
Jedes Setup liegt in einem eigenen Unterordner.

## 📂 Vorhandene Skripte
EOF

# Alle *-setup.sh Dateien auflisten
find scripte -type f -name "*-setup.sh" | sort | while read -r script; do
  name=$(basename "$script")
  dir=$(basename "$(dirname "$script")")
  echo "- [$dir]($script) – Setup-Skript für **$dir**" >> $README
done

# Footer
cat <<EOF >> $README

## ⚡ Automatische Aktualisierung
Die README wird automatisch bei jedem Commit aktualisiert (via GitHub Actions Workflow im Ordner \`.github/workflows/\`).

EOF

