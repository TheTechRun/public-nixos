# Intro:
### This is a public version of my Nix-OS setup. It is similar to my private setup with a few alterations. 

### This will install barebones i3wm with light-dm/slick-greeter. You can comment in and out whichever included desktop environment or window manager that you'd like. I will also be adding Sway and KDE nix files soon. 

# Future plans:
I am going to convert my docker-compose files to nix files. Also, converting bash files to nix as well. 

# INSTALL:
`nix-shell -p git`

```
cd ~
git clone https://github.com/TheTechRun/public-nixos
```
# Rename public-nixos directory to nixos-config:
`mv ~/public-nixos ~/nixos-config`

# Enable Flakes in your configuration.nix:
`sudo sed -i '$ i\  # Enable flakes.\n  nix.settings.experimental-features = [ "nix-command" "flakes" ];\n' /etc/nixos/configuration.nix`

# Rebuild your configuration.nix:
```
cd /etc/nixos/
sudo nixos-rebuild switch
```

# Copy your hardware-config
`sudo cp /etc/nixos/hardware-configuration.nix ~/nixos-config/modules/system/hardware-configuration.nix`

# Symlink flake:
`sudo ln -sf ~/nixos-config/flake.nix /etc/nixos/flake.nix`

# Make all scripts executable:
`find ~/nixos-config/ -type f -name "*.sh" -exec chmod +x {} +`

# Build Flake:
`sudo nixos-rebuild switch --flake $HOME/nixos-config`

# ALL-in-ONE command:
### Start a shell:
`nix-shell -p git`

### Now run:
```
cd ~
git clone https://github.com/TheTechRun/public-nixos
mv ~/public-nixos/ ~/nixos-config
sudo sed -i '$ i\  # Enable flakes.\n  nix.settings.experimental-features = [ "nix-command" "flakes" ];\n' /etc/nixos/configuration.nix
cd /etc/nixos/
sudo nixos-rebuild switch
sudo cp /etc/nixos/hardware-configuration.nix ~/nixos-config/modules/system/hardware-configuration.nix
sudo ln -sf ~/nixos-config/flake.nix /etc/nixos/flake.nix
find ~/nixos-config/ -type f -name "*.sh" -exec chmod +x {} +
sudo nixos-rebuild switch --flake $HOME/nixos-config
```

# OPTIONAL - Run this script to replace the username with yours:
`bash ~/nixos-config/replace-username.sh`


