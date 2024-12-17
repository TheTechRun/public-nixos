{ config, lib, pkgs, ... }:

let
  searxngDir = builtins.toString (./. + "/searxng");
in
{
  virtualisation.docker.enable = true;

  virtualisation.oci-containers.containers = {
    redis = {
      image = "redis:alpine";
      ports = [
        "6379:6379"
      ];
    };

    searxng = {
      image = "searxng/searxng:latest";
      environment = {
        SEARXNG_BASE_URL = "http://localhost:8092";
        REDIS_URL = "redis://localhost:6379/0";
      };
      volumes = [
        "${searxngDir}:/etc/searxng:rw"
      ];
      ports = [
        "8092:8080"
      ];
      dependsOn = [ "redis" ];
    };
  };

  networking.firewall.allowedTCPPorts = [ 8092 ];

  system.activationScripts = {
    createSearxngSettings = ''
      mkdir -p ${searxngDir}
      if [ ! -f ${searxngDir}/settings.yml ]; then
        cat > ${searxngDir}/settings.yml << EOL
use_default_settings: true
server:
  secret_key: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"  # change this!
  limiter: false  # can be disabled for a private instance
  image_proxy: true
ui:
  static_use_hash: true
redis:
  url: redis://localhost:6379/0
EOL
      fi
    '';

    searxngPermissions = ''
      mkdir -p ${searxngDir}
      chown -R 1000:1000 ${searxngDir}
      chmod -R 755 ${searxngDir}
    '';
  };
}