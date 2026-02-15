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
    ./widgets
    ./browsers
    ./terminals
    ./shells
    ./threeD
    ./testing.nix
  ];
}
