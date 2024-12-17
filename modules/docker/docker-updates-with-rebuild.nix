{ config, lib, pkgs, ... }:

{
  # Service that runs during system activation
  system.activationScripts.dockerContainerUpdates = {
    text = ''
      echo "Updating Docker containers..."
      
      # Pull latest images
      ${pkgs.docker}/bin/docker pull rogerfar/rdtclient:latest || true
      ${pkgs.docker}/bin/docker pull lscr.io/linuxserver/lidarr:latest || true
      ${pkgs.docker}/bin/docker pull lscr.io/linuxserver/jackett:latest || true
      ${pkgs.docker}/bin/docker pull ghcr.io/hotio/sonarr:latest || true
      ${pkgs.docker}/bin/docker pull lscr.io/linuxserver/syncthing:latest || true
      ${pkgs.docker}/bin/docker pull vaultwarden/server:latest || true
      ${pkgs.docker}/bin/docker pull portainer/portainer-ce:latest || true
      ${pkgs.docker}/bin/docker pull searxng/searxng:latest || true
      ${pkgs.docker}/bin/docker pull redis:alpine || true
      ${pkgs.docker}/bin/docker pull ferdium/ferdium-server:latest || true
      ${pkgs.docker}/bin/docker pull jellyfin/jellyfin:latest || true
      
      # Restart containers to use new images
      echo "Restarting containers with new images..."
      ${pkgs.docker}/bin/docker container restart rdt || true
      ${pkgs.docker}/bin/docker container restart lidarr || true
      ${pkgs.docker}/bin/docker container restart jackett || true
      ${pkgs.docker}/bin/docker container restart sonarr || true
      ${pkgs.docker}/bin/docker container restart syncthing || true
      ${pkgs.docker}/bin/docker container restart vaultwarden || true
      ${pkgs.docker}/bin/docker container restart portainer || true
      ${pkgs.docker}/bin/docker container restart searxng || true
      ${pkgs.docker}/bin/docker container restart redis || true
      ${pkgs.docker}/bin/docker container restart ferdium || true
      ${pkgs.docker}/bin/docker container restart jellyfin || true
    '';
    deps = [];
  };

  # Keep the daily timer as a backup
  systemd.timers."docker-containers-update" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };

  systemd.services."docker-containers-update" = {
    script = ''
      echo "Running scheduled Docker container updates..."
      
      # Pull latest images
      ${pkgs.docker}/bin/docker pull rogerfar/rdtclient:latest || true
      ${pkgs.docker}/bin/docker pull lscr.io/linuxserver/lidarr:latest || true
      ${pkgs.docker}/bin/docker pull lscr.io/linuxserver/jackett:latest || true
      ${pkgs.docker}/bin/docker pull ghcr.io/hotio/sonarr:latest || true
      ${pkgs.docker}/bin/docker pull lscr.io/linuxserver/syncthing:latest || true
      ${pkgs.docker}/bin/docker pull vaultwarden/server:latest || true
      ${pkgs.docker}/bin/docker pull portainer/portainer-ce:latest || true
      ${pkgs.docker}/bin/docker pull searxng/searxng:latest || true
      ${pkgs.docker}/bin/docker pull redis:alpine || true
      ${pkgs.docker}/bin/docker pull ferdium/ferdium-server:latest || true
      ${pkgs.docker}/bin/docker pull jellyfin/jellyfin:latest || true
      
      # Restart containers
      ${pkgs.docker}/bin/docker container restart rdt || true
      ${pkgs.docker}/bin/docker container restart lidarr || true
      ${pkgs.docker}/bin/docker container restart jackett || true
      ${pkgs.docker}/bin/docker container restart sonarr || true
      ${pkgs.docker}/bin/docker container restart syncthing || true
      ${pkgs.docker}/bin/docker container restart vaultwarden || true
      ${pkgs.docker}/bin/docker container restart portainer || true
      ${pkgs.docker}/bin/docker container restart searxng || true
      ${pkgs.docker}/bin/docker container restart redis || true
      ${pkgs.docker}/bin/docker container restart ferdium || true
      ${pkgs.docker}/bin/docker container restart jellyfin || true
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}