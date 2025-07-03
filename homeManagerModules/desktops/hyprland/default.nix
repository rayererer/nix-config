{ config, pkgs, lib, ... }: 

let
  hyprCfg = config.my.desktops.hyprland;
in
{
  imports = [
    ./hyprland.nix
    ./core.nix
    ./locale.nix
    ./envVarAggregator.nix
    ./inlineEnvVarHandler.nix
    ./lyIntegration.nix
    ./uwsmIntegration.nix
  ];
}
