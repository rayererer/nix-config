{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./flakes.nix
    ./homeManager.nix
    ./locale.nix
    ./shells.nix
    ./wsl.nix
    ./graphics
    ./bootloaders
    ./services
    ./desktops
    ./fonts
    ./stylix
    ./gaming
  ];
}
