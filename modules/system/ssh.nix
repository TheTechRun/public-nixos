{ config, lib, pkgs, ... }:

{
  # Server-side SSH configuration
  services.openssh = {
    enable = true;
    
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      # Enable SFTP subsystem
      Subsystem = "sftp internal-sftp";
    };
    
    # Consider changing this if you need SSH access from other machines
    listenAddresses = [
      #All Addresses
     # { addr = "0.0.0.0"; port = 22; }  # IPv4: all interfaces
     # { addr = "::"; port = 22; }       # IPv6: all interfaces
      
      # Tailscale Only
      { addr = "100.92.247.76"; port = 22; } # PC
    ];
  };

  # Enable FUSE
  boot.kernelModules = [ "fuse" ];

  # Install SSHFS and other useful SSH-related tools
  environment.systemPackages = with pkgs; [
    sshfs
    openssh
    fuse
  ];

  # Set up SSH keys for your user
  users.users.ttr = {
    openssh.authorizedKeys.keys = [
      # Laptop
     "ssh-ed25519 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXx git@dummy.com"

     # Termux (Android):
     "ssh-ed25519 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ssh@dummy.com"

    ];
  };

  # SSH client configuration for remote PC
  environment.etc."ssh/ssh_config".text = ''
    Host remote
      HostName remote
      User ttr
      Port 22
      ForwardX11 yes
      IdentityFile ~/.ssh/id_ed25519
      ServerAliveInterval 60
      ServerAliveCountMax 3
      Compression yes
  '';

  # Enable X11 forwarding
  services.xserver.enable = true;

  # Allow users in the "fuse" group to use FUSE
  users.groups.fuse = {};
  users.users.ttr.extraGroups = [ "fuse" ];
}
