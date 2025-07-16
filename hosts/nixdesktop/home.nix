{pkgs, ...}: {
  home.username = "rayer";
  home.homeDirectory = "/home/rayer";

  my = {
    desktops = {
      enable = true;

      runners.fuzzel.enable = true;

      hyprland = {
        enable = true;

        appLauncher.default = "fuzzel";

        monitors = [
          "homeSamsung"
          "homeROG"
        ];
      };
    };

    browsers = {
      zen.enable = true;
    };

    guiPrograms = {
      obsidian.enable = true;
    };

    cliPrograms = {
      git = {
        enable = true;
        withGh = true;
        useDefaultCredentials = true;
      };

      nixFormatter.enable = true;

      neovim = {
        enable = true;
        # makeDefault = true;
        useNvf = true;
      };

      ripgrep = {
        enable = true;
      };
    };
  };

  home.stateVersion = "25.05"; # Don't change this.
}
