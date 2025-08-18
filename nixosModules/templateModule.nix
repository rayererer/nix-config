{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myOs.templateModuleNameHere;
in {
  options.myOs = {
    templateModuleNameHere = {
      enable = lib.mkEnableOption "Enable the templateModuleNameHere module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
