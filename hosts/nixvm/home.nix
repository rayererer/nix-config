

{ pkgs, ... }: {

  home.username = "rayer"; 
  home.homeDirectory = "/home/rayer";

  home.packages = with pkgs; [
    neofetch
  ];

  neovim = { 
    enable = true;
    makeDefault = true;
  };

  home.stateVersion = "25.05"; # Don't change this.
}
