{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./terminals.nix
    ./ghostty
  ];
}
