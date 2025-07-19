{
  pkgs,
  lib,
  config,
  ...
}: let
  nvfCfg = config.my.cliPrograms.neovim.nvf;
  langHandModCfg = nvfCfg.moduleCfg.languageHandling;
  cfg = langHandModCfg.languages.nix;
in {
  options.my.cliPrograms.neovim.nvf = {
    moduleCfg.languageHandling = {
      languages = {
        nix = {
          enable = lib.mkEnableOption "Enable the nix module.";
        };
      };
    };

    languageHandling = {
      
    };
  };

  config =
    lib.mkIf cfg.enable {
      programs.nvf.settings = {
        vim.languages.nix = {
          enable = true;
          format.type = "alejandra";
        };
      };
    };
}
