{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.my.bundles.cliPrograms.git;
  mkBundleConfig = helpers.bundles.bundleUtils.mkBundleConfig;
in {
  options.my.bundles.cliPrograms = {
    git = {
      enable = lib.mkEnableOption ''
        Enable the git bundle.
      '';
    };
  };

  config = lib.mkIf cfg.enable (mkBundleConfig {
    my = {
      cliPrograms = {
        git = {
          enable = true;
          withGh = true;
          useDefaultCredentials = true;
        };
      };
    };
  });
}
