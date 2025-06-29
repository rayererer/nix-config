{ pkgs, lib, ... }:

let
  modCfg = config.desktops.hyprland.moduleCfg;
in
{

  imports = [
    ./core.nix
    ./uwsmIntegration.nix
  ];

  modCfg.core.enable = lib.mkDefault true;
}
