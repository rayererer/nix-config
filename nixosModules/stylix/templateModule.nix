{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myOs.stylix.colorSchemes.templateModuleNameHere;
in {
  options.myOs.stylix.colorSchemes = {
    templateModuleNameHere = {
      enable = lib.mkEnableOption "Enable the templateModuleNameHere color scheme.";
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
