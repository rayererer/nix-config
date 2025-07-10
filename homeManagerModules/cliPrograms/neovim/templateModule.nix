{
  pkgs,
  lib,
  config,
  ...
}: let
  nvimCfg = config.my.cliPrograms.neovim;
  cfg = nvimCfg.moduleCfg.templateModuleNameHere;
in {
  options.my.cliPrograms.neovim = {
    moduleCfg.templateModuleNameHere = {
      enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
