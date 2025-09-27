{pkgs, ...}: {
  home = {
    username = "rayer";
    homeDirectory = "/home/rayer";
  };

  nixpkgs.config.allowUnfree = true;

  my = {
    bundles = {
      bundlePackages.generalDesktop.enable = true;
    };

    games.minecraft.enable = true;

    desktops.hyprland = {
      hyprshade = {
        enable = true;

        blueLightFilterTimes = {
          start = "20:00:00";
          end = "07:00:00";
        };
      };

      monitors = [
        "homeSamsung"
        "homeROG"
      ];
    };

    browsers.zen.syncing.profile = "i7eyurii.test";

    cliPrograms.neovim.nvf.languageHandling.languages = [
      "rust"
    ];
  };

  home.stateVersion = "25.05"; # Don't change this.
}
