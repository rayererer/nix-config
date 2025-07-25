{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.shells.templateModuleNameHere;
in {
  options.my.shells = {
    templateModuleNameHere = {
      enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
