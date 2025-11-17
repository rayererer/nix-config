{pkgs, ...}: {
  home = {
    username = "rayer";
    homeDirectory = "/home/rayer";
  };

  nixpkgs.config.allowUnfree = true;

  my = {
    bundles = {
      bundlePackages.wsl.enable = true;
    };

    cliPrograms.neovim.nvf.languageHandling.languages = [
      "rust"
      "ruby"
      "html"
      "css"
      "ts"
      "clang"
      "arduino"
    ];
  };

  home.stateVersion = "24.11"; # Don't change this.
}
