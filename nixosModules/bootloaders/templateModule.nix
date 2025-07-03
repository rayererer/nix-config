{ pkgs, lib, config, ... }:

let
  cfg = config.myOs.bootloaders;
in
{

options.myOs.bootloaders = {
  moduleCfg.templateModuleNameHere = {
    enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
  };
};

config = lib.mkIf cfg.moduleCfg.templateModuleNameHere.enable {
  
};
}
