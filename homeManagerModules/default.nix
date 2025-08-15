{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./games
    ./cliPrograms
    ./guiPrograms
    ./desktops
    ./browsers
    ./terminals
    ./shells
    ./threeD
  ];
}
