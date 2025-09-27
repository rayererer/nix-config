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
  myOs = {
    bundles.bundlePackages.wsl.hostName = "nixschoolwsl";
  };

  system.stateVersion = "24.11"; # Don't change this.
}
