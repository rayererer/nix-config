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

- [ ] Change from the weird module config structure of some stuff (neovim and hyprland e.g.), might be more useful for hyprland than neovim though.
- [x] Somehow use hyprshade or other blue-light filter app, could maybe just make script/picker for hyprshade, might not even need
to download it outside of using it inside a nix shell.
- [ ] Fix so the secondary colors actually work in ghostty (they seem not to).
- [ ] Fix more portable configuring of zen browser, including saving vimium config and zen mods. (On my way in feature/zen-syncing)
- [ ] Make discords directory and make it have multiple and include a default (basically like browser and terminal)
since I might want to use other discords than vesktop.
- [ ] Handle options that need both os and home manager stuff better, (just read the home manager option).
(Fixing may only be needed in desktops module.)
- [x] Maybe turn off auto enable for stylix, or do it some better way (don't need qt utils
- [ ] Make starship prompt from the pure preset and maybe adapt a bit, including transience.
pure preset convertion is done, transience and adaption remaining but idk if I will do that.
- [x] Maybe turn off auto enable for stylix, or do it some better way (don't need qt utils
if not using qt).
- [x] Add color and other stylistic stuff into config in some way, maybe use stylix.
- [x] Fix monitor config for Hyprland (issue described in hyprland.nix).
- [ ] Maybe fix helper for lists with defaults (IDK)
- [x] Fix so that if one runner installed it automatically becomes default. (IDK)
- [x] Add wayland integration for desktops and add the two env vars
 referenced in the hyprland wiki there.
- [ ] Look into impermanence and nuke on reboot.
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
- [x] Fix font stuff.
- [x] Add author info to git, and perhaps centralize it.
- [x] Rename repo to nix-config.
- [x] Create a makeUser Helper. # Unclear if a good idea. (Probably won't)
- [x] Make defining hosts in flake super easy.

## Rebuilding the system

```sh
# Update
nix flake update

# Rebuild ('#myhost' is not needed if computer hostname
# is the same as flake hostname.)
sudo nixos-rebuild switch --flake .#myhost
```
