{
  pkgs,
  lib,
  config,
  ...
}: let
  nvfCfg = config.my.cliPrograms.neovim.nvf;
  langHandModCfg = nvfCfg.moduleCfg.languageHandling;
  cfg = langHandModCfg.languages.rust;
in {
  options.my.cliPrograms.neovim.nvf = {
    moduleCfg.languageHandling = {
      languages = {
        rust = {
          enable = lib.mkEnableOption "Enable the Rust module.";
        };
      };
    };

    languageHandling = {
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nvf.settings = {
      vim.languages.rust = {
        enable = true;
      };
    };
  };
}
