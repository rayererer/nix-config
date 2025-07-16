{
  config,
  pkgs,
  lib,
  ...
}: let
  hyprCfg = config.my.desktops.hyprland;
in {
  imports = [
    ./hyprland.nix
    ./core.nix
    ./monitors.nix
    ./locale.nix
    ./envVarAggregator.nix
    ./inlineEnvVarHandler.nix
    ./lyIntegration.nix
    ./appLauncher.nix
  ];
}
