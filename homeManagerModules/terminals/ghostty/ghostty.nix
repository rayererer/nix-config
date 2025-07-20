{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}: let
  termCfg = config.my.terminals;
  cfg = termCfg.ghostty;
in {
  options.my.terminals.ghostty = {
    enable = lib.mkEnableOption "Enable the ghostty terminal.";
  };

  config = lib.mkIf cfg.enable {
    my.terminals.terminals = ["ghostty"];

    programs.ghostty = {
      enable = true;

      settings = {
        font-size = termCfg.fontSize;

        # Ghostty doesn't seem to use default by default.
        font-family = builtins.elemAt osConfig.fonts.fontconfig.defaultFonts.monospace 0;
      };
    };
  };
}
