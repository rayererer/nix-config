{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myOs.gaming.steam;
in {
  options.myOs.gaming = {
    steam = {
      enable = lib.mkEnableOption "Enable the steam module.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;

      # Look at the NixOS Wiki for ports related to stuff.
    };
  };
}
