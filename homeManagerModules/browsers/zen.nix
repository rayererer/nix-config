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
    };
  };

  config = lib.mkIf cfg.enable {
    programs.zen-browser.enable = true;
  };
}
