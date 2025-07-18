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

  networking.hostName = "nixvm"; # Define your hostname.

  home-manager = lib.mkIf cfg.homeManager.enable {
    users."${userName}" = import ./home.nix;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${userName}" = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # "wheel" is sudo.
  };

  myOs = {
    flakes.enable = true;

    bootloaders = {
      enable = true;
      firmwareType = "UEFI";
      grub.enable = true;
    };

    homeManager.enable = true;
    locale.enable = true;

    services = {
      ly.enable = true;
      networking.enable = true;
      sound.enable = true;
      vmGuest.enable = true;
    };

    desktops.hyprland = {
      enable = true;
      withFlake = true;
    };
  };

  console = {
    font = "Lat2-Terminus16";
  };

  system.stateVersion = "25.05"; # Don't change this.
}
