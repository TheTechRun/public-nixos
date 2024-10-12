{ config, lib, pkgs, ... }:

let
  username = "nixuser";  # Define the username here for easy changing
  userHome = config.users.users.${username}.home;
in
{
  services.cron = {
    enable = true;
    systemCronJobs = [
      
      # Flake Update every Monday at 12:30am
      "30 0 * * 1 ${username} ${userHome}/nixos-config/modules/scripts/flake-update.sh >> ${userHome}/.scripts/logs/flakes_updates.log 2>&1"

      # Somthing else here
      #"*/5 * * * * ${username} bash -l -c '${userHome}/.scripts/serve.sh'"

    ];
  };
}