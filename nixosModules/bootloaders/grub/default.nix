{ pkgs, lib, ... }: {

  imports = [
    ./grub.nix
    ./biosIntegration.nix
    ./uefiIntegration.nix
  ];
}
