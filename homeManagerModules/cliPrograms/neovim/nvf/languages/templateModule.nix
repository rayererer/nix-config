{
  pkgs,
  lib,
  config,
  ...
}: let
  nvfCfg = config.my.cliPrograms.neovim.nvf;
  langHandModCfg = nvfCfg.moduleCfg.languageHandling;
  cfg = langHandModCfg.templateModuleNameHere;
in {
  options.my.cliPrograms.neovim.nvf = {
    moduleCfg.languageHandling = {
      templateModuleNameHere = {
        enable = lib.mkEnableOption "Enable the templateModuleNameHere module.";
      };
    };

    languageHandling = {
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nvf.settings = {
    };
  };
}
