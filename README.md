
# NixOS:
Just a public version of my NixOS configs with some slight alterations for security.

# Directory structure:
```
/home/ttr/nixos-config
├── first-setup.sh
├── flake.lock
├── flake.nix
├── hosts
│   ├── optiplex
│   │   ├── configuration.nix
│   │   └── hardware-configuration.nix
│   ├── server
│   │   └── configuration.nix
│   └── yoga
│       ├── configuration.nix
│       └── hardware-configuration.nix
├── modules
│   ├── builds
│   │   ├── expert.nix
│   │   ├── n-m3u8dl-re.nix
│   │   ├── patches
│   │   │   └── lmms-rpmalloc.patch
│   │   ├── xdman7.nix
│   │   └── xdman8.nix
│   ├── desktop
│   │   ├── de
│   │   │   ├── wayland
│   │   │   │   └── gnome.nix
│   │   │   └── x11
│   │   │       └── cinnamon.nix
│   │   ├── display-manager
│   │   │   └── light-dm
│   │   │       └── lightdm.nix
│   │   ├── slick-greeter
│   │   │   ├── 1.jpeg
│   │   │   ├── 1.jpg
│   │   │   └── 1.png
│   │   └── wm
│   │       ├── wayland
│   │       │   ├── hyprland.nix
│   │       │   └── sway.nix
│   │       └── x11
│   │           └── i3.nix
│   ├── displaylink
│   │   ├── displaylink-600.zip
│   │   └── displaylink.nix
│   ├── docker
│   │   ├── arch-ttr.nix
│   │   ├── docker-updates.nix
│   │   ├── docker-updates-with-rebuild.nix
│   │   ├── ferdium.nix
│   │   ├── jackett.nix
│   │   ├── jellyfin.nix
│   │   ├── lidarr.nix
│   │   ├── navidrome.nix
│   │   ├── Other
│   │   │   ├── arch-root.nix
│   │   │   └── arch-ttr-terminal-only.nix
│   │   ├── portainer.nix
│   │   ├── rdt.nix
│   │   ├── searxng
│   │   │   ├── settings.yml
│   │   │   └── uwsgi.ini
│   │   ├── searxng.nix
│   │   ├── sonarr.nix
│   │   ├── syncthing.nix
│   │   ├── template.nix
│   │   └── vaultwarden.nix
│   ├── flakes
│   │   ├── python
│   │   │   ├── flake.lock
│   │   │   ├── flake.nix
│   │   │   └── flake.nix.bak
│   │   └── template
│   │       └── flake.nix
│   ├── notes.md
│   ├── scripts
│   │   ├── flake-pull.sh
│   │   ├── flake-push.sh
│   │   ├── old
│   │   │   ├── flake-build(old).sh
│   │   │   └── flake-update(old).sh
│   │   ├── optiplex-flake-build.sh
│   │   ├── optiplex-flake-update.sh
│   │   ├── setup-casiotone.sh
│   │   ├── yoga-flake-build.sh
│   │   └── yoga-flake-update.sh
│   ├── system
│   │   ├── 16gb-swap.nix
│   │   ├── 4gb-swap.nix
│   │   ├── 8gb-swap.nix
│   │   ├── audio.nix
│   │   ├── canon.nix
│   │   ├── configuration(old).nix
│   │   ├── cron.nix
│   │   ├── cups-canon-zebra.nix
│   │   ├── cups.nix
│   │   ├── firewall.nix
│   │   ├── samba.nix
│   │   ├── services.nix
│   │   ├── ssh.nix
│   │   ├── template.nix
│   │   ├── virtualization.nix
│   │   └── xmodmap.nix
│   ├── timers
│   │   └── masterscript.nix
│   └── users
│       ├── family
│       │   └── home-family.nix
│       ├── muffery
│       │   └── home-muffery.nix
│       ├── ttr
│       │   ├── bashrc.nix
│       │   └── home-ttr.nix
│       └── users.nix
└── README.md

33 directories, 80 files

```
