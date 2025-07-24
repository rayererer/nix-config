{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./shells.nix
    ./fish.nix
  ];
}
