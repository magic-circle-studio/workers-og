#!/bin/bash

TARGET_FILE="dist/index.js"

if [ ! -f "$TARGET_FILE" ]; then
    echo "Error: $TARGET_FILE not found!"
    exit 1
fi

# Check if the file already has the patch
if grep -q 'ue("filter",{id:`satori_s-${e}`,filterUnits:"userSpaceOnUse"' "$TARGET_FILE"; then
    echo "✓ $TARGET_FILE is already patched"
    exit 0
fi

# Check if the file contains the pattern we want to patch
if ! grep -q 'ue("filter",{id:`satori_s-${e}`' "$TARGET_FILE"; then
    echo "Error: Pattern not found in $TARGET_FILE"
    exit 1
fi

echo "Patching $TARGET_FILE..."
# Add filterUnits="userSpaceOnUse" to the filter element
sed -i '' 's/ue("filter",{id:`satori_s-${e}`/ue("filter",{id:`satori_s-${e}`,filterUnits:"userSpaceOnUse"/g' "$TARGET_FILE"

# Verify the patch was applied
if grep -q 'ue("filter",{id:`satori_s-${e}`,filterUnits:"userSpaceOnUse"' "$TARGET_FILE"; then
    echo "✓ Successfully patched $TARGET_FILE"
else
    echo "Error: Failed to patch $TARGET_FILE"
    exit 1
fi