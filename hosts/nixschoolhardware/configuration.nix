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

    dualBoot.enable = true;
  };

  system.stateVersion = "25.11"; # Don't change this.
}
