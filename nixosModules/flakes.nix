{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myOs.flakes;
in {
  options.myOs = {
    flakes = {
      enable = lib.mkEnableOption ''
        Enable flakes, STRONGLY recommended, since entire config
        relies on flakes.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    nix.extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
