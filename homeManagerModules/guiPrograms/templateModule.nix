{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.guiPrograms.templateModuleNameHere;
in {
  options.my.guiPrograms = {
    templateModuleNameHere = {
      enable = lib.mkEnableOption "Enable the templateModuleNameHere module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
