{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./desktops.nix
    ./uwsmEnvVarHandler.nix
    ./hyprland
  ];
}
