{pkgs, ...}: {
  home = {
    username = "rayer";
    homeDirectory = "/home/rayer";
  };

  nixpkgs.config.allowUnfree = true;

  my = {
    games.minecraft.enable = true;

    desktops = {
      enable = true;

      cursors.enable = true;

      wallpapers.enable = true;

      runners.fuzzel.enable = true;

      hyprland = {
        enable = true;

        hyprshade = {
          enable = true;

          blueLightFilterTimes = {
            start = "20:00:00";
            end = "07:00:00";
          };
        };

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
      git = {
        enable = true;
        withGh = true;
        useDefaultCredentials = true;
      };

      direnv.enable = true;

      zoxide = {
        enable = true;
        replaceCd = true;
      };

      fzf.enable = true;

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
            lsp = {
              enable = true;
              withCmpAndSnippets = true;
            };

            languages = ["nix" "rust"];
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

  home.stateVersion = "25.05"; # Don't change this.
}
