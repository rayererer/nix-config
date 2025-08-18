{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myOs.systemMaintenance.garbageCollection;
in {
  options.myOs.systemMaintenance = {
    garbageCollection = {
      enable = lib.mkEnableOption "Enable the garbageCollection module.";
    };
  };

  config = lib.mkIf cfg.enable {
    nix = {
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
        randomizedDelaySec = "45min";
      };

      optimise = {
        automatic = true;
        randomizedDelaySec = "45min";
      };
    };
  };
}
