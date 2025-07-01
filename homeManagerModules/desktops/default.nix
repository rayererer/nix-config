
{ pkgs, lib, ... }: {

  imports = [
    ./desktops.nix
    ./uwsmEnvVarHandler.nix
    ./hyprland
  ];
}
