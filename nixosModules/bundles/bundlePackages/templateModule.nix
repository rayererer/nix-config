{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.myOs.bundles.bundlePackages.templateModule.nix;
  mkBundleConfig = helpers.bundles.bundleUtils.mkBundleConfig;
in {
  options.myOs.bundles.bundlePackages = {
    templateModule.nix = {
      enable = lib.mkEnableOption ''
        Enable the templateModule.nix bundle.
      '';
    };
  };

  config = lib.mkIf cfg.enable (mkBundleConfig {
    myOs = {
      bundles = {

      };
    };
  });
}
