{ pkgs, lib, ... }: {

  imports = [
    ./cliPrograms/neovim.nix
    ./homeManagerCLI.nix
  ];
}
