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

  networking.hostName = "nixdesktop"; # Define your hostname.

  programs.appimage.enable = true;
  nixpkgs.config.allowUnfree = true;

  home-manager = lib.mkIf cfg.homeManager.enable {
    users."${userName}" = import ./home.nix;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${userName}" = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"]; # "wheel" is sudo.
  };

  # Enabling the shell manually since I cannot avoid recursion otherwise:
  programs.fish.enable = true;

  myOs = {
    flakes.enable = true;

    bootloaders = {
      enable = true;
      firmwareType = "UEFI";
      grub.enable = true;
    };

    homeManager.enable = true;
    locale.enable = true;

    graphics = {
      nvidia = {
        enable = true;
        driver = "proprietary";
      };
    };

    fonts = {
      enableDefaultStack = true;
    };

    gaming = {
      steam.enable = true;
    };

    stylix = {
      enable = true;

      colorSchemes = {
        alacrittyCopy.enable = true;
      };
    };

    services = {
      ly.enable = true;
      networking.enable = true;
      sound.enable = true;
    };

    desktops.hyprland = {
      enable = true;
      withFlake = true;
    };
  };

  system.stateVersion = "25.05"; # Don't change this.
}
