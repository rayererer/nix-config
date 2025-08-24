{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.browsers.zen.templateModuleNameHere;
in {
  options.my.browsers.zen = {
    templateModuleNameHere = {
      enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
