{ pkgs, lib, config, ... }:

let
  bootCfg = config.myOs.bootloaders;
  cfg = bootCfg.grub;
in
{

options.myOs.bootloaders.grub = {
  moduleCfg.biosIntegration = {
    enable = lib.mkEnableOption "Enable BIOS Integration module.";
  };
};

config = lib.mkIf cfg.moduleCfg.biosIntegration.enable {
  boot.loader.grub = {
    efiSupport = false;
    device = bootCfg.bios.bootDevice;
  };
};
}
