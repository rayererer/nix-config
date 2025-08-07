{
  pkgs,
  lib,
  config,
  ...
}: let
  nvfCfg = config.my.cliPrograms.neovim.nvf;
  cfg = nvfCfg.moduleCfg.templateModuleNameHere;
in {
  options.my.cliPrograms.neovim.nvf = {
    moduleCfg.templateModuleNameHere = {
      enable = lib.mkEnableOption "Enable the templateModuleNameHere module.";
    };

    miscPlugins.templateModuleNameHere = {
      enable = lib.mkEnableOption "";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nvf.settings = {
    };
  };
}
