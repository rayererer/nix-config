{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.desktops.runners;
  availableRunners = ["fuzzel"];
in {
  options.my.desktops.runners = {
    runners = lib.mkOption {
      type = lib.types.listOf (lib.types.enum availableRunners);
      default = [];
      description = ''
        Which runners are installed, each runner module should add itself here.
        Setting a default runner for the desktop should also be handled by
        its respective runners module.
      '';
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
