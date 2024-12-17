#!/usr/bin/env bash

set -euo pipefail

echo "Building and updating NixOS flake configuration..."

# Change to the nixos-config directory
cd ~/nixos-config

# Git operations
echo "Checking for changes..."
# Check both tracked and untracked files
if [[ -n "$(git status --porcelain)" ]]; then
    echo "Changes detected. Committing to git..."
    # Stage all changes, including untracked files
    git add -A

    read -p "Enter a commit message (default: 'Update NixOS configuration'): " commit_message
    commit_message=${commit_message:-"Update NixOS configuration"}
    git commit -m "$commit_message"

    echo "Pushing changes to remote repository..."
    read -p "Are you sure you want to force push to master? (y/N): " confirm
    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
        git push origin master --force
    else
        echo "Push aborted."
    fi
else
    echo "No changes detected in git."
fi

# Rebuild NixOS
echo "Rebuilding NixOS configuration..."
sudo nixos-rebuild switch --flake .#optiplex