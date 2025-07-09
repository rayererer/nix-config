{ pkgs, lib, ... }: {

  imports = [
    ./flakes.nix
    ./homeManager.nix
    ./locale.nix
    ./bootloaders
    ./networking.nix
    ./services
    ./desktops
    ./vm.nix
  ];
}
