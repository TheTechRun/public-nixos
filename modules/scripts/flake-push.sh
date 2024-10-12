#!/usr/bin/env bash

set -euo pipefail

echo "Pushing NixOS configuration changes..."

# Change to the nixos-config directory
cd ~/nixos-config

# Check if there are any changes
if git diff-index --quiet HEAD --; then
    echo "No changes to commit."
    exit 0
fi

# Git operations
echo "Committing changes to git..."
git add .

# Prompt for commit message
read -p "Enter a commit message (default: 'Update NixOS configuration'): " commit_message
commit_message=${commit_message:-"Update NixOS configuration"}
git commit -m "$commit_message"

# Prompt for confirmation before force pushing
echo "Warning: You are about to force push to the master branch."
read -p "Are you sure you want to continue? This may overwrite remote changes. (y/N): " confirm
if [[ $confirm =~ ^[Yy]$ ]]; then
    echo "Force pushing changes to remote repository..."
    git push origin master --force
    echo "Push complete."
else
    echo "Push aborted."
    exit 1
fi

echo "NixOS configuration push complete!"