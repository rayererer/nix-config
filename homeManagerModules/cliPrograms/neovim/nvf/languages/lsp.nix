{
  pkgs,
  lib,
  config,
  ...
}: let
  nvfCfg = config.my.cliPrograms.neovim.nvf;
  langHandModCfg = nvfCfg.moduleCfg.languageHandling;
  cfg = langHandModCfg.lsp;
in {
  options.my.cliPrograms.neovim.nvf = {
    moduleCfg.languageHandling = {
      lsp = {
        enable = lib.mkEnableOption "Enable the lsp module.";
      };
    };

    languageHandling = {
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nvf.settings = {
      vim = {
        lsp = {
          enable = true;
        };

        languages.enableFormat = true;
      };
    };
  };
}
