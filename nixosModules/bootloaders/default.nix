{ pkgs, lib, ... }: {

  imports = [
    ./bootloaders.nix
    ./biosIntegration.nix
    ./grub
    ./systemdBoot
  ];
}
