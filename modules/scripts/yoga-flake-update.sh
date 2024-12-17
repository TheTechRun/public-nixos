#!/usr/bin/env bash

set -euo pipefail

echo "Updating NixOS flake configuration..."

cd $HOME/nixos-config
echo "Updating flake inputs..."
nix flake update

echo "Rebuilding NixOS configuration..."
sudo nixos-rebuild switch --flake .#yoga

echo "NixOS update complete!"