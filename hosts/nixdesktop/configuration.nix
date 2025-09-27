{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.myOs;
  userName = "rayer";
in {
  imports = [
    ./hardware-configuration.nix
  ];

  fileSystems."/home/${userName}/secondary-drive" = {
    device = "/dev/disk/by-uuid/574f5d42-3179-410c-9b5b-729a35f46c2f";
    fsType = "ext4";
  };

  myOs = {
    bundles.bundlePackages.desktop = {
      hostName = "nixdesktop";
      isNvidia = true;
    };

    gaming = {
      steam.enable = true;
    };
  };

  system.stateVersion = "25.05"; # Don't change this.
}
