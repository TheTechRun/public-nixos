{ config, lib, pkgs, ... }:

let
  zwm = pkgs.callPackage /home/ctech/.config/zwm/default.nix {};
in
{
  options.services.zwm = {
    enable = lib.mkEnableOption "zwm window manager";
  };

  config = lib.mkIf config.services.zwm.enable {
    environment.systemPackages = [ zwm ];
    environment.pathsToLink = [ "/libexec" ];

    services.xserver = {
      enable = true;
      desktopManager.xterm.enable = false;
      displayManager = {
        lightdm.enable = true;
        defaultSession = "none+zwm";
        session = [
          {
            name = "zwm";
            start = ''
              ${zwm}/bin/zwm &
              waitPID=$!
            '';
          }
        ];
      };
    };

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}
