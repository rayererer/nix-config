{
  pkgs,
  lib,
  config,
  ...
}: let
  nvfCfg = config.my.cliPrograms.neovim.nvf;
  cfg = nvfCfg.moduleCfg.telescope;
in {
  options.my.cliPrograms.neovim.nvf = {
    moduleCfg.telescope = {
      enable = lib.mkEnableOption "Enable the Telescope module.";
    };

    miscPlugins.telescope = {
      enable = lib.mkEnableOption "Enable the Telescope plugin.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nvf.settings = {
      vim = {
        telescope = {
          enable = true;
        };

        keymaps = [
          {
            key = "<leader>fsk";
            mode = "n";
            action = "<cmd>Telescope keymaps<CR>";
            desc = "Show keymaps [Telescope]";
          }
        ];
      };
    };
  };
}
