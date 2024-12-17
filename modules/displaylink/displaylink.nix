{ config, pkgs, lib, ... }:

{
  nixpkgs.config.displaylink = {
    enable = true;
    # Use a fixed path relative to the repository
    driverFile = ./displaylink-600.zip;
    # Provide a fixed hash that you'll get after downloading the file
    sha256 = "1ixrklwk67w25cy77n7l0pq6j9i4bp4lkdr30kp1jsmyz8daaypw"; # Add the hash here after downloading and running nix-prefetch-url file://$(pwd)/modules/displaylink/displaylink-600.zip
  };

  # Add DisplayLink to video drivers
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];
}