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
      isQemuKvm = lib.mkEnableOption ''
        Enable the module for if this is a Virtual Machine that uses
        QEMU/KVM. (Hyper-V doesn't seem to need manual config.)
      '';
    };
  };

  config = lib.mkIf cfg.isQemuKvm {
    services.spice-vdagentd.enable = true;
    services.xserver.videoDrivers = ["virtio"];
  };
}
