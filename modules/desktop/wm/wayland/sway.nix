# /home/ttr/nixos-config/modules/desktop/wm/wayland/sway.nix
{ config, lib, pkgs, ... }:

{
  programs.sway = {
    enable = true;
    wrapperFeatures = {
      base = true;
      gtk = true;
    };
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export MOZ_ENABLE_WAYLAND=1
      export XDG_CURRENT_DESKTOP=sway
      export XDG_SESSION_TYPE=wayland
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';
    extraPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      mako
      waybar
      wofi
      grim
      slurp
      wf-recorder
      xwayland
      networkmanagerapplet
      rofi
      flameshot
      jumpapp
      pyload-ng
      screenkey
      xfce.catfish
      fsearch
      lightlocker
      haskellPackages.greenclip
      dunst
      brightnessctl
      pamixer
      playerctl
    ];
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  security.polkit.enable = true;
  hardware.graphics.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
}