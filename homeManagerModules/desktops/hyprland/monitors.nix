{
  pkgs,
  lib,
  config,
  ...
}: let
  hyprCfg = config.my.desktops.hyprland;
  cfg = hyprCfg.moduleCfg.monitors;
  availableMonitors = {
    homeVmSamsung = "Virtual-1,2560x1440@240,auto,1";
    homeVmROG = "Virtual-2,2560x1440@144,auto,1";
    homeSamsung = "DP-1,2560x1440@240,auto,1";
    homeROG = "DP-2,2560x1440@144,auto,1";
    schoolLaptop = "Virtual-1, 1920x1080@60, auto, 1";
    schoolHard = "eDP-1, 1920x1080@60, auto, 1";
  };
in {
  options.my.desktops.hyprland = {
    moduleCfg.monitors = {
      enable = lib.mkEnableOption "Enable the monitor config module.";
    };

    monitors = lib.mkOption {
      type = lib.types.listOf (lib.types.enum (builtins.attrNames availableMonitors));
      default = [];
      description = ''
        List of monitors you want to enable, defined by name, to add
        more available monitors, see the module.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        monitor = map (name: availableMonitors.${name}) hyprCfg.monitors;
      };
    };
  };
}
