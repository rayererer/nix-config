{
  pkgs,
  lib,
  config,
  ...
}: let
  deskCfg = config.my.desktops;
  hyprCfg = deskCfg.hyprland;
  cfg = hyprCfg.moduleCfg.core;

  quitCommand =
    if hyprCfg.useUWSM
    then "exec, uwsm stop"
    else "exit,";
in {
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

    moveModKey = lib.mkOption {
      type = lib.types.str;
      description = "String of the key to use as the main mod key to move stuff around";
      default = "SHIFT";
    };

    resizeModKey = lib.mkOption {
      type = lib.types.str;
      description = "String of the key to use as the main mod key to resize stuff";
      default = "CTRL";
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
        "$launchApp" = deskCfg.appLaunchPrefix;

        "$mainMod" = hyprCfg.mainModKey;
        "$moveMod" = hyprCfg.moveModKey;
        "$resizeMod" = hyprCfg.resizeModKey;

        "$terminal" = hyprCfg.terminal;

        bind = [
          "$mainMod, RETURN, exec, $launchApp $terminal"
          "$mainMod, Q, killactive,"
          "$mainMod, BACKSPACE, ${quitCommand}"
        ];

        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
      };
    };
  };
}
