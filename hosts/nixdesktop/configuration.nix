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

  # Bundled now (basics)
  # networking.hostName = "nixdesktop"; # Define your hostName.

  #Bundled now (standard).
  # nixpkgs.config.allowUnfree = true;

  # Now changed.
  # home-manager = lib.mkIf cfg.homeManager.enable {
  #   users."${userName}" = import ./home.nix;
  # };

  #Bundled now (standard).
  # nix.settings.trusted-users = [userName];

  # Enabling the shell manually since I cannot avoid recursion otherwise:
  #Bundled now (standard).
  # programs.fish.enable = true;

  myOs = {

    bundles.bundlePackages.desktop = {
      hostName = "nixdesktop";
      isNvidia = true;
    };
    #Bundled now (standard)
    # users.defaultUser = userName;

    # Bundled now (basics)
    # flakes.enable = true;

    # Bundled now (bootloaders)
    # bootloaders = {
    #   enable = true;
    #   firmwareType = "UEFI";
    #   grub.enable = true;
    # };

    #Bundled now (standard)
    # Now changed to include path and username but going to bundle it as well.
    # homeManager.enable = true;
    # locale.enable = true;
    #
    #Bundled now (standard)
    # systemMaintenance.garbageCollection.enable = true;

    #Bundled now (nvidia)
    # graphics = {
    #   nvidia = {
    #     enable = true;
    #     driver = "proprietary";
    #   };
    # };

    #Bundled now (standard)
    # fonts = {
    #   enableDefaultStack = true;
    # };

    gaming = {
      steam.enable = true;
    };

    # Bundled now (standard)
    # stylix = {
    #   enable = true;
    #
    #   colorSchemes = {
    #     alacrittyCopy.enable = true;
    #   };
    # };

    # services = {
      #Bundled now (desktops)
      # ly.enable = true;
      #Bundled now (standard)
      # networking.enable = true;
      #Bundled now (desktops)
      # sound.enable = true;
    # };

    #Bundled now (desktops)
    # desktops.hyprland = {
    #   enable = true;
    #   withFlake = true;
    # };
  };

  system.stateVersion = "25.05"; # Don't change this.
}
