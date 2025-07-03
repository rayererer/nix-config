{ pkgs, lib, config, ... }:

let
  cfg = config.myOs.bootloaders.grub;
in
{

options.myOs.bootloaders.grub = {
  moduleCfg.templateModuleNameHere = {
    enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
  };
};

config = lib.mkIf cfg.moduleCfg.templateModuleNameHere.enable {
  boot.loader.grub = {
    
  };
};
}
