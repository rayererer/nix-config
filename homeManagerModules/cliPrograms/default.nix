{ pkgs, lib, ... }: {

  imports = [
    ./homeManagerCLI.nix
    ./git.nix
    ./neovim
    ./ripgrep.nix
  ];
}
