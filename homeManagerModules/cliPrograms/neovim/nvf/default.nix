{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./nvf.nix
    ./vimOptions
    ./languages
    ./miscPlugins
  ];
}
