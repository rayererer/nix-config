{ pkgs, lib, config, ... }:

let
  nvfCfg = config.my.cliPrograms.neovim.nvf;
  cfg = nvfCfg.moduleCfg.templateModuleNameHere;
in
{

options.my.cliPrograms.neovim.nvf = {
  moduleCfg.templateModuleNameHere = {
    enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
  };
};

config = lib.mkIf cfg.enable {
};
}
