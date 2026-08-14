{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.games.heroic;
in {
  options.my.games = {
    heroic = {
      enable = lib.mkEnableOption "Enable the Heroic Games Launcher.";
    };
  };

  config =
    lib.mkIf cfg.enable {
      home.packages = [
        pkgs.heroic
      ];
    };
}
