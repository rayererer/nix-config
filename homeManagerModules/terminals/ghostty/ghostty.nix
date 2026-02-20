{
  pkgs,
  lib,
  config,
  ...
}:
let
  termCfg = config.my.terminals;
  cfg = termCfg.ghostty;
in
{
  options.my.terminals.ghostty = {
    enable = lib.mkEnableOption "Enable the ghostty terminal.";
  };

  config = lib.mkIf cfg.enable {
    my.terminals.terminals = [ "ghostty" ];

    # "Naive" fix for being able to use ~ and accents on characters in ghostty.
    # See (https://github.com/ghostty-org/ghostty/discussions/8899)
    # Using fcitx5 might be a "better" solution, but it adds more bloat, and
    # this works.
    home.sessionVariables = {
      GTK_IM_MODULE = "simple";
    };

    programs.ghostty = {
      enable = true;

      # This is redundant with stylix, but keeping it for potential
      # future reference.
      # settings = {
      # font-size = lib.mkIf termCfg.fontSize;

      # # Ghostty doesn't seem to use default by default.
      # font-family = builtins.elemAt osConfig.fonts.fontconfig.defaultFonts.monospace 0;
      # };
    };
  };
}
