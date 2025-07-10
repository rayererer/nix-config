{
  pkgs,
  lib,
  config,
  ...
}: let
  hyprCfg = config.my.desktops.hyprland;
  cfg = hyprCfg.moduleCfg.templateModuleNameHere;
in {
  options.my.desktops.hyprland = {
    moduleCfg.templateModuleNameHere = {
      enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
      };
    };
  };
}
