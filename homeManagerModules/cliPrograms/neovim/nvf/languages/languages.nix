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
      };
    };
  };
}
