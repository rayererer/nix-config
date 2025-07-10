{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.desktops.hyprland;
in {
  options.my.desktops.hyprland = {
    moduleCfg.lyIntegration = {
      enable = lib.mkEnableOption "Enable lyIntegration module.";
    };
  };

  config = lib.mkIf cfg.moduleCfg.lyIntegration.enable {
    my.desktops.hyprland.envVars = [
      ["XDG_CURRENT_DESKTOP" "Hyprland" "'Regiving' control after needed ly integration override."]
    ];
  };
}
