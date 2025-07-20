{
  config,
  pkgs,
  lib,
  ...
}: let
  hyprCfg = config.my.desktops.hyprland;
in {
  imports = [
    ./browser.nix
    ./terminal.nix
    ./hyprland.nix
    ./core.nix
    ./monitors.nix
    ./locale.nix
    ./envVarAggregator.nix
    ./inlineEnvVarHandler.nix
    ./lyIntegration.nix
    ./appLauncher.nix
    ./mouse.nix
    ./monitorNavigation.nix
    ./directions.nix
    ./windowNavigation.nix
  ];
}
