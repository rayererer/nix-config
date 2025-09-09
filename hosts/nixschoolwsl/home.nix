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

      direnv.enable = true;

      fzf.enable = true;

      zoxide = {
        enable = true;
        replaceCd = true;
      };

      nixFormatter.enable = true;

      neovim = {
        enable = true;
        makeDefault = true;
        useNvf = true;

        nvimpager = {
          enable = true;
          makeDefault = true;
        };

        nvf = {
          languageHandling = {
            lsp.enable = true;
            languages = [
              "nix"
              "rust"
              "ruby"
              "html"
              "css"
              "ts"
            ];
          };

          miscPlugins = {
            colorizer.enable = true;
            telescope.enable = true;
            nvimSurround.enable = true;
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
