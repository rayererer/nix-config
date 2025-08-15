{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.games.minecraft;
in {
  options.my.games = {
    minecraft = {
      enable = lib.mkEnableOption "Enable the minecraft module.";
    };
  };

  config =
    lib.mkIf cfg.enable {
      home.packages = [ pkgs.prismlauncher ];
    };
}
