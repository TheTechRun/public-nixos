{ config, lib, pkgs, ... }:

{
  virtualisation.oci-containers.containers = {
    navidrome = {
      image = "deluan/navidrome:latest";
      user = "1000:1000";
      environment = {
        ND_SCANSCHEDULE = "1h";
        ND_LOGLEVEL = "info";
        ND_SESSIONTIMEOUT = "24h";
        ND_BASEURL = "";
      };
      volumes = [
        "/12tb/Backups/Mega_NZ_Backup/Documents/docker/navidrome:/data"
        "/12tb/Backups/BIG_Backups/Music:/music:ro"
      ];
      ports = [
        "4533:4533"
      ];
      autoStart = true;
    };
  };

  # Enable Docker
  virtualisation.docker.enable = true;

  # Open firewall port
  networking.firewall.allowedTCPPorts = [ 4533 ];
}
