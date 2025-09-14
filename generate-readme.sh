#!/bin/bash
set -e

README_FILE="README.md"

# Debug-Ausgabe, damit du im Workflow siehst, was gefunden wird
echo "🔎 Suche nach Setup-Scripten im Ordner 'scripte/'..."
SCRIPTS=$(find scripte -type f -name "*-setup.sh" | sort)

echo "Gefundene Scripts:"
echo "$SCRIPTS" | sed 's/^/ - /'

# README.md neu schreiben
cat > $README_FILE <<EOF
# 🚀 Script-Sammlung

Dieses Repository enthält verschiedene Setup-Skripte für Docker-Anwendungen.

## 📂 Verfügbare Skripte
EOF

if [ -z "$SCRIPTS" ]; then
  echo "" >> $README_FILE
  echo "_(Noch keine Skripte gefunden)_" >> $README_FILE
else
  echo "" >> $README_FILE
  for script in $SCRIPTS; do
    NAME=$(basename "$script")
    DIR=$(dirname "$script")
    echo "- [$NAME]($script) – in \`$DIR\`" >> $README_FILE
  done
fi

cat >> $README_FILE <<EOF

## 🔄 Automatische Aktualisierung

Die \`README.md\` wird bei jedem Push automatisch aktualisiert, damit sie immer alle vorhandenen Skripte auflistet.
EOF

echo "✅ README.md erfolgreich aktualisiert!"
