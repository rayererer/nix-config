{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.desktops.runners;

  # The strings in this last must match the module names as (e.g.) launch
  # commands get extrapolated from this value.
  availableRunners = ["fuzzel"];
in {
  options.my.desktops.runners = {
    runners = lib.mkOption {
      type = lib.types.listOf (lib.types.enum availableRunners);
      default = [];
      description = ''
        Which runners are installed, each runner module should add itself here.
        Setting a default runner for the desktop should also be handled by
        its respective runners/app launcher module.
      '';
    };
  };

  config =
    lib.mkIf cfg.enable {
    };
}
