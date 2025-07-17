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
    };
  };

  config = lib.mkIf cfg.enable {
    my.browsers.browsers = ["zen"];

    programs.zen-browser.enable = true;
  };
}
