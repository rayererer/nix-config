{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.myOs.bundles.basics;
  mkBundleConfig = helpers.bundles.bundleUtils.mkBundleConfig;
in {
  options.myOs.bundles = {
    basics = {
      hostname = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = ''
          This enables the most basic options which are required for the system.
        '';
      };

      hardwareConfPath = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = ../../hosts/${cfg.hostname}/hardware-configuration.nix;
        description = ''
          The path to the hardware-configuration file, if set to null, no hardware
          configuration will be imported.
        '';
      };
    };
  };

  config = lib.mkIf (cfg.hostname != null) (mkBundleConfig {
    imports = lib.mkIf (cfg.hardwareConfPath != null) [
      cfg.hardwareConfPath  
    ];

    networking.hostname = cfg.hostname;

    myOs = {
      flakes.enable = true;
    };
  });
}
