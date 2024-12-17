{ config, lib, pkgs, ... }:

{
  virtualisation.oci-containers.containers = {
    sonarr = {
      image = "ghcr.io/hotio/sonarr:latest";
      environment = {
        PUID = "1000";
        PGID = "1000";
        UMASK = "002";
        TZ = "America/New_York";
      };
      volumes = [
        "/mnt/12tb/docker/sonarr:/config"
        "/mnt/12tb/data:/data"
      ];
      ports = [
        "8989:8989"
      ];
      autoStart = true;
    };
  };

  # Enable Docker
  virtualisation.docker.enable = true;

  # Open firewall port
  networking.firewall.allowedTCPPorts = [ 8989 ];
}