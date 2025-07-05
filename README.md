# My NixOS config

## TODO:

 - [ ] Rename repo to nix-config.
 - [ ] Create a makeUser Helper.
 - [ ] Make defining hosts in flake super easy.

## Rebuilding the system

```sh
# Update
nix flake update

# Rebuild ('#myhost' is not needed if computer hostname
# is the same as flake hostname.)
sudo nixos-rebuild switch --flake .#myhost
```
