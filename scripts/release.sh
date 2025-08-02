#!/bin/bash

TOC_FILE="ItemEra/ItemEra.toc"
CONFIG_FILE="ItemEra/Config.lua"

if grep -q "ItemEra.CONFIG" "$CONFIG_FILE"; then
  DEBUG=$(grep -E "DEBUG\s*=" "$CONFIG_FILE" | head -1 | awk -F'=' '{gsub(/[ ,]/,"",$2); print $2}')
  DISABLED_DB=$(grep -E "DISABLED_DB\s*=" "$CONFIG_FILE" | head -1 | awk -F'=' '{gsub(/[ ,]/,"",$2); print $2}')
  if [ "$DEBUG" = "true" ] || [ "$DISABLED_DB" = "true" ]; then
    echo "❌ DEBUG or DISABLED_DB is 'true'. Set both to 'false' for packaging."
    exit 1
  fi
fi


if grep -q "^## Version:" "$TOC_FILE"; then
  OLD_VERSION=$(grep "^## Version:" "$TOC_FILE" | awk '{print $3}')
  IFS='.' read -r MAJOR MINOR PATCH <<< "$OLD_VERSION"
  NEW_VERSION="$MAJOR.$MINOR.$((PATCH + 1))"
  sed -i '' "s/^## Version: .*/## Version: $NEW_VERSION/" "$TOC_FILE"
  echo "Version updated: $OLD_VERSION → $NEW_VERSION"
else
  echo "Not Version found in $TOC_FILE"
  exit 1
fi

FOLDER_VERSION="ItemEra-${NEW_VERSION}"

rm -rf *.zip

rm -rf temp
mkdir -p temp/ItemEra

cp -r ItemEra/* temp/ItemEra/
find temp/ItemEra -name ".DS_Store" -delete

cd temp
zip -r "../${FOLDER_VERSION}.zip" ItemEra
cd ..

rm -rf temp

echo "✅ Created ${FOLDER_VERSION}.zip"
open .
