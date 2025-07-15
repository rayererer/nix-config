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
  };
}
