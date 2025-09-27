{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.my.bundles.shells;
  mkBundleConfig = helpers.bundles.bundleUtils.mkBundleConfig;
in {
  options.my.bundles = {
    shells = {
      enable = lib.mkEnableOption ''
        Enables my default shell and prompt.
      '';
    };
  };

  config = lib.mkIf cfg.enable (mkBundleConfig {
    my = {
      shells = {
        fish.enable = true;
        prompts.starship.enable = true;
      };
    };
  });
}
