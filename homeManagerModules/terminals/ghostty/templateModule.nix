{
  pkgs,
  lib,
  config,
  ...
}: let
  termCfg = config.my.terminals;
  cfg = termCfg.ghostty.templateModuleNameHere;
in {
  options.my.terminals.ghostty = {
    templateModuleNameHere = {
      enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
