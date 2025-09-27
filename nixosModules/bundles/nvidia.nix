{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.myOs.bundles.nvidia;
  mkBundleConfig = helpers.bundles.bundleUtils.mkBundleConfig;
in {
  options.myOs.bundles = {
    nvidia = {
      enable = lib.mkEnableOption ''
        Enables the options I want for an nvidia machine.
      '';
    };
  };

  config = lib.mkIf cfg.enable (mkBundleConfig {
    myOs = {
      graphics.nvidia = {
        enable = true;
        driver = "proprietary";
      };
    };
  });
}
