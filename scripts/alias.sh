RETAIL="_retail_"
PTR="_ptr_"
XPTR="_xptr_"

FOLDER_SRC="/Users/klaufel/src/klaufel/ItemEra/ItemEra"

for VERSION in "$RETAIL" "$PTR" "$XPTR"; do
    DEST="/Applications/World of Warcraft/${VERSION}/Interface/AddOns/ItemEra"
    mkdir -p "/Applications/World of Warcraft/${VERSION}/Interface/AddOns/"
    [ -e "$DEST" ] && rm -rf "$DEST"
    ln -s "$FOLDER_SRC" "$DEST"
    echo "✅ Created ItemEra alias: ${VERSION}"
done