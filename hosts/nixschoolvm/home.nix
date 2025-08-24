{pkgs, ...}: {
  home.username = "rayer";
  home.homeDirectory = "/home/rayer";

  nixpkgs.config.allowUnfree = true;

  my = {
    desktops = {
      enable = true;

      cursors.enable = true;

      wallpapers.enable = true;

      runners.fuzzel.enable = true;

      hyprland = {
        enable = true;

        appLauncher.default = "fuzzel";

        monitors = [
          "schoolLaptop"
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
        syncing.profile = "pdd2kkb0.test";
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

      nixFormatter.enable = true;

      neovim = {
        enable = true;
        # makeDefault = true;
        useNvf = true;

        nvf = {
          languageHandling = {
            lsp.enable = true;
            languages = ["nix" "rust" "ruby"];
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
