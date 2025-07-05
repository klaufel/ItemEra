#!/bin/bash

# Get the addon version from TOC file
VERSION=$(grep "## Version:" ItemEra.toc | sed 's/## Version: //')

# Clean up any existing files
rm -rf *.zip "ItemEra/"

# Create ItemEra folder and copy contents
mkdir ItemEra
cp -r * ItemEra/ 2>/dev/null || true

# Remove excluded files from the copied folder
find ItemEra -name ".DS_Store" -delete
rm -rf ItemEra/.vscode
rm -rf ItemEra/_Interface
rm -rf ItemEra/ItemEra
rm -f ItemEra/package.sh
rm -f ItemEra/*.zip

# Create the zip file
zip -r "ItemEra-${VERSION}.zip" ItemEra

# Clean up temporary folder
rm -rf ItemEra

echo "Created ItemEra-${VERSION}.zip"
