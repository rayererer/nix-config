{ pkgs, lib, ... }: {

  imports = [
    ./bootloaders.nix
    ./systemdBoot
  ];
}
