{ pkgs, lib, ... }: {

  imports = [
    ./home-manager.nix
    ./desktops/hyprland.nix
  ];
}
