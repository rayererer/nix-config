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
      enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
