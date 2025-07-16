{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./runners.nix
    ./fuzzel
  ];
}
