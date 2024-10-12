#!/bin/bash

# Set the directory to search
search_dir="$HOME/nixos-config"

# Set the fixed search text
search_text="nixuser"

# Prompt for the replacement text
read -p "Enter the text to replace 'nixuser' with: " replace_text

# Find all .nix, .txt, and .sh files and perform the replacement
find "$search_dir" -type f \( -name "*.nix" -o -name "*.txt" -o -name "*.sh" \) -print0 | while IFS= read -r -d '' file; do
    # Use sed to replace the text and save changes in-place
    sed -i "s/$search_text/$replace_text/g" "$file"
    echo "Processed: $file"
done

echo "Replacement complete. All instances of 'nixuser' have been replaced with '$replace_text'."