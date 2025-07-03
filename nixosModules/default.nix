{ pkgs, lib, ... }: {

  imports = [
    ./home-manager.nix
    ./locale.nix
    ./desktops/hyprland.nix
    ./services/ly.nix
    ./services/greetd-tuigreet.nix
  ];
}
