{ config, lib, pkgs, ... }:

let
  username = "ttr";  # Define the username here for easy changing
  userHome = config.users.users.${username}.home;
in
{
  services.cron = {
    enable = true;
    systemCronJobs = [
      # Master Script  1am, 6am, 1pm, 6pm
      "0 1,6,13,18 * * * ${username} ${userHome}/.scripts/cronjobs/master.sh"

      # Flake Update every Monday at 12:30am
      "30 0 * * 1 ${username} ${userHome}/nixos-config/modules/scripts/flake-update.sh >> ${userHome}/.scripts/logs/flakes_updates.log 2>&1"

      # Serve Port TV
      "*/5 * * * * ${username} bash -l -c '${userHome}/.scripts/serve.sh'"

      # Clear Log files every Sunday and Thursday at 3 AM:
      "0 3 * * 0,4 ${username} ${userHome}/.scripts/logs/clear-all-logs.sh"

      #Testing
      # "* * * * * ${username} ${pkgs.bashInteractive}/bin/bash /mnt/12tb/TestStuff/cron/test.sh" # For Testing
    ];
  };
}