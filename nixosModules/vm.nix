{ pkgs, lib, config, ... }:

let
  cfg = config.myOs.vm;
in
{

options.myOs = {
  vm = {
    enable = lib.mkEnableOption "Enable the module for if this is a Virtual Machine.";
  };
};

config = lib.mkIf cfg.enable {
  services.spice-vdagentd.enable = true;
  services.xserver.videoDrivers = [ "virtio" ];
};

}
