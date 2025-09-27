{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.myOs.bundles.bundlePackages.wsl;
  inherit (helpers.bundles.bundleUtils) mkBundleConfig;
in {
  options.myOs.bundles.bundlePackages = {
    wsl = {
      hostname = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = ''
          Enables the stuff I want on any WSL machine.
        '';
      };
    };
  };

  config = lib.mkIf (cfg.hostname != null) (mkBundleConfig {
    myOs = {
      bundles = {
        wsl.enable = true;

        bundlePackages = {
          standard = {inherit (cfg) hostname;};
        };
      };
    };
  });
}
