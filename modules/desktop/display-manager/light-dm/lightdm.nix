# /home/ttr/nixos-config/modules/desktop/display-manager/light-dm/lightdm.nix
{ config, lib, pkgs, ... }:

let
  backgroundImage = pkgs.copyPathToStore ../../slick-greeter/1.jpeg;
in
{
  services.xserver = {
    enable = true;
    
    displayManager = {
      defaultSession = "none+i3";
      
      lightdm = {
        enable = true;
        background = backgroundImage;
        greeters.gtk.enable = false;
        
        greeters.slick = {
          enable = true;
          extraConfig = ''
            background=${backgroundImage}
            draw-user-backgrounds=false
            theme-name=Adwaita-dark
            icon-theme-name=Adwaita
            font-name=Sans 11
            xft-antialias=true
            xft-hintstyle=hintfull
            enable-hidpi=auto
          '';
        };
      };
      
      session = [
        {
          name = "i3";
          manage = "window";
          start = ''
            ${pkgs.i3}/bin/i3
          '';
        }
        {
          name = "sway";
          manage = "window";
          start = ''
            export XDG_SESSION_TYPE=wayland
            export XDG_CURRENT_DESKTOP=sway
            exec ${pkgs.sway}/bin/sway
          '';
        }
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    lightdm
    lightdm-slick-greeter
    sway
  ];
}