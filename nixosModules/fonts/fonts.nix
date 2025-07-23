{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myOs.fonts;
in {
  options.myOs.fonts = {
    enableDefaultStack = lib.mkEnableOption ''
      Enable my default font stack. (Also makes changes to stylix.)
    '';
  };

  config = lib.mkIf cfg.enableDefaultStack {
    fonts = {
      enableDefaultPackages = false; # Made redundant by the installed fonts.

      packages = with pkgs; [
        nerd-fonts.caskaydia-mono # Mono font, and nerd font. No ligatures.

        inter # Main text font.

        noto-fonts # For coverage of basically all scripts.

        noto-fonts-cjk-sans # For asian languages.
        noto-fonts-color-emoji # For emojis, good coverage.
      ];

      fontconfig.defaultFonts = {
        sansSerif = ["Inter" "Noto Sans"];
        serif = ["Noto Serif"];
        monospace = ["CaskaydiaMono Nerd Font"];
        emoji = ["Noto Color Emoji"];
      };
    };
    stylix.targets.fontconfig.enable = false;

    stylix.fonts = {
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };

      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };

      monospace = {
        package = pkgs.nerd-fonts.caskaydia-mono;
        name = "CaskaydiaMono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
