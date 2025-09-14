#!/bin/bash
set -e

# README Header
cat <<EOF > README.md
# 🚀 Script-Sammlung

Dieses Repository enthält verschiedene Setup-Skripte für Docker-Anwendungen.

## 📂 Verfügbare Skripte
EOF

# Alle setup.sh Skripte in scripte/*/* finden und auflisten
find scripte -type f -name "*-setup.sh" | sort | while read -r script; do
    script_name=$(basename "$script")
    folder_name=$(basename "$(dirname "$script")")
    echo "- **$folder_name** → \`$script_name\`" >> README.md
done

# Footer
cat <<EOF >> README.md

## 🔄 Automatische Aktualisierung

Die README.md wird bei jedem Push automatisch aktualisiert, damit sie immer alle vorhandenen Skripte auflistet.
EOF
