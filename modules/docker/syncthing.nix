{ config, lib, pkgs, ... }:

{
  virtualisation.oci-containers.containers = {
    syncthing = {
      image = "lscr.io/linuxserver/syncthing:latest";
      environment = {
        PUID = "1000";
        PGID = "1000";
        TZ = "America/New_York";
      };
      volumes = [
        "./config:/config"
        "/home/ttr/notes:/notes"
      ];
      ports = [
        "8384:8384"
        "22000:22000/tcp"
        "22000:22000/udp"
        "21027:21027/udp"
      ];
      autoStart = true;
      extraOptions = [
        "--hostname=syncthing"
      ];
    };
  };

  # Enable Docker
  virtualisation.docker.enable = true;

  # Open firewall ports
  networking.firewall = {
    allowedTCPPorts = [ 8384 22000 ];
    allowedUDPPorts = [ 22000 21027 ];
  };
}