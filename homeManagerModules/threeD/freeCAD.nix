{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.threeD.freeCAD;
in {
  options.my.threeD = {
    freeCAD = {
      enable = lib.mkEnableOption "Enable the FreeCAD module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
      home.packages = [
        pkgs.freecad
      ];
    };
}
