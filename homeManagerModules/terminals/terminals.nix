{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.terminals;

  # This list must contain the same name of the module corresponding to the terminal.
  availableTerminals = ["ghostty"];
in {
  options.my.terminals = {
    terminals = lib.mkOption {
      type = lib.types.listOf (lib.types.enum availableTerminals);
      default = [];
      description = ''
        Which terminals are installed, each terminal module should add itself here.
      '';
    };

    default = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum cfg.terminals);
      default =
        if (builtins.length cfg.terminals == 1)
        then builtins.elemAt cfg.terminals 0
        else null;
      description = ''
        Which terminal to use as the default, if only one is installed it should
        automatically become the default.
      '';
    };

    fontSize = lib.mkOption {
      type = lib.types.ints.positive;
      default = 14;
      description = ''
        What font size to use in terminals (points).
      '';
    };
  };

  config = lib.mkIf (builtins.length cfg.terminals > 0) {
    warnings =
      if cfg.default == null
      then [
        ''
          No default terminal has been set despite there being terminals installed.
          If just one terminal has been installed it should automatically become
          the default.
        ''
      ]
      else [];
  };
}
