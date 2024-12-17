# This runs arch as root user only

{ config, lib, pkgs, ... }:

let
  archContainer = config.virtualisation.oci-containers.containers.archlinux;
in
{
  virtualisation.oci-containers.containers = {
    archlinux = {
      image = "quay.io/toolbx/arch-toolbox:latest";
      autoStart = true;
      volumes = [
        "/home:/home"
        "/media:/media"
        "/mnt:/mnt"
        "/etc/resolv.conf:/etc/resolv.conf:ro"
      ];
      extraOptions = [
        "--network=host"
        "--security-opt=label=disable"
        "--security-opt=seccomp=unconfined"
        "--device=/dev/fuse"
        "--cap-add=CAP_SYS_ADMIN"
        "--cap-add=CAP_NET_ADMIN"
      ];
      cmd = [ "tail" "-f" "/dev/null" ];  # Keep the container running
    };
  };

  environment.systemPackages = with pkgs; [ 
    distrobox
    (writeScriptBin "enter-archlinux" ''
      #!${pkgs.stdenv.shell}
      set -e
      echo "Checking Arch Linux container status..."
      if ! ${pkgs.docker}/bin/docker ps -a | grep -q archlinux; then
        echo "Arch Linux container not found. Creating it..."
        ${pkgs.docker}/bin/docker create --name archlinux ${toString archContainer.extraOptions} ${toString (map (v: "-v ${v}") archContainer.volumes)} ${archContainer.image} tail -f /dev/null
      fi
      
      echo "Ensuring Arch Linux container is running..."
      CONTAINER_STATUS=$(${pkgs.docker}/bin/docker inspect -f '{{.State.Status}}' archlinux)
      if [ "$CONTAINER_STATUS" != "running" ]; then
        echo "Starting Arch Linux container..."
        ${pkgs.docker}/bin/docker start archlinux
        sleep 2  # Give the container a moment to start up
      fi
      
      echo "Entering Arch Linux container..."
      exec ${pkgs.docker}/bin/docker exec -it archlinux /bin/bash
    '')
    (writeScriptBin "debug-arch-container" ''
      #!${pkgs.stdenv.shell}
      echo "Arch container configuration:"
      echo "Image: ${archContainer.image}"
      echo "AutoStart: ${toString archContainer.autoStart}"
      echo "Volumes: ${toString archContainer.volumes}"
      echo "Extra options: ${toString archContainer.extraOptions}"
      echo "Container Status:"
      ${pkgs.docker}/bin/docker inspect archlinux
    '')
  ];

  # Ensure Docker service is enabled
  virtualisation.docker.enable = true;
}