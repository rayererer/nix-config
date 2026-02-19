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

  myOs = {
    bundles.bundlePackages.desktop = {
      hostName = "nixschoolhardware";
      isNvidia = true;
    };

    services = {
      dualBoot.enable = true;
      backlightControl.enable = true;

      sound.laptopControls.enable = true;
      bluetooth.enable = true;
    };

  };

  system.stateVersion = "25.11"; # Don't change this.
}
