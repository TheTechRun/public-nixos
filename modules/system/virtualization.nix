{ config, pkgs, ... }:

{
  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd.enable = true;
    docker = {
      enable = true;
      enableOnBoot = true;
    };
    # Uncomment if you want to use Podman instead of Docker
    # podman = {
    #   enable = true;
    #   autoPrune.enable = true;
    #   defaultNetwork.settings = {
    #     dns_enabled = true;
    #     ipv6_enabled = false;
    #   };
    # };
  };

  programs.virt-manager.enable = true;
}