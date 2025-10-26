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
<<<<<<< Updated upstream
=======

    browsers = {
      zen = {
        enable = true;
        noProgram = true;

        zenPath = "/mnt/c/Users/hello/AppData/Roaming/zen";
        # ++ "${builtins.readFile "${config.home.homeDirectory}/windows_username"}"

        syncing.profile = "5fe684un.test";
      };
    };
>>>>>>> Stashed changes
  };

  home.stateVersion = "24.11"; # Don't change this.
}
