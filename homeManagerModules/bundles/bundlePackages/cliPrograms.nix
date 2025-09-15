{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.my.bundles.bundlePackages.cliPrograms;
  mkBundleConfig = helpers.bundles.bundleUtils.mkBundleConfig;
in {
  options.my.bundles.bundlePackages = {
    cliPrograms = {
      enable = lib.mkEnableOption ''
        Enables all the bundles inside cliPrograms.
      '';
    };
  };

  config = lib.mkIf cfg.enable (mkBundleConfig {
    my = {
      bundles = {
        cliPrograms = {
          git.enable = true;
          development.enable = true;
          miscTools.enable = true;
          neovim.enable = true;
        };
      };
    };
  });
}
