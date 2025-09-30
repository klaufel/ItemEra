#!/bin/bash

TOC_FILE="ItemEra/ItemEra.toc"
CONFIG_FILE="ItemEra/Config.lua"


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
