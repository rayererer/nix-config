{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./prompts
    ./shells.nix
    ./fish.nix
  ];
}
