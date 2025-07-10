{
  pkgs,
  lib,
  config,
  ...
}: let
  bootCfg = config.myOs.bootloaders;
  cfg = bootCfg.grub;
in {
  options.myOs.bootloaders = {
    grub = {
      enable = lib.mkEnableOption "Enable grub as the bootloader.";
    };
  };

  config = lib.mkIf cfg.enable {
    myOs.bootloaders.bootloader = "grub";

    boot.loader.grub = {
      enable = true;
    };

    myOs.bootloaders.grub.moduleCfg = {
      uefiIntegration.enable = bootCfg.firmwareType == "UEFI";
      biosIntegration.enable = bootCfg.firmwareType == "BIOS";
    };
  };
}
