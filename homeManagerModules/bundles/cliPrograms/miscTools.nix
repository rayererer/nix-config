{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.my.bundles.cliPrograms.miscTools;
  mkBundleConfig = helpers.bundles.bundleUtils.mkBundleConfig;
in {
  options.my.bundles.cliPrograms = {
    miscTools = {
      enable = lib.mkEnableOption ''
        Enable the miscTools bundle.
      '';
    };
  };

  config = lib.mkIf cfg.enable (mkBundleConfig {
    my = {
      cliPrograms = {
        zoxide = {
          enable = true;
          replaceCd = true;
        };

        ripgrep.enable = true;
        fzf.enable = true;
        nixFormatter.enable = true;
        tldr.enable = true;
        zipping.enable = true;
      };
    };
  });
}
