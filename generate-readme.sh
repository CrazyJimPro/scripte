#!/bin/bash
# Dieses Script erstellt eine README.md mit allen vorhandenen setup-Skripten.

echo "# 🚀 Script-Sammlung" > README.md
echo "" >> README.md
echo "Dieses Repository enthält verschiedene Setup-Skripte für Docker-Anwendungen." >> README.md
echo "" >> README.md
echo "## 📂 Verfügbare Skripte" >> README.md
echo "" >> README.md

# Alle setup.sh Dateien in scripte/*/ auflisten
find scripte -type f -name "*-setup.sh" | sort | while read -r script; do
  name=$(basename "$script")
  dir=$(dirname "$script" | sed 's|scripte/||')
  echo "- **$dir** → \`$name\`" >> README.md
done

echo "" >> README.md
echo "## 🔄 Automatische Aktualisierung" >> README.md
echo "" >> README.md
echo "Die README.md wird bei jedem Push automatisch aktualisiert, damit sie immer alle vorhandenen Skripte auflistet." >> README.md
