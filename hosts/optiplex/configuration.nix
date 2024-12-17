{ config, pkgs, lib, ... }:

{
  imports =
      [ 
           # Desktop Environment
      ../../modules/desktop/wm/x11/i3.nix  
      ../../modules/desktop/wm/wayland/sway.nix  
      ../../modules/desktop/display-manager/light-dm/lightdm.nix

           # System
          ./hardware-configuration.nix
      ../../modules/displaylink/displaylink.nix
      ../../modules/system/audio.nix
      ../../modules/system/cron.nix
      ../../modules/system/cups-canon-zebra.nix
      ../../modules/system/firewall.nix
      ../../modules/system/samba.nix
      ../../modules/system/services.nix
      ../../modules/system/ssh.nix
      ../../modules/system/virtualization.nix
      ../../modules/system/xmodmap.nix
            
        # Distrobox
      ../../modules/docker/arch-ttr.nix

        # Docker
      ../../modules/docker/docker-updates.nix
      ../../modules/docker/portainer.nix
      ../../modules/docker/sonarr.nix
      ../../modules/docker/jackett.nix
      ../../modules/docker/rdt.nix
      ../../modules/docker/searxng.nix
      ../../modules/docker/vaultwarden.nix
      ../../modules/docker/syncthing.nix
      ../../modules/docker/lidarr.nix
      ];
  
  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Define your hostname
  networking.hostName = "optiplex"; 

  # Define your nixos version
  system.stateVersion = "24.05"; 

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable UID and GUID change
  users.mutableUsers = true;

  # Enable Logitech
  hardware.logitech.wireless.enable = true;
  
  # Kensington Expert Scrolling Button
  systemd.user.services.enable-scroll = {
    description = "Enable scrolling with Kensington Expert button";
    wantedBy = [ "default.target" ];
    script = "${pkgs.bash}/bin/bash ~/.scripts/TTR-Scripts/TTR-KensingtonExpert/saved-mappings/righty.sh";
  };

  # Set terminator as the default terminal
  environment.variables = {
    XDG_TERMINAL = "terminator";
  };     

  # Enable programs
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable Sudo
  security.sudo.enable = true;

  # Bootloader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 30; 
  boot.loader.efi.canTouchEfiVariables = true;

  # Garbage collection
  nix.gc.automatic = true; 
   
  # Enable bin files to run
  programs.nix-ld.enable = true;

  # Set time zone
  time.timeZone = "America/New_York";

  # Locale settings
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  }; 

  environment.sessionVariables = {
    PATH = ["${pkgs.pyload-ng}/bin"];
  };

  # Enable libinput
  services.libinput.enable = true;
}