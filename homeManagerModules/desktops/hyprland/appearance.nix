{
  pkgs,
  lib,
  config,
  ...
}:
let
  hyprCfg = config.my.desktops.hyprland;
  cfg = hyprCfg.moduleCfg.appearance;
in
{
  options.my.desktops.hyprland = {
    moduleCfg.appearance = {
      enable = lib.mkEnableOption "Enable the appearance module.";
    };

    noBordersOrGaps = lib.mkEnableOption ''
      Turns off borders and gaps if enabled.
    '';
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = lib.mkMerge [
        {
          general = lib.mkIf hyprCfg.noBordersOrGaps {
            border_size = 0;
            gaps_in = 0;
            gaps_out = 0;
          };
        }
      ];
    };
  };
}
