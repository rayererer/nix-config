{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./flakes.nix
    ./homeManager.nix
    ./locale.nix
    ./bootloaders
    ./services
    ./desktops
  ];
}
