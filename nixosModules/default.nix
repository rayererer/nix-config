{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./flakes.nix
    ./homeManager.nix
    ./locale.nix
    ./graphics
    ./bootloaders
    ./services
    ./desktops
    ./fonts
    ./stylix
  ];
}
