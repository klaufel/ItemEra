#!/bin/bash

TOC_FILE="ItemEra/ItemEra.toc"

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

# Clean up any existing files
rm -rf *.zip

# Create ItemEra folder and copy contents
mkdir ${FOLDER_VERSION}
cp -r ItemEra/ ${FOLDER_VERSION}/ 2>/dev/null || true

# Remove excluded files from the copied folder
find ${FOLDER_VERSION} -name ".DS_Store" -delete
rm -rf ${FOLDER_VERSION}/ItemEra
rm -f ${FOLDER_VERSION}/*.zip

# Create the zip file
zip -r "${FOLDER_VERSION}.zip" ItemEra

# Clean up temporary folder
rm -rf ${FOLDER_VERSION}

echo "✅ Created ItemEra-${NEW_VERSION}.zip"
open .
