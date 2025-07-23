{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.my.desktops;
  envUtils = helpers.envVars.envVarUtils;
  availableDesktops = ["hyprland"];
in {
  options.my.desktops = {
    enable = lib.mkEnableOption "Enable desktops module.";

    desktops = lib.mkOption {
      type = lib.types.listOf (lib.types.enum availableDesktops);
      default = [];
      description = ''
        A list of selected desktops, each desktop
        module should add itself to this list.
      '';
    };

    envVars = lib.mkOption {
      type = envUtils.envVarListType;
      default = [];
      description = "A list of desktop agnostic Env Vars";
    };

    appLaunchPrefix = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = ''
        Prefix before app launch, default is an empty string, needed because
        uwsm and app2unit each want own commands to launch apps with.
        For changing this: add a space at the end as unnecessary spaces are usually fine
        while to few are not good.
      '';
    };

    fontSize = lib.mkOption {
      type = lib.types.ints.positive;
      default = 24;
      description = ''
        What font size to use in general desktop elements (points).
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    warnings =
      if builtins.length cfg.desktops == 0
      then [
        ''
          No desktop has been selected even though the desktops module
          is enabled, this is probably not intended, please import a
          desktop using 'config.my.desktops.desktopNameHere.enable'.
          (source: 'homeManagerModules/desktops/desktops.nix')
        ''
      ]
      else [];

    stylix.fonts.sizes.desktop = cfg.fontSize;
  };
}
