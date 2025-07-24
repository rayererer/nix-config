{
  pkgs,
  lib,
  config,
  ...
}: let
  deskCfg = config.my.desktops;
  hyprCfg = deskCfg.hyprland;
  browserCfg = config.my.browsers;
  hyprBrowserCfg = hyprCfg.browser;
  cfg = hyprCfg.moduleCfg.browser;
in {
  options.my.desktops.hyprland = {
    moduleCfg.browser = {
      enable = lib.mkEnableOption "Enable the browser module.";
    };

    browser = {
      keyBind = lib.mkOption {
        type = lib.types.str;
        description = "String of the key to use for launching the default browser.";
        default = "W";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        bind = [
          "$mainMod, ${hyprBrowserCfg.keyBind}, exec, $launchApp ${browserCfg.${browserCfg.default}.launchCommand}"
        ];
      };
    };
  };
}
