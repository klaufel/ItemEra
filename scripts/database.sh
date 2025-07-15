#!/bin/bash




# Fecha actual en formato ISO
DATE=$(date -u +"%Y-%m-%dT%H:%M:%S%z")

# Ruta de los archivos
JSON_FILE="database.json"
LUA_FILE="Data-4.lua"

# Escribir cabecera en el archivo Lua
cat <<EOF > "$LUA_FILE"
-- https://github.com/t-mart/ItemVersion/blob/master/ItemVersion/Data.lua
-- This is a generated file not meant to be edited by hand.
-- If you need to make modifications, open an issue to discuss.
-- Last updated: $DATE
local _, addon = ...

addon.itemIdToVersionId = {
EOF

# Procesar el JSON y añadir las líneas al archivo Lua (sin jq)
grep -o '"[0-9]\+": [0-9]\+' "$JSON_FILE" | \
sed 's/"\([0-9]\+\)": \([0-9]\+\)/    [\1] = \2,/' >> "$LUA_FILE"

# Cerrar la tabla
echo "}" >> "$LUA_FILE"