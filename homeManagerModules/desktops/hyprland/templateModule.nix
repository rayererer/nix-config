{ pkgs, lib, config, ... }:

let
  moduleName = "placeHolderModuleNameHere"
  cfg = config.my.desktops.hyprland;
in
{

options.my.desktops.hyprland = {
  moduleCfg.${moduleName} = {
    enable = lib.mkEnableOption = {
      description = "Enable ${moduleName} module.";
      default = false;
    }
  };
};

config = lib.mkIf cfg.moduleCfg.${moduleName}.enable {
  wayland.windowManager.hyprland = {
    settings = {

    };
  };
};
}
