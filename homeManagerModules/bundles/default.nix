{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./cliPrograms
    ./desktops
    ./shells.nix
    ./threeD.nix
    ./bundlePackages
  ];
}
