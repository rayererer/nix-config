

{ pkgs, ... }: {

  home.username = "rayer"; 
  home.homeDirectory = "/home/rayer";

  my = {
    desktops = {

      enable = true;

      hyprland = { 
        enable = true;
      };
    };

    browsers = {
      zen.enable = true;
    };

    cliPrograms = {

      git = {
        enable = true;
        withGh = true;
      };

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
