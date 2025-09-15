{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./bundles.nix
    ./cliPrograms
    ./desktops
    ./shells.nix
    ./threeD.nix
    ./bundlePackages
  ];
}
