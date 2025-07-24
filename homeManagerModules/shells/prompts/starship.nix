{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}: let
  shellCfg = config.my.shells;
  cfg = shellCfg.prompts.starship;
in {
  options.my.shells.prompts = {
    starship = {
      enable = lib.mkEnableOption "Enable the starship config module.";
    };
  };

  config = lib.mkIf cfg.enable {
    my.shells.prompts.prompts = ["starship"];

    programs = {
      starship = {
        enable = true;

        settings = {
          add_newline = false;
        };
      };

      fish.interactiveShellInit = ''
        # Starship prompt integration
        starship init fish | source
      '';
    };
  };
}
