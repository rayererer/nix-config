{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./ly.nix
    ./greetd-tuigreet.nix
    ./ssh.nix
    ./sound.nix
    ./vmGuest.nix
    ./networking.nix
    ./wsl.nix
  ];
}
