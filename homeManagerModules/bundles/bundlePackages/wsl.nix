{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.my.bundles.bundlePackages.wsl;
  mkBundleConfig = helpers.bundles.bundleUtils.mkBundleConfig;
in {
  options.my.bundles.bundlePackages = {
    wsl = {
      enable = lib.mkEnableOption ''
        Enable the bundle for everything I want installed on all wsl hosts.
      '';
    };
  };

  config = lib.mkIf cfg.enable (mkBundleConfig {
    my = {
      bundles = {
        bundlePackages = {
          basics.enable = true;
        };
      };
    };
  });
}
