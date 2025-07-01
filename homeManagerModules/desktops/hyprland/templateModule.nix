{ pkgs, lib, config, ... }:

let
  cfg = config.my.desktops.hyprland;
in
{

options.my.desktops.hyprland = {
  moduleCfg.templateModuleNameHere = {
    enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
  };
};

config = lib.mkIf cfg.moduleCfg.templateModuleNameHere.enable {
  wayland.windowManager.hyprland = {
    settings = {

    };
  };
};
}
