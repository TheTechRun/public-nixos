{ config, pkgs, lib, ... }:

{
  imports =
      [ 

              # Desktop Environment
          ../../modules/desktop/wm/x11/i3.nix   
    
               # System
              ./hardware-configuration.nix
          ../../modules/system/audio.nix
          ../../modules/system/16gb-swap.nix
          #../../modules/system/cron.nix
          ../../modules/system/cups.nix
          ../../modules/system/firewall.nix
          ../../modules/system/samba.nix
          ../../modules/system/services.nix
          ../../modules/system/ssh.nix
          ../../modules/system/virtualization.nix
          ../../modules/system/xdomap.nix
   
      ];
  
  
   # Enable flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Define your hostname.
  networking.hostName = "yoga"; 

  # Define your nixos version.
  system.stateVersion = "24.05"; 

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable UID and GUID change
  users.mutableUsers = true;

  # Set terminator as the default terminal
  environment.variables = {
   XDG_TERMINAL = "terminator";
  };     

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };

  #Enable Sudo
  security.sudo.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 30; 
  boot.loader.efi.canTouchEfiVariables = true;

  # Bootloader. (Use this for grub instead especially if you're on a VM)
  #boot.loader.grub.enable = true;
  #boot.loader.grub.device = "/dev/vda";
  #boot.loader.grub.useOSProber = true;

  # garbage collection
  nix.gc.automatic = true; 
   
  # Enable bin files to run
  programs.nix-ld.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
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

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

}
