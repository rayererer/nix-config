{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.myOs.bundles.standard;
  inherit (helpers.bundles.bundleUtils) mkBundleConfig;
in {
  options.myOs.bundles = {
    standard = {
      userName = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = ''
          Enables things that I would generally want on any machine but that are
          not necessary (those live in the basics bundle). An example is home-manager
          which gets enabled here. Currently this module contains quite a lot of
          stuff and this could get modularized in the future.
        '';
      };

      homeManagerPath = lib.mkOption {
        type = lib.types.path;
        default = ../../hosts/${config.networking.hostName}/home.nix;
        description = ''
          The path to the main file of the home-manager config, most likely
          (but not necessarily) named 'home.nix'.
        '';
      };
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

      homeManager = {
        inherit (cfg) userName;
        path = cfg.homeManagerPath;
      };

      stylix = {
        enable = true;

        colorSchemes = {
          alacrittyCopy.enable = true;
        };
      };
    };
  });
}
