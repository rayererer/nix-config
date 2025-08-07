{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./colorizer.nix
    ./telescope.nix
  ];
}
