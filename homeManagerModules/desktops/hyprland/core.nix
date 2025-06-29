{ pkgs, lib, config, ... }:

let
  cfg = config.my.desktops.hyprland;
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
};

config = lib.mkIf cfg.moduleCfg.core.enable {
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
