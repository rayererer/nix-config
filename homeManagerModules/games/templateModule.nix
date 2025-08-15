{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.games.templateModuleNameHere;
in {
  options.my.games = {
    templateModuleNameHere = {
      enable = lib.mkEnableOption "Enable the templateModuleNameHere module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
