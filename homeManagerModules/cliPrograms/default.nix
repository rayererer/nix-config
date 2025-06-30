{ pkgs, lib, ... }: {

  imports = [
    ./homeManagerCLI.nix
    ./neovim.nix
    ./ripgrep.nix
  ];
}
