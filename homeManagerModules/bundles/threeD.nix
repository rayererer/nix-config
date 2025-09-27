{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.my.bundles.threeD;
  mkBundleConfig = helpers.bundles.bundleUtils.mkBundleConfig;
in {
  options.my.bundles = {
    threeD = {
      enable = lib.mkEnableOption ''
        Enables software for handling 3D stuff, including CAD and 3D printing.
      '';
    };
  };

  config = lib.mkIf cfg.enable (mkBundleConfig {
    my = {
      threeD = {
        prusaSlicer.enable = true;
        freeCAD.enable = true;
      };
    };
  });
}
