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
      enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
