# My Nix config for both NixOS and Home Manager (And basically everything)

## Overview

This is (as stated in the title) my nix config for basically everything and is currently very much a work in progress, although
I only have this OS installed on my desktop. The main concept is to modularize everything and only have to enable simple toggles
/ set simple settings in the host specific configs. The goal is also for most stuff to be explicit, hence why I don't
automatically enable stuff like git even though it is pretty much universal and I can't really imagine not wanting to have it on
any host.

For now you will have to look at the modules and files themselves (and the TODO list I suppose) to figure out what options are
available and what has been done. Hopefully the file structure should be relatively self-explanatory though. 

Feel free to open an issue if you are curious about anything.

## TODO:

 - [ ] Maybe fix helper for lists with defaults
 - [ ] Fix so that if one runner installed it automatically becomes default.
 - [x] Add wayland integration for desktops and add the two env vars
 referenced in the hyprland wiki there.
 - [ ] Look into impermeance and nuke on reboot.
 - [ ] Fix secrets handling
 - [ ] Look into services/scopes and stuff for uwsm / app2unit.
 - [x] Fix uwsm integration for hyprland to respect executing with rules. Also fix exec-once, and make the file logic more readable and less repetitive.
 Also maybe completely rewrite and try to give permission to change normal hyprland config file.
 (Probably just make a launch command and live with adding it manually to apps.)
 - [x] Clean up UWSM stuff, perhaps make module in desktops/
 - [x] Fix so that app2unit is optionally used instead of 'uwsm app --'
 - [x] Move stuff into services, and all around put modules into directories.
 - [x] Move ly out of services. # NVM, it is definitely a service.
 - [ ] Expand ssh module.
 - [ ] Fix font stuff.
 - [x] Add author info to git, and perhaps centralize it.
 - [x] Rename repo to nix-config.
 - [ ] Create a makeUser Helper. # Unclear if a good idea.
 - [x] Make defining hosts in flake super easy.

## Rebuilding the system

```sh
# Update
nix flake update

# Rebuild ('#myhost' is not needed if computer hostname
# is the same as flake hostname.)
sudo nixos-rebuild switch --flake .#myhost
```
