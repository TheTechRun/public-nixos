{ config, lib, pkgs, ... }:

{
  virtualisation.oci-containers.containers = {
    rdt = {
      image = "rogerfar/rdtclient:latest";
      environment = {
        PUID = "1000";
        PGID = "1000";
        UMASK = "002";
        TZ = "America/New_York";
      };
      volumes = [
        "/mnt/12tb/data/downloads:/data/downloads"
        "/mnt/12tb/docker/rdt/data/db:/data/db"
      ];
      ports = [
        "6500:6500"
      ];
      autoStart = true;
    };
  };

  # Enable Docker
  virtualisation.docker.enable = true;

  # Open firewall port
  networking.firewall.allowedTCPPorts = [ 6500 ];
}