{ config, lib, pkgs, ... }:

{
  virtualisation.oci-containers.containers = {
    vaultwarden = {
      image = "vaultwarden/server:latest";
      volumes = [
        "/mnt/12tb/Backups/Mega_NZ_Backup/Documents/docker/vaultwarden:/data/"
      ];
      ports = [
        "4378:80"
      ];
      autoStart = true;
    };
  };

  # Enable Docker
  virtualisation.docker.enable = true;

  # Open firewall port
  networking.firewall.allowedTCPPorts = [ 4378 ];
}