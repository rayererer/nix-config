{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.my.bundles.cliPrograms.neovim.templateModuleNameHere;
  mkBundleConfig = helpers.bundles.bundleUtils.mkBundleConfig;
in {
  options.my.bundles.cliPrograms.neovim = {
    templateModuleNameHere = {
      enable = lib.mkEnableOption ''
        Enable the templateModuleNameHere neovim bundle.
      '';
    };
  };

  config = lib.mkIf cfg.enable (mkBundleConfig {
    my = {
      cliPrograms = {

      };
    };
  });
}
