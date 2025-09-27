{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.myOs.bundles.desktops;
  mkBundleConfig = helpers.bundles.bundleUtils.mkBundleConfig;
in {
  options.myOs.bundles = {
    desktops = {
      enable = lib.mkEnableOption ''
        Enables the stuff I want for any desktop computer.
      '';
    };
  };

  config = lib.mkIf cfg.enable (mkBundleConfig {
    myOs = {
      services = {
        ly.enable = true;
        sound.enable = true;
      };

      desktops.hyprland = {
        enable = true;
      };
    };
  });
}
