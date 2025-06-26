{ pkgs, lib, ... }: {

  imports = [
    ./cliPrograms/neovim.nix
    ./homeManagerCLI.nix
    ./desktops/hyprland.nix
  ];
}
