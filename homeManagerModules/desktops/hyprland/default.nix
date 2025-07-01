{ config, pkgs, lib, ... }: 

let
  hyprCfg = config.my.desktops.hyprland;
in
{
  imports = [
    ./hyprland.nix
    ./core.nix
    ./envVarAggregator.nix
    ./inlineEnvVarHandler.nix
    ./uwsmIntegration.nix
  ];
}
