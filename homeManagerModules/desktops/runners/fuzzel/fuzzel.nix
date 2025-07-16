{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.desktops.runners.fuzzel;
in {
  options.my.desktops.runners = {
    fuzzel = {
      enable = lib.mkEnableOption "Enable the fuzzel config module.";
    };
  };

  config = lib.mkIf cfg.enable {
    my.desktops.runners.runners = ["fuzzel"];

    programs.fuzzel.enable = true;
  };
}
