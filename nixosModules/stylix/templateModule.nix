{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myOs.stylix.templateModuleNameHere;
in {
  options.myOs.stylix= {
    templateModuleNameHere = {
      enable = lib.mkEnableOption "Enable the templateModuleNameHere module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
