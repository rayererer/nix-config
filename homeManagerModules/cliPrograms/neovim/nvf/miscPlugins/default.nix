{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./colorizer.nix
    ./telescope.nix
    ./nvimSurround.nix
  ];
}
