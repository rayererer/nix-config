{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.threeD.prusaSlicer;
in {
  options.my.threeD = {
    prusaSlicer = {
      enable = lib.mkEnableOption "Enable the prusa slicer module.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.prusa-slicer
    ];
  };
}
