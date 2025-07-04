{ pkgs, lib, config, ... }:

let
  cfg = config.myOs.bootloaders;
in
{

options.myOs.bootloaders = {
  moduleCfg.biosIntegration = {
    enable = lib.mkEnableOption "Enable templateModuleNameHere module.";
  };

  bios = {
    bootDevice = lib.mkOption {
      type = lib.nullOr lib.types.str;
      default = null;
      description = "The device to install the bootloader while on BIOS";
    };
  };
};

config = lib.mkIf cfg.moduleCfg.biosIntegration.enable {
  
  assertions = [
    {
      assertion = cfg.bios.bootDevice != null;
      message = ''
        When using BIOS, a boot device path must be set.
      '';
    }
  ];
};
}
