{ pkgs, lib, config, ... }:

let
  moduleName = "core";
  cfg = config.my.desktops.hyprland;
in
{

options.my.desktops.hyprland = {
  moduleCfg.${moduleName} = {
    enable = lib.mkEnableOption {
      description = "Enable ${moduleName} module. (default is true).";
      default = true;
    };
  };

  mainModKey = {
    type = lib.types.str;
    description = "String of the key to use as mainMod (default is 'SUPER').";
    default = "SUPER";
  };
};

config = lib.mkIf cfg.moduleCfg.${moduleName}.enable {
  wayland.windowManager.hyprland = {
    settings = {
     "$mainMod" = cfg.mainModKey;

      bind = [
        "$mainMod,RETURN,exec,kitty"
      ];
    };
  };
};
}
