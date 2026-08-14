{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./minecraft.nix
    ./heroic.nix
  ];
}
