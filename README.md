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
cd ~/nixos-config
```
# Rename public-nixos directory to nixos-config:
`mv ~/public-nixos ~/nixos-config`

# Copy your hardware-config
`sudo cp /etc/nixos/hardware-configuration.nix ~/nixos-config/modules/system/hardware-configuration.nix`

# Symlink flake:
`sudo ln -sf ~/nixos-config/flake.nix /etc/nixos/flake.nix`

# Add this to configuration.nix to Enable Flakes (already done):
`nix.settings.experimental-features = [ "nix-command" "flakes" ];`

# Make all scripts executable:
`find ~/nixos-config/ -type f -name "*.sh" -exec chmod +x {} +`

# Build Flake:
`sudo nixos-rebuild switch --flake $HOME/nixos-config`

# All-in-one command:
```
cd ~
git clone https://github.com/TheTechRun/public-nixos
cd ~/nixos-config
mv ~/public-nixos/ ~/nixos-config ~/
rmdir ~/public-nixos
sudo cp /etc/nixos/hardware-configuration.nix ~/nixos-config/modules/system/hardware-configuration.nix
sudo ln -sf ~/nixos-config/flake.nix /etc/nixos/flake.nix
find ~/nixos-config/ -type f -name "*.sh" -exec chmod +x {} +
sudo nixos-rebuild switch --flake $HOME/nixos-config
```

# OPTIONAL - Run this script to replace the username with yours:
`bash ~/nixos-config/replace-username.sh`


