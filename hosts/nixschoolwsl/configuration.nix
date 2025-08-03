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
  networking.hostName = "nixschoolwsl"; # Define your hostname.

  nixpkgs.hostPlatform = "x86_64-linux";

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

    wsl = {
  enable = true;
  userName = userName;
};

    flakes.enable = true;

    homeManager.enable = true;
    locale.enable = true;

    fonts = {
      enableDefaultStack = true;
    };

    stylix = {
      enable = true;

      colorSchemes = {
        alacrittyCopy.enable = true;
      };
    };

services = {
    networking.enable = true;
};
  };

  system.stateVersion = "24.11"; # Don't change this.
}
