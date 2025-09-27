{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.myOs.bundles.basics;
  inherit (helpers.bundles.bundleUtils) mkBundleConfig;
in {
  options.myOs.bundles = {
    basics = {
      hostName = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = ''
          This enables the most basic options which are required for the system.
        '';
      };
    };
  };

  config = lib.mkIf (cfg.hostName != null) (mkBundleConfig {
    networking = {inherit (cfg) hostName;};

    myOs = {
      flakes.enable = true;
    };
  });
}
