
{pkgs, ...}: {
  home = {
    username = "rayer";
    homeDirectory = "/home/rayer";
  };

  my = {

    testing.enable = true;

    bundles = {
      bundlePackages.generalDesktop.enable = true;
    };

    desktops.hyprland.monitors = [
      "schoolHard"
    ];

    cliPrograms.neovim.nvf.languageHandling.languages = [
      "rust"
      "ruby"
      "html"
      "css"
      "ts"
      "clang"
      "markdown"
    ];
  };

  home.stateVersion = "25.11"; # Don't change this.
}
