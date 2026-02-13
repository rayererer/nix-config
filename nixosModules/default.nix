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
    ./sopsNix.nix
    ./dualBoot.nix
    ./systemMaintenance
    ./graphics
    ./bootloaders
    ./services
    ./desktops
    ./fonts
    ./stylix
    ./gaming
    ./users
    ./bundles
  ];
}
