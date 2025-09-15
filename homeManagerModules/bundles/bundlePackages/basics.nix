{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.my.bundles.bundlePackages.basics;
  mkBundleConfig = helpers.bundles.bundleUtils.mkBundleConfig;
in {
  options.my.bundles.bundlePackages = {
    basics = {
      enable = lib.mkEnableOption ''
        Enable the basics that I use and would want on all places where I have
        NixOS.
      '';
    };
  };

  config = lib.mkIf cfg.enable (mkBundleConfig {
    my = {
      bundles = {
        shells.enable = true;

        bundlePackages = {
          cliPrograms.enable = true;
        };
      };
    };
  });
}
