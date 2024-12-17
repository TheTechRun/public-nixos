# copy and paste this into your new .nix and then add stuff from docker-compose that you want to convert

{ config, lib, pkgs, ... }:

{
  virtualisation.oci-containers.containers = {
    container-name-here = {
      image = "image-name:latest";
      environment = {
        # Environment variables here (look at other nix files for examples)
        PUID = "1000";
        PGID = "1000";
        UMASK = "002";
        TZ = "America/New_York";
      };
      volumes = [
        "/host/path:/container/path"
        # More volume mappings as needed
      ];
      ports = [
        "host-port:container-port"
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
  networking.firewall.allowedTCPPorts = [ port-number ];
}