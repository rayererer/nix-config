{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.threeD.templateModuleNameHere;
in {
  options.my.threeD = {
    templateModuleNameHere = {
      enable = lib.mkEnableOption "Enable the templateModuleNameHere module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
