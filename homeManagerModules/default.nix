{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./cliPrograms
    ./guiPrograms
    ./desktops
    ./browsers
    ./terminals
    ./shells
    ./threeD
  ];
}
