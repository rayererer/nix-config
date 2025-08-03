{pkgs, ...}: {
  home.username = "rayer";
  home.homeDirectory = "/home/rayer";

  nixpkgs.config.allowUnfree = true;

  my = {
    shells = {
      fish.enable = true;
      prompts.starship.enable = true;
    };

    cliPrograms = {
      git = {
        enable = true;
        withGh = true;
        useDefaultCredentials = true;
      };

      zoxide = {
        enable = true;
        replaceCd = true;
      };

      nixFormatter.enable = true;

      neovim = {
        enable = true;
        # makeDefault = true;
        useNvf = true;

        nvf = {
          languageHandling = {
            lsp.enable = true;
          };

          miscPlugins = {
            colorizer.enable = true;
          };
        };
      };

      ripgrep = {
        enable = true;
      };
    };
  };

  home.stateVersion = "24.11"; # Don't change this.
}
