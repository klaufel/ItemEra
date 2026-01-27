#!/bin/bash

TOC_FILE="ItemEra/ItemEra.toc"
CONFIG_FILE="ItemEra/Config.lua"

# Check debug flags
if grep -q "ItemEra.CONFIG" "$CONFIG_FILE"; then
  DEBUG=$(grep -E "DEBUG\s*=" "$CONFIG_FILE" | head -1 | awk -F'=' '{gsub(/[ ,]/,"",$2); print $2}')
  DISABLED_DB=$(grep -E "DISABLED_DB\s*=" "$CONFIG_FILE" | head -1 | awk -F'=' '{gsub(/[ ,]/,"",$2); print $2}')
  if [ "$DEBUG" = "true" ] || [ "$DISABLED_DB" = "true" ]; then
    echo "❌ DEBUG or DISABLED_DB is 'true'. Set both to 'false' for release."
    exit 1
  fi
fi

# Increment version
if grep -q "^## Version:" "$TOC_FILE"; then
  OLD_VERSION=$(grep "^## Version:" "$TOC_FILE" | awk '{print $3}')
  IFS='.' read -r MAJOR MINOR PATCH <<< "$OLD_VERSION"
  NEW_VERSION="$MAJOR.$MINOR.$((PATCH))"
  sed -i '' "s/^## Version: .*/## Version: $NEW_VERSION/" "$TOC_FILE"
  echo "✅ Version updated: $OLD_VERSION → $NEW_VERSION"
else
  echo "❌ Version not found in $TOC_FILE"
  exit 1
fi

# Git commit, tag and push
git add .
git commit -m "release: v$NEW_VERSION"
git tag "$NEW_VERSION"
git push origin main --tags

echo "🚀 Release $NEW_VERSION pushed successfully!"
