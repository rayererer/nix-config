{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./stylix.nix
    ./colorSchemes
  ];
}
