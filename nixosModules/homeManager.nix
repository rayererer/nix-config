{
  pkgs,
  inputs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.myOs.homeManager;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options.myOs.homeManager = lib.mkOption {
    type = lib.types.nullOr (lib.types.submodule {
      options = {
        userName = lib.mkOption {
          type = lib.types.str;
          description = "The name of the user to enable home-manager for.";
        };

        path = lib.mkOption {
          type = lib.types.path;
          description = ''
            The path to the main file of the home-manager config, most likely
            (but not necessarily) named 'home.nix'.
          '';
        };
      };
    });
    default = null;
    description = ''
      Enable home-manager for a specified user.
    '';
  };

  config =
    lib.mkIf cfg
    != null
    {
      home-manager = {
        sharedModules = [
          ../homeManagerModules
        ];

        extraSpecialArgs = {
          inherit inputs helpers;
        };

        users."${cfg.userName}" = import cfg.path;
      };
    };
}
