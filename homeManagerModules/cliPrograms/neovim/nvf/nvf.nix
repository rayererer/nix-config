{ inputs, pkgs, lib, config, ... }:

let
  nvimCfg = config.my.cliPrograms.neovim;
  cfg = nvimCfg.moduleCfg.nvf;
in
{

imports = [
  inputs.nvf.homeManagerModules.default
];

options.my.cliPrograms.neovim = {
  moduleCfg.nvf = {
    enable = lib.mkEnableOption "Enable the nvf config module.";
  };
};

config = lib.mkIf cfg.enable {
  programs.nvf = {
    enable = true;

    settings = {
      
    };
  };
};
}
