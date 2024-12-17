{ config, lib, pkgs, ... }:

{
  networking = {
    firewall = {
       enable = true; # change this to enable and disable
       allowedTCPPorts = [ 2234 8001 22 445 5000 631 9100 9089 53317 ];
       allowedUDPPorts = [ 2234 8001 22 445 5000 631 5353 9089 53317 ];
    };

    extraHosts = ''
      192.168.1.222 rustdesk.cloudlive.us
    '';
  };
}

### PORTS ###
# 44 - Baikal
# 631 9100 5353 - Cups (Printer)
# 53317 - Localsend
# 8001 - Pyload
# 5000 - Pyserve
# 445 - Samba
# 22 - Ssh
# 2234 - Soulseek

