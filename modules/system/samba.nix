{ config, lib, pkgs, ... }: {
  services = {
    samba = {
      enable = true;
      package = pkgs.samba4Full;
      openFirewall = true;
      settings = {
        global = {
          "server smb encrypt" = "required";
          "server min protocol" = "SMB3_00";
        };
        videos = {
          path = "$HOME/Videos";
          "read only" = "no";
          comment = "Videos folder";
        };
        downloads = {
          path = "$HOME/Downloads";
          "read only" = "no";
          comment = "Downloads folder";
        };
      };
    };
  };
}