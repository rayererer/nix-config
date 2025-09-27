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
    bundles.bundlePackages.desktop.hostName = "nixschoolvm";
  };

  system.stateVersion = "25.05"; # Don't change this.
}
