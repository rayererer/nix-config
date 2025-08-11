{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./desktops.nix
    ./cursors.nix
    ./uwsmEnvVarHandler.nix
    ./hyprland
    ./nvidiaIntegration.nix
    ./uwsmIntegration.nix
    ./app2unitIntegration.nix
    ./runners
  ];
}
