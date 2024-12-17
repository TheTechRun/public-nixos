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
        tv = {
          path = "/mnt/12tb/data/media/tv";
          "read only" = "no";
          comment = "CF TV Series";
        };
        movies = {
          path = "/mnt/12tb/data/media/movies";
          "read only" = "no";
          comment = "CF Movies";
        };
        jellyfin = {
          path = "/mnt/12tb/Jellyfin_Media";
          "read only" = "no";
          comment = "Jellyfin Videos";
        };
        roughdrafts = {
          path = "/12tb/Rough_Drafts";
          "read only" = "no";
          comment = "Rough Drafts";
        };
      };
    };
  };
}