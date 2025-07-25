{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.shells.prompts;

  availablePrompts = ["starship"];
in {
  options.my.shells.prompts = {
    prompts = lib.mkOption {
      type = lib.types.listOf (lib.types.enum availablePrompts);
      default = [];
      description = ''
        Which prompts are installed, each prompt module should add itself here.
      '';
    };

    default = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum cfg.prompts);
      default =
        if (builtins.length cfg.prompts == 1)
        then builtins.elemAt cfg.prompts 0
        else null;
      description = ''
        Which prompt to use as the default, if only one is installed it should
        automatically become the default.
      '';
    };
  };

  config = lib.mkIf (builtins.length cfg.prompts > 0) {
    warnings =
      if cfg.default == null
      then [
        ''
          No default prompt has been set despite there being prompts installed.
          If just one prompt has been installed it should automatically become
          the default.
        ''
      ]
      else [];
  };
}
