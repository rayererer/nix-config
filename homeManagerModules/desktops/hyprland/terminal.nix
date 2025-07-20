{
  pkgs,
  lib,
  config,
  ...
}: let
  deskCfg = config.my.desktops;
  hyprCfg = deskCfg.hyprland;
  terminalCfg = config.my.terminals;
  hyprTerminalCfg = hyprCfg.terminal;
  cfg = hyprCfg.moduleCfg.terminal;
in {
  options.my.desktops.hyprland = {
    moduleCfg.terminal = {
      enable = lib.mkEnableOption "Enable the terminal module.";
    };

    terminal = {
      keyBind = lib.mkOption {
        type = lib.types.str;
        description = "String of the key to use for launching the default terminal.";
        default = "RETURN";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        bind = [
          "$mainMod, ${hyprTerminalCfg.keyBind}, exec, $launchApp ${terminalCfg.default}"
        ];
      };
    };
  };
}
