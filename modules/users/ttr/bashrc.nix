{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {

       # Nixos commands
      buildopt = "$HOME/nixos-config/modules/scripts/optiplex-flake-build.sh";
      buildopttrace = "cd $HOME/nixos-config && sudo nixos-rebuild switch --flake .#optiplex --show-trace";
      builyoga = "$HOME/nixos-config/modules/scripts/yoga-flake-build.sh";
      update = "$HOME/nixos-config/modules/scripts/flake-update.sh";
      rebuild = "sudo nixos-rebuild switch --flake /home/ttr/nixos-config";
      fpull = "$HOME/nixos-config/modules/scripts/flake-pull.sh";
      fpush = "$HOME/nixos-config/modules/scripts/flake-push.sh";
      cdmodules = "cd $HOME/nixos-config/modules";
      cdnix = "cd $HOME/nixos-config";
      config = "micro $HOME/nixos-config/configuration.nix";
      flake = "micro $HOME/nixos-config/flake.nix";
      flakes = "micro $HOME/nixos-config/flake.nix";
      hardware = "micro $HOME/nixos-config/hosts/optiplex/hardware-configuration.nix";
      home = "micro $HOME/nixos-config/modules/users/home-ttr.nix";
      usersnix = "micro $HOME/nixos-config/modules/users/users.nix";
      nixgarbage = "sudo nix-store --gc";

           # APP LAUNCH
      timeshift = "sudo timeshift-gtk";
      gparted = "sudo gparted";
      vmm = "virt-manager";
      gufw = "sudo gufw";
      ufw = "sudo gufw";
      
      # FILE LOCATIONS
      dow = "cd $HOME/Downloads";
      scr = "cd $HOME/.scripts";
  
      
      # Arch Docker Container
      a1 = "enter-arch-ttr";
      
      # GIT
      homepull = "bash $HOME/home-pull.sh";
      homepush = "bash $HOME/home-push.sh";

      # FFMPEG Scripts
      findmkv = "find /mnt/12tb/data/media -type f -name \"*.mkv\" -print0 | xargs -0 -I {} echo \"{}\" | sort && $HOME/.scripts/ffmpeg-scripts/mkv-to-mp4-with-prompt.sh";
      countmkv = "find /mnt/12tb/data/media -type f -name \"*.mkv\" | wc -l";
      mp4togif = "bash $HOME/.scripts/ffmpeg-scripts/mp4-to-gif.sh";
      mwp = "$HOME/.scripts/ffmpeg-scripts/N_m3u8DL-RE-with-prompts-MWP.sh";
      d720 = "$HOME/.scripts/ffmpeg-scripts/720p.sh";
      d1080 = "$HOME/.scripts/ffmpeg-scripts/1080p.sh";

        # SCRIPTS
      m1 = "bash $HOME/.scripts/cronjobs/master.sh";
      m2 = "tail -f $HOME/.scripts/logs/mastersh.log";
      m3 = "cd /tmp && rm script.lock";
      sb = "bash $HOME/.scripts/Small-Backups.sh";
      bb = "bash $HOME/.scripts/Big-Backups.sh";
      pi = "$HOME/.scripts/piper/piper-rofi-hardcoded.sh";
      tts = "$HOME/.scripts/piper/piper-rofi-hardcoded.sh";
      
      # QUICK TERMS
      ll = "ls -l";
      cl = "clear";
      CL = "clear";
      xx = "find . -type f \\( -name \"*.sh\" -o -name \"*.py\" -o -name \"*.perl\"       -o -name \"*.AppImage\" \\) -exec chmod +x {} +";
      cron = "crontab -e";
      cronjob20 = "sudo journalctl -u cron -n 20";
      cronjob40 = "sudo journalctl -u cron -n 40";
      cronjob50 = "sudo journalctl -u cron -n 50";
      back = "cd ../";
      back2 = "cd ../..";
      back3 = "cd ../../..";
      mega = "mega-sync";
      makes = "makepkg -si";
      uninstall = "flatpak uninstall";
      samba = "sudo micro /etc/samba/smb.conf";
      unfree = "export NIXPKGS_ALLOW_UNFREE=1";
      dup = "sudo docker-compose up -d";
      pup = "sudo podman-compose up -d";
      source = "source ~/.bashrc";
      SOURCE = "source ~/.bashrc";
      repo = "cd $HOME/ttr-app-repo/";
      trash = "trash-empty";
      w = "wget";
      microserve = "micro $HOME/.scripts/serve.sh";
      i3r = "i3-msg reload";
      sr = "swaymsg reload";
      apacherestart = "sudo systemctl restart apache2";
      
      # PRODUCTIVITY
      sym = "bash $HOME/.scripts/symlink.sh";
      replace = "bash $HOME/.scripts/replace_text.sh";
      theme = "$HOME/.scripts/TTR-Themer/rofi-themer.sh";
      blog = "bundle exec jekyll serve";
      bloginstall = "bundle install";
      blogbuild = "bundle exec jekyll build";
      msearch = "bash $HOME/.scripts/mastersearch.sh";
      
      # SSH Commands
      rsssh = "sudo systemctl restart sshd";
      sshconfig = "micro $HOME/.ssh/config";
      sshremote = "ssh ttr@remote";
      sshmountremote = "sshfs ttr@remote:/home/ttr/ ~/remote_server";
      sshunmountremote = "fusermount -u $HOME/remote_server";
      sshxremote = "ssh -X ttr@remote";
      catpub = "cat /home/ttr/.ssh/id_ed25519.pub";


    };
    initExtra = ''
      # Chain of sourcing:
      # .xprofile -> .profile -> .bashrc
      # source ~/.bashrc

      # If not running interactively, don't do anything
      case $- in
          *i*) ;;
            *) return;;
      esac

      # QT apps theming
      export QT_QPA_PLATFORMTHEME="qt5ct"

      # Share history between shells
      export PROMPT_COMMAND='history -a'

      # Starship prompt
      if command -v starship &> /dev/null; then
          eval "$(starship init bash)"
      fi

      # History control
      export HISTCONTROL=ignoredups:erasedups
      shopt -s histappend
      PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

      # Enable bash completion
      if ! shopt -oq posix; then
        if [ -f /usr/share/bash-completion/bash_completion ]; then
          . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
          . /etc/bash_completion
        fi
      fi

      # Install Ruby Gems to ~/gems
      export GEM_HOME="$HOME/gems"
      export PATH="$HOME/gems/bin:$PATH"

      # Nix LD for bin files
      export NIX_LD=$(cat $(nix eval --raw nixpkgs#stdenv.cc)/nix-support/dynamic-linker)
    '';
  };
}  