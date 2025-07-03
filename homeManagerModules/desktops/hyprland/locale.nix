{ pkgs, lib, config, ... }:

let
  cfg = config.my.desktops.hyprland;
in
{

options.my.desktops.hyprland = {
  moduleCfg.locale = {
    enable = lib.mkEnableOption "Enable locale module.";
  };
};

config = lib.mkIf cfg.moduleCfg.locale.enable {
  wayland.windowManager.hyprland = {
    settings = {
      input = {
        kb_layout = "se";
      };
    };
  };
};
}
