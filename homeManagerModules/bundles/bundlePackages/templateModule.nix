{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.my.bundles.bundlePackages.templateModule.nix;
  mkBundleConfig = helpers.bundles.bundleUtils.mkBundleConfig;
in {
  options.my.bundles.bundlePackages = {
    templateModule.nix = {
      enable = lib.mkEnableOption ''
        Enable the templateModule.nix bundle.
      '';
    };
  };

  config = lib.mkIf cfg.enable (mkBundleConfig {
    my = {
      bundles = {

      };
    };
  });
}
