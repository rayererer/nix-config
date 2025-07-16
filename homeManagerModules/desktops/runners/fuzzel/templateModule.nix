{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.desktops.runners.fuzzel.templateModuleNameHere;
in {
  options.my.desktops.runners.fuzzel = {
    templateModuleNameHere = {
      enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
