{ pkgs, lib, ... }: {

  imports = [
    ./flakes.nix
    ./homeManager.nix
    ./locale.nix
    ./bootloaders
    ./networking.nix
    ./git.nix
    ./sound.nix
    ./desktops/hyprland.nix
    ./services/ly.nix
    ./services/greetd-tuigreet.nix
  ];
}
