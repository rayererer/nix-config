{
  pkgs,
  lib,
  config,
  ...
}: let
  deskCfg = config.my.desktops;
  hyprCfg = deskCfg.hyprland;
  appLaunchCfg = hyprCfg.appLauncher;
  cfg = hyprCfg.moduleCfg.appLauncher;
in {
  options.my.desktops.hyprland = {
    moduleCfg.appLauncher = {
      enable = lib.mkEnableOption "Enable the app launcher module.";
    };

    appLauncher = {
      keyBind = lib.mkOption {
        type = lib.types.str;
        description = "String of the key to use for launching the app launcher.";
        default = "R";
      };

      default = lib.mkOption {
        type = lib.types.nullOr (lib.types.enum deskCfg.runners.runners);
        default = null;
        description = ''
          Set the default app launcher for Hyprland. The app launcher must
          have been added to the list of installed app launchers (runners), which you
          do by enabling them with 'desktops.runners.runnerYouWant.enable'.
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        bind = [
          "$mainMod, ${appLaunchCfg.keyBind}, exec, ${deskCfg.runners.${appLaunchCfg.default}.launchCommand}"
        ];
      };
    };
  };
}
