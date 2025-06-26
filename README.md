# My NixOS config

## Rebuilding the system

```sh
# Update
nix flake update

# Rebuild
sudo nixos-rebuild switch --flake .#myhost
```
