{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.templateModuleNameHere;
in {
  options.my = {
    templateModuleNameHere = {
      enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
