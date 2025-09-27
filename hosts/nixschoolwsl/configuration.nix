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

  #Bundled now (wsl).
  # nixpkgs.hostPlatform = "x86_64-linux";

  nixpkgs.config.allowUnfree = true;

  home-manager = lib.mkIf cfg.homeManager.enable {
    users."${userName}" = import ./home.nix;
  };

  nix.settings.trusted-users = [userName];

  # Enabling the shell manually since I cannot avoid recursion otherwise:
  programs.fish.enable = true;

  myOs = {
    users.defaultUser = userName;

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

      #Bundled now (wsl)
      # wsl = {
      #   enable = true;
      #   inherit userName;
      # };
    };
  };

  system.stateVersion = "24.11"; # Don't change this.
}
