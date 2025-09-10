{
  pkgs,
  lib,
  config,
  helpers,
  ...
}: let
  cfg = config.my.bundles.cliPrograms.neovim;
  mkBundleConfig = helpers.bundles.bundleUtils.mkBundleConfig;
in {
  options.my.bundles.cliPrograms = {
    neovim = {
      enable = lib.mkEnableOption ''
        Enable the neovim bundle. (Currently just one bundle)
      '';
    };
  };

  config = lib.mkIf cfg.enable (mkBundleConfig {
    my = {
      cliPrograms = {
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
      };
    };
  });
}
