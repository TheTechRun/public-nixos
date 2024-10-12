{ config, pkgs, callPackage, ... }: 

#{
 # environment.pathsToLink = [ "/libexec" ];

  # Lockscreen & logins
  # services.xserver.displayManager.lightdm.enable = true; 
  # services.xserver.displayManager.lightdm.greeters.gtk = {
  #   enable = true;
  #   extraConfig = ''
  #     background=.../slick-greeter/1.jpeg
  #   '';
  # };

  # Regular GTK Greeter
  # services.xserver.displayManager.lightdm = {
  #   enable = true;
  #   background = ".../slick-greeter/1.jpeg";
  #   greeters.gtk.enable = true;
  # };

  let
  # Define the background image path relative to this file
  backgroundImage = .../slick-greeter/1.jpeg;
in
{
  environment.pathsToLink = [ "/libexec" ];

  services.xserver.displayManager.lightdm = {
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

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services.mpd.enable = true; # Music Player Demon  
     
  services.displayManager = {
    enable = true;
    defaultSession = "none+i3";
  };

  # Enable the X11 windowing system
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
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
# lightdm-slick-greeter
xautolock # autolocks
lightlocker # locks screen for real
lightdm-slick-greeter
      ];
    };
  };
}