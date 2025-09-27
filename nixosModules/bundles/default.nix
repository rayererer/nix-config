{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./bundlePackages
    ./basics.nix
    ./standard.nix
    ./bootloaders.nix
    ./desktops.nix
    ./nvidia.nix
    ./wsl.nix
  ];
}
