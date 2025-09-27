{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.myOs.bundles.templateModuleNameHere;
  mkBundleConfig = helpers.bundles.bundleUtils.mkBundleConfig;
in {
  options.myOs.bundles = {
    templateModuleNameHere = {
      enable = lib.mkEnableOption ''
        Enable the templateModuleNameHere bundle.
      '';
    };
  };

  config = lib.mkIf cfg.enable (mkBundleConfig {
    myOs = {
      
    };
  });
}
