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
    floatingKey = lib.mkOption {
      type = lib.types.str;
      default = "V";
      description = ''
        Key to use for toggling floating on windows.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        bind = [
          "$mainMod, ${hyprCfg.fullscreenKey}, fullscreen"
          "$mainMod, ${hyprCfg.floatingKey}, togglefloating"
        ];

        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
      };
    };
  };
}
