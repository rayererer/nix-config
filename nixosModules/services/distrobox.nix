{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myOs.services.distrobox;
in {
  options.myOs.services = {
    distrobox = {
      enable = lib.mkEnableOption "Enable the distrobox module.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [pkgs.distrobox];
    virtualisation.podman.enable = true;
    virtualisation.podman.dockerCompat = true;
  };
}
