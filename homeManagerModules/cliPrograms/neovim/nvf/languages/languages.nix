{
  pkgs,
  lib,
  config,
  ...
}: let
  nvfCfg = config.my.cliPrograms.neovim.nvf;
  langHandCfg = nvfCfg.languageHandling;
  langHandModCfg = nvfCfg.moduleCfg.languageHandling;
  cfg = langHandModCfg.languages;
in {
  options.my.cliPrograms.neovim.nvf = {
    moduleCfg.languageHandling = {
      languages = {
        nix = {
          enable = lib.mkEnableOption "Enable the nix module.";
        };

        rust = {
          enable = lib.mkEnableOption "Enable the Rust module.";
        };

        ruby = {
          enable = lib.mkEnableOption "Enable the Ruby module.";
        };

        html = {
          enable = lib.mkEnableOption "Enable the HTML module.";
        };

        css = {
          enable = lib.mkEnableOption "Enable the CSS module.";
        };

        ts = {
          enable = lib.mkEnableOption ''
            Enable the TypeScript/JavaScript module.
          '';
        };

        clang = {
          enable = lib.mkEnableOption ''
            Enable the C/C++ module.
          '';
        };

        markdown = {
          enable = lib.mkEnableOption ''
            Enable the markdown module.
          '';
        };
      };
    };

    languageHandling = {
    };
  };

  config = lib.mkIf (builtins.length langHandCfg.languages > 0) {
    programs.nvf.settings = {
      vim.languages = {
        nix = lib.mkIf cfg.nix.enable {
          enable = true;
          format.type = "alejandra";
        };

        rust = lib.mkIf cfg.rust.enable {
          enable = true;
        };

        ruby = lib.mkIf cfg.ruby.enable {
          enable = true;
        };

        html = lib.mkIf cfg.html.enable {
          enable = true;
        };

        css = lib.mkIf cfg.css.enable {
          enable = true;
        };

        ts = lib.mkIf cfg.ts.enable {
          enable = true;
        };

        clang = lib.mkIf cfg.clang.enable {
          enable = true;
          dap.enable = true;
        };

        markdown = lib.mkIf cfg.markdown.enable {
          enable = true;
          extensions.markview-nvim.enable = true;
        };
      };
    };
  };
}
