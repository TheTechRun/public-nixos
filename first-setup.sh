#!/usr/bin/env bash

# Prompt for username
read -p "Enter your username: " username

# Set the $user variable
user="/home/$username"

# git clone:
cd "$user"
git clone https://github.com/TheTechRun/nixos-config
cd "$user/nixos-config"

# Copy your hardware-config
cp /etc/nixos/hardware-configuration.nix "$user/nixos-config/modules/system/hardware-configuration.nix"

# Symlink your flake:
ln -sf "$user/nixos-config/flake.nix" /etc/nixos/flake.nix

# Make all scripts executable:
chmod +x "$user/nixos-config/modules/scripts/"*.sh

# Run the build script:
sudo nixos-rebuild switch --flake $user/nixos-config
