# users.nix
{ config, pkgs, ... }:

{
  users.users = {
    nixuser = {
      isNormalUser = true;
      extraGroups = [ "nixuser" "wheel" "cups" "networkmanager" "scanner" "lp" "libvirtd" "docker" ];
      uid = 1000;  # It's good practice to explicitly set the UID
    };
    # Add Other Users
    #nixusertwo = {
     # isNormalUser = true;
     # extraGroups = [ "nixusertwo" "cups" "networkmanager" ];
     # uid = 1001;  
    #};
    
  };

  users.groups = {
    nixuser = {
      gid = 1000;
    };
    # You can define other groups here as needed
    #nixusertwo = {
     #  gid = 1001;
    #};
  };
}

# Manuall set userid and groupid
#sudo usermod -u 1000 nixuser
#sudo groupmod -g 1001 nixusertwo
#sudo usermod -u 1000 nixuser
#sudo groupmod -g 1001 nixusertwo