{ pkgs, lib, config, ... }:

let
  hyprCfg = config.my.desktops.hyprland;
in
{

options.my.desktops.hyprland = {
  moduleCfg.templateModuleNameHere = {
    enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
  };
};

config = lib.mkIf hyprCfg.moduleCfg.templateModuleNameHere.enable {
  wayland.windowManager.hyprland = {
    settings = {

    };
  };
};
}
