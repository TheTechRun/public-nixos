# TO LAUNCH CONTAINER: enter-arch-<username>>
# TO EXPORT AND GET LAUNCH COMMAND: export-app-<username> <app name>

{ config, lib, pkgs, ... }:

let
  username = "ttr";
  containerName = "arch-${username}";
  userHome = "/home/${username}";
  archContainer = config.virtualisation.oci-containers.containers.${containerName};
  userDesktopFilePath = "${userHome}/.local/share/applications";
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
        "/tmp/.X11-unix:/tmp/.X11-unix"
        "/run/user/1000:/run/user/1000"
      ];
      environment = {
        DISPLAY = ":0";
        WAYLAND_DISPLAY = "wayland-0";
        XDG_RUNTIME_DIR = "/run/user/1000";
      };
      extraOptions = [
        "--network=host"
        "--security-opt=label=disable"
        "--security-opt=seccomp=unconfined"
        "--device=/dev/fuse"
        "--cap-add=CAP_SYS_ADMIN"
        "--cap-add=CAP_NET_ADMIN"
        "--ipc=host"
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
        ${pkgs.docker}/bin/docker create --name ${containerName} \
          ${toString archContainer.extraOptions} \
          ${toString (map (v: "-v ${v}") archContainer.volumes)} \
          ${toString (lib.mapAttrsToList (k: v: "-e ${k}=${v}") archContainer.environment)} \
          ${archContainer.image} tail -f /dev/null
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
        # Install necessary packages for GUI applications
        pacman -Syu --noconfirm xorg-xhost
      "
      
      echo "Entering ${containerName} container..."
      xhost +local:  # Allow local connections to X server
      exec ${pkgs.docker}/bin/docker exec -it \
        -u ${username} \
        -e HOME=${userHome} \
        -e DISPLAY=$DISPLAY \
        -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
        -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
        -w ${userHome} \
        ${containerName} /bin/bash
    '')
    (writeScriptBin "export-app-${username}" ''
      #!${pkgs.stdenv.shell}
      set -e
      if [ "$1" = "" ]; then
        echo "Usage: export-app-${username} <application>"
        exit 1
      fi
      APP="$1"
      DESKTOP_FILE="${userDesktopFilePath}/$APP-${containerName}.desktop"
      EXEC_COMMAND="${pkgs.docker}/bin/docker exec -it --user ${username} ${containerName} $APP"
      
      ${pkgs.docker}/bin/docker exec ${containerName} bash -c "
        if ! command -v $APP &> /dev/null; then
          echo \"$APP is not installed in the container. Installing...\"
          sudo pacman -Syu --noconfirm $APP
        fi
      "
      
      mkdir -p "${userDesktopFilePath}"
      cat > "$DESKTOP_FILE" << EOF
[Desktop Entry]
Name=$APP (${containerName})
Exec=$EXEC_COMMAND
Icon=application-x-executable
Type=Application
Categories=Distrobox;
EOF
      
      chmod +x "$DESKTOP_FILE"
      
      echo "Application $APP has been exported from ${containerName}."
      echo "It should now appear in your application launcher."
      echo "To run it from the command line, use:"
      echo "$EXEC_COMMAND"
      echo "If the application doesn't appear in your launcher, you may need to log out and log back in."
    '')
    (writeScriptBin "debug-${containerName}" ''
      #!${pkgs.stdenv.shell}
      echo "${containerName} configuration:"
      echo "Image: ${archContainer.image}"
      echo "AutoStart: ${toString archContainer.autoStart}"
      echo "Volumes: ${toString archContainer.volumes}"
      echo "Environment: ${toString (lib.mapAttrsToList (k: v: "${k}=${v}") archContainer.environment)}"
      echo "Extra options: ${toString archContainer.extraOptions}"
      echo "Container Status:"
      ${pkgs.docker}/bin/docker inspect ${containerName}
      echo "User in container:"
      ${pkgs.docker}/bin/docker exec ${containerName} id ${username} || echo "User ${username} not found in container"
    '')
  ];

  # Ensure Docker service is enabled
  virtualisation.docker.enable = true;

  # Append to the existing XDG_DATA_DIRS environment variable
  environment.extraInit = ''
    export XDG_DATA_DIRS="$HOME/.local/share:$XDG_DATA_DIRS"
  '';
}