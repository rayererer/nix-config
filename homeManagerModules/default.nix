{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./cliPrograms
    ./desktops
    ./browsers
  ];
}
