{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./bundles
    ./games
    ./cliPrograms
    ./guiPrograms
    ./desktops
    ./browsers
    ./terminals
    ./shells
    ./threeD
    ./testing.nix
  ];
}
