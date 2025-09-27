{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.myOs.bundles.bundlePackages.desktop;
  inherit (helpers.bundles.bundleUtils) mkBundleConfig;
in {
  options.myOs.bundles.bundlePackages = {
    desktop = {
      hostname = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = ''
          Enables the stuff I want on any desktop computer.
        '';
      };

      isNvidia = lib.mkEnableOption ''
        If set to true, will enable nvidia stuff as well.
      '';
    };
  };

  config = lib.mkIf (cfg.hostname != null) (mkBundleConfig {
    myOs = {
      bundles = {
        nvidia.enable = cfg.isNvidia;
        bootloaders.enable = true;
        desktops.enable = true;

        bundlePackages = {
          standard = {inherit (cfg) hostname;};
        };
      };
    };
  });
}
