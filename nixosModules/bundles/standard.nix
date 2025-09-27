{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.myOs.bundles.standard;
  mkBundleConfig = helpers.bundles.bundleUtils.mkBundleConfig;
in {
  options.myOs.bundles = {
    standard = {
      userName = lib.mkEnableOption ''
        Enables things that I would generally want on any machine but that are
        not necessary (those live in the basics bundle). An example is home-manager
        which gets enabled here. Currently this module contains quite a lot of
        stuff and this could get modularized in the future.
      '';
    };
  };

  config = lib.mkIf (cfg.userName != null) (mkBundleConfig {
    nixpkgs.config.allowUnfree = true;

    nix.settings.trusted-users = [cfg.userName];

    # Enabling the shell manually since I cannot avoid recursion otherwise:
    programs.fish.enable = true;

    myOs = {
      users.defaultUser = cfg.userName;
      locale.enable = true;
      systemMaintenance.garbageCollection.enable = true;
      fonts.enableDefaultStack = true;
      services.networking.enable = true;

      stylix = {
        enable = true;

        colorSchemes = {
          alacrittyCopy.enable = true;
        };
      };
    };
  });
}
