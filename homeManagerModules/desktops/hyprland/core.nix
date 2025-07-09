{ pkgs, lib, config, ... }:

let
  hyprCfg = config.my.desktops.hyprland;
  cfg = hyprCfg.moduleCfg.core;
in
{

options.my.desktops.hyprland = {
  moduleCfg.core = {
    enable = lib.mkEnableOption {
      description = "Enable core module.";
    };
  };

  mainModKey = lib.mkOption {
    type = lib.types.str;
    description = "String of the key to use as mainMod (default is 'SUPER').";
    default = "SUPER";
  };

  terminal = lib.mkOption {
    type = lib.types.str;
    description = "Terminal used by default in Hyprland as a string";
    default = "kitty";
  };
};

config = lib.mkIf cfg.enable {
  wayland.windowManager.hyprland = {
    settings = {

     "$mainMod" = hyprCfg.mainModKey;
     "$terminal" = hyprCfg.terminal;
      
      bind = [
        "$mainMod,RETURN,exec,$terminal"
        "$mainMod,Q,killactive"
      ];
    };
  };
};
}
