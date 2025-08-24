{
  pkgs,
  lib,
  config,
  ...
}: let
  nvimCfg = config.my.cliPrograms.neovim;
  pagerCfg = nvimCfg.nvimpager;
  cfg = nvimCfg.moduleCfg.nvimpager;
in {
  options.my.cliPrograms.neovim = {
    moduleCfg.nvimpager = {
      enable = lib.mkEnableOption "Enable nvimpager module.";
    };

    nvimpager = {
      enable = lib.mkEnableOption ''
        Add nvimpager, a pager using neovim.
      '';

      makeDefault = lib.mkEnableOption ''
        Make nvimpager the default pager, using the 'PAGER' environment variable.
      '';

    };
  };

  config =
    lib.mkIf cfg.enable {
      home.packages = [pkgs.nvimpager];

      home.sessionVariables = lib.mkIf pagerCfg.makeDefault {
        PAGER = "nvimpager";
      };
    };
}
