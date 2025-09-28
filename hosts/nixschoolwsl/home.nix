{pkgs, config, ...}: {
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
