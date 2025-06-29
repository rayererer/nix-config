

{ pkgs, ... }: {

  home.username = "rayer"; 
  home.homeDirectory = "/home/rayer";

  home-manager-cli.enable = true;

  wayland.windowManager.hyprland = {
    settings = {
     "$mainMod" = "SUPER";

      bind = [
        "$mainMod,RETURN,exec,neofetch"
      ];
    };
  };

  my.desktops.hyprland = { 
    enable = true;
    withUWSM = true;
  };

  neovim = { 
    enable = true;
    makeDefault = true;
  };

  home.stateVersion = "25.05"; # Don't change this.
}
