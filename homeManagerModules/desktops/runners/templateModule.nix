{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.desktops.runners.templateModuleNameHere;
in {
  options.my.desktops.runners = {
    templateModuleNameHere = {
      enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
