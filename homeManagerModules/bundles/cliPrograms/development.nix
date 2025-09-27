{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.my.bundles.cliPrograms.development;
  mkBundleConfig = helpers.bundles.bundleUtils.mkBundleConfig;
in {
  options.my.bundles.cliPrograms = {
    development = {
      enable = lib.mkEnableOption ''
        Enable the development bundle.
      '';
    };
  };

  config = lib.mkIf cfg.enable (mkBundleConfig {
    my = {
      cliPrograms = {
        direnv.enable = true;
      };
    };
  });
}
