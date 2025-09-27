{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.myOs.bundles.bundlePackages.standard;
  inherit (helpers.bundles.bundleUtils) mkBundleConfig;
in {
  options.myOs.bundles.bundlePackages = {
    standard = {
      hostName = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = ''
          The hostName of the machine. If this is set, the package bundle will
          get enabled.
        '';
      };

      userName = lib.mkOption {
        type = lib.types.str;
        default = "rayer";
        description = ''
          The name of the default user on the machine. (Setting this alone will
          not do anything).
        '';
      };
    };
  };

  config = lib.mkIf (cfg.hostName != null) (mkBundleConfig {
    myOs = {
      bundles = {
        basics = {inherit (cfg) hostName;};
        standard = {inherit (cfg) userName;};
      };
    };
  });
}
