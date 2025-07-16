{
  pkgs,
  lib,
  config,
  ...
}: let
  hyprCfg = config.my.desktops.hyprland;
  cfg = hyprCfg.moduleCfg.mouse;
in {
  options.my.desktops.hyprland = {
    moduleCfg.mouse = {
      enable = lib.mkEnableOption "Enable the mouse module.";
    };

    turnOffMouseAccel = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Wheter to turn off mouse acceleration in Hyprland, true means that the
        profile is 'flat'. (default is true)
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        input = {
          accel_profile = lib.mkIf hyprCfg.turnOffMouseAccel "flat";
        };
      };
    };
  };
}
