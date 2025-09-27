{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.myOs.bundles.bootloaders;
  mkBundleConfig = helpers.bundles.bundleUtils.mkBundleConfig;
in {
  options.myOs.bundles = {
    bootloaders = {
      enable = lib.mkEnableOption ''
        Enables the stuff I want for my bootloader. This assumes UEFI so if that
        is not the case, manually set the firmware type.
      '';
    };
  };

  config = lib.mkIf cfg.enable (mkBundleConfig {
    myOs = {
      bootloaders = {
        enable = true;
        firmwareType = "UEFI";
        grub.enable = true;
      };
    };
  });
}
