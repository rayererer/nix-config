{ pkgs, lib, ... }: {

  imports = [
    ./homeManagerCLI.nix
    ./git.nix
    ./neovim.nix
    ./ripgrep.nix
  ];
}
