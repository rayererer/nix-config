{ pkgs, lib, ... }: {

  imports = [
    ./flakes.nix
    ./homeManager.nix
    ./locale.nix
    ./bootloaders
    ./networking.nix
    ./sound.nix
    ./desktops
}
