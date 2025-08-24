{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./neovim.nix
    ./nvimpager.nix
    ./nvf
  ];
}
