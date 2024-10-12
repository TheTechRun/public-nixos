{ config, pkgs, ... }:

{

  imports = [
  ./bashrc.nix
     #...other imports
];

  home.username = "nixusertwo";
  home.homeDirectory = "/home/nixusertwo";


  # Set environment variables
  home.sessionVariables = {
    EDITOR = "micro";
    PATH = "$PATH:/usr/bin:$HOME/.local/bin";
  };

  # Set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 22;
   # "Xft.dpi" = 172;
  };

  # Packages for the nixusertwo user
  home.packages = with pkgs; [ 
    
    brave
    #more here
    
    
  ];

  # Example of how to configure a program (uncomment and modify as needed)
  # programs.git = {
  #   enable = true;
  #   userName = "Family User";
  #   userEmail = "nixusertwo@example.com";
  # };

  # This value determines the Home Manager release that your
  # configuration is compatible with. It's recommended to keep this up to date.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
