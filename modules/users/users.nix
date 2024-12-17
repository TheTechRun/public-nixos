# users.nix
{ config, pkgs, ... }:

{
  users.users = {
    ttr = {
      isNormalUser = true;
      extraGroups = [ "plugdev" "wheel" "cups" "networkmanager" "scanner" "lp" "libvirtd" "libvirt" "docker" "ttr" ];
      uid = 1000;  # It's good practice to explicitly set the UID
    };
    muffery = {
      isNormalUser = true;
      extraGroups = [ "cups" "networkmanager" "muffery" ];
      uid = 5000;  
    };
    family = {
      isNormalUser = true;
      extraGroups = [ "cups" "networkmanager" "family" ];
      uid = 5001; 
    };
  };

  users.groups = {
    ttr = {
      gid = 1000;
    };
    # You can define other groups here as needed
    muffery = {
       gid = 5000;
    };
     family = {
       gid = 5001;
    };
     
  };
}

# Set passwords:
#sudo passwd <username>


# Manual set userid and groupid
#sudo usermod -u 5000 family
#sudo groupmod -g 5000 family
#sudo usermod -u 5001 muffery
#sudo groupmod -g 5001 muffery