{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./homeManagerCLI.nix
    ./git.nix
    ./neovim
    ./ripgrep.nix
    ./nixFormatter.nix
    ./zoxide.nix
    ./direnv.nix
    ./fzf.nix
    ./tldr.nix
    ./zipping.nix
  ];
}
