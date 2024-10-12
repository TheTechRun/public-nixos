#!/usr/bin/env bash

# Set the directory to search
search_dir="$HOME/nixos-config"

# Prompt for the text to search for
read -p "Enter the text to search for: " search_text

# Prompt for the replacement text
read -p "Enter the text to replace it with: " replace_text

# Find all .nix, .txt, and .sh files and perform the replacement
find "$search_dir" -type f \( -name "*.nix" -o -name "*.txt" -o -name "*.sh" \) -print0 | while IFS= read -r -d '' file; do
    # Use sed to replace the text and save changes in-place
    sed -i "s/$search_text/$replace_text/g" "$file"
    echo "Processed: $file"
done

echo "Replacement complete."