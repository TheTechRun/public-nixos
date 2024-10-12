
{
  description = "NixOS configuration with system-wide packages and allowUnfree";

  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
   nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      #url = "github:nix-community/home-manager/release-24.05";
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # Window Managers & Desktop Environments
          ./modules/desktop/wm/x11/i3.nix
          #./modules/desktop/de/wayland/hyprland.nix
          #./modules/desktop/wm/x11/dwm/dwm.nix
          #./modules/desktop/de/wayland/gnome.nix
          #./modules/desktop/de/x11/cinnamon.nix

          # Configs
          ./modules/system/configuration.nix
          ./modules/system/hardware-configuration.nix

          # Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users = {
                          nixuser = import ./modules/users/nixuser/home-nixuser.nix;
                          #nixusertwo = import ./modules/users/nixusertwo/home-nixusertwo.nix;
                        };
          }
          # New module for SYSTEM-WIDE packages and allowUnfree
          ({ config, pkgs, ... }: {
          nixpkgs.config.allowUnfree = true;
          environment.systemPackages = with pkgs; [
 # Basics:
alacritty # terminal
chromium # browser
xed-editor # text editor
rofi # app launcher
dmenu # launcher
micro # terminal text editor

# File Manager:
xfce.thunar
xfce.thunar-archive-plugin

# Others:
bash
folder-color-switcher
cups
distrobox
gpick
haskellPackages.greenclip
home-manager
networkmanagerapplet
pyload-ng
trash-cli
unzip
vlc
wget
xarchiver
xorg.xmodmap
xorg.setxkbmap

# Audio
pulseaudio
pamixer
pavucontrol

# Trackpad 
libinput
libinput-gestures
libnotify
libimobiledevice
ifuse

# Script Dependencies
coreutils
ffmpeg_7
findutils
gawk
moreutils
perl
rclone
rename
rsync
jq
neovim

# for compiling
gcc
gnumake
xorg.libxcb

# Windows Manager
xorg.xinit

# xdm build
jdk 
maven
            ];
          })
        ];
      };
    };
  };
}
