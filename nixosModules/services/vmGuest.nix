{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myOs.services.vmGuest;
in {
  options.myOs.services = {
    vmGuest = {
      enable = lib.mkEnableOption "Enable the module for if this is a Virtual Machine.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.spice-vdagentd.enable = true;
    services.xserver.videoDrivers = ["virtio"];
  };
}
