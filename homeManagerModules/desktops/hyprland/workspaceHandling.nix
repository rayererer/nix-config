{
  pkgs,
  lib,
  config,
  ...
}: let
  hyprCfg = config.my.desktops.hyprland;
  cfg = hyprCfg.moduleCfg.workspaceHandling;
in {
  options.my.desktops.hyprland = {
    moduleCfg.workspaceHandling = {
      enable = lib.mkEnableOption "Enable the workspace handling module.";
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        bind =
          []
          ++ builtins.concatLists (
            builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mainMod, code:1${toString i}, workspace, ${toString ws}"
                "$mainMod $moveMod, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9
          );
      };
    };
  };
}
