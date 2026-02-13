{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myOs.services.dualBoot;
in {
  options.myOs.services = {
    dualBoot = {
      enable = lib.mkEnableOption "Enable settings for dual booting.";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.loader.grub.useOSProber = config.boot.loader.grub.enable;
  };
}
