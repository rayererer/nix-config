{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.myOs.services.bluetooth;
in
{
  options.myOs.services = {
    bluetooth = {
      enable = lib.mkEnableOption "Enable the bluetooth service.";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth.enable = true;
  };
}
