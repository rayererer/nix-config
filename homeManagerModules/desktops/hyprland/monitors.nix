{ pkgs, lib, config, ... }:

let
  hyprCfg = config.my.desktops.hyprland;
  cfg = hyprCfg.moduleCfg.monitors;
  availableMonitors = [ "homeROG" "homeSamsung" ];
in
{

options.my.desktops.hyprland = {
  moduleCfg.monitors = {
    enable = lib.mkEnableOption "Enable the monitor config module.";
  };

  monitors = lib.mkOption { 
    type = lib.types.listOf (lib.types.enum availableMonitors);
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

    };
  };
};

}
