{ pkgs, lib, config, ... }:

let
  cfg = config.myOs;
in
{
  imports = [ 
    ./hardware-configuration.nix
  ];

  home-manager = lib.mkIf cfg.home-manager.enable { 
    users.rayer = import ./home.nix;
  };

  myOs = {

    bootloaders = {
      enable = true;
      firmwareType = "UEFI";
      # systemdBoot.enable = true;
      grub.enable = true;
    };

    home-manager.enable = true;
    locale.enable = true;

    services.ly.enable = true;
    desktops.hyprland = { 
      enable = true;
    };
  };

  networking.hostName = "nixvm"; # Define your hostname.
  networking.networkmanager.enable = true;

  console = {
    font = "Lat2-Terminus16";
  };

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rayer = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim
    git
    gh
  ];

  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.stateVersion = "25.05"; # Don't change this.
}

