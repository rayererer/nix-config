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
    ./graphics
    ./bootloaders
    ./services
    ./desktops
    ./fonts
    ./stylix
  ];
}
