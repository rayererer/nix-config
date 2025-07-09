# My NixOS config

## TODO:

 - [ ] Fix uwsm integration for hyprland to respect executing with rules. Also fix exec-once, and make the file logic more readable and less repetitive.
 Also maybe completely rewrite and try to give permission to change normal hyprland config file.
 - [ ] Clean up UWSM stuff, perhaps make module in desktops/
 - [x] Fix so that app2unit is optionally used instead of 'uwsm app --'
 - [x] Move stuff into services, and all around put modules into directories.
 - [x] Move ly out of services. # NVM, it is definitely a service.
 - [ ] Expand ssh module.
 - [ ] Fix font stuff.
 - [ ] Add author info to git, and perhaps centralize it.
 - [ ] Rename repo to nix-config.
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
