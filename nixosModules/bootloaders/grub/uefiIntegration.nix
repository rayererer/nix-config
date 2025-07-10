{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myOs.bootloaders.grub;
in {
  options.myOs.bootloaders.grub = {
    moduleCfg.uefiIntegration = {
      enable = lib.mkEnableOption "Enable UEFI Integration module.";
    };
  };

  config = lib.mkIf cfg.moduleCfg.uefiIntegration.enable {
    boot.loader.grub = {
      efiSupport = true;
      device = "nodev";
    };
  };
}
