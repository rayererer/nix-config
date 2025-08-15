{
  pkgs,
  lib,
  config,
  ...
}: let
  hyprCfg = config.my.desktops.hyprland;
  cfg = hyprCfg.moduleCfg.windowControlling;
in {
  options.my.desktops.hyprland = {
    moduleCfg.windowControlling = {
      enable = lib.mkEnableOption "Enable the window controlling module.";
    };

    fullscreenKey = lib.mkOption {
      type = lib.types.str;
      default = "F";
      description = ''
        Key to use for setting windows in fullscreen.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        bind = [
          "$mainMod, ${hyprCfg.fullscreenKey}, fullscreen"
        ];

        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
      };
    };
  };
}
