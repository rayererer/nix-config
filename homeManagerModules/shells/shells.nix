{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.shells;

  # This list must contain the same name of the module corresponding to the shell.
  availableShells = ["fish"];
in {
  options.my.shells = {
    shells = lib.mkOption {
      type = lib.types.listOf (lib.types.enum availableShells);
      default = [];
      description = ''
        Which shells are installed, each shell module should add itself here.
      '';
    };

    default = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum cfg.shells);
      default =
        if (builtins.length cfg.shells == 1)
        then builtins.elemAt cfg.shells 0
        else null;
      description = ''
        Which shell to use as the default, if only one is installed it should
        automatically become the default.
      '';
    };
  };

  config = lib.mkIf (builtins.length cfg.shells > 0) {
    warnings =
      if cfg.default == null
      then [
        ''
          No default shell has been set despite there being shells installed.
          If just one shell has been installed it should automatically become
          the default.
        ''
      ]
      else [];
  };
}
