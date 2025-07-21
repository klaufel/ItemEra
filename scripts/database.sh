#!/bin/bash

# Fecha ISO con microsegundos y zona horaria tipo +00:00
DATE=$(date -u +"%Y-%m-%dT%H:%M:%S.%6NZ")
DATE=${DATE/Z/+00:00}

# Archivos
JSON_FILE_1="./database/itemIdToVersionId.json"
JSON_FILE_2="./database/versionIdToVersion.json"
LUA_FILE="./ItemEra/Data.lua"

{
  echo "-- Last updated: $DATE"
  echo "local _, addon = ..."
  echo ""
} > "$LUA_FILE"

{
    echo -n "addon.itemIdToVersionId = {"
    ENTRIES_2=$(grep '[0-9][0-9]*": [0-9][0-9]*' "$JSON_FILE_1" | \
        sed -E 's/"([0-9]+)": ([0-9]+)/[\1]=\2/')
    echo "$ENTRIES_2" | tr -d '\n' | sed 's/ //g' >> "$LUA_FILE"
    echo "}"
} >> "$LUA_FILE"

{
  echo ""
  echo -n "addon.versionIdToVersion = {"
  # Extraer clave y valor del JSON y formatear como [clave]="valor"
  grep -E '"[0-9]+": "[^"]+"' "$JSON_FILE_2" | \
    sed -E 's/"([0-9]+)": "([^"]+)"/[\1]="\2"/' | \
    tr -d '\n' | sed 's/ //g'
  echo "}"
} >> "$LUA_FILE"