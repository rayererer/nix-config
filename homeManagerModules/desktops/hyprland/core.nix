{ pkgs, lib, config, ... }:

let
  moduleName = "placeHolderModuleNameHere"
  cfg = config.my.desktops.hyprland;
in
{

options.my.desktops.hyprland = {
  moduleCfg.${moduleName} = {
    enable = lib.mkEnableOption = {
      description = "Enable ${moduleName} module. (default is true).";
      default = false;
    }
  };

  mainModKey = {
    type = types.str;
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
