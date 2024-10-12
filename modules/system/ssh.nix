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
      { addr = "127.0.0.1"; port = 22; }
      { addr = "::1"; port = 22; }
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
  users.users.nixuser = {
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2E... machine_a_public_key"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5... machine_b_public_key"
    ];
  };

  # SSH client configuration
  environment.etc."ssh/ssh_config".text = ''
    Host remote
      HostName remote
      User nixuser
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
  users.users.nixuser.extraGroups = [ "fuse" ];
}
