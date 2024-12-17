{ config, lib, pkgs, ... }:

{
  virtualisation.oci-containers.containers = {
    ferdium = {
      image = "ferdium/ferdium-server:latest";
      environment = {
        NODE_ENV = "production";
        APP_URL = "https://ferdium.dummy.com/";
        DB_CONNECTION = "sqlite";
        DB_HOST = "127.0.0.1";
        DB_PORT = "3306";
        DB_USER = "root";
        DB_PASSWORD = "XXXXXXXX";
        DB_DATABASE = "ferdium";
        DB_SSL = "false";
        MAIL_CONNECTION = "smtp";
        SMTP_HOST = "127.0.0.1";
        SMTP_PORT = "2525";
        MAIL_SSL = "false";
        MAIL_USERNAME = "username";
        MAIL_PASSWORD = "password";
        MAIL_SENDER = "noreply@dummy.com";
        IS_CREATION_ENABLED = "true";
        IS_DASHBOARD_ENABLED = "true";
        IS_REGISTRATION_ENABLED = "true";
        CONNECT_WITH_FRANZ = "false";
        DATA_DIR = "/data";
        JWT_USE_PEM = "true";
        PUID = "1000";
        PGID = "1000";
        TZ = "America/New_York";
        AUTO_UPDATE = "true";
      };
      volumes = [
        "/mnt/12tb/docker/ferdium/data/:/data"
        "/mnt/12tb/docker/ferdium/data/tmp:/app/build/tmp"
        "/mnt/12tb/docker/ferdium/data//recipes:/app/build/recipes"
      ];
      ports = [
        "3333:3333"
      ];
      autoStart = true;
      extraOptions = [
        "--network=host"
      ];
    };
  };

  # Enable Docker
  virtualisation.docker.enable = true;

  # Open firewall port
  networking.firewall.allowedTCPPorts = [ 3333 ];
}