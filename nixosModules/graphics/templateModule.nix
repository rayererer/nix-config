{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myOs.graphics.templateModuleNameHere;
in {
  options.myOs.graphics = {
    templateModuleNameHere = {
      enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
