{
  pkgs,
  lib,
  config,
  ...
}: let
  hyprCfg = config.my.desktops.hyprland;
  cfg = hyprCfg.moduleCfg.windowNavigation;

  # Pass input in the format:
  # {
  #   mods = "modKey(s)";
  #   dispatcher = "hyprlandDispatcher";
  #   actions = [ "leftAction" "downAction" "upAction" "rightAction" ]
  # }
  # so for example:
  # {
  #   mods = "$mainMod SHIFT";
  #   dispatcher = "swapwindow"
  #   actions = ["l" "d" "u" "r"]
  # }
  forEveryDirection = {
    mods,
    dispatcher,
    actions,
  }:
    builtins.concatLists
    (
      map (
        directionSet:
          builtins.genList (
            i: let
              directions = ["leftKey" "downKey" "upKey" "rightKey"];
            in "${mods}, ${directionSet.${builtins.elemAt directions i}}, ${dispatcher}, ${builtins.elemAt actions i}"
          )
          4
      )
      hyprCfg.directionSets
    );
in {
  options.my.desktops.hyprland = {
    moduleCfg.windowNavigation = {
      enable = lib.mkEnableOption "Enable the window navigation module.";
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        bind =
          # Moving focus
          forEveryDirection
          {
            mods = "$mainMod";
            dispatcher = "movefocus";
            actions = ["l" "d" "u" "r"];
          }
          ++
          # Moving Windows
          forEveryDirection
          {
            mods = "$mainMod $moveMod";
            dispatcher = "swapwindow";
            actions = ["l" "d" "u" "r"];
          }
          ++
          # Resizing Windows
          forEveryDirection
          {
            mods = "$mainMod $resizeMod";
            dispatcher = "resizeactive";
            actions = ["-60 0" "0 60" "0 -60" "60 0"];
          };
      };
    };
  };
}
