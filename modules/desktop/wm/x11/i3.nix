{ config, pkgs, callPackage, ... }: 

let
  # Import the background image into the Nix store
  # Adjust this path to point to the correct location of your background image
  backgroundImage = pkgs.copyPathToStore ../../slick-greeter/1.jpeg;
in
{
  environment.pathsToLink = [ "/libexec" ];

  services.xserver = {
    enable = true;
    
    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      lightdm = {
        enable = true;
        background = backgroundImage;
        greeters = {
          gtk.enable = false;
          slick = {
            enable = true;
            extraConfig = ''
              background=${backgroundImage}
              draw-user-backgrounds=false
            '';
          };
        };
      };
    };
  
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
arandr
autokey
autotiling
arandr
betterlockscreen 
dunst
feh
dconf-editor
i3altlayout
i3status 
i3lock
i3blocks
i3status 
lxappearance
libmpdclient
mpd
nitrogen
picom-pijulius
tdrop
jumpapp
wmctrl
xprintidle #for auto lock in i3
xorg.xprop
xdotool
xorg.xev
xorg.xhost
xdg-desktop-portal
xdg-desktop-portal-gtk 

# Lockscreen
xautolock # autolocks
lightlocker # locks screen for real
lightdm-slick-greeter
      ];
    };
  };

  # Move the defaultSession setting here
  services.displayManager.defaultSession = "none+i3";

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}