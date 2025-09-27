{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./standard.nix
    ./desktop.nix
    ./wsl.nix
  ];
}
