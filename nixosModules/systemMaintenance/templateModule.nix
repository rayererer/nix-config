{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myOs.systemMaintenance.templateModuleNameHere;
in {
  options.myOs.systemMaintenance = {
    templateModuleNameHere = {
      enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
