#!/bin/bash
set -e

echo "Starte README-Generierung..."

# README Header
cat <<EOF > README.md
# 🚀 Script-Sammlung

Dieses Repository enthält verschiedene Setup-Skripte für Docker-Anwendungen.

## 📂 Verfügbare Skripte
EOF

# Debug: Welche Dateien findet er?
echo "Gefundene Scripts:" >&2
find scripte -type f -name "*-setup.sh" -print >&2

# Liste in README schreiben
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
