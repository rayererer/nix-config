{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./ghostty.nix
    ./themes.nix
  ];
}
