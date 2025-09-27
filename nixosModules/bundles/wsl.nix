{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.myOs.bundles.wsl;
  mkBundleConfig = helpers.bundles.bundleUtils.mkBundleConfig;
in {
  options.myOs.bundles = {
    wsl = {
      userName = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = ''
          Enables the stuff specifically needed for NixOS on WSL.
        '';
      };
    };
  };

  config = lib.mkIf (cfg.userName != null) (mkBundleConfig {
    nixpkgs.hostPlatform = "x86_64-linux";

    myOs = {
      services.wsl = {
        enable = true;
        inherit (cfg) userName;
      };
    };
  });
}
