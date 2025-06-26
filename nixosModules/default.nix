{ pkgs, lib, ... }: {

  imports = [
    ./home-manager.nix
    ./desktops/hyprland.nix
    ./services/ly.nix
    ./services/greetd-tuigreet.nix
  ];
}
