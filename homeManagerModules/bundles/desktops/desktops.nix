{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.my.bundles.desktops;
  mkBundleConfig = helpers.bundles.bundleUtils.mkBundleConfig;
in {
  options.my.bundles = {
    desktops = {
      enable = lib.mkEnableOption ''
        Enable the templateModuleNameHere bundle.
      '';
    };
  };

  config = lib.mkIf cfg.enable (mkBundleConfig {
    my = {
      desktops = {
        enable = true;
        cursors.enable = true;
        wallpapers.enable = true;
        runners.fuzzel.enable = true;

        hyprland = {
          enable = true;

          hyprshade = {
            enable = true;

            blueLightFilterTimes = {
              start = "20:00:00";
              end = "07:00:00";
            };
          };
        };
      };
    };
  });
}
