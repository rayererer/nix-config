{ config, pkgs, lib, ... }: {

  imports = [
    ./core.nix
    ./uwsmIntegration.nix
  ];

  config.my.desktops.hyprland.moduleCfg = {
    core.enable = lib.mkDefault true;
  };
}
