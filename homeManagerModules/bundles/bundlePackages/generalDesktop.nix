{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.my.bundles.bundlePackages.generalDesktop;
  mkBundleConfig = helpers.bundles.bundleUtils.mkBundleConfig;
in {
  options.my.bundles.bundlePackages = {
    generalDesktop = {
      enable = lib.mkEnableOption ''
        Enable the generalDesktop bundle.
      '';
    };
  };

  config = lib.mkIf cfg.enable (mkBundleConfig {
    my = {
      guiPrograms = {
        obsidian.enable = true;
        vesktop.enable = true;
      };

      bundles = {
        threeD.enable = true;
        bundlePackages = {
          basicDesktop.enable = true;
        };
      };
    };
  });
}
