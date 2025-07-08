{ pkgs, lib, config, ... }:

let
  cfg = config.myOs.services.ssh;
in
{

options.myOs.services = {
  ssh = {
    enable = lib.mkEnableOption ''
      Enable the SSH module and with it, the OpenSSH daemon.
    '';
  };
};

config = lib.mkIf cfg.enable {
  services.openssh.enable = true;
};

}
