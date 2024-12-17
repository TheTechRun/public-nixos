{ config, lib, pkgs, ... }:

{
  # Timer to run updates daily at 3am
  systemd.timers."docker-containers-update" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 03:00:00";  # Run at 3am every day
      Persistent = true;  # Run on next boot if system was down at scheduled time
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
      
      # Wait a moment for pulls to complete
      sleep 30
      
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
      
      echo "Docker container updates completed"
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    # Add some safety measures
    startLimitIntervalSec = 300;  # 5 minutes
    startLimitBurst = 3;  # Allow 3 restarts within 5 minutes
  };
}