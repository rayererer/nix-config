{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./prompts.nix
    ./starship.nix
  ];
}
