{ config, lib, pkgs, ... }:

{
  virtualisation.oci-containers.containers = {
    container-name = {
      image = "jellyfin/jellyfin:latest";
      environment = {
        PUID = "1000";
        PGID = "1000";
        UMASK = "002";
        TZ = "America/New_YorkTC";
      };
      volumes = [
        "/mnt/12tb/Jellyfin_Media:/data"
        "/mnt/12tb/docker/jellyfin/config:/config"

      ];
      ports = [
        "8096:8096"
        # More port mappings as needed
      ];
      autoStart = true;
      extraOptions = [
        # Add "--network=host" only if necessary
        # "--network=host"
      ];
    };
  };

  # Open necessary firewall ports
  networking.firewall.allowedTCPPorts = [ 8096 ];
}