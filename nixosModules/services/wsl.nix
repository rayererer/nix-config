{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myOs.services.wsl;
in {
  options.myOs.services = {
    wsl = {
      enable = lib.mkEnableOption ''
        Enable the wsl module for if this host runs in WSL.
      '';

      userName = lib.mkOption {
        type = lib.types.str;
        default = "nixos";
        description = ''
          Which username for the default user to use in WSL.
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {
    wsl = {
      enable = true;
      defaultUser = cfg.userName;
    };
  };
}
