{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myOs.dualBoot;
in {
  options.myOs = {
    dualBoot = {
      enable = lib.mkEnableOption "Enable settings for dual booting.";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.loader.grub.useOSProber = config.boot.loader.grub.enable;
  };
}
