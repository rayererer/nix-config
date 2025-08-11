{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.desktops.templateModuleNameHere;
in {
  options.my.desktops = {
    templateModuleNameHere = {
      enable = lib.mkEnableOption "Enable the templateModuleNameHere module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
