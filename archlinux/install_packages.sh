#!/bin/bash

# File containing the list of packages
PACKAGE_FILE="/home/pro/.dotfiles/archlinux/packages.txt"

# Check if the package file exists
if [[ ! -f "$PACKAGE_FILE" ]]; then
    echo "Error: $PACKAGE_FILE not found!"
    exit 1
fi

# Read and process each line in the package file
while IFS= read -r package || [[ -n "$package" ]]; do
    # Skip empty lines or lines starting with '#'
    [[ "$package" =~ ^#.*$ || -z "$package" ]] && continue

    # Check if the package is already installed
    if paru -Qi "$package" &>/dev/null; then
        echo "Package '$package' is already installed."
    else
        echo "Installing package '$package'..."
        paru -S --needed --noconfirm "$package"
    fi
done < "$PACKAGE_FILE"
