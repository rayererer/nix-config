{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myOs.fonts.templateModuleNameHere;
in {
  options.myOs.fonts = {
    templateModuleNameHere = {
      enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
