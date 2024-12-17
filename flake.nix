{
  description = "NixOS configuration with system-wide packages and allowUnfree";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  let
    system = "x86_64-linux";
    
    # Define overlay for custom packages
    overlay = final: prev: {
      n-m3u8dl-re = final.callPackage ./modules/builds/n-m3u8dl-re.nix {};
      xdman7 = final.callPackage ./modules/builds/xdman7.nix {};
      xdman8 = final.callPackage ./modules/builds/xdman8.nix {};

    # Create a pinned nixpkgs instance (get the narhash and rev from flake.lock )
  pinnedPkgs = import (fetchTarball {
    url = "https://github.com/nixos/nixpkgs/archive/a73246e2eef4c6ed172979932bc80e1404ba2d56.tar.gz";
    sha256 = "sha256-463SNPWmz46iLzJKRzO3Q2b0Aurff3U1n0nYItxq7jU=";
  }) { system = final.system; };

  # Pin multiple packages to the same nixpkgs revision
  normcap = final.pinnedPkgs.normcap;
  vscodium = final.pinnedPkgs.vscodium;
  localsend = final.pinnedPkgs.localsend;  
    };
    
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [ overlay ];  # Add our custom overlay
    };
    
    lib = nixpkgs.lib;
    
    # Built from Source
    builtPackages = {
      n-m3u8dl-re = pkgs.callPackage ./modules/builds/n-m3u8dl-re.nix {
       inherit (pkgs) 
         lib 
         stdenv 
         fetchurl
         makeWrapper
         icu
         openssl
         zlib;  
      };
    };
    
    # Common system packages
    commonPackages = with pkgs; [
      alacritty chromium curl xed-editor rofi dmenu micro
      xfce.thunar xfce.thunar-archive-plugin
      bash folder-color-switcher cups distrobox gpick
      haskellPackages.greenclip home-manager networkmanagerapplet polybar
      pyload-ng trash-cli unzip vlc wget xarchiver
      xorg.xmodmap xorg.setxkbmap
      pulseaudio pamixer pavucontrol
      libnotify libimobiledevice ifuse
      coreutils ffmpeg_7 findutils gawk moreutils perl
      rclone rename rsync jq neovim
      gcc gnumake xorg.libxcb
      xorg.xinit jdk maven yq solaar nomacs yt-dlp
    ];

    # Optiplex-specific packages
    optiplexPackages = with pkgs; [
      # Add packages specific to optiplex here
      # For example:
      # virtualbox
      # docker-compose
    ];

    # Yoga-specific packages
    yogaPackages = with pkgs; [
      libinput
      libinput-gestures
      # Add more yoga-specific packages here
      # For example:
      # powertop
      # tlp
    ];

  in {
    nixosConfigurations = {
      optiplex = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs lib pkgs; };  # Added pkgs to specialArgs
        modules = [
          # Make overlay available system-wide
          { nixpkgs.overlays = [ overlay ]; }
          ./hosts/optiplex/configuration.nix
          ./modules/users/users.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit builtPackages; };  # Pass builtPackages to all home-manager modules
              users = {
                ttr = { ... }: {
                  imports = [ ./modules/users/ttr/home-ttr.nix ];
                };
                muffery = { ... }: {
                  imports = [ ./modules/users/muffery/home-muffery.nix ];
                };
                family = { ... }: {
                  imports = [ ./modules/users/family/home-family.nix ];
                };
              };
            };
            nixpkgs.config.allowUnfree = true;
            environment.systemPackages = commonPackages ++ optiplexPackages;
          }
        ];
      };

      yoga = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs lib pkgs; };  # Added pkgs to specialArgs
        modules = [
          # Make overlay available system-wide
          { nixpkgs.overlays = [ overlay ]; }
          ./hosts/yoga/configuration.nix
          ./hosts/yoga/hardware-configuration.nix
          ./modules/desktop/wm/x11/i3.nix
          ./modules/users/users.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit builtPackages; };  # Pass builtPackages to all home-manager modules
              users = {
                ttr = { ... }: {
                  imports = [ ./modules/users/ttr/home-ttr.nix ];
                };
                muffery = { ... }: {
                  imports = [ ./modules/users/muffery/home-muffery.nix ];
                };
              };
            };
            nixpkgs.config.allowUnfree = true;
            environment.systemPackages = commonPackages ++ yogaPackages;
          }
        ];
      };
    };
  };
}
