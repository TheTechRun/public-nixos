{ config, pkgs, lib, ... }:

let
  # Use the full path to the directory containing the displaylink.nix file
  driverFile = "$HOME/nixos-config/modules/displaylink/displaylink-600.zip";

  updateDisplayLinkHash = pkgs.writeShellScript "update-displaylink-hash" ''
    set -e
    new_hash=$(${pkgs.nix}/bin/nix-prefetch-url file://${driverFile})
    echo "$new_hash"
  '';

  newHash = builtins.readFile (pkgs.runCommand "new-displaylink-hash" {} ''
    ${updateDisplayLinkHash} > $out
  '');

in
{
  nixpkgs.config.displaylink = {
    enable = true;
    driverFile = driverFile;
    sha256 = "${newHash}";
  };

  # Add any other DisplayLink-related configuration here
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

  # If you have any other DisplayLink-specific settings, add them here
  # For example:
  # boot.kernelModules = [ "evdi" ];
}