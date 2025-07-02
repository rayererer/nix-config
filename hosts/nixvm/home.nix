

{ pkgs, osConfig, ... }: {

  home.username = "rayer"; 
  home.homeDirectory = "/home/rayer";

  my = {
    desktops = {

      enable = true;

      hyprland = { 
        enable = false;
      };
    };

    cliPrograms = {

      homeManagerCLI = {
        # enable = true;
      };

      neovim = { 
        enable = true;
        makeDefault = true;
      };

      ripgrep = {
        enable = true;
      };
    };
  };

  home.stateVersion = "25.05"; # Don't change this.
}
