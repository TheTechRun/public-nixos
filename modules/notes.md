# Update pinned programs
To update the pinned packages, you would just need to update two things in that flake.nix pinned overlay block:

1. The commit hash in the URL
2. The sha256 hash

```nix
pinnedPkgs = import (fetchTarball {
    url = "https://github.com/nixos/nixpkgs/archive/a73246e2eef4c6ed172979932bc80e1404ba2d56.tar.gz";  # <- Update this hash
    sha256 = "sha256-463SNPWmz46iLzJKRzO3Q2b0Aurff3U1n0nYItxq7jU=";  # <- And this hash
}) { system = final.system; };
```

You can get these values from a newer `flake.lock` after doing a `flake update`. Look for the `nixpkgs` entry in your lock file, which will have:
- `rev`: use this in the URL
- `narHash`: use this as the sha256

The rest of your pinned packages will automatically use the new versions from that revision without needing any other changes.

# Docker Updates:
`docker-updates.nix` uses systemD timer and will run docker updates every day at 3am. 
`docker-updates-with-rebuild.nix` does the same but will also update docker containers with every rebuild. 

# New Flakes in environment setups 
Flakes will not work until they are added to git. For dev environments you may have to manually add it. 
Example for python:

```
# Add to git (Only need to run this if build script is not woking)
cd ~/nixos-config
git add modules/flakes/python/
git commit -m "Add Python development flake"
git push origin master

# Force create lock file
cd ~/nixos-config/modules/flakes/python
nix flake lock --recreate-lock-file
```