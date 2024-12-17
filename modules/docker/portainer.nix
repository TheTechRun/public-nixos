{ config, lib, pkgs, ... }:

{
  virtualisation.oci-containers.containers = {
    portainer = {
      image = "portainer/portainer-ce:latest";
      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock"
        "portainer_data:/data"
      ];
      ports = [
        "8009:8009"
        "9443:9443"
      ];
      autoStart = true;
    };
  };

  # Enable Docker
  virtualisation.docker.enable = true;

  # Open firewall ports
  networking.firewall.allowedTCPPorts = [ 8009 9443 ];
}