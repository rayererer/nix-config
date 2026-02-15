{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.my.widgets.quickshell;
  quickShellDir = ../../../foreign-configs/quickshell;
in
{
  options.my.widgets.quickshell = {
    enable = lib.mkEnableOption "Enable the use of quickshell.";
  };

  config = lib.mkIf cfg.enable {

    programs.quickshell = {
      enable = true;

      # I don't want to build every time and found no cache.
      # package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;

      configs = {
        clock = lib.path.append quickShellDir "clock";
        # default = quickShellDir;
      };

      activeConfig = "clock";

      systemd = {
        enable = true;
        target = "graphical-session.target";
      };
    };

    my.cliPrograms.neovim.nvf.languageHandling.languages = [ "qml" ];
  };
}
