{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.browsers;

  # This list must contain the same name of the module corresponding to the browser.
  availableBrowsers = ["zen"];
in {
  options.my.browsers = {
    browsers = lib.mkOption {
      type = lib.types.listOf (lib.types.enum availableBrowsers);
      default = [];
      description = ''
        Which browsers are installed, each browser module should add itself here.
      '';
    };

    default = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum cfg.browsers);
      default =
        if (builtins.length cfg.browsers == 1)
        then builtins.elemAt cfg.browsers 0
        else null;
      description = ''
        Which browser to use as the default, if only one is installed it should
        automatically become the default.
      '';
    };
  };

  config = lib.mkIf (builtins.length cfg.browsers > 0) {
    warnings =
      if cfg.default == null
      then [
        ''
          No default browser has been set despite there being browsers installed.
          If just one browser has been installed it should automatically become
          the default.
        ''
      ]
      else [];
  };
}
