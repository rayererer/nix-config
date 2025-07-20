{
  pkgs,
  lib,
  config,
  ...
}: let
  termCfg = config.my.terminals;
  ghosttyCfg = termCfg.ghostty;
  cfg = ghosttyCfg.themes;
in {
  options.my.terminals.ghostty = {
    themes = {
      theme = lib.mkOption {
        type = lib.types.str;
        default = "alacritty-copy";
        description = ''
          Which font to use, custom fonts are also defined in this module.
        '';
      };
    };
  };

  config = lib.mkIf ghosttyCfg.enable {
    programs.ghostty = {
      settings = {
        theme = cfg.theme;
      };

      themes = {
        alacritty-copy = {
          palette = [
            "0=#181818"
            "1=#ac4242"
            "2=#90a959"
            "3=#f4bf75"
            "4=#6a9fb5"
            "5=#aa759f"
            "6=#75b5aa"
            "7=#d8d8d8"
            "8=#6b6b6b"
            "9=#c55555"
            "10=#aac474"
            "11=#feca88"
            "12=#82b8c8"
            "13=#c28cb8"
            "14=#93d3c3"
            "15=#f8f8f8"
          ];

          background = "181818";
          foreground = "d8d8d8";

          cursor-color = "d8d8d8";
          cursor-text = "181818";

          selection-background = "d8d8d8";
          selection-foreground = "181818";
        };
      };
    };
  };
}
