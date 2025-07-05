#!/bin/bash

# Get the addon version from TOC file
VERSION=$(grep "## Version:" ItemEra.toc | sed 's/## Version: //')

# Create the zip file in the current directory
rm -rf "ItemEra" "ItemEra.zip"
zip -r "ItemEra.zip" . \
    -x "*.DS_Store" \
       "*/.DS_Store" \
       "**/.DS_Store" \
       ".vscode/*" \
       "_Interface/*" \
       "ItemEra/*" \
       "Thumbs.db" \
       ".git/*" \
       ".gitignore" \
       "package.sh" \
       "*.zip"

echo "Created ItemEra: v${VERSION}.zip"
