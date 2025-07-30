{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.cliPrograms.templateModuleNameHere;
in {
  options.my.cliPrograms = {
    templateModuleNameHere = {
      enable = lib.mkEnableOption "Enable the templateModuleNameHere module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
