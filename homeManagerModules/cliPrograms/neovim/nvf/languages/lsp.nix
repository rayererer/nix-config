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

        withCmpAndSnippets = lib.mkEnableOption ''
          Enable the cmp and snippets module.
        '';
      };
    };

    languageHandling = {
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nvf.settings = {
      vim = lib.mkMerge [
        {
          lsp = {
            enable = true;
          };

          languages.enableFormat = true;
        }
        (lib.mkIf cfg.withCmpAndSnippets {
          autocomplete.blink-cmp.enable = true;

          snippets.luasnip.enable = true;
        })
      ];
    };
  };
}
