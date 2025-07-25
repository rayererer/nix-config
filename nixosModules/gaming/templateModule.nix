{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myOs.gaming.templateModuleNameHere;
in {
  options.myOs.gaming = {
    templateModuleNameHere = {
      enable = lib.mkEnableOption "Enable the templateModuleNameHere module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
