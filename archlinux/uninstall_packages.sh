#!/bin/bash

# Define the package file path
PACKAGE_FILE="/home/pro/.dotfiles/archlinux/packages.txt"

echo "Uninstalling packages..."
echo "from $PACKAGE_FILE listed as ##[package_name]"

# Check if the file exists
if [ ! -f "$PACKAGE_FILE" ]; then
    echo "Error: File '$PACKAGE_FILE' not found!"
    exit 1
fi

# Read the file and uninstall each package starting with ##
grep -E '^## ?' "$PACKAGE_FILE" | while read -r line; do
    # Extract the package name (remove ## and leading/trailing whitespace)
    pkg=$(echo "$line" | sed -E 's/^## ?//; s/^[ \t]*//; s/[ \t]*$//')

    if [ -n "$pkg" ]; then
        echo "Uninstalling: $pkg"
        yay -Rns --noconfirm "$pkg"
    fi
done
