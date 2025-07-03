{ pkgs, lib, config, ... }:

let
  cfg = config.myOs.bootloaders;
  allowedBootLoaders = [ "grub" "systemd-boot" ];
in
{
options.myOs = {
  bootloaders = {
    enable = lib.mkEnableOption "Enable boot loader stuff.";
    bootloader = lib.mkOption {
      type = lib.types.nullOr ( lib.types.enum allowedBootLoaders );
      default = null;
      description = ''
        Which bootloader to use, bootloader modules should add themselves
	to this list.
      '';
    };
    isUEFI = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "If the boot loader is for UEFI (default is true)";
    };
  };
};

config = lib.mkIf cfg.enable {

  assertions = [
    {
      assertion = cfg.bootloader != null;
      message = ''If bootloaders is enabled, a bootloader is required to also be set.'';
    }
  ];

  boot.loader.efi.canTouchEfiVariables = cfg.isUEFI;
};

}
