{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myOs.services.airplay;
in {
  options.myOs.services = {
    airplay = {
      enable = lib.mkEnableOption "Enable airplay module.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.uxplay
    ];

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };
  };
}
