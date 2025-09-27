{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./basics.nix
    ./wsl.nix
    ./basicDesktop.nix
    ./generalDesktop.nix
    ./cliPrograms.nix
  ];
}
