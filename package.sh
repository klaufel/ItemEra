#!/bin/bash

# Get the addon version from TOC file
VERSION=$(grep "## Version:" ItemEra/ItemEra.toc | sed 's/## Version: //')
FOLDER_VERSION="ItemEra-${VERSION}"

# Clean up any existing files
rm -rf *.zip

# Create ItemEra folder and copy contents
mkdir ${FOLDER_VERSION}
cp -r ItemEra/ ${FOLDER_VERSION}/ 2>/dev/null || true

# Remove excluded files from the copied folder
find ${FOLDER_VERSION} -name ".DS_Store" -delete
rm -rf ${FOLDER_VERSION}/.vscode
rm -rf ${FOLDER_VERSION}/_Interface
rm -rf ${FOLDER_VERSION}/README.md
rm -rf ${FOLDER_VERSION}/stylua.toml
rm -rf ${FOLDER_VERSION}/ItemEra
rm -f ${FOLDER_VERSION}/package.sh
rm -f ${FOLDER_VERSION}/*.zip

# Create the zip file
zip -r "${FOLDER_VERSION}.zip" ItemEra

# Clean up temporary folder
rm -rf ${FOLDER_VERSION}

echo "Created ItemEra-${VERSION}.zip"
