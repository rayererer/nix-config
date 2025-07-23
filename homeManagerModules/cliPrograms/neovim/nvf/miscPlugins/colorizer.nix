{
  pkgs,
  lib,
  config,
  ...
}: let
  nvfCfg = config.my.cliPrograms.neovim.nvf;
  cfg = nvfCfg.moduleCfg.colorizer;
in {
  options.my.cliPrograms.neovim.nvf = {
    moduleCfg.colorizer = {
      enable = lib.mkEnableOption "Enable the colorizer module.";
    };

    miscPlugins.colorizer = {
      enable = lib.mkEnableOption "Enable the colorizer plugin to preview colors.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nvf.settings = {
      vim.ui.colorizer.enable = true;
    };
  };
}
