{
  pkgs,
  lib,
  config,
  osConfig,
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
          WARNING, stylix overrides this.
        '';
      };
    };
  };

  config = {
    programs.ghostty = {
      settings = {
        theme = lib.mkIf (!osConfig.myOs.stylix.enable) cfg.theme;
      };

      themes = {
        # Override to actually utilize lighter colors.
        stylix.palette = with config.stylix.base16Scheme; lib.mkForce [
          "0=#${base00}"
          "1=#${base08}"
          "2=#${base0B}"
          "3=#${base0A}"
          "4=#${base0D}"
          "5=#${base0E}"
          "6=#${base0C}"
          "7=#${base05}"
          "8=#${base03}"
          "9=#${base12}" # From here
          "10=#${base14}"
          "11=#${base13}"
          "12=#${base16}"
          "13=#${base17}"
          "14=#${base15}" # To here is the actual override.
          "15=#${base07}"
        ];

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
