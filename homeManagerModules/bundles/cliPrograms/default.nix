{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./git.nix
    ./miscTools.nix
    ./development.nix
    ./neovim
  ];
}
