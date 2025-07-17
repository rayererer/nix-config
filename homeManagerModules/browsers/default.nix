{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./browsers.nix
    ./zen.nix
  ];
}
