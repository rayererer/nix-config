{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.cliPrograms.git;
in {
  options.my.cliPrograms = {
    git = {
      enable = lib.mkEnableOption "Enable git module.";
      withGh = lib.mkEnableOption ''
        Also download the GitHub CLI to e.g. verify for
        GitHub easier.
      '';
      useDefaultCredentials = lib.mkEnableOption ''
        Whether to use the default credentials including my GitHub noreply email.
      '';
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        programs = {
          git = {
            enable = true;

            settings = {
              init.defaultBranch = "main";
            };
          };

          gh = lib.mkIf cfg.withGh {
            enable = true;
          };
        };
      }

      (lib.mkIf cfg.useDefaultCredentials {
        programs.git.settings.user = {
          name = "rayererer";
          email = "119081004+rayererer@users.noreply.github.com";
        };
      })
    ]
  );
}
