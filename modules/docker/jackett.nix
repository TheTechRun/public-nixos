{ config, lib, pkgs, ... }:

{
  virtualisation.oci-containers.containers = {
    jackett = {
      image = "lscr.io/linuxserver/jackett:latest";
      environment = {
        PUID = "1000";
        PGID = "1000";
        TZ = "America/New_York";
        AUTO_UPDATE = "true";
        RUN_OPTS = "";
      };
      volumes = [
        "/mnt/12tb/docker/jackett/data:/config"
        "/mnt/12tb/docker/jackett/blackhole:/downloads"
      ];
      ports = [
        "9117:9117"
      ];
      autoStart = true;
      extraOptions = [
       # "--sysctl=net.ipv6.conf.all.disable_ipv6=1" #this will block connections!
      ];
    };
  };

  # Enable Docker
  virtualisation.docker.enable = true;

  # Open firewall port
  networking.firewall.allowedTCPPorts = [ 9117 ];
}