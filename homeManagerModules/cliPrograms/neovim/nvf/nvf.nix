{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  nvimCfg = config.my.cliPrograms.neovim;
  nvfCfg = nvimCfg.nvf;
  miscPluginCfg = nvfCfg.miscPlugins;
  cfg = nvimCfg.moduleCfg.nvf;
in {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  options.my.cliPrograms.neovim = {
    moduleCfg.nvf = {
      enable = lib.mkEnableOption "Enable the nvf config module.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nvf = {
      enable = true;
    };

    # Vim options is still just imported.
    my.cliPrograms.neovim.nvf.moduleCfg = {
      languageHandling.enable = true;
      colorizer.enable = miscPluginCfg.colorizer.enable;
    };
  };
}
