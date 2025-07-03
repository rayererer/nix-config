{ pkgs, lib, config, ... }:

let
  cfg = config.myOs.bootloaders;
  allowedBootLoaders = [ "grub" "systemd-boot" ];
  firmwareTypes = [ "UEFI" "BIOS" ];
in
{
options.myOs = {
  bootloaders = {
    enable = lib.mkEnableOption "Enable bootloader stuff.";
    bootloader = lib.mkOption {
      type = lib.types.nullOr ( lib.types.enum allowedBootLoaders );
      default = null;
      example = "grub";
      description = ''
        Which bootloader to use, bootloader modules MUST add themselves
	to this list.
      '';
    };
    firmwareType = lib.mkOption {
      type = lib.types.enum firmwareTypes;
      example = "UEFI";
      description = "Choose which firmware type the bootloader should use (Probably 'UEFI').";
    };
  };
};

config = lib.mkMerge [

(lib.mkIf (!cfg.enable) {
  assertions = [
    {
      assertion = cfg.bootloader == null;
      message = ''
        A bootloader (${cfg.bootloader}) has been enabled even though the main
        'config.myOs.bootloaders.enable' is false.
      '';
    }
  ];
})

(lib.mkIf cfg.enable {
  assertions = [
    {
      assertion = cfg.bootloader != null;
      message = ''
        If bootloaders is enabled, a bootloader is required to also be set.
      '';
    }
  ];

  # Since only one option is set for global UEFI integration
  # no own module exists.
  boot.loader.efi.canTouchEfiVariables = cfg.firmwareType == "UEFI";
  myOs.bootloaders.moduleCfg = {
    biosIntegration.enable = cfg.firmwareType == "BIOS";
  };
})

];
}
