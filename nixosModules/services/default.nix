{ pkgs, lib, ... }: {

  imports = [
    ./ly.nix
    ./greetd-tuigreet.nix
    ./ssh.nix
  ];
}
