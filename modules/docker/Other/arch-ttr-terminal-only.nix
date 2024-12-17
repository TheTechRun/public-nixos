# Arch in command line only. No X-Server

{ config, lib, pkgs, ... }:

let
  username = "ttr";
  containerName = "arch-${username}";
  userHome = "/home/${username}";
  archContainer = config.virtualisation.oci-containers.containers.${containerName};
in
{
  virtualisation.oci-containers.containers = {
    ${containerName} = {
      image = "quay.io/toolbx/arch-toolbox:latest";
      autoStart = true;
      volumes = [
        "${userHome}:${userHome}"
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
      cmd = [ "tail" "-f" "/dev/null" ];
    };
  };

  environment.systemPackages = with pkgs; [ 
    distrobox
    (writeScriptBin "enter-arch-${username}" ''
      #!${pkgs.stdenv.shell}
      set -e
      echo "Checking ${containerName} container status..."
      if ! ${pkgs.docker}/bin/docker ps -a | grep -q ${containerName}; then
        echo "${containerName} container not found. Creating it..."
        ${pkgs.docker}/bin/docker create --name ${containerName} ${toString archContainer.extraOptions} ${toString (map (v: "-v ${v}") archContainer.volumes)} ${archContainer.image} tail -f /dev/null
      fi
      
      echo "Ensuring ${containerName} container is running..."
      CONTAINER_STATUS=$(${pkgs.docker}/bin/docker inspect -f '{{.State.Status}}' ${containerName})
      if [ "$CONTAINER_STATUS" != "running" ]; then
        echo "Starting ${containerName} container..."
        ${pkgs.docker}/bin/docker start ${containerName}
      fi
      
      echo "Setting up user ${username} in the container..."
      ${pkgs.docker}/bin/docker exec ${containerName} bash -c "
        if ! id ${username} &>/dev/null; then
          useradd -m -u $(id -u ${username}) ${username}
          echo '${username} ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
        fi
      "
      
      echo "Entering ${containerName} container..."
      exec ${pkgs.docker}/bin/docker exec -it -u ${username} -e HOME=${userHome} ${containerName} /bin/bash
    '')
    (writeScriptBin "debug-${containerName}" ''
      #!${pkgs.stdenv.shell}
      echo "${containerName} configuration:"
      echo "Image: ${archContainer.image}"
      echo "AutoStart: ${toString archContainer.autoStart}"
      echo "Volumes: ${toString archContainer.volumes}"
      echo "Extra options: ${toString archContainer.extraOptions}"
      echo "Container Status:"
      ${pkgs.docker}/bin/docker inspect ${containerName}
      echo "User in container:"
      ${pkgs.docker}/bin/docker exec ${containerName} id ${username} || echo "User ${username} not found in container"
    '')
  ];

  # Ensure Docker service is enabled
  virtualisation.docker.enable = true;
}