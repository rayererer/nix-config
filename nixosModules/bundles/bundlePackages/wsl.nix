{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  bundlePkgCfg = config.myOs.bundles.bundlePackages;
  cfg = bundlePkgCfg.wsl;
  inherit (helpers.bundles.bundleUtils) mkBundleConfig;
in {
  options.myOs.bundles.bundlePackages = {
    wsl = {
      hostName = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = ''
          The hostName of the WSL machine.
        '';
      };

      userName = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = bundlePkgCfg.standard.userName;
        description = ''
          The name of the default WSL user.
        '';
      };
    };
  };

  config = lib.mkIf (cfg.hostName != null && cfg.userName != null) (mkBundleConfig {
    myOs = {
      bundles = {
        wsl = {inherit (cfg) userName;};

        bundlePackages = {
          standard = {inherit (cfg) hostName;};
        };
      };
    };
  });
}
