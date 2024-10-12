#!/usr/bin/env bash

set -euo pipefail

echo "Pulling NixOS configuration changes..."

# Change to the nixos-config directory
cd ~/nixos-config

# Fetch the latest changes
echo "Fetching latest changes from remote..."
git fetch origin

# Check if there are any changes
if git diff --quiet HEAD origin/master; then
    echo "No new changes to pull."
else
    # Pull changes
    echo "Pulling changes excluding hardware-configuration.nix..."
    git pull origin master

    # Checkout files from origin/master, excluding hardware-configuration.nix
    git checkout origin/master -- . ':!hardware-configuration.nix'

    echo "Changes pulled successfully."
    
    # Show a summary of changes
    echo "Summary of changes:"
    git --no-pager log --oneline HEAD@{1}..
fi

echo "Pull operation complete."