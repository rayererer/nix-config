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
          mappings = {
          
          };
        };

        languages.enableFormat = true;

        keymaps = [
          {
            key = "<leader>K";
            mode = "n";
            action = "vim.lsp.buf.hover";
            desc = "Show [K]ool information about hovered symbol";
          }

          {
            key = "<leader>gd";
            mode = ["n" "v"];
            action = "vim.lsp.buf.definiton";
            desc = "[G]o to [d]efinition of hovered symbol";
          }

          {
            key = "<leader>ca";
            mode = ["n" "v"];
            action = "vim.lsp.buf.code_action";
            desc = "Perform [c]ode [a]ction";
          }

          {
            key = "<leader>rv";
            mode = ["n" "v"];
            action = "vim.lsp.buf.rename";
            desc = "[R]ename [v]ariable";
          }

          {
            key = "<leader>i";
            mode = ["n" "v"];
            action = "vim.lsp.buf.implementation";
            desc = "Show [i]mplementations";
          }

          {
            key = "<C-c>";
            mode = "i";
            action = "vim.lsp.buf.completion";
            desc = "Perform [c]ompletion";
          }
        ];
      };
    };
  };
}
