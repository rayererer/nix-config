{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./zen.nix
    ./syncing.nix
  ];
}
