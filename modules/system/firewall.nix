{ config, lib, pkgs, ... }:

{
  networking = {
    firewall = {
       enable = true; # change this to enable and disable
       allowedTCPPorts = [ 22 445 8384 5000 631 9100 9089 8096 8989 9117 6500 53317 ];
       allowedUDPPorts = [ 22 445 8384 5000 631 5353 9089 8096 8989 9117 6500 53317 ];
    };

    extraHosts = ''
      192.168.1.222 something.something.com
    '';
  };
}

### PORTS ###
# 5000 - pyserve
# 631 9100 5353 - Cups (Printer)
# 53317 - Localsend
# 8989 - Sonarr
# 9117 - Jackett
# 44 - Baikal
# 8096 - Jellyfin
# 6500 - RDT
# 8384 - Syncthing
# 445 - Samba
# 22 -ssh