{
  pkgs,
  lib,
  config,
  ...
}: let
  nvfCfg = config.my.cliPrograms.neovim.nvf;
  cfg = nvfCfg.moduleCfg.nvimSurround;
in {
  options.my.cliPrograms.neovim.nvf = {
    moduleCfg.nvimSurround = {
      enable = lib.mkEnableOption "Enable the nvimSurround module.";
    };

    miscPlugins.nvimSurround = {
      enable = lib.mkEnableOption ''
        Enable the nvim-surround plugin which enables more complex operations
        surrounding text.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nvf.settings = {
      vim.utility.surround = {
        enable = true;
        useVendoredKeybindings = false;
      };
    };
  };
}
