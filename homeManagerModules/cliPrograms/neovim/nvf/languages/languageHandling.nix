{
  pkgs,
  lib,
  config,
  ...
}: let
  nvfCfg = config.my.cliPrograms.neovim.nvf;
  langHandCfg = nvfCfg.languageHandling;
  cfg = nvfCfg.moduleCfg.languageHandling;

  availableLanguages = ["nix" "rust" "ruby" "html" "css" "ts"]; # ts is also for javascript
in {
  options.my.cliPrograms.neovim.nvf = {
    moduleCfg.languageHandling = {
      enable = lib.mkEnableOption "Enable the languages module.";
    };

    languageHandling = {
      languages = lib.mkOption {
        type = lib.types.listOf (lib.types.enum availableLanguages);
        default = ["nix"];
        description = ''
          A list of which language servers to eanble with NVF, (default is  ["nix"],
          since this is written in nix after all.)
        '';
      };

      lsp = {
        enable = lib.mkEnableOption ''
          Wheter to use to use lsp for configured languages.
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nvf.settings = {
      vim.languages = {
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        # Moved to lsp since it seems just unnecessary to have without being able
        # to actually use the command from the lsp.
        # enableFormat = true;

        # Should probably enable Debuggers in their specific language modules.
        # enableDAP = true;
      };
    };

    my.cliPrograms.neovim.nvf.moduleCfg.languageHandling = {
      languages =
        lib.genAttrs langHandCfg.languages (_name: {enable = true;});

      lsp.enable = langHandCfg.lsp.enable;
    };
  };
}
