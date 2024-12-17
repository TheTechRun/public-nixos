# copy and paste this into your new .nix and then add stuff from docker-compose that you want to convert

{ config, lib, pkgs, ... }:

{
  virtualisation.oci-containers.containers = {
    lidarr = {
      image = "lscr.io/linuxserver/lidarr:latest";
      environment = {
        # Environment variables here (look at other nix files for examples)
        PUID = "1000";
        PGID = "1000";
        UMASK = "002";
        TZ = "America/New_York";
      };
      volumes = [
        "/mnt/12tb/docker/lidarr:/config"
        "/mnt/12tb/data:/data"
        #"/mnt/12tb/data/downloads/music-lidarr:/downloads"
      ];
      ports = [
        "8686:8686"
        # More port mappings as needed
      ];
      autoStart = true;
      extraOptions = [
        # Add "--network=host" only if necessary
        # "--network=host"
      ];
    };
  }; 

  # Enable Docker
  virtualisation.docker.enable = true;

  # Open necessary firewall ports
  networking.firewall.allowedTCPPorts = [ 8686 ];
}