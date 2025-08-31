{pkgs, ...}: {
  home = {
    username = "rayer";
    homeDirectory = "/home/rayer";
  };

  nixpkgs.config.allowUnfree = true;

  my = {
    testing.enable = true;

    games.minecraft.enable = true;

    desktops = {
      enable = true;

      cursors.enable = true;

      wallpapers.enable = true;

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

    terminals = {
      ghostty.enable = true;
    };

    shells = {
      fish.enable = true;
      prompts.starship.enable = true;
    };

    browsers = {
      zen = {
        enable = true;
        syncing.profile = "i7eyurii.test";
      };
    };

    threeD = {
      prusaSlicer.enable = true;
      freeCAD.enable = true;
    };

    guiPrograms = {
      obsidian.enable = true;
      vesktop.enable = true;
    };

    cliPrograms = {
      # Bundled now (git)
      #git = {
      #enable = true;
      #withGh = true;
      #useDefaultCredentials = true;
      #};

      # Bundled now (development)
      #direnv.enable = true;

      # Bundled now (miscTools)
      #zoxide= {
      #enable = true;
      #replaceCd = true;
      #};

      # Bundled now (miscTools)
      #fzf.enable = true;

      # Bundled now (miscTools)
      #nixFormatter.enable = true;

      # NOT bundled yet (neovim)
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
            languages = ["nix" "rust"];
          };

          miscPlugins = {
            colorizer.enable = true;
            telescope.enable = true;
            nvimSurround.enable = true;
          };
        };
      };

      # Bundled now (miscTools)
      #ripgrep = {
      #enable = true;
      #};
    };
  };

  home.stateVersion = "25.05"; # Don't change this.
}
