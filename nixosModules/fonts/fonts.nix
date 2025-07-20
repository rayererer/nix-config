{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.myOs.fonts;
in {
  options.myOs.fonts = {
    enableDefaultStack = lib.mkEnableOption "Enable my default font stack.";
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
        sansSerif = [ "Inter" "Noto Sans" ];
        serif = ["Noto Serif"];
        monospace = ["CaskaydiaCove Nerd Font Mono"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
