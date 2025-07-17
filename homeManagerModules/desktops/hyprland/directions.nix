{
  pkgs,
  lib,
  config,
  ...
}: let
  hyprCfg = config.my.desktops.hyprland;
  cfg = hyprCfg.moduleCfg.directions;

  # Define each set in the format:
  # ["nameOfSet" "leftKey" "downKey" "upKey" "rightKey"]
  directionSets = [
    ["vim" "h" "j" "k" "l"]
    ["arrows" "left" "down" "up" "right"]
  ];

  availableDirectionSets = lib.listToAttrs (map (tuple:
    if !(builtins.length tuple == 5)
    then throw "Invalid defintion of direction sets (must contain five items)"
    else let
      elem = num: (builtins.elemAt tuple num);
    in {
      name = elem 0;
      value = {
        leftKey = elem 1;
        downKey = elem 2;
        upKey = elem 3;
        rightKey = elem 4;
      };
    })
  directionSets);

  availableNames = builtins.attrNames availableDirectionSets;

  directionSetType =
    lib.types.coercedTo
    (lib.types.enum availableNames)
    (name: availableDirectionSets.${name})
    (lib.types.submodule {
      options = {
        name = lib.mkOption {
          type = lib.types.str;
          description = "Name of the direction set";
        };

        leftKey = lib.mkOption {
          type = lib.types.str;
        };

        downKey = lib.mkOption {
          type = lib.types.str;
        };

        upKey = lib.mkOption {
          type = lib.types.str;
        };

        rightKey = lib.mkOption {
          type = lib.types.str;
        };
      };
    });
in {
  options.my.desktops.hyprland = {
    moduleCfg.directions = {
      enable = lib.mkEnableOption ''
        Enable the directions module (currently useless as it only contains an option.
      '';
    };

    directionSets = lib.mkOption {
      type = lib.types.listOf directionSetType;
      default = ["vim" "arrows"];
      description = ''
        A list of which direction sets to use for stuff around hyprland,
        (e.g. moving and resizing) by default both vim motions and arrow keys
        can be used.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
      };
    };
  };
}
