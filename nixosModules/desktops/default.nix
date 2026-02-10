{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./niri.nix
  ];
}
