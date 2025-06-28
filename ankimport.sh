#!/bin/bash

ZIP_FILE="$1"
ANKI_MEDIA_DIR="/Users/your.username/Library/Application Support/Anki2/User 1/collection.media"

echo "Unpacking $ZIP_FILE..."
unzip -j "$ZIP_FILE" "media/*" -d "$ANKI_MEDIA_DIR"
unzip -j "$ZIP_FILE" "items.csv" -d .

echo "Starting Anki..."
open -a "Anki"
sleep 3

curl localhost:8765 -X POST -d @- <<EOF
{
    "action": "guiImportFile",
    "version": 6,
    "params": {
        "path": "$(pwd)/items.csv"
    }
}
EOF

echo
echo "Press Enter to continue..."
read -p ""

echo "Cleaning up..."
rm items.csv
rm "$ZIP_FILE"
echo "Done." 