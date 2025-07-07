# My NixOS config

## TODO:

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
