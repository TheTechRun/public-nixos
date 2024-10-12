{ config, pkgs, ... }:

{
  imports = [
    #./bashrc.nix
    #...other imports
  ];

  # TODO please change the username & home directory to your own
  home.username = "nixuser";
  home.homeDirectory = "/home/nixuser";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';
  
  # Set environment variables
  home.sessionVariables = {
    EDITOR = "micro";
    PATH = "$PATH:/usr/bin:$HOME/.local/bin:$HOME/nixuser-app-repo/";
  };

  # Set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 22;
    # "Xft.dpi" = 172;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [

# Testing
kmonad #keybaord

# Web Browsers:
brave
firefox
#microsoft-edge
opera

# File Managers & Addons:
xfce.catfish
mate.caja-with-extensions
ranger

# Music:
clementine
sayonara

# Basics
terminator # Konsole
bitwarden # PW Manager

# Productivity:
autokey
colorpicker # waylad
flameshot
fsearch
gpick # Colorpicker x11
piper-tts
normcap # OCR
scrcpy # Screen Record
tree # directory structure hierarchies 
#joplin-desktop # Notes

# Self Hosting:
docker-compose
#cloudflared
#rustdesk-flutter

# Programming:
android-tools
neovim
#neovim-unwrapped
vscodium # Text Editor

# Editing:
audacity
gimp-with-plugins
obs-studio 

# Virtual:
distrobox
virt-manager

# TUI:
bottom
cava
cmatrix
fastfetch
figlet #ASVII Generator
glava
glow
neofetch

# Other
#ferdium
gparted
gthumb #Pic Viewer
gtk4
jumpapp
localsend
lsof
megacmd
playerctl 
polybarFull
protonvpn-gui      
scrot #Screenshot
starship
syncthing
tmux
wine
xarchiver
xclip
xdotool
xvfb-run
yt-dlp
zenity #Prompt for new Files

# fonts
font-awesome
nerdfonts
unifont

# Soulseek
nicotine-plus
slskd

# Messaging
#discord
#telegram-desktop
#element-desktop

# Jellyfin Programs
#jellyfin
#jellyfin-ffmpeg
#jellyfin-web


  ];

  # basic configuration of programs, please change to your own:
  #Git
  programs.bat = {
    enable = true;
    config = {
      theme = "GitHub";
      italic-text = "always";
    };    
  };
  
  programs.git = {
    enable = true;
    userName = "Nixuser";
    userEmail = "something @something.com";
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  # home.enableNixpkgsReleaseCheck = false;
}