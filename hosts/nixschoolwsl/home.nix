{pkgs, ...}: {
  home = {
    username = "rayer";
    homeDirectory = "/home/rayer";
  };

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
      "markdown"
    ];

    browsers = {
      zen = {
        enable = true;
        noProgram = true;

        zenPath = "C:\Users\\${builtins.readFile "${config.home.homeDirectory}"}\AppData\Roaming\zen\Profiles\5fe684un.test";
      };
    };
  };

  home.stateVersion = "24.11"; # Don't change this.
}
