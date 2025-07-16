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
    ./nvidiaIntegration.nix
    ./uwsmIntegration.nix
    ./app2unitIntegration.nix
    ./runners
  ];
}
