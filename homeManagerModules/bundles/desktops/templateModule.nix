{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.my.bundles.desktops.templateModuleNameHere;
  mkBundleConfig = helpers.bundles.bundleUtils.mkBundleConfig;
in {
  options.my.bundles.desktops = {
    templateModuleNameHere = {
      enable = lib.mkEnableOption ''
        Enable the templateModuleNameHere bundle.
      '';
    };
  };

  config = lib.mkIf cfg.enable (mkBundleConfig {
    my = {
      desktops = {
        
      };
    };
  });
}
