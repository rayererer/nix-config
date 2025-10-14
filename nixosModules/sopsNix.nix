{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.myOs.sopsNix;
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  options.myOs = {
    sopsNix = {
      ageKeyFile = lib.mkOption { 
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = ''
          Enables the use of sops-nix with my default settings using the key file
          specified.
        '';
      };
    };
  };

  config =
    lib.mkIf (cfg.ageKeyFile != null) {
      sops = {
        age.keyFile = cfg.ageKeyFile;

        defaultSopsFile = ../secrets/secrets.yaml;
        defaultSopsFormat = "yaml";
      };
    };
}
