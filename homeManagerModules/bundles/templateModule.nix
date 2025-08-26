{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.my.bundles.templateModuleNameHere;
  mkBundleConfig = helpers.bundles.bundleUtils.mkBundleConfig;
in {
  options.my.bundles = {
    templateModuleNameHere = {
      enable = lib.mkEnableOption ''
        Enable the templateModuleNameHere bundle.
      '';
    };
  };

  config =
    lib.mkIf cfg.enable mkBundleConfig {
    };
}
