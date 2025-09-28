{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.browsers.zen;
in {
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  options.my.browsers = {
    zen = {
      enable = lib.mkEnableOption "Enable the Zen Browser module.";

      launchCommand = lib.mkOption {
        type = lib.types.str;
        default = "zen";
        description = ''
          The launch command to use for the zen browser, for use in other modules,
          for example in keybindings.
        '';
      };

      zenPath = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default =
          if !cfg.noProgram
          then "${config.home.homeDirectory}/.zen"
          else null;
        description = ''
          The path to put the zen directory in, will be the standard if nothing
          else is specified, mostly for if on windows but syncing with wsl.
        '';
      };

      noProgram = lib.mkEnableOption ''
        Set this if you don't want zen installed but might want other options
        related to it. Make sure to also set Zen Path if you enable this and
        want syncing.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    my.browsers.browsers = ["zen"];

    programs.zen-browser.enable = !cfg.noProgram;
  };
}
