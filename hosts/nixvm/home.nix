

{ pkgs, ... }: {

  home.username = "rayer"; 
  home.homeDirectory = "/home/rayer";

  home-manager-cli.enable = true;

  neovim = { 
    enable = true;
    makeDefault = true;
  };

  home.stateVersion = "25.05"; # Don't change this.
}
