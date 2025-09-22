#!/usr/bin/env bash

# Disable hot reloading for zipping
sed -i "s/HOTRELOADING = true/HOTRELOADING = false/g" "main.lua"

OUTPUT_ZIP=${1:-"Xaidee-FocusCrystalOverBrassKnuckles.zip"}

EXCLUDE_PATTERNS=("$OUTPUT_ZIP")

if [ -f .gitignore ]; then
    while IFS= read -r line; do
        # Skip empty lines and comments
        [[ -z "$line" || "$line" =~ ^# ]] && continue
        EXCLUDE_PATTERNS+=("$line")
    done < .gitignore
fi

rm "$OUTPUT_ZIP"
zip -r "$OUTPUT_ZIP" . -x "${EXCLUDE_PATTERNS[@]}"
# Re-enable DEBUG for dev
sed -i "s/DEBUG = false/DEBUG = true/g" "main.lua"
