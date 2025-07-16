{
  pkgs,
  lib,
  config,
  ...
}: let
  hyprCfg = config.my.desktops.hyprland;
  cfg = hyprCfg.moduleCfg.monitorNavigation;
in {
  options.my.desktops.hyprland = {
    moduleCfg.monitorNavigation = {
      enable = lib.mkEnableOption "Enable the monitor navigation module.";
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        bind = [
          "$mainMod, less, focusmonitor, -1"
          "$mainMod $moveMod, less, movewindow, mon:-1"
        ];
      };
    };
  };
}
