{ config, pkgs, lib, ... }: {

  imports = [
    ./hyprland.nix
    ./core.nix
    ./uwsmIntegration.nix
  ];

  config.my.desktops.hyprland.moduleCfg = {
    core.enable = lib.mkDefault true;
  };
}
