{pkgs, ...}: {
  home = {
    username = "rayer";
    homeDirectory = "/home/rayer";
  };

  my = {
    bundles = {
      bundlePackages.generalDesktop.enable = true;
    };

    desktops.hyprland.monitors = [
      "schoolLaptop"
    ];

    browsers.zen.syncing.profile = "pdd2kkb0.test";

    cliPrograms.neovim.nvf.languageHandling.languages = [
      "rust"
      "ruby"
    ];
  };

  home.stateVersion = "25.05"; # Don't change this.
}
