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

        withDapUI = lib.mkEnableOption ''
          Enable the DAP UI module.
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

            # See (1) below.
            mappings.format = null;
          };

          languages.enableFormat = true;

          # (1) This is a fix so that for example python formatting works,
          # it makes it so that the issue of not finding lsp protocol works
          # by always using conform.
          keymaps = [
            {
              key = "<leader>lf";
              mode = ["n"];
              action = "<cmd>lua require('conform').format({ lsp_format = 'fallback' })<cr>";
              desc = "Format using conform.";
            }
          ];
        }
        (lib.mkIf cfg.withCmpAndSnippets {
          autocomplete.blink-cmp.enable = true;

          snippets.luasnip.enable = true;
        })
        (lib.mkIf cfg.withDapUI {
          debugger.nvim-dap.ui.enable = true;
        })
      ];
    };
  };
}
