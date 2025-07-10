{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./neovim.nix
    ./nvf
  ];
}
