#!/bin/bash

# Set the directory to search
search_dir="$HOME/nixos-config"

# Set the fixed search text
search_text="nixuser"

# Prompt for the replacement text
read -p "Enter the text to replace 'nixuser' with: " replace_text

# Function to rename directories
rename_directories() {
    find "$search_dir" -depth -type d -name "*$search_text*" | while read dir; do
        newdir=$(echo "$dir" | sed "s/$search_text/$replace_text/g")
        if [ "$dir" != "$newdir" ]; then
            mv "$dir" "$newdir"
            echo "Renamed directory: $dir -> $newdir"
        fi
    done
}

# Function to replace text in files
replace_in_files() {
    find "$search_dir" -type f \( -name "*.nix" -o -name "*.txt" -o -name "*.sh" \) -print0 | while IFS= read -r -d '' file; do
        if grep -q "$search_text" "$file"; then
            sed -i "s/$search_text/$replace_text/g" "$file"
            echo "Processed file: $file"
        fi
    done
}

# First, rename directories (starting from deepest ones)
rename_directories

# Then, replace text in files
replace_in_files

echo "Replacement complete. All instances of 'nixuser' have been replaced with '$replace_text' in file contents and directory names."