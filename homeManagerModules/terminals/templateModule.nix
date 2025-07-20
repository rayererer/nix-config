{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.terminals.templateModuleNameHere;
in {
  options.my.terminals = {
    templateModuleNameHere = {
      enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
