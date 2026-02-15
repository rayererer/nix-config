{
  pkgs,
  lib,
  config,
  helpers,
  ...
}:
let
  cfg = config.my.testing;
  bundleUtils = helpers.bundles.bundleUtils;
in
{
  options.my = {
    testing = {
      enable = lib.mkEnableOption ''
        Enable the testing module for whatever I need in the moment.
      '';
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      (bundleUtils.mkBundleConfig {
        # Bundle testing here.
      })
      {
        # Normal config testing
        my.widgets.quickshell.containers = {
          topbar = [
            "Clock"
            "Battery"
          ];
        };
      }
    ]
  );
}
