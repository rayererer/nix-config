{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.cliPrograms.neovim;
in {
  options.my.cliPrograms.neovim = {
    enable = lib.mkEnableOption "Enable Neovim.";
    useNvf = lib.mkEnableOption "Enable configuring with nvf.";
    makeDefault = lib.mkEnableOption "Make Neovim the default editor.";
  };

  config = lib.mkIf cfg.enable {
    programs.neovim.enable = true;

    my.cliPrograms.neovim.moduleCfg = {
      nvf.enable = cfg.useNvf;
      nvimpager.enable = cfg.nvimpager.enable;
    };

    programs.neovim.defaultEditor = cfg.makeDefault;
  };
}
