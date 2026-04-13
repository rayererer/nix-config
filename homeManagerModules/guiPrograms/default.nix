{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./obsidian.nix
    ./vesktop.nix
    ./aseprite.nix
  ];
}
