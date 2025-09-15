{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.my.bundles.bundlePackages.basicDesktop;
  mkBundleConfig = helpers.bundles.bundleUtils.mkBundleConfig;
in {
  options.my.bundles.bundlePackages = {
    basicDesktop = {
      enable = lib.mkEnableOption ''
        Enable the basicDesktop bundle.
      '';
    };
  };

  config = lib.mkIf cfg.enable (mkBundleConfig {
    my = {
      terminals.ghostty.enable = true;
      browsers.zen.enable = true;
      bundles = {
        desktops.enable = true;
        bundlePackages = {
          basics.enable = true;
        };
      };
    };
  });
}
