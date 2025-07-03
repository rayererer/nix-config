{ pkgs, lib, config, ... }:

let
  bootCfg = config.myOs.bootloaders;
  cfg = bootCfg.systemdBoot;
in
{
options.myOs.bootloaders = {
  systemdBoot = {
    enable = lib.mkEnableOption "Enable systemd-boot as the bootloader.";
  };
};

config = lib.mkIf cfg.enable {
  
  myOs.bootloaders.bootloader = "systemd-boot";

  boot.loader.systemd-boot = {
    enable = true;
  };

  assertions = [
    {
      assertion = bootCfg.isUEFI;
      message = ''
        'config.myOs.bootloaders.systemdBoot.enable' cannot be true 
	without 'config.myOs.bootloaders.isUEFI' also being true
	since systemd-boot only works on UEFI.
      '';
    }
  ];
};

}
